package edu.mcw.scge.uploadFiles.storage;

import org.springframework.beans.factory.annotation.Autowired;


import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Service;
import org.springframework.util.FileSystemUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.stream.Stream;

@Service
public class FileSystemStorageService  implements StorageService{
    private final Path rootLocation;

    @Autowired
    public FileSystemStorageService(StorageProperties storageProperties) {

            if (storageProperties.getLocation() != null && storageProperties.getLocation().trim().length() == 0) {
                throw new StorageException("File upload location can not be Empty.");
            }
            String rootLocation=storageProperties.getLocation();
            if(!storageProperties.getApplicationId().isEmpty() && !storageProperties.getSponsorName().isEmpty())
            rootLocation+="/"+storageProperties.getApplicationId()+"_"+storageProperties.getSponsorName();
            if(storageProperties.getModule()>0){
                rootLocation+="/m"+storageProperties.getModule();
            }
            this.rootLocation = Paths.get(rootLocation);

          init(storageProperties.getApplicationId());

    }
    @Override
    public void store(MultipartFile file) {
        try {
            if (file.isEmpty()) {
                throw new StorageException("Failed to store empty file " + file.getOriginalFilename());
            }
            Files.copy(file.getInputStream(), rootLocation.resolve(file.getOriginalFilename()));
        } catch (IOException e) {
            throw new StorageException("Failed to store file " + file.getOriginalFilename(), e);
        }
    }

    @Override
    public Stream<Path> loadAll() {
        try {
            return Files.walk(this.rootLocation, 2)
                    .filter(path -> !path.equals(this.rootLocation))
                    .map(path -> this.rootLocation.relativize(path));
        } catch (IOException e) {
            throw new StorageException("Failed to read stored files", e);
        }

    }

    @Override
    public Path load(String filename) {
        return rootLocation.resolve(filename);
    }

    @Override
    public Resource loadAsResource(String filename) {
        System.out.println("Storage location:" +this.rootLocation +"\nFILE NAME:"+ filename);
        try {
            Path file = load(filename);
            Resource resource = new UrlResource(file.toUri());
            if(resource.exists() || resource.isReadable()) {
                return resource;
            }
            else {
                throw new StorageFileNotFoundException("Could not read file: " + filename);

            }
        } catch (MalformedURLException e) {
            throw new StorageFileNotFoundException("Could not read file: " + filename, e);
        }
    }

    @Override
    public void deleteAll() {
        FileSystemUtils.deleteRecursively(rootLocation.toFile());
    }

    @Override
    public void init(String applicationId) {
        try {
            boolean existsRootLocation=Files.exists(rootLocation);
            if(!existsRootLocation) {
                Files.createDirectory(rootLocation);
                if(applicationId!=null && !applicationId.equals(""))
                for (int module : Arrays.asList(1, 2, 3, 4, 5)) {
                    System.out.println("LOCATION:"+ rootLocation.toString() + "/m" + module);
                    Path modulePath = Paths.get(rootLocation.toString() + "/m" + module);
                    Files.createDirectory(modulePath);
                }
            }


        } catch (IOException e) {
            throw new StorageException("Could not initialize storage", e);
        }
    }

}

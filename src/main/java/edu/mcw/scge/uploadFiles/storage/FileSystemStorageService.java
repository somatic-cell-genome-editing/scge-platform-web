package edu.mcw.scge.uploadFiles.storage;

import org.springframework.beans.factory.annotation.Autowired;


import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Service;
import org.springframework.util.FileSystemUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
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
            if(storageProperties.getApplicationId()>0 && !storageProperties.getSponsorName().isEmpty())
            rootLocation+="/"+storageProperties.getApplicationId()+"_"+storageProperties.getSponsorName();
            this.rootLocation = Paths.get(rootLocation);
            init(storageProperties.getApplicationId());

    }
    @Override
    public void store(MultipartFile file, String rename, int module, String version) {
        try {
            if (file.isEmpty()) {
                throw new StorageException("Failed to store empty file " + file.getOriginalFilename());
            }
            Path modulePath = Paths.get(rootLocation.toString() + "/m" + module);
            boolean exists=Files.exists(modulePath.resolve(rename));

            if(!exists) {
                Files.copy(file.getInputStream(), modulePath.resolve(rename));
            }else{
                Resource resource=loadAsResource(rename, module);
                InputStream stream=resource.getInputStream(); //EXISTING FILE
                InputStream stream1= file.getInputStream(); // NEW UPDATED FILE
                Files.copy(stream, modulePath.resolve("v"+version+"_"+rename));
                stream.close();
                Files.copy(stream1, modulePath.resolve(rename), StandardCopyOption.REPLACE_EXISTING);
                stream1.close();
            }
        } catch (IOException e) {
            throw new StorageException("Failed to store file " + file.getOriginalFilename(), e);
        }
    }

    @Override
    public Stream<Path> loadAll(int module) {
        try {
            Path modulePath = Paths.get(rootLocation.toString() + "/m" + module);
            return Files.walk(modulePath, 2)
                    .filter(path -> !path.equals(modulePath))
                    .map(path -> modulePath.relativize(path));
        } catch (IOException e) {
            throw new StorageException("Failed to read stored files", e);
        }

    }

    @Override
    public Path load(String filename, int module) {
        Path modulePath = Paths.get(rootLocation.toString() + "/m" + module);
        return modulePath.resolve(filename);
    }

    @Override
    public Resource loadAsResource(String filename, int module) {
        try {
            Path file = load(filename, module);
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
    public void init(int applicationId) {
        try {
            boolean existsRootLocation=Files.exists(rootLocation);
            if(!existsRootLocation) {
                Files.createDirectory(rootLocation);
                if(applicationId!=0 )
                for (int module : Arrays.asList(1, 2, 3, 4, 5)) {
                    Path modulePath = Paths.get(rootLocation.toString() + "/m" + module);
                    boolean existsModulePath=Files.exists(modulePath);
                    if(!existsModulePath)
                    Files.createDirectory(modulePath);
                }
            }


        } catch (IOException e) {
            throw new StorageException("Could not initialize storage", e);
        }
    }

}

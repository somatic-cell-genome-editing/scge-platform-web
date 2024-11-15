package edu.mcw.scge.uploadFiles;

import java.io.IOException;
import java.net.FileNameMap;
import java.net.URLConnection;

import java.nio.file.Path;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;


import com.google.gson.Gson;
import edu.mcw.scge.uploadFiles.storage.StorageFileNotFoundException;
import edu.mcw.scge.uploadFiles.storage.StorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.MimeType;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.method.annotation.MvcUriComponentsBuilder;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping(value="/data/store")
public class FileUploadController {

    private final StorageService storageService;

    @Autowired
    public FileUploadController(StorageService storageService) {
        this.storageService = storageService;
    }

    @GetMapping("/")
    public String listUploadedFiles(Model model,  RedirectAttributes redirectAttributes) throws IOException {

        model.addAttribute("files", storageService.loadAll().map(
                        path -> MvcUriComponentsBuilder.fromMethodName(FileUploadController.class,
                                "serveFile", path.getFileName().toString()).build().toUri().toString())
                .collect(Collectors.toList()));
        Map<String, String> fileLocationMap=new HashMap<>();

        for(Path path:(Iterable<Path>)()->storageService.loadAll().iterator()){
            fileLocationMap.put(path.getFileName().toString(), MvcUriComponentsBuilder.fromMethodName(FileUploadController.class,
                    "serveFile", path.getFileName().toString()).build().toUri().toString()) ;
        }
        model.addAttribute("fileLocationMap", fileLocationMap);
        redirectAttributes.addFlashAttribute("fileLocationMap", fileLocationMap);
        redirectAttributes.addFlashAttribute("message", model.getAttribute("message"));
        Gson gson=new Gson();
        System.out.println("FILE LOCATION MAP:"+gson.toJson(fileLocationMap));
        System.out.println("Redirect attributes:"+model.getAttribute("message"));
        return "redirect:/data/ind/ctdRequirements";
      //  return "uploadForm";

    }

    @GetMapping("/files/{filename:.+}")
    @ResponseBody
    public ResponseEntity<Resource> serveFile(@PathVariable(required = true) String filename) {
        System.out.println("FILENAME GET:"+ filename);

        Resource file = storageService.loadAsResource(filename);

        if (file == null)
            return ResponseEntity.notFound().build();
        if(filename.contains(".zip")) {
            return ResponseEntity.ok().header(HttpHeaders.CONTENT_DISPOSITION,
                    "attachment; filename=\"" + file.getFilename() + "\"").body(file);
        }else {
            FileNameMap fileNameMap= URLConnection.getFileNameMap();
            String mimeType=fileNameMap.getContentTypeFor(file.getFilename()); //not working for JSON files
            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION,
                    "inline; filename=\"" + file.getFilename() + "\"")
                    .contentType(MediaType.asMediaType(MimeType.valueOf(mimeType)))
                    .body(file);
        }
    }
    @PostMapping("/")
    public String handleFileUpload(@RequestParam("file") MultipartFile file,
                                   RedirectAttributes redirectAttributes) {
        storageService.store(file);
        redirectAttributes.addFlashAttribute("message",
                "You successfully uploaded " + file.getOriginalFilename() + "!");

        return "redirect:/data/store/";
    }

    @ExceptionHandler(StorageFileNotFoundException.class)
    public ResponseEntity<?> handleStorageFileNotFound(StorageFileNotFoundException exc) {
        return ResponseEntity.notFound().build();
    }

}
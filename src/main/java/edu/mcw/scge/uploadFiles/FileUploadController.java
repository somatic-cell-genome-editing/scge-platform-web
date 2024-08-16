package edu.mcw.scge.uploadFiles;

import java.io.IOException;
import java.net.FileNameMap;
import java.net.URLConnection;

import java.nio.file.Path;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;


import com.google.gson.Gson;
import edu.mcw.scge.configuration.UserService;
import edu.mcw.scge.dao.implementation.ctd.SectionDAO;
import edu.mcw.scge.datamodel.Application;
import edu.mcw.scge.datamodel.Person;
import edu.mcw.scge.datamodel.ctd.Section;
import edu.mcw.scge.uploadFiles.storage.FileSystemStorageService;
import edu.mcw.scge.uploadFiles.storage.StorageFileNotFoundException;
import edu.mcw.scge.uploadFiles.storage.StorageProperties;
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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping(value="/data/store")
public class FileUploadController {

    private  StorageService storageService;
    @Autowired
    private StorageProperties storageProperties;


    @ModelAttribute("storageProperties")
    @Autowired
    public void setStorageProperties(StorageProperties storageProperties) {
        this.storageProperties=storageProperties;
        this.storageService=new FileSystemStorageService(this.storageProperties);
    }
    @Autowired
    public FileUploadController(StorageService storageService) {
        this.storageService=storageService;
    }
    @GetMapping(value="/application")
    public String getNewApplication(HttpServletRequest req, HttpServletResponse res) throws Exception {
        req.setAttribute("storageProperties", storageProperties);
        req.setAttribute("page", "/WEB-INF/jsp/ctd/application");
        req.getRequestDispatcher("/WEB-INF/jsp/base.jsp").forward(req, res);

        return null;
    }
    @GetMapping(value="/application/{applicationId}")
    public String getApplicationById(HttpServletRequest req, HttpServletResponse res) throws Exception {
        req.setAttribute("storageProperties", storageProperties);
        req.setAttribute("page", "/WEB-INF/jsp/ctd/application");
        req.getRequestDispatcher("/WEB-INF/jsp/base.jsp").forward(req, res);

        return null;
    }
    @PostMapping(value="/application")
    public String createApplication(RedirectAttributes redirectAttributes, Model model) throws Exception {
        setStorageProperties((StorageProperties) model.getAttribute("storageProperties"));
      System.out.println("ApplicationId:"+ storageProperties.getApplicationId()+"\tSponsor:"+ storageProperties.getSponsorName());
      Application application=new Application();
        application.setApplicationId(storageProperties.getApplicationId());
        System.out.println("APPLCATION ID:"+ application.getApplicationId());
      redirectAttributes.addFlashAttribute("storageProperties", model.getAttribute("storageProperties"));
        return "redirect:/data/store/ctdRequirements";

    }
    @RequestMapping(value="/ctdRequirements")
    public String getCTDRequirements(HttpServletRequest req, HttpServletResponse res, Model model) throws Exception {

        SectionDAO sectionDAO=new SectionDAO();
        Map<Integer, List<Section>> modules=new HashMap<>();
        for(int module: Arrays.asList(1,2,3,4,5)) {
            List<Section> sections = sectionDAO.getTopLevelSectionsOfModule(module);
            modules.put(module, sections);
        }
        //  model.addAttribute("storageProperties", storageProperties);
        req.setAttribute("model", model);
        req.setAttribute("storageProperties", model.getAttribute("storageProperties"));
        req.setAttribute("modules", modules);
        req.setAttribute("page", "/WEB-INF/jsp/ctd/ctdTable");
        req.getRequestDispatcher("/WEB-INF/jsp/base.jsp").forward(req, res);

        return null;
    }
    @GetMapping("/")
    public String listUploadedFiles(Model model,  RedirectAttributes redirectAttributes) throws IOException {
        setStorageProperties((StorageProperties) model.getAttribute("storageProperties"));
        redirectAttributes.addFlashAttribute("storageProperties", storageProperties);
        model.addAttribute("files", storageService.loadAll().map(
                        path -> MvcUriComponentsBuilder.fromMethodName(FileUploadController.class,
                                "serveFile", storageProperties.getApplicationId(), storageProperties.getSponsorName(),storageProperties.getModule(),path.getFileName().toString()).build().toUri().toString())
                .collect(Collectors.toList()));
        Map<String, String> fileLocationMap=new HashMap<>();

        for(Path path:(Iterable<Path>)()->storageService.loadAll().iterator()){
            fileLocationMap.put(path.getFileName().toString(), MvcUriComponentsBuilder.fromMethodName(FileUploadController.class,
                    "serveFile", storageProperties.getApplicationId(), storageProperties.getSponsorName(), storageProperties.getModule(),path.getFileName().toString()).build().toUri().toString()) ;
        }
        model.addAttribute("fileLocationMap", fileLocationMap);
        redirectAttributes.addFlashAttribute("fileLocationMap", fileLocationMap);
        redirectAttributes.addFlashAttribute("message", model.getAttribute("message"));
        return "redirect:/data/store/ctdRequirements";
      //  return "uploadForm";

    }

    @GetMapping("/files/{applicationId}/{sponsorName}/{module}/{filename:.+}/")
    @ResponseBody
    public ResponseEntity<Resource> serveFile(@PathVariable(required = true) int applicationId, @PathVariable(required = true) String sponsorName,@PathVariable(required = true) int module,@PathVariable(required = true) String filename) {
        System.out.println("FILENAME GET:"+ filename);
        storageProperties.setSponsorName(sponsorName);
        storageProperties.setApplicationId(applicationId);
        storageProperties.setModule(module);
        setStorageProperties(storageProperties);
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
    public String fileUpload(@RequestParam("file") MultipartFile file,
                                   RedirectAttributes redirectAttributes, Model model, @RequestParam("sectionCode") String sectionCode ) {
        model.addAttribute("storageProperties", storageProperties);
        setStorageProperties(storageProperties);
        storageService.store(file, sectionCode);
        redirectAttributes.addFlashAttribute("storageProperties", storageProperties);
        redirectAttributes.addFlashAttribute("message",
                "You successfully uploaded " + file.getOriginalFilename() + "!");

        return "redirect:/data/store/";
    }

    @ExceptionHandler(StorageFileNotFoundException.class)
    public ResponseEntity<?> handleStorageFileNotFound(StorageFileNotFoundException exc) {
        return ResponseEntity.notFound().build();
    }

}
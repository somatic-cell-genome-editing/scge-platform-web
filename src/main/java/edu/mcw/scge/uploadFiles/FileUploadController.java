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


import edu.mcw.scge.dao.implementation.ctd.SectionDAO;
import edu.mcw.scge.datamodel.Application;
import edu.mcw.scge.datamodel.Document;
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

    @Autowired
    private Application application;
    @Autowired
    private DBService dbService;

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

    @RequestMapping(value="/ctdRequirements")
    public String getCTDRequirements(HttpServletRequest req, HttpServletResponse res, Model model) throws Exception {

        this. application= (Application) model.getAttribute("application");
        this.storageProperties.setApplicationId(application.getApplicationId());
        this.storageProperties.setSponsorName(application.getSponsorName());
        SectionDAO sectionDAO=new SectionDAO();
        Map<Integer, List<Section>> modules=new HashMap<>();
        for(int module: Arrays.asList(1,2,3,4,5)) {
            List<Section> sections = sectionDAO.getTopLevelSectionsOfModule(module);
            modules.put(module, sections);
        }
        model.addAttribute("application", application);
        //  model.addAttribute("storageProperties", storageProperties);
        if(model.getAttribute("sectionDocuments")!=null)
        req.setAttribute("sectionDocuments",  model.getAttribute("sectionDocuments"));
        req.setAttribute("readonly", model.getAttribute("readonly"));
        req.setAttribute("model", model);
        req.setAttribute("storageProperties", this.storageProperties);
        req.setAttribute("application", this.application);
        req.setAttribute("modules", modules);
        req.setAttribute("page", "/WEB-INF/jsp/ctd/ctdTable");
        req.getRequestDispatcher("/WEB-INF/jsp/base.jsp").forward(req, res);

        return null;
    }

    @GetMapping("/")
    public String listUploadedFiles(Model model,  RedirectAttributes redirectAttributes) throws Exception {
        setStorageProperties((StorageProperties) model.getAttribute("storageProperties"));
        redirectAttributes.addFlashAttribute("storageProperties", storageProperties);
        this.application= (Application) model.getAttribute("application");
        redirectAttributes.addFlashAttribute("application", application);
        model.addAttribute("files", storageService.loadAll(storageProperties.getModule()).map(
                        path -> MvcUriComponentsBuilder.fromMethodName(FileUploadController.class,
                                "serveFile", storageProperties.getApplicationId(), storageProperties.getSponsorName(),storageProperties.getModule(),path.getFileName().toString()).build().toUri().toString())
                .collect(Collectors.toList()));
        Map<String, String> fileLocationMap=new HashMap<>();

        for(Path path:(Iterable<Path>)()->storageService.loadAll(storageProperties.getModule()).iterator()){
            fileLocationMap.put(path.getFileName().toString(), MvcUriComponentsBuilder.fromMethodName(FileUploadController.class,
                    "serveFile", storageProperties.getApplicationId(), storageProperties.getSponsorName(), storageProperties.getModule(),path.getFileName().toString()).build().toUri().toString()) ;
        }
        model.addAttribute("fileLocationMap", fileLocationMap);
        model.addAttribute("application", application);
        Map<String, List<Document>> sectionDocuments=dbService.getApplicationDocuments(application.getApplicationId());
        model.addAttribute("sectionDocuments", sectionDocuments);
        redirectAttributes.addFlashAttribute("readonly", true);
        redirectAttributes.addFlashAttribute("sectionDocuments", sectionDocuments);

        redirectAttributes.addFlashAttribute("fileLocationMap", fileLocationMap);
        redirectAttributes.addFlashAttribute("message", model.getAttribute("message"));
    //    return "redirect:/data/store/ctdRequirements";
      //  return "uploadForm";
       return  "redirect:/ind/application/"+application.getApplicationId();
    }

    @GetMapping("/files/{applicationId}/{sponsorName}/{module}/{filename:.+}/")
    @ResponseBody
    public ResponseEntity<Resource> serveFile(@PathVariable(required = true) int applicationId, @PathVariable(required = true) String sponsorName,@PathVariable(required = true) int module,@PathVariable(required = true) String filename) {
        storageProperties.setSponsorName(sponsorName);
        storageProperties.setApplicationId(applicationId);
        storageProperties.setModule(module);
        setStorageProperties(storageProperties);
        Resource file = storageService.loadAsResource(filename, module);

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
                                   RedirectAttributes redirectAttributes, Model model, @RequestParam("sectionCode") String sectionCode ) throws Exception {
        storageProperties.setSection(sectionCode);
        model.addAttribute("storageProperties", storageProperties);
        application=dbService.getApplicationById(storageProperties.getApplicationId());
        model.addAttribute("application", application);
        setStorageProperties(storageProperties);
        String rename=sectionCode.replaceAll("\\.", "_")+"_"+file.getOriginalFilename();
        String version=dbService.saveDocument(rename, storageProperties, storageProperties.getTier());
        storageService.store(file, rename, storageProperties.getModule(), version);
        redirectAttributes.addFlashAttribute("application", application);
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
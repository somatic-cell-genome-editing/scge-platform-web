package edu.mcw.scge.controller;

import edu.mcw.scge.dao.implementation.ctd.SectionDAO;
import edu.mcw.scge.datamodel.Application;
import edu.mcw.scge.datamodel.Document;
import edu.mcw.scge.datamodel.ctd.Section;
import edu.mcw.scge.uploadFiles.DBService;
import edu.mcw.scge.uploadFiles.storage.StorageProperties;
import org.eclipse.tags.shaded.org.apache.xpath.operations.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value="/ind/application")
public class ApplicationController extends ModulesController {
    @Autowired
    private DBService dbService;
    @GetMapping(value="/new")
    public String getNewApplication(HttpServletRequest req, HttpServletResponse res) throws Exception {
        req.setAttribute("readonly", false);
        req.setAttribute("application", new Application());
        req.setAttribute("page", "/WEB-INF/jsp/ind_application/application");
        req.getRequestDispatcher("/WEB-INF/jsp/base.jsp").forward(req, res);

        return null;
    }

    @PostMapping(value="/create")
    public String createApplication(@ModelAttribute Application application, BindingResult bindingResult, RedirectAttributes redirectAttributes) throws Exception {
        int applicationId=dbService.insertApplication(application);
        redirectAttributes.addFlashAttribute("message", "Successfully created application. Please upload the required documents below");
        return "redirect:/ind/application/"+applicationId;

    }
    @RequestMapping(value="/{applicationId}")
    public String getApplicationById(HttpServletRequest req, HttpServletResponse res,Model model, @PathVariable(required = true) int applicationId, @ModelAttribute StorageProperties storageProperties) throws Exception {
        Application application=dbService.getApplicationById(applicationId);
        Map<String, List<Document>> sectionDocuments=dbService.getApplicationDocuments(applicationId);
        storageProperties.setApplicationId(applicationId);
        storageProperties.setSponsorName(application.getSponsorName());
        req.setAttribute("message", model.getAttribute("message"));
        req.setAttribute("storageProperties", storageProperties);
        req.setAttribute("readonly", true);
        req.setAttribute("sectionDocuments", sectionDocuments);
        req.setAttribute("modules", getCTDModules());
        req.setAttribute( "application", application);
        req.setAttribute("model", model);
        req.setAttribute("page", "/WEB-INF/jsp/ctd/application");
        req.getRequestDispatcher("/WEB-INF/jsp/base.jsp").forward(req, res);
        return null;
    }
//    public  Map<Integer, List<Section>> getCTDModules() throws Exception {
//        SectionDAO sectionDAO=new SectionDAO();
//        Map<Integer, List<Section>> modules=new HashMap<>();
//        for(int module: Arrays.asList(1,2,3,4,5)) {
//            List<Section> sections = sectionDAO.getTopLevelSectionsOfModule(module);
//            modules.put(module, sections);
//        }
//        return modules;
//    }
}

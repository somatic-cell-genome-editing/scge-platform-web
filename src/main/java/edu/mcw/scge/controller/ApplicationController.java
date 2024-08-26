package edu.mcw.scge.controller;

import com.google.gson.Gson;
import edu.mcw.scge.datamodel.Application;
import edu.mcw.scge.uploadFiles.DBService;
import edu.mcw.scge.uploadFiles.storage.StorageProperties;
import org.checkerframework.checker.units.qual.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping(value="/ind/application")
public class ApplicationController {

    @Autowired
    private DBService dbService;
    @GetMapping(value="/new")
    public String getNewApplication(HttpServletRequest req, HttpServletResponse res) throws Exception {
        req.setAttribute("application", new Application());
        req.setAttribute("page", "/WEB-INF/jsp/ctd/application");
        req.getRequestDispatcher("/WEB-INF/jsp/base.jsp").forward(req, res);

        return null;
    }

    @PostMapping(value="/create")
    public String createApplication(RedirectAttributes redirectAttributes, Model model, @ModelAttribute Application application, BindingResult bindingResult) throws Exception {
        model.addAttribute("application", application);
        dbService.insertApplication(application);
        redirectAttributes.addFlashAttribute("application", application);
        return "redirect:/data/store/ctdRequirements";

    }
    @RequestMapping(value="/{applicationId}")
    public String getApplicationById(RedirectAttributes redirectAttributes, Model model, @PathVariable(required = true) int applicationId) throws Exception {
        Application application=dbService.getApplicationById(applicationId);
        model.addAttribute("application", application);
        redirectAttributes.addFlashAttribute("application", application);
        return "redirect:/data/store/ctdRequirements";

    }
}

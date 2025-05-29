package edu.mcw.scge.controller;


import edu.mcw.scge.dao.implementation.ctd.SectionDAO;
import edu.mcw.scge.datamodel.ctd.Section;
import edu.mcw.scge.uploadFiles.storage.FileSystemStorageService;
import edu.mcw.scge.uploadFiles.storage.StorageProperties;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value="/data/ind")
public class GuidanceController {
    @RequestMapping(value="/forms")
    public String getINDForms(HttpServletRequest req, HttpServletResponse res) throws Exception {

        req.setAttribute("page", "/WEB-INF/jsp/forms/forms");
        req.getRequestDispatcher("/WEB-INF/jsp/base.jsp").forward(req, res);

        return null;
    }
    @RequestMapping(value="/templates")
    public String getINDTemplates(HttpServletRequest req, HttpServletResponse res) throws Exception {

        req.setAttribute("page", "/WEB-INF/jsp/templates/templates");
        req.getRequestDispatcher("/WEB-INF/jsp/base.jsp").forward(req, res);

        return null;
    }

}

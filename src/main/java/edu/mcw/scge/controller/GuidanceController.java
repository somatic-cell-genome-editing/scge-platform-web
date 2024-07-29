package edu.mcw.scge.controller;


import edu.mcw.scge.dao.implementation.ctd.SectionDAO;
import edu.mcw.scge.datamodel.ctd.Section;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value="/data/ind")
public class GuidanceController {
    @RequestMapping(value="/forms")
    public String getINDForms(HttpServletRequest req, HttpServletResponse res, Model model,
                                              @PathVariable(required = false) String category, @RequestParam(required = false) String searchTerm) throws Exception {

        req.setAttribute("page", "/WEB-INF/jsp/forms/forms");
        req.getRequestDispatcher("/WEB-INF/jsp/base.jsp").forward(req, res);

        return null;
    }
    @RequestMapping(value="/templates")
    public String getINDTemplates(HttpServletRequest req, HttpServletResponse res, Model model,
                              @PathVariable(required = false) String category, @RequestParam(required = false) String searchTerm) throws Exception {

        req.setAttribute("page", "/WEB-INF/jsp/templates/templates");
        req.getRequestDispatcher("/WEB-INF/jsp/base.jsp").forward(req, res);

        return null;
    }
    @RequestMapping(value="/ctdRequirements")
    public String getCTDRequirements(HttpServletRequest req, HttpServletResponse res, Model model,
                                  @PathVariable(required = false) String category, @RequestParam(required = false) String searchTerm) throws Exception {
        SectionDAO sectionDAO=new SectionDAO();
        Map<Integer, List<Section>> modules=new HashMap<>();
        for(int module: Arrays.asList(1,2,3,4,5)) {
            List<Section> sections = sectionDAO.getTopLevelSectionsOfModule(module);
            modules.put(module, sections);
        }
        req.setAttribute("modules", modules);
        req.setAttribute("page", "/WEB-INF/jsp/ctd/ctdTable");
        req.getRequestDispatcher("/WEB-INF/jsp/base.jsp").forward(req, res);

        return null;
    }
}

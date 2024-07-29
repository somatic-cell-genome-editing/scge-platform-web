package edu.mcw.scge.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping(value="/data/ind")
public class DocumentController {
    @RequestMapping(value="/upload")
    public String getUploadForm(HttpServletRequest req, HttpServletResponse res, Model model,
                                  @PathVariable(required = false) String category, @RequestParam(required = false) String searchTerm) throws Exception {

        req.setAttribute("page", "/WEB-INF/jsp/ctd/upload");
        req.getRequestDispatcher("/WEB-INF/jsp/base.jsp").forward(req, res);

        return null;
    }
}

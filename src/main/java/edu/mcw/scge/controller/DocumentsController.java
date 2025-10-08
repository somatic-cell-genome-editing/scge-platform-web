package edu.mcw.scge.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
@RequestMapping(value="/data/documents")
public class DocumentsController {
    @RequestMapping(value="/regulatoryDocuments")
    public String getRegulatoryDocuments(HttpServletRequest req, HttpServletResponse res) throws Exception {
        req.setAttribute("page", "/WEB-INF/jsp/regulatoryDocuments/regulatoryDocuments");
        req.setAttribute("title", "Regulatory Documents, Investigational New Drug (IND)");
        req.getRequestDispatcher("/WEB-INF/jsp/base.jsp").forward(req, res);

        return null;
    }
}

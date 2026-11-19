package edu.mcw.scge.controller;

import edu.mcw.scge.service.regulatory.RegulatoryDocumentsService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/public/documents")
public class DocumentsController {

    private final RegulatoryDocumentsService regulatoryDocumentsService = new RegulatoryDocumentsService();

    @RequestMapping(value="/regulatory")
    public String getRegulatoryDocuments(HttpServletRequest req, HttpServletResponse res) throws Exception {
        // Disease areas -> programs -> documents + publications. The page is
        // rendered entirely from this; nothing on it is hard-coded any more.
        req.setAttribute("diseaseAreas", regulatoryDocumentsService.getPageContent());
        req.setAttribute("page", "/WEB-INF/jsp/regulatoryDocuments/regulatoryDocuments");
        req.setAttribute("title", "Regulatory Documents, Investigational New Drug (IND)");
        req.getRequestDispatcher("/WEB-INF/jsp/base.jsp").forward(req, res);

        return null;
    }
}

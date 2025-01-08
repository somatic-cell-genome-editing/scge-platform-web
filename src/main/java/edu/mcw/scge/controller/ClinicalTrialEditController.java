package edu.mcw.scge.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/clinicalTrialEdit")
public class ClinicalTrialEditController {

    @RequestMapping("/home")
    public String home(HttpServletRequest req,HttpServletResponse res) throws Exception{
        req.setAttribute("page", "/WEB-INF/jsp/edit/ctEditHome");
        req.getRequestDispatcher("/WEB-INF/jsp/base.jsp").forward(req, res);
        return null;
    }

}

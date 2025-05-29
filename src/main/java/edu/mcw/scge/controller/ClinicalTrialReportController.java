package edu.mcw.scge.controller;
import edu.mcw.scge.dao.implementation.ClinicalTrailDAO;
import edu.mcw.scge.datamodel.Alias;
import edu.mcw.scge.datamodel.ClinicalTrialAdditionalInfo;
import edu.mcw.scge.datamodel.ClinicalTrialExternalLink;
import edu.mcw.scge.datamodel.ClinicalTrialRecord;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/data/clinicalTrials/report")
public class ClinicalTrialReportController {

    ClinicalTrailDAO ctDAO = new ClinicalTrailDAO();

    @RequestMapping("/{nctId}")
    public String getClinicalReport(HttpServletRequest req, HttpServletResponse res, @PathVariable(required = true)String nctId) throws Exception{

        try{
            System.out.println("NCTID:"+ nctId);
            ClinicalTrialRecord clinicalTrialData = ctDAO.getSingleClinicalTrailRecordByNctId(nctId);
            List<Alias> aliasData = ctDAO.getAliases(nctId,"compound");
            List<ClinicalTrialAdditionalInfo>fdaInfo = ctDAO.getAdditionalInfo(nctId,"fda_designation");
            List<String>propertyValues = ctDAO.getDistinctPropertyValues("fda_designation");
            if(clinicalTrialData==null){
                req.setAttribute("errorMessage","Clinical Trial Data not found for NCT ID: "+nctId);
                req.setAttribute("page","/WEB-INF/jsp/report/clinicalTrial/error");
                req.getRequestDispatcher("/WEB-INF/jsp/base.jsp").forward(req, res);
                return null;
            }
            List<ClinicalTrialExternalLink> clinicalExtLinkData = ctDAO.getExtLinksByNctIdSorted(nctId);
            req.setAttribute("clinicalTrialData",clinicalTrialData);
            req.setAttribute("clinicalExtLinkData",clinicalExtLinkData);
            req.setAttribute("aliasData",aliasData);
            req.setAttribute("fdaInfo",fdaInfo);
            req.setAttribute("propertyValues",propertyValues);
            req.setAttribute("page","/WEB-INF/jsp/report/clinicalTrial/main");
            req.getRequestDispatcher("/WEB-INF/jsp/base.jsp").forward(req, res);
            return null;
        }
        catch (Exception e){
            e.printStackTrace();
            req.setAttribute("error message","Error fetching clinical trial data: "+e.getMessage());
            req.setAttribute("page","/WEB-INF/jsp/report/clinicalTrial/error");
            req.getRequestDispatcher("/WEB-INF/jsp/base.jsp").forward(req, res);
            return null;
        }
    }


}

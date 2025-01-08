package edu.mcw.scge.controller;

import edu.mcw.scge.dao.implementation.ClinicalTrailDAO;
import edu.mcw.scge.datamodel.ClinicalTrialExternalLink;
import edu.mcw.scge.datamodel.ClinicalTrialRecord;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;

@Controller
@RequestMapping("/clinicalTrialEdit")
public class ClinicalTrialEditController {
    ClinicalTrailDAO ctDAO = new ClinicalTrailDAO();

    @RequestMapping("/home")
    public String home(HttpServletRequest req,HttpServletResponse res) throws Exception{
        req.setAttribute("page", "/WEB-INF/jsp/edit/ctEditHome");
        req.getRequestDispatcher("/WEB-INF/jsp/base.jsp").forward(req, res);
        return null;
    }
    @PostMapping("/report/{nctId}/edit")
    public String editClinicalTrialReport(
            HttpServletRequest req,
            HttpServletResponse res,
            @PathVariable("nctId") String nctId
    ) throws Exception {

        try {
            ClinicalTrialRecord ctRecord = new ClinicalTrialRecord();

            ctRecord.setnCTNumber(nctId);
            ctRecord.setTargetGeneOrVariant(req.getParameter("targetGeneOrVariant"));
            ctRecord.setTherapyType(req.getParameter("therapyType"));
            ctRecord.setTherapyRoute(req.getParameter("therapyRoute"));
            ctRecord.setMechanismOfAction(req.getParameter("mechanismOfAction"));
            ctRecord.setRouteOfAdministration(req.getParameter("routeOfAdministration"));
            ctRecord.setDrugProductType(req.getParameter("drugProductType"));
            ctRecord.setTargetTissueOrCell(req.getParameter("targetTissueOrCell"));
            ctRecord.setDeliverySystem(req.getParameter("deliverySystem"));
            ctRecord.setVectorType(req.getParameter("vectorType"));
            ctRecord.setEditorType(req.getParameter("editorType"));
            ctRecord.setDose1(req.getParameter("dose1"));
            ctRecord.setDose2(req.getParameter("dose2"));
            ctRecord.setDose3(req.getParameter("dose3"));
            ctRecord.setDose4(req.getParameter("dose4"));
            ctRecord.setDose5(req.getParameter("dose5"));
            ctRecord.setRecentUpdates(req.getParameter("recentUpdates"));
            ctRecord.setPatents(req.getParameter("patents"));
            ctRecord.setCompoundName(req.getParameter("compoundName"));
            ctRecord.setIndication(req.getParameter("indication"));

            // Handle external links updates
            String[] linkIds = req.getParameterValues("linkId");
            String[] extLinkTypes = req.getParameterValues("extLink");
            String[] linkNames = req.getParameterValues("linkName");
            String[] links = req.getParameterValues("link");
            String[] deleteFlags = req.getParameterValues("deleteLink");
            if(linkIds!=null&&linkIds.length>0) {
                for (int i = 0; i < linkIds.length; i++) {

                    //delete the links
                    if (deleteFlags != null && Arrays.asList(deleteFlags).contains(linkIds[i])) {
                        ctDAO.deleteExternalLink(Integer.parseInt(linkIds[i]));
                        continue;
                    }
                    //Update the links table
                    ClinicalTrialExternalLink extLink = new ClinicalTrialExternalLink();
                    extLink.setName(linkNames[i]);
                    extLink.setType(extLinkTypes[i]);
                    extLink.setLink(links[i]);
                    extLink.setNctId(nctId);
                    extLink.setId(Integer.parseInt(linkIds[i]));
                    ctDAO.updateExternalLink(extLink);
                }
            }
            //insert new external link
            String[] newLinkIds = req.getParameterValues("newLinkId");
            if (newLinkIds != null) {
                for(String tempId:newLinkIds){
                    ClinicalTrialExternalLink extLink = new ClinicalTrialExternalLink();
                    extLink.setName(req.getParameter("newLinkName_" + tempId));
                    extLink.setType(req.getParameter("newExtLink_" + tempId));
                    extLink.setLink(req.getParameter("newLink_" + tempId));
                    extLink.setNctId(nctId);
                    extLink.setId(ctDAO.getNextKey("clinical_trial_ext_links_seq"));
                    ctDAO.insertExternalLink(extLink);
                }
            }

            //update the clinical_trial_record table
            ctDAO.updateCuratedDataFields(ctRecord);
            req.getSession().setAttribute("showAlert", "true");
            res.sendRedirect("/platform/data/clinicalTrials/report/" + nctId);
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "Error updating clinical trial data: " + e.getMessage());
            req.setAttribute("page","/WEB-INF/jsp/report/clinicalTrial/error");
            req.getRequestDispatcher("/WEB-INF/jsp/base.jsp").forward(req, res);
            return null;
        }
    }
}

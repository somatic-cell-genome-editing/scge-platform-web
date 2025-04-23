package edu.mcw.scge.controller;

import edu.mcw.scge.dao.implementation.ClinicalTrailDAO;
import edu.mcw.scge.datamodel.Alias;
import edu.mcw.scge.datamodel.ClinicalTrialAdditionalInfo;
import edu.mcw.scge.datamodel.ClinicalTrialExternalLink;
import edu.mcw.scge.datamodel.ClinicalTrialRecord;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.List;

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
            ctRecord.setDevelopmentStatus(req.getParameter("developmentStatus"));
            ctRecord.setIndicationDOID(req.getParameter("indicationDOID"));
            ctRecord.setCompoundDescription(req.getParameter("compoundDescription"));
            ctRecord.setRecordStatus(req.getParameter("recordStatus"));
            ctRecord.setNctId(nctId);

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

            //Handle FDA designations
            List<ClinicalTrialAdditionalInfo> existingFdaDesignations = ctDAO.getAdditionalInfo(nctId,"fda_designation");
            List<String>allFdaDesignations = ctDAO.getDistinctPropertyValues("fda_designation");
            String[] selectedFdaDesignations = req.getParameterValues("fdaDesignation");

            for(String designationValue:allFdaDesignations){
                boolean isSelected = false;

                if (selectedFdaDesignations != null) {
                    for (String selected : selectedFdaDesignations) {
                        if (selected.equals(designationValue)) {
                            isSelected = true;
                            break;
                        }
                    }
                }
                ClinicalTrialAdditionalInfo info = new ClinicalTrialAdditionalInfo();
                info.setNctId(nctId);
                info.setPropertyName("fda_designation");
                info.setPropertyValue(designationValue);

                boolean exists = false;
                for (ClinicalTrialAdditionalInfo existing : existingFdaDesignations) {
                    if (existing.getPropertyValue().equals(designationValue)) {
                        exists = true;
                        break;
                    }
                }
                // Insert or delete based on selection status and existence
                if (isSelected && !exists) {
                    // Selected but doesn't exist - insert it
                    ctDAO.insertAdditionalInfo(info);
                } else if (!isSelected && exists) {
                    // Not selected but exists - delete it
                    for (ClinicalTrialAdditionalInfo existing : existingFdaDesignations) {
                        if (existing.getPropertyValue().equals(designationValue)) {
                            ctDAO.deleteAdditionalInfo(existing.getNctId(),existing.getPropertyName(),existing.getPropertyValue());
                            break;
                        }
                    }
                }
            }

            //Handle Alias fields
            String aliasValue = req.getParameter("aliasValue");
            String aliasKeyStr = req.getParameter("aliasKey");

            List<Alias> existingAliases = ctDAO.getAliases(nctId, "compound");
            boolean hasExistingAlias = (existingAliases != null && !existingAliases.isEmpty());

            if (aliasValue == null || aliasValue.trim().isEmpty()) {
                // If alias value is empty and there's an existing record, delete it
                if (hasExistingAlias) {
                    int aliasKey = 0;
                    if (aliasKeyStr != null && !aliasKeyStr.trim().isEmpty()) {
                        aliasKey = Integer.parseInt(aliasKeyStr);
                    } else {
                        aliasKey = existingAliases.get(0).getKey();
                    }
                    ctDAO.deleteAlias(aliasKey);
                }
            } else {
                String aliasType = req.getParameter("aliasType");
                String aliasNotes = req.getParameter("aliasNotes");
                String aliasFieldName = req.getParameter("aliasFieldName");

                if (aliasFieldName == null || aliasFieldName.isEmpty()) {
                    aliasFieldName = "compound";
                }

                Alias alias = new Alias();
                alias.setAlias(aliasValue);
                alias.setAliasTypeLC(aliasType);
                alias.setNotes(aliasNotes);
                alias.setIdentifier(nctId);
                alias.setFieldName(aliasFieldName);

                if (hasExistingAlias) {
                    if (aliasKeyStr != null && !aliasKeyStr.trim().isEmpty()) {
                        alias.setKey(Integer.parseInt(aliasKeyStr));
                    } else {
                        alias.setKey(existingAliases.get(0).getKey());
                    }
                    ctDAO.updateAlias(alias);
                } else {
                    ctDAO.insertAlias(alias);
                }
            }
            //update the clinical_trial_record table
            ctDAO.updateCuratedDataFields(ctRecord);
            ctDAO.updateSomeNewFieldsDataFields(ctRecord);
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
    @GetMapping("/add")
    public String addClinicalTrialReport(@RequestParam(name="nctId",required = true)String nctId,
                                         HttpServletRequest req,
                                         HttpServletResponse res) throws Exception{
        if(nctId!=null&&!nctId.trim().isEmpty()){
            String result = ctDAO.downloadClinicalTrailByNctId(nctId);
            switch(result){
                case "inserted":
                case "updated":
                    req.getSession().setAttribute("result",result.equals("inserted")?"Clinical trial data successfully inserted":
                            "Clinical trial data already exists, and got successfully updated");
                    res.sendRedirect("/platform/data/clinicalTrials/report/"+nctId+"?edit=true");
                    return null;
                default:
                    req.getSession().setAttribute("result","Error processing clinical trial data: " + result);
                    res.sendRedirect("/platform/clinicalTrialEdit/home/");
            }
        }
        return null;
    }
}

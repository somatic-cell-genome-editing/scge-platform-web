package edu.mcw.scge.controller;



import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import edu.mcw.scge.service.es.clinicalTrials.ClinicalTrialsService;
import edu.mcw.scge.service.es.clinicalTrials.ClinicalTrialApiIndexServices;

import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.search.aggregations.bucket.terms.Terms;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

@Controller
@RequestMapping(value="/data/search")
public class SearchController{

    @RequestMapping(value="/clinicalTrialsapi")
    public String getClinicalTrialsAPIResults(HttpServletRequest req, HttpServletResponse res, Model model,
                                       @PathVariable(required = false) String category, @RequestParam(required = false) String searchTerm) throws Exception {
        ClinicalTrialApiIndexServices services = new ClinicalTrialApiIndexServices();
        Map<String, List<String>> filterMap=getFiltersMap(req);
        SearchResponse sr=services.getSearchResults(searchTerm ,getFiltersMap(req));
        req.setAttribute("searchTerm", searchTerm);
        req.setAttribute("sr", sr);
        req.setAttribute("filterMap", filterMap);
        Terms terms=sr.getAggregations().get("organization");
        req.setAttribute("page", "/WEB-INF/jsp/search/clinicalTrials/resultsview");
        req.getRequestDispatcher("/WEB-INF/jsp/base.jsp").forward(req, res);

        return null;
    }


    @RequestMapping(value="/clinicalTrials")
    public String getClinicalTrialsFileResults(HttpServletRequest req, HttpServletResponse res, Model model,
                                              @PathVariable(required = false) String category, @RequestParam(required = false) String searchTerm) throws Exception {
        ClinicalTrialsService services = new ClinicalTrialsService();
        LinkedHashMap<String, List<String>> filterMap=getFiltersMap(req);
        SearchResponse sr=services.getSearchResults(searchTerm ,getFiltersMap(req));
        req.setAttribute("searchTerm", searchTerm);
        req.setAttribute("sr", sr);
        req.setAttribute("filterMap", filterMap);
        req.setAttribute("filtersSelected", getSelectedOrderedFilters(req));
        model.addAttribute("searchTerm", searchTerm);
//        Terms terms=sr.getAggregations().get("organization");
        req.setAttribute("page", "/WEB-INF/jsp/search/clinicalTrials/resultsview");
        req.getRequestDispatcher("/WEB-INF/jsp/base.jsp").forward(req, res);

        return null;
    }
    public LinkedHashMap<String,  List<String>> getFiltersMap(HttpServletRequest request) throws IOException {

        LinkedHashMap<String,  List<String>> filterMap=new LinkedHashMap<>();
        for(String filterField:ClinicalTrialsService.aggregationFields) {
            if (request.getParameterValues(filterField) != null) {
                List<String> filterValues = Arrays.asList(request.getParameterValues(filterField));
                filterMap.put(filterField, filterValues);
            }
        }

        return filterMap;
    }
    public List<String> getSelectedOrderedFilters(HttpServletRequest request) throws IOException {

        ObjectMapper mapper=new ObjectMapper();
        List<String> filters=new ArrayList<>();

        if(request.getParameter("filtersSelected")!=null){
            filters=mapper.readValue(request.getParameter("filtersSelected"), List.class);
        }

        if(request.getParameter("unchecked")!=null && !request.getParameter("unchecked").equals("") && filters!=null){
           return   removeFilter(request, filters);
        }
        if(request.getParameter("checked")!=null && !request.getParameter("checked").equals("") && filters!=null){
            return addFilter(request, filters);
        }

        return filters;
    }
    public List<String> removeFilter(HttpServletRequest request,  List<String> filters){
        String fieldValue=request.getParameter("unchecked");
        List<String> fieldValues=new ArrayList<>();
        for(String fv:filters){
                if (!fv.equalsIgnoreCase(fieldValue)) {
                    fieldValues.add(fv);
                }
            }
        return fieldValues;
    }
    public List<String> addFilter(HttpServletRequest request,List<String> filters){
        String fieldValue=request.getParameter("checked");
        if(fieldValue!=null)
            filters.add(fieldValue);
        return filters;
    }
}

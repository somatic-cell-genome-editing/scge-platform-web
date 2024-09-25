package edu.mcw.scge.controller;



import edu.mcw.scge.service.es.clinicalTrials.ClinicalTrialsService;
import edu.mcw.scge.service.es.clinicalTrials.PlatformIndexServices;

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
        PlatformIndexServices services = new PlatformIndexServices();
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
        Map<String, List<String>> filterMap=getFiltersMap(req);
        SearchResponse sr=services.getSearchResults(searchTerm ,getFiltersMap(req));
        req.setAttribute("searchTerm", searchTerm);
        req.setAttribute("sr", sr);
        req.setAttribute("filterMap", filterMap);
//        Terms terms=sr.getAggregations().get("organization");
        req.setAttribute("page", "/WEB-INF/jsp/search/clinicalTrials/resultsview");
        req.getRequestDispatcher("/WEB-INF/jsp/base.jsp").forward(req, res);

        return null;
    }
    public Map<String,  List<String>> getFiltersMap(HttpServletRequest request) throws IOException {
        Map<String,  List<String>> filterMap=new HashMap<>();
        for(String filterField:ClinicalTrialsService.aggregationFields) {
            if (request.getParameterValues(filterField) != null) {
                List<String> filterValues = Arrays.asList(request.getParameterValues(filterField));
                filterMap.put(filterField, filterValues);
            }
        }
        return filterMap;
    }

}

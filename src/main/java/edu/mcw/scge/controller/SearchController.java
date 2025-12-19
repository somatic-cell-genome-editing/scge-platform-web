package edu.mcw.scge.controller;



import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import edu.mcw.scge.configuration.Access;
import edu.mcw.scge.datamodel.Definition;
import edu.mcw.scge.datamodel.Person;
import edu.mcw.scge.datamodel.web.ClinicalTrials;
import edu.mcw.scge.service.es.clinicalTrials.ClinicalTrialsService;

import edu.mcw.scge.uploadFiles.DBService;
import org.elasticsearch.action.search.SearchResponse;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;

import java.util.*;

@Controller
@RequestMapping(value="/data/search")
public class SearchController{
    DBService service=new DBService();
    Access access=new Access();
    private static final int DEFAULT_PAGE_SIZE = 100;


    @RequestMapping(value="/")
    public String getSearchResultsResults(HttpServletRequest req, HttpServletResponse res, Model model,
                                               @RequestParam(required = true) String searchTerm,
                                               @RequestParam(defaultValue = "0") int page,
                                               @RequestParam(defaultValue = "100") int pageSize,
                                               OAuth2AuthenticationToken authentication) throws Exception {
        if(searchTerm==null)
            return null;
        ClinicalTrialsService services = new ClinicalTrialsService();
        LinkedHashMap<String, List<String>> filterMap=getFiltersMap(req, authentication);
        SearchResponse sr=services.getSearchResults(searchTerm, null, getFiltersMap(req, authentication), page, pageSize);

        // Set pagination attributes
        long totalHits = sr.getHits().getTotalHits().value;
        int totalPages = (int) Math.ceil((double) totalHits / pageSize);
        req.setAttribute("currentPage", page);
        req.setAttribute("pageSize", pageSize);
        req.setAttribute("totalHits", totalHits);
        req.setAttribute("totalPages", totalPages);

        // Get recent updates for daily digest (separate query)
        SearchResponse digestSr = services.getRecentUpdatesForDigest(null, getFiltersMap(req, authentication));
        req.setAttribute("digestHits", digestSr.getHits().getHits());

        req.setAttribute("searchTerm", searchTerm);
        req.setAttribute("sr", sr);
        req.setAttribute("filterMap", filterMap);
        req.setAttribute("filtersSelected", getSelectedOrderedFilters(req, authentication));
        model.addAttribute("searchTerm", searchTerm);
//        Terms terms=sr.getAggregations().get("organization");
        Map<String,List<Definition>> definitions=service.getAllDefinitionsMap();
        req.setAttribute("definitions", definitions);
        req.setAttribute("page", "/WEB-INF/jsp/search/clinicalTrials/resultsview");
        req.getRequestDispatcher("/WEB-INF/jsp/base.jsp").forward(req, res);

        return null;
    }
    @RequestMapping(value="/{category}")
    public String getClinicalTrialsFileResults(HttpServletRequest req, HttpServletResponse res, Model model,
                                               @PathVariable("category") String category, @RequestParam(name="searchTerm", required = false) String searchTerm,
                                               @RequestParam(defaultValue = "0") int page,
                                               @RequestParam(defaultValue = "100") int pageSize,
                                               OAuth2AuthenticationToken authentication) throws Exception {
        ClinicalTrialsService services = new ClinicalTrialsService();
        LinkedHashMap<String, List<String>> filterMap=getFiltersMap(req, authentication);
        SearchResponse sr=services.getSearchResults(searchTerm, category, getFiltersMap(req, authentication), page, pageSize);

        // Set pagination attributes
        long totalHits = sr.getHits().getTotalHits().value;
        int totalPages = (int) Math.ceil((double) totalHits / pageSize);
        req.setAttribute("currentPage", page);
        req.setAttribute("pageSize", pageSize);
        req.setAttribute("totalHits", totalHits);
        req.setAttribute("totalPages", totalPages);

        // Get recent updates for daily digest (separate query)
        SearchResponse digestSr = services.getRecentUpdatesForDigest(category, getFiltersMap(req, authentication));
        req.setAttribute("digestHits", digestSr.getHits().getHits());

        req.setAttribute("searchTerm", searchTerm);
        req.setAttribute("sr", sr);
        req.setAttribute("filterMap", filterMap);
        req.setAttribute("filtersSelected", getSelectedOrderedFilters(req, authentication));
        model.addAttribute("searchTerm", searchTerm);
//        Terms terms=sr.getAggregations().get("organization");
        Map<String,List<Definition>> definitions=service.getAllDefinitionsMap();
        req.setAttribute("expandAllFilters", req.getParameter("expandAllFilters"));
        req.setAttribute("definitions", definitions);
        req.setAttribute("category", category);
        if(category.equalsIgnoreCase("clinicalTrial"))
        req.setAttribute("title", "Gene Therapy Clinical Trials");
        else  req.setAttribute("title", category);
        req.setAttribute("page", "/WEB-INF/jsp/search/clinicalTrials/resultsview");
        req.getRequestDispatcher("/WEB-INF/jsp/base.jsp").forward(req, res);

        return null;
    }
    @RequestMapping(value="/autocomplete")
    public String getAutocompleteTerms(HttpServletRequest req, HttpServletResponse res, Model model,
                                               @RequestParam(required = false) String searchTerm) throws Exception {
        ClinicalTrialsService services = new ClinicalTrialsService();
        Set<String> autocompleteList=services.getAutocompleteList(searchTerm);
        Gson gson = new Gson();
        String autoList = gson.toJson(autocompleteList);
        res.getWriter().write(autoList);
        return null;
    }
    public LinkedHashMap<String,  List<String>> getFiltersMap(HttpServletRequest request, OAuth2AuthenticationToken authentication) throws Exception {

        LinkedHashMap<String,  List<String>> filterMap=new LinkedHashMap<>();
        for(String filterField: ClinicalTrials.facets) {
            if (request.getParameterValues(filterField) != null) {
                List<String> filterValues = Arrays.asList(request.getParameterValues(filterField));
                filterMap.put(filterField, filterValues);
            }
        }
        List<String> status=new ArrayList<>();
        if(filterMap.get("status")!=null) {
            status.addAll(filterMap.get("status"));
            boolean activeFlag = false;
            for (String stat : status) {
                if (stat.equalsIgnoreCase("Active")) {
                    activeFlag = true;
                    break;
                }
            }
            if (activeFlag) {
                status.add("Active not recruiting");
                status.add("Recruiting");
                filterMap.put("status", status);
            }
        }
        status.remove("Active");
        List<String> recordStatus=new ArrayList<>();
        Person person = getPersonFromAuth(authentication, request);
        if(filterMap.get("recordStatus")!=null && person!=null && access.isAdmin(person)){
            recordStatus.addAll(filterMap.get("recordStatus"));
        }
        else{
            if(person==null){
            recordStatus.add("Active");}
        }

        filterMap.put("recordStatus", recordStatus);
        return filterMap;
    }

    private Person getPersonFromAuth(OAuth2AuthenticationToken authentication, HttpServletRequest request) throws Exception {
        // First try to get from session (cached)
        if (request.getSession().getAttribute("person") != null) {
            return (Person) request.getSession().getAttribute("person");
        }
        // If not in session, get from OAuth2 token
        if (authentication != null && authentication.getPrincipal() != null) {
            Map<String, Object> attributes = authentication.getPrincipal().getAttributes();
            if (attributes != null && attributes.get("email") != null) {
                String email = (String) attributes.get("email");
                edu.mcw.scge.dao.implementation.PersonDao pdao = new edu.mcw.scge.dao.implementation.PersonDao();
                List<Person> personList = pdao.getPersonByEmail(email);
                if (personList != null && !personList.isEmpty()) {
                    Person person = personList.get(0);
                    // Cache in session for future requests
                    request.getSession().setAttribute("person", person);
                    return person;
                }
            }
        }
        return null;
    }
    public List<String> getSelectedOrderedFilters(HttpServletRequest request, OAuth2AuthenticationToken authentication) throws Exception {

        ObjectMapper mapper=new ObjectMapper();
        List<String> filters=new ArrayList<>();

        if(request.getParameter("filtersSelected")!=null && !request.getParameter("filtersSelected").equals("")){
            filters=mapper.readValue(request.getParameter("filtersSelected"), List.class);
        }

        if(request.getParameter("unchecked")!=null && !request.getParameter("unchecked").equals("") && filters!=null){
           return   removeFilter(request, filters);
        }
        if(request.getParameter("checked")!=null && !request.getParameter("checked").equals("") && filters!=null){
            return addFilter(request, filters);
        }
        if(request.getParameter("unchecked")==null && request.getParameter("checked")==null)
        {
            LinkedHashMap<String,  List<String>> filterMap=   getFiltersMap(request, authentication);
            if(filterMap!=null && filterMap.size()>0){
                for(String key:filterMap.keySet()){
                    List<String> filterValues=filterMap.get(key);
                    filters.addAll(filterValues);
                }
            }
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

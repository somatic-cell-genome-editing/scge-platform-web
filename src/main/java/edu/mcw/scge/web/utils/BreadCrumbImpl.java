package edu.mcw.scge.web.utils;


import jakarta.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

public class BreadCrumbImpl implements Crumb {


    public TreeMap<Integer, Map<String, String>> getSearchCrumbTrail(String pageContext, HttpServletRequest req){
        TreeMap<Integer, Map<String, String>> crumbTrail=new TreeMap<>();
        String parentCrumb=new String();
        String childCrumb=new String();
        String parentUrl=new String();
        if(pageContext.equalsIgnoreCase("search")){
            String searchTerm=req.getParameter("searchTerm");
            String category= (String) req.getAttribute("category");
            Map<String, String> trailNLink1=new HashMap<>();
            parentCrumb= "Categories";
            parentUrl="/platform/data/search/results?searchTerm="+searchTerm;
            trailNLink1.put(parentCrumb, parentUrl);
            crumbTrail.put(1, trailNLink1);

            childCrumb= category;
            Map<String, String> trailNLink2=new HashMap<>();
            trailNLink2.put(childCrumb, "");
            crumbTrail.put(2, trailNLink2);

        }
        return crumbTrail;
    }
    public TreeMap<Integer, Map<String, String>> getEditorCrumbTrail(String pageContext, HttpServletRequest req){
        TreeMap<Integer, Map<String, String>> crumbTrail=new TreeMap<>();
        String parentCrumb=new String();
        int parentId=0;
        String childCrumb=new String();
        String parentUrl=new String();
        if(pageContext.equalsIgnoreCase("search")){
            String searchTerm=req.getParameter("searchTerm");
            String category= (String) req.getAttribute("category");
            Map<String, String> trailNLink1=new HashMap<>();

            parentCrumb= "Categories";
            parentUrl="/platform/data/search/results?searchTerm="+searchTerm;
            trailNLink1.put(parentCrumb, parentUrl+parentId);
            crumbTrail.put(1, trailNLink1);

            childCrumb= category;
            Map<String, String> trailNLink2=new HashMap<>();
            trailNLink2.put(childCrumb, "");
            crumbTrail.put(2, trailNLink2);

        }
        return crumbTrail;
    }

    @Override
    public TreeMap<Integer, Map<String, String>> getCrumbTrailMap(HttpServletRequest req, Object parent, Object child, String pageContext) {
        return null;
    }
}

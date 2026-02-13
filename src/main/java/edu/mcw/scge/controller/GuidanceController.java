package edu.mcw.scge.controller;


import edu.mcw.scge.dao.implementation.ctd.CTDResourceDAO;
import edu.mcw.scge.dao.implementation.ctd.SectionDAO;
import edu.mcw.scge.datamodel.ctd.CTDResource;
import edu.mcw.scge.datamodel.ctd.Section;
import edu.mcw.scge.services.SCGEContext;
import edu.mcw.scge.uploadFiles.storage.FileSystemStorageService;
import edu.mcw.scge.uploadFiles.storage.StorageProperties;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.*;

@Controller
@RequestMapping(value="/data/ind")
public class GuidanceController extends ModulesController{
    @RequestMapping(value="/forms")
    public String getINDForms(HttpServletRequest req, HttpServletResponse res) throws Exception {
        req.setAttribute("title","Investigational New Drug (IND) forms");
        req.setAttribute("page", "/WEB-INF/jsp/forms/forms");
        req.getRequestDispatcher("/WEB-INF/jsp/base.jsp").forward(req, res);

        return null;
    }
    @RequestMapping(value="/templates")
    public String getINDTemplates(HttpServletRequest req, HttpServletResponse res) throws Exception {
        if(!SCGEContext.isProduction()) {
            req.setAttribute("modules", getCTDModules());
            req.setAttribute("title", "Investigational New Drug (IND) Templates");
            req.setAttribute("page", "/WEB-INF/jsp/templates/templates");
            req.getRequestDispatcher("/WEB-INF/jsp/base.jsp").forward(req, res);
     }
        return null;
    }

    @RequestMapping(value="/resources")
    public String getResources(HttpServletRequest req, HttpServletResponse res) throws Exception {
        CTDResourceDAO resourceDAO = new CTDResourceDAO();
        SectionDAO sectionDAO = new SectionDAO();

        List<CTDResource> allResources = resourceDAO.getAllResources();

        // Group resources by module (1-5), with general resources separate
        Map<Integer, Map<String, List<CTDResource>>> moduleResources = new TreeMap<>();
        for (int i = 1; i <= 5; i++) {
            moduleResources.put(i, new TreeMap<>(new SectionCodeComparator()));
        }
        List<CTDResource> generalResources = new ArrayList<>();

        for (CTDResource resource : allResources) {
            String section = resource.getCtdSection();
            if (section == null || section.isEmpty() || section.equals("null") || section.equals("ALL")) {
                generalResources.add(resource);
            } else {
                // Determine module from section code (first character before '.')
                try {
                    int module = Integer.parseInt(section.substring(0, 1));
                    if (module >= 1 && module <= 5) {
                        moduleResources.get(module)
                                .computeIfAbsent(section, k -> new ArrayList<>())
                                .add(resource);
                    } else {
                        generalResources.add(resource);
                    }
                } catch (NumberFormatException e) {
                    generalResources.add(resource);
                }
            }
        }

        // Build section name lookup
        Map<String, String> sectionNames = new HashMap<>();
        for (int module = 1; module <= 5; module++) {
            for (Map.Entry<String, List<CTDResource>> entry : moduleResources.get(module).entrySet()) {
                String sectionCode = entry.getKey();
                if (!sectionNames.containsKey(sectionCode)) {
                    Section s = sectionDAO.getSectionBySectionCode(sectionCode);
                    if (s != null) {
                        sectionNames.put(sectionCode, s.getSectionName());
                    }
                }
            }
        }

        req.setAttribute("moduleResources", moduleResources);
        req.setAttribute("generalResources", generalResources);
        req.setAttribute("sectionNames", sectionNames);
        req.setAttribute("title", "IND Resources");
        req.setAttribute("page", "/WEB-INF/jsp/templates/resources");
        req.getRequestDispatcher("/WEB-INF/jsp/base.jsp").forward(req, res);

        return null;
    }

    /**
     * Comparator for section codes that sorts numerically by each segment.
     */
    private static class SectionCodeComparator implements Comparator<String> {
        @Override
        public int compare(String s1, String s2) {
            String[] parts1 = s1.trim().split("\\.");
            String[] parts2 = s2.trim().split("\\.");
            int len = Math.max(parts1.length, parts2.length);
            for (int i = 0; i < len; i++) {
                String p1 = i < parts1.length ? parts1[i].trim() : "";
                String p2 = i < parts2.length ? parts2[i].trim() : "";
                // Try numeric comparison first
                try {
                    int n1 = Integer.parseInt(p1);
                    int n2 = Integer.parseInt(p2);
                    if (n1 != n2) return Integer.compare(n1, n2);
                } catch (NumberFormatException e) {
                    int cmp = p1.compareTo(p2);
                    if (cmp != 0) return cmp;
                }
            }
            return 0;
        }
    }
}

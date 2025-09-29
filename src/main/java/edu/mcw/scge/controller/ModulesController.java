package edu.mcw.scge.controller;

import edu.mcw.scge.dao.implementation.ctd.SectionDAO;
import edu.mcw.scge.datamodel.ctd.Section;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value="/ind/application")
public class ModulesController {
    public Map<Integer, List<Section>> getCTDModules() throws Exception {
        SectionDAO sectionDAO=new SectionDAO();
        Map<Integer, List<Section>> modules=new HashMap<>();
        for(int module: Arrays.asList(1,2,3,4,5)) {
            List<Section> sections = sectionDAO.getTopLevelSectionsOfModule(module);
            modules.put(module, sectionDAO.sort(sections));
        }
        return modules;
    }
}

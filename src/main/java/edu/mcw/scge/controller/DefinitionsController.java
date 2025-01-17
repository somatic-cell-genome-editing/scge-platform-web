package edu.mcw.scge.controller;

import com.google.gson.Gson;
import edu.mcw.scge.datamodel.Definition;
import edu.mcw.scge.uploadFiles.DBService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Controller
@RestController
@RequestMapping("/data/definitions")

public class DefinitionsController {
    DBService service=new DBService();
    Gson gson=new Gson();
    @GetMapping("/all")
    public String getDefinitions() throws Exception {
       List<Definition> definitions=service.getAllDefinitions();
       return gson.toJson(definitions);
    }
}

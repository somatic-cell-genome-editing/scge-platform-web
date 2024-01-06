package edu.mcw.scge.configuration;

import edu.mcw.scge.dao.implementation.*;
import edu.mcw.scge.datamodel.*;
import edu.mcw.scge.service.DataAccessService;

import org.springframework.web.bind.annotation.ModelAttribute;


import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class Access {
    PersonDao pdao=new PersonDao();

    public Person getUser(HttpSession session) throws Exception{
        UserService us = new UserService();
        return us.getCurrentUser(session);
    }


    public boolean isAdmin(Person p) throws Exception{

        if (p.getEmail().toLowerCase().equals("jdepons@yahoo.com")
            || p.getEmail().toLowerCase().equals("jthota@mcw.edu")
            || p.getEmail().toLowerCase().equals("mrdwinel@mcw.edu")
            || p.getEmail().toLowerCase().equals("mjhoffman@mcw.edu")
            || p.getEmail().toLowerCase().equals("ageurts@mcw.edu")
            || p.getEmail().toLowerCase().equals("alemke@mcw.edu")
            || p.getEmail().toLowerCase().equals("mgrzybowski@mcw.edu")
            || p.getEmail().toLowerCase().equals("jrsmith@mcw.edu")
            || p.getEmail().toLowerCase().equals("akwitek@mcw.edu")
            || p.getEmail().toLowerCase().equals("mtutaj@mcw.edu")) {
            return true;
        }else {
            return false;
        }
    }
    public boolean isDeveloper(Person p) throws Exception{

        if (p.getEmail().toLowerCase().equals("jdepons@yahoo.com")
                || p.getEmail().toLowerCase().equals("jthota@mcw.edu")
                || p.getEmail().toLowerCase().equals("mtutaj@mcw.edu")) {
            return true;
        }else {
            return false;
        }
    }
    public boolean verifyUserExists( String principalName, String email) throws Exception {

        List<Person> people= (pdao.getPersonByEmail(email));
        if(people!=null && people.size()>0){
            Person p= people.get(0);
            pdao.updateGoogleId(principalName, p.getId());
            return true;
        }
        return false;
    }
    //   @ModelAttribute("personInfoRecords")
    public List<PersonInfo> getPersonInfoRecords(@ModelAttribute("userAttributes") Map userAttributes) throws Exception {
        if(userAttributes!=null) {
            boolean userExists = verifyUserExists(userAttributes.get("sub").toString(), userAttributes.get("email").toString());
            List<PersonInfo> personInfoList = new ArrayList<>();
            if (userExists) {
                List<Person> personRecords = pdao.getPersonByGoogleId(userAttributes.get("sub").toString());
                if (personRecords.size() > 0)
                    personInfoList = pdao.getPersonInfo(personRecords.get(0).getId());
            }
            return personInfoList;
        }
        return null;
    }
    public List<PersonInfo> getPersonInfoRecords(int personId) throws Exception {

            List<PersonInfo> personInfoList = new ArrayList<>();

                    personInfoList = pdao.getPersonInfo(personId);

            return personInfoList;


    }


}

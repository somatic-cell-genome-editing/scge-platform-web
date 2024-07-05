package edu.mcw.scge.controller;


import edu.mcw.scge.configuration.Access;
import edu.mcw.scge.platform.dao.implementation.PersonDao;
import edu.mcw.scge.platform.datamodel.Person;


import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import java.util.*;


/**
 * Created by jthota on 8/9/2019.
 */
@Controller

public class LoginController{
    PersonDao pdao=new PersonDao();
    Access access=new Access();

    @RequestMapping("/home")
    public String getHomePage(OAuth2AuthenticationToken authentication, HttpServletRequest req) throws Exception {

        req.setAttribute("seoDescription","Database of study and experiment data generated by the Somatic Cell Genome Editing Consortium");
        req.setAttribute("seoTitle","Home");
        req.setAttribute("page", "/WEB-INF/jsp/home");
        return "base";
    }

    @RequestMapping("/loginSuccessPage")
    public String verifyAuthentication(OAuth2AuthenticationToken authentication, HttpServletRequest req) throws Exception {
        Map userAttributes=getUserAttributes(authentication);

        if(userAttributes!=null) {
            boolean userExists = access.verifyUserExists(userAttributes.get("sub").toString(), userAttributes.get("email").toString());
            if (userExists) {
                List<Person> personList = pdao.getPersonByEmail(userAttributes.get("email").toString());
                Person p=personList.get(0);
                System.out.println("PERSON:"+p.getEmail());
                if (p.getStatus().equalsIgnoreCase("active")) {
                    HttpSession session = req.getSession(true);
                    session.setAttribute("userAttributes", userAttributes);
                    session.setAttribute("personId", p.getId());
                  //  session.setAttribute("personInfoList", getPerson(userAttributes));
                    req.setAttribute("personInfoList", access.getPersonInfoRecords(userAttributes));

                    System.out.println("USER_LOGIN_SUCCESS " + userAttributes.get("email").toString()+ " " +  new Date().toString());
                    req.setAttribute("page", "/WEB-INF/jsp/login/home");
                    return "base";

                }
            } else {
                System.out.println("USER_LOGIN_FAILED " + userAttributes.get("email").toString() + " " +  new Date().toString());
                req.setAttribute("msg", "Please contact SCGE admin and register your google id");
                return "redirect:/loginFailure";
            }
        }
            return "redirect:/loginFailure";

    }

    @RequestMapping("/loginFailure")
    public String getFailureMessage(HttpServletRequest req){
       String msg="Please contact admin at ";
       req.setAttribute("msg",msg);
        return "loginFailure" ;
    }
 public Map getUserAttributes(OAuth2AuthenticationToken authentication){
     if(authentication!=null) {
       return   authentication.getPrincipal().getAttributes();
     }
     return null;
 }

}

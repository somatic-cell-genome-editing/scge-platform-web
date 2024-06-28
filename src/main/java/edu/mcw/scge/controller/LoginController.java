package edu.mcw.scge.controller;


import edu.mcw.scge.configuration.Access;
import edu.mcw.scge.platform.dao.implementation.PersonDao;
import edu.mcw.scge.platform.datamodel.Person;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ResolvableType;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;

import org.springframework.security.oauth2.client.OAuth2AuthorizedClient;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientService;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;

import org.springframework.stereotype.Controller;

import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import java.util.*;


/**
 * Created by jthota on 8/9/2019.
 */
@Controller

public class LoginController{

    private static final String authorizationRequestBaseUri = "login";
    Map<String, String> oauth2AuthenticationUrls = new HashMap<>();
    PersonDao pdao=new PersonDao();
    Access access=new Access();
    @Autowired
   private ClientRegistrationRepository clientRegistrationRepository;
    @Autowired
    private OAuth2AuthorizedClientService authorizedClientService;

    @RequestMapping("/oauth_login")
    public String getLoginPage(OAuth2AuthenticationToken authentication) throws Exception {
      Iterable<ClientRegistration> clientRegistrations = null;
        ResolvableType type = ResolvableType.forInstance(clientRegistrationRepository)
                .as(Iterable.class);
        if (type != ResolvableType.NONE && ClientRegistration.class.isAssignableFrom(type.resolveGenerics()[0])) {
            clientRegistrations = (Iterable<ClientRegistration>) clientRegistrationRepository;
        }
      /* clientRegistrations.forEach(clientRegistration -> System.out.println(clientRegistration.getClientId()+"\n"+clientRegistration.getClientSecret()+"\n"+
               clientRegistration.getProviderDetails().getAuthorizationUri()+"\nSCOPES: "+clientRegistration.getScopes().toString()));*/

        clientRegistrations.forEach(registration -> oauth2AuthenticationUrls.put(registration.getClientName(), authorizationRequestBaseUri + "/" + registration.getRegistrationId()));
        //model.addAttribute("urls", oauth2AuthenticationUrls);

       return "redirect:/";

    }

    @RequestMapping("/loginSuccess")
    public String getHomePage(OAuth2AuthenticationToken authentication, HttpServletRequest req) throws Exception {

        req.setAttribute("seoDescription","Database of study and experiment data generated by the Somatic Cell Genome Editing Consortium");
        req.setAttribute("seoTitle","Home");

        req.setAttribute("page", "/WEB-INF/jsp/home");
        return "base";
    }

    @RequestMapping("/loginSuccessPage")
    public String verifyAuthentication(OAuth2AuthenticationToken authentication, HttpServletRequest req) throws Exception {
        System.out.println("Authentication Not null:"+ (authentication!=null));
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

                    return "redirect:/loginSuccess";
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
         OAuth2AuthorizedClient client = authorizedClientService.loadAuthorizedClient(authentication.getAuthorizedClientRegistrationId(), authentication.getName());
         if(client!=null) {
             String userInfoEndpointUri = client.getClientRegistration()
                     .getProviderDetails()
                     .getUserInfoEndpoint()
                     .getUri();
             if (!StringUtils.isEmpty(userInfoEndpointUri)) {
                 RestTemplate restTemplate = new RestTemplate();
                 HttpHeaders headers = new HttpHeaders();
                 headers.add(HttpHeaders.AUTHORIZATION, "Bearer " + client.getAccessToken()
                         .getTokenValue());
                 HttpEntity<String> entity = new HttpEntity<String>("", headers);

                 ResponseEntity<Map> response = restTemplate.exchange(userInfoEndpointUri, HttpMethod.GET, entity, Map.class);
                 return response.getBody();
             }
         }
     }
     return null;
 }

}

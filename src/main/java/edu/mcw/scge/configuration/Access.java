package edu.mcw.scge.configuration;




import edu.mcw.scge.dao.implementation.PersonDao;
import edu.mcw.scge.datamodel.Person;
import edu.mcw.scge.datamodel.PersonInfo;
import org.springframework.web.bind.annotation.ModelAttribute;


import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class Access {
    PersonDao pdao=new PersonDao();

    public Person getUser(HttpSession session) throws Exception{
        UserService us = new UserService();
        return us.getCurrentUser(session);
    }
    public boolean isAdmin(Person p) throws Exception{
        return pdao.isAdmin(p);
    }
    public boolean isDeveloper(Person p) throws Exception{
        return pdao.isDeveloper(p);
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

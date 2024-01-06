package edu.mcw.scge.service;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.http.HttpRequest;
import edu.mcw.scge.dao.AbstractDAO;
import edu.mcw.scge.dao.implementation.*;
import edu.mcw.scge.dao.spring.StudyAssociationQuery;
import edu.mcw.scge.datamodel.*;
import edu.mcw.scge.process.tierUpdates.UpdateUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.web.bind.annotation.ModelAttribute;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URI;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.util.*;

/**
 * Created by jthota on 8/16/2019.
 */
public class DataAccessService extends AbstractDAO {
    PersonDao pdao=new PersonDao();
    GroupDAO gdao=new GroupDAO();


    public void insertOrUpdate(Person p) throws Exception{

            int key=pdao.getNextKey("person_seq");
            p.setId(key);
            pdao.insert(p);

    }
   public boolean existsInSCGE(GoogleIdToken.Payload payload) throws Exception {
       List<Person> p=pdao.getPersonByGoogleId(payload.getSubject());
        if(p==null || p.size()==0){

           int id= updateGoogleId(payload);
            if(id!=0){
                return true;
            }

        }else{
            if(p.size()>0)
           return true;
        }


        return false;
    }

    public static String restGet(String url, String contentType) throws Exception {
        try {
            DefaultHttpClient httpClient = new DefaultHttpClient();
            HttpGet getRequest = new HttpGet(url);
            if (contentType != null) getRequest.addHeader("accept", contentType);

            HttpResponse response = httpClient.execute(getRequest);

            if (response.getStatusLine().getStatusCode() != 200) {
                if (response.getStatusLine().getStatusCode() == 404) return "";
                throw new RuntimeException("Failed : HTTP error code : "
                        + response.getStatusLine().getStatusCode());
            }

            BufferedReader br = new BufferedReader(
                    new InputStreamReader((response.getEntity().getContent())));

            String outputLine = "", output = "";
            while ((outputLine = br.readLine()) != null) {
                output += outputLine;
            }

            httpClient.getConnectionManager().shutdown();
            return output;

        } catch (IOException e) {

            throw e;
        }
    }
    public int updateGoogleId(GoogleIdToken.Payload payload) throws Exception {
        String googleSub=payload.getSubject();
           List<Person>  pList=pdao.getPersonByEmail(payload.getEmail());
            if(pList!=null && pList.size()==1){
                pdao.updateGoogleId(googleSub,pList.get(0).getId() );
                return  pList.get(0).getId();
            }

        return 0;
    }

    public List<Person> getAllMembers() throws Exception {
        return   pdao.getAllActiveMembers();
    }
    public List<Person> getPersonById(String scgeMemberId) throws Exception {
        return   pdao.getPersonById(Integer.parseInt(scgeMemberId));
    }
    public int getPersonByGoogleId(GoogleIdToken.Payload paylaod) throws Exception {
        List<Person> pList=pdao.getPersonByGoogleId(paylaod.getSubject());
        if(pList!=null && pList.size()>0){
            return pList.get(0).getId();
        }
        return  0 ;
    }



   public  Map<SCGEGroup, List<SCGEGroup>> getGroupsMapByGroupName(String groupName) throws Exception {

        Map<SCGEGroup, List<SCGEGroup>> map= new HashMap<>();
        List<SCGEGroup> subgroups=new ArrayList<>();
        int groupId=gdao.getGroupId(groupName);
        try {
            subgroups=   gdao.getSubGroupsByGroupId(groupId);
            for(SCGEGroup sg:subgroups){
                List<SCGEGroup> ssgroups=  gdao.getSubGroupsByGroupId(sg.getGroupId());
                map.put(sg, ssgroups);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return map;
    }


    public Map<SCGEGroup, List<Person>> getGroupMembersMapExcludeDCCNIH( Map<SCGEGroup, List<SCGEGroup>> consortiumGroup) throws Exception {
        Map<SCGEGroup, List<Person>> map=new HashMap<>();
        List<Integer> DCCNIHGroups= gdao.getDCCNIHGroupIds();
        for(Map.Entry e: consortiumGroup.entrySet()){
            List<SCGEGroup> groups= (List<SCGEGroup>) e.getValue();
            for(SCGEGroup g:groups){
                int groupId= g.getGroupId();
                List<Person> sortedMembers=new ArrayList<>();
                List<Integer> memberIds=new ArrayList<>();
                List<Person> members=gdao.getGroupMembersByGroupId(groupId);
                for(Person p:members){
                    if(!memberIds.contains(p.getId())){
                        sortedMembers.add(p);
                        memberIds.add(p.getId());
                    }
                }
              if(!DCCNIHGroups.contains(groupId))
                map.put(g, sortedMembers);

            }
        }
        return map;
    }
    public Map<SCGEGroup, List<Person>> getDCCNIHMembersMap( Map<SCGEGroup   , List<SCGEGroup>> consortiumGroup) throws Exception {
        Map<SCGEGroup, List<Person>> map=new HashMap<>();
        List<Integer> DCCNIHGroups= gdao.getDCCNIHGroupIds();
        for(Map.Entry e: consortiumGroup.entrySet()){
            List<SCGEGroup> groups= (List<SCGEGroup>) e.getValue();
            for(SCGEGroup g:groups){
                int groupId= g.getGroupId();
                if(DCCNIHGroups.contains(groupId)) {
                    List<Person> sortedMembers = new ArrayList<>();
                    List<Integer> memberIds = new ArrayList<>();
                    List<Person> members = gdao.getGroupMembersByGroupId(groupId);
                    for (Person p : members) {
                        if (!memberIds.contains(p.getId())) {
                            sortedMembers.add(p);
                            memberIds.add(p.getId());
                        }
                    }

                    map.put(g, sortedMembers);
                }

            }
        }
        return map;
    }


    public List<Integer> getDCCNIHGroupsIds() throws Exception {
        GroupDAO gdao=new GroupDAO();
        return gdao.getDCCNIHGroupIds();

    }

}

package edu.mcw.scge.uploadFiles;

import com.google.gson.Gson;
import edu.mcw.scge.dao.implementation.ApplicationDAO;
import edu.mcw.scge.dao.implementation.DocumentDAO;
import edu.mcw.scge.dao.implementation.PersonDao;
import edu.mcw.scge.datamodel.Application;
import edu.mcw.scge.datamodel.Document;
import edu.mcw.scge.datamodel.PersonInfo;
import edu.mcw.scge.uploadFiles.storage.StorageProperties;
import org.springframework.stereotype.Service;

import javax.print.Doc;
import java.util.*;

@Service
public class DBService {
    ApplicationDAO applicationDAO= new ApplicationDAO();
    DocumentDAO documentDAO= new DocumentDAO();

    PersonDao personDao=new PersonDao();
    public int insertApplication(Application application) throws Exception {
        int applicationId=applicationDAO.getNextKey("application_id_seq");
        application.setApplicationId(applicationId);
        applicationDAO.insert(application);
        return applicationId;
    }
    public void insertDocument(Document document) throws Exception {
        documentDAO.insert(document);
    }
    public int getNewApplicationId() throws Exception {
        return applicationDAO.getNextKey("application_id_seq");
    }
    public String saveDocument(String fileName, StorageProperties properties, int tier) throws Exception {
        Gson gson=new Gson();
        Document document=getDocument(fileName, properties);
        int docSequenceKey = documentDAO.getNextKey("document_seq");
        if(document==null) {
           document=new Document();
            document.setDocumentId(docSequenceKey);
            document.setTier(tier);
            document.setUploadedBy(properties.getSubmittedBy());
            document.setDocumentName(fileName);
            document.setModule(properties.getModule());
            document.setSection(properties.getSection());
            document.setApplicationId(properties.getApplicationId());
            document.setSponsorName(properties.getSponsorName());
            document.setVersion("1");
            document.setProductName(properties.getProductName());
            documentDAO.insert(document);
            return document.getVersion();
        }else{
            int version= Integer.parseInt(document.getVersion());
            int updatedVersion=version+1;
            document.setVersion(String.valueOf(updatedVersion));
            document.setDocumentId(docSequenceKey);
            documentDAO.insert(document);
            return String.valueOf(updatedVersion);
        }


    }
    public Document getDocument(String fileName, StorageProperties storageProperties) throws Exception {
        return   documentDAO.getDocumentByName(fileName, storageProperties.getApplicationId(), storageProperties.getSponsorName(), storageProperties.getModule());
    }
    public List<Application> getApplications() throws Exception {
        return applicationDAO.getApplications();
    }
    public Application getApplicationById(int applicationId) throws Exception {
        return applicationDAO.getApplicationById(applicationId);
    }
    public List<Application> getApplicationByGroupId(int groupId) throws Exception {
        return applicationDAO.getApplicationsByGroupId(groupId);
    }
    public Map<Integer, List<Application>> getApplicationsByUserId(int userId) throws Exception {
        List<PersonInfo> personInfoList=personDao.getPersonInfo(userId);
        Map<Integer, List<Application>> applicationsMap=new HashMap<>();
        for(PersonInfo personInfo:personInfoList){
            int groupId=personInfo.getGroupId();
            List<Application> applications=new ArrayList<>();
           if( applicationsMap.get(groupId)!=null){
               applications.addAll(applicationsMap.get(groupId));
           }
           applications.addAll(getApplicationByGroupId(groupId));
           applicationsMap.put(groupId, applications);
        }
        return applicationsMap;
    }
    public Map<String, List<Document>> getApplicationDocuments(int applicationId) throws Exception {
        List<Document> documents=  documentDAO.getDocumentsByApplicationId(applicationId);
        Map<String, List<Document>> map=new HashMap<>(); //section documents map
        if(documents.size()>0){
            for(Document document:documents){
                List<Document> docs=new ArrayList<>();
                if(map.get(document.getSection())!=null){
                    docs.addAll(map.get(document.getSection()));
                }
                docs.add(document);
                map.put(document.getSection().trim(), docs);
            }
        }
        return map;
    }
}

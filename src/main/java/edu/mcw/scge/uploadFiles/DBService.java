package edu.mcw.scge.uploadFiles;

import edu.mcw.scge.dao.implementation.ApplicationDAO;
import edu.mcw.scge.dao.implementation.DocumentDAO;
import edu.mcw.scge.dao.spring.ApplicationQuery;
import edu.mcw.scge.datamodel.Application;
import edu.mcw.scge.datamodel.Document;
import edu.mcw.scge.uploadFiles.storage.StorageProperties;
import io.grpc.Context;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class DBService {

     ApplicationDAO applicationDAO= new ApplicationDAO();
     DocumentDAO documentDAO= new DocumentDAO();

    public void insertApplication(Application application) throws Exception {
        applicationDAO.insert(application);
    }
    public void insertDocument(Document document) throws Exception {
        documentDAO.insert(document);
    }
    public int getNewApplicationId() throws Exception {
        return applicationDAO.getNextKey("application_id_seq");
    }
    public String saveDocument(String fileName, StorageProperties properties, int tier) throws Exception {
       Document document=getDocument(fileName, properties);
       if(document==null) {
           document=new Document();
           int docSequenceKey = documentDAO.getNextKey("document_seq");
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
       }else{
           String version=document.getVersion();
           int updatedVersion=Integer.parseInt(version)+1;
           document.setVersion(String.valueOf(updatedVersion));
           int docSequenceKey = documentDAO.getNextKey("document_seq");
           document.setDocumentId(docSequenceKey);
           documentDAO.insert(document);
       }
        System.out.println("DOCUMENT VERSION:"+ document.getVersion());

        return document.getVersion();
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

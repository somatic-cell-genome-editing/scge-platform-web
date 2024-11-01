package edu.mcw.scge.uploadFiles.storage;


import edu.mcw.scge.datamodel.Application;
import edu.mcw.scge.datamodel.Document;
import org.elasticsearch.index.similarity.ScriptedSimilarity;
import org.springframework.context.annotation.Configuration;

@Configuration("storageProperties")
public class StorageProperties extends Document {
    /**
     * Folder location for storing files
     */
    private String location ="C:/upload-dir";
//    private int applicationId;
//    private String sponsorName="";
//    public int module;
//
//    public int getApplicationId() {
//        return applicationId;
//    }
//
//    public void setApplicationId(int applicationId) {
//        this.applicationId = applicationId;
//    }
//
//    public String getSponsorName() {
//        return sponsorName;
//    }
//
//    public void setSponsorName(String sponsorName) {
//        this.sponsorName = sponsorName;
//    }
//
//    public int getModule() {
//        return module;
//    }
//
//    public void setModule(int module) {
//        this.module = module;
//    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

//    public String getApplicationId() {
//        return applicationId;
//    }
//
//    public void setApplicationId(String applicationId) {
//        this.applicationId = applicationId;
//    }
//
//    public String getSponsorName() {
//        return sponsorName;
//    }
//
//    public void setSponsorName(String sponsorName) {
//        this.sponsorName = sponsorName;
//    }
}

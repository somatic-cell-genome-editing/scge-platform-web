package edu.mcw.scge.uploadFiles.storage;


import edu.mcw.scge.datamodel.Document;
import org.springframework.context.annotation.Configuration;

@Configuration("storageProperties")
public class StorageProperties extends Document {
    /**
     * Folder location for storing files
     */
    private String location = "C:/upload-dir";

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }
}

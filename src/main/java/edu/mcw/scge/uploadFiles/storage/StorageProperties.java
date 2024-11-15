package edu.mcw.scge.uploadFiles.storage;


import org.springframework.context.annotation.Configuration;

@Configuration
public class StorageProperties {
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

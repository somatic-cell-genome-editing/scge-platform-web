package edu.mcw.scge.uploadFiles.storage;

import org.springframework.core.io.Resource;
import org.springframework.web.multipart.MultipartFile;

import java.nio.file.Path;
import java.util.stream.Stream;

public interface StorageService {
    void init(int applicationId);

    void store(MultipartFile file, String sectionCode, int module, String version);

    Stream<Path> loadAll(int module);

    Path load(String filename, int module);

    Resource loadAsResource(String filename, int module);

    void deleteAll();
}

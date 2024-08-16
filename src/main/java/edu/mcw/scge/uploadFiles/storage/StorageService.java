package edu.mcw.scge.uploadFiles.storage;

import org.springframework.core.io.Resource;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.nio.file.Path;
import java.util.stream.Stream;

public interface StorageService {
    void init(int applicationId);

    void store(MultipartFile file, String sectionCode);

    Stream<Path> loadAll();

    Path load(String filename);

    Resource loadAsResource(String filename);

    void deleteAll();

}

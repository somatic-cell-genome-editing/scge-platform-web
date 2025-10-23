package edu.mcw.scge.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@Controller
@RequestMapping(value = "/download")
public class DownloadController {

  //  @RequestMapping(value = "/{filename:.+}", method = RequestMethod.POST)
    @RequestMapping(value = "/zipFile", method = RequestMethod.POST)
    public ResponseEntity<Resource> downloadFile(HttpServletRequest request) {
        String filename=request.getParameter("filename");
        try {
          // Configure your file directory
            String FILE_DIRECTORY = "/data/download/IND000000";
            Path filePath = Paths.get(FILE_DIRECTORY).resolve(filename).normalize();
            Resource resource = new UrlResource(filePath.toUri());

            if (resource.exists() && resource.isReadable()) {
                String contentType = "application/octet-stream"; // Default content type, determine dynamically if possible

                return ResponseEntity.ok()
                        .contentType(MediaType.parseMediaType(contentType))
                        .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.getFilename() + "\"")
                        .body(resource);
            } else {
                return ResponseEntity.notFound().build();
            }
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }
    @GetMapping("/module")
    public void downloadFile(HttpServletResponse response, @RequestParam String filename,@RequestParam String path) throws IOException {

     String MODULE_DIRECTORY = "/data/download/IND000000/"+path.replaceAll("'","");;
 //        Path to the directory where files are stored
        Path filePath = Paths.get(MODULE_DIRECTORY, filename);

        if (!Files.exists(filePath)) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().write("File not found");
            return;
        }

        // Try to detect the file's content type
        String contentType = Files.probeContentType(filePath);
        if (contentType == null) {
            contentType = "application/octet-stream"; // Fallback for unknown types
        }

        // Set response headers
        response.setContentType(contentType);
        response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
        response.setContentLengthLong(Files.size(filePath));

        // Stream the file
        try (InputStream in = Files.newInputStream(filePath);
             OutputStream out = response.getOutputStream()) {

            byte[] buffer = new byte[8192];
            int bytesRead;
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
            out.flush();
        }
    }
    @GetMapping("/regulatory")
    public void downloadRegulatoryDocument(HttpServletResponse response, @RequestParam String documentName) throws IOException {

        System.out.println("filename:" + documentName);
        //    String MODULE_DIRECTORY = "/data/download/IND000000/"+path.replaceAll("'","");;
        String MODULE_DIRECTORY = "C:\\Users\\jthota\\Downloads\\regulatory\\documents\\";
        //        Path to the directory where files are stored
        Path filePath = Paths.get(MODULE_DIRECTORY, documentName.replaceAll("'", ""));

        if (!Files.exists(filePath)) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().write("File not found");
            return;
        }

// Try to detect the file's content type
        String contentType = Files.probeContentType(filePath);
        if (contentType == null) {
            contentType = "application/octet-stream"; // Fallback for unknown types
        }

// Set response headers
        response.setContentType(contentType);
// Use "inline" to open in browser instead of downloading
        response.setHeader("Content-Disposition", "inline; filename=\"" + documentName.replaceAll("'", "") + "\"");
        response.setContentLengthLong(Files.size(filePath));

// Stream the file
        try (InputStream in = Files.newInputStream(filePath);
             OutputStream out = response.getOutputStream()) {

            byte[] buffer = new byte[8192];
            int bytesRead;
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
            out.flush();
        }
    }
    }

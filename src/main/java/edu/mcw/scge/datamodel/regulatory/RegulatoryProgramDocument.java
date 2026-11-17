package edu.mcw.scge.datamodel.regulatory;

/**
 * A regulatory document a program has shared - a briefing book, a meeting
 * package, the FDA's responses. The file itself is served by
 * DownloadController.downloadRegulatoryDocument.
 */
public class RegulatoryProgramDocument {

    private int documentId;
    private int programId;
    private String label;
    private String fileName;
    private int displayOrder;

    public int getDocumentId() {
        return documentId;
    }

    public void setDocumentId(int documentId) {
        this.documentId = documentId;
    }

    public int getProgramId() {
        return programId;
    }

    public void setProgramId(int programId) {
        this.programId = programId;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public int getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(int displayOrder) {
        this.displayOrder = displayOrder;
    }
}

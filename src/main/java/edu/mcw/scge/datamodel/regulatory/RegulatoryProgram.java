package edu.mcw.scge.datamodel.regulatory;

import java.util.ArrayList;
import java.util.List;

/**
 * One SCGE program: a row of the Gantt table on the Shared Regulatory
 * Documents page, and a block in that page's sidebar.
 */
public class RegulatoryProgram {

    private int programId;
    private int diseaseAreaId;
    /** Stable short key; the expand/collapse DOM ids are built from it. */
    private String slug;
    private String programName;
    private String sidebarName;
    private String programUrl;
    /** Progress bar width as a percentage of the five phase columns. */
    private int timelineWidthPct;
    private int displayOrder;

    private List<RegulatoryProgramDocument> documents = new ArrayList<>();
    private List<RegulatoryPublication> publications = new ArrayList<>();

    public int getProgramId() {
        return programId;
    }

    public void setProgramId(int programId) {
        this.programId = programId;
    }

    public int getDiseaseAreaId() {
        return diseaseAreaId;
    }

    public void setDiseaseAreaId(int diseaseAreaId) {
        this.diseaseAreaId = diseaseAreaId;
    }

    public String getSlug() {
        return slug;
    }

    public void setSlug(String slug) {
        this.slug = slug;
    }

    public String getProgramName() {
        return programName;
    }

    public void setProgramName(String programName) {
        this.programName = programName;
    }

    /** Sidebar heading; the program name stands in when none was curated. */
    public String getSidebarName() {
        return (sidebarName == null || sidebarName.trim().isEmpty()) ? programName : sidebarName;
    }

    public void setSidebarName(String sidebarName) {
        this.sidebarName = sidebarName;
    }

    public String getProgramUrl() {
        return programUrl;
    }

    public void setProgramUrl(String programUrl) {
        this.programUrl = programUrl;
    }

    public int getTimelineWidthPct() {
        return timelineWidthPct;
    }

    public void setTimelineWidthPct(int timelineWidthPct) {
        this.timelineWidthPct = timelineWidthPct;
    }

    public int getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(int displayOrder) {
        this.displayOrder = displayOrder;
    }

    public List<RegulatoryProgramDocument> getDocuments() {
        return documents;
    }

    public void setDocuments(List<RegulatoryProgramDocument> documents) {
        this.documents = documents;
    }

    public List<RegulatoryPublication> getPublications() {
        return publications;
    }

    public void setPublications(List<RegulatoryPublication> publications) {
        this.publications = publications;
    }

    public boolean hasDocuments() {
        return documents != null && !documents.isEmpty();
    }

    public boolean hasPublications() {
        return publications != null && !publications.isEmpty();
    }

    /**
     * A program with nothing to show is listed in the Gantt table (its timeline
     * still says where it has got to) but kept out of the sidebar, which exists
     * purely to reach documents and publications.
     */
    public boolean isListedInSidebar() {
        return hasDocuments() || hasPublications();
    }

    /** DOM id of the expandable publications row, e.g. "pku-publications". */
    public String getPublicationsRowId() {
        return slug + "-publications";
    }

    /** DOM id of the expandable documents row, e.g. "pku-documents". */
    public String getDocumentsRowId() {
        return slug + "-documents";
    }

    /** DOM id of the sidebar's collapsible publications panel. */
    public String getSidebarPublicationsId() {
        return "sidebar-" + slug + "-pubs";
    }
}

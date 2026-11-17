package edu.mcw.scge.datamodel.regulatory;

/**
 * One publication cited by the Shared Regulatory Documents page.
 *
 * Held independently of the program that cites it because the same paper is
 * listed under more than one program; see regulatory_program_publication.
 */
public class RegulatoryPublication {

    private int publicationId;
    private String title;
    private String url;
    /** Null for the entries that were listed without a year. */
    private Integer publicationYear;

    public int getPublicationId() {
        return publicationId;
    }

    public void setPublicationId(int publicationId) {
        this.publicationId = publicationId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Integer getPublicationYear() {
        return publicationYear;
    }

    public void setPublicationYear(Integer publicationYear) {
        this.publicationYear = publicationYear;
    }

    /** Title with the year appended the way the page shows it: "Title (2025)". */
    public String getDisplayTitle() {
        return publicationYear == null ? title : title + " (" + publicationYear + ")";
    }
}

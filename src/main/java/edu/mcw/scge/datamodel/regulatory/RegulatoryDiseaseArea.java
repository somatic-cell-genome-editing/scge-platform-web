package edu.mcw.scge.datamodel.regulatory;

import java.util.ArrayList;
import java.util.List;

/**
 * A group of programs sharing one icon-and-label cell down the left of the
 * Gantt table on the Shared Regulatory Documents page.
 */
public class RegulatoryDiseaseArea {

    private int diseaseAreaId;
    private String name;
    /** Font Awesome class, when the area is drawn with a glyph. */
    private String iconClass;
    /** Webapp-relative image path, when the area is drawn with an image. */
    private String iconImage;
    /** Colour treatment for the circular icon, defined in regulatoryDocuments.css. */
    private String cssClass;
    private int displayOrder;

    private List<RegulatoryProgram> programs = new ArrayList<>();

    public int getDiseaseAreaId() {
        return diseaseAreaId;
    }

    public void setDiseaseAreaId(int diseaseAreaId) {
        this.diseaseAreaId = diseaseAreaId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIconClass() {
        return iconClass;
    }

    public void setIconClass(String iconClass) {
        this.iconClass = iconClass;
    }

    public String getIconImage() {
        return iconImage;
    }

    public void setIconImage(String iconImage) {
        this.iconImage = iconImage;
    }

    public String getCssClass() {
        return cssClass;
    }

    public void setCssClass(String cssClass) {
        this.cssClass = cssClass;
    }

    public int getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(int displayOrder) {
        this.displayOrder = displayOrder;
    }

    public List<RegulatoryProgram> getPrograms() {
        return programs;
    }

    public void setPrograms(List<RegulatoryProgram> programs) {
        this.programs = programs;
    }

    public boolean hasIconImage() {
        return iconImage != null && !iconImage.trim().isEmpty();
    }

    /**
     * Rows the area's icon cell spans: one per program. The page script bumps
     * this as panels are opened, so it is only the starting value.
     */
    public int getRowSpan() {
        return programs == null ? 1 : Math.max(programs.size(), 1);
    }
}

package edu.mcw.scge.service.regulatory;

import edu.mcw.scge.dao.AbstractDAO;
import edu.mcw.scge.datamodel.regulatory.RegulatoryDiseaseArea;
import edu.mcw.scge.datamodel.regulatory.RegulatoryProgram;
import edu.mcw.scge.datamodel.regulatory.RegulatoryProgramDocument;
import edu.mcw.scge.datamodel.regulatory.RegulatoryPublication;
import org.springframework.jdbc.object.MappingSqlQuery;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

/**
 * Reads the content behind the Shared Regulatory Documents page.
 *
 * Lives in the web project rather than scge-platform-core so that curating a
 * new program or document does not require rebuilding and redeploying the core
 * artifact; it extends core's AbstractDAO for the shared datasource handling.
 */
public class RegulatoryDocumentsDAO extends AbstractDAO {

    public List<RegulatoryDiseaseArea> getDiseaseAreas() throws Exception {
        String sql = "select * from regulatory_disease_area order by display_order, name";
        return new DiseaseAreaQuery(this.getDataSource(), sql).execute();
    }

    public List<RegulatoryProgram> getPrograms() throws Exception {
        String sql = "select * from regulatory_program"
                + " order by disease_area_id, display_order, program_name";
        return new ProgramQuery(this.getDataSource(), sql).execute();
    }

    public List<RegulatoryProgramDocument> getDocuments() throws Exception {
        String sql = "select * from regulatory_program_document"
                + " order by program_id, display_order, label";
        return new DocumentQuery(this.getDataSource(), sql).execute();
    }

    /**
     * Every program/publication pairing, flattened. The program_id rides along
     * on the publication object so one query can fill every program's list -
     * see {@link ProgramPublication}.
     */
    public List<ProgramPublication> getProgramPublications() throws Exception {
        String sql = "select pp.program_id, pp.display_order, p.*"
                + " from regulatory_program_publication pp"
                + " join regulatory_publication p on p.publication_id = pp.publication_id"
                + " order by pp.program_id, pp.display_order, p.title";
        return new ProgramPublicationQuery(this.getDataSource(), sql).execute();
    }

    /** A publication together with the program that cites it. */
    public static class ProgramPublication {
        private final int programId;
        private final RegulatoryPublication publication;

        public ProgramPublication(int programId, RegulatoryPublication publication) {
            this.programId = programId;
            this.publication = publication;
        }

        public int getProgramId() {
            return programId;
        }

        public RegulatoryPublication getPublication() {
            return publication;
        }
    }

    private static class DiseaseAreaQuery extends MappingSqlQuery<RegulatoryDiseaseArea> {
        DiseaseAreaQuery(DataSource ds, String sql) {
            super(ds, sql);
        }

        @Override
        protected RegulatoryDiseaseArea mapRow(ResultSet rs, int rowNum) throws SQLException {
            RegulatoryDiseaseArea area = new RegulatoryDiseaseArea();
            area.setDiseaseAreaId(rs.getInt("disease_area_id"));
            area.setName(rs.getString("name"));
            area.setIconClass(rs.getString("icon_class"));
            area.setIconImage(rs.getString("icon_image"));
            area.setCssClass(rs.getString("css_class"));
            area.setDisplayOrder(rs.getInt("display_order"));
            return area;
        }
    }

    private static class ProgramQuery extends MappingSqlQuery<RegulatoryProgram> {
        ProgramQuery(DataSource ds, String sql) {
            super(ds, sql);
        }

        @Override
        protected RegulatoryProgram mapRow(ResultSet rs, int rowNum) throws SQLException {
            RegulatoryProgram program = new RegulatoryProgram();
            program.setProgramId(rs.getInt("program_id"));
            program.setDiseaseAreaId(rs.getInt("disease_area_id"));
            program.setSlug(rs.getString("slug"));
            program.setProgramName(rs.getString("program_name"));
            program.setSidebarName(rs.getString("sidebar_name"));
            program.setProgramUrl(rs.getString("program_url"));
            program.setTimelineWidthPct(rs.getInt("timeline_width_pct"));
            program.setDisplayOrder(rs.getInt("display_order"));
            return program;
        }
    }

    private static class DocumentQuery extends MappingSqlQuery<RegulatoryProgramDocument> {
        DocumentQuery(DataSource ds, String sql) {
            super(ds, sql);
        }

        @Override
        protected RegulatoryProgramDocument mapRow(ResultSet rs, int rowNum) throws SQLException {
            RegulatoryProgramDocument document = new RegulatoryProgramDocument();
            document.setDocumentId(rs.getInt("document_id"));
            document.setProgramId(rs.getInt("program_id"));
            document.setLabel(rs.getString("label"));
            document.setFileName(rs.getString("file_name"));
            document.setDisplayOrder(rs.getInt("display_order"));
            return document;
        }
    }

    private static class ProgramPublicationQuery extends MappingSqlQuery<ProgramPublication> {
        ProgramPublicationQuery(DataSource ds, String sql) {
            super(ds, sql);
        }

        @Override
        protected ProgramPublication mapRow(ResultSet rs, int rowNum) throws SQLException {
            RegulatoryPublication publication = new RegulatoryPublication();
            publication.setPublicationId(rs.getInt("publication_id"));
            publication.setTitle(rs.getString("title"));
            publication.setUrl(rs.getString("url"));
            int year = rs.getInt("publication_year");
            publication.setPublicationYear(rs.wasNull() ? null : year);
            return new ProgramPublication(rs.getInt("program_id"), publication);
        }
    }
}

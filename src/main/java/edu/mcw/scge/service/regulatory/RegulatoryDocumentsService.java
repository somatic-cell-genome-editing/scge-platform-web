package edu.mcw.scge.service.regulatory;

import edu.mcw.scge.datamodel.regulatory.RegulatoryDiseaseArea;
import edu.mcw.scge.datamodel.regulatory.RegulatoryProgram;
import edu.mcw.scge.datamodel.regulatory.RegulatoryProgramDocument;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Builds the object graph the Shared Regulatory Documents page renders:
 * disease areas, each holding its programs, each holding its documents and
 * publications.
 *
 * Four flat queries stitched together in memory rather than a query per
 * program - the whole page is a few dozen rows, and it keeps the number of
 * round trips constant as programs are added.
 */
public class RegulatoryDocumentsService {

    private final RegulatoryDocumentsDAO dao = new RegulatoryDocumentsDAO();

    public List<RegulatoryDiseaseArea> getPageContent() throws Exception {
        List<RegulatoryDiseaseArea> areas = dao.getDiseaseAreas();
        List<RegulatoryProgram> programs = dao.getPrograms();

        Map<Integer, RegulatoryProgram> programsById = new LinkedHashMap<>();
        for (RegulatoryProgram program : programs) {
            programsById.put(program.getProgramId(), program);
        }

        for (RegulatoryProgramDocument document : dao.getDocuments()) {
            RegulatoryProgram program = programsById.get(document.getProgramId());
            if (program != null) {
                program.getDocuments().add(document);
            }
        }

        for (RegulatoryDocumentsDAO.ProgramPublication link : dao.getProgramPublications()) {
            RegulatoryProgram program = programsById.get(link.getProgramId());
            if (program != null) {
                program.getPublications().add(link.getPublication());
            }
        }

        Map<Integer, RegulatoryDiseaseArea> areasById = new LinkedHashMap<>();
        for (RegulatoryDiseaseArea area : areas) {
            areasById.put(area.getDiseaseAreaId(), area);
        }
        for (RegulatoryProgram program : programs) {
            RegulatoryDiseaseArea area = areasById.get(program.getDiseaseAreaId());
            if (area != null) {
                area.getPrograms().add(program);
            }
        }

        // An area with no programs would render an icon cell spanning nothing.
        List<RegulatoryDiseaseArea> populated = new ArrayList<>();
        for (RegulatoryDiseaseArea area : areas) {
            if (!area.getPrograms().isEmpty()) {
                populated.add(area);
            }
        }
        return populated;
    }
}

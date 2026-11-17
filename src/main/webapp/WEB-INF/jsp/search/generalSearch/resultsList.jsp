<%@ page import="java.util.stream.Collectors" %>
<%--
  One card per hit, laid out according to the hit's category. Unknown
  categories fall through to a generic card so a category indexed later shows
  up as a readable result instead of an empty row.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="results-list-view gs-list">
<%
    for (Hit<Map> hit : hits) {
        Map<String, Object> source = (Map<String, Object>) hit.source();
        if (source == null) {
            continue;
        }
        String hitCategory = raw(source.get("category"));

        // The highlighter returns the matching passage of a document's text,
        // HTML-escaped by Elasticsearch with only its own <em> markers left.
        String snippet = "";
        if (hit.highlight() != null && hit.highlight().get("content") != null
                && !hit.highlight().get("content").isEmpty()) {
            snippet = hit.highlight().get("content").get(0);
        }

        if (hitCategory.equalsIgnoreCase("RegulatoryDocument")) {
            String title = raw(source.get("title"));
            String documentName = raw(source.get("documentName"));
            if (title.isEmpty()) {
                title = documentName;
            }
            String program = raw(source.get("program"));
            String documentType = raw(source.get("documentType"));
            String pageCount = raw(source.get("pageCount"));
            String fileSize = formatFileSize(source.get("fileSize"));
            String lastModified = formatDate(source.get("lastModifiedDate"));
            boolean redacted = Boolean.parseBoolean(raw(source.get("redacted")));
            String downloadUrl = raw(source.get("downloadUrl"));
            if (downloadUrl.isEmpty() && !documentName.isEmpty()) {
                // Older documents were indexed before downloadUrl was added.
                downloadUrl = "/platform/public/download/regulatory?documentName=" + urlEnc(documentName);
            }
            List<String> tags = source.get("tags") != null
                    ? (List<String>) source.get("tags") : new ArrayList<>();
%>
    <div class="list-view-card gs-card gs-card-document">
        <div class="list-view-header">
            <div class="list-view-title">
                <% if (!downloadUrl.isEmpty()) { %>
                <a href="<%=downloadUrl%>" target="_blank" class="list-view-nct-link"><%=esc(title)%></a>
                <% } else { %>
                <span class="list-view-nct-link"><%=esc(title)%></span>
                <% } %>
                <span class="gs-badge gs-badge-category">Regulatory Document</span>
                <% if (!program.isEmpty()) { %><span class="gs-badge gs-badge-program"><%=esc(program)%></span><% } %>
                <% if (!documentType.isEmpty()) { %><span class="gs-badge"><%=esc(documentType)%></span><% } %>
                <% if (redacted) { %><span class="gs-badge gs-badge-redacted">Redacted</span><% } %>
            </div>
            <% if (!downloadUrl.isEmpty()) { %>
            <div class="list-view-actions">
                <a href="<%=downloadUrl%>" target="_blank" class="btn btn-sm btn-primary">Open Document</a>
            </div>
            <% } %>
        </div>

        <% if (!snippet.isEmpty()) { %>
        <div class="gs-snippet">&hellip;<%=snippet%>&hellip;</div>
        <% } %>

        <% if (!tags.isEmpty()) { %>
        <div class="gs-tags">
            <% for (String tag : tags) { %><span class="gs-tag"><%=esc(tag)%></span><% } %>
        </div>
        <% } %>

        <div class="list-view-footer">
            <div class="list-view-meta">
                <% if (!documentName.isEmpty()) { %>
                <span><i class="fa fa-file-text-o"></i> <%=esc(documentName)%></span>
                <% } %>
                <% if (!pageCount.isEmpty()) { %>
                <span><i class="fa fa-files-o"></i> <%=esc(pageCount)%> pages</span>
                <% } %>
                <% if (!fileSize.isEmpty()) { %>
                <span><i class="fa fa-download"></i> <%=esc(fileSize)%></span>
                <% } %>
                <% if (!lastModified.isEmpty()) { %>
                <span><i class="fa fa-refresh"></i> Last Modified: <%=esc(lastModified)%></span>
                <% } %>
            </div>
        </div>
    </div>
<%
        } else if (hitCategory.equalsIgnoreCase("ClinicalTrial")) {
            String nctId = raw(source.get("nctId"));
            String indication = raw(source.get("indication"));
            String sponsor = raw(source.get("sponsor"));
            String sponsorClass = raw(source.get("sponsorClass"));
            String compoundName = raw(source.get("compoundName"));
            String therapyType = raw(source.get("therapyType"));
            String targetGene = raw(source.get("targetGeneOrVariant"));

            List<String> phases = source.get("phases") != null
                    ? (List<String>) source.get("phases") : new ArrayList<>();
            String phase = phases.stream().collect(Collectors.joining(", "));

            List<String> statuses = source.get("status") != null
                    ? (List<String>) source.get("status") : new ArrayList<>();
            String status = statuses.isEmpty() ? "" : statuses.get(0);

            List<String> locationsList = source.get("locations") != null
                    ? (List<String>) source.get("locations") : new ArrayList<>();
            String locations = locationsList.stream().limit(3).collect(Collectors.joining(", "));
            if (locationsList.size() > 3) {
                locations += " + " + (locationsList.size() - 3) + " more";
            }
%>
    <div class="list-view-card gs-card gs-card-trial">
        <div class="list-view-header">
            <div class="list-view-title">
                <a href="/platform/data/report/clinicalTrials/<%=urlEnc(nctId)%>" target="_blank" class="list-view-nct-link"><%=esc(nctId)%></a>
                <span class="gs-badge gs-badge-category">Clinical Trial</span>
                <% if (!status.isEmpty()) { %>
                <span class="list-view-status status-<%=status.toLowerCase().replace(" ", "-").replace(",", "")%>"><%=esc(status)%></span>
                <% } %>
                <% if (!phase.isEmpty()) { %><span class="list-view-phase"><%=esc(phase)%></span><% } %>
            </div>
            <div class="list-view-actions">
                <a href="/platform/data/report/clinicalTrials/<%=urlEnc(nctId)%>" target="_blank" class="btn btn-sm btn-primary">View Report</a>
            </div>
        </div>

        <% if (!indication.isEmpty()) { %>
        <div class="list-view-indication"><%=esc(indication)%></div>
        <% } %>

        <div class="list-view-body">
            <div class="list-view-row">
                <% if (!sponsor.isEmpty()) { %>
                <div class="list-view-field">
                    <span class="list-view-label">Sponsor</span>
                    <span class="list-view-value"><%=esc(sponsor)%><% if (!sponsorClass.isEmpty()) { %> <small>(<%=esc(sponsorClass)%>)</small><% } %></span>
                </div>
                <% } %>
                <% if (!compoundName.isEmpty()) { %>
                <div class="list-view-field">
                    <span class="list-view-label">Compound</span>
                    <span class="list-view-value"><%=esc(compoundName)%></span>
                </div>
                <% } %>
                <% if (!therapyType.isEmpty()) { %>
                <div class="list-view-field">
                    <span class="list-view-label">Therapeutic Modality</span>
                    <span class="list-view-value"><%=esc(therapyType)%></span>
                </div>
                <% } %>
                <% if (!targetGene.isEmpty()) { %>
                <div class="list-view-field">
                    <span class="list-view-label">Target Gene</span>
                    <span class="list-view-value"><%=esc(targetGene)%></span>
                </div>
                <% } %>
            </div>
        </div>

        <% if (!locations.isEmpty()) { %>
        <div class="list-view-footer">
            <div class="list-view-meta">
                <span><i class="fa fa-map-marker"></i> <%=esc(locations)%></span>
            </div>
        </div>
        <% } %>
    </div>
<%
        } else {
            // A category the index carries but this page has no layout for yet.
            String title = raw(source.get("title"));
            if (title.isEmpty()) title = raw(source.get("documentName"));
            if (title.isEmpty()) title = raw(source.get("nctId"));
            if (title.isEmpty()) title = hit.id();
%>
    <div class="list-view-card gs-card">
        <div class="list-view-header">
            <div class="list-view-title">
                <span class="list-view-nct-link"><%=esc(title)%></span>
                <% if (!hitCategory.isEmpty()) { %>
                <span class="gs-badge gs-badge-category"><%=esc(ClinicalTrialsService.categoryDisplayName(hitCategory))%></span>
                <% } %>
            </div>
        </div>
        <% if (!snippet.isEmpty()) { %>
        <div class="gs-snippet">&hellip;<%=snippet%>&hellip;</div>
        <% } %>
    </div>
<%
        }
    }
%>
</div>

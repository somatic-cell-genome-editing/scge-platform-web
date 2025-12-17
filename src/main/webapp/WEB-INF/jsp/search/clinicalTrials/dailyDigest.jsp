<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 12/16/2025
  Time: 4:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Get digest hits from controller (already filtered and sorted)
    SearchHit[] digestHitsArray = (SearchHit[]) request.getAttribute("digestHits");
    List<Map<String, Object>> recentUpdates = new ArrayList<>();

    if(digestHitsArray != null) {
        for(SearchHit hit : digestHitsArray) {
            recentUpdates.add(hit.getSourceAsMap());
        }
    }

    int maxDigestItems = recentUpdates.size(); // Already limited to 5 in the query
%>
<% if(maxDigestItems > 0) { %>
<div class="daily-digest-card">
    <div class="digest-header" onclick="toggleDigest()" style="cursor: pointer;">
        <i class="fa fa-newspaper-o"></i>
        <h4>Clinical Trials Daily Digest</h4>
        <span class="digest-badge"><%=maxDigestItems%> Recent Update<%=maxDigestItems > 1 ? "s" : ""%></span>
        <span class="digest-toggle"><i id="digestToggleIcon" class="fa fa-chevron-down"></i></span>
    </div>
    <div id="digestContent" class="digest-collapsible collapsed">
        <p class="digest-subtitle">Clinical trials with updates in the last 7 days</p>
        <div class="digest-items">
            <%
                for(int i = 0; i < maxDigestItems; i++) {
                    Map<String, Object> item = recentUpdates.get(i);
                    String nctId = item.get("nctId") != null ? item.get("nctId").toString() : "";
                    String indication = item.get("indication") != null ? item.get("indication").toString() : "N/A";
                    String sponsor = item.get("sponsor") != null ? item.get("sponsor").toString() : "N/A";
                    String updateDate = item.get("recordModifiedDate") != null ? item.get("recordModifiedDate").toString() : "";
                    String recentUpdateNote = item.get("recentUpdates") != null ? item.get("recentUpdates").toString() : "";
                    List<String> statusList = item.get("status") != null ? (List<String>) item.get("status") : new ArrayList<>();
                    String status = statusList.size() > 0 ? statusList.get(0) : "N/A";
                    List<ClinicalTrialFieldChange> updatedFields=null;
                    try {
                        updatedFields=clinicalTrailDAO.getFieldChangesByNctId(nctId);

                    } catch (Exception e) {
                        throw new RuntimeException(e);
                    }

            %>
            <div class="digest-item" style="overflow: auto">
                <div class="digest-item-header">
                    <a href="/platform/data/report/clinicalTrials/<%=nctId%>" target="_blank" class="digest-nct-link"><%=nctId%></a>
                    <span class="digest-date"><i class="fa fa-calendar"></i> <%=updateDate%></span>
                </div>
                <div class="digest-item-body">
                    <div class="digest-indication" title="<%=indication%>"><%=indication.length() > 80 ? indication.substring(0, 80) + "..." : indication%></div>
                    <div class="digest-meta">
                        <span class="digest-sponsor"><i class="fa fa-building"></i> <%=sponsor%></span>
                        <span class="digest-status status-<%=status.toLowerCase().replace(" ", "-")%>"><%=status%></span>
                    </div>
                    <%
                        if(updatedFields!=null && updatedFields.size()>0){
                            // Filter out last_update_post_date entries
                            List<ClinicalTrialFieldChange> filteredUpdates = new ArrayList<>();
                            for(ClinicalTrialFieldChange update : updatedFields) {
                                if(!update.getFieldName().equalsIgnoreCase("last_update_post_date")) {
                                    filteredUpdates.add(update);
                                }
                            }
                            if(filteredUpdates.size() > 0) {
                    %>
                    <div class="digest-updates-section">
                        <div class="digest-updates-header">
                            <i class="fa fa-pencil-square-o"></i> Field Updates
                        </div>
                        <div class="digest-updates-list">
                            <% for(ClinicalTrialFieldChange update : filteredUpdates) { %>
                            <div class="digest-update-item">
                                <span class="digest-field-name"><%=update.getFieldName()%></span>
                                <span class="digest-field-change">
                                    <span class="digest-old-value" title="<%=update.getOldValue()%>"><%=update.getOldValue() != null && update.getOldValue().length() > 50 ? update.getOldValue().substring(0, 50) + "..." : update.getOldValue()%></span>
                                    <i class="fa fa-arrow-right"></i>
                                    <span class="digest-new-value" title="<%=update.getNewValue()%>"><%=update.getNewValue() != null && update.getNewValue().length() > 50 ? update.getNewValue().substring(0, 50) + "..." : update.getNewValue()%></span>
                                </span>
                                <span class="digest-update-by"><%=update.getUpdateBy()%></span>
                            </div>
                            <% } %>
                        </div>
                    </div>
                    <% }} %>
                    <% if(recentUpdateNote != null && !recentUpdateNote.isEmpty() && !recentUpdateNote.equals("null")) { %>
                    <div class="digest-update-note"><i class="fa fa-info-circle"></i> <%=recentUpdateNote.length() > 150 ? recentUpdateNote.substring(0, 150) + "..." : recentUpdateNote%></div>
                    <% } %>
                </div>
            </div>
            <% } %>
        </div>
        <% if(recentUpdates.size() > 5) { %>
        <div class="digest-footer">
            <span class="digest-more-info"><i class="fa fa-info-circle"></i> <%=recentUpdates.size() - 5%> more trial(s) updated recently. Use filters or search to find them.</span>
        </div>
        <% } %>
    </div><!-- end digestContent -->
</div>
<script>
    function toggleDigest() {
        var content = document.getElementById('digestContent');
        var icon = document.getElementById('digestToggleIcon');
        if (content.classList.contains('collapsed')) {
            content.classList.remove('collapsed');
            icon.classList.remove('fa-chevron-down');
            icon.classList.add('fa-chevron-up');
        } else {
            content.classList.add('collapsed');
            icon.classList.remove('fa-chevron-up');
            icon.classList.add('fa-chevron-down');
        }
    }
</script>
<% } %>

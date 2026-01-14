<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 12/16/2025
  Time: 4:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    int displayLimit = 5;
    int maxDigestItems = Math.min(totalUpdates, displayLimit);
%>
<% if(totalUpdates > 0) { %>
<div class="daily-digest-sidebar">
    <div class="digest-sidebar-header">
        <i class="fa fa-newspaper-o"></i>
        <h4>Clinical Trials Daily Digest</h4>
        <span class="digest-badge"><%=totalUpdates%> Update<%=totalUpdates > 1 ? "s" : ""%></span>
    </div>
    <p class="digest-subtitle">Updates in the last 7 days</p>
    <div class="digest-sidebar-content">
        <div class="digest-items">
            <%
                for(int i = 0; i < maxDigestItems; i++) {
                    Map<String, Object> item = recentUpdates.get(i);
                    String nctId = item.get("nctId") != null ? item.get("nctId").toString() : "";
                    String indication = item.get("indication") != null ? item.get("indication").toString() : "N/A";
                    String sponsor = item.get("sponsor") != null ? item.get("sponsor").toString() : "N/A";
                    String updateDate = item.get("recordModifiedDate") != null ? item.get("recordModifiedDate").toString() : "";
                    String creationDate = item.get("recordCreationDate") != null ? item.get("recordCreationDate").toString() : "";
                    boolean isNew = !creationDate.isEmpty() && creationDate.equals(updateDate);
                    String recentUpdateNote = item.get("recentUpdates") != null ? item.get("recentUpdates").toString() : "";
                    List<String> statusList = item.get("status") != null ? (List<String>) item.get("status") : new ArrayList<>();
                    String status = statusList.size() > 0 ? statusList.get(0) : "N/A";
                    List<ClinicalTrialFieldChange> updatedFields=null;
                    List<ClinicalTrialFieldChange> filteredUpdates = new ArrayList<>();
                    try {
                        updatedFields=clinicalTrailDAO.getFieldChangesByNctId(nctId);
                        if(updatedFields!=null && updatedFields.size()>0){
                            for(ClinicalTrialFieldChange update : updatedFields) {
                              //  if(!update.getFieldName().equalsIgnoreCase("last_update_post_date")) {
                                    filteredUpdates.add(update);
                             //   }
                            }
                        }
                    } catch (Exception e) {
                        throw new RuntimeException(e);
                    }

            %>
            <div class="digest-item">
                <div class="digest-item-header">
                    <span class="digest-nct-wrapper">
                        <a href="/platform/data/report/clinicalTrials/<%=nctId%>" target="_blank" class="digest-nct-link"><%=nctId%></a><% if(isNew) { %><span class="digest-new-badge">NEW</span><% } %>
                        <% if(filteredUpdates.size() > 0) { %>
                        <div class="digest-updates-section">
                            <div class="digest-updates-header" onclick="toggleUpdatesPopover(event, this)">
                                <span title="View Updates"><i class="fa fa-pencil-square-o"></i> </span>
                                <div class="digest-updates-tooltip">
                                    <% for(ClinicalTrialFieldChange update : filteredUpdates) { %>
                                    <div class="digest-update-item">
                                        <span class="digest-field-name"><%=StringUtils.capitalize(update.getFieldName().toLowerCase().trim().replaceAll("_", " "))%></span>
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
                        </div>
                        <% } %>
                    </span>
                    <span class="digest-date"><i class="fa fa-calendar"></i> <%=updateDate%></span>
                </div>
                <div class="digest-item-body">
                    <div class="digest-indication" title="<%=indication%>"><%=indication.length() > 80 ? indication.substring(0, 80) + "..." : indication%></div>
                    <div class="digest-meta">
                        <span class="digest-sponsor"><i class="fa fa-building"></i> <%=sponsor%></span>
                        <span class="digest-status status-<%=status.toLowerCase().replace(" ", "-")%>"><%=status%></span>
                    </div>
                    <% if(recentUpdateNote != null && !recentUpdateNote.isEmpty() && !recentUpdateNote.equals("null")) { %>
                    <div class="digest-update-note"><i class="fa fa-info-circle"></i> <%=recentUpdateNote.length() > 150 ? recentUpdateNote.substring(0, 150) + "..." : recentUpdateNote%></div>
                    <% } %>
                </div>
            </div>
            <% } %>
        </div>
        <% if(totalUpdates > displayLimit) { %>
        <div class="digest-footer">
            <span class="digest-more-info"><i class="fa fa-info-circle"></i> <%=totalUpdates - displayLimit%> more update(s) recently</span>
        </div>
        <% } %>
    </div><!-- end digest-sidebar-content -->
</div>
<script>
    function toggleUpdatesPopover(event, element) {
        event.stopPropagation();
        // Close all other open popovers
        document.querySelectorAll('.digest-updates-header.active').forEach(function(el) {
            if (el !== element) {
                el.classList.remove('active');
            }
        });
        // Toggle this popover
        var isActive = element.classList.toggle('active');

        // Position the tooltip if active
        if (isActive) {
            var tooltip = element.querySelector('.digest-updates-tooltip');
            if (tooltip) {
                var rect = element.getBoundingClientRect();
                var tooltipWidth = 550; // max-width from CSS

                // Position below the button, aligned to the right edge
                tooltip.style.top = (rect.bottom + 8) + 'px';
                tooltip.style.right = (window.innerWidth - rect.right) + 'px';
                tooltip.style.left = 'auto';

                // Check if tooltip goes off left edge of screen
                var tooltipRect = tooltip.getBoundingClientRect();
                if (tooltipRect.left < 10) {
                    tooltip.style.right = 'auto';
                    tooltip.style.left = '10px';
                }
            }
        }
    }

    // Close popover when clicking outside
    document.addEventListener('click', function(event) {
        if (!event.target.closest('.digest-updates-header')) {
            document.querySelectorAll('.digest-updates-header.active').forEach(function(el) {
                el.classList.remove('active');
            });
        }
    });
</script>
<% } %>

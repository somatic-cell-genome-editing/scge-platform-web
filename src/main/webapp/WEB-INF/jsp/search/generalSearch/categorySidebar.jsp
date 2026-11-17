<%--
  Category sidebar for the general search results.

  The counts come from an aggregation that deliberately ignores the category
  currently selected, so every category the search term reaches stays listed
  and the visitor can switch between them rather than being stranded in one.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String categoryBaseUrl = "/platform/data/search/?searchTerm=" + urlEnc(searchTerm);
    if (pageSize != 100) {
        categoryBaseUrl += "&pageSize=" + pageSize;
    }
%>
<div class="gs-sidebar">
    <h4 class="gs-sidebar-title"><i class="fa fa-folder-open-o"></i>&nbsp;Categories</h4>
    <ul class="gs-category-list">
        <li class="gs-category-item <%=selectedCategory.isEmpty() ? "active" : ""%>">
            <a href="<%=categoryBaseUrl%>">
                <span class="gs-category-name">All Results</span>
                <span class="gs-category-count"><%=allCategoriesCount%></span>
            </a>
        </li>
        <%
            for (Map.Entry<String, Long> entry : categoryCounts.entrySet()) {
                String categoryKey = entry.getKey();
                boolean isSelected = categoryKey.equalsIgnoreCase(selectedCategory);
        %>
        <li class="gs-category-item <%=isSelected ? "active" : ""%>">
            <a href="<%=categoryBaseUrl%>&category=<%=urlEnc(categoryKey)%>">
                <span class="gs-category-name"><%=esc(ClinicalTrialsService.categoryDisplayName(categoryKey))%></span>
                <span class="gs-category-count"><%=entry.getValue()%></span>
            </a>
        </li>
        <% } %>
        <% if (categoryCounts.isEmpty()) { %>
        <li class="gs-category-empty">No categories matched this search.</li>
        <% } %>
    </ul>

    <%-- Each category that has a browse page of its own gets a link to it. --%>
    <div class="gs-sidebar-links">
        <h5 class="gs-sidebar-subtitle">Browse</h5>
        <a href="/platform/data/search/ClinicalTrial">Gene Therapy Trial Browser</a>
        <a href="/platform/public/documents/regulatory">Shared Regulatory Documents</a>
    </div>
</div>

<%--
  Search box for the general results page. Keeps the visitor on this page and
  preserves the category they are narrowed to, so re-searching inside
  "Regulatory Documents" stays inside Regulatory Documents.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
  $(function () {
    $("#generalSearchTerm").autocomplete({
      source: function (request, response) {
        $.ajax({
          url: "/platform/data/search/autocomplete",
          type: "GET",
          data: {searchTerm: request.term},
          max: 100,
          dataType: "json",
          success: function (data) {
            response(data)
          }
        });
      }
    })
    .autocomplete("instance")._renderItem = function (ul, item) {
      return $("<li>")
              .attr("data-value", item.value.replace("<strong>").replace("</strong>"))
              .append("<div>" + item.label + "</div>")
              .appendTo(ul);
    };
    $("#generalSearchTerm").on("autocompleteclose", function () {
      $(this).val(stripHTML($(this).val()))
    });
  })
</script>
<form id="generalSearchForm" class="form-inline" action="/platform/data/search/">
  <input type="hidden" name="category" value="<%=esc(selectedCategory)%>">
  <div class="input-group md-form form-sm pl-0">
    <input class="form-control form-control-sm form-container-sm amber-border" id="generalSearchTerm"
           name="searchTerm" type="text" value="<%=esc(searchTerm)%>"
           placeholder="Search SCGE Platform.." aria-label="Search" required maxlength="100">
    <div class="input-group-append">
      <button class="input-group-text lighten-3 btn btn-light" id="basic-text-general" type="submit">
        <i class="fas fa-search text-grey" aria-hidden="true"></i>
      </button>
    </div>
  </div>
</form>

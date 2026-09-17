<%@ page import="edu.mcw.scge.datamodel.Definition" %>
<%@ page import="org.apache.commons.lang.StringUtils" %><%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 1/16/2025
  Time: 12:20 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    Map<String,List<Definition>> definitions=null;
    if(request.getAttribute("definitions")!=null)
            definitions= (Map<String, List<Definition>>) request.getAttribute("definitions");

    // Counts shown in the header subtitle / group badges.
    int dmTotalTerms=0, dmGroupCount=0;
    if(definitions!=null){
        for(String dmKey:definitions.keySet()){
            List<Definition> dmDefs=definitions.get(dmKey);
            if(dmDefs==null) continue;
            int dmValid=0;
            for(Definition dmD:dmDefs){
                if(dmD!=null && dmD.getDefinition()!=null && dmD.getTerm()!=null) dmValid++;
            }
            if(dmValid>0){ dmGroupCount++; dmTotalTerms+=dmValid; }
        }
    }
%>
<div class="modal fade" tabindex="-1" role="dialog" id="definitionsModal" aria-labelledby="definitionsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <div>
                    <h5 class="modal-title" id="definitionsModalLabel"><i class="fa fa-book" aria-hidden="true"></i>Glossary</h5>
                    <span class="dm-subtitle"><%=dmTotalTerms%> term<%=dmTotalTerms==1?"":"s"%> in <%=dmGroupCount%> categor<%=dmGroupCount==1?"y":"ies"%></span>
                </div>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="dm-toolbar">
                <div class="dm-search" id="dmSearchWrap">
                    <i class="fa fa-search" aria-hidden="true"></i>
                    <input type="text" id="dmSearchInput" placeholder="Search terms or definitions&hellip;" autocomplete="off" aria-label="Search glossary">
                    <button type="button" class="dm-clear" id="dmClearBtn" aria-label="Clear search">&times;</button>
                </div>
            </div>
            <div class="modal-body">
                <%
                    if(definitions!=null){
                        for(String key:definitions.keySet()){
                            List<Definition> defs=definitions.get(key);
                            if(defs==null) continue;
                            int dmSectionCount=0;
                            for(Definition d:defs){
                                if(d!=null && d.getDefinition()!=null && d.getTerm()!=null) dmSectionCount++;
                            }
                            if(dmSectionCount==0) continue;
                %>
                <section class="dm-group">
                    <h6 class="dm-group-title"><%=key%><span class="dm-count"><%=dmSectionCount%></span></h6>
                    <dl class="dm-list">
                        <%
                            for(Definition d:defs){
                                if(d!=null && d.getDefinition()!=null && d.getTerm()!=null){
                        %>
                        <div class="dm-item">
                            <dt><%=StringUtils.capitalize(d.getTerm())%></dt>
                            <dd><%=StringUtils.capitalize(d.getDefinition())%></dd>
                        </div>
                        <%}}%>
                    </dl>
                </section>
                <%}}%>
                <p class="dm-empty"><i class="fa fa-search" aria-hidden="true"></i>No terms match your search.</p>
            </div>
            <div class="modal-footer">
                <span class="dm-hint">Press <strong>Esc</strong> to close</span>
                <button type="button" class="btn btn-sm btn-primary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<script>
    (function () {
        var modal = document.getElementById('definitionsModal');
        if (!modal || modal.dataset.dmBound) return;
        modal.dataset.dmBound = '1';

        var wrap = modal.querySelector('#dmSearchWrap');
        var input = modal.querySelector('#dmSearchInput');
        var clearBtn = modal.querySelector('#dmClearBtn');
        var items = Array.prototype.slice.call(modal.querySelectorAll('.dm-item'));
        var groups = Array.prototype.slice.call(modal.querySelectorAll('.dm-group'));

        function filter() {
            var q = input.value.trim().toLowerCase();
            wrap.classList.toggle('has-value', q.length > 0);

            items.forEach(function (item) {
                var hit = !q || item.textContent.toLowerCase().indexOf(q) !== -1;
                item.classList.toggle('is-hidden', !hit);
            });

            var visible = 0;
            groups.forEach(function (group) {
                var shown = group.querySelectorAll('.dm-item:not(.is-hidden)').length;
                group.classList.toggle('is-hidden', shown === 0);
                visible += shown;
            });
            modal.classList.toggle('is-empty', visible === 0);
        }

        input.addEventListener('input', filter);
        clearBtn.addEventListener('click', function () {
            input.value = '';
            filter();
            input.focus();
        });

        // Reset + focus the search box each time the glossary opens.
        if (window.jQuery) {
            window.jQuery(modal).on('shown.bs.modal', function () {
                input.value = '';
                filter();
                input.focus();
            });
        }
    })();
</script>

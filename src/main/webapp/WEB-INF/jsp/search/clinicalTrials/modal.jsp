<%@ page import="edu.mcw.scge.datamodel.Definition" %>
<%@ page import="org.apache.commons.lang.StringUtils" %><%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 1/16/2025
  Time: 12:20 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Map<String,List<Definition>> definitions=null;
    if(request.getAttribute("definitions")!=null)
            definitions= (Map<String, List<Definition>>) request.getAttribute("definitions");

%>
<div class="modal " tabindex="-1" role="dialog" id="definitionsModal">
    <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Definitions</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <%
                    if(definitions!=null){
                        for(String key:definitions.keySet()){
                            List<Definition> defs=definitions.get(key);
                %>
                <h4><%=key%></h4>
                <table class="table  table-bordered table-responsive-sm">
                <%

                    for(Definition d:defs){
                        if(d!=null && d.getDefinition()!=null && d.getTerm()!=null){
                %>
                     <tr><td class="col-md-2"><%=StringUtils.capitalize(d.getTerm())%></td><td class="col-md"><%=StringUtils.capitalize(d.getDefinition())%></td></tr>
                    <%}}%>
                </table>
                <%}}%>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
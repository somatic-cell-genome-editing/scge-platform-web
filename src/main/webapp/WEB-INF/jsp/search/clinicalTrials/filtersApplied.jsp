<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 10/21/2024
  Time: 1:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%if(filtersSelected!=null && filtersSelected.size()>0) {
    if (filtersSelected.size() == 1 && filtersSelected.get(0).equalsIgnoreCase("Active")){

}else{
  boolean first=true;
%>
<strong>Remove Filters:</strong>

<%
  loop:  for(String filter: filtersSelected){
//  List<String> values=filterMap.get(key);
    if(filter.equalsIgnoreCase("Active") && (p==null || !access.isAdmin(p))){
        continue loop;
    }

    if(first){first=false;
%>
<%--&nbsp;<span style="color:darkorange; font-weight: bold"><%=filter%></span>--%>
<button class="btn btn-light btn-sm " value="<%=filter%>" onclick="removeFilter('\''+this.value+'\'')" ><%=filter%>&nbsp;<i class="fa fa-times-circle" style="font-size:15px;color:red" ></i></button>

  <% }else{%>
  <span style="font-weight: bold">&nbsp;|&nbsp;</span><button class="btn btn-light btn-sm " value="<%=filter%>" onclick="removeFilter('\''+this.value+'\'')" ><%=filter%>&nbsp;<i class="fa fa-times-circle" style="font-size:15px;color:red" ></i></button>

<% }
%>

<%}}}%>

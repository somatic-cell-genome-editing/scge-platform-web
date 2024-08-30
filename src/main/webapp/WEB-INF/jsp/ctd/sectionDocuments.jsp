<%@ page import="edu.mcw.scge.datamodel.Document" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %><%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 8/27/2024
  Time: 9:12 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%if(sectionDocuments!=null && !sectionCode.isEmpty()){
    List<Document> docs=sectionDocuments.get(sectionCode.trim());
    if(docs!=null && docs.size()>0){%>
<ul>
    <%

        for(Document doc:docs){
            String docName="";
            String docLocation=docLocationURI+module+"/";
            if(Integer.parseInt(doc.getVersion())>1){
                docName+="v"+doc.getVersion()+"_";
            }
            docName+=doc.getDocumentName();
            docLocation+=docName+"/";
    %>
    <li><a href="<%=docLocation%>"  target="_blank"><%=docName%></a></li>
    <%}%>
</ul>
<%}}%>
<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 11/25/2025
  Time: 1:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.*, java.io.*, javax.xml.parsers.*, org.w3c.dom.*" %>

<%
  String rssUrl = "https://www.fda.gov/about-fda/contact-fda/stay-informed/rss-feeds/press-releases/rss.xml";

  DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
  DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();

  URL url = new URL(rssUrl);
  URLConnection connection = url.openConnection();
  InputStream inputStream = connection.getInputStream();

  Document doc = dBuilder.parse(inputStream);
  doc.getDocumentElement().normalize();

  NodeList items = doc.getElementsByTagName("item");
%>

<h4>FDA Press Releases</h4>

<% for (int i = 0; i < Math.min(items.getLength(), 10); i++) {
  Node item = items.item(i);

  if (item.getNodeType() == Node.ELEMENT_NODE) {
    Element e = (Element) item;

    String fdaNewstitle = e.getElementsByTagName("title").item(0).getTextContent();
    String link = e.getElementsByTagName("link").item(0).getTextContent();
    String pubDate = e.getElementsByTagName("pubDate").item(0).getTextContent();
    if(fdaNewstitle.toLowerCase().contains("gene therapy")){
%>

<div style="margin-bottom: 15px;">
  <ol class="list-unstyled mb-0">
  <li><a href="<%= link %>" target="_blank"><%= fdaNewstitle %></a>
  <small><%= pubDate %></small>
  </li>
  </ol>
</div>

<%
      } }
  }
%>


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
  NodeList items = null;
  boolean feedError = false;
  String[] keywords = {"gene therapy", "gene editing", "cell therapy", "biologics", "genome", "cber", "ind", "investigational new drug"};

  try {
    DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
    DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();

    URL url = new URL(rssUrl);
    URLConnection connection = url.openConnection();
    connection.setConnectTimeout(5000);
    connection.setReadTimeout(5000);
    InputStream inputStream = connection.getInputStream();

    Document doc = dBuilder.parse(inputStream);
    doc.getDocumentElement().normalize();

    items = doc.getElementsByTagName("item");
  } catch (Exception ex) {
    feedError = true;
  }
%>

<h4>FDA Press Releases</h4>

<%
  int matchCount = 0;
  if (!feedError && items != null) {
    for (int i = 0; i < Math.min(items.getLength(), 20); i++) {
      Node item = items.item(i);
      if (item.getNodeType() == Node.ELEMENT_NODE) {
        Element e = (Element) item;
        String fdaNewstitle = e.getElementsByTagName("title").item(0).getTextContent();
        String link = e.getElementsByTagName("link").item(0).getTextContent();
        String pubDate = e.getElementsByTagName("pubDate").item(0).getTextContent();
        String titleLower = fdaNewstitle.toLowerCase();
        boolean matches = false;
        for (String kw : keywords) {
          if (titleLower.contains(kw)) { matches = true; break; }
        }
        if (matches) {
          matchCount++;
%>
<div style="margin-bottom: 15px;">
  <ol class="list-unstyled mb-0">
  <li><a href="<%= link %>" target="_blank"><%= fdaNewstitle %></a>
  <small><%= pubDate %></small>
  </li>
  </ol>
</div>
<%
        }
      }
    }
    if (matchCount == 0) {
%>
<p style="color: #666; font-style: italic;">No recent gene therapy related press releases found. <a href="https://www.fda.gov/news-events/fda-newsroom/press-announcements" target="_blank">View all FDA Press Releases</a></p>
<%
    }
  } else {
%>
<p style="color: #666; font-style: italic;">Unable to load FDA press releases. <a href="https://www.fda.gov/news-events/fda-newsroom/press-announcements" target="_blank">Visit FDA Newsroom</a></p>
<%
  }
%>


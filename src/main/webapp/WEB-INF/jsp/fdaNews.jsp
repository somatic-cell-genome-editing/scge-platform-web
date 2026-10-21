<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 11/25/2025
  Time: 1:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.*, java.io.*, java.util.regex.*, javax.xml.parsers.*, org.w3c.dom.*" %>

<%
  String rssUrl = "https://www.fda.gov/about-fda/contact-fda/stay-informed/rss-feeds/press-releases/rss.xml";
  NodeList items = null;
  boolean feedError = false;
  String[] keywords = {"gene therapy", "gene editing", "cell therapy", "biologics", "genome", "investigational new drug",
                       // rare / orphan regulatory pathways - FDA Rare Disease Framework
                       // Initiative, Oct 2026
                       "rare disease", "orphan",
                       // nonclinical testing terminology - FDA direct final rule, Sep 2026
                       // (90 FR 2026-19350) replaced "animal"/"preclinical" with "nonclinical"
                       "nonclinical", "non-clinical", "preclinical", "animal testing"};
  // Short acronyms must match as whole words - a substring match on "ind" also hits
  // Indian, Indicated, Kind, finding, industry, etc.
  Pattern[] acronymPatterns = {
      Pattern.compile("\\bind\\b"),
      Pattern.compile("\\bcber\\b")
  };

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
  // Scan every item FDA sends (the feed currently carries 20, so the old
  // Math.min(..., 20) scan cap never actually bound) and cap instead what gets
  // rendered, which is what keeps the home page panel a fixed size.
  int maxDisplay = 10;
  int matchCount = 0;
  if (!feedError && items != null) {
    for (int i = 0; i < items.getLength() && matchCount < maxDisplay; i++) {
      Node item = items.item(i);
      if (item.getNodeType() == Node.ELEMENT_NODE) {
        Element e = (Element) item;
        String fdaNewstitle = e.getElementsByTagName("title").item(0).getTextContent();
        String link = e.getElementsByTagName("link").item(0).getTextContent();
        String pubDate = e.getElementsByTagName("pubDate").item(0).getTextContent();
        // Match title + summary, not title alone: relevant releases often carry the topical
        // term only in the body. The Rare Disease Framework Initiative (Oct 2026) was missed
        // this way - its headline says only "Rare Disease Drug Development" while its summary
        // says "drugs and biologics for rare diseases". FDA item descriptions are a single
        // summary sentence with no boilerplate, so this adds little false-positive risk.
        NodeList descNodes = e.getElementsByTagName("description");
        String description = (descNodes.getLength() > 0) ? descNodes.item(0).getTextContent() : "";
        String searchText = (fdaNewstitle + " " + description).toLowerCase();
        boolean matches = false;
        for (String kw : keywords) {
          if (searchText.contains(kw)) { matches = true; break; }
        }
        if (!matches) {
          for (Pattern p : acronymPatterns) {
            if (p.matcher(searchText).find()) { matches = true; break; }
          }
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


<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 7/5/2024
  Time: 1:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
  ul.progress li.active {
    background-color: #dc9305;
  }

  ul.progress li {
    background-color: #7e7e7e;
    position:relative;
    text-indent:0.5em;
  }
  ul.progress li:after {
    content:'';
    position:absolute;
    right:100%;
    margin-right:0.4em;
    width:1.2em;
    padding-top:1.2em;;
    border:solid white;
    z-index:1;
    transform:rotate(45deg);
    border-bottom:0;
    border-left:0;
    box-shadow:5px -5px 0 3px  #7e7e7e
  }
  ul.progress li.active:after {
    box-shadow:6px -6px 0 3px #dc9305;
  }
  ul.progress {
    list-style: none;
    margin: 0.5em;
    padding: 0;
    overflow:hidden;
    white-space:nowrap
  }

  ul.progress li {
    display:inline-block;
    line-height: 20px;
    height: 20px;
    min-width: 130px;
    position: relative;
    transition:min-width 0.5s;
  }


  ul.progress li a {
    padding: 0px 0px 0px 6px;
    color: #FFF;
    text-decoration: none;
  }
  ul.progress li:hover {
    min-width:300px;
  }
  ul.progress li:before {
    content:'\2714'
  }
  ul.progress li.active:before,
  ul.progress li.active ~ li:before {
    content:''
  }


</style>
<ul class="progress">
  <li class="active"><a href="">Module1</a></li>
  <li><a href="">Module2</a></li>
  <li><a href="">Module3</a></li>
  <li><a href="">Module4</a></li>
  <li><a href="">Module5</a></li>
</ul>
<%--<ul class="progress">--%>
<%--  <li><a href="">Module1</a></li>--%>
<%--  <li class="active" ><a href="">Module2</a></li>--%>
<%--  <li><a href="">Module3</a></li>--%>
<%--  <li><a href="">Module4</a></li>--%>
<%--</ul>--%>
<%--<ul class="progress">--%>
<%--  <li><a href="">Module1</a></li>--%>
<%--  <li><a href="">Module2</a></li>--%>
<%--  <li class="active"><a href="">Module3</a></li>--%>
<%--  <li><a href="">Module4</a></li>--%>
<%--</ul>--%>
<%--<ul class="progress">--%>
<%--  <li><a href="">Module1</a></li>--%>
<%--  <li><a href="">Module2</a></li>--%>
<%--  <li><a href="">Module3</a></li>--%>
<%--  <li class="active"><a href="">Module4</a></li>--%>
<%--</ul>--%>
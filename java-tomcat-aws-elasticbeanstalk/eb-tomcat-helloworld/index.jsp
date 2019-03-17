<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.io.BufferedWriter" %>
<%@page import="java.io.FileWriter" %>
<%@page import="java.util.Date" %>
<%@page import="java.util.Scanner" %>
<%
/** Log POSTs at / to a file **/
if ("POST".equalsIgnoreCase(request.getMethod())) {
        BufferedWriter writer = new BufferedWriter(new FileWriter("/tmp/sample-app.log", true));
        Scanner scanner = new Scanner(request.getInputStream()).useDelimiter("\\A");
	if(scanner.hasNext()) {
		String reqBody = scanner.next();
		writer.write(String.format("%s Received message: %s.\n", (new Date()).toString(), reqBody));
	}
        writer.flush();
        writer.close();
	
} else {
  final boolean xrayEnabled = Boolean.valueOf(System.getProperty("XRAY_ENABLED"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <!--
    Copyright 2010-2011 Amazon.com, Inc. or its affiliates. All Rights Reserved.

    Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at

        http://aws.Amazon/apache2.0/

    or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
  -->
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Welcome</title>
  <style>
  body {
    color: #ffffff;
    background-color: #c7c7c7;
    font-family: Arial, sans-serif;
    font-size:14px;
    -moz-transition-property: text-shadow;
    -moz-transition-duration: 4s;
    -webkit-transition-property: text-shadow;
    -webkit-transition-duration: 4s;
    text-shadow: none;
  }
  body.blurry {
    -moz-transition-property: text-shadow;
    -moz-transition-duration: 4s;
    -webkit-transition-property: text-shadow;
    -webkit-transition-duration: 4s;
    text-shadow: #fff 0px 0px 25px;
  }
  a {
    color: #0188cc;
  }
  html, body {
    height: 100%;
  }
  .wrapper {
    height: 100%;
    margin: auto;
    display: flex;
  }
  .textColumn, .linksColumn {
    padding: 2em;
  }
  .textColumn {
    float: left;
    width: 50%;
    height: 100%;
    text-align: right;
    padding-top: 11em;
    background-color: #0188cc;
    background-image: -moz-radial-gradient(left top, circle, #6ac9f9 0%, #0188cc 60%);
    background-image: -webkit-gradient(radial, 0 0, 1, 0 0, 500, from(#6ac9f9), to(#0188cc));
  }
  .textColumn p {
    width: 75%;
    float:right;
  }
  .linksColumn {
    float: left;
    width: 50%;
    height: 100%;
    background-color: #c7c7c7;
  }

  h1 {
    font-size: 500%;
    font-weight: normal;
    margin-bottom: 0em;
  }
  h2 {
    font-size: 200%;
    font-weight: normal;
    margin-bottom: 0em;
  }
  ul {
    padding-left: 1em;
    margin: 0px;
  }
  li {
    margin: 1em 0em;
  }

  #generateTrace {
    display: inline-block;
    padding: 6px 12px;
    margin-bottom: 0;
    font-size: 14px;
    font-weight: 400;
    line-height: 1.42857143;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    cursor: pointer;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    background-image: none;
    border: 1px solid transparent;
    border-radius: 4px;
    padding: 10px 16px;
    font-size: 18px;
    line-height: 1.3333333;
    border-radius: 6px;
    color: #eee;
    background-color: #0188cc;
    border-color: white;
    text-decoration: none;
  }
  #generateTrace:hover {
    background-color: transparent;
    color: #0188cc;
  }

  .linksColumn p {
    color: #0188cc;
  }

  </style>
</head>
<body id="sample">
  <div class="wrapper">
      <div class="textColumn">
        <h1>Congratulations</h1>
        <p>Your first AWS Elastic Beanstalk Application is now running on your own dedicated environment in the AWS Cloud</p>
      </div>

      <div class="linksColumn">
        <h2>What's Next?</h2>
        <ul>
          <li><a href="http://aws.amazon.com/elasticbeanstalk/ug/">Learn how to build, deploy and manage your own applications using AWS Elastic Beanstalk</a></li>
          <li><a href="http://aws.amazon.com/elasticbeanstalk/concepts/">AWS Elastic Beanstalk concepts</a></li>
          <li><a href="http://aws.amazon.com/elasticbeanstalk/deployment/">Learn how to create new application versions</a></li>
          <li><a href="http://aws.amazon.com/elasticbeanstalk/environments/">Learn how to manage your application environments</a></li>
        </ul>
        <h2>Download the AWS Reference Application</h2>
        <ul>
          <li><a href="http://aws.amazon.com/elasticbeanstalk/referenceapp/">Explore a fully-featured reference application using the AWS SDK for Java</a></li>
        </ul>
        <h2>AWS Toolkit for Eclipse</h2>
        <ul>
          <li><a href="http://aws.amazon.com/elasticbeanstalk/eclipse/">Developers may build and deploy AWS Elastic Beanstalk applications directly from Eclipse</a></li>
          <li><a href="http://aws.amazon.com/elasticbeanstalk/eclipsesc/">Get started with Eclipse and AWS Elastic Beanstalk by watching this video</a></li>
          <li><a href="http://aws.amazon.com/elasticbeanstalk/docs/">View all AWS Elastic Beanstalk documentation</a></li>
        </ul>
        <% if (xrayEnabled) { %>
          <h2>AWS X-Ray</h2>
          <p>AWS X-Ray helps developers analyze and debug distributed applications. With X-Ray, you can understand how your application and its underlying services are performing to identify and troubleshoot the root cause of performance issues and errors.</p>
          <p><a href="https://docs.aws.amazon.com/xray/latest/devguide/aws-xray.html">Learn More</a></p>
          <p>Choose <strong>Generate sample traffic</strong> to create data that you can view in the X-Ray console.</p>
          <a id="generateTrace" href="javascript: void(0);" onclick="doTrace();">Generate Sample Traffic</a>
          <br /><br />
          <a href="https://console.aws.amazon.com/xray/home" target="_blank">Open the AWS X-Ray Console</a>
        <% } %>
      </div>
  </div>
  <% if (xrayEnabled) { %>
    <script>
      function doTrace() {
        document.getElementById("generateTrace").textContent = "Generating Traffic...";
        var xmlHttp = new XMLHttpRequest();
        xmlHttp.onreadystatechange = function() {
          if (xmlHttp.readyState == 4) {
            if (xmlHttp.status == 200) {
              document.getElementById("generateTrace").textContent = "Done! Click to generate more data";
            } else {
              // Non 200 ready status
              document.getElementById("generateTrace").textContent = "Issue communicating with backend. Click to try again.";
            }
          }
        }
        xmlHttp.open("GET", "/trace", true);
        xmlHttp.send(null);
      }
    </script>
  <% } %>
</body>
</html>
<% } %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.io.BufferedWriter" %>
<%@page import="java.io.FileWriter" %>
<%@page import="java.util.Date" %>
<%
/** Log scheduled tasks to a file **/
if ("POST".equalsIgnoreCase(request.getMethod())) {
        BufferedWriter writer = new BufferedWriter(new FileWriter("/tmp/sample-app.log", true));
        String taskName = request.getHeader("X-Aws-Sqsd-Taskname");
        String scheduleTime = request.getHeader("X-Aws-Sqsd-Scheduled-At");
        writer.write(String.format("%s Received task %s scheduled at %s.\n", (new Date()).toString(), taskName, scheduleTime));
        writer.flush();
        writer.close();
}
%>

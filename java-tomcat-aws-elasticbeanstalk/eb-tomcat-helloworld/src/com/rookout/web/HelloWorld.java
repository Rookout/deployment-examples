package com.rookout.web; 

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.io.*;

public class HelloWorld extends HttpServlet {
  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NumberFormatException {
    String name = request.getParameter("name");
    if (name == null) {
      name = "world";
    }   
    PrintWriter out = response.getWriter();
    out.println("Hello, " + name + "!");
    out.close();
  }
}
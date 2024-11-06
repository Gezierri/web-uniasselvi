package com.example.uniasselvi_web;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "mainServlet", value = "/main")
public class MainServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String page = request.getParameter("page");

        if (page == null || page.equals("home")) {
            request.getRequestDispatcher("home.jsp").forward(request, response);
        } else if (page.equals("aluno")) {
            request.getRequestDispatcher("students.jsp").forward(request, response);
        } else if (page.equals("escola")) {
            request.getRequestDispatcher("school.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Página não encontrada");
        }
    }
}
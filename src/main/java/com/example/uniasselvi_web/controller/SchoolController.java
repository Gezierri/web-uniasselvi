package com.example.uniasselvi_web.controller;

import com.example.uniasselvi_web.db.DbConnection;
import com.example.uniasselvi_web.model.SchoolModel;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "school", value = "/school/*")
public class SchoolController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getPathInfo();

        switch (action) {
            case "/insert":
                insertSchool(request, response);
                break;
            case "/update":
                updateSchool(request, response);
                break;
            case "/delete":
                deleteSchool(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Ação não suportada");
        }
    }


    protected void insertSchool(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");

        StringBuilder jsonBuffer = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                jsonBuffer.append(line);
            }
        }

        String jsonString = jsonBuffer.toString();


        ObjectMapper objectMapper = new ObjectMapper();
        SchoolModel school = objectMapper.readValue(jsonString, SchoolModel.class);

        Connection connection = null;
        try {
            connection = DbConnection.getConnection();
            String sql = "INSERT INTO schools (name, email, phone, city, state, status) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, school.getName());
            statement.setString(2, school.getEmail());
            statement.setString(3, school.getPhone());
            statement.setString(4, school.getCity());
            statement.setString(5, school.getState());
            statement.setString(6, school.getStatus());
            statement.executeUpdate();
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao salvar a escola.");
        } finally {
            DbConnection.closeConnection(connection);
        }
    }

    private void updateSchool(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String status = request.getParameter("status");

        Connection connection = null;
        try {
            connection = DbConnection.getConnection();
            String sql = "UPDATE schools SET name=?, email=?, phone=?, city=?, state=?, status=? WHERE id=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, name);
            statement.setString(2, email);
            statement.setString(3, phone);
            statement.setString(4, city);
            statement.setString(5, state);
            statement.setString(6, status);
            statement.setInt(7, id);
            statement.executeUpdate();
            response.sendRedirect("/schoolList.jsp");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao atualizar a escola.");
        } finally {
            DbConnection.closeConnection(connection);
        }
    }

    private void deleteSchool(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        Connection connection = null;
        try {
            connection = DbConnection.getConnection();
            String sql = "DELETE FROM schools WHERE id=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            statement.executeUpdate();
            response.sendRedirect("/schoolList.jsp");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao deletar a escola.");
        } finally {
            DbConnection.closeConnection(connection);
        }
    }
}

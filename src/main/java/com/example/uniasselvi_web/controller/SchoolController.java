package com.example.uniasselvi_web.controller;

import com.example.uniasselvi_web.db.DbConnection;
import com.example.uniasselvi_web.model.SchoolModel;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "school", urlPatterns = {"/school", "/school/*"})
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

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            listSchools(req, resp);
        } else if (pathInfo.equals("/get")) {
            getSchool(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Recurso não encontrado.");
        }
    }

    private void listSchools(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<SchoolModel> schools = new ArrayList<>();
        Connection connection = null;

        try {
            connection = DbConnection.getConnection();
            String sql = "SELECT * FROM schools";
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);

            while (resultSet.next()) {
                SchoolModel school = new SchoolModel();
                school.setId(resultSet.getInt("id"));
                school.setName(resultSet.getString("name"));
                school.setEmail(resultSet.getString("email"));
                school.setPhone(resultSet.getString("phone"));
                school.setCity(resultSet.getString("city"));
                school.setState(resultSet.getString("state"));
                school.setStatus(resultSet.getString("status"));
                schools.add(school);
            }

            req.setAttribute("schools", schools);

            RequestDispatcher dispatcher = req.getRequestDispatcher("/index.jsp?page=school");
            dispatcher.forward(req, resp);

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao buscar as escolas.");
        } finally {
            DbConnection.closeConnection(connection);
        }
    }

    private void getSchool(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idParam = req.getParameter("id");
        System.out.println("ID recebido para obter dados: " + idParam); // Log para debugging

        if (idParam == null || idParam.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID da escola não fornecido.");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID da escola inválido: " + idParam);
            return;
        }

        Connection connection = null;
        SchoolModel school = null;

        try {
            connection = DbConnection.getConnection();
            String sql = "SELECT * FROM schools WHERE id=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                school = new SchoolModel();
                school.setId(resultSet.getInt("id"));
                school.setName(resultSet.getString("name"));
                school.setEmail(resultSet.getString("email"));
                school.setPhone(resultSet.getString("phone"));
                school.setCity(resultSet.getString("city"));
                school.setState(resultSet.getString("state"));
                school.setStatus(resultSet.getString("status"));
            }

            if (school != null) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");

                ObjectMapper objectMapper = new ObjectMapper();
                String schoolJson = objectMapper.writeValueAsString(school);

                PrintWriter out = resp.getWriter();
                out.print(schoolJson);
                out.flush();
            } else {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Escola não encontrada.");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao obter os dados da escola.");
        } finally {
            DbConnection.closeConnection(connection);
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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        StringBuilder jsonBuffer = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                jsonBuffer.append(line);
            }
        }

        String jsonString = jsonBuffer.toString();
        System.out.println("JSON recebido para atualização: " + jsonString); // Log para debugging

        ObjectMapper objectMapper = new ObjectMapper();
        SchoolModel school;
        try {
            school = objectMapper.readValue(jsonString, SchoolModel.class);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Dados da escola inválidos.");
            return;
        }

        if (school.getId() == 0 || school.getName() == null || school.getEmail() == null ||
                school.getPhone() == null || school.getCity() == null ||
                school.getState() == null || school.getStatus() == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Dados da escola incompletos.");
            return;
        }

        Connection connection = null;

        try {
            connection = DbConnection.getConnection();
            String sql = "UPDATE schools SET name=?, email=?, phone=?, city=?, state=?, status=? WHERE id=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, school.getName());
            statement.setString(2, school.getEmail());
            statement.setString(3, school.getPhone());
            statement.setString(4, school.getCity());
            statement.setString(5, school.getState());
            statement.setString(6, school.getStatus());
            statement.setInt(7, school.getId());

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Escola com ID " + school.getId() + " atualizada com sucesso.");
                response.setStatus(HttpServletResponse.SC_OK);
                String updatedSchoolJson = objectMapper.writeValueAsString(school);
                PrintWriter out = response.getWriter();
                out.print(updatedSchoolJson);
                out.flush();
            } else {
                System.out.println("Escola com ID " + school.getId() + " não encontrada para atualização.");
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Escola não encontrada.");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao atualizar a escola.");
        } finally {
            DbConnection.closeConnection(connection);
        }
    }

    private void deleteSchool(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID da escola não fornecido.");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID da escola inválido: " + idParam);
            return;
        }

        Connection connection = null;
        try {
            connection = DbConnection.getConnection();
            String sql = "DELETE FROM schools WHERE id=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Escola não encontrada.");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao deletar a escola.");
        } finally {
            DbConnection.closeConnection(connection);
        }
    }
}

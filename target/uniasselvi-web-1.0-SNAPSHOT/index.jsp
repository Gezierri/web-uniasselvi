<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sidebar com Navegação Dinâmica</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <!-- Font Awesome para ícones -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f9fa;
        }

        .sidebar {
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            background-color: #343a40;
            padding-top: 20px;
        }

        .sidebar a {
            color: #c2c7d0;
            text-decoration: none;
            padding: 15px;
            display: flex;
            align-items: center;
            transition: background 0.3s, color 0.3s;
        }

        .sidebar a:hover {
            background-color: #495057;
            color: #ffffff;
        }

        .sidebar a.active {
            background-color: #0d6efd;
            color: #ffffff;
        }

        .sidebar a i {
            margin-right: 10px;
        }

        .content {
            margin-left: 260px;
            padding: 20px;
        }

        .sidebar .sidebar-header {
            padding: 10px;
            color: #fff;
            text-align: center;
            font-size: 1.5em;
        }
    </style>
</head>
<body>

<div class="sidebar">
    <div class="sidebar-header">
        Sistema Estudante
    </div>
    <hr style="border-top: 1px solid #c2c7d0;">
    <a href="index.jsp?page=student" class="nav-link">
        <i class="fas fa-user-graduate"></i> Aluno
    </a>
    <a href="index.jsp?page=school" class="nav-link">
        <i class="fas fa-school"></i> Escola
    </a>
</div>

<div class="content">
    <%
        String pageAtual = request.getParameter("page");

        if (pageAtual == null || pageAtual.equals("student")) {
    %>
    <jsp:include page="student.jsp"/>
    <%
    } else if (pageAtual.equals("school")) {
    %>
    <jsp:include page="school.jsp"/>
    <%
    } else {
    %>
    <h1>Página não encontrada</h1>
    <p>A página solicitada não existe.</p>
    <%
        }
    %>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>
</html>

<%--
  Created by IntelliJ IDEA.
  User: gezierri
  Date: 05/11/2024
  Time: 20:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Aluno</title>

    <style>
        .table-container {
            padding: 20px;
        }

        .status-active {
            color: #fff;
            background-color: #28a745;
            border-radius: 4px;
            padding: 3px 10px;
        }

        .table img {
            width: 40px;
            height: auto;
        }
    </style>
</head>
<body>
<div class="container-fluid table-container">
    <div class="d-flex justify-content-between mb-3">
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#studentModal">
            <i class="fas fa-plus"></i> Add Aluno
        </button>
    </div>

    <div class="table-responsive">
        <table class="table table-striped align-middle">
            <thead>
            <tr>
                <th scope="col">Nome</th>
                <th scope="col">E-mail</th>
                <th scope="col">Telefone</th>
                <th scope="col">Data de Nascimento</th>
                <th scope="col">Sexo</th>
                <th scope="col">Status</th>
                <th scope="col">Ação</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>John Doe</td>
                <td>Aluno@gmail.com</td>
                <td>47991476451</td>
                <td>30/01/1990</td>
                <td>Masculino</td>
                <td><span class="status-active">Active</span></td>
                <td>
                    <button class="btn btn-link"><i class="fas fa-edit"></i></button>
                    <button class="btn btn-link text-danger"><i class="fas fa-trash"></i></button>
                </td>
            </tr>
            </tbody>
        </table>
    </div>

    <div class="modal fade" id="studentModal" tabindex="-1" aria-labelledby="studentModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="studentModalLabel">Adicionar Novo Aluno</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="studentForm">
                        <div class="mb-3">
                            <label for="studentName" class="form-label">Nome</label>
                            <input type="text" class="form-control" id="studentName" name="name" required>
                        </div>
                        <div class="mb-3">
                            <label for="studentEmail" class="form-label">E-mail</label>
                            <input type="email" class="form-control" id="studentEmail" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="studentPhone" class="form-label">Telefone</label>
                            <input type="text" class="form-control" id="studentPhone" name="phone" required>
                        </div>
                        <div class="mb-3">
                            <label for="studentBirthDate" class="form-label">Data de Nascimento</label>
                            <input type="date" class="form-control" id="studentBirthDate" name="birthDate" required>
                        </div>
                        <div class="mb-3">
                            <label for="studentGender" class="form-label">Sexo</label>
                            <select class="form-select" id="studentGender" name="gender" required>
                                <option value="" selected>Selecione o sexo</option>
                                <option value="Masculino">Masculino</option>
                                <option value="Feminino">Feminino</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="studentStatus" class="form-label">Status</label>
                            <select class="form-select" id="studentStatus" name="status" required>
                                <option value="Ativo">Ativo</option>
                                <option value="Inativo">Inativo</option>
                            </select>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-primary" onclick="saveStudent()">Salvar</button>
                </div>
            </div>
        </div>
    </div>
</div>


</body>
</html>

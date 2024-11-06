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
    <title>Escola</title>

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
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#schoolModal">
        <i class="fas fa-plus"></i> Add Escola
        </button>
    </div>

    <div class="table-responsive">
        <table class="table table-striped align-middle">
            <thead>
            <tr>
                <th scope="col">Nome</th>
                <th scope="col">E-mail</th>
                <th scope="col">Telefone</th>
                <th scope="col">Cidade</th>
                <th scope="col">Estado</th>
                <th scope="col">Status</th>
                <th scope="col">Ação</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>Uniasselvi</td>
                <td>uniasselvi@gmail.com</td>
                <td>47991476451</td>
                <td>Gaspar</td>
                <td>Santa Catarina</td>
                <td><span class="status-active">Active</span></td>
                <td>
                    <button class="btn btn-link"><i class="fas fa-edit"></i></button>
                    <button class="btn btn-link text-danger"><i class="fas fa-trash"></i></button>
                </td>
            </tr>
            </tbody>
        </table>
    </div>

    <div class="modal fade" id="schoolModal" tabindex="-1" aria-labelledby="schoolModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="schoolModalLabel">Add New School</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="schoolForm">
                        <div class="mb-3">
                            <label for="schoolName" class="form-label">Nome</label>
                            <input type="text" class="form-control" id="schoolName" name="name" required>
                        </div>
                        <div class="mb-3">
                            <label for="schoolEmail" class="form-label">E-mail</label>
                            <input type="email" class="form-control" id="schoolEmail" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="schoolPhone" class="form-label">Telefone</label>
                            <input type="text" class="form-control" id="schoolPhone" name="phone" required>
                        </div>
                        <div class="mb-3">
                            <label for="schoolCity" class="form-label">Cidade</label>
                            <input type="text" class="form-control" id="schoolCity" name="city" required>
                        </div>
                        <div class="mb-3">
                            <label for="schoolState" class="form-label">Estado</label>
                            <input type="text" class="form-control" id="schoolState" name="state" required>
                        </div>
                        <div class="mb-3">
                            <label for="schoolStatus" class="form-label">Status</label>
                            <select class="form-select" id="schoolStatus" name="status" required>
                                <option value="Ativo">Ativo</option>
                                <option value="Inativo">Inativo</option>
                            </select>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-primary" onclick="saveSchool()">Salvar</button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>

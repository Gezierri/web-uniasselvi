<%--
  Created by IntelliJ IDEA.
  User: gezierri
  Date: 05/11/2024
  Time: 20:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <c:forEach var="school" items="${schools}">
                <tr>
                    <td>${school.name}</td>
                    <td>${school.email}</td>
                    <td>${school.phone}</td>
                    <td>${school.city}</td>
                    <td>${school.state}</td>
                    <td><span class="status-active">${school.status}</span></td>
                    <td>
                        <button class="btn btn-link" onclick="editSchool(${school.id})"><i class="fas fa-edit"></i></button>
                        <button class="btn btn-link text-danger" onclick="deleteSchool(${school.id})"><i class="fas fa-trash"></i></button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Modal para Adicionar Escola -->
    <div class="modal fade" id="schoolModal" tabindex="-1" aria-labelledby="schoolModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form id="schoolForm">
                    <div class="modal-header">
                        <h5 class="modal-title" id="schoolModalLabel">Adicionar Nova Escola</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
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
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="button" class="btn btn-primary" onclick="saveSchool()">Salvar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal para Editar Escola -->
    <div class="modal fade" id="editSchoolModal" tabindex="-1" aria-labelledby="editSchoolModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form id="editSchoolForm">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editSchoolModalLabel">Editar Escola</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" id="editSchoolId" name="id">
                        <div class="mb-3">
                            <label for="editSchoolName" class="form-label">Nome</label>
                            <input type="text" class="form-control" id="editSchoolName" name="name" required>
                        </div>
                        <div class="mb-3">
                            <label for="editSchoolEmail" class="form-label">E-mail</label>
                            <input type="email" class="form-control" id="editSchoolEmail" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="editSchoolPhone" class="form-label">Telefone</label>
                            <input type="text" class="form-control" id="editSchoolPhone" name="phone" required>
                        </div>
                        <div class="mb-3">
                            <label for="editSchoolCity" class="form-label">Cidade</label>
                            <input type="text" class="form-control" id="editSchoolCity" name="city" required>
                        </div>
                        <div class="mb-3">
                            <label for="editSchoolState" class="form-label">Estado</label>
                            <input type="text" class="form-control" id="editSchoolState" name="state" required>
                        </div>
                        <div class="mb-3">
                            <label for="editSchoolStatus" class="form-label">Status</label>
                            <select class="form-select" id="editSchoolStatus" name="status" required>
                                <option value="Ativo">Ativo</option>
                                <option value="Inativo">Inativo</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="button" class="btn btn-primary" onclick="updateSchool()">Salvar Alterações</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    async function saveSchool() {
        const form = document.getElementById('schoolForm');

        const school = {
            name: form.schoolName.value,
            email: form.schoolEmail.value,
            phone: form.schoolPhone.value,
            city: form.schoolCity.value,
            state: form.schoolState.value,
            status: form.schoolStatus.value
        };

        try {
            const response = await fetch('school/insert', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(school)
            });

            if (response.ok) {
                alert('Dados da escola salvos com sucesso!');
                form.reset();
                const modal = bootstrap.Modal.getInstance(document.getElementById('schoolModal'));
                modal.hide();
                window.location.href = '<%= request.getContextPath() %>/school';
            } else {
                alert('Erro ao salvar os dados da escola.');
            }
        } catch (error) {
            console.error('Erro:', error);
            alert('Erro ao salvar os dados da escola.');
        }
    }

    function deleteSchool(id) {
        console.log(`${id}`);
        console.log(id);

        console.log('<%= request.getContextPath() %>/school/delete?id=' + id);
        if (confirm('Tem certeza que deseja deletar esta escola?')) {
            fetch('<%= request.getContextPath() %>/school/delete?id=' + id, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
            })
                .then(response => {
                    if (response.ok) {
                        alert('Escola deletada com sucesso!');
                        window.location.href = '<%= request.getContextPath() %>/school';
                    } else {
                        alert('Erro ao deletar a escola.');
                    }
                })
                .catch(error => {
                    console.error('Erro:', error);
                    alert('Erro ao deletar a escola.');
                });
        }
    }

    function editSchool(id) {
        console.log("Editar escola com ID:", id); // Log para debugging

        fetch('<%= request.getContextPath() %>/school/get?id=' + id, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            }
        })
            .then(response => {
                if (response.ok) {
                    return response.json();
                } else {
                    throw new Error('Erro ao obter os dados da escola.');
                }
            })
            .then(data => {
                document.getElementById('editSchoolId').value = data.id;
                document.getElementById('editSchoolName').value = data.name;
                document.getElementById('editSchoolEmail').value = data.email;
                document.getElementById('editSchoolPhone').value = data.phone;
                document.getElementById('editSchoolCity').value = data.city;
                document.getElementById('editSchoolState').value = data.state;
                document.getElementById('editSchoolStatus').value = data.status;

                var editModal = new bootstrap.Modal(document.getElementById('editSchoolModal'));
                editModal.show();
            })
            .catch(error => {
                console.error('Erro:', error);
                alert('Erro ao obter os dados da escola para edição.');
            });
    }

    function updateSchool() {
        const form = document.getElementById('editSchoolForm');

        const school = {
            id: form.editSchoolId.value,
            name: form.editSchoolName.value,
            email: form.editSchoolEmail.value,
            phone: form.editSchoolPhone.value,
            city: form.editSchoolCity.value,
            state: form.editSchoolState.value,
            status: form.editSchoolStatus.value
        };

        console.log("Dados editados da escola:", school); // Log para debugging

        fetch(`<%= request.getContextPath() %>/school/update`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(school)
        })
            .then(response => {
                if (response.ok) {
                    alert('Escola atualizada com sucesso!');

                    const modal = bootstrap.Modal.getInstance(document.getElementById('editSchoolModal'));
                    modal.hide();
                    window.location.href = '<%= request.getContextPath() %>/school';
                } else {
                    response.text().then(text => alert(`Erro: ${text}`));
                }
            })
            .catch(error => {
                console.error('Erro:', error);
                alert('Erro ao atualizar a escola.');
            });
    }
</script>

</body>
</html>

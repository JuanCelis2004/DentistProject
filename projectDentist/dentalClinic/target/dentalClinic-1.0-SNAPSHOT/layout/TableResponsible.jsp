<%@page import="model.Responsible"%>
<%@page import="java.util.List"%>
<%@page import="controller.ResponsibleController"%>
<div class="container-fluid">

    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary" style="text-align: center">Responsible's List</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped" id="dataTable" width="100%" cellspacing="0">
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>Dni</th>
                            <th>Fist name</th>
                            <th>Last name</th>
                            <th>User name</th>
                            <th>Phone number</th>                            
                            <th>Address</th>
                            <th>Date Birth</th>
                            <th>Email</th>
                            <th>Type responsible</th>                          
                            <th>Action</th>
                        </tr>
                    </thead>

                    <tbody>
                        <%
                            ResponsibleController ControlR = new ResponsibleController();
                            List<Responsible> listResponsible = (List<Responsible>) session.getAttribute("list");

                            int cont = 1;
                            if (listResponsible != null && !listResponsible.isEmpty()) {
                                for (Responsible listR : listResponsible) {
                        %>
                        <tr>
                            <td><%=cont%></td>
                            <td><%=listR.getUser().getDni()%></td>
                            <td><%=listR.getUser().getName()%></td>
                            <td><%=listR.getUser().getLastName()%></td>
                            <td><%=listR.getUser().getUserName()%></td>
                            <td><%=listR.getUser().getPhoneNumber()%></td>
                            <td><%=listR.getUser().getAddress()%></td>
                            <%
                                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
                                sdf.setTimeZone(java.util.TimeZone.getTimeZone("America/Bogota")); // o tu zona local
                            %>
                            <td><%= (listR.getUser().getDateBirth() != null) ? sdf.format(listR.getUser().getDateBirth()) : ""%></td>
                            <td><%=listR.getUser().getEmail()%></td>
                            <td><%=listR.getType()%></td>
                            <td>
                                <a href="#" class="editU" data-toggle="modal" data-target="#editEmployeeModal"
                                   data-id="<%=listR.getUser().getId()%>"
                                   data-dni="<%=listR.getUser().getDni()%>"
                                   data-name="<%=listR.getUser().getName()%>"
                                   data-lastname="<%=listR.getUser().getLastName()%>"
                                   data-username="<%=listR.getUser().getUserName()%>"
                                   data-phonenumber="<%=listR.getUser().getPhoneNumber()%>"
                                   data-address="<%=listR.getUser().getAddress()%>"
                                   data-datebirth="<%= (listR.getUser().getDateBirth() != null) ? new java.text.SimpleDateFormat("yyyy-MM-dd").format(listR.getUser().getDateBirth()) : ""%>"
                                   data-email="<%=listR.getUser().getEmail()%>"
                                   data-typeresponsible="<%=listR.getType()%>"
                                   data-idresponsible="<%=listR.getId()%>"
                                   <i class="material-icons" data-toggle="tooltip" title="Edit" style="color: greenyellow;">&#xE254;</i>
                                </a >
                                <a href="#deleteEmployeeModal" class="deleteU" data-toggle="modal" 
                                   data-idu="<%=listR.getUser().getId()%>"
                                   data-idr="<%=listR.getId()%>">
                                    <i class="material-icons" data-toggle="tooltip" title="Delete" style="color: red;">&#xE872;</i>
                                </a>

                            </td>
                        </tr>
                        <%
                                    cont++;
                                }
                            } else {

                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Edit Modal HTML -->
    <div id="editEmployeeModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="../ResponsibleController" method="POST">
                    <div class="modal-header">						
                        <h4 class="modal-title">Edit responsible</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">					
                        <input type="hidden" id="editId" name="id_responsibleEditar">                     
                        <input type="hidden" id="editId" name="id_responsibleEditM">

                        <div class="form-group">
                            <label>DNI</label>
                            <input type="text" class="form-control" id="editDni" name="dniEdit" required>
                        </div>
                        <div class="form-group">
                            <label>Fist name</label>
                            <input type="text" class="form-control" id="editName" name="nameEdit" required>
                        </div>
                        <div class="form-group">
                            <label>Last name</label>
                            <input type="text" class="form-control" id="editLastName" name="lastNameEdit" required>
                        </div>
                        <div class="form-group">
                            <label>User name</label>
                            <input type="text" class="form-control" id="editUserName" name="userNameEdit" required>
                        </div>
                        <div class="form-group">
                            <label>Phone number</label>
                            <input type="text" class="form-control" id="editAddress" name="phoneNumberEdit" required>
                        </div>
                        <div class="form-group">
                            <label>Address</label>
                            <input type="text" class="form-control" id="editTelefono" name="addressEdit" required>
                        </div>
                        <div class="form-group">
                            <label>Date Birth</label>
                            <input type="date" class="form-control" id="editDateBirth" name="dateBirthEdit" required>
                        </div> 
                        <div class="form-group">
                            <label>Email</label>
                            <input type="text" class="form-control" id="editEmail" name="emailEdit" required>
                        </div>
                        <div class="form-group">
                            <label>Type Resposible</label>
                            <select id="edittypeResponsible" name="typeResponsibleEdit" class="form-control">
                                <option value="Madre">Father</option>
                                <option value="Padre">Mother</option>
                                <option value="Herman@ Mayor">Other</option>
                            </select>                        
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-info" name="action" value="edit" >Editar</button>
                    </div>
                </form>

            </div>
        </div>
    </div>
    <!-- Delete Modal HTML -->
    <div id="deleteEmployeeModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="../ResponsibleController" method="POST">
                    <div class="modal-header">						
                        <h4 class="modal-title">Delete responsible</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <input type="hidden" class="form-control" id="deleteIdU" name="id_usuarioEliminar" required>

                    <input type="hidden" class="form-control" id="deleteIdD" name="id_ResponsibleEliminar" required>
                    <div class="modal-body">					
                        <p>Are you sure you want to delete this responsible?</p>
                        <p class="text-warning"><small>This action cannot be undone!</small></p>
                    </div>

                    <div class="modal-footer">
                        <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                        <input type="submit" class="btn btn-danger" name="action" value="delete">
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

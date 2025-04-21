<%@page import="model.Secretary"%>
<%@page import="java.util.List"%>
<%@page import="controller.SecretaryController"%>
<div class="container-fluid">

    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary" style="text-align: center">Secretary's list</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped" id="dataTable" width="100%" cellspacing="0">
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>Dni</th>
                            <th>First naame</th>
                            <th>Last name</th>
                            <th>User name</th>
                            <th>Phone number</th>                            
                            <th>Address</th>
                            <th>Date Birth</th>
                            <th>Email</th>
                            <th>Zone</th>                          
                            <th>Action</th>
                        </tr>
                    </thead>

                    <tbody>
                        <%
                            SecretaryController ControlS = new SecretaryController();
                            List<Secretary> listSecretary = (List<Secretary>) session.getAttribute("list");

                            int cont = 1;
                            if (listSecretary != null && !listSecretary.isEmpty()) {
                                for (Secretary listS : listSecretary) {
                        %>
                        <tr>
                            <td><%=cont%></td>
                            <td><%=listS.getUser().getDni()%></td>
                            <td><%=listS.getUser().getName()%></td>
                            <td><%=listS.getUser().getLastName()%></td>
                            <td><%=listS.getUser().getUserName()%></td>
                            <td><%=listS.getUser().getPhoneNumber()%></td>
                            <td><%=listS.getUser().getAddress()%></td>
                            <%
                                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
                                sdf.setTimeZone(java.util.TimeZone.getTimeZone("America/Bogota")); // o tu zona local
                            %>
                            <td><%= (listS.getUser().getDateBirth() != null) ? sdf.format(listS.getUser().getDateBirth()) : ""%></td>
                            <td><%=listS.getUser().getEmail()%></td>
                            <td><%=listS.getZone()%></td>
                            <td>
                                <a href="#" class="editU" data-toggle="modal" data-target="#editEmployeeModal"
                                   data-id="<%=listS.getUser().getId()%>"
                                   data-dni="<%=listS.getUser().getDni()%>"
                                   data-name="<%=listS.getUser().getName()%>"
                                   data-lastname="<%=listS.getUser().getLastName()%>"
                                   data-username="<%=listS.getUser().getUserName()%>"
                                   data-phonenumber="<%=listS.getUser().getPhoneNumber()%>"
                                   data-address="<%=listS.getUser().getAddress()%>"
                                   data-datebirth="<%= (listS.getUser().getDateBirth() != null) ? new java.text.SimpleDateFormat("yyyy-MM-dd").format(listS.getUser().getDateBirth()) : ""%>"
                                   data-email="<%=listS.getUser().getEmail()%>"
                                   data-zone="<%=listS.getZone()%>"
                                   data-ids="<%=listS.getId()%>"
                                   <i class="material-icons" data-toggle="tooltip" title="Edit" style="color: greenyellow;">&#xE254;</i>
                                </a >
                                <a href="#deleteEmployeeModal" class="deleteU" data-toggle="modal" 
                                   data-idu="<%=listS.getUser().getId()%>"
                                   data-ids="<%=listS.getId()%>">
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
                <form action="../SecretaryController" method="POST">
                    <div class="modal-header">						
                        <h4 class="modal-title">Edit Secretary</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">					
                        <input type="hidden" id="editId" name="id_secretaryEditar">                     
                        <input type="hidden" id="editId" name="id_secretaryEditM">

                        <div class="form-group">
                            <label>DNI</label>
                            <input type="text" class="form-control" id="editDni" name="dniEdit" required>
                        </div>
                        <div class="form-group">
                            <label>First name</label>
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
                            <label>Zone</label>
                            <select id="editZoneSecretary" name="zoneSecretaryEdit" class="form-control">
                                <option value="Administrative">Administrative</option>
                                <option value="Sanitary">Sanitary</option>
                            </select>                        
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-info" name="action" value="edit" >Edit</button>
                    </div>
                </form>

            </div>
        </div>
    </div>
    <!-- Delete Modal HTML -->
    <div id="deleteEmployeeModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="../SecretaryController" method="POST">
                    <div class="modal-header">						
                        <h4 class="modal-title">Delete responsable</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <input type="hidden" class="form-control" id="deleteIdU" name="id_usuarioEliminar" required>

                    <input type="hidden" class="form-control" id="deleteIdD" name="id_secretaryEliminar" required>
                    <div class="modal-body">					
                        <p>Are you sure you want to delete this secretary?</p>
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

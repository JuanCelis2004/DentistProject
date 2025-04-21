<%@page import="persistence.ScheduleJpaController"%>
<%@page import="controller.DentistController"%>
<%@page import="model.Dentist"%>
<%@page import="model.Schedule"%>
<%@page import="java.util.List"%>
<div class="container-fluid">

    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary" style="text-align: center">Dentist´s List</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped" id="dataTable" width="100%" cellspacing="0">
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>Dni</th>
                            <th>First name</th>
                            <th>Last name</th>
                            <th>User name</th>
                            <th>Phone number</th>                            
                            <th>Address</th>
                            <th>Date Birth</th>
                            <th>Email</th>
                            <th>Specialty</th>                          
                            <th>Schedule</th> 
                            <th>Actions</th>
                        </tr>
                    </thead>

                    <tbody>
                        <%
                            DentistController dentistController = new DentistController();
                            List<Dentist> listDentist = (List<Dentist>) session.getAttribute("list");

                            int cont = 1;
                            if (listDentist != null && !listDentist.isEmpty()) {
                                for (Dentist list : listDentist) {
                        %>
                        <tr>
                            <td><%=cont%></td>
                            <td><%=list.getUser().getDni()%></td>
                            <td><%=list.getUser().getName()%></td>
                            <td><%=list.getUser().getLastName()%></td>
                            <td><%=list.getUser().getUserName()%></td>
                            <td><%=list.getUser().getPhoneNumber()%></td>
                            <td><%=list.getUser().getAddress()%></td>
                            <%
                                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
                                sdf.setTimeZone(java.util.TimeZone.getTimeZone("America/Bogota"));
                            %>
                            <td><%= (list.getUser().getDateBirth() != null) ? sdf.format(list.getUser().getDateBirth()) : ""%></td>
                            <td><%=list.getUser().getEmail()%></td>
                            <td><%=list.getSpecialty()%></td>
                            <td><%=list.getSchedule().getStartTime()%> to <%=list.getSchedule().getEndTime()%></td>

                            <td>
                                <a href="#" class="editD" data-toggle="modal" data-target="#editDentistModal"
                                   data-id="<%=list.getUser().getId()%>"
                                   data-dni="<%=list.getUser().getDni()%>"
                                   data-name="<%=list.getUser().getName()%>"
                                   data-lastname="<%=list.getUser().getLastName()%>"
                                   data-username="<%=list.getUser().getUserName()%>"
                                   data-phonenumber="<%=list.getUser().getPhoneNumber()%>"
                                   data-address="<%=list.getUser().getAddress()%>"
                                   data-datebirth="<%= (list.getUser().getDateBirth() != null) ? new java.text.SimpleDateFormat("yyyy-MM-dd").format(list.getUser().getDateBirth()) : ""%>"
                                   data-email="<%=list.getUser().getEmail()%>"
                                   data-specialty="<%=list.getSpecialty()%>"
                                   data-schedule="<%=list.getSchedule().getId()%>"
                                   data-iddentist="<%=list.getId()%>" >
                                    <i class="material-icons" data-toggle="tooltip" title="Edit" style="color: greenyellow;">&#xE254;</i>
                                </a>
                                <a href="#deleteDentistModal" class="deleteD" data-toggle="modal" 
                                   data-idu="<%=list.getUser().getId()%>"
                                   data-idd="<%=list.getId()%>">
                                    <i class="material-icons" data-toggle="tooltip" title="Delete" style="color: red;">&#xE872;</i>
                                </a>
                            </td>
                        </tr>
                        <%
                                    cont++;
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Edit Dentist Modal -->
    <div id="editDentistModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="../DentistController" method="POST">
                    <div class="modal-header">						
                        <h4 class="modal-title">Edit dentist</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">					
                        <input type="hidden" id="editId" name="id_dentistEditar">
                        <input type="hidden" id="editId" name="id_dentistEditarM">
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
                            <input type="text" class="form-control" id="userNameEdit" name="userNameEdit" required>
                        </div>	
                        <div class="form-group">
                            <label>Phone number</label>
                            <input type="text" class="form-control" id="editPhoneNumber" name="phoneNumberEdit" required>
                        </div>
                        <div class="form-group">
                            <label>Address</label>
                            <input type="text" class="form-control" id="editAddress" name="addressEdit" required>
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
                            <label>Specialty</label>
                            <select id="editSpecialty" name="specialtyEdit" class="form-control">
                                <option value="Yes">Yes</option>
                                <option value="No">No</option>
                            </select>                        
                        </div>
                        <div class="form-group">
                            <label>Schedule</label>
                            <select id="editSpecialty" name="scheduleEdit" class="form-control">
                                <%
                                    ScheduleJpaController ControlS = new ScheduleJpaController();
                                    List<Schedule> listSchedule = ControlS.findScheduleEntities();

                                    if (listSchedule != null && !listSchedule.isEmpty()) {
                                        for (Schedule listS : listSchedule) {
                                %>
                                <option value="<%= listS.getId()%>"><%= listS.getStartTime()%> to <%= listS.getEndTime()%></option>
                                <%
                                        }
                                    }
                                %>
                            </select>                        
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-info" name="action" value="edit">Edit</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Delete Dentist Modal -->
    <div id="deleteDentistModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="../DentistController" method="POST">
                    <div class="modal-header">						
                        <h4 class="modal-title">Delete dentist</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <!-- <input type="hidden" class="form-control" id="deleteId" name="id_dentistEliminar"> --> 

                    <input type="hidden" class="form-control" id="deleteIdU" name="id_usuarioEliminar" required>

                    <input type="hidden" class="form-control" id="deleteIdD" name="id_dentistEliminar" required>


                    <div class="modal-body">					
                        <p>Are you sure you want to delete this dentist?</p>
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

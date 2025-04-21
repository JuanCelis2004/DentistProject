<%-- 
    Document   : TableSchedule
    Created on : 6/04/2025, 10:44:11?p.?m.
    Author     : juand
--%>

<%@page import="model.Schedule"%>
<%@page import="java.util.List"%>
<%@page import="controller.ScheduleController"%>
<div class="container-fluid">

    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Schedule´s List</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped" id="dataTable" width="100%" cellspacing="0">
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>Start Time</th>
                            <th>End Time</th>
                            <th>Action</th>
                        </tr>
                    </thead>

                    <tbody>
                        <%
                            ScheduleController ControlS = new ScheduleController();
                            List<Schedule> listSchedule = (List<Schedule>) session.getAttribute("listSchedule");

                            int cont = 1;
                            if (listSchedule != null && !listSchedule.isEmpty()) {
                                for (Schedule listS : listSchedule) {
                        %>
                        <tr>
                            <td><%=cont%></td>
                            <td><%=listS.getStartTime()%></td>
                            <td><%=listS.getEndTime()%></td>
                            <td>
                                <a href="#" class="editU" data-toggle="modal" data-target="#editEmployeeModal"
                                   data-id="<%=listS.getId()%>"
                                   data-starttime="<%=listS.getStartTime()%>"
                                   data-endtime="<%=listS.getEndTime()%>"                                
                                   <i class="material-icons" data-toggle="tooltip" title="Edit" style="color: greenyellow;">&#xE254;</i>
                                </a >
                                <a href="#deleteEmployeeModal" class="deleteU" data-toggle="modal" data-id="<%=listS.getId()%>">
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
                <form action="../ScheduleController" method="POST">
                    <div class="modal-header">						
                        <h4 class="modal-title">Edit schedule</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">					
                        <input type="hidden" id="editId" name="id_horarioEditar">
                        <div class="form-group">
                            <label>Start time</label>
                            <input type="time" class="form-control" id="editStartTime" name="startTimeEdit" required>
                        </div>
                        <div class="form-group">
                            <label>End time</label>
                            <input type="time" class="form-control" id="editEndTime" name="endTimeEdit" required>
                        </div>                       
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-info" name="action" value="Edit" >Edit</button>
                    </div>
                </form>

            </div>
        </div>
    </div>
    <!-- Delete Modal HTML -->
    <div id="deleteEmployeeModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="../ScheduleController" method="POST">
                    <div class="modal-header">						
                        <h4 class="modal-title">Delete schedule</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <input type="hidden" id="editId" name="id_horarioEliminar">
                    <div class="modal-body">					
                        <p>Are you sure you want to delete this schedule?</p>
                        <p class="text-warning"><small>This action cannot be undone!</small></p>
                    </div>

                    <div class="modal-footer">
                        <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                        <input type="submit" class="btn btn-danger" name="action" value="Delete">
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>



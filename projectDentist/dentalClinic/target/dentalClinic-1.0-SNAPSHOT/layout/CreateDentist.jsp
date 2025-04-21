<%-- 
    Document   : CreateDentist
    Created on : 8/04/2025, 12:44:10?p.?m.
    Author     : david
--%>

<%@page import="persistence.ScheduleJpaController"%>
<%@page import="model.Schedule"%>
<%@page import="java.util.List"%>
<%@page import="controller.ScheduleController"%>
<div class="container-fluid">
    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800" style="text-align: center;">Create dentist</h1>

    <form action="../DentistController" method="POST" class="createRForm">
        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="int" class="form-label">Dni</label>
                <input type="number" class="form-control" name="dni" id="int" placeholder="Dni">
            </div>
            <div class="col-md-6 mb-3">
                <label for="name" class="form-label">First name</label>
                <input type="text" class="form-control" name="name" id="name" placeholder="Name">
            </div>

            <div class="col-md-6 mb-3">
                <label for="lastName" class="form-label">Last name</label>
                <input type="text" class="form-control" name="lastName" id="lastName" placeholder="Last Name">
            </div>
            <div class="col-md-6 mb-3">
                <label for="userName" class="form-label">User name</label>
                <input type="text" class="form-control" name="userName" id="userName" placeholder="User name">
            </div>

            <div class="col-md-6 mb-3">
                <label for="number" class="form-label">Phone number</label>
                <input type="number" class="form-control" name="phoneNumber" id="number" placeholder="Phone number">
            </div>
            <div class="col-md-6 mb-3">
                <label for="address" class="form-label">Address</label>
                <input type="text" class="form-control" name="address" id="address" placeholder="Address">
            </div>

            <div class="col-md-6 mb-3">
                <label for="dateBirth" class="form-label">Date Birth</label>
                <input type="date" class="form-control" name="dateBirth" id="dateBirth">
            </div>
            <div class="col-md-6 mb-3">
                <label for="email" class="form-label">Email address</label>
                <input type="email" class="form-control" name="email" id="email" placeholder="Email">
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="schedule" class="form-label">Schedule</label>
                <select class="form-control" id="schedule" name="Schedule">
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

            <div class="col-md-6 mb-3">
                <label for="specialty" class="form-label">Specialty</label>
                <select class="form-control" id="specialty" name="specialty">
                    <option value="Yes">Yes</option>
                    <option value="No">No</option>
                </select>
            </div>
        </div>

        <div class="text-center mt-4">
            <button type="submit" name="action" value="create" class="btn btn-primary">Send</button>
        </div>
    </form>
</div>
<%@page import="model.Responsible"%>
<%@page import="java.util.List"%>
<%@page import="persistence.ResponsibleJpaController"%>
<div class="container-fluid">
    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800" style="text-align: center;">Create a patient</h1>

    <form action="../PatientController" method="POST" class="createPForm">
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
                <label for="responsible" class="form-label">Responsible</label>
                <select class="form-control" id="Responsible" name="Responsible">
                    <%
                        ResponsibleJpaController ControlR = new ResponsibleJpaController();
                        List<Responsible> listResponsible = ControlR.findResponsibleEntities();

                        if (listResponsible != null && !listResponsible.isEmpty()) {
                            for (Responsible listR : listResponsible) {
                    %>
                    <option value="<%= listR.getId()%>">C.C. <%=listR.getUser().getDni()%> de <%=listR.getUser().getName()%> <%=listR.getUser().getLastName()%> -> <%=listR.getType() %></option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>

            <div class="col-md-6 mb-3">
                <label for="eps" class="form-label">Do you have eps?</label>
                <select class="form-control" id="eps" name="eps">
                    <option value="true">Yes</option>
                    <option value="false">No</option>
                </select>
            </div>
        </div>

        <div class="text-center mt-4">
            <button type="submit" name="action" value="create" class="btn btn-primary">Send</button>
        </div>
    </form>
</div>
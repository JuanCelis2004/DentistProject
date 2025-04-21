
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<!-- Sidebar -->
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

    <!-- Sidebar - Brand -->
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.html">
        <div class="sidebar-brand-icon rotate-n-15">
            <i class="fa-solid fa-bandage"></i>
        </div>
        <div class="sidebar-brand-text mx-3">Clinic Ing <sup>s</sup></div>
    </a>

    <!-- Divider -->
    <hr class="sidebar-divider my-0">

    <!-- Nav Item - Dashboard -->
    <li class="nav-item active">
        <a class="nav-link" href="index.jsp">
            <i class="fas fa-fw fa-tachometer-alt"></i>
            <span>Dashboard</span></a>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider">

    <!-- Heading -->
    <div class="sidebar-heading">
        Interface
    </div>
    <c:if test="${sessionScope.userRolType == 5}">
        <!-- Nav Item - Users Collapse Menu -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
               aria-expanded="true" aria-controls="collapseTwo">
                <i class="fas fa-user"></i>
                <span>Users</span>
            </a>
            <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <h6 class="collapse-header">User's options:</h6>
                    <a class="collapse-item" href="../userController" name="action" value="verU" >See users</a>
                    <a class="collapse-item" href="../view/CreateUser.jsp">Create users</a>
                </div>
            </div>
        </li>

        <!-- Nav Item - Dentist Collapse Menu -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseDentist"
               aria-expanded="true" aria-controls="collapseDentist">
                <i class="fas fa-tooth"></i>
                <span>Dentists</span>
            </a>
            <div id="collapseDentist" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <h6 class="collapse-header">Dentist's options</h6>
                    <a class="collapse-item" href="../DentistController?action=show">See dentist</a>
                    <a class="collapse-item" href="../view/CreateDentist.jsp">Create dentist</a>
                </div>
            </div>
        </li>

        <!-- Nav Item - Secretary Collapse Menu -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseSecretary"
               aria-expanded="true" aria-controls="collapseSecretary">
                <i class="fa-solid fa-user-tie"></i>
                <span>Secretary</span>
            </a>
            <div id="collapseSecretary" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <h6 class="collapse-header">Secretary's options</h6>
                    <a class="collapse-item" href="../SecretaryController?action=show" name="action" value="verU" >See secretaries</a>
                    <a class="collapse-item" href="../view/CreateSecretary.jsp">Create secretary</a>
                </div>
            </div>
        </li>

        <!-- Nav Item - Patient Collapse Menu -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePatient"
               aria-expanded="true" aria-controls="collapsePatient">
                <i class="fa-solid fa-hospital-user"></i>
                <span>Patient</span>
            </a>
            <div id="collapsePatient" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <h6 class="collapse-header">Patient's options</h6>
                    <a class="collapse-item" href="../PatientController?action=show" name="action" value="verU" >See Patients</a>
                    <a class="collapse-item" href="../view/CreatePatient.jsp">Create patient</a>
                </div>
            </div>
        </li>


        <!-- Nav Item - Schedules Collapse Menu -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseSchedules"
               aria-expanded="true" aria-controls="collapseSchedules">
                <i class="fas fa-clock"></i>
                <span>Schedules</span>
            </a>
            <div id="collapseSchedules" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <h6 class="collapse-header">Schedule's options</h6>
                    <a class="collapse-item" href="../ScheduleController?action=show" name="action" value="verU" >See schedules</a>
                    <a class="collapse-item" href="../view/CreateSchedule.jsp">Create schedules</a>
                </div>
            </div>
        </li>

        <!-- Nav Item - Responsible Collapse Menu -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseResposible"
               aria-expanded="true" aria-controls="collapseResposible">
                <i class="fa-solid fa-users"></i>
                <span>Responsible</span>
            </a>
            <div id="collapseResposible" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <h6 class="collapse-header">Responsible's options</h6>
                    <a class="collapse-item" href="../ResponsibleController?action=show" name="action" value="verU" >See Responsibles</a>
                    <a class="collapse-item" href="../view/CreateResponsible.jsp">Create responsible</a>
                </div>
            </div>
        </li>

        <!-- Nav Item - Turn Collapse Menu -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTurn"
               aria-expanded="false" aria-controls="collapseTurn">
                <i class="fas fa-clipboard-list"></i> <!-- Cambiado a 'fas' en lugar de 'fa-solid' -->
                <span>Turns</span> <!-- Cambiado a plural para consistencia -->
            </a>
            <div id="collapseTurn" class="collapse" aria-labelledby="headingTurn" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <h6 class="collapse-header">Turn Options</h6> <!-- Corregido el posesivo -->
                    <a class="collapse-item" href="../TurnController?action=list">View Turns</a> <!-- Enlace corregido -->
                    <a class="collapse-item" href="../view/CreateTurn.jsp">Create Turn</a> <!-- Enlace corregido -->
                </div>
            </div>
        </li>

        <hr class="sidebar-divider d-none d-md-block">

        <!-- Sidebar Toggler (Sidebar) -->
        <div class="text-center d-none d-md-inline" style="display: flex; justify-content: center; width: 100%;">
            <button class="rounded-circle border-0" id="sidebarToggle" style="margin: 0 auto;"></button>
        </div>
    </c:if>

</ul>
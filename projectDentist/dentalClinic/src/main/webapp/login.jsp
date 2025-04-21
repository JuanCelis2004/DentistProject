<%-- 
    Document   : login
    Created on : 8/03/2025, 9:52:32 p. m.
    Author     : david
--%>

<%@page import="persistence.UserJpaController"%>
<%@page import="persistence.RolJpaController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies

    UserJpaController userjpa = new UserJpaController();
%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="layout/header.jsp" %>
        <link rel="stylesheet" href="styles/css/login.css"/>
        <title>DentalIng</title>

    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-md-12" style="display: flex;justify-content: center;align-items: center; width: 100vw;height: 100vh;">
                    <div class="wrapper">
                        <div class="form" id="form1">
                            <div class="title"><h1>Login</h1></div>
                            <form action="userController"  method="POST" class="loginForm">
                                <div class="profileImage">
                                    <i class="fa-solid fa-tooth"></i>

                                </div>
                                <div class="form-group">
                                    <i class="fa fa-envelope form-icon"></i>
                                    <input type="email" class="form-control" name= "email" id="email" placeholder="Email">
                                </div>
                                <div class="form-group">
                                    <i class="fa fa-lock form-icon"></i>
                                    <input type="password" class="form-control" name="password" id="pwd" placeholder="Password">
                                </div>
                                <button type="submit" name="action" value="login" class="btn btn-default">login</button>
                            </form>
                        </div>
                        <div class="form form-horizontal" id="form2">
                            <div class="title"><h1>Sing Up</h1></div>
                            <form action="userController"  method="POST" class="signupForm" style="
                                  flex-grow: 1;
                                  overflow-y: auto;
                                  max-height: 65vh;
                                  padding: 10px;">
                                <div class="profileImage">
                                    <i class="fa-solid fa-tooth"></i>
                                </div>
                                <div class="form-group">
                                    <i class="fa-solid fa-id-card-clip form-icon"></i>
                                    <input type="number" class="form-control" name="dni" id="int" placeholder="Dni">
                                </div>
                                <div class="form-group">
                                    <i class="fa-solid fa-user form-icon"></i>
                                    <input type="text" class="form-control" name="name" id="name" placeholder="Name">
                                </div>
                                <div class="form-group">
                                    <i class="fa-solid fa-user form-icon"></i>
                                    <input type="text" class="form-control" name="lastName" id="lastName" placeholder="Last Name">
                                </div>
                                <div class="form-group">
                                    <i class="fa-solid fa-phone form-icon"></i>
                                    <input type="number" class="form-control" name="phoneNumber" id="number" placeholder="Phone number">
                                </div>
                                <div class="form-group">
                                    <i class="fa-solid fa-map-location-dot form-icon"></i>
                                    <input type="text" class="form-control" name="address" id="address" placeholder="Address">
                                </div>
                                <div class="form-group">
                                    <i class="fa-solid fa-user-secret form-icon"></i>
                                    <input type="text" class="form-control" name="userName" id="userName" placeholder="User name">
                                </div>
                                <label>Fecha de nacimiento</label>
                                <div class="form-group">
                                    <i class="fa-solid fa-location-dot form-icon"></i>
                                    <input type="date" class="form-control" name="dateBirth" id="dateBirth" placeholder="Date">
                                </div>
                                <div class="form-group">
                                    <i class="fa fa-envelope form-icon"></i>
                                    <input type="email" class="form-control" name="email" id="email" placeholder="Email">
                                </div>
                                <div class="form-group">
                                    <i class="fa fa-lock form-icon"></i>
                                    <input type="password" class="form-control" name="password" id="pwd" placeholder="Password">
                                </div>
                                <div class="form-group">
                                    <i class="fa fa-lock form-icon"></i>
                                    <input type="password" class="form-control" id="repwd" name="repwd" placeholder="Retype-Password">
                                </div>

                                <button type="submit" name="action" value="signup" class="btn btn-default">Sign up</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="layout/script.jsp" %> 
        <script>
            // Obtener los parámetros de la URL
            const urlParams = new URLSearchParams(window.location.search);

            // Mostrar alerta si hay un mensaje de éxito o error
            if (urlParams.has('success')) {
                Swal.fire({
                    icon: 'success',
                    title: 'Registro Exitoso',
                    text: urlParams.get('success'),
                    confirmButtonColor: '#3085d6',
                    confirmButtonText: 'OK'
                });

                // Eliminar parámetros de la URL después de mostrar la alerta
                history.replaceState(null, null, window.location.pathname);
            }

            if (urlParams.has('error')) {
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: urlParams.get('error'),
                    confirmButtonColor: '#d33',
                    confirmButtonText: 'OK'
                });

                // Eliminar parámetros de la URL después de mostrar la alerta
                history.replaceState(null, null, window.location.pathname);
            }
        </script>


        <script src="styles/js/login.js"></script>
    </body>
</html>

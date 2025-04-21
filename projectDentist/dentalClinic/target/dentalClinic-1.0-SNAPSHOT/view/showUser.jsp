<%-- 
    Document   : showUser
    Created on : 2/04/2025, 5:29:09 p. m.
    Author     : juand
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="../layout/header.jsp" %>
        <title>Ver Usuarios</title>
    </head>
    <body id="page-top">
        <div id="wrapper">
            <%@include file="../layout/side_bar.jsp" %>
            <div id="content-wrapper" class="d-flex flex-column">
                <%@include file="../layout/nav.jsp" %>

                <%@include file="../layout/tableUser.jsp" %>

                <%@include file="../layout/footer.jsp" %>
            </div>
        </div>


        <%@include file="../layout/script.jsp" %> 
        <script src="${pageContext.request.contextPath}/styles/js/tableUser.js"></script>
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
    </body>

</html>

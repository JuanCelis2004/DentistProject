<%-- 
    Document   : script
    Created on : 8/03/2025, 3:10:46 p. m.
    Author     : david
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- Bootstrap core JavaScript-->
<script src="${pageContext.request.contextPath}/styles/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/styles/js/bootstrap.bundle.min.js"></script>
<!-- Core plugin JavaScript-->
<script src="${pageContext.request.contextPath}/styles/js/jquery.easing.min.js"></script>
<!-- Custom scripts for all pages-->
<script src="${pageContext.request.contextPath}/styles/js/sb-admin-2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

 <!-- Page level plugins -->
 <script src="${pageContext.request.contextPath}/styles/js/jquery.dataTables.min.js"></script>
 <script src="${pageContext.request.contextPath}/styles/js/dataTables.bootstrap4.min.js"></script>
 <script src="${pageContext.request.contextPath}/styles/js/tableDentist.js"></script>
 
 <!-- Page level custom scripts -->
 <script src="${pageContext.request.contextPath}/styles/js/datatables-demo.js"></script>
 
 <script>
            // Obtener los parámetros de la URL
            const urlParams = new URLSearchParams(window.location.search);

            // Mostrar alerta si hay un mensaje de éxito o error
            if (urlParams.has('success')) {
                Swal.fire({
                    icon: 'success',
                    title: 'Acción Exitosa',
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
<%-- 
    Document   : ShowDentist
    Created on : 8/04/2025, 3:29:40 p. m.
    Author     : david
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
     <head>
        <%@include file="../layout/header.jsp" %>
        <title>View dentist</title>
    </head>
    <body id="page-top">
        <div id="wrapper">
            <%@include file="../layout/side_bar.jsp" %>
            <div id="content-wrapper" class="d-flex flex-column">
                <%@include file="../layout/nav.jsp" %>
                
                <%@include file="../layout/TableDentist.jsp" %>
                
                <%@include file="../layout/footer.jsp" %>
            </div>
        </div>
        <%@include file="../layout/script.jsp" %> 
        <script src="${pageContext.request.contextPath}/styles/js/tableResponsible.js "></script>
    </body>
</html>

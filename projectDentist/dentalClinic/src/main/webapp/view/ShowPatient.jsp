<%-- 
    Document   : ShowPatient
    Created on : 13/04/2025, 12:06:11 a. m.
    Author     : juand
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="../layout/header.jsp" %>
        <title>Dashboard</title>
    </head>
    <body id="page-top">
        <div id="wrapper">
            <%@include file="../layout/side_bar.jsp" %>
            <div id="content-wrapper" class="d-flex flex-column">
                <%@include file="../layout/nav.jsp" %>
                
                <%@include file="../layout/TablePatient.jsp" %>
                
                <%@include file="../layout/footer.jsp" %>
            </div>
        </div>
        <%@include file="../layout/script.jsp" %> 
        
    </body>
</html>

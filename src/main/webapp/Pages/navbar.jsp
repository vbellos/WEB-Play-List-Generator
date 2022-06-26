<%@ page import ="com.example.demo.Models.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.demo.Dao.Dao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">

<body>
<style>
    ul {
        list-style-type: none;
        margin: 0;
        padding: 0;
    }
</style>
<%
    Dao bd = new Dao();
%>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="./Home">Playlist Generator</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>


        </div>
        <ul class="d-flex me-auto mb-2 mb-lg-0 px-4">
            <div class="collapse navbar-collapse">
                <%
                    User u = (User) session.getAttribute("user");
                    if (u != null) {

                %>

                <li class="nav-item dropdown">
                    <a class="h-100 btn btn-outline-success dropdown-toggle" data-toggle="dropdown" href="#"><i class="bi bi-person-circle"></i> <%=u.getName()%> <span class="caret"></span> </a>
                    <div class="dropdown-menu " aria-labelledby="navbarDropdown">

                        <a class="dropdown-item" href="<%=request.getContextPath()%>/Account">Account</a>

                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="<%=request.getContextPath()%>/Logout">Logout</a>

                    </div>
                </li>
                <%
                } else {
                    // Not logged in, show login prompt
                %>

                <li class="nav-item px-2"><a class="btn btn-outline-success nav-link" href="<%=request.getContextPath()%>/Register"> Register</a></li>
                <li class="nav-item px-2"><a class="btn btn-outline-success nav-link" href="<%=request.getContextPath()%>/Login"> Login</a></li>
                <%
                    }
                %>
            </div>
        </ul>
    </div>


</nav>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">

<head>
<title>Login</title>
</head>
<body>
<header>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="./Home">Playlist Generator</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <ul class="d-flex me-auto mb-2 mb-lg-0 px-4">
                <div class="collapse navbar-collapse">

                    <li class="nav-item px-2"><a class="btn btn-outline-success nav-link" href="<%=request.getContextPath()%>/Register"> Register</a></li>
                    <li class="nav-item px-2"><a class="btn btn-outline-success nav-link" href="<%=request.getContextPath()%>/Login"> Login</a></li>

                </div>
            </ul>
        </div>

    </nav>
			</header>
<div align="center">

    <div class="container">


        <div class="container">
            <form action="<%=request.getContextPath()%>/Login" method = "post" class="m-auto" style="max-width:600px">
                <h3 class="my-4">Login Form</h3>
                <hr class="my-4" />
                <div class="form-group mb-3 row"><label for="username-2" class="col-md-5 col-form-label">Email:</label>
                    <div class="col-md-7"><input type="text" class="form-control form-control-lg" id="username-2" name="email" required></div>
                </div>
                <div class="form-group mb-3 row"><label for="password-3" class="col-md-5 col-form-label">Password:</label>
                    <div class="col-md-7"><input type="password" class="form-control form-control-lg" id="password-3" name="password" required></div>
                </div>
                <hr class="bg-transparent border-0 py-1" />
                <hr class="my-4" />
                <div class="form-group mb-3 row"><label for="login6" class="col-md-5 col-form-label"></label>
                    <div class="col-md-7"><button class="btn btn-success btn-lg" type="submit">Login</button></div>
                </div>
                <hr class="my-4" />

            </form>
        </div>

    </div>
</div>
</body>
</html>
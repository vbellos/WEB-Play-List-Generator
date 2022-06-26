<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/styles.jsp"%>
<head>
    <title>Register</title>
</head>
<body>
<%@ include file="navbar.jsp" %>
<br>
<br>
<div align="center">

    <div class="container  border rounded">
        <h3 class="text-center">Register Form</h3>
        <hr>
        <!-- <div class="container text-center"> -->
        <div class="container">

        <form action="<%= request.getContextPath() %>/Register" method="post" class="form-horizontal" >
            <fieldset>




                <!-- Text input-->
                <div class="control-group">
                    <label class="control-label" for="name">Name:</label>
                    <div class="controls">
                        <input id="name" name="name" type="text" placeholder="" class="input-xlarge" required="">

                    </div>
                </div>

                <!-- Text input-->
                <div class="control-group">
                    <label class="control-label" for="email">Email:</label>
                    <div class="controls">
                        <input id="email" name="email" type="text" placeholder="" class="input-xlarge" required="">

                    </div>
                </div>


                <!-- Password input-->
                <div class="control-group">
                    <label class="control-label" for="password">Password:</label>
                    <div class="controls">
                        <input id="password" name="password" type="password" placeholder="" class="input-xlarge" required="">

                    </div>
                </div>

                <br>

                <!-- Button -->
                <div class="control-group">
                    <input type="submit" value="Register" class="btn btn-success" />
                </div>
                <br>

            </fieldset>
        </form>
        </div>
    </div>
    </div>
</body>
</html>
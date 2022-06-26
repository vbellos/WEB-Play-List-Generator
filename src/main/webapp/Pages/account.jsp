
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Account</title>
    <%@include file="/WEB-INF/styles.jsp"%>
    <%@include file="navbar.jsp"%>
</head>
<body>


<%
    Dao dao = new Dao();
    User user = (User) session.getAttribute("user");

    if(user == null)
    {
        response.sendRedirect("./Login");
    }

%>
<br>
<br>

<div>

    <div class="container border rounded">
        <h3 class="text-center">My account</h3>
        <hr>
        <!-- <div class="container text-center"> -->
        <div class="container text-center">
            <form action="./Account" method="post" class="form-horizontal" content="text/html;charset=UTF-8" >
                <fieldset>


                    <div class="control-group">
                        <label class="control-label" for="name">Name:</label>
                        <div class="controls">
                            <input id="name" name="name" type="text" value="<%=user.getName()%>"  class="input-xlarge" required="">

                        </div>
                    </div>



                    <!-- Text input-->
                    <div class="control-group">
                        <label class="control-label" for="email">Email:</label>
                        <div class="controls">
                            <input id="email" name="email" type="text" value="<%=user.getEmail()%>" class="input-xlarge" required="">

                        </div>
                    </div>


                    <!-- Password input-->
                    <div class="control-group">
                        <label class="control-label" for="password">Password:</label>
                        <div class="controls">
                            <input id="password" name="password" type="password" value="<%=user.getPassword()%>" class="input-xlarge" required="">

                        </div>
                    </div>

                    <br>
                    <!-- Button -->
                    <div class="control-group">
                        <input type="submit" value="Update Info" class="btn btn-success" />
                    </div>

                </fieldset>
            </form>
        </div>
    </div>
    </div>

<br>

<div>

    <div class="container border rounded">
        <h3 class="text-center">Acount Type</h3>
        <hr>
        <!-- <div class="container text-center"> -->
        <div class="container text-center">
            <h3><%=user.getType().toUpperCase()%></h3>
            <%if(!dao.isUserPremium(user.getUser_id())) {%>
            <hr>
            <a href="Account?action=upgrade" class = "btn btn-outline-success">Upgrade</a>
            <%}%>
            <p></p>
        </div>
    </div>
</div>

</body>
</html>

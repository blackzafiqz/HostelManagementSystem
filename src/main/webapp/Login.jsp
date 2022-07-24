<%-- 
    Document   : Login
    Created on : 20 Jul 2022, 7:08:42 pm
    Author     : black
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <%@include file="Header.jsp" %>
        <script>
            function validate() {
                var username = document.form.username.value;
                var password = document.form.password.value;
                if (username == null || username == "") {
                    alert("Username cannot be blank");
                    return false;
                } else if (password == null || password == "") {
                    alert("Password cannot be blank");
                    return false;
                }
            }
        </script>

        <meta name="theme-color" content="#712cf9">


        <style>
            .bd-placeholder-img {
                font-size: 1.125rem;
                text-anchor: middle;
                -webkit-user-select: none;
                -moz-user-select: none;
                user-select: none;
            }

            @media (min-width: 768px) {
                .bd-placeholder-img-lg {
                    font-size: 3.5rem;
                }
            }

            .b-example-divider {
                height: 3rem;
                background-color: rgba(0, 0, 0, .1);
                border: solid rgba(0, 0, 0, .15);
                border-width: 1px 0;
                box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
            }

            .b-example-vr {
                flex-shrink: 0;
                width: 1.5rem;
                height: 100vh;
            }

            .bi {
                vertical-align: -.125em;
                fill: currentColor;
            }

            .nav-scroller {
                position: relative;
                z-index: 2;
                height: 2.75rem;
                overflow-y: hidden;
            }

            .nav-scroller .nav {
                display: flex;
                flex-wrap: nowrap;
                padding-bottom: 1rem;
                margin-top: -1px;
                overflow-x: auto;
                text-align: center;
                white-space: nowrap;
                -webkit-overflow-scrolling: touch;
            }
        </style>


        <link href="css/signin.css" rel="stylesheet">
    </head>
    <body class="text-center">

        <main class="form-signin w-100 m-auto">
            <form name="form" method="post" action="/LoginServlet" onsubmit="return validate()">>
                <img class="mb-4" src="images/LogoUiTM.png" alt="" width="300" height="100">
                <h1 class="h3 mb-3 fw-normal">Sign in</h1>
                <%
                    if (request.getParameter("invalid") != null) {
                        out.print(request.getParameter("invalid").equals("true") ? "<p style='color:red'>Invalid Login</p>" : "");
                    }
                    if (request.getParameter("signout") != null)
                        out.print(request.getParameter("signout").equals("true") ? "<p style='color:red'>Signed out</p>" : "");
                %>
                <div class="form-floating">
                    <input type="email" class="form-control" name="email" placeholder="name@example.com">
                    <label for="floatingInput">Email address</label>
                </div>
                <div class="form-floating">
                    <input type="password" class="form-control" name="password" placeholder="Password">
                    <label for="floatingPassword">Password</label>
                </div>

                <div class="checkbox mb-3">
                    <label>
                        <input type="checkbox" value="remember-me"> Remember me
                    </label>
                </div>
                <button class="w-100 btn btn-lg btn-primary" type="submit">Sign in</button>
                <p class="mt-5 mb-3 text-muted">&copy; 2017–2022</p>
            </form>
        </main>


        <%@include file="Footer.jsp" %>
    </body>
</html>


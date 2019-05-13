<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<html>
<head>
    <meta charset="utf-8">

    <link type="text/css" rel="stylesheet" href="http://localhost/PSGBD/public/css/Login-style.css"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--webfonts-->
    <link href="<spring:url value='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800' rel='stylesheet' type='text.css'/>"/>
    <!--//webfonts-->
</head>

<body>
<div class="main">
    <form action="<?php echo URL ?>Login/signIn" method="post">
        <h1><span>Employer</span> <lable> Login </lable> </h1>
        <div class="inset">
            <p>
                <label for="userName">USER NAME</label>
                <input type="text" placeholder="User Name" required/>
                <span class="help-block"><?php echo $data['name']; ?></span>
            </p>
            <p>
                <label for="password">PASSWORD</label>
                <input type="password" placeholder="password" required/>
                <span class="help-block"><?php echo $data['pass']; ?></span>
            </p>
            <p>
                <input type="checkbox" name="remember" id="remember">
                <label for="remember">Agree to Continue</label>
            </p>
        </div>

        <p class="p-container">
            <input type="submit" value="Login">
        </p>
    </form>
</div>
</body>
</html>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Bootstrap Example</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link type="text/css" rel="stylesheet" href="http://localhost/PSGBD/public/css/Home-style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>

<body>
<div class="content">
    <div class="colors">
        <a class="default" href="javascript:void(0)"></a>
        <a class="blue" href="javascript:void(0)"></a>
        <a class="green" href="javascript:void(0)"></a>
        <a class="red" href="javascript:void(0)"></a>
        <a class="white" href="javascript:void(0)"></a>
        <a class="black" href="javascript:void(0)"></a>
    </div>
    <div id="jquery-accordion-menu" class="jquery-accordion-menu">
        <div class="jquery-accordion-menu-header">Hopkins Hospital</div>
        <ul>
            <li class="active"><a href="http://localhost/PSGBD/Home"><i class="fa fa-home"></i>Home </a></li>
            <li><a href="http://localhost/PSGBD/Doctors"><i class="fa fa-user-md"></i>Doctors </a>
                <ul class="submenu">
                    <li><a href="http://localhost/PSGBD/Shifts">Shifts </a></li>
                    <li><a href="#">Hire </a></li>
                    <li><a href="#">Fire </a></li>
                    <li><a href="#">Book an OR </a></li>
                </ul>
            <li><a href="#"><i class="fa fa-address-card"></i>Wards</a><span
                    class="jquery-accordion-menu-label">20 </span></li>
            <li><a href="#"><i class="fa fa-users"></i>Pacients </a>
                <ul class="submenu">
                    <li><a href="#">Pacient file</a></li>
                    <li><a href="#">Add</a></li>
                    <li><a href="#">Discharge</a></li>
                    <li><a href="#">Under treatment </a></li>
                    <li><a href="#">Ordered by age </a></li>
                    <li><a href="#">Find by the assigned doctor</a></li>
                    <li><a href="#">Get number of hospitalizations</a></li>
                </ul>
            </li>
            <li><a href="#"><i class="fa fa-bed"></i>Rooms</a>
                <ul class="submenu">
                    <li><a href="#">Available rooms by ward</a></li>
                    <li><a href="#">Occupied </a></li>
                </ul>
            </li>
            <li><a href="#"><i class="fa fa-suitcase"></i>Portfolio </a>
                <ul class="submenu">
                    <li><a href="#">Web Design </a></li>
                    <li><a href="#">Graphics </a><span class="jquery-accordion-menu-label">10 </span></li>
                    <li><a href="#">Photoshop </a></li>
                    <li><a href="#">Programming </a></li>
                </ul>
            </li>
            <li><a href="#"><i class="fa fa-user"></i>About </a></li>
            <li><a href="#"><i class="fa fa-envelope"></i>Contact </a></li>
        </ul>
        <div class="jquery-accordion-menu-footer">Footer</div>
    </div>
</div>
<div class="main">
    <div class="logoHS"></div>
    <div class="DocMsg">In spital sunt angajati <?php
        echo ($data['num']."\n");
        ?> medici.</div>
    <div class="Med">
        <div class="DocTbl">Medicii atribuiti fiecarei sectii.</div>
        <table class="table table-hover table-dark">
            <thead>
            <tr>
                <th scope="col">Ward Name</th>
                <th scope="col">Nr. of Doctors</th>
            </tr>
            </thead>
            <tbody>
        <?php
        $i=0;
        foreach ($data['specs'] as $spec){
            echo ("<tr><td>".$spec ."</td><td>".$data['meds'][$i]."</td></tr>");
            $i=$i+1;
        }
        ?>
            </tbody>
        </table>
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="http://localhost/PSGBD/public/js/Home.js"></script>
</body>
</html>

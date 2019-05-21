<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Hopkins Hospital</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link type="text/css" rel="stylesheet" href="<?php echo URL ?>public/css/Home-style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css"
          integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
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
            <li class="active"><a href="<?php echo URL ?>Home"><i class="fa fa-home"></i>Home </a></li>
            <li><a href="<?php echo URL ?>Doctors"><i class="fa fa-user-md"></i>Doctors </a>
                <ul class="submenu">
                    <li><a href="<?php echo URL ?>Shifts">Shifts </a></li>
                    <li><a href="<?php echo URL ?>Hire">Hire </a></li>
                    <li><a href="#">Fire </a></li>
                    <li><a href="#">Book an OR </a></li>
                </ul>
            <li><a href="#"><i class="fa fa-procedures"></i>Wards</a><span
                    class="jquery-accordion-menu-label">20 </span></li>
            <li><a href="#"><i class="fa fa-user-injured"></i>Patients </a>
                <ul class="submenu">
                    <li><a href="#">Patient file</a></li>
                    <li><a href="<?php echo URL ?>AddPatient">Add patient</a></li>
                    <li><a href="#">Assign a room to a patient</a></li>
                    <li><a href="#">Hospitalize a patient</a></li>
                    <li><a href="#">Assign a treatment</a></li>
                    <li><a href="#">Discharge</a></li>
                    <li><a href="#">Under treatment </a></li>
                    <li><a href="#">Ordered by age </a></li>
                    <li><a href="#">Find by the assigned doctor</a></li>
                    <li><a href="<?php echo URL ?>NumberOfHospitalizations">Get number of hospitalizations</a></li>
                </ul>
            </li>
            <li><a href="#"><i class="fa fa-bed"></i>Rooms</a>
                <ul class="submenu">
                    <li><a href="<?php echo URL ?>FreeRooms">Available rooms by ward</a></li>
                    <li><a href="#">Occupied </a></li>
                </ul>
            </li>
            <li><a href="#"><i class="fa fa-pills"></i>Meds</a>
                <ul class="submenu">
                    <li><a href="#">Add a med </a></li>
                    <li><a href="#">Check stock </a></li>
                </ul>
            </li>
            <li><a href="#"><i class="fa fa-user"></i>About </a></li>
            <li><a href="#"><i class="fa fa-envelope"></i>Contact </a></li>
        </ul>
        <div class="jquery-accordion-menu-footer">Footer</div>
    </div>
</div>
<div class="main">
    <div class="DocMsg">Pagina de adaugare medic in baza de date.</div>

    <form action="<?php echo URL ?>Hire/Adaugare" method="post">
        <div class="CitireId">
            <div class="input-group flex-nowrap">
                <input type="text" class="form-control" placeholder="Nume" aria-label="last-name" name="last-name" aria-describedby="addon-wrapping">
            </div>
            <div class="input-group flex-nowrap">
                <input type="text" class="form-control" placeholder="Prenume" aria-label="first-name" name="first-name" aria-describedby="addon-wrapping">
            </div>
            <div class="input-group flex-nowrap">
                <input type="text" class="form-control" placeholder="Inceput tura" aria-label="begin" name="begin" aria-describedby="addon-wrapping">
            </div>
            <div class="input-group flex-nowrap">
                <input type="text" class="form-control" placeholder="Sfarsit tura" aria-label="end" name="end" aria-describedby="addon-wrapping">
            </div>
            <div class="input-group flex-nowrap">
                <input type="text" class="form-control" placeholder="Sectia" aria-label="ward" name="ward" aria-describedby="addon-wrapping">
            </div>
            <button type="submit" class="btn btn-dark">Adaugare</button>
        </div>
    </form>

</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="http://localhost/PSGBD/public/js/Home.js"></script>
</body>
</html>

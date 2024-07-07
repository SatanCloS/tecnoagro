<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Página de Bienvenida</title>
    <!-- <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet"> -->
    <style>
        body, html {
            height: 100%;
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
        }

        .bg-welcome {
            background: linear-gradient(to bottom, #ffffff, #d3d3d3);
            height: 100%;
            display: flex;
            justify-content: flex-start;
            align-items: flex-start;
            color: #343a40;
            text-align: center;
            padding-top: 20%;
            padding-left: 20px;
            padding-right: 20px;
        }

        .welcome-content {
            max-width: 600px;
            margin: 0 auto;
        }

        .welcome-title {
            font-size: 4rem;
            margin-bottom: 1rem;
            color: #343a40;
        }

        .welcome-text {
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
            color: #343a40;
        }

        .welcome-button {
            font-size: 1.2rem;
            padding: 10px 20px;
            color: #343a40;
            background-color: #ffffff;
            border: 1px solid #343a40;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s, color 0.3s;
        }

        .welcome-button:hover {
            background-color: #343a40;
            color: #ffffff;
        }
    </style>
</head>

<body>
    <div class="bg-welcome">
        <div class="welcome-content">
            <h1 class="welcome-title">¡Bienvenido!</h1>
            <p class="welcome-text">Estamos encantados de tenerte aquí. Explora y disfruta de nuestra página web.</p>
            <!-- <button class="welcome-button" onclick="location.href='homepage.html'">Ingresar</button> -->
        </div>
    </div>

    <!-- <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
</body>

</html>

<!DOCTYPE html>
<html>

<head>
    <title>Sistema web - Pentrix</title>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="X-UA-Compatible" content="IE=11">

    <!-- Bootstrap -->
    <link rel="stylesheet" href="plugins/bootstrap/css/bootstrap.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="plugins/sweetalert2/10.16.7/sweetalert2.min.css">

    <!-- Custom styles for datatable-->
    <link href="plugins/jquery.dataTables/css/jquery.dataTables.min.css" rel="stylesheet" />

    <!-- Jquery -->
    <script src="plugins/jquery/jquery.js"></script>

    <!-- Custom styles for datatable-->
    <script src="plugins/jquery.dataTables/js/jquery.dataTables.min.js?x=6"></script>

    <script src="plugins/sweetalert2/10.16.7/sweetalert2.all.min.js"> </script>
    <script src="plugins/sweetalert2/10.16.7/polyfill.js"> </script>

    <link rel="stylesheet" type="text/css" href="plugins/select2/select2.min.css">
	
    <script src="plugins/select2/select2.min.js"></script>

 
  <link href="plugins/css/ruang-admin.min.css" rel="stylesheet">

	<script type="text/javascript">
    function Cargar(url){
      $.post(url,
          function(data) {
              if ('' !== data) {
                  // here data is the content of the whole php page
                  // Inner HTML for php page content
                  $('#Contenido').empty().html(data);
              }
          }
      );
    }
  </script>

  

</head>

<body class="text-left" style="font-size:14px;">
	<header class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 shadow">
      <a class="navbar-brand col-md-3 col-lg-2 me-0 px-3" href="#">Pentrix WEB - v1.0</a>
      <button class="navbar-toggler position-absolute d-md-none collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
  </header>


<div class="container-fluid">
  <div class="row">


  <nav>


  <ul class="navbar-nav sidebar sidebar-light accordion" id="accordionSidebar">
     
      <hr class="sidebar-divider my-0">
      <li class="nav-item active">
        <a class="nav-link" href="#" onclick="Cargar('vista/homePage.php');" >
          <i class="fas fa-fw fa-tachometer-alt"></i>
          <span>Menú de Opciones</span>
        </a>
      </li>

      <hr class="sidebar-divider">
      <div class="sidebar-heading">
        Características
      </div>

      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseBootstrap"
          aria-expanded="true" aria-controls="collapseBootstrap">
          <i class="far fa-fw fa-window-maximize"></i>
          <span>Catálogo</span>
        </a>
        <div id="collapseBootstrap" class="collapse" aria-labelledby="headingBootstrap" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">


              <a class="collapse-item" href="#" onclick="Cargar('vista/linea.php');" >
                <span data-feather="file"></span>
                Línea
              </a>
 
              <a class="collapse-item" href="#" onclick="Cargar('vista/marca.php');" >
                <span data-feather="file"></span>
                Marca
              </a>
              
              <a class="collapse-item" href="#" onclick="Cargar('vista/articulo.php');" >
                <span data-feather="shopping-cart"></span>
                Artículo
              </a>

              <a class="collapse-item" href="#" onclick="Cargar('vista/tipopersona.php');" >
                <span data-feather="users"></span>
                Tipo Persona
              </a>

              <a class="collapse-item" href="#" onclick="Cargar('vista/proveedor.php');" >
                <span data-feather="bar-chart-2"></span>
                Proveedor
              </a>

              <!-- <a class="collapse-item" href="#" onclick="Cargar('vista/cliente.php');" >
                <span data-feather="layers"></span>
                Zona
              </a>

              <a class="collapse-item" href="#" onclick="Cargar('vista/cliente.php');" >
                <span data-feather="layers"></span>
                SubZona
              </a> -->

              <a class="collapse-item" href="#" onclick="Cargar('vista/cliente.php');" >
                <span data-feather="layers"></span>
                Cliente
              </a>

              <a class="collapse-item" href="#"  onclick="Cargar('vista/paginaEnConstruccion.php');" >
                <span data-feather="layers"></span>                
                <span style="color: red;">Vendedor</span>
              </a>

              <a class="collapse-item" href="#" onclick="Cargar('vista/banco.php');" >
                <span data-feather="layers"></span>
                Bancos
              </a>

              <a class="collapse-item" href="#"  onclick="Cargar('vista/cuenta.php');">
                <span data-feather="layers"></span>
                Cuentas
              </a>

              <a class="collapse-item" href="#" onclick="Cargar('vista/grupoconcepto.php');" >
                <span data-feather="layers"></span>
                Grupo de Conceptos
              </a>

              <a class="collapse-item" href="#" onclick="Cargar('vista/concepto.php');" >
                <span data-feather="layers"></span>
                Conceptos
              </a>

              <a class="collapse-item" href="#" onclick="Cargar('vista/sucursal.php');" >
                <span data-feather="layers"></span>
                Sucursal
              </a>

          </div>
        </div>
      </li>



      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseForm" aria-expanded="true"
          aria-controls="collapseForm">
          <i class="fab fa-fw fa-wpforms"></i>
          <span>Operaciones</span>
        </a>
        <div id="collapseForm" class="collapse" aria-labelledby="headingForm" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">Artículos</h6>
              <a class="collapse-item" href="#" onclick="Cargar('vista/compra.php');" >
                <span data-feather="layers"></span>
                
                <span style="color: red;">Ingresos o Compras</span>
              </a>

              <a class="collapse-item" href="#" onclick="Cargar('vista/venta.php');" >
                <span data-feather="layers"></span>
                
                <span style="color: red;">Salidas o Ventas</span>
              </a>

              
              <a class="collapse-item" href="#" onclick="Cargar('vista/paginaEnConstruccion.php');" >
                <span data-feather="layers"></span>
                
                <span style="color: red;">Traslados de Artículos</span>
              </a>

              <a class="collapse-item" href="#" onclick="Cargar('vista/paginaEnConstruccion.php');" >
                <span data-feather="layers"></span>
                
                <span style="color: red;">Proforma de Venta</span>
              </a>


              <a class="collapse-item" href="#" onclick="Cargar('vista/paginaEnConstruccion.php');" >
                <span data-feather="layers"></span>
                
                <span style="color: red;">Servicio Técnico/Garantías</span>
              </a>



              <h6 class="collapse-header">Clientes</h6>
              <a class="collapse-item" href="#" onclick="Cargar('vista/cuentasxcobrar.php');" >
                <span data-feather="layers"></span>
                Créditos Anteriores
              </a>

              <a class="collapse-item" href="#" onclick="Cargar('vista/AmortizacionCliente.php');" >
                <span data-feather="layers"></span>
                <span>Amortización</span>
              </a>

              <a class="collapse-item" href="#" onclick="Cargar('vista/paginaEnConstruccion.php');" >
                <span data-feather="layers"></span>
                
                <span style="color: red;">Nota de Crédito</span>
              </a>

              <h6 class="collapse-header">Proveedor</h6>
              <a class="collapse-item" href="#" onclick="Cargar('vista/cuentasxpagar.php');" >
                <span data-feather="layers"></span>
                Deudas Anteriores
              </a>            

              <a class="collapse-item" href="#" onclick="Cargar('vista/AmortizacionProveedor.php');" >
                <span data-feather="layers"></span>
                
                <span data-feather="layers"></span>Amortización</span>
              </a>

              <a class="collapse-item" href="#" onclick="Cargar('vista/paginaEnConstruccion.php');" >
                <span data-feather="layers"></span>
                
                <span style="color: red;">Nota de Crédito</span>
              </a>

              <a class="collapse-item" href="#" onclick="Cargar('vista/paginaEnConstruccion.php');" >
                <span data-feather="layers"></span>
                
                <span style="color: red;">Nota de Débito</span>
              </a>

              <h6 class="collapse-header">Caja y Bancos</h6>
              <a class="collapse-item" href="#" onclick="Cargar('vista/movimientoIngresoEgreso.php');" >
                <span data-feather="layers"></span>
                Mov. de Ingreso y Egreso
              </a> 


              <a class="collapse-item" href="#" onclick="Cargar('vista/transferenciaCuentas.php');" >
                <span data-feather="layers"></span>
                Transferencias
              </a> 

          </div>
        </div>
      </li>



      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTable" aria-expanded="true"
          aria-controls="collapseTable">
          <i class="fas fa-fw fa-table"></i>
          <span>Reportes</span>
        </a>
        <div id="collapseTable" class="collapse" aria-labelledby="headingTable" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">



              <h6 class="collapse-header">Stock</h6>            
              <a class="collapse-item" href="#" onclick="Cargar('vista/rpt_InventarioFisico.php');" >
                <span data-feather="file"></span>
                Inventario Físico
              </a>



              <a class="collapse-item" href="#" onclick="Cargar('vista/rpt_KardexFisico.php');" >
                <span data-feather="layers"></span>
                Kardex Físico
              </a>

              <h6 class="collapse-header">Ingresos</h6>
              <a class="collapse-item" href="#" onclick="Cargar('vista/paginaEnConstruccion.php');" >
                <span data-feather="layers"></span>
                
                <span style="color: red;">Compras Detalladas</span>
              </a>
              
              <a class="collapse-item" href="#" onclick="Cargar('vista/paginaEnConstruccion.php');" >
                <span data-feather="layers"></span>
                
                <span style="color: red;">Compras por Artículo</span>
              </a>
              
              <a class="collapse-item" href="#" onclick="Cargar('vista/paginaEnConstruccion.php');" >
                <span data-feather="layers"></span>
                
                <span style="color: red;">Compras por Proveedor</span>
              </a>
              
              <a class="collapse-item" href="#" onclick="Cargar('vista/paginaEnConstruccion.php');" >
                <span data-feather="layers"></span>
                
                <span style="color: red;">Resumen de Compras</span>
              </a>


              <h6 class="collapse-header">Salidas</h6>
              <a class="collapse-item" href="#" onclick="Cargar('vista/paginaEnConstruccion.php');" >
                <span data-feather="layers"></span>
                
                <span style="color: red;">Ventas detalladas</span>
              </a>
              
              <a class="collapse-item" href="#" onclick="Cargar('vista/paginaEnConstruccion.php');" >
                <span data-feather="layers"></span>
                
                <span style="color: red;">Ventas por Artículo</span>
              </a>
              
              <a class="collapse-item" href="#" onclick="Cargar('vista/paginaEnConstruccion.php');" >
                <span data-feather="layers"></span>
                
                <span style="color: red;">Ventas por Cliente</span>
              </a>   

              <a class="collapse-item" href="#" onclick="Cargar('vista/paginaEnConstruccion.php');" >
                <span data-feather="layers"></span>
                
                <span style="color: red;">Resumen de Ventas</span>
              </a>
              
              
              <a class="collapse-item" href="#" onclick="Cargar('vista/paginaEnConstruccion.php');" >
                <span data-feather="layers"></span>
                
                <span style="color: red;">Mayores Vendidos</span>
              </a>
              
             

              <h6 class="collapse-header">Translados</h6>
              <a class="collapse-item" href="#" onclick="Cargar('vista/paginaEnConstruccion.php');" >
                <span data-feather="layers"></span>
                
                <span style="color: red;">Utilidad Detallada</span>
              </a>
              
              <a class="collapse-item" href="#" onclick="Cargar('vista/paginaEnConstruccion.php');" >
                <span data-feather="layers"></span>
                
                <span style="color: red;">Utilidad Resumida</span>
              </a>


              <h6 class="collapse-header">Pedidos</h6>
              <a class="collapse-item" href="#" onclick="Cargar('vista/paginaEnConstruccion.php');" >
                <span data-feather="layers"></span>
                
                <span style="color: red;">Utilidad Detallada</span>
              </a>
              
              <a class="collapse-item" href="#" onclick="Cargar('vista/paginaEnConstruccion.php');" >
                <span data-feather="layers"></span>
                
                <span style="color: red;">Utilidad Resumida</span>
              </a>


              <h6 class="collapse-header">Soporte Técnico</h6>
              <a class="collapse-item" href="#" onclick="Cargar('vista/paginaEnConstruccion.php');" >
                <span data-feather="layers"></span>
                
                <span style="color: red;">Utilidad Detallada</span>
              </a>
              
              <a class="collapse-item" href="#" onclick="Cargar('vista/paginaEnConstruccion.php');" >
                <span data-feather="layers"></span>
                
                <span style="color: red;">Utilidad Resumida</span>
              </a>



              <h6 class="collapse-header">Clientes</h6>
              <a class="collapse-item" href="#" onclick="Cargar('vista/rpt_EECCCliente.php');" >
                <span data-feather="layers"></span>
                Estado de Cuenta
              </a>

            
              <a class="collapse-item" href="#" onclick="Cargar('vista/rpt_CuentasxCobrar.php');" >
                <span data-feather="layers"></span>
                Cuentas por Cobrar
              </a>

              <a class="collapse-item" href="#" onclick="Cargar('vista/paginaEnConstruccion.php');" >
                <span data-feather="layers"></span>
                
                <span style="color: red;">Record de Clientes</span>
              </a> 


              <h6 class="collapse-header">Proveedor</h6>
              <a class="collapse-item" href="#" onclick="Cargar('vista/rpt_EECCProveedor.php');" >
                <span data-feather="layers"></span>
                Estado de Cuenta
              </a>      
              
              <a class="collapse-item" href="#" onclick="Cargar('vista/rpt_cuentasPagar.php');" >
                <span data-feather="layers"></span>
                Cuentas por Pagar
              </a> 

              <a class="collapse-item" href="#" onclick="Cargar('vista/paginaEnConstruccion.php');" >
                <span data-feather="layers"></span>
                
                <span style="color: red;">Record de Proveedores</span>
              </a> 


              <h6 class="collapse-header">Caja y Bancos</h6>
              <a class="collapse-item" href="#" onclick="Cargar('vista/rpt_movimientoIngresoEgreso.php');" >
                <span data-feather="layers"></span>
                Mov. de Ingreso y Egreso
              </a> 
              
              <a class="collapse-item" href="#" onclick="Cargar('vista/rpt_saldosCuentas.php');" >
                <span data-feather="layers"></span>
                Saldos de Cuentas
              </a> 

              
              <a class="collapse-item" href="#" onclick="Cargar('vista/rpt_ConceptoIndividual.php');" >
                <span data-feather="layers"></span>
                Concepto Individual
              </a> 

              <a class="collapse-item" href="#" onclick="Cargar('vista/rpt_gastosDetallados.php');" >
                <span data-feather="layers"></span>
                Gastos Detallados
              </a>

              <a class="collapse-item" href="#" onclick="Cargar('vista/rpt_gastosResumen.php');" >
                <span data-feather="layers"></span>
                
                <span>Gastos Resumen</span>
              </a> 

          </div>
        </div>
      </li>


      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseGerencial" aria-expanded="true"
          aria-controls="collapseGerencial">
          <i class="fas fa-fw fa-chart-area"></i>
          <span>Gerencial</span>
        </a>
        <div id="collapseGerencial" class="collapse" aria-labelledby="headingGerencial" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">

              <!-- <h6 class="collapse-header">Procesar Información</h6>
              <a class="collapse-item" href="#" onclick="Cargar('vista/paginaEnConstruccion.php');" >
                <span data-feather="layers"></span>
                
                <span style="color: red;">Generar Información</span>
              </a> -->

              <h6 class="collapse-header">Balance</h6>
              <a class="collapse-item" href="#" onclick="Cargar('vista/paginaEnConstruccion.php');" >
                <span data-feather="layers"></span>
                
                <span style="color: red;">Balance General</span>
              </a>

              <a class="collapse-item" href="#" onclick="Cargar('vista/paginaEnConstruccion.php');" >
                <span data-feather="layers"></span>
                
                <span style="color: red;">Balance Resumido</span>
              </a>

              <a class="collapse-item" href="#" onclick="Cargar('vista/rpt_EGP.php');" >
                <span data-feather="layers"></span>
                
                <span>E.G.P.</span>
              </a>

              <h6 class="collapse-header">Utilidad</h6>
              <a class="collapse-item" href="#" onclick="Cargar('vista/rpt_UtilidadDetallada.php');" >
                <span data-feather="layers"></span>
                
                <span>Utilidad Detallada</span>
              </a>
              
              <a class="collapse-item" href="#" onclick="Cargar('vista/rpt_UtilidadResumida.php');" >
                <span data-feather="layers"></span>
                
                <span>Utilidad Resumida</span>
              </a>
              
              <h6 class="collapse-header">Valorados</h6>
              <a class="collapse-item" href="#" onclick="Cargar('vista/rpt_InventarioValorado.php');" >
                <span data-feather="layers"></span>
                
                <span">Inventario Valorado</span>
              </a>
              
              <a class="collapse-item" href="#" onclick="Cargar('vista/rpt_KardexValorado.php');" >
                <span data-feather="layers"></span>
                
                <span">Kardex Valorado</span>
              </a>

          </div>
        </div>
      </li> 




      <hr class="sidebar-divider">
      <div class="sidebar-heading">
        Administración del Sistema
      </div>
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePage" aria-expanded="true"
          aria-controls="collapsePage">
          <i class="fas fa-fw fa-columns"></i>
          <span>Usuarios/Permisos</span>
        </a>
        <div id="collapsePage" class="collapse" aria-labelledby="headingPage" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            
            <a class="collapse-item" href="#" onclick="Cargar('vista/paginaEnConstruccion.php');" >
              <span data-feather="layers"></span>
              
              <span style="color: red;">Usuarios</span>
            </a>

            <a class="collapse-item" href="#" onclick="Cargar('vista/paginaEnConstruccion.php');" >
              <span data-feather="layers"></span>
              
              <span style="color: red;">Cambio de Contraseña</span>
            </a>


          </div>
        </div>
      </li>


      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilitarios" aria-expanded="true"
          aria-controls="collapseUtilitarios">
          <i class="fas fa-fw fa-columns"></i>
          <span>Utilitarios</span>
        </a>
        <div id="collapseUtilitarios" class="collapse" aria-labelledby="headingPage" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">


            <a class="collapse-item" href="#" onclick="Cargar('vista/tipoCambio.php');" >
              <span data-feather="layers"></span>
              Tipo de cambio
            </a>

            <a class="collapse-item" href="#" onclick="Cargar('vista/paginaEnConstruccion.php');" >
              <span data-feather="layers"></span>
              
              <span style="color: red;">Cerrar fechas</span>
            </a>

            <a class="collapse-item" href="#" onclick="Cargar('vista/paginaEnConstruccion.php');" >
              <span data-feather="layers"></span>
              
              <span style="color: red;">Recalcular Stock</span>
            </a>

            <a class="collapse-item" href="#" onclick="Cargar('vista/tipodocumento.php');" >
                <span data-feather="shopping-cart"></span>
                Tipo de Documento
              </a>

              
            <a class="collapse-item" href="#" onclick="Cargar('vista/seriedocumento.php');" >
              <span data-feather="layers"></span>
              Serie de Documentos
            </a>

            <!-- <a class="collapse-item" href="#" onclick="#" >
              <span data-feather="layers"></span>
              Generar Backups
            </a>

            <a class="collapse-item" href="#" onclick="#" >
              <span data-feather="layers"></span>
              Datos de la Empresa
            </a> -->


          </div>
        </div>
      </li>




      <hr class="sidebar-divider">
      <div class="version" id="version-ruangadmin"></div>
    </ul>
    </nav>

    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4" id="Contenido">


  </main>
  </div>
</div>


<script src="plugins/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>




</body>



</html>


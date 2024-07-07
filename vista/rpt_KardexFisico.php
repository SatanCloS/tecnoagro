<!DOCTYPE html>
<html lang="en">

<head>
    <script type="text/javascript">
        "use strict";
        $(document).ready(function() {
            // Crear un objeto Date para el primer día del mes actual
            var primerDiaMes = new Date();
            primerDiaMes.setDate(1);

            // Obtener la fecha en formato "AAAA-MM-DD"
            var fechaFormato = primerDiaMes.toJSON().slice(0, 10);

            // Establecer el valor del elemento con id "txtFecha_ini"
            $('#txtDesde').val(fechaFormato);
            //$('#txtDesde').val(new Date().toJSON().slice(0, 10));

            $('#txtHasta').val(new Date().toJSON().slice(0, 10));
            $('#cboArticulo').val();
            $('#cboSucursal').val();

            $("#tituloLista").text("Reporte: Kardex Físico");
            //$("#tituloMantenimiento").text("Gestión de Ingresos o Compras");
            $("#identificador").val("Reporte: Kardex Físico");

            Listar();

            //Filtros
            $("#cboArticulo").select2();
            ListarCboArticulo();

            $("#cboSucursal").select2();
            ListarCboSucursal();

            $("#btnConsultar").click(function() {
                Listar();
            })
        })


        function Listar() {
            $.ajax({
                url: "controlador/contLogistica.php",
                type: "POST",
                data: {
                    "accion": "KardexFisico",
                    "txtDesde": $('#txtDesde').val(),
                    "txtHasta": $('#txtHasta').val(),
                    "cboArticulo": $("#cboArticulo").val(),
                    "cboSucursal": $('#cboSucursal').val()
                },
                //console.log(data);
                //async: true,
                success: function(data) {
                    var data = JSON.parse(data);
                    //console.log(data);
                    var $cuerpo = "";
                    if (data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            var fecha = data[i].fecha !== null ? data[i].fecha : '';
                            var ingreso = data[i].ingreso == 0 ? '' : data[i].ingreso;
                            var salida = data[i].salida == 0 ? '' : data[i].salida;

                            $cuerpo += "<tr>";
                            $cuerpo += "<td>" + fecha + "</td>";
                            $cuerpo += "<td>" + data[i].documento + "</td>";
                            $cuerpo += "<td>" + data[i].cliprov + "</td>";
                            $cuerpo += "<td align='right'>" + ingreso + "</td>";
                            $cuerpo += "<td align='right'>" + salida + "</td>";
                            $cuerpo += "<td align='right'>" + data[i].saldo + "</td>";                            
                            $cuerpo += "<td style='display: none;'>" + data[i].fila + "</td>"; 
                            $cuerpo += "</tr>";
                        }
                    }
                   // console.log($cuerpo)
                    $("#tCXC").DataTable().destroy();
                    $("#tbCXC").html($cuerpo);
                    $("#tCXC").DataTable({
                        "processing": true,
                        'dom': 'Blfrtip',
                        'buttons': [
                            /*'copy',*/
                            {
                                "extend": 'excel',
                                "text": '<i class="fa fa-file-excel"></i> Exportar a Excel',
                                "className": 'btn btn-sm btn-radius btn-success mb-2',
                                "title": 'Listado'
                            }, {
                                "extend": 'pdf',
                                "text": '<i class="fa fa-file-pdf"></i> Exportar a PDF',
                                "className": 'btn btn-sm btn-radius btn-danger mb-2',
                                "title": 'Listado'
                            }
                        ],
                        "language": {
                            "url": "plugins/jquery.dataTables/Spanish.json"
                        },
                        columnDefs: [{
                            orderable: false,
                            targets: 2
                        }],
                        "order": [[6, 'asc']]

                    });
                    //loading(false);
                },
                error: function(result) {
                    console.log(result);
                }
            });
        }


        function ListarCboArticulo() {
            $.ajax({
                url: "controlador/contArticulo.php",
                type: "POST",
                data: {
                    "accion": "Listar"
                },
                success: function(data) {
                    var data = JSON.parse(data);
                    //console.log(data);
                    var $cuerpo = "";
                    if (data.length > 0) {
                        $cuerpo += "<option value='0'>- SELECCIONE -</option>";
                        for (var i = 0; i < data.length; i++) {
                            $cuerpo += "<option value='" + data[i].codigo + "'>" + data[i].nombre + "</option>";
                        }
                    }
                    $("#cboArticulo").html($cuerpo);
                },
                error: function(result) {
                    console.log(result);
                }
            });
        }


        function ListarCboSucursal() {
            $.ajax({
                url: "controlador/contSucursal.php",
                type: "POST",
                data: {
                    "accion": "Listar"
                },
                success: function(data) {
                    var data = JSON.parse(data);
                    //console.log(data);
                    var $cuerpo = "";
                    if (data.length > 0) {
                        $cuerpo += "<option value='0'>- SELECCIONE -</option>";
                        for (var i = 0; i < data.length; i++) {
                            $cuerpo += "<option value='" + data[i].codigo + "'>" + data[i].nombre + "</option>";
                        }
                    }
                    $("#cboSucursal").html($cuerpo);

                },
                error: function(result) {
                    console.log(result);
                }
            });
        }

        function Alerta(tipo, titulo, texto) {
            Swal.fire({
                confirmButtonColor: '#007bff',
                icon: tipo,
                title: titulo,
                text: texto
                    //footer: '<a href>Why do I have this issue?</a>'
            })
        }

        function fnLimpiar() {
            // $("#hdcod").val("0");
            // //$("#txtfecha_mop").val("");
            // $("#txtObservacion_mop").val("");
        }

    </script>
</head>

<body class="hold-transition sidebar-mini layout-fixed">
    <div class="wrapper">

        <!-- /.content-header -->
        <section class="content pt-2">
            <div class="container-fluid">
                <div class="row" id="Lista">
                    <div class="col-md-12 col-sm-12">
                        <div class="card shadow">
                            <!-- Card Header - Dropdown -->
                            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                <div class="col-sm-8">
                                    <h5 class="col-sm-8 text-left" class="m-0" id="tituloLista"></h5>
                                </div>
                            </div>


                            <!-- <div class="card-header">
                                <div class="form-row mb-12">
                                    <label for="txtDesde" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                       Fecha Incial: </label>
                                    <div class="col-sm-2 col-md-2">
                                        <input type="date" class="form-control form-control-sm" id="txtDesde" name="txtDesde" maxlength="10"  />
                                    </div>

                                    <label for="txtHasta" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                       Fecha Incial: </label>
                                    <div class="col-sm-2 col-md-2">
                                        <input type="date" class="form-control form-control-sm" id="txtHasta" name="txtHasta" maxlength="10"  />
                                    </div>

                                    <div class="col-sm-2 text-right">
                                        <button type="button" id="btnConsultar" class="btn btn-sm btn-primary btn-radius">
                                        <i class="fas fa-plus-square"></i><span>&nbsp;Consultar</span></button>
                                    </div>
                                </div> -->

                            <div class="card-header">
                                <div class="form-row mb-12">
                                    <label for="txtDesde" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                       Fecha Incial: </label>
                                    <div class="col-sm-2 col-md-2">
                                        <input type="date" class="form-control form-control-sm" id="txtDesde" name="txtDesde" maxlength="10"  />
                                    </div>
                                
                                    <label for="txtHasta" class="col-sm-1 col-form-label-sm" style="text-align:right" >
                                       Fecha Final: </label>
                                    <div class="col-sm-2 col-md-2">
                                        <input type="date" class="form-control form-control-sm" id="txtHasta" name="txtHasta" maxlength="10"  />
                                    </div>

                                    <div class="col-sm-2 text-right">
                                        <button type="button" id="btnConsultar" class="btn btn-sm btn-primary btn-radius">
                                        <i class="fas fa-plus-square"></i><span>&nbsp;Consultar</span></button>
                                    </div>
                                </div>

                                <div class="form-row mb-12">
                                    <label for="txtArticulo" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                    Artículo: </label>
                                    <div class="col-sm-4">
                                        <select class="cboArticulo form-control" style="width:460px" id="cboArticulo" name="cboArticulo"></select>
                                    </div>
                                </div>

                                <div class="form-row mb-12">
                                    <label for="txtSucursal" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                    Sucursal: </label>
                                    <div class="col-sm-4">
                                        <select class="cboSucursal form-control" style="width:460px" id="cboSucursal" name="cboSucursal"></select>
                                    </div>
                                </div>

                            </div>

                            <!--- <div class="card-body pL-2 pr-2">-->
                            <div class="card-body">
                                <div class="table-responsive" style="font-size: 11px;">
                                    <table id="tCXC" class="display compact order-column form-control-sm" style="width:98%;">
                                        <thead>
                                            <tr>
                                                <th style="width: 10%; text-align:center;">
                                                    Fecha
                                                </th>
                                                <th style="width: 20%; text-align:center;">
                                                    Documento
                                                </th>
                                                <th style="width: 40%; text-align:center;">
                                                    Persona
                                                </th>
                                                <th style="width: 10%; text-align:right;">
                                                    Ingreso
                                                </th>
                                                <th style="width: 10%; text-align:right;">
                                                    Salida
                                                </th>
                                                <th style="width: 10%; text-align:right;">
                                                    Saldo
                                                </th>
                                                <th style="width: 1%; text-align:center; visibility: hidden;">
                                                    fila
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbCXC">
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /.container-fluid -->
        </section>
        <!-- /.content -->
    </div>
</body>
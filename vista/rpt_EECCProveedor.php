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
            $('#txtHasta').val(new Date().toJSON().slice(0, 10));
            $('#cboProveedor').val();
            $('#cboSucursal').val();

            $("#tituloLista").text("Reporte: Estado de Cuenta de Proveedor");
            //$("#tituloMantenimiento").text("Gestión de Ingresos o Compras");
            $("#identificador").val("Reporte: Estado de Cuenta de Proveedor");

            Listar();

            //Filtros
            $("#cboProveedor").select2();
            ListarCboProveedor();

            $("#cboSucursal").select2();
            ListarCboSucursal();

            $("#btnConsultar").click(function() {
                Listar();
            })
        })


        function Listar() {
            $.ajax({
                url: "controlador/contEECCCliente.php",
                type: "POST",
                data: {
                    "accion": "EstadoCuentaProveedor",
                    "txtDesde": $('#txtDesde').val(),
                    "txtHasta": $('#txtHasta').val(),
                    "cboProveedor": $("#cboProveedor").val(),
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
                            var ingreso_soles = data[i].ingreso_soles == 0 ? '' : data[i].ingreso_soles;
                            var salida_soles = data[i].salida_soles == 0 ? '' : data[i].salida_soles;

                            var ingreso_dolar = data[i].ingreso_dolar == 0 ? '' : data[i].ingreso_dolar;
                            var salida_dolar = data[i].salida_dolar == 0 ? '' : data[i].salida_dolar;

                            $cuerpo += "<tr>";
                            $cuerpo += "<td>" + fecha + "</td>";
                            $cuerpo += "<td>" + data[i].documento + "</td>";
                            $cuerpo += "<td>" + data[i].detalle + "</td>";
                            $cuerpo += "<td align='right'>" + ingreso_soles + "</td>";
                            $cuerpo += "<td align='right'>" + salida_soles + "</td>";
                            $cuerpo += "<td align='right'>" + data[i].saldo_soles + "</td>";  
                            $cuerpo += "<td align='right'>" + ingreso_dolar + "</td>";
                            $cuerpo += "<td align='right'>" + salida_dolar + "</td>";
                            $cuerpo += "<td align='right'>" + data[i].saldo_dolar + "</td>";                                                        
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
                        "order": [[9, 'asc']]

                    });
                    //loading(false);
                },
                error: function(result) {
                    console.log(result);
                }
            });
        }


        function ListarCboProveedor() {
            $.ajax({
                url: "controlador/contProveedor.php",
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
                    $("#cboProveedor").html($cuerpo);
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


                            <div class="card-header">
                                <div class="form-row mb-12">
                                    <!-- <label for="txtDesde" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                       Fecha Incial: </label>
                                    <div class="col-sm-2 col-md-2">
                                        <input type="date" class="form-control form-control-sm" id="txtDesde" name="txtDesde" maxlength="10"  />
                                    </div>

                                    <label for="txtHasta" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                       Fecha Incial: </label>
                                    <div class="col-sm-2 col-md-2">
                                        <input type="date" class="form-control form-control-sm" id="txtHasta" name="txtHasta" maxlength="10"  />
                                    </div> -->

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
                                    <label for="lblProveedor" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                    Proveedor: </label>
                                    <div class="col-sm-4">
                                        <select class="cboCliente form-control" style="width:460px" id="cboProveedor" name="cboProveedor"></select>
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
                                                <th style="width: 8%; text-align:center;">Fecha</th>
                                                <th style="width: 10%; text-align:center;">Documento</th>
                                                <th style="width: 40%; text-align:center;">Detalle</th>
                                                <th style="width: 7%; text-align:right;">Deuda S/.</th>
                                                <th style="width: 7%; text-align:right;">Pago S/.</th>
                                                <th style="width: 7%; text-align:right;">Saldo S/.</th>
                                                <th style="width: 7%; text-align:right;">Deuda $</th>
                                                <th style="width: 7%; text-align:right;">Pago $</th>
                                                <th style="width: 7%; text-align:right;">Saldo $</th>
                                                <th style="width: 1%; text-align:center; visibility: hidden;">fila</th>
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
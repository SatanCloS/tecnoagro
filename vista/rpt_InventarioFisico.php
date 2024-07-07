<!DOCTYPE html>
<html lang="en">

<head>
    <script type="text/javascript">
        "use strict";
        $(document).ready(function() {
            $('#txtHasta').val(new Date().toJSON().slice(0, 10));
            $('#cboLinea').val();
            $('#cboSucursal').val();

            $("#tituloLista").text("Reporte: Inventario Físico");
            //$("#tituloMantenimiento").text("Gestión de Ingresos o Compras");
            $("#identificador").val("Reporte: Inventario Físico");

            Listar();

            //Filtros
            $("#cboLinea").select2();
            ListarCboLinea();

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
                    "accion": "InventarioFisico",
                    "txtHasta": $('#txtHasta').val(),
                    "cboLinea": $("#cboLinea").val(),
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
                            $cuerpo += "<tr>";
                            $cuerpo += "<td>" + data[i].codigo + "</td>";
                            $cuerpo += "<td>" + data[i].articulo + "</td>";
                            $cuerpo += "<td>" + data[i].unidadm + "</td>";
                            $cuerpo += "<td>" + data[i].linea + "</td>";
                            $cuerpo += "<td>" + data[i].stock + "</td>";
                            $cuerpo += "</tr>";
                        }
                    }
                   // console.log($cuerpo)
                    $("#tCXC").DataTable().destroy();
                    $("#tbCXC").html($cuerpo);
                    $("#tCXC").DataTable({
                        "lengthMenu": [[100, 50, 25, -1], [100, 50, 25, "All"]],
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
                        "order": [[2, 'desc']]

                    });
                    //loading(false);
                },
                error: function(result) {
                    console.log(result);
                }
            });
        }


        function ListarCboLinea() {
            $.ajax({
                url: "controlador/contLinea.php",
                type: "POST",
                data: {
                    "accion": "ListarTodos"
                },
                success: function(data) {
                    var data = JSON.parse(data);
                    //console.log(data);
                    var $cuerpo = "";
                    if (data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            $cuerpo += "<option value='" + data[i].codigo + "'>" + data[i].nombre + "</option>";
                        }
                    }
                    $("#cboLinea").html($cuerpo);
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
                    "accion": "ListarTodos"
                },
                success: function(data) {
                    var data = JSON.parse(data);
                    //console.log(data);
                    var $cuerpo = "";
                    if (data.length > 0) {
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
                                    <label for="txtHasta" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                       Fecha Incial: </label>
                                    <div class="col-sm-2 col-md-2">
                                        <input type="date" class="form-control form-control-sm" id="txtHasta" name="txtHasta" maxlength="10"  />
                                    </div>

                                    <div class="col-sm-2 text-right">
                                        <button type="button" id="btnConsultar" class="btn btn-sm btn-primary btn-radius">
                                        <i class="fas fa-plus-square"></i><span>&nbsp;Consultar</span></button>
                                    </div>
                                </div>

                                <div class="form-row mb-12">
                                    <label for="txtLinea" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                    Línea: </label>
                                    <div class="col-sm-4">
                                        <select class="cboLinea form-control" style="width:460px" id="cboLinea" name="cboLinea"></select>
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
                                                    Código
                                                </th>
                                                <th style="width: 50%; text-align:center;">
                                                    Artículo
                                                </th>
                                                <th style="width: 10%; text-align:center;">
                                                    Unidad M.
                                                </th>
                                                <th style="width: 20%; text-align:center;">
                                                    Línea
                                                </th>
                                                <th style="width: 10%; text-align:center;">
                                                    Stock
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
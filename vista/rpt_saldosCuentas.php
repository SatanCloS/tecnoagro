<!DOCTYPE html>
<html lang="en">

<head>
    <script type="text/javascript">
        "use strict";
        $(document).ready(function() {
            $('#txtfecha_ini').val(new Date().toJSON().slice(0, 10));
            $('#cboSucursal').val();

            $("#tituloLista").text("Reporte: Saldos de Cuentas");
            //$("#tituloMantenimiento").text("Gestión de Ingresos o Compras");
            $("#identificador").val("Reporte: Saldos de Cuentas");

            Listar();

            //Filtros
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
                    "accion": "saldosCuentas",
                    "txtfecha_ini": $('#txtfecha_ini').val(),
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
                            var soles = data[i].soles == 0 ? '' : data[i].soles;
                            var dolar = data[i].dolar == 0 ? '' : data[i].dolar;

                            $cuerpo += "<tr>";
                            $cuerpo += "<td>" + data[i].codigo + "</td>";
                            $cuerpo += "<td>" + data[i].cuenta + "</td>";
                            $cuerpo += "<td>" + data[i].banco + "</td>";
                            $cuerpo += "<td align='right'>" + soles + "</td>";
                            $cuerpo += "<td align='right'>" + dolar + "</td>";                           
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
                        "order": [[0, 'asc']]

                    });
                    //loading(false);
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
                                    <label for="txtfecha_ini" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                       Fecha Incial: </label>
                                    <div class="col-sm-2 col-md-2">
                                        <input type="date" class="form-control form-control-sm" id="txtfecha_ini" name="txtfecha_ini" maxlength="10"  />
                                    </div>

                                    
                                    <div class="col-sm-2 text-right">
                                        <button type="button" id="btnConsultar" class="btn btn-sm btn-primary btn-radius">
                                        <i class="fas fa-plus-square"></i><span>&nbsp;Consultar</span></button>
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
                                                <th style="width: 10%; text-align:center;">Codigo</th>
                                                <th style="width: 40%; text-align:center;">Cuenta</th>
                                                <th style="width: 30%; text-align:center;">Banco</th>
                                                <th style="width: 10%; text-align:right;">Soles S/.</th>
                                                <th style="width: 10%; text-align:right;">Dolares S/.</th>
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
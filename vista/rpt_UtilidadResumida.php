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
            $('#cboSucursal').val();

            $("#tituloLista").text("Reporte: Utilidad Resumida");
            $("#identificador").val("Reporte: Utilidad Resumida");

            Listar();

            //Filtros
            $("#cboSucursal").select2();
            ListarCboSucursal();

            $("#btnConsultar").click(function() {
                if (validar() == true) {
                    Listar();
                }
            })
        })



        function Listar() {
            $.ajax({
                url: "controlador/contGerencial.php",
                type: "POST",
                data: {
                    "accion": "utilidadResumida",
                    "txtDesde": $('#txtDesde').val(),
                    "txtHasta": $('#txtHasta').val(),
                    "cboSucursal": $('#cboSucursal').val()
                },
                success: function(data) {
                    var data = JSON.parse(data);
                    var groupedData = groupByLinea(data);
                    var $cuerpo = "";

                    for (var linea in groupedData) {
                        var Data = groupedData[linea];

                        // Inicializa los totales
                        var totalCantidad = 0;
                        var totalImporte = 0;
                        var totalUtilidad = 0;
                        
                        $cuerpo += "<tr>";
                        $cuerpo += "<td colspan='5' style='text-align:left; background-color:#f0f0f0;'><strong>" + linea + "</strong></td>";
                        $cuerpo += "</tr>";
                       
                        for (var i = 0; i < Data.length; i++) {
                            $cuerpo += "<tr>";
                            $cuerpo += "<td>" + Data[i].articulo + "</td>";
                            $cuerpo += "<td align='right'>" + Data[i].cantidad + "</td>";
                            $cuerpo += "<td align='right'>" + Data[i].importe + "</td>";
                            $cuerpo += "<td align='right'>" + Data[i].costo + "</td>";
                            $cuerpo += "<td align='right'>" + Data[i].utilidad + "</td>";
                            $cuerpo += "</tr>";

                            // Suma los valores a los totales
                            totalCantidad += parseFloat(Data[i].cantidad);
                            totalImporte += parseFloat(Data[i].importe);
                            totalUtilidad += parseFloat(Data[i].utilidad);
                        }

                         // Agrega la fila de totales para el artículo actual
                        $cuerpo += "<tr>";
                        $cuerpo += "<td style='text-align:right;'><strong>Totales:</strong></td>";
                        $cuerpo += "<td align='right'><strong>" + totalCantidad.toFixed(2) + "</strong></td>";
                        // $cuerpo += "<td></td>";
                        $cuerpo += "<td align='right'><strong>" + totalImporte.toFixed(2) + "</strong></td>";
                        $cuerpo += "<td></td>";
                        $cuerpo += "<td align='right'><strong>" + totalUtilidad.toFixed(2) + "</strong></td>";
                        $cuerpo += "</tr>";
                        
                    }
                    $("#tCXC").DataTable().destroy();
                    $("#tbCXC").html($cuerpo);
                    $("#tCXC").DataTable({
                        "lengthMenu": [[100, 50, 25, -1], [100, 50, 25, "All"]],
                        "processing": true,
                        'dom': 'Blfrtip',
                        'buttons': [
                            {
                                "extend": 'excel',
                                "text": '<i class="fa fa-file-excel"></i> Exportar a Excel',
                                "className": 'btn btn-sm btn-radius btn-success mb-2',
                                "title": 'Listado'
                            }, 
                            {
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
                    });
                },
                error: function(result) {
                    console.log(result);
                }
            });
        }

        function groupByLinea(data) {
            return data.reduce((result, item) => {
                (result[item.linea] = result[item.linea] || []).push(item);
                return result;
            }, {});
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

        function validar() {
            var titulo = 'Validación de Kardex valorado';
        
            if ($("#cboSucursal").val().trim() == '0') {
                msgAlerta('error', 'Debe seleccionar una sucursal', titulo);
                $("#cboSucursal").focus();
                return false;
            }

            return true;
        }

        function msgAlerta(tipo, texto, titulo) {
            Swal.fire({
                confirmButtonColor: '#007bff',
                icon: tipo,
                title: titulo,
                text: texto
                    //footer: '<a href>Why do I have this issue?</a>'
            });
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
                                    <label for="txtDesde" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                       Fecha Incial: </label>
                                    <div class="col-sm-2 col-md-2">
                                        <input type="date" class="form-control form-control-sm" id="txtDesde" name="txtDesde" maxlength="10"  />
                                    </div>

                                    <label for="txtHasta" class="col-sm-1 col-form-label-sm" style="text-align:right" >
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
                                                <th style="width: 60%; text-align:center;">Articulo</th>
                                                <th style="width: 10%; text-align:right;">Cantidad</th>
                                                <th style="width: 10%; text-align:right;">Importe</th>
                                                <th style="width: 10%; text-align:right;">Costo</th>
                                                <th style="width: 10%; text-align:right;">Utilidad</th>
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
<!DOCTYPE html>
<html lang="en">

<head>
    <script type="text/javascript">
        "use strict";
        $(document).ready(function() {
            $('#txtFecha').val(new Date().toJSON().slice(0, 10));
            $('#cboSucursal').val();

            $("#tituloLista").text("Reporte: Inventario Valorado");
            $("#identificador").val("Reporte: Inventario Valorado");

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
                    "accion": "inventario_valorado",
                    "txtFecha": $('#txtFecha').val(),
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
                            var costo = data[i].costo == 0 ? '' : data[i].costo;
                            $cuerpo += "<tr>";
                            $cuerpo += "<td>" + data[i].linea + "</td>";
                            $cuerpo += "<td>" + data[i].articulo + "</td>";
                            $cuerpo += "<td>" + data[i].medida + "</td>";
                            $cuerpo += "<td align='right'>" + data[i].stock  + "</td>";
                            $cuerpo += "<td align='right'>" + costo + "</td>";
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
                        //"order": [[0, 'asc']]

                    });
                    //loading(false);
                },
                error: function(result) {
                    console.log(result);
                }
            });
        }


        // function ListarCboArticulo() {
        //     $.ajax({
        //         url: "controlador/contArticulo.php",
        //         type: "POST",
        //         data: {
        //             "accion": "Listar"
        //         },
        //         success: function(data) {
        //             var data = JSON.parse(data);
        //             //console.log(data);
        //             var $cuerpo = "";
        //             if (data.length > 0) {
        //                 $cuerpo += "<option value='0'>- SELECCIONE -</option>";
        //                 for (var i = 0; i < data.length; i++) {
        //                     $cuerpo += "<option value='" + data[i].codigo + "'>" + data[i].nombre + "</option>";
        //                 }
        //             }
        //             $("#cboArticulo").html($cuerpo);
        //         },
        //         error: function(result) {
        //             console.log(result);
        //         }
        //     });
        // }

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
                                    <label for="lblFecha" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                       Hasta: </label>
                                    <div class="col-sm-2 col-md-2">
                                        <input type="date" class="form-control form-control-sm" id="txtFecha" name="txtFecha" maxlength="10"  />
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
                                                <th style="width: 20%; text-align:center;">Línea</th>
                                                <th style="width: 50%; text-align:center;">Artículo</th>
                                                <th style="width: 10%; text-align:center;">Und. Med.</th>
                                                <th style="width: 10%; text-align:right;">Stock</th>
                                                <th style="width: 10%; text-align:right;">Costo</th>                                                
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
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
            $('#txtFecha_ini').val(fechaFormato);
            //$('#txtFecha_ini').val(new Date().toJSON().slice(0, 10));

            $('#txtFecha_fin').val(new Date().toJSON().slice(0, 10));
            $('#txtfechaIngreso_reg').val(new Date().toJSON().slice(0, 10));
            $('#txtfechaEmision_reg').val(new Date().toJSON().slice(0, 10));

            $('#cboProveedor').val();
            $('#cboSucursal').val();

            $("#mdRegistro").hide();
            // $("#mdListarSucursal").hide();
            // $("#mdListarProveedor").hide();
            // $("#mdListarTipoDocumento").hide();
            // $("#mdListarMoneda").hide();

            $("#tituloLista").text("Listado de Ingresos o Compras");
            $("#tituloMantenimiento").text("Gestión de Ingresos o Compras");
            $("#identificador").val("Tipo de Ingresos o Compras");

            Listar();

            //Filtros
            $("#cboProveedor").select2();
            ListarCboProveedor();

            $("#cboSucursal").select2();
            ListarCboSucursal();


            //Objetos de Registro
            $("#cboSucursal_reg").select2();
            ListarCboSucursal_reg();

            $("#cboProveedor_reg").select2();
            ListarCboProveedor_reg();

            $("#cboTipoDocumento_reg").select2();
            ListarCboTipoDocumento_reg();

            $("#cboMoneda_reg").select2();
            ListarCboMoneda_reg();

            $("#cboCondicion_reg").select2();
            ListarCboCondicion_reg();





            $("#btnConsultar").click(function() {
                Listar();
            })


            $("#btnNuevo").click(function() {
                //fnLimpiar();
                $("#Lista").hide();
                $("#mdRegistro").show();
                // $("#mdListarSucursal").hide();
                // $("#mdListarTipoProveedor").hide();
                // $("#mdListarDocumento").hide();
                // $("#mdListarMoneda").hide();

                // $("#txtNombre").focus();
            })

            $("#btnGuardar").click(function() {
                //ConfirmarGuardar();
            });

            $("#btnCancelar").click(function() {
                //loading(true);

                $("#Lista").show();
                $("#mdRegistro").hide();
                // $("#mdListarSucursal").hide();
                // $("#mdListarProveedor").hide();
                // $("#mdListarTipoDocumento").hide();
                // $("#mdListarMoneda").hide();
                // // //Listar();
                // // //loading(false);
            });

        //     //loading(false);
        })


        function Listar() {
            $.ajax({
                url: "controlador/contCompra.php",
                type: "POST",
                data: {
                    "accion": "Listar",
                    "txtFecha_ini": $('#txtFecha_ini').val(),
                    "txtFecha_fin": $('#txtFecha_fin').val(),
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
                            $cuerpo += "<tr>";
                            $cuerpo += "<td align='center'>" + (i + 1) + "</td>";
                            $cuerpo += "<td>" + data[i].documento + "</td>";
                            $cuerpo += "<td>" + data[i].fecha + "</td>";
                            $cuerpo += "<td>" + data[i].proveedor + "</td>";
                            $cuerpo += "<td>" + data[i].condicion + "</td>";
                            $cuerpo += "<td>" + data[i].moneda + "</td>";
                            $cuerpo += "<td align='right'>" + data[i].importe + "</td>";
                            $cuerpo += "<td style='font-size:10px; text-align:center;'>";
                            $cuerpo += "<button type='button' class='btn btn-info btn-sm btn-radius' onclick='Editar(" + data[i].codigo + ")' title='Editar' ><i class='fas fa-edit small'></i></button>";
                            $cuerpo += " <button type='button' class='btn btn-danger btn-sm btn-radius' onclick='ConfirmarEliminar(" + data[i].codigo + ")' title='Eliminar'><i class='fa fa-trash-alt small'></i></button>";
                            $cuerpo += "</td>";
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
                        }]

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


        function ListarCboSucursal_reg() {
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
                    $("#cboSucursal_reg").html($cuerpo);

                },
                error: function(result) {
                    console.log(result);
                }
            });
        }

        function ListarCboProveedor_reg() {
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
                    $("#cboProveedor_reg").html($cuerpo);

                },
                error: function(result) {
                    console.log(result);
                }
            });
        }

        function ListarCboTipoDocumento_reg() {
            $.ajax({
                url: "controlador/contTipoDocumento.php",
                type: "POST",
                data: {
                    "accion": "Listar",
                    "accionBuscar":"B",
                    "tipo":"I",
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
                    $("#cboTipoDocumento_reg").html($cuerpo);

                },
                error: function(result) {
                    console.log(result);
                }
            });
        }

        function ListarCboMoneda_reg() {
            $.ajax({
                url: "controlador/contMoneda.php",
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
                    $("#cboMoneda_reg").html($cuerpo);

                },
                error: function(result) {
                    console.log(result);
                }
            });
        }


        function ListarCboCondicion_reg() {
            $.ajax({
                url: "controlador/contCondicion.php",
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
                    $("#cboCondicion_reg").html($cuerpo);

                },
                error: function(result) {
                    console.log(result);
                }
            });
        }



        // function Guardar() {
        //     //loading(true);
        //     $("form#frmRegistro input[id=accion]").remove();
        //     $('#frmRegistro').append('<input type="hidden" id="accion" name="accion" value="Actualizar" />');
        //     var form = $("#frmRegistro").serializeArray();
        //     $("form#frmRegistro input[id=accion]").remove();
        //     $.ajax({
        //         url: "controlador/contCuentasxPagar.php",
        //         type: "POST",
        //         //async: false,
        //         data: form,
        //         success: function(data) {
        //             var data = JSON.parse(data);
        //             var titulo = '';
        //             var cod = $("#hdcod").val();
        //             if (cod == 0) {
        //                 titulo = 'Registrar ' + $("#identificador").val();
        //             } else {
        //                 titulo = 'Actualizar ' + $("#identificador").val();
        //             }

        //             if (data[0].rpta == 0) {
        //                 //alerta('error', data[0].msj, titulo);
        //             } else {
        //                 //alerta('success', data[0].msj, titulo);

        //                 $("#mdRegistro").hide();
        //                 $("#Lista").show();

        //                 Listar();
        //                 fnLimpiar();
        //             }
        //         },
        //         error: function(result) {
        //             //alerta('error', 'No se pudo realizar la operación.', $("#identificador").val());
        //         }
        //     })
        // }


        // function validar() {
        //     var titulo = 'Validación de ' + $("#identificador").val();

        //     if ($("#txtfecha_mop").val().trim() == "") {
        //         $("#txtfecha_mop").focus();
        //         return false;
        //     }

        //     if ($("#txtCodigo_suc").val().trim() == "") {
        //         $("#txtCodigo_suc").focus();
        //         return false;
        //     }
        //     if ($("#txtCodigo_pro").val().trim() == "") {
        //         $("#txtCodigo_pro").focus();
        //         return false;
        //     }
        //     if ($("#txtCodigo_tdo").val().trim() == "") {
        //         $("#txtCodigo_tdo").focus();
        //         return false;
        //     }

        //     if ($("#txtSerie_mop").val().trim() == "") {
        //         $("#txtSerie_mop").focus();
        //         return false;
        //     }
        //     if ($("#txtNumero_mop").val().trim() == "") {
        //         $("#txtNumero_mop").focus();
        //         return false;
        //     }
        //     if ($("#txtCodigo_mon").val().trim() == "") {
        //         $("#txtCodigo_mon").focus();
        //         return false;
        //     }
        //     if ($("#txtImporte_mop").val().trim() == "") {
        //         $("#txtImporte_mop").focus();
        //         return false;
        //     }
        //     if ($("#txtFechaVencimiento_mop").val().trim() == "") {
        //         $("#txtFechaVencimiento_mop").focus();
        //         return false;
        //     }

        //     /*
        //     if (!confirm('¿Está seguro que desea eliminar la sucursal?')) {
        //         return false;
        //     }*/

        //     return true;

        //     //Confirmar('¿Está seguro que desea eliminar el registro?', 'Luego no podra visualizarlo', 'Guardar()');
        // }


        // function Editar(id) {
        //     //console.log(id);
        //     //loading(true);
        //     fnLimpiar();
        //     //$("#frmRegistro").addClass("was-validated");
        //     $.ajax({
        //         url: "controlador/contCuentasxPagar.php",
        //         type: "POST",
        //         async: false,
        //         //dataType: "json",
        //         data: {
        //             "accion": "Editar",
        //             "codigo": id
        //         },
        //         success: function(data) {
        //             //console.log(data);
        //             var data = JSON.parse(data);
        //             $("#hdcod").val(data[0].codigo);
        //             $("#txtCodigo_suc").val(data[0].codigo_suc);
        //             $("#txtSucursal").val(data[0].sucursal);
        //             $("#txtCodigo_tdo").val(data[0].codigo_tdo);
        //             $("#txtTipoDocumento").val(data[0].documento);
        //             $("#txtSerie_mop").val(data[0].serie_mop);
        //             $("#txtNumero_mop").val(data[0].numero_mop);
        //             $("#txtCodigo_pro").val(data[0].codigo_pro);
        //             $("#txtProveedor").val(data[0].proveedor);
        //             $("#txtfecha_mop").val(data[0].fecha_mop);
        //             $("#txtImporte_mop").val(data[0].importe_mop);
        //             $("#txtFechaVencimiento_mop").val(data[0].fechaVencimiento_mop);
        //             $("#txtCodigo_mon").val(data[0].codigo_mon);
        //             $("#txtMoneda").val(data[0].moneda);
        //             $("#txtObservacion_mop").val(data[0].detalle_mop);



        //             $("#Lista").hide();
        //             $("#mdRegistro").show();
        //             //loading(false);
        //         },
        //         error: function(result) {
        //             //console.log("problemas");
        //             console.log(result);
        //         }
        //     });

        // }

        // function ConfirmarEliminar(id) {
        //     Confirmar('question', '¿Está seguro que desea eliminar el registro?', 'Luego no podrá visualizarlo', 'Eliminar("' + id + '")');
        // }

        // function ConfirmarGuardar() {
        //     if (validar() == true) {
        //         Confirmar('question', '¿Está seguro que desea guardar los datos?', '', 'Guardar()');
        //     }
        // }

        // function Confirmar(icono, titulo, detalle, funcion) {
        //     Swal.fire({
        //         title: titulo,
        //         text: detalle,
        //         icon: icono,
        //         showCancelButton: true,
        //         cancelButtonColor: '#dc3545',
        //         confirmButtonText: '<i class="fa fa-check"></i> Si',
        //         cancelButtonText: '<i class="fa fa-times"></i> No'
        //     }).then(function(result) {
        //         if (result.value) {
        //             eval(funcion);
        //         }
        //     })
        // }

        function Alerta(tipo, titulo, texto) {
            Swal.fire({
                confirmButtonColor: '#007bff',
                icon: tipo,
                title: titulo,
                text: texto
                    //footer: '<a href>Why do I have this issue?</a>'
            })
        }

        // function Eliminar(id) {
        //     //console.log(id);
        //     //if (confirm("¿Esta seguro que desea eliminar el registro?")) {
        //     var titulo = 'Eliminar ' + $("#identificador").val();
        //     //loading(true);
        //     $.ajax({
        //         url: "controlador/contCuentasxPagar.php",
        //         type: "POST",
        //         //dataType: "json",
        //         data: {
        //             "accion": "Eliminar",
        //             "codigo": id
        //         },
        //         success: function(data) {
        //             var data = JSON.parse(data);
        //             //console.log(data);
        //             if (data[0].rpta == 0) {
        //                 alerta('error', data[0].msj, titulo);
        //             } else {
        //                 alerta('success', data[0].msj, titulo);
        //                 Listar();
        //             }
        //             //loading(false);
        //         },
        //         error: function(result) {
        //             //console.log(result);
        //             alerta('error', $("#identificador").val() + ' no pudo ser eliminada.', titulo);
        //         }
        //     });
        //     //}
        // }

        function fnLimpiar() {
            // $("#hdcod").val("0");
            // //$("#txtfecha_mop").val("");
            // $('#txtfecha_mop').val(new Date().toJSON().slice(0, 10));
            // $("#txtCodigo_suc").val("");
            // $("#txtSucursal").val("");
            // $("#txtCodigo_pro").val("");
            // $("#txtProveedor").val("");
            // $("#txtCodigo_tdo").val("");
            // $("#txtTipoDocumento").val("");
            // $("#txtSerie_mop").val("");
            // $("#txtNumero_mop").val("");
            // $("#txtCodigo_mon").val("");
            // $("#txtMoneda").val("");
            // $("#txtImporte_mop").val("");
            // //$("#txtFechaVencimiento_mop").val("");
            // $('#txtFechaVencimiento_mop').val(new Date().toJSON().slice(0, 10));
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
                                <div class="col-sm-4 text-right">
                                    <button type="button" id="btnNuevo" class="btn btn-sm btn-primary btn-radius">
                                        <i class="fas fa-plus-square"></i><span>&nbsp;Nuevo</span></button>
                                </div>
                            </div>


                            <div class="card-header">
                                <div class="form-row mb-12">
                                    <label for="txtFecha_ini" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                       Fecha Incial: </label>
                                    <div class="col-sm-2 col-md-2">
                                        <input type="date" class="form-control form-control-sm" id="txtFecha_ini" name="txtFecha_ini" maxlength="10"  />
                                    </div>

                                    <label for="txtFecha_fin" class="col-sm-1 col-form-label-sm" style="text-align:right" >
                                       Fecha Final: </label>
                                    <div class="col-sm-2 col-md-2">
                                        <input type="date" class="form-control form-control-sm" id="txtFecha_fin" name="txtFecha_fin" maxlength="10"  />
                                    </div>

                                    <div class="col-sm-2 text-right">
                                        <button type="button" id="btnConsultar" class="btn btn-sm btn-primary btn-radius">
                                        <i class="fas fa-plus-square"></i><span>&nbsp;Consultar</span></button>
                                    </div>
                                </div>

                                <div class="form-row mb-12">
                                    <label for="txtProveedor" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                    Proveedor: </label>
                                    <div class="col-sm-4">
                                        <select class="cboProveedor form-control" style="width:460px" id="cboProveedor" name="cboProveedor"></select>
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
                                                <th style="width: 5%; text-align:center;">
                                                    N°
                                                </th>
                                                <th style="width: 10%; text-align:center;">
                                                    Documento
                                                </th>
                                                <th style="width: 10%; text-align:center;">
                                                    Fecha
                                                </th>
                                                <th style="width: 43%; text-align:center;">
                                                    Proveedor
                                                </th>
                                                <th style="width: 10%; text-align:center;">
                                                    Condición
                                                </th>
                                                <th style="width: 10%; text-align:center;">
                                                    Moneda
                                                </th>
                                                <th style="width: 10%; text-align:center;">
                                                    Importe
                                                </th>
                                                <th style="width: 10%; text-align:center;">
                                                    Acción
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


                <div class="row" id="mdRegistro">
                    <div class="container">
                        <div class="row justify-content-center">

                            <div class="col-xl-12 col-md-12 col-lg-12">
                                <div class="card shadow">
                                    <!-- Card Header - Dropdown -->
                                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                        <h6 class="card-title text-primary font-weight-bold" id="tituloMantenimiento"></h6>
                                        <input type="hidden" id="identificador" name="identificador" value="">
                                    </div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-sm-12 col-md-12"  class="border=1">
                                                <!-- <form id="frmRegistro" class="needs-validation" novalidate>-->
                                                <form id="frmRegistro">


                                                    <div class="col-lg-12" style="margin-top:2px;">
                                                        <div class="form-row mb-12">
                                                            <label for="lblSucursal_reg" class="col-sm-1 col-form-label" style="text-align:right">
                                                            Sucursal: </label>
                                                            <div class="col-sm-6">
                                                                <select class="cboSucursal_reg form-control" style="width:460px" id="cboSucursal_reg" name="cboSucursal_reg"></select>
                                                            </div>
                                                        

                                                            <label for="lblfechaIngreso_reg" class="col-sm-1 col-form-label-sm" style="text-align:right" >
                                                                F. Ingreso: </label>
                                                            <div class="col-sm-2">
                                                                <input type="hidden" id="hdcod" name="hdcod" value="0">
                                                                <input type="date" class="form-control form-control-sm" id="txtfechaIngreso_reg" name="txtfechaIngreso_reg" maxlength="20" />
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-12" style="margin-top:2px;">
                                                        <div class="form-row mb-12">
                                                            <label for="lblProveedor_reg" class="col-sm-1 col-form-label" style="text-align:right">
                                                            Proveedor: </label>
                                                            <div class="col-sm-6">
                                                                <select class="cboProveedor_reg form-control" style="width:460px" id="cboProveedor_reg" name="cboProveedor_reg"></select>
                                                            </div>

                                                            <label for="lblfechaEmision_reg" class="col-sm-1 col-form-label-sm" style="text-align:right" >
                                                                F. Emision: </label>
                                                            <div class="col-sm-2">
                                                                <input type="hidden" id="hdcod" name="hdcod" value="0">
                                                                <input type="date" class="form-control form-control-sm" id="txtfechaEmision_reg" name="txtfechaEmision_reg" maxlength="20" />
                                                            </div>
                                                        </div>

                                                        
                                                    </div>                                                 

                                                    <div class="col-lg-12" style="margin-top:2px;">
                                                        <div class="form-row mb-12">
                                                            <label for="lblTipoDocumento_reg" class="col-sm-1 col-form-label" style="text-align:right">
                                                            Documento: </label>
                                                            <div class="col-sm-3">
                                                                <select class="cboTipoDocumento_reg form-control" style="width:250px" id="cboTipoDocumento_reg" name="cboTipoDocumento_reg"></select>
                                                            </div>
                                                        
                                                            <label for="lblSerie_reg" class="col-sm-1 col-form-label-sm" style="text-align:right" >
                                                                Serie: </label>
                                                            <div class="col-sm-1">
                                                                <input type="text" style="text-align:center" class="form-control form-control-sm" id="txtSerie_reg" name="txtSerie_reg" maxlength="20" />
                                                            </div>
                                                        
                                                            <label for="lblNumero_reg" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                                                Número: </label>
                                                            <div class="col-sm-2">
                                                                <input type="text" style="text-align:center" class="form-control form-control-sm" id="txtSerie_reg" name="txtSerie_reg" maxlength="20" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <!-- <div class="form-row mb-2 form-control-sm"> -->
                                                    <div class="col-lg-12" style="margin-top:2px;">    
                                                        <div class="form-row mb-12">
                                                            <label for="lblMoneda_reg" class="col-sm-1 col-form-label-sm" style="text-align:right" >
                                                            Moneda: </label>
                                                            <div class="col-sm-2">
                                                                <select class="cboMoneda_reg form-control" style="width:150px" id="cboMoneda_reg" name="cboMoneda_reg"></select>
                                                            </div>
                                                                                                                
                                                            <label for="lblCondicion_reg" class="col-sm-1 col-form-label-sm" style="text-align:right" >
                                                                Condición: </label>
                                                            <div class="col-sm-2">
                                                                <select class="cboCondicion_reg form-control" style="width:200px" id="cboCondicion_reg" name="cboCondicion_reg"></select>
                                                            </div>


                                                            <label for="lblDias" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                                                Dias: </label>
                                                            <div class="col-sm-1">
                                                                <input type="text" style="text-align:center" class="form-control form-control-sm" id="txtdias_reg" name="txtdias_reg" maxlength="20" />
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-12" style="margin-top:2px;">    
                                                        <div class="form-row mb-12">
                                                            <label for="lblObservacion_reg" class="col-sm-1 col-form-label-sm" style="text-align:right" >
                                                                Detalle: </label>
                                                            <div class="col-sm-9">
                                                                <input type="text" class="form-control form-control-sm" id="txtObservacion_reg" name="txtObservacion_reg" maxlength="500" />
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <a data-toggle="modal" href="#myModal">
                                                                    <button type="button" id="btnNuevo" class="btn btn-sm btn-primary btn-radius">
                                                                    <i class="fas fa-plus-square"></i><span>&nbsp;Nuevo</span></button>
                                                                </a>
                                                            </div>

                                                            <!-- <div class="col-sm-2">
                                                                <a data-toggle="modal" href="#myModal">
                                                                <button id="btnAgregarArt" type="button" class="btn btn-primary"><span class="fa fa-plus"></span>  Agregar</button>
                                                                </a>
                                                            </div> -->

                                                        </div>    
                                                    </div>



                                                    <div class="card-body">
                                                        <div class="table-responsive" style="font-size: 11px;">
                                                            <table id="tCXC" class="display compact order-column form-control-sm" style="width:98%;">
                                                                <thead>
                                                                    <tr>
                                                                        <th style="width: 5%; text-align:center color: blue;">N°</th>
                                                                        <th style="width: 43%; text-align:center;">Artículo</th>
                                                                        <th style="width: 10%; text-align:center;">Und. Med</th>
                                                                        <th style="width: 10%; text-align:center;">Cantidad</th>
                                                                        <th style="width: 10%; text-align:center;">Precio</th>
                                                                        <th style="width: 10%; text-align:center;">Importe</th>
                                                                        <th style="width: 10%; text-align:center;">Acción</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody id="tbCXC">
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>


                                                    <div style="text-align: center;" class="pt-2">
                                                        <button type="button" id="btnGuardar" class="btn btn-sm btn-primary btn-radius">
                                                            <i class="fa fa-save"></i>&nbsp;Guardar</button>
                                                        <button type="button" id="btnCancelar" class="btn btn-sm btn-danger btn-radius">
                                                            <i class="fa fa-times-circle"></i>&nbsp;Cancelar</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
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
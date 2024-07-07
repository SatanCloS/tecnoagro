<!DOCTYPE html>
<html lang="en">

<head>
    <script type="text/javascript">
        "use strict";
        $(document).ready(function() {
            $('#txtfecha').val(new Date().toJSON().slice(0, 10))

            $('#cboAnio').val();
            $('#cboMes').val();

            $("#mdRegistro").hide();

            $("#tituloLista").text("Listado Tipo de Cambio");
            $("#tituloMantenimiento").text("Registro Tipo de Cambio");
            $("#identificador").val("Tipo de Cambio");

            Listar();

            //Filtros
            $("#cboAnio").select2();
            ListarCboAnio();

            $("#cboMes").select2();
            ListarCboMes();

            $("#btnConsultar").click(function() {
                Listar();
            })


            $("#btnNuevo").click(function() {
                fnLimpiar();
                $("#Lista").hide();
                $("#mdRegistro").show();
            })

            $("#btnGuardar").click(function() {
                ConfirmarGuardar();
            });

            $("#btnCancelar").click(function() {
                //loading(true);
                $("#Lista").show();
                $("#mdRegistro").hide();
            });

            $("#cboAnio").change(function() {
                var selectedValue = $(this).val();
                $("#cboMes").select2();
                ListarCboMes();
            });

        })


        function Listar() {
            $.ajax({
                url: "controlador/contTipoCambio.php",
                type: "POST",
                data: {
                    "accion": "Listar",
                    "cboAnio": $('#cboAnio').val(),
                    "cboMes": $('#cboMes').val()
                },                
                //async: true,
                success: function(data) {
                    var data = JSON.parse(data);
                    //console.log(data);
                    var $cuerpo = "";
                    if (data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            $cuerpo += "<tr>";
                            $cuerpo += "<td align='center'>" + (i + 1) + "</td>";
                            $cuerpo += "<td>" + data[i].fecha + "</td>";
                            $cuerpo += "<td style='text-align:right;'>" + data[i].cambioCompra + "</td>";
                            $cuerpo += "<td style='text-align:right;'>" + data[i].cambioVenta + "</td>";                    
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
                        "lengthMenu": [[50, 25, -1], [50, 25, "All"]],
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

        function ListarCboAnio() {
            $.ajax({
                url: "controlador/contTipoCambio.php",
                type: "POST",
                data: {
                    "accion": "ListarAnio"
                },
                success: function(data) {
                    var data = JSON.parse(data);
                    var $cuerpo = "";
                    if (data.length > 0) {
                        $cuerpo += "<option value='0'>- SELECCIONE -</option>";
                        for (var i = 0; i < data.length; i++) {
                            $cuerpo += "<option value='" + data[i].codigo + "'>" + data[i].nombre + "</option>";
                        }
                    }
                    $("#cboAnio").html($cuerpo);
                },
                error: function(result) {
                    console.log(result);
                }
            });
        }
        
        function ListarCboMes() {
            $.ajax({
                url: "controlador/contTipoCambio.php",
                type: "POST",
                data: {
                    "accion": "ListarMes",
                    "cboAnio": $("#cboAnio").val()
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
                    $("#cboMes").html($cuerpo);

                },
                error: function(result) {
                    console.log(result);
                }
            });
        }


        function Guardar() {
            //loading(true);
            $("form#frmRegistro input[id=accion]").remove();
            $('#frmRegistro').append('<input type="hidden" id="accion" name="accion" value="Actualizar" />');
            var form = $("#frmRegistro").serializeArray();
            $("form#frmRegistro input[id=accion]").remove();
            $.ajax({
                url: "controlador/contTipoCambio.php",
                type: "POST",
                //async: false,
                data: form,
                success: function(data) {
                    var data = JSON.parse(data);
                    var titulo = '';
                    var cod = $("#hdcod").val();
                    if (cod == 0) {
                        titulo = 'Registrar ' + $("#identificador").val();
                    } else {
                        titulo = 'Actualizar ' + $("#identificador").val();
                    }

                    if (data[0].rpta == 0) {
                        msgAlerta('error', data[0].msj, titulo);
                    } else {
                        msgAlerta('success', data[0].msj, titulo);

                        $("#mdRegistro").hide();
                        $("#Lista").show();

                        Listar();
                        fnLimpiar();
                    }
                },
                error: function(result) {
                    msgAlerta('error', 'No se pudo realizar la operación.', $("#identificador").val());
                }
            })
        }


        function validar() {
            var titulo = 'Validación de ' + $("#identificador").val();

            if ($("#txtfecha").val().trim() == "") {
                msgAlerta('error', 'Debe ingresar la fecha del ' + $("#identificador").val(), titulo);
                $("#txtfecha").focus();
                return false;
            }

            if ($("#txtCambioCompra").val() == 0) {
                msgAlerta('error', 'Debe ingresar un importe del ' + $("#identificador").val(), titulo);
                $("#txtCambioCompra").focus();
                return false;
            }

            if ($("#txtCambioVenta").val() == 0) {
                msgAlerta('error', 'Debe ingresar un importe del ' + $("#identificador").val(), titulo);
                $("#txtCambioVenta").focus();
                return false;
            }

            return true;
        }


        function Editar(id) {
            //console.log(id);
            //loading(true);
            fnLimpiar();
            //$("#frmRegistro").addClass("was-validated");
            $.ajax({
                url: "controlador/contTipoCambio.php",
                type: "POST",
                async: false,
                //dataType: "json",
                data: {
                    "accion": "Editar",
                    "codigo": id
                },
                success: function(data) {
                    console.log(data);
                    
                    var data = JSON.parse(data);
                    $("#hdcod").val(data[0].codigo);
                    $("#txtfecha").val(data[0].fecha);
                    $("#txtCambioCompra").val(data[0].cambioCompra);
                    $("#txtCambioVenta").val(data[0].cambioVenta);
                 
                    $("#Lista").hide();
                    $("#mdRegistro").show();
                    //loading(false);
                },
                error: function(result) {
                    //console.log("problemas");
                    console.log(result);
                }
            });

        }

        function ConfirmarEliminar(id) {
            Confirmar('question', '¿Está seguro que desea eliminar el registro?', 'Luego no podrá visualizarlo', 'Eliminar("' + id + '")');
        }

        function ConfirmarGuardar() {
            if (validar() == true) {
                Confirmar('question', '¿Está seguro que desea guardar los datos?', '', 'Guardar()');
            }
        }

        function Confirmar(icono, titulo, detalle, funcion) {
            Swal.fire({
                title: titulo,
                text: detalle,
                icon: icono,
                showCancelButton: true,
                cancelButtonColor: '#dc3545',
                confirmButtonText: '<i class="fa fa-check"></i> Si',
                cancelButtonText: '<i class="fa fa-times"></i> No'
            }).then(function(result) {
                if (result.value) {
                    eval(funcion);
                }
            })
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

        function Eliminar(id) {
            //console.log(id);
            //if (confirm("¿Esta seguro que desea eliminar el registro?")) {
            var titulo = 'Eliminar ' + $("#identificador").val();
            //loading(true);
            $.ajax({
                url: "controlador/contTipoCambio.php",
                type: "POST",
                //dataType: "json",
                data: {
                    "accion": "Eliminar",
                    "codigo": id
                },
                success: function(data) {
                    var data = JSON.parse(data);
                    //console.log(data);
                    if (data[0].rpta == 0) {
                        msgAlerta('error', data[0].msj, titulo);
                    } else {
                        msgAlerta('success', data[0].msj, titulo);
                        Listar();
                    }
                    //loading(false);
                },
                error: function(result) {
                    //console.log(result);
                    msgAlerta('error', $("#identificador").val() + ' no pudo ser eliminada.', titulo);
                }
            });
            //}
        }

        function fnLimpiar() {
            $("#hdcod").val("0");
            $('#txtfecha').val(new Date().toJSON().slice(0, 10));
            $("#txtCambioCompra").val("0");
            $("#txtCambioVenta").val("0");
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
                                    <label for="lblAnio" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                    Año: </label>
                                    <div class="col-sm-3">
                                        <select class="cboAnio form-control" style="width:300px" id="cboAnio" name="cboAnio"></select>
                                    </div>

                                    <div class="col-sm-2 text-right">
                                        <button type="button" id="btnConsultar" class="btn btn-sm btn-primary btn-radius">
                                        <i class="fas fa-plus-square"></i><span>&nbsp;Consultar</span></button>
                                    </div>

                                </div>

                                <div class="form-row mb-12">
                                    <label for="lblMes" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                    Mes: </label>
                                    <div class="col-sm-3">
                                        <select class="cboMes form-control" style="width:300px" id="cboMes" name="cboMes"></select>
                                    </div>
                                </div>

                            </div>

                            <!--- <div class="card-body pL-2 pr-2">-->
                            <div class="card-body">
                                <div class="table-responsive" style="font-size: 11px;">
                                    <table id="tCXC" class="display compact order-column form-control-sm" style="width:98%;">
                                        <thead>
                                            <tr>
                                                <th style="width: 10%; text-align:center;">N°</th>
                                                <th style="width: 10%; text-align:center;">Fecha</th>
                                                <th style="width: 35%; text-align:right;">Cambio Compra</th>
                                                <th style="width: 35%; text-align:right;">Cambio Venta</th>                                         
                                                <th style="width: 10%; text-align:center;">Acción</th>
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

                            <div class="col-xl-6 col-md-6 col-lg-6">
                                <div class="card shadow">
                                    <!-- Card Header - Dropdown -->
                                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                        <h6 class="card-title text-primary font-weight-bold" id="tituloMantenimiento"></h6>
                                        <input type="hidden" id="identificador" name="identificador" value="">
                                    </div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-sm-12 col-md-12">
                                                <!-- <form id="frmRegistro" class="needs-validation" novalidate>-->
                                                <form id="frmRegistro">
                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="lblfecha" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Fecha Ingreso: </label>
                                                        <div class="col-sm-4">
                                                            <input type="hidden" id="hdcod" name="hdcod" value="0">
                                                           <input type="date" class="form-control form-control-sm" id="txtfecha" name="txtfecha" maxlength="20" />
                                                        </div>
                                                    </div>


                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="lblcambioCompra" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            cambio Compra: </label>
                                                        <div class="col-sm-4">
                                                           <input type="number" style="text-align:right" class="form-control form-control-sm" id="txtCambioCompra" name="txtCambioCompra" placeholder="0.00" maxlength="20" />
                                                        </div>
                                                    </div>

                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="lblCambioVenta" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            cambio Venta: </label>
                                                        <div class="col-sm-4">
                                                           <input type="number" style="text-align:right" class="form-control form-control-sm" id="txtCambioVenta" name="txtCambioVenta" placeholder="0.00" maxlength="20" />
                                                        </div>
                                                    </div>

                                                    <hr> <!-- Línea horizontal -->

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
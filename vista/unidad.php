<!DOCTYPE html>
<html lang="en">

<head>
    <script type="text/javascript">
        "use strict";
        $(document).ready(function() {

            //$("#txtTexto").focus();
            $("#mdRegistro").hide();
            $("#tituloLista").text("Unidades de medida");
            $("#tituloMantenimiento").text("Gestión de unidad de medida");
            $("#identificador").val("Unidad de medida");

            Listar();

            $("#btnNuevo").click(function() {
                //loading(true);
                fnLimpiar();
                $("#Lista").hide();
                $("#mdRegistro").show();
                $("#txtNombre").focus();
                //$("#frmRegistro").removeClass("was-validated");
                //loading(false);
            })

            $("#btnGuardar").click(function() {
                ConfirmarGuardar();     
            });

            $("#btnCancelar").click(function() {
                //loading(true);

                $("#Lista").show();
                $("#mdRegistro").hide();
                //Listar();
                //loading(false);
            });

            //loading(false);

        })

        function Listar() {
            ////loading(true);
            $.ajax({
                url: "controlador/contUnidad.php",
                type: "POST",
                data: {
                    "accion": "Listar"
                },
                //async: true,
                success: function(data) {
                    // you will get response from your php page (what you echo or print)
                    var data = JSON.parse(data);
                    //console.log(data);
                    var $cuerpo = "";
                    if (data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            $cuerpo += "<tr>";
                            $cuerpo += "<td align='center'>" + (i + 1) + "</td>";
                            $cuerpo += "<td>" + data[i].nombre + "</td>";
                            $cuerpo += "<td>" + data[i].abreviatura + "</td>";
                            $cuerpo += "<td style='font-size:10px; text-align:center;'>";
                            $cuerpo += "<button type='button' class='btn btn-info btn-sm btn-radius' onclick='Editar(" + data[i].codigo + ")' title='Editar' ><i class='fas fa-edit small'></i></button>";
                            $cuerpo += " <button type='button' class='btn btn-danger btn-sm btn-radius' onclick='ConfirmarEliminar(" + data[i].codigo + ")' title='Eliminar'><i class='fa fa-trash-alt small'></i></button>";
                            $cuerpo += "</td>";
                            $cuerpo += "</tr>";                        
                        }
                    }
                    //console.log($cuerpo)
                    $("#tUnidad").DataTable().destroy();
                    $("#tbUnidad").html($cuerpo);
                    $("#tUnidad").DataTable({
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
                            targets: 3
                        }]

                    });
                    //loading(false);
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
                url: "controlador/contUnidad.php",
                type: "POST",
                //async: false,
                data: form,
                success: function(data) {
                    //console.log(data);
                    var data = JSON.parse(data);
                    var titulo = '';
                    var cod = $("#hdcod").val();
                    if (cod == 0) {
                        titulo = 'Registrar ' + $("#identificador").val();
                    } else {
                        titulo = 'Actualizar ' + $("#identificador").val();
                    }

                    if (data[0].rpta == 0) {
                        //alerta('error', data[0].msj, titulo);
                    } else {
                        //alerta('success', data[0].msj, titulo);
                        
                        $("#mdRegistro").hide();
                        $("#Lista").show();
                        
                        Listar();
                        fnLimpiar();
                    }
                },
                error: function(result) {
                    //alerta('error', 'No se pudo realizar la operación.', $("#identificador").val());
                }
            })
        }

        function validar() {
            var titulo = 'Validación de ' + $("#identificador").val();

            if ($("#txtNombre").val().trim() == "") {
                //alerta('error', 'Ingrese el nombre del ' + $("#identificador").val(), titulo);
                $("#txtNombre").focus();
                return false;
            }
            if ($("#txtAbreviatura").val().trim() == "") {
                //alerta('error', 'Ingrese abreviatura del ' + $("#identificador").val(), titulo);
                $("#txtAbreviatura").focus();
                return false;
            }


            /*
            if (!confirm('¿Está seguro que desea eliminar la sucursal?')) {
                return false;
            }*/

            return true;

            //Confirmar('¿Está seguro que desea eliminar el registro?', 'Luego no podra visualizarlo', 'Guardar()');
        }


        function Editar(id) {
            //console.log(id);
            //loading(true);
            fnLimpiar();
            //$("#frmRegistro").addClass("was-validated");
            $.ajax({
                url: "controlador/contUnidad.php",
                type: "POST",
                async: false,
                //dataType: "json",
                data: {
                    "accion": "Editar",
                    "codigo": id
                },
                success: function(data) {
                    var data = JSON.parse(data);
                    $("#hdcod").val(data[0].codigo);
                    $("#txtNombre").val(data[0].nombre);
                    $("#txtAbreviatura").val(data[0].abreviatura);
                    $("#Lista").hide();
                    $("#mdRegistro").show();
                    //loading(false);
                },
                error: function(result) {
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

function Alerta(tipo, titulo, texto) {
    Swal.fire({
        confirmButtonColor: '#007bff',
        icon: tipo,
        title: titulo,
        text: texto
            //footer: '<a href>Why do I have this issue?</a>'
    })
}
        function Eliminar(id) {
            //console.log(id);
            //if (confirm("¿Esta seguro que desea eliminar el registro?")) {
            var titulo = 'Eliminar ' + $("#identificador").val();
            //loading(true);
            $.ajax({
                url: "controlador/contUnidad.php",
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
                        //alerta('error', data[0].msj, titulo);
                    } else {
                        //alerta('success', data[0].msj, titulo);
                        Listar();
                    }
                    //loading(false);
                },
                error: function(result) {
                    console.log(result);
                    //alerta('error', $("#identificador").val() + ' no pudo ser eliminada.', titulo);
                }
            });
            //}
        }

        function fnLimpiar() {
            $("#hdcod").val("0");
            $("#txtNombre").val("");
            $("#txtAbreviatura").val("");
        }
    </script>
</head>

<body class="hold-transition sidebar-mini layout-fixed">
    <div class="wrapper">


        <!-- Content Header (Page header) -->
        <!--<div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0">Sucursales</h1>
                    </div>

                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="index">Menú Principal</a></li>
                            <li class="breadcrumb-item active">Sucursales</li>
                        </ol>
                    </div>

                </div>
            </div>
        </div>-->
        <!-- /.content-header -->
        <section class="content pt-2">
            <div class="container-fluid">
                <div class="row" id="Lista">
                    <div class="col-md-12 col-sm-12">
                        <div class="card shadow">
                            <!-- Card Header - Dropdown -->
                            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                <div class="col-sm-8">
                                    <h3 class="m-0" id="tituloLista"></h3>
                                </div>
                                <div class="col-sm-4 text-right">
                                    <button type="button" id="btnNuevo" class="btn btn-sm btn-primary btn-radius">
                                        <i class="fas fa-plus-square"></i><span>&nbsp;Nuevo</span></button>
                                </div>

                            </div>
                            <!--- <div class="card-body pL-2 pr-2">-->
                            <div class="card-body">

                                <div class="table-responsive" style="font-size: 11px;">
                                    <table id="tUnidad" class="display compact order-column form-control-sm" style="width:98%;">
                                        <thead>
                                            <tr>
                                                <th style="width: 5%; text-align:center;">
                                                    N°
                                                </th>
                                                <th style="width: 58%; text-align:center;">
                                                    Nombre
                                                </th>
                                                <th style="width: 25%; text-align:center;">
                                                    Abreviatura
                                                </th>
                                                <th style="width: 10%; text-align:center;">
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbUnidad">
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Mantenimiento -->
                <div class="row" id="mdRegistro">
                    <div class="col-xl-12 col-md-12 col-lg-12">
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
                                            <div class="form-row mb-2">
                                                <label for="txtNombre" class="col-sm-3 col-form-label-sm">
                                                    Nombre</label>
                                                <div class="col-sm-4">
                                                    <input type="hidden" id="hdcod" name="hdcod" value="0">
                                                    <input type="text" class="form-control form-control-sm" id="txtNombre" name="txtNombre" maxlength="100" />
                                                    <!--<div class="invalid-feedback">
                                                        Ingrese Nombre
                                                    </div> -->
                                                </div>
                                            </div>
                                            <div class="form-row mb-2">
                                                <label for="txtAbreviatura" class="col-sm-3 col-form-label-sm">
                                                    Abreviatura</label>
                                                <div class="col-sm-3 col-md-2">
                                                    <input type="text" class="form-control form-control-sm" id="txtAbreviatura" name="txtAbreviatura" placeholder="" maxlength="10" />
                                                    <!--<div class="invalid-feedback">
                                                        Ingrese abreviatura
                                                    </div> -->
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
            <!-- /.container-fluid -->
        </section>
        <!-- /.content -->
    </div>
</body>
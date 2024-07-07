<!DOCTYPE html>
<html lang="en">

<head>
    <script type="text/javascript">
        "use strict";
        $(document).ready(function() {
            $("#mdRegistro").hide();

            $("#tituloLista").text("Listado de Clientes");
            $("#tituloMantenimiento").text("Gestión de Clientes");
            $("#identificador").val("Cliente");

            Listar();

            $("#cboDepartamento").select2();
            ListarCboDepartamento();

            $("#cboProvincia").select2();
            ListarCboProvincia();

            $("#cboDistrito").select2();
            ListarCboDistrito();

            $("#cboDocumento").select2();
            ListarCboDocumento();

            $("#cboTipoPersona").select2();
            ListarCboTipoPersona();

            $("#btnNuevo").click(function() {
                //loading(true);
                fnLimpiar();
                $("#Lista").hide();
                $("#mdRegistro").show();                
                
                $("#cboDocumento").focus();
            })

            $("#btnGuardar").click(function() {
                ConfirmarGuardar();     
            });

            $("#btnCancelar").click(function() {
                //loading(true);

                $("#Lista").show();
                $("#mdRegistro").hide();
               
            });

            // Adjuntar controlador de eventos change al combo
            $("#cboDepartamento").change(function() {
                var selectedValue = $(this).val();
                $("#cboProvincia").select2(); // Initialize the select2 plugin
                ListarCboProvincia($('#cboDepartamento').val());
            });
           
            $("#cboProvincia").change(function() {
                var selectedValue = $(this).val();
                $("#cboDistrito").select2();
                ListarCboDistrito($('#cboProvincia').val() );
            });
            //loading(false);
        })

        function Listar() {
            ////loading(true);
            $.ajax({
                url: "controlador/contCliente.php",
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
                            $cuerpo += "<td>" + data[i].direccion_cli + "</td>";  
                            $cuerpo += "<td>" + data[i].nombre_tip + "</td>";  
                            $cuerpo += "<td>" + data[i].nombre_doc + "</td>";  
                            $cuerpo += "<td>" + data[i].numero_doc + "</td>";  
                            $cuerpo += "<td style='font-size:10px; text-align:center;'>";
                            $cuerpo += "<button type='button' class='btn btn-info btn-sm btn-radius' onclick='Editar(" + data[i].codigo + ")' title='Editar' ><i class='fas fa-edit small'></i></button>";
                            $cuerpo += " <button type='button' class='btn btn-danger btn-sm btn-radius' onclick='ConfirmarEliminar(" + data[i].codigo + ")' title='Eliminar'><i class='fa fa-trash-alt small'></i></button>";
                            $cuerpo += "</td>";
                            $cuerpo += "</tr>";                        
                        }
                    }
                   // console.log($cuerpo)
                    $("#tCliente").DataTable().destroy();
                    $("#tbCliente").html($cuerpo);
                    $("#tCliente").DataTable({
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

        function ListarCboDepartamento() {
            $.ajax({
                url: "controlador/contUbigeo.php",
                type: "POST",
                data: {
                    "accion": "ListarDepartamento",
                    "codigo": 0
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
                    $("#cboDepartamento").html($cuerpo);
                },
                error: function(result) {
                    console.log(result);
                }
            });
        }
      
        function ListarCboProvincia(codigo_dep) {
            $.ajax({
                url: "controlador/contUbigeo.php",
                type: "POST",
                data: {
                    "accion": "ListarProvincia",
                    "codigo": codigo_dep    
                    // $('#cboDepartamento').val() 
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
                    $("#cboProvincia").html($cuerpo);
                },
                error: function(result) {
                    console.log(result);
                }
            });
        }

        function ListarCboDistrito(codigo_pro) {
            $.ajax({
                url: "controlador/contUbigeo.php",
                type: "POST",
                data: {
                    "accion": "ListarDistrito",
                    "codigo": codigo_pro
                    //$('#cboProvincia').val() 
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
                    $("#cboDistrito").html($cuerpo);
                },
                error: function(result) {
                    console.log(result);
                }
            });
        }


        function ListarCboDocumento() {
            $.ajax({
                url: "controlador/contDocumento.php",
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
                    $("#cboDocumento").html($cuerpo);
                },
                error: function(result) {
                    console.log(result);
                }
            });
        }

        
        function ListarCboTipoPersona() {
            $.ajax({
                url: "controlador/contTipoPersona.php",
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
                    $("#cboTipoPersona").html($cuerpo);
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
                url: "controlador/contCliente.php",
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

            if ($("#cboDocumento").val().trim() == 0) {
                msgAlerta('error', 'Debe seleccionar un documento para el ' + $("#identificador").val(), titulo);
                $("#cboDocumento").focus();
                return false;
            }

            if ($("#txtNombre_cli").val().trim() == "") {
                msgAlerta('error', 'Ingrese el nombre del ' + $("#identificador").val(), titulo);
                $("#txtNombre_cli").focus();
                return false;
            }

            if ($("#cboDepartamento").val().trim() == 0) {
                msgAlerta('error', 'Debe seleccionar un departamento para el ' + $("#identificador").val(), titulo);
                $("#cboDepartamento").focus();
                return false;
            }

            if ($("#cboProvincia").val().trim() == 0) {
                msgAlerta('error', 'Debe seleccionar una provincia para el ' + $("#identificador").val(), titulo);
                $("#cboProvincia").focus();
                return false;
            }

            if ($("#cboDistrito").val().trim() == 0) {
                msgAlerta('error', 'Debe seleccionar un distrito para el ' + $("#identificador").val(), titulo);
                $("#cboDistrito").focus();
                return false;
            }

            if ($("#cboTipoPersona").val().trim() == 0) {
                msgAlerta('error', 'Debe seleccionar un tipo de persona para el ' + $("#identificador").val(), titulo);
                $("#cboTipoPersona").focus();
                return false;
            }
            
            return true;
        }

        function Editar(id) {
            fnLimpiar();
            $.ajax({
                url: "controlador/contCliente.php",
                type: "POST",
                async: false,
                data: {
                    "accion": "Editar",
                    "codigo": id
                },
                success: function(data) {
                    var data = JSON.parse(data);
                    $("#hdcod").val(data[0].codigo);
                    $("#cboDocumento").val(data[0].codigo_doc).trigger('change'); // Disparar evento change para select2
                    $("#txtNumero_doc").val(data[0].numero_doc);
                    $("#txtNombre_cli").val(data[0].nombre);
                    $("#txtDireccion_cli").val(data[0].direccion_cli);
                    $("#cboDepartamento").val(data[0].codigo_dep).trigger('change'); // Disparar evento change para select2
                    
                    // Esperar un breve momento antes de seleccionar provincia y distrito
                    setTimeout(function() {
                        $("#cboProvincia").val(data[0].codigo_pro).trigger('change'); // Disparar evento change para select2
                    }, 100);

                    setTimeout(function() {
                        $("#cboDistrito").val(data[0].codigo_dis).trigger('change'); // Disparar evento change para select2
                    }, 500);

                    $("#txtEstado_cli").val(data[0].estadosunat_cli);
                    $("#txtCondicion_cli").val(data[0].condicionsunat_cli);
                    $("#txtTelefono_cli").val(data[0].telefono_cli);
                    $("#txtCorreo_cli").val(data[0].email_cli);
                    $("#cboTipoPersona").val(data[0].codigo_tip).trigger('change'); // Disparar evento change para select2
                    $("#txtObservacion_cli").val(data[0].observacion_cli);

                    $("#Lista").hide();
                    $("#mdRegistro").show();
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
            var titulo = 'Eliminar ' + $("#identificador").val();
            $.ajax({
                url: "controlador/contCliente.php",
                type: "POST",
                data: {
                    "accion": "Eliminar",
                    "codigo": id
                },
                success: function(data) {
                    var data = JSON.parse(data);
                    if (data[0].rpta == 0) {
                        msgAlerta('error', data[0].msj, titulo);
                    } else {
                        msgAlerta('success', data[0].msj, titulo);
                        Listar();
                    }
                    //loading(false);
                },
                error: function(result) {
                    console.log(result);
                    msgAlerta('error', $("#identificador").val() + ' no pudo ser eliminada.', titulo);
                }
            });
            //}
        }

        function fnLimpiar() {
            $("#hdcod").val("0");
            $("#cboDocumento").val("0").change();
            $("#txtNumero_doc").val("");
            $("#txtNombre_cli").val("");
            $("#txtDireccion_cli").val("");
            $("#cboDepartamento").val("0").change();
            $("#txtEstado_cli").val("");
            $("#cboProvincia").val("0").change();
            $("#txtCondicion_cli").val("");
            $("#cboDistrito").val("0").change();
            $("#txtTelefono_cli").val("");
            $("#txtCorreo_cli").val("");
            $("#cboTipoPersona").val("0").change();
            $("#txtObservacion_cli").val("");
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
                            <!--- <div class="card-body pL-2 pr-2">-->
                            <div class="card-body">

                                <div class="table-responsive" style="font-size: 11px;">
                                    <table id="tCliente" class="display compact order-column form-control-sm" style="width:98%;">
                                        <thead>
                                            <tr>
                                                <th style="width: 3%; text-align:center;">
                                                    N°
                                                </th>
                                                <th style="width: 24%; text-align:center;">
                                                    Nombre o Razón Social
                                                </th>
                                                <th style="width: 24%; text-align:center;">
                                                    Dirección
                                                </th>
                                                <th style="width: 10%; text-align:center;">
                                                    Tipo Persona
                                                </th>
                                                <th style="width: 6%; text-align:center;">
                                                    Doc.
                                                </th>
                                                <th style="width: 8%; text-align:center;">
                                                    Número
                                                </th>
                                                <th style="width: 6%; text-align:center;">
                                                    Acción
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbCliente">
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
                            <div class="col-xl-8 col-md-8 col-lg-8">
                                <div class="card shadow">
                                    <!-- Card Header - Dropdown -->
                                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                        <h6 class="card-title text-primary font-weight-bold" id="tituloMantenimiento"></h6>
                                        <input type="hidden" id="identificador" name="identificador" value="">
                                    </div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-sm-12 col-md-12" >
                                                <!-- <form id="frmRegistro" class="needs-validation" novalidate>-->
                                                <form id="frmRegistro">
                                                    
                                                    <div class="form-group">                                                        
                                                        <div class="form-row mb-2 form-control-sm">
                                                            <label for="lblDocumento" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                                Documento: </label>
                                                            <div class="col-sm-3 col-md-3">
                                                            <select class="cboDocumento form-control" style="width:200px" id="cboDocumento" name="cboDocumento"></select>
                                                            </div>

                                                            <label for="lblNumero" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                                                Número: </label>
                                                            <div class="col-sm-3">
                                                                <input type="text" class="form-control form-control-sm" id="txtNumero_doc" name="txtNumero_doc" maxlength="20"  />
                                                            </div>

                                                        </div>
                                                        <hr> <!-- Línea horizontal -->
                                                    </div>

                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="lblNombre" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Nombre o Razón Social: </label>
                                                        <div class="col-sm-8">
                                                            <input type="hidden" id="hdcod" name="hdcod" value="0">
                                                            <input type="text" class="form-control form-control-sm" id="txtNombre_cli" name="txtNombre_cli" maxlength="500" />
                                                        </div>
                                                    </div>

                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="lblDireccion_cli" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Dirección: </label>
                                                        <div class="col-sm-8">
                                                           <input type="text" class="form-control form-control-sm" id="txtDireccion_cli" name="txtDireccion_cli" maxlength="500" />
                                                        </div>
                                                    </div>


                                                    <div class="form-group">                                                        
                                                        <div class="form-row mb-2 form-control-sm">
                                                            <label for="lblDepartamento" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                                Departamento: </label>
                                                            <div class="col-sm-3 col-md-3">
                                                            <select class="cboDepartamento form-control" style="width:200px" id="cboDepartamento" name="cboDepartamento"></select>
                                                            </div>

                                                            <label for="lblEstado" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                                                Estado: </label>
                                                            <div class="col-sm-3">
                                                                <input type="text" class="form-control form-control-sm" id="txtEstado_cli" name="txtEstado_cli" maxlength="20"  />
                                                            </div>

                                                        </div>
                                                    </div>

                                                    <div class="form-group">                                                        
                                                        <div class="form-row mb-2 form-control-sm">
                                                            <label for="lblProvincia" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                                Provincia: </label>
                                                            <div class="col-sm-3 col-md-3">
                                                            <select class="cboProvincia form-control" style="width:200px" id="cboProvincia" name="cboProvincia"></select>
                                                            </div>

                                                            <label for="lblCondicion" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                                                Condición: </label>
                                                            <div class="col-sm-3">
                                                                <input type="text" class="form-control form-control-sm" id="txtCondicion_cli" name="txtCondicion_cli" maxlength="20"  />
                                                            </div>

                                                        </div>
                                                    </div>

                                                    <div class="form-group">                                                        
                                                        <div class="form-row mb-2 form-control-sm">
                                                            <label for="lblDistrito" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                                Distrito: </label>
                                                            <div class="col-sm-3 col-md-3">
                                                            <select class="cboDistrito form-control" style="width:200px" id="cboDistrito" name="cboDistrito"></select>
                                                            </div>

                                                            <label for="lblTelefono" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                                                Teléfono: </label>
                                                            <div class="col-sm-3">
                                                                <input type="text" class="form-control form-control-sm" id="txtTelefono_cli" name="txtTelefono_cli" maxlength="20"  />
                                                            </div>

                                                        </div>
                                                    </div>


                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="lblCorreo_cli" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            E-Mail: </label>
                                                        <div class="col-sm-8">
                                                           <input type="text" class="form-control form-control-sm" id="txtCorreo_cli" name="txtCorreo_cli" maxlength="500" />
                                                        </div>
                                                    </div>

                                                    
                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="lblTipoPersona" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Tipo de Persona: </label>
                                                        <div class="col-sm-4">
                                                            <select class="cboTipoPersona form-control" style="width:435px" id="cboTipoPersona" name="cboTipoPersona"></select>
                                                        </div>
                                                    </div>

                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="txtObservacion_cli" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Observación: </label>
                                                        <div class="col-sm-8">
                                                           <input type="text" class="form-control form-control-sm" id="txtObservacion_cli" name="txtObservacion_cli" maxlength="500" />
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
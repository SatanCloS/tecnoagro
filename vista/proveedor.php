<!DOCTYPE html>
<html lang="en">

<head>
    <script type="text/javascript">
        "use strict";
        $(document).ready(function() {
            $("#mdRegistro").hide();
            //$("#mdListarTipoPersona").hide();
            //$("#mdListarDocumento").hide();

            $("#tituloLista").text("Listado de Proveedores");
            $("#tituloMantenimiento").text("Gestión de Proveedores");
            $("#identificador").val("Proveedor");

            Listar();

            $("#cboDocumento").select2();
            ListarCboDocumento();

            $("#cboTipoPersona").select2();
            ListarCboTipoPersona();

            $("#btnNuevo").click(function() {
                //loading(true);
                fnLimpiar();
                $("#Lista").hide();
                $("#mdRegistro").show();                
                //$("#mdListarTipoPersona").hide();
                //$("#mdListarDocumento").hide();

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
                //$("#mdListarTipoPersona").hide();
                //$("#mdListarDocumento").hide();
                //Listar();
                //loading(false);
            });

            
            // $("#btnBuscarTipoPersona").click(function() {
            //     $("#Lista").hide();
            //     $("#mdRegistro").hide();
            //     $("#mdListarTipoPersona").show();
              
            //    ListarTipoPersona();
            // });

            
            // $("#btnCancelarTipoPersona").click(function() {
            //     $("#Lista").hide();
            //     $("#mdRegistro").show();
            //     $("#mdListarTipoPersona").hide();
            //     //$("#txtNombre").focus();
            // });



           
            // $("#btnBuscarDocumento").click(function() {
            //     $("#Lista").hide();
            //     $("#mdRegistro").hide();
            //     $("#mdListarTipoPersona").hide();
            //     $("#mdListarDocumento").show();

            //    ListarDocumento();
            // });

            
            // $("#btnCancelarDocumento").click(function() {
            //     $("#Lista").hide();
            //     $("#mdRegistro").show();
            //     $("#mdListarTipoPersona").hide();
            //     $("#mdListarDocumento").hide();
            //     //$("#txtNombre").focus();
            // });

            //loading(false);
        })

        function Listar() {
            ////loading(true);
            $.ajax({
                url: "controlador/contProveedor.php",
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
                            $cuerpo += "<td>" + data[i].direccion_pro + "</td>";  
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
                    $("#tProveedor").DataTable().destroy();
                    $("#tbProveedor").html($cuerpo);
                    $("#tProveedor").DataTable({
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
                url: "controlador/contProveedor.php",
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

            if ($("#txtNombre").val().trim() == "") {
                msgAlerta('error', 'Debe ingresar el nombre del ' + $("#identificador").val(), titulo);
                $("#txtNombre").focus();
                return false;
            }

            if ($("#cboTipoPersona").val().trim() == 0) {
                msgAlerta('error', 'Debe seleccionar un tipo de persona de ' + $("#identificador").val(), titulo);
                $("#cboTipoPersona").focus();
                return false;
            }

            if ($("#cboDocumento").val().trim() == 0) {
                msgAlerta('error', 'Debe seleccionar un documento de ' + $("#identificador").val(), titulo);
                $("#cboDocumento").focus();
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
                url: "controlador/contProveedor.php",
                type: "POST",
                async: false,
                //dataType: "json",
                data: {
                    "accion": "Editar",
                    "codigo": id
                },
                success: function(data) {
                    //console.log(data);
                    var data = JSON.parse(data);
                    $("#hdcod").val(data[0].codigo);
                    $("#txtNombre").val(data[0].nombre);
                    $("#txtDireccion_pro").val(data[0].direccion_pro);
                    $("#txtCiudad_pro").val(data[0].ciudad_pro);
                    $("#txtTelefono_pro").val(data[0].telefono_pro);
                    $("#cboTipoPersona").val(data[0].codigo_tip).change();
                    // $("#txtNombre_tip").val(data[0].nombre_tip);
                    $("#cboDocumento").val(data[0].codigo_doc).change();
                    //$("#txtNombre_doc").val(data[0].nombre_doc);
                    $("#txtNumero_doc").val(data[0].numero_doc);
                    $("#txtObservacion_pro").val(data[0].observacion_pro);
                     
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
                url: "controlador/contProveedor.php",
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
                    console.log(result);
                    msgAlerta('error', $("#identificador").val() + ' no pudo ser eliminada.', titulo);
                }
            });
            //}
        }

        function fnLimpiar() {
            $("#hdcod").val("0");
            $("#txtNombre").val("");
            $("#txtDireccion_pro").val("");
            $("#txtCiudad_pro").val("");
            $("#txtTelefono_pro").val("");            
            $("#cboTipoPersona").val("0").change();
            // $("#txtNombre_tip").val("");
            $("#cboDocumento").val("0").change();
            // $("#txtNombre_doc").val("");
            $("#txtNumero_doc").val("");
            $("#txtObservacion_pro").val("");
        }


        // function ListarTipoPersona() {
           
        //     $.ajax({
        //         url: "controlador/contTipoPersona.php",
        //         type: "POST",
        //         data: {
        //             "accion": "Listar"
        //         },
                
        //         success: function(data) {
        //             var data = JSON.parse(data);
                    
        //             var $cuerpo = "";
        //             if (data.length > 0) {
        //                 for (var i = 0; i < data.length; i++) {
        //                     $cuerpo += "<tr>";
        //                     $cuerpo += "<td align='center'>" + (i + 1) + "</td>";
        //                     $cuerpo += "<td>" + data[i].nombre + "</td>";
        //                     $cuerpo += "<td style='font-size:10px; text-align:center;'>";
        //                     $cuerpo += "<button type='button' class='btn btn-info btn-sm btn-radius' onclick='EditarTipoPersona(" + data[i].codigo + ")' title='Editar' >  <i class='fas fa-check small'></i> </i></button>";
        //                     $cuerpo += "</td>";
        //                     $cuerpo += "</tr>";                        
        //                 }
        //             }
        //             $("#tListadoTipoPersona").DataTable().destroy();
        //             $("#tbListadoTipoPersona").html($cuerpo);
        //             $("#tListadoTipoPersona").DataTable({
        //                 "processing": true,
        //                 'dom': 'Blfrtip',
        //                 'buttons': [
                            
        //                     {
        //                         "extend": 'excel',
        //                         "text": '<i class="fa fa-file-excel"></i> Exportar a Excel',
        //                         "className": 'btn btn-sm btn-radius btn-success mb-2',
        //                         "title": 'Listado'
        //                     }, {
        //                         "extend": 'pdf',
        //                         "text": '<i class="fa fa-file-pdf"></i> Exportar a PDF',
        //                         "className": 'btn btn-sm btn-radius btn-danger mb-2',
        //                         "title": 'Listado'
        //                     }
        //                 ],
        //                 "language": {
        //                     "url": "plugins/jquery.dataTables/Spanish.json"
        //                 },
        //                 columnDefs: [{
        //                     orderable: false,
        //                     targets: 2
        //                 }]

        //             });
                    
        //         },
        //         error: function(result) {
        //             console.log(result);
        //         }
        //     });
        // }

        // function EditarTipoPersona(id) {
            
        //     $.ajax({
        //         url: "controlador/contTipoPersona.php",
        //         type: "POST",
        //         async: false,
                
        //         data: {
        //             "accion": "Editar",
        //             "codigo": id
        //         },
        //         success: function(data) {
        //             var data = JSON.parse(data);
        //             $("#txtCodigo_tip").val(data[0].codigo);
        //             $("#txtNombre_tip").val(data[0].nombre);
                    
        //             $("#mdRegistro").show();
        //             $("#mdListarTipoPersona").hide();
        //         },
        //         error: function(result) {
                    
        //             console.log(result);
        //         }
        //     });

        // }

        // function ListarDocumento() {
            
        //     $.ajax({
        //         url: "controlador/contDocumento.php",
        //         type: "POST",
        //         data: {
        //             "accion": "Listar"
        //         },
                
        //         success: function(data) {
        //             var data = JSON.parse(data);
        //             var $cuerpo = "";
        //             if (data.length > 0) {
        //                 for (var i = 0; i < data.length; i++) {
        //                     $cuerpo += "<tr>";
        //                     $cuerpo += "<td align='center'>" + (i + 1) + "</td>";
        //                     $cuerpo += "<td>" + data[i].nombre + "</td>";
        //                     $cuerpo += "<td style='font-size:10px; text-align:center;'>";
        //                     $cuerpo += "<button type='button' class='btn btn-info btn-sm btn-radius' onclick='EditarDocumento(" + data[i].codigo + ")' title='Editar' >  <i class='fas fa-check small'></i> </i></button>";
        //                     $cuerpo += "</td>";
        //                     $cuerpo += "</tr>";                        
        //                 }
        //             }
                    
        //             $("#tListadoDocumento").DataTable().destroy();
        //             $("#tbListadoDocumento").html($cuerpo);
        //             $("#tListadoDocumento").DataTable({
        //                 "processing": true,
        //                 'dom': 'Blfrtip',
        //                 'buttons': [
                           
        //                     {
        //                         "extend": 'excel',
        //                         "text": '<i class="fa fa-file-excel"></i> Exportar a Excel',
        //                         "className": 'btn btn-sm btn-radius btn-success mb-2',
        //                         "title": 'Listado'
        //                     }, {
        //                         "extend": 'pdf',
        //                         "text": '<i class="fa fa-file-pdf"></i> Exportar a PDF',
        //                         "className": 'btn btn-sm btn-radius btn-danger mb-2',
        //                         "title": 'Listado'
        //                     }
        //                 ],
        //                 "language": {
        //                     "url": "plugins/jquery.dataTables/Spanish.json"
        //                 },
        //                 columnDefs: [{
        //                     orderable: false,
        //                     targets: 2
        //                 }]

        //             });
                    
        //         },
        //         error: function(result) {
        //             console.log(result);
        //         }
        //     });
        // }

        // function EditarDocumento(id) {
            
        //     $.ajax({
        //         url: "controlador/contDocumento.php",
        //         type: "POST",
        //         async: false,
                
        //         data: {
        //             "accion": "Editar",
        //             "codigo": id
        //         },
        //         success: function(data) {
        //             var data = JSON.parse(data);
        //             $("#txtCodigo_doc").val(data[0].codigo);
        //             $("#txtNombre_doc").val(data[0].nombre);
                    
        //             $("#mdRegistro").show();
        //             $("#mdListarDocumento").hide();
        //         },
        //         error: function(result) {
                    
        //             console.log(result);
        //         }
        //     });

        // }


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
                                    <table id="tProveedor" class="display compact order-column form-control-sm" style="width:98%;">
                                        <thead>
                                            <tr>
                                                <th style="width: 5%; text-align:center;">
                                                    N°
                                                </th>
                                                <th style="width: 24%; text-align:center;">
                                                    Nombre o Razón Social
                                                </th>
                                                <th style="width: 24%; text-align:center;">
                                                    Dirección
                                                </th>
                                                <th style="width: 15%; text-align:center;">
                                                    Tipo Persona
                                                </th>
                                                <th style="width: 10%; text-align:center;">
                                                    Doc.
                                                </th>
                                                <th style="width: 10%; text-align:center;">
                                                    Número
                                                </th>
                                                <th style="width: 10%; text-align:center;">
                                                    Acción
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbProveedor">
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
                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="txtNombre" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Nombre o Razón Social: </label>
                                                        <div class="col-sm-8">
                                                            <input type="hidden" id="hdcod" name="hdcod" value="0">
                                                            <input type="text" class="form-control form-control-sm" id="txtNombre" name="txtNombre" maxlength="500" />
                                                            <!--<div class="invalid-feedback">
                                                                Ingrese Nombre
                                                            </div> -->
                                                        </div>
                                                    </div>

                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="txtDireccion_pro" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Dirección: </label>
                                                        <div class="col-sm-8">
                                                           <input type="text" class="form-control form-control-sm" id="txtDireccion_pro" name="txtDireccion_pro" maxlength="500" />
                                                        </div>
                                                    </div>

                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="txtCiudad_pro" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Ciudad: </label>
                                                        <div class="col-sm-8">
                                                           <input type="text" class="form-control form-control-sm" id="txtCiudad_pro" name="txtCiudad_pro" maxlength="100" />
                                                        </div>

                                                       
                                                    </div>


                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="txtTelefono_pro" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Telefono: </label>
                                                        <div class="col-sm-8">
                                                           <input type="text" class="form-control form-control-sm" id="txtTelefono_pro" name="txtTelefono_pro" maxlength="100" />
                                                        </div>
                                                    </div>


                                                    <!-- <div class="form-row mb-2 form-control-sm">
                                                        <label for="txtTipoPersona" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                        Tipo de Persona: </label>
                                                        
                                                        <div class="col-sm-1" style="text-align: center;">
                                                            <input type="hidden" id="txtCodigo_tip" name="txtCodigo_tip" value="0">
                                                            <button type="button" id="btnBuscarTipoPersona" class="btn  btn-sm btn-outline-success">
                                                                <i class="fas fa-search-plus"></i></button>
                                                        </div>
                                                        <div class="col-sm-7">
                                                            <input type="text" class="form-control form-control-sm" id="txtNombre_tip" name="txtNombre_tip"  maxlength="100" readonly />
                                                        </div>
                                                    </div> -->

                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="lblTipoPersona" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Tipo de Persona: </label>
                                                        <div class="col-sm-4">
                                                            <select class="cboTipoPersona form-control" style="width:435px" id="cboTipoPersona" name="cboTipoPersona"></select>
                                                        </div>
                                                    </div>

                                                    


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
                                                    </div>

                                                    
                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="txtObservacion_pro" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Observación: </label>
                                                        <div class="col-sm-8">
                                                           <input type="text" class="form-control form-control-sm" id="txtObservacion_pro" name="txtObservacion_pro" maxlength="500" />
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




                <!-- <div class="row" id="mdListarTipoPersona">
                    <div class="container">
                        <div class="row justify-content-center">
                        
                            <div class="col-xl-8 col-md-8 col-lg-8">
                                <div class="card shadow">
                                   
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-sm-12 col-md-12">
                                                <form id="frmListadoTipoPersona">
                                                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                                        <div class="col-sm-8 text-left">
                                                            <h5 class="m-0" id="tituloLista">Listado de Tipo de Persona</h5>
                                                        </div>
                                                        <div class="col-sm-4 text-right">
                                                            
                                                            <button type="button" id="btnCancelarTipoPersona" class="btn btn-sm btn-danger btn-radius">
                                                                <i class="fa fa-times-circle"></i>&nbsp;Cancelar</button>
                                                        </div>
                                                    </div>



                                                    <div class="card-body">
                                                        <div class="table-responsive" style="font-size: 11px;">
                                                            <table id="tListadoTipoPersona" class="display compact order-column form-control-sm" style="width:98%;">
                                                                <thead>
                                                                    <tr>
                                                                        <th style="width: 5%; text-align:center;">
                                                                            N°
                                                                        </th>
                                                                        <th style="width: 83%; text-align:center;">
                                                                            Nombre
                                                                        </th>
                                                                        <th style="width: 10%; text-align:center;">
                                                                            Acción
                                                                        </th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody id="tbListadoTipoPersona">
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>

                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div> -->




                <!-- <div class="row" id="mdListarDocumento">
                    <div class="container">
                        <div class="row justify-content-center">
                        
                            <div class="col-xl-8 col-md-8 col-lg-8">
                                <div class="card shadow">
                                    
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-sm-12 col-md-12">
                                                <form id="frmListadoDocumento">
                                                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                                        <div class="col-sm-8 text-left">
                                                            <h5 class="m-0" id="tituloLista">Listado de Documento</h5>
                                                        </div>
                                                        <div class="col-sm-4 text-right">
                                                            <button type="button" id="btnCancelarDocumento" class="btn btn-sm btn-danger btn-radius">
                                                                <i class="fa fa-times-circle"></i>&nbsp;Cancelar</button>
                                                        </div>
                                                    </div>
                                                    <div class="card-body">
                                                        <div class="table-responsive" style="font-size: 11px;">
                                                            <table id="tListadoDocumento" class="display compact order-column form-control-sm" style="width:98%;">
                                                                <thead>
                                                                    <tr>
                                                                        <th style="width: 5%; text-align:center;">
                                                                            N°
                                                                        </th>
                                                                        <th style="width: 83%; text-align:center;">
                                                                            Nombre
                                                                        </th>
                                                                        <th style="width: 10%; text-align:center;">
                                                                            Acción
                                                                        </th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody id="tbListadoDocumento">
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>

                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div> -->



            </div>
            <!-- /.container-fluid -->
        </section>
        <!-- /.content -->
    </div>
</body>
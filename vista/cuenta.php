<!DOCTYPE html>
<html lang="en">

<head>
    <script type="text/javascript">
        "use strict";
        $(document).ready(function() {
            $("#mdRegistro").hide();
            // $("#mdListarMoneda").hide();
            // $("#mdListarBanco").hide();
            // $("#mdListarSucursal").hide();

            $("#tituloLista").text("Listado de Cuentas");
            $("#tituloMantenimiento").text("Gestión de Cuentas");
            $("#identificador").val("Cuenta");

            Listar();

            $("#cboMoneda").select2();
            ListarCboMoneda();

            $("#cboBanco").select2();
            ListarCboBanco();

            $("#cboSucursal").select2();
            ListarCboSucursal();


            $("#btnNuevo").click(function() {
                //loading(true);
                fnLimpiar();
                $("#Lista").hide();
                $("#mdRegistro").show();                
                // $("#mdListarMoneda").hide();
                // $("#mdListarBanco").hide();
                // $("#mdListarSucursal").hide();


                $("#txtNombre").focus();
                
            })

            $("#btnGuardar").click(function() {
                ConfirmarGuardar();     
            });

            $("#btnCancelar").click(function() {
                $("#Lista").show();
                $("#mdRegistro").hide();
                // $("#mdListarMoneda").hide();
                // $("#mdListarBanco").hide();
                // $("#mdListarSucursal").hide();
                
            });

            
            // $("#btnBuscarMoneda").click(function() {
            //     $("#Lista").hide();
            //     $("#mdRegistro").hide();
            //     $("#mdListarMoneda").show();
            //     $("#mdListarBanco").hide();
            //     $("#mdListarSucursal").hide();

            //     ListarMoneda();
            // });

            
            // $("#btnCancelarMoneda").click(function() {
            //     $("#Lista").hide();
            //     $("#mdRegistro").show();
            //     $("#mdListarMoneda").hide();
            //     $("#mdListarBanco").hide();
            //     $("#mdListarSucursal").hide();
            //     //$("#txtNombre").focus();
            // });



            // $("#btnBuscarBanco").click(function() {
            //     $("#Lista").hide();
            //     $("#mdRegistro").hide();
            //     $("#mdListarMoneda").hide();
            //     $("#mdListarBanco").show();
            //     $("#mdListarSucursal").hide();

            //    ListarBanco();
            // });

            
            // $("#btnCancelarBanco").click(function() {
            //     $("#Lista").hide();
            //     $("#mdRegistro").show();
            //     $("#mdListarMoneda").hide();
            //     $("#mdListarBanco").hide();
            //     $("#mdListarSucursal").hide();

            // });


            // $("#btnBuscarSucursal").click(function() {
            //     $("#Lista").hide();
            //     $("#mdRegistro").hide();
            //     $("#mdListarMoneda").hide();
            //     $("#mdListarBanco").hide();
            //     $("#mdListarSucursal").show();

            //     ListarSucursal();
            // });

            
            // $("#btnCancelarSucursal").click(function() {
            //     $("#Lista").hide();
            //     $("#mdRegistro").show();
            //     $("#mdListarMoneda").hide();
            //     $("#mdListarBanco").hide();
            //     $("#mdListarSucursal").hide();
            // });


            //loading(false);
        })

        function Listar() {
            ////loading(true);
            $.ajax({
                url: "controlador/contCuenta.php",
                type: "POST",
                data: {
                    "accion": "Listar",
                    "accionBuscar":"L",
                    "codigo_suc": "1"                    
                },
                success: function(data) {
                    var data = JSON.parse(data);
                    //console.log(data);
                    var $cuerpo = "";
                    if (data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            $cuerpo += "<tr>";
                            $cuerpo += "<td align='center'>" + (i + 1) + "</td>";
                            $cuerpo += "<td>" + data[i].nombre + "</td>"; 
                            $cuerpo += "<td>" + data[i].abreviatura_mon + "</td>";  
                            $cuerpo += "<td>" + data[i].nombre_ban + "</td>";  
                            $cuerpo += "<td>" + data[i].titular_cta + "</td>";  
                            $cuerpo += "<td>" + data[i].nombre_suc + "</td>";  
                            $cuerpo += "<td style='font-size:10px; text-align:center;'>";
                            $cuerpo += "<button type='button' class='btn btn-info btn-sm btn-radius' onclick='Editar(" + data[i].codigo + ")' title='Editar' ><i class='fas fa-edit small'></i></button>";
                            $cuerpo += " <button type='button' class='btn btn-danger btn-sm btn-radius' onclick='ConfirmarEliminar(" + data[i].codigo + ")' title='Eliminar'><i class='fa fa-trash-alt small'></i></button>";
                            $cuerpo += "</td>";
                            $cuerpo += "</tr>";   
                        }
                    }
                   // console.log($cuerpo)
                    $("#tCuenta").DataTable().destroy();
                    $("#tbCuenta").html($cuerpo);
                    $("#tCuenta").DataTable({
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


        function ListarCboMoneda() {
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
                    $("#cboMoneda").html($cuerpo);
                },
                error: function(result) {
                    console.log(result);
                }
            });
        }

        function ListarCboBanco() {
            $.ajax({
                url: "controlador/contBanco.php",
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
                    $("#cboBanco").html($cuerpo);
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


        function Guardar() {
            //loading(true);
            $("form#frmRegistro input[id=accion]").remove();
            $('#frmRegistro').append('<input type="hidden" id="accion" name="accion" value="Actualizar" />');
            var form = $("#frmRegistro").serializeArray();
            $("form#frmRegistro input[id=accion]").remove();
            $.ajax({
                url: "controlador/contCuenta.php",
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
                msgAlerta('error', 'Debe ingresar el nombre de la ' + $("#identificador").val(), titulo);
                $("#txtNombre").focus();
                return false;
            }
            if ($("#cboMoneda").val().trim() == 0) {
                msgAlerta('error', 'Debe seleccionar la moneda de la ' + $("#identificador").val(), titulo);
                $("#cboMoneda").focus();
                return false;
            }
            if ($("#cboBanco").val().trim() == 0) {
                msgAlerta('error', 'Debe seleccionar el banco de la ' + $("#identificador").val(), titulo);
                $("#cboBanco").focus();
                return false;
            }
            if ($("#cboSucursal").val().trim() == 0) {
                msgAlerta('error', 'Debe seleccionar la sucursal de la ' + $("#identificador").val(), titulo);
                $("#cboSucursal").focus();
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
                url: "controlador/contCuenta.php",
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
                    $("#txtTitular_cta").val(data[0].titular_cta);
                    $("#cboMoneda").val(data[0].codigo_mon).change();
                    // $("#txtMoneda").val(data[0].nombre_mon);
                    $("#cboBanco").val(data[0].codigo_ban).change();
                    // $("#txtBanco").val(data[0].nombre_ban);
                    $("#cboSucursal").val(data[0].codigo_suc).change();
                    // $("#txtSucursal").val(data[0].nombre_suc);
                     
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
                url: "controlador/contCuenta.php",
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
            $("#txtTitular_cta").val("");

            $("#cboMoneda").val("0").change();
            $("#cboBanco").val("0").change();
            $("#cboSucursal").val("0").change();
        }


        // function ListarMoneda() {
        //     $.ajax({
        //         url: "controlador/contMoneda.php",
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
        //                     $cuerpo += "<td>" + data[i].abreviatura_mon + "</td>";
        //                     $cuerpo += "<td style='font-size:10px; text-align:center;'>";
        //                     $cuerpo += "<button type='button' class='btn btn-info btn-sm btn-radius' onclick='EditarMoneda(" + data[i].codigo + ")' title='Editar' >  <i class='fas fa-check small'></i> </i></button>";
        //                     $cuerpo += "</td>";
        //                     $cuerpo += "</tr>";                        
        //                 }
        //             }
        //             $("#tListadoMoneda").DataTable().destroy();
        //             $("#tbListadoMoneda").html($cuerpo);
        //             $("#tListadoMoneda").DataTable({
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

        // function EditarMoneda(id) {
        //     $.ajax({
        //         url: "controlador/contMoneda.php",
        //         type: "POST",
        //         async: false,
        //         data: {
        //             "accion": "Editar",
        //             "codigo": id
        //         },
        //         success: function(data) {

        //             var data = JSON.parse(data);
        //             $("#txtCodigo_mon").val(data[0].codigo);
        //             $("#txtMoneda").val(data[0].nombre);
                    
        //             $("#mdRegistro").show();
        //             $("#mdListarMoneda").hide();
        //         },
        //         error: function(result) {
        //             console.log(result);
        //         }
        //     });

        // }

        // function ListarBanco() {
        //     $.ajax({
        //         url: "controlador/contBanco.php",
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
        //                     $cuerpo += "<button type='button' class='btn btn-info btn-sm btn-radius' onclick='EditarBanco(" + data[i].codigo + ")' title='Editar' >  <i class='fas fa-check small'></i> </i></button>";
        //                     $cuerpo += "</td>";
        //                     $cuerpo += "</tr>";                        
        //                 }
        //             }
        //             $("#tListadoBanco").DataTable().destroy();
        //             $("#tbListadoBanco").html($cuerpo);
        //             $("#tListadoBanco").DataTable({
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

        // function EditarBanco(id) {
        //     $.ajax({
        //         url: "controlador/contBanco.php",
        //         type: "POST",
        //         async: false,
        //         data: {
        //             "accion": "Editar",
        //             "codigo": id
        //         },
        //         success: function(data) {
        //             var data = JSON.parse(data);
        //             $("#txtCodigo_ban").val(data[0].codigo);
        //             $("#txtBanco").val(data[0].nombre);
                    
        //             $("#mdRegistro").show();
        //             $("#mdListarBanco").hide();
        //         },
        //         error: function(result) {
        //             console.log(result);
        //         }
        //     });

        // }

        // function ListarSucursal() {
        //     $.ajax({
        //         url: "controlador/contSucursal.php",
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
        //                     $cuerpo += "<button type='button' class='btn btn-info btn-sm btn-radius' onclick='EditarSucursal(" + data[i].codigo + ")' title='Editar' >  <i class='fas fa-check small'></i> </i></button>";
        //                     $cuerpo += "</td>";
        //                     $cuerpo += "</tr>";                        
        //                 }
        //             }
        //             $("#tListadoSucursal").DataTable().destroy();
        //             $("#tbListadoSucursal").html($cuerpo);
        //             $("#tListadoSucursal").DataTable({
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

        // function EditarSucursal(id) {
        //     $.ajax({
        //         url: "controlador/contSucursal.php",
        //         type: "POST",
        //         async: false,
        //         data: {
        //             "accion": "Editar",
        //             "codigo": id
        //         },
        //         success: function(data) {
        //             var data = JSON.parse(data);
        //             $("#txtCodigo_suc").val(data[0].codigo);
        //             $("#txtSucursal").val(data[0].nombre);
                    
        //             $("#mdRegistro").show();
        //             $("#mdListarSucursal").hide();
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
        <!-- /.content-header -->
        <section class="content pt-2">
            <div class="container-fluid">
                <div class="row" id="Lista">
                    <div class="col-md-12 col-sm-12">
                        <div class="card shadow">
                            <!-- Card Header - Dropdown -->
                            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                <<div class="col-sm-8">
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
                                    <table id="tCuenta" class="display compact order-column form-control-sm" style="width:98%;">
                                        <thead>
                                            <tr>
                                                <th style="width: 5%; text-align:center;">
                                                    N°
                                                </th>
                                                <th style="width: 15%; text-align:center;">
                                                    Número de Cuenta
                                                </th>
                                                <th style="width: 8%; text-align:center;">
                                                    Moneda
                                                </th>
                                                <th style="width: 15%; text-align:center;">
                                                    Banco
                                                </th>
                                                <th style="width: 25%; text-align:center;">
                                                    Titular
                                                </th>
                                                <th style="width: 20%; text-align:center;">
                                                    Sucursal
                                                </th>
                                                <th style="width: 10%; text-align:center;">
                                                    Acción
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbCuenta">
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
                                                            Nro. de Cuenta: </label>
                                                        <div class="col-sm-8">
                                                            <input type="hidden" id="hdcod" name="hdcod" value="0">
                                                            <input type="text" class="form-control form-control-sm" id="txtNombre" name="txtNombre" maxlength="500" />
                                                            <!--<div class="invalid-feedback">
                                                                Ingrese Nombre
                                                            </div> -->
                                                        </div>
                                                    </div>

                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="txtTitular_cta" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                        Titular: </label>
                                                        <div class="col-sm-8">
                                                           <input type="text" class="form-control form-control-sm" id="txtTitular_cta" name="txtTitular_cta" maxlength="500" />
                                                        </div>
                                                    </div>


                                                    <!-- <div class="form-row mb-2 form-control-sm">
                                                        <label for="txtMoneda" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                        Moneda: </label>
                                                        
                                                        <div class="col-sm-1" style="text-align: center;">
                                                            <input type="hidden" id="txtCodigo_mon" name="txtCodigo_mon" value="0">
                                                            <button type="button" id="btnBuscarMoneda" class="btn btn-sm  btn-outline-success">
                                                                <i class="fas fa-search-plus"></i></button>
                                                        </div>
                                                        <div class="col-sm-7">
                                                            <input type="text" class="form-control form-control-sm" id="txtMoneda" name="txtMoneda"  maxlength="100" readonly />
                                                        </div>
                                                    </div> -->

                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="lblMoneda" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Moneda: </label>
                                                        <div class="col-sm-4">
                                                            <select class="cboMoneda form-control" style="width:435px" id="cboMoneda" name="cboMoneda"></select>
                                                        </div>
                                                    </div>



                                                    <!-- <div class="form-row mb-2 form-control-sm">
                                                        <label for="txtBanco" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                        Banco: </label>
                                                        
                                                        <div class="col-sm-1" style="text-align: center;">
                                                            <input type="hidden" id="txtCodigo_ban" name="txtCodigo_ban" value="0">
                                                            <button type="button" id="btnBuscarBanco" class="btn btn-sm  btn-outline-success">
                                                                <i class="fas fa-search-plus"></i></button>
                                                        </div>
                                                        <div class="col-sm-7">
                                                            <input type="text" class="form-control form-control-sm" id="txtBanco" name="txtBanco"  maxlength="100" readonly />
                                                        </div>
                                                    </div> -->

                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="lblBanco" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Banco: </label>
                                                        <div class="col-sm-4">
                                                            <select class="cboBanco form-control" style="width:435px" id="cboBanco" name="cboBanco"></select>
                                                        </div>
                                                    </div>

                                                    <!-- <div class="form-row mb-2 form-control-sm">
                                                        <label for="txtSucursal" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                        Sucursal: </label>
                                                        
                                                        <div class="col-sm-1" style="text-align: center;">
                                                            <input type="hidden" id="txtCodigo_suc" name="txtCodigo_suc" value="0">
                                                            <button type="button" id="btnBuscarSucursal" class="btn btn-sm  btn-outline-success">
                                                                <i class="fas fa-search-plus"></i></button>
                                                        </div>
                                                        <div class="col-sm-7">
                                                            <input type="text" class="form-control form-control-sm" id="txtSucursal" name="txtSucursal"  maxlength="100" readonly />
                                                        </div>
                                                    </div> -->

                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="lblSucursal" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Sucursal: </label>
                                                        <div class="col-sm-4">
                                                            <select class="cboSucursal form-control" style="width:435px" id="cboSucursal" name="cboSucursal"></select>
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




                <!-- <div class="row" id="mdListarMoneda">
                    <div class="container">
                        <div class="row justify-content-center">
                        
                            <div class="col-xl-8 col-md-8 col-lg-8">
                                <div class="card shadow">
                                    
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-sm-12 col-md-12">
                                                <form id="frmListadoMoneda">
                                                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                                        <div class="col-sm-8 text-left">
                                                            <h5 class="m-0" id="tituloLista">Listado de Monedas</h5>
                                                        </div>
                                                        <div class="col-sm-4 text-right">
                                                            
                                                            <button type="button" id="btnCancelarMoneda" class="btn btn-sm btn-danger btn-radius">
                                                                <i class="fa fa-times-circle"></i>&nbsp;Cancelar</button>
                                                        </div>
                                                    </div>



                                                    <div class="card-body">
                                                        <div class="table-responsive" style="font-size: 11px;">
                                                            <table id="tListadoMoneda" class="display compact order-column form-control-sm" style="width:98%;">
                                                                <thead>
                                                                    <tr>
                                                                        <th style="width: 5%; text-align:center;">
                                                                            N°
                                                                        </th>
                                                                        <th style="width: 83%; text-align:center;">
                                                                            Moneda
                                                                        </th>
                                                                        <th style="width: 83%; text-align:center;">
                                                                            Abreviatura
                                                                        </th>
                                                                        <th style="width: 10%; text-align:center;">
                                                                            Acción
                                                                        </th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody id="tbListadoMoneda">
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




                <!-- <div class="row" id="mdListarBanco">
                    <div class="container">
                        <div class="row justify-content-center">
                        
                            <div class="col-xl-8 col-md-8 col-lg-8">
                                <div class="card shadow">
                                    
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-sm-12 col-md-12">
                                                <form id="frmListadobanco">
                                                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                                        <div class="col-sm-8 text-left">
                                                            <h5 class="m-0" id="tituloLista">Listado de Bancos</h5>
                                                        </div>
                                                        <div class="col-sm-4 text-right">
                                                           
                                                            <button type="button" id="btnCancelarBanco" class="btn btn-sm btn-danger btn-radius">
                                                                <i class="fa fa-times-circle"></i>&nbsp;Cancelar</button>
                                                        </div>
                                                    </div>



                                                    <div class="card-body">
                                                        <div class="table-responsive" style="font-size: 11px;">
                                                            <table id="tListadoBanco" class="display compact order-column form-control-sm" style="width:98%;">
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
                                                                <tbody id="tbListadoBanco">
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



                

                <!-- <div class="row" id="mdListarSucursal">
                    <div class="container">
                        <div class="row justify-content-center">
                        
                            <div class="col-xl-8 col-md-8 col-lg-8">
                                <div class="card shadow">
                                    
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-sm-12 col-md-12">
                                                <form id="frmListadoSucursal">
                                                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                                        <div class="col-sm-8 text-left">
                                                            <h5 class="m-0" id="tituloLista">Listado de Sucursal</h5>
                                                        </div>
                                                        <div class="col-sm-4 text-right">
                                                            
                                                            <button type="button" id="btnCancelarSucursal" class="btn btn-sm btn-danger btn-radius">
                                                                <i class="fa fa-times-circle"></i>&nbsp;Cancelar</button>
                                                        </div>
                                                    </div>



                                                    <div class="card-body">
                                                        <div class="table-responsive" style="font-size: 11px;">
                                                            <table id="tListadoSucursal" class="display compact order-column form-control-sm" style="width:98%;">
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
                                                                <tbody id="tbListadoSucursal">
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
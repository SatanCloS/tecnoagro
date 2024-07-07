<!DOCTYPE html>
<html lang="en">

<head>
    <script type="text/javascript">
        "use strict";
        $(document).ready(function() {
            $("#mdRegistro").hide();
            $("#mdListarSerieDocumento").hide();

            $("#tituloLista").text("Listado de Serie de Documentos");
            $("#tituloMantenimiento").text("Gestión de Serie de Documentos");
            $("#identificador").val("Serie de Documentos");

            Listar();

            //Filtros del Listado
            $("#cboSucursal").select2();
            ListarCboSucursal();
            
            $("#cboDocumento").select2();
            ListarCboDocumento();


            $("#btnNuevo").click(function() {
                fnLimpiar();
                $("#Lista").hide();
                $("#mdListarSerieDocumento").hide();
                $("#mdRegistro").show();

                $("#cboDocumento").focus();
            })

            $("#btnGuardar").click(function() {
                ConfirmarGuardar();     
            });

            $("#btnCancelar").click(function() {
                //loading(true);
                $("#mdRegistro").hide();
                $("#mdListarSerieDocumento").hide();
                $("#Lista").show();

                //Listar();
                //loading(false);
            });

        })

        function Listar() {
            ////loading(true);
            $.ajax({
                url: "controlador/contSerieDocumento.php",
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
                            $cuerpo += "<td>" + data[i].nombre_tdo + "</td>";
                            $cuerpo += "<td>" + data[i].serie_ser + "</td>";
                            $cuerpo += "<td>" + data[i].numero_ser + "</td>";
                            $cuerpo += "<td>" + data[i].nombre_suc + "</td>";
                            $cuerpo += "<td style='font-size:10px; text-align:center;'>";
                            $cuerpo += "<button type='button' class='btn btn-info btn-sm btn-radius' onclick='Editar(" + data[i].codigo + ")' title='Editar' ><i class='fas fa-edit small'></i></button>";
                            $cuerpo += " <button type='button' class='btn btn-danger btn-sm btn-radius' onclick='ConfirmarEliminar(" + data[i].codigo + ")' title='Eliminar'><i class='fa fa-trash-alt small'></i></button>";
                            $cuerpo += "</td>";
                            $cuerpo += "</tr>";                        
                        }
                    }
                    //console.log($cuerpo)
                    $("#tSerieDocumento").DataTable().destroy();
                    $("#tbSerieDocumento").html($cuerpo);
                    $("#tSerieDocumento").DataTable({
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
                url: "controlador/contTipoDocumento.php",
                type: "POST",
                data: {
                    "accion": "Listar",
                    "accionBuscar": "L",
                    "tipo": "0"
                },
                success: function(data) {
                    var data = JSON.parse(data);
                    //console.log(data);
                    var $cuerpo = "";
                    if (data.length > 0) {
                        $cuerpo += "<option value='0'> - SELECCIONE - </option>";
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
                        $cuerpo += "<option value='0'> - SELECCIONE - </option>";
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
                url: "controlador/contSerieDocumento.php",
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

                    console.log('holaaaaaaaaaaa')

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

            // if ( $("#cboDocumento").val().trim() == "0") {
            //     mostrarMensaje('Por favor, seleccione un documento', 'alert-danger');
            //     return false;
            // }

            // //var inputValue = $("#txtDocumento").val().trim();
            // if ( $("#txtSerie").val().trim() == "") {
            //     mostrarMensaje('Por favor, digite una serie para el documento', 'alert-danger');
            //     return false;
            // }
            
            // if ( $("#txtNumero").val().trim() == "") {
            //     $("#txtNumero").val("0");
            //     //mostrarMensaje('Por favor, digite un número para el documento', 'alert-danger');
            //     //return false;
            // }

            // if ( $("#cboSucursal").val().trim() == "0") {
            //     mostrarMensaje('Por favor, seleccione una Sucursal', 'alert-danger');
            //     return false;
            // }

            if ($("#cboDocumento").val().trim() == 0) {
                msgAlerta('error', 'Debe seleccionar un documento para la ' + $("#identificador").val(), titulo);
                $("#cboDocumento").focus();
                return false;
            }

            if ($("#txtSerie").val().trim() === "" || $("#txtSerie").val().trim() === "0") {
                msgAlerta('error', 'Debe ingresar la serie', titulo);
                $("#txtSerie").focus();
                return false;
            }

            if ($("#txtNumero").val().trim() == "") {
                $("#txtNumero").val("0")                
            }

            if ($("#cboSucursal").val().trim() == 0) {
                msgAlerta('error', 'Debe seleccionar una sucursal de ' + $("#identificador").val(), titulo);
                $("#cboSucursal").focus();
                return false;
            }

            return true;
        }

        // function mostrarMensaje(mensaje, clase) {
        //     $('#mensaje').text(mensaje).removeClass('alert-success alert-danger').addClass(clase).show();
        //     // Ocultar el mensaje después de 3 segundos (2000 milisegundos)
        //     setTimeout(function() {
        //         $('#mensaje').fadeOut();
        //     }, 2000);
        // }


        function Editar(id) {
            //mostrarMensaje('Por favor, seleccione un documento ID=' + id , 'alert-danger' );
            //mostrarMensaje('Por favor, seleccione un documento ID=' + id , 'alert-danger' );
            //$("#cboDocumento option:selected").text().trim()

            //console.log(id);
            //loading(true);
            fnLimpiar();
            //$("#frmRegistro").addClass("was-validated");
            $.ajax({
                url: "controlador/contSerieDocumento.php",
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
                    $("#cboDocumento").val(data[0].codigo_tdo).change();
                    $("#txtSerie").val(data[0].serie_ser);
                    $("#txtNumero").val(data[0].numero_ser);
                    $("#cboSucursal").val(data[0].codigo_suc).change();
                    
                    $("#Lista").hide();
                    $("#mdListarSerieDocumento").hide();
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
            //mostrarMensaje('Por favor, seleccione un documento ID=' + id , 'alert-danger' );
            //alerta("Hola" + id);
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
                url: "controlador/contSerieDocumento.php",
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
            $("#cboDocumento").val("0").change();
            $("#txtSerie").val("0");
            $("#txtNumero").val("0");
            $("#cboSucursal").val("0").change();
        }




    </script>
</head>

<body class="hold-transition sidebar-mini layout-fixed">
    <!-- Elemento para mostrar mensajes de alerta -->
    <div id="mensaje" class="alert mt-2" style="display: none;"></div>
    
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
                                    <table id="tSerieDocumento" class="display compact order-column form-control-sm" style="width:98%;">
                                        <thead>
                                            <tr>
                                                <th style="width: 5%; text-align:center;">
                                                    N°
                                                </th>
                                                <th style="width: 30%; text-align:center;">
                                                    Documento
                                                </th>
                                                <th style="width: 10%; text-align:center;">
                                                    Serie
                                                </th>
                                                <th style="width: 10%; text-align:center;">
                                                    Número
                                                </th>
                                                <th style="width: 30%; text-align:center;">
                                                    Sucursal
                                                </th>                                                
                                                <th style="width: 10%; text-align:center;">
                                                    Acción
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbSerieDocumento">
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
                                            <div class="col-sm-12 col-md-12">
                                                <!-- <form id="frmRegistro" class="needs-validation" novalidate>-->
                                                <form id="frmRegistro">

                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="txtDocumento" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                        Documento: </label>
                                                        <input type="hidden" id="hdcod" name="hdcod" value="0">
                                                        <div class="col-sm-3">
                                                            <select class="cboDocumento form-control" style="width:436px" id="cboDocumento" name="cboDocumento"></select>
                                                        </div>
                                                    </div>

                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="txtSerie" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Serie: </label>
                                                        <div class="col-sm-3">
                                                           <input type="number" style="text-align:right" class="form-control form-control-sm" id="txtSerie" name="txtSerie" placeholder="0" maxlength="5" />
                                                        </div>
                                                    </div>

                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="txtNumero" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Número: </label>
                                                        <div class="col-sm-3">
                                                           <input type="number" style="text-align:right" class="form-control form-control-sm" id="txtNumero" name="txtNumero" placeholder="0" maxlength="5" />
                                                        </div>
                                                    </div>

                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="txtSucursal" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                        Sucursal: </label>
                                                        <div class="col-sm-3">
                                                            <select class="cboSucursal form-control" style="width:436px" id="cboSucursal" name="cboSucursal"></select>
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
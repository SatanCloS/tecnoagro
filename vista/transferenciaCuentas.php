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
            $('#txtFecha_fin').val(new Date().toJSON().slice(0, 10));
            $('#txtFecha_reg').val(new Date().toJSON().slice(0, 10));

            $("#mdRegistro").hide();
            $("#tituloLista").text("Listado de Transferencia de Cuentas");
            $("#tituloMantenimiento").text("Gestión de Transferencia de Cuentas");
            $("#identificador").val("Trasferencia de Cuentas");

            Listar();
            
            //Filtros del Listado
            $("#cboSucursal").select2();
            ListarCboSucursal();

            cargarCombos();

            $("#btnNuevo").click(function() {
                $("#txtEstado_reg").val("Nuevo");
                fnLimpiar();
                cargarCombos();
                $("#Lista").hide();
                $("#mdRegistro").show(); 
            })

            $("#btnConsultar").click(function() {
                Listar();
            })

            $("#btnGuardar").click(function() {
                ConfirmarGuardar();     
            });

            $("#btnCancelar").click(function() {
                //loading(true);

                $("#Lista").show();
                $("#mdRegistro").hide();
                // //Listar();
                // //loading(false);               
            });


            $("#cboSucursal_reg").on("change", function() {
                var selectedValue = $(this).val();

                if ($("#txtEstado_reg").val() === "Nuevo") {
                    ObtenerNroRecibo();
                }
                //ObtenerNroRecibo();

                $("#cboCuentaOrigen_reg").select2();
                ListarCboCuentaOrigen_reg();

                $("#cboCuentaDestino_reg").select2();
                ListarCboCuentaDestino_reg();
            });

            //actualiza la cuenta destino cuando se haya seleccionado la cuenta origen
            $("#cboCuentaOrigen_reg").on("change", function() {
                var selectedValue = $(this).val();

                $("#cboCuentaDestino_reg").select2();
                ListarCboCuentaDestino_reg();
            });


            $("#cboCuentaDestino_reg").on("change", function() {
                if ($("#txtEstado_reg").val() === "Nuevo") {
                    ObtenerSucursalDestino($('#cboCuentaDestino_reg').val());
                }
            });
        })

              
        function Listar() { 
            $.ajax({
                url: "controlador/contTransferenciaCuentas.php",
                type: "POST",
                data: {
                    "accion": "Listar",
                    "cboSucursal": $('#cboSucursal').val()
                },
                //async: true,
                success: function(data) {
                    var data = JSON.parse(data);
                    //console.log(data);
                    var $cuerpo = "";
                    if (data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            var fecha = data[i].fecha !== null ? data[i].fecha_moc : '';
                            var importe = data[i].importe_moc == 0 ? '' : Number(data[i].importe_moc).toLocaleString(undefined, { minimumFractionDigits: 2 });
                            
                            $cuerpo += "<tr>";
                            $cuerpo += "<td>" + fecha + "</td>"; 
                            $cuerpo += "<td>" + data[i].recibo_moc + "</td>";  
                            $cuerpo += "<td>" + data[i].ctaOrigen + "</td>";  
                            $cuerpo += "<td>" + data[i].ctaDestino + "</td>";  
                            $cuerpo += "<td>" + importe + "</td>";  
                            $cuerpo += "<td>" + data[i].detalle_moc + "</td>";  
                            $cuerpo += "<td style='font-size:10px; text-align:center;'>";
                            $cuerpo += "<button type='button' class='btn btn-info btn-sm btn-radius' onclick='Editar(" + data[i].codigo + ")' title='Editar'><i class='fas fa-edit small'></i></button>";
                            $cuerpo += " <button type='button' class='btn btn-danger btn-sm btn-radius' onclick='ConfirmarEliminar(" + data[i].codigo + ")' title='Eliminar'><i class='fa fa-trash-alt small'></i></button>";
                            $cuerpo += "</td>";
                            $cuerpo += "</tr>";                        
                        }
                    }
                    //console.log($cuerpo)
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
                        }]

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
                        $cuerpo += "<option value='0'> - SELECCIONE - </option>";
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

        function ListarCboCuentaOrigen_reg() { 
            $.ajax({
                url: "controlador/contCuenta.php",
                type: "POST",
                data: {
                    "accion": "Listar",
                    "accionBuscar":"B",
                    "codigo_suc": $('#cboSucursal_reg').val()                   
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
                    $("#cboCuentaOrigen_reg").html($cuerpo);
                    
                },
                error: function(result) {
                    console.log(result);
                }
            });
        }
       
        function ListarCboCuentaDestino_reg() { 
            $.ajax({
                url: "controlador/contCuenta.php",
                type: "POST",
                data: {
                    "accion": "ListadoCuentas",
                    "accionBuscar":"LT",
                    "codigo_cta": $("#cboCuentaOrigen_reg").val(),
                    "codigo_suc": 0           
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
                    $("#cboCuentaDestino_reg").html($cuerpo);
                    
                },
                error: function(result) {
                    console.log(result);
                }
            });
        }

        function ObtenerNroRecibo() { 
            $.ajax({
                url: "controlador/contTipoDocumento.php",
                type: "POST",
                data: {
                    "accion": "ObtenerNrotransferencia",  
                    "tipo": "I",
                    "codigo_suc": $('#cboSucursal_reg').val()
                },
                success: function(data) {
                    var data = JSON.parse(data);
                    if (data.length > 0) {
                        var selectedValue = data[0].recibo;
                        var input = document.getElementById('txtRecibo_reg');
                        input.value = selectedValue;
                    }
                    else{
                         var selectedValue = 0;
                         var input = document.getElementById('txtRecibo_reg');
                         input.value = "";                        
                    }
                },
                error: function(result) {
                    console.log(result);
                }
            });
        }

        function ObtenerSucursalDestino(id) { 
            $.ajax({
                url: "controlador/contCuenta.php",
                type: "POST",
                data: {
                    "accion": "ObtenerSucursalDestino",  
                    "codigo": id
                },
                success: function(data) {
                    var data = JSON.parse(data);
                    if (data.length > 0) {
                        document.getElementById('hdsucursalDestino').value = data[0].codigo_suc;
                        document.getElementById('txtSucursalDestino_reg').value = data[0].nombre_suc;
                    }
                    else{
                         var selectedValue = 0;
                         var input = document.getElementById('hdsucursalDestino');
                         input.value = "";                        
                    }
                },
                error: function(result) {
                    console.log(result);
                }
            });
        }

        function Guardar() {
            //alert($('#cboListaPersona').val());
            //loading(true);
            $("form#frmRegistro input[id=accion]").remove();
            $('#frmRegistro').append('<input type="hidden" id="accion" name="accion" value="Actualizar" />');
            var form = $("#frmRegistro").serializeArray();
            $("form#frmRegistro input[id=accion]").remove();
            $.ajax({
                url: "controlador/contTransferenciaCuentas.php",
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

        function cargarCombos(){
            $("#cboSucursal_reg").select2();
            ListarCboSucursal_reg();

            $("#cboCuentaOrigen_reg").select2();
            ListarCboCuentaOrigen_reg();
            
            $("#cboCuentaDestino_reg").select2();
            ListarCboCuentaDestino_reg();
            
        }
        
        function validar() {
            var titulo = 'Validación de ' + $("#identificador").val();
            
            if ($("#txtFecha_reg").val().trim() == "") {
                msgAlerta('error', 'Debe ingresar la fecha de la ' + $("#identificador").val(), titulo);
                $("#txtFecha_reg").focus();
                return false;
            }

            if ($("#cboSucursal_reg").val().trim() == 0) {
                msgAlerta('error', 'Debe seleccionar una sucursal de la' + $("#identificador").val(), titulo);
                $("#cboSucursal_reg").focus();
                return false;
            }

            if ($("#txtImporte").val().trim() == 0) {
                msgAlerta('error', 'Debe ingresar el importe', titulo);
                $("#txtImporte").focus();
                return false;
            }

            if ($("#cboCuentaOrigen_reg").val().trim() == 0) {
                msgAlerta('error', 'Debe seleccionar una cuenta origen de la ' + $("#identificador").val(), titulo);
                $("#cboCuentaOrigen_reg").focus();
                return false;
            }

            if ($("#cboCuentaDestino_reg").val().trim() == 0) {
                msgAlerta('error', 'Debe seleccionar una cuenta destino de la ' + $("#identificador").val(), titulo);
                $("#cboCuentaDestino_reg").focus();
                return false;
            }

            return true;

        }


        function Editar(id, tipo_mov, tabla) {
            //loading(true);
            $("#txtEstado_reg").val("Editar");
                 
            fnLimpiar();
            //$("#frmRegistro").addClass("was-validated");
            $.ajax({
                url: "controlador/contTransferenciaCuentas.php",
                type: "POST",
                async: false,
                //dataType: "json",
                data: {
                    "accion": "Editar",
                    "codigo": id,
                    "cboSucursal": $('#cboSucursal').val() 
                },
                success: function(data) {
                    console.log(data);
                    var data = JSON.parse(data);
                    $("#hdcod").val(data[0].codigo);
                    $("#txtRecibo_reg").val(data[0].recibo);
                    $("#txtFecha_reg").val(data[0].fecha);
                    $("#cboSucursal_reg").val(data[0].codigo_suc).change();

                    setTimeout(function() {
                        $("#cboCuentaOrigen_reg").val(data[0].ctaOrigen).trigger('change'); // Disparar evento change para select2
                    }, 100);
                    
                    setTimeout(function() {
                        $("#cboCuentaDestino_reg").val(data[0].ctaDestino).trigger('change'); // Disparar evento change para select2
                    }, 200);
                    
                    $("#txtImporte").val(data[0].importe);
                    $("#txtcodigoDestino_reg").val(data[0].codigoDestino);
                    $("#txtObservacion_reg").val(data[0].detalle);

                    $("#hdsucursalDestino").val(data[0].codigosuc_destino);
                    $("#txtSucursalDestino_reg").val(data[0].sucursaldestino);


                    // <input type="hidden" id="hdsucursalDestino" name="hdsucursalDestino" value="0">
                    // <input type="text" class="form-control form-control-sm" id="txtSucursalDestino_reg" name="txtSucursalDestino_reg"  maxlength="100" readonly/>

                    // "codigosuc_destino" => $row["codigosuc_destino"],
                    // "sucursaldestino" => $row["sucursaldestino"]

                    
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


        function Eliminar(codigo) {
            //alert(codigo +" - "+ tipo_mov +" - "+ tabla);

            //if (confirm("¿Esta seguro que desea eliminar el registro?")) {
            var titulo = 'Eliminar ' + $("#identificador").val();
            //loading(true);
            $.ajax({
                url: "controlador/contTransferenciaCuentas.php",
                type: "POST",
                //dataType: "json",
                data: {
                    "accion": "Eliminar",
                    "codigo": codigo                 
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
            $("#hdcod").val(0);
            $("#txtFecha_reg").val(new Date().toJSON().slice(0, 10));
            $("#txtRecibo_reg").val("");            
            $("#txtImporte").val("");
            $("#txtObservacion_reg").val("");       
            $("#cboSucursal_reg").val("0").change();
            $("#cboCuentaOrigen_reg").val("0").change();
            $("#cboCuentaDestino_reg").val("0").change();
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
                                    <label for="txtSucursal" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                    Sucursal Origen: </label>
                                    <div class="col-sm-4">
                                        <select class="cboSucursal form-control" style="width:450px" id="cboSucursal" name="cboSucursal"></select>
                                    </div>
                                </div>
                            </div>

                            <div class="card-body">
                                <div class="table-responsive" style="font-size: 11px;">
                                    <table id="tCXC" class="display compact order-column form-control-sm" style="width:98%;">
                                        <thead>
                                            <tr>                                               
                                                <th style="width: 10%; text-align:center;">Fecha</th>
                                                <th style="width: 10%; text-align:center;">Recibo</th>
                                                <th style="width: 20%; text-align:center;">Cuenta Origen</th>                                                
                                                <th style="width: 20%; text-align:right;">Cuenta Destino</th>
                                                <th style="width: 10%; text-align:right;">Importe</th>
                                                <th style="width: 20%; text-align:right;">Detalle</th>
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
                                                        <label for="txtRecibo" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Nro. Transferencia: </label>
                                                        <div class="col-sm-3">
                                                            <input type="hidden" id="hdcod" name="hdcod" value="0">
                                                            <input type="text" class="form-control form-control-sm" id="txtRecibo_reg" name="txtRecibo_reg"  maxlength="100" readonly/>
                                                        </div>

                                                        <label for="txtFecha" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                                            Fecha: </label>
                                                        <div class="col-sm-3">
                                                           <input type="date" class="form-control form-control-sm" id="txtFecha_reg" name="txtFecha_reg" maxlength="20" />
                                                        </div> 
                                                    </div>


                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="txtSucursal_reg" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                        Sucursal: </label>
                                                        <div class="col-sm-3">
                                                            <select class="cboSucursal_reg form-control" style="width:436px" id="cboSucursal_reg" name="cboSucursal_reg"></select>
                                                        </div>
                                                    </div>

                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="txtImporte" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Importe S/.: </label>
                                                        <div class="col-sm-3">
                                                           <input type="number" style="text-align:right" class="form-control form-control-sm" id="txtImporte" name="txtImporte" placeholder="0.00" maxlength="20" />
                                                        </div>
                                                        
                                                    </div>


                                                    <div class="form-group">
                                                        <hr> <!-- Línea horizontal -->
                                                        <div class="form-row mb-2">
                                                            <label for="lblCuentaOrigen_reg" class="col-sm-3 col-form-label-sm text-right">Cuenta Origen:</label>
                                                            <div class="col-sm-9">
                                                                <select class="cboCuentaOrigen_reg form-control" style="width:436px" id="cboCuentaOrigen_reg" name="cboCuentaOrigen_reg"></select>                                                                
                                                            </div>
                                                        </div>
                                                        <hr> <!-- Línea horizontal -->
                                                    </div>

                                                    
                                                    <div class="form-group">
                                                        <div class="form-row mb-2">
                                                            <label for="txtCuentaDestino_reg" class="col-sm-3 col-form-label-sm text-right">Cuenta Destino:</label>
                                                            <div class="col-sm-9">
                                                                <select class="cboCuentaDestino_reg form-control" style="width:436px" id="cboCuentaDestino_reg" name="cboCuentaDestino_reg"></select>
                                                            </div>

                                                            <div class="col-sm-3">
                                                                <input type="hidden" id="txtcodigoDestino_reg" name="txtcodigoDestino_reg" value="0"/>
                                                            </div> 
                                                        </div>
                                                    </div>

                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="lblSucursalDestino" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Sucursal Destino: </label>
                                                        <div class="col-sm-8">
                                                            <input type="hidden" id="hdsucursalDestino" name="hdsucursalDestino" value="0">
                                                            <input type="text" class="form-control form-control-sm" id="txtSucursalDestino_reg" name="txtSucursalDestino_reg"  maxlength="100" readonly/>
                                                        </div>
                                                        <hr> <!-- Línea horizontal -->
                                                    </div>

                                                  
                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="txtObservacion" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Observación: </label>
                                                        <div class="col-sm-8">
                                                           <textarea class="form-control form-control-sm" id="txtObservacion_reg" name="txtObservacion_reg" maxlength="500"></textarea>
                                                        </div>

                                                        <div class="col-sm-3">
                                                           <input type="hidden" id="txtEstado_reg" name="txtEstado_reg" value="0" />
                                                        </div>
                                                    </div>
                                                   

                                                    <div class="form-row mb-2 form-control-sm">
                                                        <!-- <label for="txtObservacion" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                             </label> -->
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
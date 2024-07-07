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
            $("#cboCliente").val();
            $('#cboSucursal').val();

            $("#mdRegistro").hide();

            $("#tituloLista").text("Listado de Amortización de Clientes");
            $("#tituloMantenimiento").text("Gestión de Amortización de Clientes");
            $("#identificador").val(" Amortización de Clientes");

            
            //$('#txtEstado_reg').val()=="Nuevo";


            var fechaActual = new Date();
            var fechaFormato = fechaActual.toISOString().slice(0, 10);

            ObtenerTipoCambio(fechaFormato);
           
            $("#cboCliente").select2();
            ListarCboCliente();

            $("#cboSucursal").select2();
            ListarCboSucursal();

            cargarCombos();
            Listar();

            $("#btnConsultar").click(function() {
                Listar();               
            })


            $("#btnNuevo").click(function() {
                fnLimpiar();
                fnHabilitarControles("Nuevo");


                $("#Lista").hide();
                $("#mdRegistro").show();          
                $("#txtNombre").focus();
            })

            $("#btnGuardar").click(function() {
                ConfirmarGuardar();     
            });

            $("#btnCancelar").click(function() {
                //loading(true);
                $("#Lista").show();
                $("#mdRegistro").hide();
            });

            $("#cboSucursal_reg").change(function() {
                var selectedValue = $(this).val();
                $("#cboCuenta_reg").select2();
                ListarCboCuenta_reg();

                if ($("#txtEstado_reg").val() === "Nuevo") {
                    ObtenerNroRecibo();                    
                }
            });

            $("#cboCuenta_reg").change(function() {
                if ($("#txtEstado_reg").val() === "Nuevo") {
                    ObtenerNroRecibo();
                    ObtenerDatosCuenta();
                }
            });

        })

       
        function Listar() { 
            $.ajax({
                url: "controlador/contAmortizacionCliente.php",
                type: "POST",
                data: {
                    "accion": "Listar",
                    "cboTipo": $("#cboTipo").val(),
                    "txtFecha_ini": $('#txtFecha_ini').val(),
                    "txtFecha_fin": $('#txtFecha_fin').val(),
                    "cboCliente": $("#cboCliente").val(),
                    "cboSucursal": $('#cboSucursal').val()
                },
                success: function(data) {
                    var data = JSON.parse(data);
                    var $cuerpo = "";
                    if (data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            $cuerpo += "<tr>";
                            $cuerpo += "<td align='center'>" + (i + 1) + "</td>";
                            $cuerpo += "<td>" + data[i].fecha_moc + "</td>"; 
                            $cuerpo += "<td>" + data[i].documento + "</td>";  
                            $cuerpo += "<td>" + data[i].nombre_cli + "</td>";  
                            $cuerpo += "<td align='center'>" + data[i].moneda + "</td>";  
                            $cuerpo += "<td align='right'>" + data[i].importe_moc + "</td>";  
                            $cuerpo += "<td align='right'>" + data[i].pago_moc + "</td>";  
                            $cuerpo += "<td align='right'>" + data[i].saldo_moc + "</td>";  
                            $cuerpo += "<td style='font-size:10px; text-align:center;'>";

                            if (data[i].tipo === 'C' && parseFloat(data[i].saldo_moc) > 0) {
                                $cuerpo += "<button type='button' class='btn btn-success btn-sm btn-radius' onclick='EditarDeuda(" + data[i].codigo + ")' title='Nuevo' ><i class='fas fa-edit small'></i></button>";
                            }

                            if (data[i].tipo == 'P') {
                                $cuerpo += "<button type='button' class='btn btn-info btn-sm btn-radius' onclick='EditarPago(" + data[i].codigo + ")' title='Editar' ><i class='fas fa-edit small'></i></button>";
                                $cuerpo += " <button type='button' class='btn btn-danger btn-sm btn-radius' onclick='ConfirmarEliminar(" + data[i].codigo + ")' title='Eliminar'><i class='fa fa-trash-alt small'></i></button>";
                            }
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

        //Listado de los Filtros
        function ListarCboCliente() { 
            $.ajax({
                url: "controlador/contCliente.php",
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
                    $("#cboCliente").html($cuerpo);
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

        function ListarcboTipo_reg() { 
            var $cuerpo = "";
            $cuerpo += "<option value='D'> DEUDA </option>";
            $cuerpo += "<option value='P'> PAGOS </option>";
            $cuerpo += "<option value='T'> DEUDA/PAGOS </option>";
            $("#cboTipo").html($cuerpo);
        }

        
        //Listado de los registros
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

        function ListarCboCuenta_reg() { 
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
                    $("#cboCuenta_reg").html($cuerpo);
                },
                error: function(result) {
                    console.log(result);
                }
            });
        }

        
        function Guardar() {
            $("form#frmRegistro input[id=accion]").remove();
            $('#frmRegistro').append('<input type="hidden" id="accion" name="accion" value="Actualizar" />');
            var form = $("#frmRegistro").serializeArray();
            $("form#frmRegistro input[id=accion]").remove();
            $.ajax({
                url: "controlador/contAmortizacionCliente.php",
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

            $("#cboCuenta_reg").select2();
            ListarCboCuenta_reg();

            $("#cboTipo").select2();
            ListarcboTipo_reg();
        }

        function fnHabilitarControles(as_flag) {
            if (as_flag === "Nuevo") {
                $("#txtEstado_reg").val("Nuevo");
                //$("#cboTipoMovimiento").prop("disabled", false);
                //$("#cboSucursal_reg").prop("disabled", false);
                //$("#cboCuenta_reg").prop("disabled", false);
                //$("#cboListaPersona").prop("disabled", false);
            } else {
                $("#txtEstado_reg").val("Editar");
                //$("#cboTipoMovimiento").prop("disabled", true);
                //$("#cboSucursal_reg").prop("disabled", true);
                //$("#cboCuenta_reg").prop("disabled", true);
                //$("#cboListaPersona").prop("disabled", true);
            }
        }
        
        function ObtenerNroRecibo() { 
            $.ajax({
                url: "controlador/contCuenta.php",
                type: "POST",
                data: {
                    "accion": "ObtenerNroRecibo",  
                    "tipo": "I",
                    "codigo_cta": $('#cboCuenta_reg').val()
                },
                success: function(data) {
                    var data = JSON.parse(data);
                    if (data.length > 0) {
                        var selectedValue = data[0].recibo;
                        var input = document.getElementById('txtRecibo_reg');
                        input.value = selectedValue;
                    }else{
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

        function ObtenerTipoCambio(fecha) { 
            $.ajax({
                url: "controlador/contTipoCambio.php",
                type: "POST",
                data: {
                    "accion": "ObtenerTipoCambio",  
                    "tipo": "V",
                    "fecha": fecha
                },
                success: function(data) {
                    var data = JSON.parse(data);
                    if (data.length > 0) {
                        var selectedValue = data[0].tipocambio;
                        var input = document.getElementById('txtDolar_reg');
                        input.value = selectedValue;
                    }else{
                         var selectedValue = 0;
                         var input = document.getElementById('txtDolar_reg');
                         input.value = "";                        
                    }
                },
                error: function(result) {
                    console.log(result);
                }
            });
        }

        function ObtenerDatosCuenta() { 
            $.ajax({
                url: "controlador/contCuenta.php",
                type: "POST",
                data: {
                    "accion": "ObtenerDatosCuenta",  
                    "tipo": "LBM",
                    "codigo": $('#cboCuenta_reg').val()
                },
                success: function(data) {
                    var data = JSON.parse(data);
                    if (data.length > 0) {
                        document.getElementById('txtMoneda_reg').value = data[0].nombre_mon;
                        document.getElementById('txtBanco_reg').value = data[0].nombre_ban;
                    }else{
                         document.getElementById('txtMoneda_reg').value = "";
                         document.getElementById('txtBanco_reg').value = "";
                    }
                },
                error: function(result) {
                    console.log(result);
                }
            });
        }


        function validar() {
            var titulo = 'Validación de ' + $("#identificador").val();

            if ($("#txtfecha_moc").val().trim() == "") {
                msgAlerta('error', 'Debe ingresar la fecha del ' + $("#identificador").val(), titulo);
                $("#txtfecha_moc").focus();
                return false;
            }

            if ($("#cboSucursal_reg").val().trim() == 0) {
                msgAlerta('error', 'Debe seleccionar una sucursal del ' + $("#identificador").val(), titulo);
                $("#cboSucursal_reg").focus();
                return false;
            }

            if ($("#cboCuenta_reg").val().trim() == 0) {
                msgAlerta('error', 'Debe seleccionar una cuenta del ' + $("#identificador").val(), titulo);
                $("#cboCuenta_reg").focus();
                return false;
            }

            if ($("#txtCodigo_mon").val().trim() == "") {
                msgAlerta('error', 'Ingrese una moneda para el ' + $("#identificador").val(), titulo);
                $("#txtCodigo_mon").focus();
                return false;
            }

            // if ($("#txtCodigo_ban").val().trim() == "") {
            //     msgAlerta('error', 'Ingrese un banco para el ' + $("#identificador").val(), titulo);
            //     $("#txtCodigo_ban").focus();
            //     return false;
            // }

            if ($("#txtRecibo_reg").val().trim() == "") {
                msgAlerta('error', 'Ingrese un recibo para el ' + $("#identificador").val(), titulo);
                $("#txtRecibo_reg").focus();
                return false;
            }

            if ($("#txtDolar_reg").val().trim() == "") {
                msgAlerta('error', 'Ingrese el tipo de cambio para el ' + $("#identificador").val(), titulo);
                $("#txtDolar_reg").focus();
                return false;
            }

            if ($("#txtCodigo_cli").val().trim() == "") {
                msgAlerta('error', 'Ingrese un cliente para el ' + $("#identificador").val(), titulo);
                $("#txtCodigo_cli").focus();
                return false;
            }

            if ($("#txtImporte_moc").val().trim() == "") {
                msgAlerta('error', 'Ingrese un importe para el ' + $("#identificador").val(), titulo);
                $("#txtImporte_moc").focus();
                return false;
            }

         
            return true;
        }


        function EditarDeuda(id) {
            fnLimpiar();
            fnHabilitarControles("Nuevo");

            $.ajax({
                url: "controlador/contAmortizacionCliente.php",
                type: "POST",
                async: false,
                //dataType: "json",
                data: {
                    "accion": "EditarDeuda",
                    "codigo": id
                },
                success: function(data) {
                    //console.log(data);
                    var data = JSON.parse(data);
                    
                    //$("#hdcod").val(data[0].codigo);
                    $("#hdcod").val("0");
                    $("#hdreferencia").val(data[0].codigo);
                    $("#hdcodigo_tdo").val(data[0].codigo_tdo);
                    $("#hdnumero_ser").val(data[0].serie_moc);
                    $("#hdnumero_doc").val(data[0].numero_moc);

                    var fechaActual = new Date();
                    var fechaFormato = fechaActual.toISOString().slice(0, 10);
                    $("#txtfecha_moc").val(fechaFormato);
                    
                    $("#cboSucursal_reg").val(data[0].codigo_suc).change();
                    $("#txtCodigo_mon").val(data[0].codigo_mon);
                    $("#txtCodigo_ban").val(data[0].codigo_ban);
                    $("#txtCodigo_cli").val(data[0].codigo_cli);
                    $("#txtCliente").val(data[0].cliente);
                    $("#txtDeuda_moc").val(data[0].importe_moc);
                    $("#txtSaldo_moc").val(data[0].saldo_moc);

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

        function EditarPago(id) {
            //msgAlerta('error', 'Ingrese una fecha para el ' , 'titulo');
            fnLimpiar();
            fnHabilitarControles("Editar");
            
            $.ajax({
                url: "controlador/contAmortizacionCliente.php",
                type: "POST",
                async: false,
                //dataType: "json",
                data: {
                    "accion": "EditarPago",
                    "codigo": id
                },
                success: function(data) {
                    console.log(data);
                    var data = JSON.parse(data);
                    
                    $("#hdcod").val(data[0].codigo);
                    $("#txtfecha_moc").val(data[0].fecha_moc);
                    $("#cboSucursal_reg").val(data[0].codigo_suc).change();
                    
                    setTimeout(function() {
                        $("#cboCuenta_reg").val(data[0].codigo_cta).trigger('change'); // Disparar evento change para select2
                    }, 300);

                    $("#txtCodigo_mon").val(data[0].codigo_mon);
                    $("#txtMoneda_reg").val(data[0].moneda);
                    $("#txtCodigo_ban").val(data[0].codigo_ban);
                    $("#txtBanco_reg").val(data[0].banco);
                    $("#txtRecibo_reg").val(data[0].recibo_moc);

                    $("#txtDolar_reg").val(data[0].dolar_moc);
                    $("#txtCodigo_cli").val(data[0].codigo_cli);
                    $("#txtCliente").val(data[0].cliente);
                    
                    $("#txtDeuda_moc").val(data[0].importe_ref);
                    $("#txtSaldo_moc").val(data[0].saldo_ref);
                    $("#txtImporte_moc").val(data[0].importe_moc);

                    $("#txtObservacion_moc").val(data[0].detalle_moc);
                    // //$("#txtObservacion_moc").val(data[0].codigo_ven);                   
                    $("#hdcodigo_tdo").val(data[0].codigo_tdo);
                    $("#hdnumero_ser").val(data[0].serie_moc);
                    $("#hdnumero_doc").val(data[0].numero_moc);                  
                    $("#hdreferencia").val(data[0].referencia_moc);

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
                url: "controlador/contAmortizacionCliente.php",
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
            $("#hdreferencia").val("0");
            $("#hdcodigo_tdo").val("0");
            $("#hdnumero_ser").val("0");
            $("#hdnumero_doc").val("0");
            $("#txtfecha_moc").val("");
            $("#cboSucursal_reg").val("0").change();
            $("#txtRecibo_reg").val("");  
            $("#cboCuenta_reg").val("0").change();
            $("#txtCodigo_mon").val("");
            $("#txtMoneda").val("");
            $("#txtCodigo_ban").val("");
            $("#txtNombre_ban").val("");
            $("#txtRecibo_reg").val("");
            //$("#txtDolar_reg").val("0");
            $("#txtCodigo_cli").val("");
            $("#txtCliente").val("");
            $("#txtImporte_moc").val("0");
            $("#txtObservacion_moc").val("");
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
                                    <label for="lblFecha_ini" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                       Fecha Incial: </label>
                                    <div class="col-sm-2 col-md-2">
                                        <input type="date" class="form-control form-control-sm" id="txtFecha_ini" name="txtFecha_ini" maxlength="10"  />
                                    </div>
                                
                                    <label for="lblFecha_fin" class="col-sm-1 col-form-label-sm" style="text-align:right" >
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
                                    <label for="lblCliente" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                        Cliente: </label>
                                    <div class="col-sm-4">
                                        <select class="cboCliente form-control" style="width:460px" id="cboCliente" name="cboCliente"></select>
                                    </div>
                                </div>

                                <div class="form-row mb-12">
                                    <label for="lblSucursal" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                        Sucursal: </label>
                                    <div class="col-sm-4">
                                        <select class="cboSucursal form-control" style="width:460px" id="cboSucursal" name="cboSucursal"></select>
                                    </div>
                                </div>

                                <div class="form-row mb-12">
                                    <label for="lblTipo" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                        Tipo: </label>
                                    <div class="col-sm-4">
                                        <select class="cboTipo form-control" style="width:200px" id="cboTipo" name="cboTipo"></select>
                                    </div>
                                </div>
                            </div>

                            <!--- <div class="card-body pL-2 pr-2">-->
                            <div class="card-body">
                                <div class="table-responsive" style="font-size: 11px;">
                                    <table id="tCXC" class="display compact order-column form-control-sm" style="width:98%;">
                                        <thead>
                                            <tr>
                                                <th style="width: 5%; text-align:center;">N°</th>
                                                <th style="width: 8%; text-align:center;">Fecha</th>
                                                <th style="width: 8%; text-align:center;">Tipo de Documento</th>
                                                <th style="width: 33%; text-align:center;">Cliente</th>
                                                <th style="width: 6%; text-align:center;">Moneda</th>
                                                <th style="width: 10%; text-align:right;">Deuda</th>
                                                <th style="width: 10%; text-align:right;">Pagos</th>
                                                <th style="width: 10%; text-align:right;">Saldo</th>
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
                                                        <label for="txtfecha_moc" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Fecha: </label>
                                                        <div class="col-sm-3">
                                                            <input type="hidden" id="hdcod" name="hdcod" value="0">
                                                            <input type="hidden" id="hdreferencia" name="hdreferencia" value="0">
                                                            <input type="hidden" id="hdcodigo_tdo" name="hdcodigo_tdo" value="0">
                                                            <input type="hidden" id="hdnumero_ser" name="hdnumero_ser" value="0">
                                                            <input type="hidden" id="hdnumero_doc" name="hdnumero_doc" value="0">
                                                                
                                                           <input type="date" class="form-control form-control-sm" id="txtfecha_moc" name="txtfecha_moc" maxlength="20" />
                                                        </div>
                                                    </div>


                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="lblSucursal_reg" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                        Sucursal: </label>
                                                        <div class="col-sm-3">
                                                            <select class="cboSucursal_reg form-control" style="width:436px" id="cboSucursal_reg" name="cboSucursal_reg"></select>
                                                        </div>
                                                    </div>

                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="lblCuenta_reg" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                        Cuenta: </label>
                                                        <div class="col-sm-3">
                                                            <select class="cboCuenta_reg form-control" style="width:436px" id="cboCuenta_reg" name="cboCuenta_reg"></select>
                                                        </div>
                                                    </div>

                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="lblMoneda_reg" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Moneda: </label>
                                                        <div class="col-sm-3">
                                                            <input type="hidden" id="txtCodigo_mon" name="txtCodigo_mon" value="0">
                                                            <input type="text" style="text-align:center" class="form-control form-control-sm" id="txtMoneda_reg" name="txtMoneda_reg" maxlength="20" />
                                                        </div>
                                                        <label for="lblbanco_reg" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                                            Banco: </label>
                                                        <div class="col-sm-3">
                                                            <input type="hidden" id="txtCodigo_ban" name="txtCodigo_ban" value="0">
                                                            <input type="text" style="text-align:center" class="form-control form-control-sm" id="txtBanco_reg" name="txtBanco_reg" maxlength="20" />
                                                        </div>
                                                    </div>

                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="lblrecibo_reg" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Recibo: </label>
                                                        <div class="col-sm-3">
                                                            <input type="text" style="text-align:center" class="form-control form-control-sm" id="txtRecibo_reg" name="txtRecibo_reg" maxlength="20" />
                                                        </div>
                                                        <label for="lblDolar_reg" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                                            T. cambio: </label>
                                                        <div class="col-sm-3">
                                                                <input type="text" style="text-align:center" class="form-control form-control-sm" id="txtDolar_reg" name="txtDolar_reg" maxlength="20" />
                                                        </div>
                                                    </div>


                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="lblCliente_reg" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Cliente: </label>
                                                        <div class="col-sm-8">
                                                            <input type="hidden" id="txtCodigo_cli" name="txtCodigo_cli" value="0">
                                                            <input type="text" style="text-align:left" class="form-control form-control-sm" id="txtCliente" name="txtCliente" maxlength="20" />
                                                        </div>

                                                    </div>

                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="lblDeuda_moc" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Deuda: </label>
                                                        <div class="col-sm-3">
                                                            <input type="number" style="text-align:right; font-weight: bold;" class="form-control form-control-sm" id="txtDeuda_moc" name="txtDeuda_moc" placeholder="0.00" maxlength="20" />
                                                        </div>
                                                        
                                                        <label for="lblSaldo_moc" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                                            Saldo: </label>
                                                        <div class="col-sm-3">
                                                           <input type="number" style="text-align:right; font-weight: bold;" class="form-control form-control-sm" id="txtSaldo_moc" name="txtSaldo_moc" placeholder="0.00" maxlength="20" />
                                                        </div>

                                                    </div>


                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="txtImporte_moc" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Importe S/.: </label>
                                                        <div class="col-sm-3">
                                                           <input type="number" style="text-align:right" class="form-control form-control-sm" id="txtImporte_moc" name="txtImporte_moc" placeholder="0.00" maxlength="20" />
                                                        </div>
                                                    </div>



                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="txtObservacion_moc" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Observación: </label>
                                                        <div class="col-sm-8">
                                                           <input type="text" class="form-control form-control-sm" id="txtObservacion_moc" name="txtObservacion_moc" maxlength="500" />
                                                        </div>

                                                        <div class="col-sm-3">
                                                           <input type="hidden" id="txtEstado_reg" name="txtEstado_reg" value="0" />
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
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
            $("#tituloLista").text("Reporte de Movimiento de Ingresos y Egresos");
            $("#tituloMantenimiento").text("Gestión de Movimientos de caja y bancos");
            $("#identificador").val("Reporte de Movimiento de Ingresos y Egresos");

            Listar();
            
            //Filtros del Listado
            $("#cboSucursal").select2();
            ListarCboSucursal();

            $("#cboCuenta").select2();
            ListarCboCuenta();
           
            cargarCombos();

            $("#btnNuevo").click(function() {
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



            // Adjuntar controlador de eventos change al combo
            $("#cboSucursal").change(function() {
                var selectedValue = $(this).val();
                $("#cboCuenta").select2();
                ListarCboCuenta();
            });

            $("#cboSucursal_reg").change(function() {
                var selectedValue = $(this).val();
                $("#cboCuenta_reg").select2();
                ListarCboCuenta_reg();

                ObtenerNroRecibo();
            });

            $("#cboTipoMovimiento").change(function() {
                ObtenerNroRecibo();
            });

            //Obtener Nro recibo
            $("#cboCuenta_reg").change(function() {
                //alert(selectedValue);
                ObtenerNroRecibo();                
            });


            // Adjuntar controlador de eventos change al combo
            $("#cboListaPersona").change(function() {
                // Obtener el valor seleccionado del combo
                var selectedValue = $(this).val();

                // Ejecutar la acción según el valor seleccionado
                switch (selectedValue) {
                    case "1":
                        fnOcultarDiv('MostrarCliente');
                        break;
                    case "2":
                        fnOcultarDiv('MostrarProveedor');
                        break;
                    default:
                        fnOcultarDiv('OcultarTodo');
                        break;
                }
            });

        })

        function fnOcultarDiv(tipo) { 
            // Obtener el elemento div por su clase
            var divCliente = document.getElementById('DivCliente_reg');
            var divProveedor = document.getElementById('DivProveedor_reg');

            // Verificar el valor del parámetro
            switch(tipo) {
                case 'OcultarTodo':
                    divCliente.style.visibility = 'hidden';
                    divProveedor.style.visibility = 'hidden';
                    break;
                case 'MostrarCliente':
                    divCliente.style.visibility = 'visible';
                    divProveedor.style.visibility = 'hidden';
                    break;
                case 'MostrarProveedor':
                    divCliente.style.visibility = 'hidden';
                    divProveedor.style.visibility = 'visible';
                    break;                
            }
        }    


       
        function Listar() { 
            $.ajax({
                url: "controlador/contMovimientoIngresoEgreso.php",
                type: "POST",
                data: {
                    "accion": "Listar",
                    "txtFecha_ini": $('#txtFecha_ini').val(),
                    "txtFecha_fin": $('#txtFecha_fin').val(),
                    "cboCuenta": $('#cboCuenta').val(),
                    "cboSucursal": $('#cboSucursal').val()
                },
                //async: true,
                success: function(data) {
                    var data = JSON.parse(data);
                    //console.log(data);
                    var $cuerpo = "";
                    if (data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            var fecha = data[i].fecha !== null ? data[i].fecha : '';
                            var persona = data[i].persona !== null ? data[i].persona : '';
                            var ingreso = data[i].ingreso == 0 ? '' : Number(data[i].ingreso).toLocaleString(undefined, { minimumFractionDigits: 2 });
                            var salida = data[i].salida == 0 ? '' : Number(data[i].salida).toLocaleString(undefined, { minimumFractionDigits: 2 });
                            var saldo = data[i].saldo == 0 ? '' : Number(data[i].saldo).toLocaleString(undefined, { minimumFractionDigits: 2 });

                            $cuerpo += "<tr>";
                            $cuerpo += "<td>" + fecha + "</td>"; 
                            $cuerpo += "<td>" + data[i].documento + "</td>";  
                            $cuerpo += "<td>" + persona + "</td>";  
                            $cuerpo += "<td>" + ingreso + "</td>";  
                            $cuerpo += "<td>" + salida + "</td>";  
                            $cuerpo += "<td>" + saldo + "</td>";  
                            $cuerpo += "<td>" + data[i].referencia + "</td>";  
                            // $cuerpo += "<td style='font-size:10px; text-align:center;'>";
                            //$cuerpo += "<button type='button' class='btn btn-info btn-sm btn-radius' onclick='Editar(" + data[i].codigo + ", \"" + data[i].tipo_mov + "\", \"" + data[i].tabla + "\")' title='Editar'><i class='fas fa-edit small'></i></button>";
                            //$cuerpo += " <button type='button' class='btn btn-danger btn-sm btn-radius' onclick='ConfirmarEliminar(" + data[i].codigo + ", \"" + data[i].tipo_mov + "\", \"" + data[i].tabla + "\")' title='Eliminar'><i class='fa fa-trash-alt small'></i></button>";
                            // $cuerpo += "</td>";
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


        function ListarCboCuenta() { 
            $.ajax({
                url: "controlador/contCuenta.php",
                type: "POST",
                data: {
                    "accion": "Listar",  
                    "accionBuscar": "B",  
                    "codigo_suc": $('#cboSucursal').val() 
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
                    $("#cboCuenta").html($cuerpo);
                },
                error: function(result) {
                    console.log(result);
                }
            });
        }


        function ListarCboIngresoEgreso() { 
            $.ajax({
                url: "controlador/contTipoMovimiento.php",
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
                             $cuerpo += "<option value='" + data[i].codigo + "'>" + data[i].nombre_tmo + "</option>";                     
                        }
                    }
                    $("#cboTipoMovimiento").html($cuerpo);
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

        function ListarCboCuenta_Mod() { 
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

        function ListarCboConcepto_reg() { 
            $.ajax({
                url: "controlador/contConcepto.php",
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
                    $("#cboConcepto_reg").html($cuerpo);
                    
                },
                error: function(result) {
                    console.log(result);
                }
            });
        }


        function ListarcboListaPersona() { 
            var $cuerpo = "";
            $cuerpo += "<option value='0'> NINGUNO </option>";
            $cuerpo += "<option value='1'> CLIENTE </option>";
            $cuerpo += "<option value='2'> PROVEEDOR </option>";
            $("#cboListaPersona").html($cuerpo);

            // // Datos obtenidos dinámicamente del servidor
            // var data = [
            //     { value: 0, text: "NINGUNO" },
            //     { value: 1, text: "CLIENTE" },
            //     { value: 2, text: "PROVEEDOR" }
            //     // Puedes agregar más elementos aquí si es necesario
            // ];

            // // Construir las opciones del combo
            // var $cuerpo = "";
            // for (var i = 0; i < data.length; i++) {
            //     $cuerpo += "<option value='" + data[i].value + "'>" + data[i].text + "</option>";
            // }

            // // Agregar las opciones al combo
            // $("#cboPersona").html($cuerpo);
        }


        function ListarCboCliente_reg() { 
            $.ajax({
                url: "controlador/contCliente.php",
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
                    $("#cboCliente_reg").html($cuerpo);
                    
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
                        $cuerpo += "<option value='0'> - SELECCIONE - </option>";
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


        function ObtenerNroRecibo() { 
            $.ajax({
                url: "controlador/contCuenta.php",
                type: "POST",
                data: {
                    "accion": "ObtenerNroRecibo",  
                    "tipo": $('#cboTipoMovimiento').val(),
                    "codigo_cta": $('#cboCuenta_reg').val()
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


        function Guardar() {
            //alert($('#cboListaPersona').val());
            //loading(true);
            $("form#frmRegistro input[id=accion]").remove();
            $('#frmRegistro').append('<input type="hidden" id="accion" name="accion" value="Actualizar" />');
            var form = $("#frmRegistro").serializeArray();
            $("form#frmRegistro input[id=accion]").remove();
            $.ajax({
                url: "controlador/contMovimientoIngresoEgreso.php",
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

        function cargarCombos(){
            fnOcultarDiv('OcultarTodo');

            //Objetos del Registro
            $("#cboTipoMovimiento").select2();
            ListarCboIngresoEgreso();

            $("#cboSucursal_reg").select2();
            ListarCboSucursal_reg();

            $("#cboCuenta_reg").select2();
            ListarCboCuenta_reg();

            $("#cboConcepto_reg").select2();
            ListarCboConcepto_reg();

            $("#cboListaPersona").select2();
            ListarcboListaPersona();

            $("#cboCliente_reg").select2();
            ListarCboCliente_reg();

            $("#cboProveedor_reg").select2();
            ListarCboProveedor_reg();

        }
        
        function validar() {
            var titulo = 'Validación de ' + $("#identificador").val();

            // if ($("#txtfecha_moc").val().trim() == "") {
            //     $("#txtfecha_moc").focus();
            //     return false;
            // }

            // if ($("#txtCodigo_suc").val().trim() == "") {
            //     $("#txtCodigo_suc").focus();
            //     return false;
            // }
            // if ($("#txtCodigo_cli").val().trim() == "") {
            //     $("#txtCodigo_cli").focus();
            //     return false;
            // }
            // if ($("#txtCodigo_tdo").val().trim() == "") {
            //     $("#txtCodigo_tdo").focus();
            //     return false;
            // }
          
            // if ($("#txtSerie_moc").val().trim() == "") {
            //     $("#txtSerie_moc").focus();
            //     return false;
            // }
            // if ($("#txtNumero_moc").val().trim() == "") {
            //     $("#txtNumero_moc").focus();
            //     return false;
            // }
            // if ($("#txtCodigo_mon").val().trim() == "") {
            //     $("#txtCodigo_mon").focus();
            //     return false;
            // }
            // if ($("#txtImporte_moc").val().trim() == "") {
            //     $("#txtImporte_moc").focus();
            //     return false;
            // }
            // if ($("#txtFechaVencimiento_moc").val().trim() == "") {
            //     $("#txtFechaVencimiento_moc").focus();
            //     return false;
            // }
            
            // /*
            // if (!confirm('¿Está seguro que desea eliminar la sucursal?')) {
            //     return false;
            // }*/

            return true;

            //Confirmar('¿Está seguro que desea eliminar el registro?', 'Luego no podra visualizarlo', 'Guardar()');
        }


        function Editar(id, tipo_mov, tabla) {
            //loading(true);
            fnLimpiar();
            //$("#frmRegistro").addClass("was-validated");
            $.ajax({
                url: "controlador/contMovimientoIngresoEgreso.php",
                type: "POST",
                async: false,
                //dataType: "json",
                data: {
                    "accion": "Editar",
                    "codigo": id,
                    "tipo_mov": tipo_mov,
                    "tabla": tabla                    
                },
                success: function(data) {
                    console.log(data);
                    var data = JSON.parse(data);
                    $("#hdcod").val(data[0].codigo);
                    $("#cboTipoMovimiento").val(data[0].tipo).change();
                    $("#txtFecha_reg").val(data[0].fecha);
                    $("#cboSucursal_reg").val(data[0].codigo_suc).change();
                    
                    $("#cboCuenta_reg").val(data[0].codigo_cta).change();
                    $("#txtRecibo_reg").val(data[0].recibo);

                    $("#txtRecibo_Mod").val(data[0].recibo);
                    $("#txtcodigoCta_Mod").val(data[0].codigo_cta);

                 

                    $("#cboConcepto_reg").val(data[0].codigo_con).change();
                    $("#txtImporte").val(data[0].importe);
                    $("#txtObservacion_reg").val(data[0].detalle);

                    $("#cboListaPersona").val(data[0].direccionadoa).change();
                    $("#cboCliente_reg").val(data[0].persona).change();
                    //$("#cboProveedor_reg").val(data[0].fechaVencimiento_moc);
                   
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


        function ConfirmarEliminar(id, tipo_mov, tabla) {
            Confirmar('question', '¿Está seguro que desea eliminar el registro?', 'Luego no podrá visualizarlo', 'Eliminar("' + id + '","' + tipo_mov + '","' + tabla + '")');            
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


        function Eliminar(codigo, tipo_mov, tabla) {
            //alert(codigo +" - "+ tipo_mov +" - "+ tabla);

            //if (confirm("¿Esta seguro que desea eliminar el registro?")) {
            var titulo = 'Eliminar ' + $("#identificador").val();
            //loading(true);
            $.ajax({
                url: "controlador/contMovimientoIngresoEgreso.php",
                type: "POST",
                //dataType: "json",
                data: {
                    "accion": "Eliminar",
                    "codigo": codigo,
                    "tabla": tabla                    
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
                    //console.log(result);
                    alerta('error', $("#identificador").val() + ' no pudo ser eliminada.', titulo);
                }
            });
            //}
        }

        function fnLimpiar() {
            $("#hdcod").val(0);
            $("#txtFecha_reg").val(new Date().toJSON().slice(0, 10));
            // // $("#txtSucursal").val("");
            $("#txtRecibo_reg").val("");            
            // $("#txtCliente").val("");
            $("#txtImporte").val("");
            $("#txtObservacion_reg").val("");

            // cboTipoMovimiento
            // //txtFecha_reg
            // cboSucursal_reg
            // cboCuenta_reg
            // //txtRecibo_reg
            // cboConcepto_reg
            // //txtImporte
            // //txtObservacion_reg
            // cboListaPersona
            // cboCliente_reg
            // cboProveedor_reg

        }
		
		



        
        // function ListarSucursal() {
        //     ////loading(true);
        //     $.ajax({
        //         url: "controlador/contSucursal.php",
        //         type: "POST",
        //         data: {
        //             "accion": "Listar"
        //         },
        //         //async: true,
        //         success: function(data) {
        //             // you will get response from your php page (what you echo or print)
        //             var data = JSON.parse(data);
        //             //console.log("error");
        //             //console.log(data);
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
        //             //console.log($cuerpo)
        //             $("#tListadoSucursal").DataTable().destroy();
        //             $("#tbListadoSucursal").html($cuerpo);
        //             $("#tListadoSucursal").DataTable({
        //                 "processing": true,
        //                 'dom': 'Blfrtip',
        //                 'buttons': [
        //                     /*'copy',*/
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
        //             //loading(false);
        //         },
        //         error: function(result) {
        //             console.log(result);
        //         }
        //     });
        // }

        // function EditarSucursal(id) {
        //     //console.log(id);
        //     //loading(true);
        //     //fnLimpiar();
        //     //$("#frmRegistro").addClass("was-validated");
        //     $.ajax({
        //         url: "controlador/contSucursal.php",
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
        //             $("#txtCodigo_suc").val(data[0].codigo);
        //             $("#txtSucursal").val(data[0].nombre);
                    
        //             $("#mdRegistro").show();
        //             $("#mdListarSucursal").hide();
        //         },
        //         error: function(result) {
        //             //console.log("problemas");
        //             console.log(result);
        //         }
        //     });

        // }




        // function ListarCliente() {
        //     ////loading(true);
        //     $.ajax({
        //         url: "controlador/contCliente.php",
        //         type: "POST",
        //         data: {
        //             "accion": "Listar"
        //         },
        //         //async: true,
        //         success: function(data) {
        //             // you will get response from your php page (what you echo or print)
        //             var data = JSON.parse(data);
        //             //console.log("error");
        //             //console.log(data);
        //             var $cuerpo = "";
        //             if (data.length > 0) {
        //                 for (var i = 0; i < data.length; i++) {
        //                     $cuerpo += "<tr>";
        //                     $cuerpo += "<td align='center'>" + (i + 1) + "</td>";
        //                     $cuerpo += "<td>" + data[i].nombre + "</td>"; 
        //                     $cuerpo += "<td>" + data[i].direccion_cli + "</td>";  
        //                     $cuerpo += "<td>" + data[i].nombre_tip + "</td>";  
        //                     $cuerpo += "<td>" + data[i].nombre_doc + "</td>";  
        //                     $cuerpo += "<td>" + data[i].numero_doc + "</td>"; 
        //                     $cuerpo += "<td style='font-size:10px; text-align:center;'>";
        //                     $cuerpo += "<button type='button' class='btn btn-info btn-sm btn-radius' onclick='EditarCliente(" + data[i].codigo + ")' title='Editar' >  <i class='fas fa-check small'></i> </i></button>";
        //                     $cuerpo += "</td>";
        //                     $cuerpo += "</tr>";                        
        //                 }
        //             }
        //             //console.log($cuerpo)
        //             $("#tListadoCliente").DataTable().destroy();
        //             $("#tbListadoCliente").html($cuerpo);
        //             $("#tListadoCliente").DataTable({
        //                 "processing": true,
        //                 'dom': 'Blfrtip',
        //                 'buttons': [
        //                     /*'copy',*/
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
        //             //loading(false);
        //         },
        //         error: function(result) {
        //             console.log(result);
        //         }
        //     });
        // }

        // function EditarCliente(id) {
        //     //console.log(id);
        //     //loading(true);
        //     //fnLimpiar();
        //     //$("#frmRegistro").addClass("was-validated");
        //     $.ajax({
        //         url: "controlador/contCliente.php",
        //         type: "POST",
        //         async: false,
        //         //dataType: "json",
        //         data: {
        //             "accion": "Editar",
        //             "codigo": id
        //         },
        //         success: function(data) {
        //             var data = JSON.parse(data);
        //             $("#txtCodigo_cli").val(data[0].codigo);
        //             $("#txtCliente").val(data[0].nombre);
                    
        //             $("#mdRegistro").show();
        //             $("#mdListarCliente").hide();
        //         },
        //         error: function(result) {
        //             //console.log("problemas");
        //             console.log(result);
        //         }
        //     });

        // }




        // function ListarTipoDocumento() {
        //     ////loading(true);
        //     $.ajax({
        //         url: "controlador/contTipoDocumento.php",
        //         type: "POST",
        //         data: {
        //             "accion": "Listar"
        //         },
        //         //async: true,
        //         success: function(data) {
        //             // you will get response from your php page (what you echo or print)
        //             var data = JSON.parse(data);
        //             //console.log("error");
        //             //console.log(data);
        //             var $cuerpo = "";
        //             if (data.length > 0) {
        //                 for (var i = 0; i < data.length; i++) {
        //                     $cuerpo += "<tr>";
        //                     $cuerpo += "<td align='center'>" + (i + 1) + "</td>";
        //                     $cuerpo += "<td>" + data[i].nombre + "</td>";
        //                     $cuerpo += "<td>" + data[i].abreviatura + "</td>";
        //                     $cuerpo += "<td style='font-size:10px; text-align:center;'>";
        //                     $cuerpo += "<button type='button' class='btn btn-info btn-sm btn-radius' onclick='EditarTipoDocumento(" + data[i].codigo + ")' title='Editar' >  <i class='fas fa-check small'></i> </i></button>";
        //                     $cuerpo += "</td>";
        //                     $cuerpo += "</tr>";                        
        //                 }
        //             }
        //             //console.log($cuerpo)
        //             $("#tListadoTipoDocumento").DataTable().destroy();
        //             $("#tbListadoTipoDocumento").html($cuerpo);
        //             $("#tListadoTipoDocumento").DataTable({
        //                 "processing": true,
        //                 'dom': 'Blfrtip',
        //                 'buttons': [
        //                     /*'copy',*/
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
        //             //loading(false);
        //         },
        //         error: function(result) {
        //             console.log(result);
        //         }
        //     });
        // }

        // function EditarTipoDocumento(id) {
        //     //console.log(id);
        //     //loading(true);
        //     //fnLimpiar();
        //     //$("#frmRegistro").addClass("was-validated");
        //     $.ajax({
        //         url: "controlador/contTipoDocumento.php",
        //         type: "POST",
        //         async: false,
        //         //dataType: "json",
        //         data: {
        //             "accion": "Editar",
        //             "codigo": id
        //         },
        //         success: function(data) {
        //             var data = JSON.parse(data);
        //             $("#txtCodigo_tdo").val(data[0].codigo);
        //             $("#txtTipoDocumento").val(data[0].nombre);
                    
        //             $("#mdRegistro").show();
        //             $("#mdListarTipoDocumento").hide();
        //         },
        //         error: function(result) {
        //             //console.log("problemas");
        //             console.log(result);
        //         }
        //     });

        // }


        // function ListarMoneda() {
        //     ////loading(true);
        //     $.ajax({
        //         url: "controlador/contMoneda.php",
        //         type: "POST",
        //         data: {
        //             "accion": "Listar"
        //         },
        //         //async: true,
        //         success: function(data) {
        //             // you will get response from your php page (what you echo or print)
        //             var data = JSON.parse(data);
        //             //console.log("error");
        //             //console.log(data);
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
        //             //console.log($cuerpo)
        //             $("#tListadoMoneda").DataTable().destroy();
        //             $("#tbListadoMoneda").html($cuerpo);
        //             $("#tListadoMoneda").DataTable({
        //                 "processing": true,
        //                 'dom': 'Blfrtip',
        //                 'buttons': [
        //                     /*'copy',*/
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
        //             //loading(false);
        //         },
        //         error: function(result) {
        //             console.log(result);
        //         }
        //     });
        // }

        // function EditarMoneda(id) {
        //     //console.log(id);
        //     //loading(true);
        //     //fnLimpiar();
        //     //$("#frmRegistro").addClass("was-validated");
        //     $.ajax({
        //         url: "controlador/contMoneda.php",
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
        //             $("#txtCodigo_mon").val(data[0].codigo);
        //             $("#txtMoneda").val(data[0].nombre);
                    
        //             $("#mdRegistro").show();
        //             $("#mdListarMoneda").hide();
        //         },
        //         error: function(result) {
        //             //console.log("problemas");
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
                                    Sucursal: </label>
                                    <div class="col-sm-4">
                                        <select class="cboSucursal form-control" style="width:450px" id="cboSucursal" name="cboSucursal"></select>
                                    </div>
                                </div>

                                <div class="form-row mb-12">
                                    <label for="txtCuenta" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                    Cuenta: </label>
                                    <div class="col-sm-4">
                                        <select class="cboCuenta form-control" style="width:450px" id="cboCuenta" name="cboCuenta"></select>
                                    </div>
                                </div>

                            </div>



                            <!--- <div class="card-body pL-2 pr-2">-->
                            <div class="card-body">
                                <div class="table-responsive" style="font-size: 11px;">
                                    <table id="tCXC" class="display compact order-column form-control-sm" style="width:98%;">
                                        <thead>
                                            <tr>                                               
                                                <th style="width: 8%; text-align:center;">Fecha</th>
                                                <th style="width: 6%; text-align:center;">Documento</th>
                                                <th style="width: 33%; text-align:center;">Persona</th>                                                
                                                <th style="width: 8%; text-align:right;">Ingreso</th>
                                                <th style="width: 8%; text-align:right;">Egreso</th>
                                                <th style="width: 8%; text-align:right;">Saldo</th>
                                                <th style="width: 21%; text-align:center;">Referencia</th>
                                                <!-- <th style="width: 8%; text-align:center;">Acción</th> -->
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
                                                        <label for="txtMovimiento" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                        Movimiento: </label>
                                                        <div class="col-sm-3">
                                                            <input type="hidden" id="hdcod" name="hdcod" value="0">
                                                            <select class="cboTipoMovimiento form-control" style="width:150px" id="cboTipoMovimiento" name="cboTipoMovimiento"></select>
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
                                                        <label for="txtCuenta_reg" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                        Cuenta: </label>
                                                        <div class="col-sm-3">
                                                            <select class="cboCuenta_reg form-control" style="width:436px" id="cboCuenta_reg" name="cboCuenta_reg"></select>
                                                        </div>
                                                    </div>

                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="txtRecibo" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                        Nro. Recibo: </label>
                                                        <div class="col-sm-3">
                                                            <input type="text" class="form-control form-control-sm" id="txtRecibo_reg" name="txtRecibo_reg"  maxlength="100" readonly/>
                                                        </div>

                                                        <div class="col-sm-3">
                                                            <input type="text" class="form-control form-control-sm" id="txtRecibo_Mod" name="txtRecibo_Mod"  maxlength="100" readonly/>
                                                        </div>

                                                        <div class="col-sm-3">
                                                            <input type="text" class="form-control form-control-sm" id="txtcodigoCta_Mod" name="txtcodigoCta_Mod"  maxlength="100" readonly/>
                                                        </div>

                                                    </div>

                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="txtConcepto_reg" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                        Concepto: </label>
                                                        <div class="col-sm-3">
                                                            <select class="cboConcepto_reg form-control" style="width:436px" id="cboConcepto_reg" name="cboConcepto_reg"></select>
                                                        </div>
                                                    </div>

                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="txtImporte" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Importe S/.: </label>
                                                        <div class="col-sm-3">
                                                           <input type="number" style="text-align:right" class="form-control form-control-sm" id="txtImporte" name="txtImporte" placeholder="0.00" maxlength="20" />
                                                        </div>                                           

                                                    </div>
                                                  
                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="txtObservacion" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Observación: </label>
                                                        <div class="col-sm-8">
                                                           <input type="text" class="form-control form-control-sm" id="txtObservacion_reg" name="txtObservacion_reg" maxlength="500" />
                                                           <!-- <textarea class="form-control form-control-sm" id="txtObservacion_reg" name="txtObservacion_reg" maxlength="500"></textarea> -->
                                                        </div>
                                                    </div>

                                                    <!-- <div class="form-row mb-2 form-control-sm">
                                                        <label for="txtMovimiento" class="col-sm-3 col-form-label-sm" style="text-align:right" ></label>
                                                    </div> -->
                                                    <hr> <!-- Línea horizontal -->
                                                    <div class="form-row mb-2 form-control-sm">
                                                        
                                                        <label for="txtMovimiento" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                        Direccionar a: </label>
                                                        <div class="col-sm-3">
                                                            <select class="cboListaPersona form-control" style="width:150px" id="cboListaPersona" name="cboListaPersona"></select>
                                                        </div>
                                                    </div>

                                                    <div class="form-row mb-2 form-control-sm" id="DivCliente_reg">
                                                        <label for="txtCliente_reg" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                        Cliente: </label>
                                                        <div class="col-sm-3">
                                                            <select class="cboCliente_reg form-control" style="width:436px" id="cboCliente_reg" name="cboCliente_reg"></select>
                                                        </div>                                                       
                                                    </div>

                                                    <div class="form-row mb-2 form-control-sm" id="DivProveedor_reg">
                                                        <label for="txtProveedor_reg" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                        Proveedor: </label>
                                                        
                                                        <div class="col-sm-3">
                                                            <select class="cboProveedor_reg form-control" style="width:436px" id="cboProveedor_reg" name="cboProveedor_reg"></select>
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
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
            $('#cboProveedor').val();
            $('#cboSucursal').val();


            $("#mdRegistro").hide();
            $("#mdListarSucursal").hide();
            $("#mdListarProveedor").hide();
            $("#mdListarTipoDocumento").hide();            
            $("#mdListarMoneda").hide();

            $("#tituloLista").text("Listado de Deudas Anteriores");
            $("#tituloMantenimiento").text("Gestión de  Deudas Anteriores");
            $("#identificador").val(" Deuda Anterior");

            Listar();
            
            $("#cboProveedor").select2();
            ListarCboProveedor();

            $("#cboSucursal").select2();
            ListarCboSucursal();


            $("#btnConsultar").click(function() {
                Listar();
            })


            $("#btnNuevo").click(function() {
                fnLimpiar();
                $("#Lista").hide();
                $("#mdRegistro").show();                
                $("#mdListarSucursal").hide();
                $("#mdListarTipoProveedor").hide();
                $("#mdListarDocumento").hide();
                $("#mdListarMoneda").hide();
                
                $("#txtNombre").focus();
            })

            $("#btnGuardar").click(function() {
                ConfirmarGuardar();     
            });

            $("#btnCancelar").click(function() {
                //loading(true);

                $("#Lista").show();
                $("#mdRegistro").hide();
                $("#mdListarSucursal").hide();
                $("#mdListarProveedor").hide();
                $("#mdListarTipoDocumento").hide();
                $("#mdListarMoneda").hide();
                // //Listar();
                // //loading(false);
            });


            //Sucursal
            $("#btnBuscarSucursal").click(function() {
                $("#Lista").hide();
                $("#mdRegistro").hide();
                $("#mdListarSucursal").show();
              
               ListarSucursal();
            });

            
            $("#btnCancelarSucursal").click(function() {
                $("#Lista").hide();
                $("#mdRegistro").show();
                $("#mdListarSucursal").hide();
            });


            //Proveedor
            $("#btnBuscarProveedor").click(function() {
                $("#Lista").hide();
                $("#mdRegistro").hide();
                $("#mdListarProveedor").show();
              
               ListarProveedor();
            });

            
            $("#btnCancelarProveedor").click(function() {
                $("#Lista").hide();
                $("#mdRegistro").show();
                $("#mdListarProveedor").hide();
            });


           // Documento
            $("#btnBuscarTipoDocumento").click(function() {
                $("#Lista").hide();
                $("#mdRegistro").hide();
                $("#mdListarTipoPersona").hide();
                $("#mdListarTipoDocumento").show();

               ListarTipoDocumento();
            });

            
            $("#btnCancelarTipoDocumento").click(function() {
                $("#Lista").hide();
                $("#mdRegistro").show();
                $("#mdListarTipoPersona").hide();
                $("#mdListarTipoDocumento").hide();
                //$("#txtNombre").focus();
            });


            //Moneda
            $("#btnBuscarMoneda").click(function() {
                $("#Lista").hide();
                $("#mdRegistro").hide();
                $("#mdListarMoneda").show();

                ListarMoneda();
            });

            
            $("#btnCancelarMoneda").click(function() {
                $("#Lista").hide();
                $("#mdRegistro").show();
                $("#mdListarMoneda").hide();
                
            });

            //loading(false);
        })

       
        function Listar() {          
            $.ajax({
                url: "controlador/contCuentasxPagar.php",
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
                            $cuerpo += "<td>" + data[i].fecha_mop + "</td>"; 
                            $cuerpo += "<td>" + data[i].documento + "</td>";  
                            $cuerpo += "<td>" + data[i].nombre_pro + "</td>";  
                            $cuerpo += "<td>" + data[i].moneda + "</td>";  
                            $cuerpo += "<td>" + data[i].importe_mop + "</td>";  
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


        function Guardar() {
            //loading(true);
            $("form#frmRegistro input[id=accion]").remove();
            $('#frmRegistro').append('<input type="hidden" id="accion" name="accion" value="Actualizar" />');
            var form = $("#frmRegistro").serializeArray();
            $("form#frmRegistro input[id=accion]").remove();
            $.ajax({
                url: "controlador/contCuentasxPagar.php",
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

        
        function validar() {
            var titulo = 'Validación de ' + $("#identificador").val();

            if ($("#txtfecha_mop").val().trim() == "") {
                $("#txtfecha_mop").focus();
                return false;
            }

            if ($("#txtCodigo_suc").val().trim() == "") {
                $("#txtCodigo_suc").focus();
                return false;
            }
            if ($("#txtCodigo_pro").val().trim() == "") {
                $("#txtCodigo_pro").focus();
                return false;
            }
            if ($("#txtCodigo_tdo").val().trim() == "") {
                $("#txtCodigo_tdo").focus();
                return false;
            }
          
            if ($("#txtSerie_mop").val().trim() == "") {
                $("#txtSerie_mop").focus();
                return false;
            }
            if ($("#txtNumero_mop").val().trim() == "") {
                $("#txtNumero_mop").focus();
                return false;
            }
            if ($("#txtCodigo_mon").val().trim() == "") {
                $("#txtCodigo_mon").focus();
                return false;
            }
            if ($("#txtImporte_mop").val().trim() == "") {
                $("#txtImporte_mop").focus();
                return false;
            }
            if ($("#txtFechaVencimiento_mop").val().trim() == "") {
                $("#txtFechaVencimiento_mop").focus();
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
                url: "controlador/contCuentasxPagar.php",
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
                    $("#txtCodigo_suc").val(data[0].codigo_suc);
                    $("#txtSucursal").val(data[0].sucursal);
                    $("#txtCodigo_tdo").val(data[0].codigo_tdo);
                    $("#txtTipoDocumento").val(data[0].documento);
                    $("#txtSerie_mop").val(data[0].serie_mop);
                    $("#txtNumero_mop").val(data[0].numero_mop);
                    $("#txtCodigo_pro").val(data[0].codigo_pro);
                    $("#txtProveedor").val(data[0].proveedor);
                    $("#txtfecha_mop").val(data[0].fecha_mop);
                    $("#txtImporte_mop").val(data[0].importe_mop);
                    $("#txtFechaVencimiento_mop").val(data[0].fechaVencimiento_mop);
                    $("#txtCodigo_mon").val(data[0].codigo_mon);
                    $("#txtMoneda").val(data[0].moneda);
                    $("#txtObservacion_mop").val(data[0].detalle_mop);
                   


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
                url: "controlador/contCuentasxPagar.php",
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
                        alerta('error', data[0].msj, titulo);
                    } else {
                        alerta('success', data[0].msj, titulo);
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
            $("#hdcod").val("0");
            //$("#txtfecha_mop").val("");
            $('#txtfecha_mop').val(new Date().toJSON().slice(0, 10));
            $("#txtCodigo_suc").val("");
            $("#txtSucursal").val("");
            $("#txtCodigo_pro").val("");            
            $("#txtProveedor").val("");
            $("#txtCodigo_tdo").val("");
            $("#txtTipoDocumento").val("");
            $("#txtSerie_mop").val("");
            $("#txtNumero_mop").val("");
            $("#txtCodigo_mon").val("");
            $("#txtMoneda").val("");
            $("#txtImporte_mop").val("");
            //$("#txtFechaVencimiento_mop").val("");
            $('#txtFechaVencimiento_mop').val(new Date().toJSON().slice(0, 10));
            $("#txtObservacion_mop").val("");
        }


        
        function ListarSucursal() {
            ////loading(true);
            $.ajax({
                url: "controlador/contSucursal.php",
                type: "POST",
                data: {
                    "accion": "Listar"
                },
                //async: true,
                success: function(data) {
                    // you will get response from your php page (what you echo or print)
                    var data = JSON.parse(data);
                    //console.log("error");
                    //console.log(data);
                    var $cuerpo = "";
                    if (data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            $cuerpo += "<tr>";
                            $cuerpo += "<td align='center'>" + (i + 1) + "</td>";
                            $cuerpo += "<td>" + data[i].nombre + "</td>";
                            $cuerpo += "<td style='font-size:10px; text-align:center;'>";
                            $cuerpo += "<button type='button' class='btn btn-info btn-sm btn-radius' onclick='EditarSucursal(" + data[i].codigo + ")' title='Editar' >  <i class='fas fa-check small'></i> </i></button>";
                            $cuerpo += "</td>";
                            $cuerpo += "</tr>";                        
                        }
                    }
                    //console.log($cuerpo)
                    $("#tListadoSucursal").DataTable().destroy();
                    $("#tbListadoSucursal").html($cuerpo);
                    $("#tListadoSucursal").DataTable({
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

        function EditarSucursal(id) {
            //console.log(id);
            //loading(true);
            //fnLimpiar();
            //$("#frmRegistro").addClass("was-validated");
            $.ajax({
                url: "controlador/contSucursal.php",
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
                    $("#txtCodigo_suc").val(data[0].codigo);
                    $("#txtSucursal").val(data[0].nombre);
                    
                    $("#mdRegistro").show();
                    $("#mdListarSucursal").hide();
                },
                error: function(result) {
                    //console.log("problemas");
                    console.log(result);
                }
            });

        }




        function ListarProveedor() {
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
                    //console.log("error");
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
                            $cuerpo += "<button type='button' class='btn btn-info btn-sm btn-radius' onclick='EditarProveedor(" + data[i].codigo + ")' title='Editar' >  <i class='fas fa-check small'></i> </i></button>";
                            $cuerpo += "</td>";
                            $cuerpo += "</tr>";                        
                        }
                    }
                    //console.log($cuerpo)
                    $("#tListadoProveedor").DataTable().destroy();
                    $("#tbListadoProveedor").html($cuerpo);
                    $("#tListadoProveedor").DataTable({
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

        function EditarProveedor(id) {
            //console.log(id);
            //loading(true);
            //fnLimpiar();
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
                    var data = JSON.parse(data);
                    $("#txtCodigo_pro").val(data[0].codigo);
                    $("#txtProveedor").val(data[0].nombre);
                    
                    $("#mdRegistro").show();
                    $("#mdListarProveedor").hide();
                },
                error: function(result) {
                    //console.log("problemas");
                    console.log(result);
                }
            });

        }




        function ListarTipoDocumento() {
            ////loading(true);
            $.ajax({
                url: "controlador/contTipoDocumento.php",
                type: "POST",
                data: {
                    "accion": "Listar",
                    "accionBuscar":"B",
                    "tipo":"P",                    
                },
                //async: true,
                success: function(data) {
                    // you will get response from your php page (what you echo or print)
                    var data = JSON.parse(data);
                    //console.log("error");
                    //console.log(data);
                    var $cuerpo = "";
                    if (data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            $cuerpo += "<tr>";
                            $cuerpo += "<td align='center'>" + (i + 1) + "</td>";
                            $cuerpo += "<td>" + data[i].nombre + "</td>";
                            $cuerpo += "<td>" + data[i].abreviatura + "</td>";
                            $cuerpo += "<td style='font-size:10px; text-align:center;'>";
                            $cuerpo += "<button type='button' class='btn btn-info btn-sm btn-radius' onclick='EditarTipoDocumento(" + data[i].codigo + ")' title='Editar' >  <i class='fas fa-check small'></i> </i></button>";
                            $cuerpo += "</td>";
                            $cuerpo += "</tr>";                        
                        }
                    }
                    //console.log($cuerpo)
                    $("#tListadoTipoDocumento").DataTable().destroy();
                    $("#tbListadoTipoDocumento").html($cuerpo);
                    $("#tListadoTipoDocumento").DataTable({
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

        function EditarTipoDocumento(id) {
            //console.log(id);
            //loading(true);
            //fnLimpiar();
            //$("#frmRegistro").addClass("was-validated");
            $.ajax({
                url: "controlador/contTipoDocumento.php",
                type: "POST",
                async: false,
                //dataType: "json",
                data: {
                    "accion": "Editar",
                    "codigo": id
                },
                success: function(data) {
                    var data = JSON.parse(data);
                    $("#txtCodigo_tdo").val(data[0].codigo);
                    $("#txtTipoDocumento").val(data[0].nombre);
                    
                    $("#mdRegistro").show();
                    $("#mdListarTipoDocumento").hide();
                },
                error: function(result) {
                    //console.log("problemas");
                    console.log(result);
                }
            });

        }


        function ListarMoneda() {
            ////loading(true);
            $.ajax({
                url: "controlador/contMoneda.php",
                type: "POST",
                data: {
                    "accion": "Listar"
                },
                //async: true,
                success: function(data) {
                    // you will get response from your php page (what you echo or print)
                    var data = JSON.parse(data);
                    //console.log("error");
                    //console.log(data);
                    var $cuerpo = "";
                    if (data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            $cuerpo += "<tr>";
                            $cuerpo += "<td align='center'>" + (i + 1) + "</td>";
                            $cuerpo += "<td>" + data[i].nombre + "</td>";
                            $cuerpo += "<td>" + data[i].abreviatura_mon + "</td>";
                            $cuerpo += "<td style='font-size:10px; text-align:center;'>";
                            $cuerpo += "<button type='button' class='btn btn-info btn-sm btn-radius' onclick='EditarMoneda(" + data[i].codigo + ")' title='Editar' >  <i class='fas fa-check small'></i> </i></button>";
                            $cuerpo += "</td>";
                            $cuerpo += "</tr>";                        
                        }
                    }
                    //console.log($cuerpo)
                    $("#tListadoMoneda").DataTable().destroy();
                    $("#tbListadoMoneda").html($cuerpo);
                    $("#tListadoMoneda").DataTable({
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

        function EditarMoneda(id) {
            //console.log(id);
            //loading(true);
            //fnLimpiar();
            //$("#frmRegistro").addClass("was-validated");
            $.ajax({
                url: "controlador/contMoneda.php",
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
                    $("#txtCodigo_mon").val(data[0].codigo);
                    $("#txtMoneda").val(data[0].nombre);
                    
                    $("#mdRegistro").show();
                    $("#mdListarMoneda").hide();
                },
                error: function(result) {
                    //console.log("problemas");
                    console.log(result);
                }
            });

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
                                                    Fecha
                                                </th>
                                                <th style="width: 10%; text-align:center;">
                                                    Tipo de Documento
                                                </th>
                                                <th style="width: 43%; text-align:center;">
                                                    Proveedor
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
                                                        <label for="txtfecha_mop" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Fecha: </label>
                                                        <div class="col-sm-3">
                                                            <input type="hidden" id="hdcod" name="hdcod" value="0">
                                                           <input type="date" class="form-control form-control-sm" id="txtfecha_mop" name="txtfecha_mop" maxlength="20" />
                                                        </div>
                                                    </div>


                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="txtSucursal" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Sucursal: </label>

                                                        <div class="col-sm-1">
                                                            <input type="hidden" id="txtCodigo_suc" name="txtCodigo_suc" value="0">
                                                            <button type="button" id="btnBuscarSucursal" class="btn btn-sm btn-outline-success" >
                                                                <i class="fas fa-search-plus"></i></button>
                                                        </div>
                                                        <div class="col-sm-7">
                                                            <input type="text" class="form-control form-control-sm" id="txtSucursal" name="txtSucursal"  maxlength="100" readonly />
                                                        </div>
                                                    </div>


                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="txtProveedor" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Proveedor: </label>
                                                        
                                                        <div class="col-sm-1">
                                                            <input type="hidden" id="txtCodigo_pro" name="txtCodigo_pro" value="0">
                                                            <button type="button" id="btnBuscarProveedor" class="btn  btn-sm btn-outline-success">
                                                                <i class="fas fa-search-plus"></i></button>
                                                        </div>
                                                        <div class="col-sm-7">
                                                            <input type="text" class="form-control form-control-sm" id="txtProveedor" name="txtProveedor"  maxlength="100" readonly />
                                                        </div>
                                                    </div>


                                                    <div class="form-row mb-2 form-control-sm" >
                                                        <label for="txtTipoDocumento" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                        Tipo de Documento: </label>
                                                        
                                                        <div class="col-sm-1">
                                                            <input type="hidden" id="txtCodigo_tdo" name="txtCodigo_tdo" value="0">
                                                            <button type="button" id="btnBuscarTipoDocumento" class="btn  btn-sm btn-outline-success">
                                                                <i class="fas fa-search-plus"></i></button>
                                                        </div>
                                                        <div class="col-sm-7">
                                                            <input type="text" class="form-control form-control-sm" id="txtTipoDocumento" name="txtTipoDocumento"  maxlength="100" readonly />
                                                        </div>
                                                    </div>


                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="txtSerie" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Serie: </label>
                                                        <div class="col-sm-3">
                                                           <input type="text" style="text-align:center" class="form-control form-control-sm" id="txtSerie_mop" name="txtSerie_mop" maxlength="20" />
                                                        </div>

                                                        <label for="txtNumero" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                                            Número: </label>
                                                        <div class="col-sm-3">
                                                           <input type="text" style="text-align:center" class="form-control form-control-sm" id="txtNumero_mop" name="txtNumero_mop" maxlength="20" />
                                                        </div>                                                       
                                                    </div>

                                                    
                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="txtMoneda" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                        Moneda: </label>
                                                        
                                                        <div class="col-sm-1">
                                                            <input type="hidden" id="txtCodigo_mon" name="txtCodigo_mon" value="0">
                                                            <button type="button" id="btnBuscarMoneda" class="btn  btn-sm btn-outline-success">
                                                                <i class="fas fa-search-plus"></i></button>
                                                        </div>
                                                        <div class="col-sm-7">
                                                            <input type="text" class="form-control form-control-sm" id="txtMoneda" name="txtMoneda"  maxlength="100" readonly />
                                                        </div>
                                                    </div>
                                                    


                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="txtImporte_mop" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Importe S/.: </label>
                                                        <div class="col-sm-3">
                                                           <input type="number" style="text-align:right" class="form-control form-control-sm" id="txtImporte_mop" name="txtImporte_mop" placeholder="0.00" maxlength="20" />
                                                        </div>

                                                        <label for="txtFechaVencimiento_mop" class="col-sm-2 col-form-label-sm" style="text-align:right" >
                                                            F. Vencimiento: </label>
                                                        <div class="col-sm-3">
                                                           <input type="date" class="form-control form-control-sm" id="txtFechaVencimiento_mop" name="txtFechaVencimiento_mop" maxlength="20" />
                                                        </div>   
                                                    </div>



                                                    <div class="form-row mb-2 form-control-sm">
                                                        <label for="txtObservacion_mop" class="col-sm-3 col-form-label-sm" style="text-align:right" >
                                                            Observación: </label>
                                                        <div class="col-sm-8">
                                                           <input type="text" class="form-control form-control-sm" id="txtObservacion_mop" name="txtObservacion_mop" maxlength="500" />
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

                <div class="row" id="mdListarSucursal">
                    <div class="container">
                        <div class="row justify-content-center">
                        
                            <div class="col-xl-8 col-md-8 col-lg-8">
                                <div class="card shadow">
                                    <!-- Card Header - Dropdown -->
                                    <!-- <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                        <h6 class="card-title text-primary font-weight-bold" id="tituloMantenimiento"></h6>
                                        <input type="hidden" id="identificador" name="identificador" value="">
                                    </div> -->
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-sm-12 col-md-12">
                                                <form id="frmListadoSucursal">
                                                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                                        <div class="col-sm-8 text-left"  >
                                                            <h5 class="m-0" id="tituloLista">Listado de Sucursales</h5>
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
                </div>


                <div class="row" id="mdListarProveedor">
                    <div class="container">
                        <div class="row justify-content-center">
                        
                            <div class="col-xl-12 col-md-12 col-lg-12">
                                <div class="card shadow">
                                    <!-- Card Header - Dropdown -->
                                    <!-- <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                        <h6 class="card-title text-primary font-weight-bold" id="tituloMantenimiento"></h6>
                                        <input type="hidden" id="identificador" name="identificador" value="">
                                    </div> -->
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-sm-12 col-md-12">
                                                <form id="frmListadoProveedor">
                                                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                                        <div class="col-sm-8 text-left" >
                                                            <h5 class="m-0" id="tituloLista">Listado de Proveedores</h5>
                                                        </div>
                                                        <div class="col-sm-4 text-right">
                                                            <!-- <button type="button" id="btnNuevaLinea" class="btn btn-sm btn-primary btn-radius">
                                                                <i class="fas fa-plus-square"></i><span>&nbsp;Nuevo</span></button> -->

                                                            <button type="button" id="btnCancelarProveedor" class="btn btn-sm btn-danger btn-radius">
                                                                <i class="fa fa-times-circle"></i>&nbsp;Cancelar</button>
                                                        </div>
                                                    </div>



                                                    <div class="card-body">
                                                        <div class="table-responsive" style="font-size: 11px;">
                                                            <table id="tListadoProveedor" class="display compact order-column form-control-sm" style="width:98%;">
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
                                                                <tbody id="tbListadoProveedor">
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
                </div>
                
                <div class="row" id="mdListarTipoDocumento">
                    <div class="container">
                        <div class="row justify-content-center">
                        
                            <div class="col-xl-8 col-md-8 col-lg-8">
                                <div class="card shadow">
                                    <!-- Card Header - Dropdown -->
                                    <!-- <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                        <h6 class="card-title text-primary font-weight-bold" id="tituloMantenimiento"></h6>
                                        <input type="hidden" id="identificador" name="identificador" value="">
                                    </div> -->
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-sm-12 col-md-12">
                                                <form id="frmListadoTipoDocumento">
                                                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                                        <div class="col-sm-8 text-left">
                                                            <h5 class="m-0" id="tituloLista">Listado de Tipo de Documentos</h5>
                                                        </div>
                                                        <div class="col-sm-4 text-right">
                                                            <!-- <button type="button" id="btnNuevaLinea" class="btn btn-sm btn-primary btn-radius">
                                                                <i class="fas fa-plus-square"></i><span>&nbsp;Nuevo</span></button> -->

                                                            <button type="button" id="btnCancelarTipoDocumento" class="btn btn-sm btn-danger btn-radius">
                                                                <i class="fa fa-times-circle"></i>&nbsp;Cancelar</button>
                                                        </div>
                                                    </div>



                                                    <div class="card-body">
                                                        <div class="table-responsive" style="font-size: 11px;">
                                                            <table id="tListadoTipoDocumento" class="display compact order-column form-control-sm" style="width:98%;">
                                                                <thead>
                                                                    <tr>
                                                                        <th style="width: 5%; text-align:center;">
                                                                            N°
                                                                        </th>
                                                                        <th style="width: 53%; text-align:center;">
                                                                            Nombre
                                                                        </th>
                                                                        <th style="width: 30%; text-align:center;">
                                                                            Abreviatura
                                                                        </th>
                                                                        <th style="width: 10%; text-align:center;">
                                                                            Acción
                                                                        </th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody id="tbListadoTipoDocumento">
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
                </div>

                <div class="row" id="mdListarMoneda">
                    <div class="container">
                        <div class="row justify-content-center">
                        
                            <div class="col-xl-8 col-md-8 col-lg-8">
                                <div class="card shadow">
                                    <!-- Card Header - Dropdown -->
                                    <!-- <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                        <h6 class="card-title text-primary font-weight-bold" id="tituloMantenimiento"></h6>
                                        <input type="hidden" id="identificador" name="identificador" value="">
                                    </div> -->
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-sm-12 col-md-12">
                                                <form id="frmListadoMoneda">
                                                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                                        <div class="col-sm-8 text-left">
                                                            <h5 class="m-0" id="tituloLista">Listado de Monedas</h5>
                                                        </div>
                                                        <div class="col-sm-4 text-right">
                                                            <!-- <button type="button" id="btnNuevaLinea" class="btn btn-sm btn-primary btn-radius">
                                                                <i class="fas fa-plus-square"></i><span>&nbsp;Nuevo</span></button> -->

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
                </div>

                




                



                
                

            </div>
            <!-- /.container-fluid -->
        </section>
        <!-- /.content -->
    </div>
</body>
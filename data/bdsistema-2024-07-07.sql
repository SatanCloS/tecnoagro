-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 07-07-2024 a las 23:08:54
-- Versión del servidor: 8.0.17
-- Versión de PHP: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bdsistema`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarArticulo` (IN `codigo` INT, IN `nombre_art` VARCHAR(500), IN `abreviatura_art` VARCHAR(100), IN `codigobarra_art` VARCHAR(100), IN `codigoproveedor_art` VARCHAR(100), IN `codigo_mar` INT, IN `codigo_lin` INT, IN `unidadm_art` VARCHAR(10), IN `tipoimpuesto_art` VARCHAR(1), IN `precio_art` DECIMAL(12,4), IN `preciomayorista_art` DECIMAL(12,4), IN `stockmin_art` INT, IN `stockmax_art` INT, IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
		IF codigo = 0 THEN
			INSERT INTO articulo(nombre_art, abreviatura_art, codigobarra_art, codigoproveedor_art, codigo_lin, codigo_mar, unidadm_art, 
						precio_art, preciomayorista_art, tipoimpuesto_art, stockmin_art, stockmax_art, estado_art, usuario_reg) 
				VALUES (nombre_art, abreviatura_art, codigobarra_art, codigoproveedor_art, codigo_lin, codigo_mar, unidadm_art, 
						precio_art, preciomayorista_art, tipoimpuesto_art, stockmin_art, stockmax_art, 1, usuario);
			
			SELECT LAST_INSERT_ID() INTO id;
			SET Mensaje = 'Articulo registrado correctamente';
		ELSE
			UPDATE articulo
			SET nombre_art=nombre_art,
				abreviatura_art=abreviatura_art,
                codigobarra_art=codigobarra_art,
                codigoproveedor_art=codigoproveedor_art,
                codigo_mar=codigo_mar,
                codigo_lin=codigo_lin,                
				unidadm_art=unidadm_art, 
                tipoimpuesto_art=tipoimpuesto_art,
				precio_art=precio_art, 
                preciomayorista_art=preciomayorista_art,
                stockmin_art=stockmin_art,
				stockmax_art=stockmax_art, 
				usuario_mod=usuario,
				fecha_mod=now()
			 WHERE	 codigo_art=codigo;
             
			 SET id=codigo;
			 SET Mensaje = 'Articulo actualizado correctamente';
		END IF;
        
	COMMIT;
    SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarBanco` (IN `codigo` INT, IN `nombre` VARCHAR(30), IN `abreviatura_ban` VARCHAR(10), IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
		IF codigo = 0 THEN
			INSERT INTO banco(nombre_ban, abreviatura_ban, usuario_reg) 
				VALUES (nombre, abreviatura_ban, usuario);
			
            SELECT LAST_INSERT_ID() INTO id;
			SET Mensaje = 'Banco registrado correctamente';
		ELSE
			UPDATE banco
			SET nombre_ban=nombre,
				abreviatura_ban=abreviatura_ban,
				usuario_mod=usuario,
				fecha_mod=now()
			 WHERE	 codigo_ban=codigo;
			 
			 SET id=codigo;
			 SET Mensaje = 'Banco actualizado correctamente';
		END IF;
        
	COMMIT;
    SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarCliente` (IN `codigo` INT, IN `nombre_cli` VARCHAR(200), IN `direccion_cli` VARCHAR(500), IN `ciudad_cli` VARCHAR(100), IN `telefono_cli` VARCHAR(50), IN `codigo_tip` INT, IN `codigo_doc` INT, IN `numero_doc` VARCHAR(20), IN `codigo_szo` INT, IN `email_cli` VARCHAR(50), IN `observacion_cli` VARCHAR(500), IN `codigo_dis` INT, IN `estadosunat_cli` VARCHAR(50), IN `condicionsunat_cli` VARCHAR(50), IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
		IF codigo = 0 THEN
        
        
			INSERT INTO cliente(nombre_cli, direccion_cli, ciudad_cli, telefono_cli, codigo_tip,  codigo_doc, numero_doc, 
						codigo_szo, email_cli, observacion_cli, codigo_dis, estadosunat_cli, condicionsunat_cli, usuario_reg ) 
				VALUES (nombre_cli, direccion_cli, ciudad_cli, telefono_cli, codigo_tip,  codigo_doc, numero_doc, 
						codigo_szo, email_cli, observacion_cli, codigo_dis, estadosunat_cli, condicionsunat_cli, usuario);
			
            SELECT LAST_INSERT_ID() INTO id;
			SET Mensaje = 'Cliente registrado correctamente';
		ELSE
			UPDATE cliente
			SET nombre_cli=nombre_cli,
				direccion_cli=direccion_cli, 
				ciudad_cli=ciudad_cli, 
				telefono_cli=telefono_cli,
				codigo_tip=codigo_tip,  
				codigo_doc=codigo_doc, 
				numero_doc=numero_doc, 
                codigo_szo=codigo_szo, 
				email_cli=email_cli, 
				observacion_cli=observacion_cli, 
				codigo_dis=codigo_dis, 
				estadosunat_cli=estadosunat_cli, 
				condicionsunat_cli=condicionsunat_cli,
				observacion_cli=observacion_cli,
				usuario_mod=usuario,
				fecha_mod=now()
			 WHERE	 codigo_cli=codigo;
			 
			 SET id=codigo;
			 SET Mensaje = 'Cliente actualizado correctamente';
		END IF;
        
	COMMIT;
    SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarConcepto` (IN `codigo` INT, IN `nombre` VARCHAR(200), IN `codigo_gco` INT, IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
		IF codigo = 0 THEN
			INSERT INTO concepto(nombre_con, codigo_gco, usuario_reg) 
				VALUES (nombre, codigo_gco, usuario);
			
            SELECT LAST_INSERT_ID() INTO id;
			SET Mensaje = 'Concepto registrado correctamente';
		ELSE
			UPDATE Concepto
			SET nombre_con=nombre,
				codigo_gco=codigo_gco,
				usuario_mod=usuario,
				fecha_mod=now()
			 WHERE	 codigo_con=codigo;
             
			 SET id=codigo;
			 SET Mensaje = 'Concepto actualizado correctamente';
		END IF;
        
	COMMIT;
    SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarCuenta` (IN `codigo` INT, IN `nombre` VARCHAR(200), IN `codigo_ban` INT, IN `codigo_mon` INT, IN `titular_cta` VARCHAR(500), IN `codigo_suc` INT, IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
		IF codigo = 0 THEN
			INSERT INTO cuenta(nombre_cta, codigo_ban, codigo_mon, titular_cta, codigo_suc, usuario_reg) 
				VALUES (nombre, codigo_ban, codigo_mon, titular_cta, codigo_suc, usuario);
			
            SELECT LAST_INSERT_ID() INTO id;
			SET Mensaje = 'Cuenta registrada correctamente';
            
            -- Llamar al procedimiento ActualizarSerieDocumento
            CALL ActualizarSerieDocumento(0, 1, '1', 0, codigo_suc, usuario, 1);
            

		ELSE
			UPDATE cuenta
			SET nombre_cta=nombre,
				codigo_ban=codigo_ban, 
				codigo_mon=codigo_mon, 
				titular_cta=titular_cta,
				codigo_suc=codigo_suc,  
				usuario_mod=usuario,
				fecha_mod=now()
			 WHERE	 codigo_cta=codigo;
			 
			 SET id=codigo;
			 SET Mensaje = 'Cuenta actualizada correctamente';
		END IF;
        
	COMMIT;
    SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarCuentasxCobrar` (IN `codigo` INT, IN `codigo_suc` INT, IN `codigo_tdo` INT, IN `serie_moc` VARCHAR(4), IN `numero_moc` VARCHAR(7), IN `codigo_cli` INT, IN `fecha_moc` DATE, IN `importe_moc` NUMERIC(12,2), IN `fechaVencimiento_moc` DATE, IN `codigo_mon` INT, IN `detalle_moc` VARCHAR(1000), IN `dolar_moc` NUMERIC(10,4), IN `codigo_ven` INT, IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
		IF codigo = 0 THEN
   
			INSERT INTO movimientocliente(codigo_suc, codigo_tdo, serie_moc, numero_moc, codigo_cli, tipo_moc, fecha_moc,
							importe_moc, saldo_moc, fechaVencimiento_moc, codigo_mon, detalle_moc, codigo_con, dolar_moc, 
                            codigo_ven, codigo_szo, codigo_zon, estado_moc, usuario_reg)
				VALUES (codigo_suc, codigo_tdo, LPAD(serie_moc,'4','0'), LPAD(numero_moc,'7','0'), codigo_cli, 'C', fecha_moc,
							importe_moc, importe_moc, fechaVencimiento_moc, codigo_mon, detalle_moc, 1, dolar_moc, codigo_ven, 
                            1, 1, 1, usuario);
			
            SELECT LAST_INSERT_ID() INTO id;
			SET Mensaje = 'CXP registrado correctamente';
		ELSE
			UPDATE movimientocliente
			SET codigo_suc=codigo_suc,
				codigo_tdo=codigo_tdo,
				serie_moc= LPAD(serie_moc,'4','0'),
				numero_moc=LPAD(numero_moc,'7','0'),
				codigo_cli=codigo_cli,
				fecha_moc=fecha_moc,
				importe_moc=importe_moc,
				saldo_moc=importe_moc,
				fechaVencimiento_moc=fechaVencimiento_moc,
				codigo_mon=codigo_mon,
				detalle_moc=detalle_moc,
				dolar_moc=dolar_moc,
				codigo_ven=codigo_ven,
				usuario_mod=usuario,
				fecha_mod=now()
			 WHERE	 codigo_moc=codigo
				and estado_moc=1;
			 
			 SET id=codigo;
			 SET Mensaje = 'CXP actualizado correctamente';
		END IF;
        
	COMMIT;
    SELECT id as Respuesta, mensaje as Mensaje;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarCuentasxPagar` (IN `codigo` INT, IN `codigo_suc` INT, IN `codigo_tdo` INT, IN `serie_mop` VARCHAR(4), IN `numero_mop` VARCHAR(7), IN `codigo_pro` INT, IN `fecha_mop` DATE, IN `importe_mop` NUMERIC(12,2), IN `fechaVencimiento_mop` DATE, IN `codigo_mon` INT, IN `detalle_mop` VARCHAR(1000), IN `dolar_mop` NUMERIC(10,4), IN `codigo_ven` INT, IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
		IF codigo = 0 THEN
			INSERT INTO movimientoProveedor(codigo_suc, codigo_tdo, serie_mop, numero_mop, codigo_pro, tipo_mop, fecha_mop,
							importe_mop, saldo_mop, fechaVencimiento_mop, codigo_mon, detalle_mop, codigo_con, dolar_mop, codigo_ven, 
                            estado_mop, usuario_reg)
				VALUES (codigo_suc, codigo_tdo, LPAD(serie_mop,'4','0'), LPAD(numero_mop,'7','0'), codigo_pro, 'P', fecha_mop,
							importe_mop, importe_mop, fechaVencimiento_mop, codigo_mon, detalle_mop, 1, dolar_mop, codigo_ven, 
                            1, usuario);
			
            SELECT LAST_INSERT_ID() INTO id;
			SET Mensaje = 'CXP registrado correctamente';
		ELSE
			UPDATE movimientoProveedor
			SET codigo_suc=codigo_suc,
				codigo_tdo=codigo_tdo,
				serie_mop= LPAD(serie_mop,'4','0'),
				numero_mop=LPAD(numero_mop,'7','0'),
				codigo_pro=codigo_pro,
				fecha_mop=fecha_mop,
				importe_mop=importe_mop,
				saldo_mop=importe_mop,
				fechaVencimiento_mop=fechaVencimiento_mop,
				codigo_mon=codigo_mon,
				detalle_mop=detalle_mop,
				dolar_mop=dolar_mop,
				codigo_ven=codigo_ven,
				usuario_mod=usuario,
				fecha_mod=now()
			 WHERE	 codigo_mop=codigo
				and estado_mop=1;
			 
			 SET id=codigo;
			 SET Mensaje = 'CXP actualizado correctamente';
		END IF;
        
	COMMIT;
    SELECT id as Respuesta, mensaje as Mensaje;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarDocumento` (IN `codigo` INT, IN `nombre` VARCHAR(200), `codigosunat` VARCHAR(3), IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
		IF codigo = 0 THEN
			INSERT INTO documento(codigo_doc, nombre_doc, codigosunat_doc , usuario_reg) 
				VALUES (codigo, nombre, codigosunat , usuario);
			
            		SELECT LAST_INSERT_ID() INTO id;
			SET Mensaje = 'Documento registrado correctamente';
		ELSE
			UPDATE documento
			SET nombre_doc=nombre,
				codigosunat_doc=codigosunat, 
				usuario_mod=usuario,
				fecha_mod=now()
			 WHERE	 codigo_doc=codigo;
			 SET id=codigo;
			 SET Mensaje = 'Documento actualizado correctamente';
		END IF;
        
	COMMIT;
    SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarGrupoConcepto` (IN `codigo` INT, IN `nombre` VARCHAR(200), IN `esgasto` VARCHAR(10), IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
    
        SET esgasto = if(esgasto='S',1,0);
        
		IF codigo = 0 THEN
			INSERT INTO grupoConcepto(nombre_gco, esgasto_gco, usuario_reg) 
				VALUES (nombre, esgasto, usuario);
			
            		SELECT LAST_INSERT_ID() INTO id;
			SET Mensaje = 'Grupo de Concepto registrado correctamente';
		ELSE
			UPDATE grupoConcepto
			SET nombre_gco=nombre,
				esgasto_gco=esgasto,
				usuario_mod=usuario,
				fecha_mod=now()
			 WHERE	 codigo_gco=codigo;
			 SET id=codigo;
			 SET Mensaje = 'Grupo de Concepto actualizado correctamente';
		END IF;
        
	COMMIT;
    SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarLinea` (IN `codigo` INT, IN `nombre` VARCHAR(200), IN `serviciotecnico_lin` VARCHAR(10), IN `usuario` INT)  BEGIN
	DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
	DECLARE errno INT;
    DECLARE existe INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;    
    
	START TRANSACTION;
    
		SET serviciotecnico_lin = if(serviciotecnico_lin='S',1,0);
        
        /*
		SELECT COUNT(*)
		INTO existe
		FROM linea
		WHERE estado_lin=1
			and REPLACE(REPLACE(nombre_lin COLLATE utf8_spanish_ci, ' ', ''), '\t', '') = REPLACE(REPLACE(nombre COLLATE utf8_spanish_ci, ' ', ''), '\t', '');

		-- Verificar el resultado y mostrar el mensaje correspondiente
		IF existe > 1 THEN				
			SET id=0;
			SET Mensaje = 'Linea Duplicada';
		ELSE
      
        END IF;
        */
			IF codigo = 0 THEN			
				SELECT COUNT(*)
				INTO existe
				FROM linea
				WHERE estado_lin=1
					and REPLACE(REPLACE(nombre_lin COLLATE utf8_spanish_ci, ' ', ''), '\t', '') = REPLACE(REPLACE(nombre COLLATE utf8_spanish_ci, ' ', ''), '\t', '');

				-- Verificar el resultado y mostrar el mensaje correspondiente
				IF existe = 0 THEN				
					INSERT INTO linea(nombre_lin, serviciotecnico_lin, estado_lin, usuario_reg, fecha_reg) 
					VALUES (nombre, serviciotecnico_lin, 1, usuario, now());

					SELECT LAST_INSERT_ID() INTO id;
					SET Mensaje = 'Linea registrada correctamente';                
                ELSE
					SET id=0;
					SET Mensaje = 'Linea Duplicada';
				END IF;
			ELSE
				UPDATE linea
				SET nombre_lin=nombre,
					serviciotecnico_lin=serviciotecnico_lin, 
					usuario_mod=usuario,                
					fecha_mod=now()
				 WHERE codigo_lin=codigo;
				 
				 SET id=codigo;
				 SET Mensaje = 'Linea actualizada correctamente';
			END IF;
        
       
	COMMIT;
    SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarMarca` (IN `codigo` INT, IN `nombre` VARCHAR(200), IN `usuario` INT)  BEGIN
	DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
	DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;    
    
	START TRANSACTION;
    
		IF codigo = 0 THEN
			INSERT INTO marca(nombre_mar, estado_mar, usuario_reg, fecha_reg) 
			VALUES (nombre, 1, usuario, now());
            
            SELECT LAST_INSERT_ID() INTO id;
			SET Mensaje = 'Marca registrada correctamente';
		ELSE
			UPDATE marca
			SET nombre_mar=nombre,				
				usuario_mod=usuario,                
				fecha_mod=now()
			 WHERE codigo_mar=codigo;
             
			 SET id=codigo;
			 SET Mensaje = 'Marca actualizada correctamente';
		END IF;
        
	COMMIT;
    SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarMoneda` (IN `codigo` INT, IN `nombre` VARCHAR(200), IN `abreviatura_mon` VARCHAR(500), IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
		IF codigo = 0 THEN
			INSERT INTO moneda(codigo_mon, nombre_mon, abreviatura_mon, usuario_reg) 
				VALUES (codigo, nombre, abreviatura_mon, usuario_reg);
			
            SELECT LAST_INSERT_ID() INTO id;
			SET Mensaje = 'Moneda registrada correctamente';
		ELSE
			UPDATE moneda
			SET nombre_mon=nombre,
				abreviatura_mon=abreviatura_mon,  
				usuario_mod=usuario,
				fecha_mod=now()
			 WHERE	 codigo_mon=codigo;
			 
			 SET id=codigo;
			 SET Mensaje = 'Moneda actualizada correctamente';
		END IF;
        
	COMMIT;
    SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarProveedor` (IN `codigo` INT, IN `nombre` VARCHAR(200), IN `direccion_pro` VARCHAR(500), IN `ciudad_pro` VARCHAR(100), IN `telefono_pro` VARCHAR(50), IN `codigo_tip` INT, IN `codigo_doc` INT, IN `numero_doc` VARCHAR(20), IN `observacion_pro` VARCHAR(500), IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
		IF codigo = 0 THEN
			INSERT INTO proveedor(nombre_pro, direccion_pro, ciudad_pro, telefono_pro, codigo_tip,  codigo_doc, numero_doc, observacion_pro, usuario_reg) 
				VALUES (nombre, direccion_pro, ciudad_pro, telefono_pro, codigo_tip,  codigo_doc, numero_doc, observacion_pro, usuario);
			
            SELECT LAST_INSERT_ID() INTO id;
			SET Mensaje = 'Proveedor registrado correctamente';
		ELSE
			UPDATE proveedor
			SET nombre_pro=nombre,
				direccion_pro=direccion_pro, 
				ciudad_pro=ciudad_pro, 
				telefono_pro=telefono_pro,
				codigo_tip=codigo_tip,  
				codigo_doc=codigo_doc, 
				numero_doc=numero_doc, 
				observacion_pro=observacion_pro,
				usuario_mod=usuario,
				fecha_mod=now()
			 WHERE	 codigo_pro=codigo;
			 
			 SET id=codigo;
			 SET Mensaje = 'Proveedor actualizado correctamente';
		END IF;
        
	COMMIT;
    SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarSerieDocumento` (IN `codigo` INT, IN `codigo_tdo` INT, IN `serie_ser` VARCHAR(5), IN `numero_ser` INT, IN `codigo_suc` INT, IN `usuario` INT, IN `sistema` INT)  BEGIN
	DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
	DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;    
    
	START TRANSACTION;
		IF codigo = 0 THEN
			INSERT INTO seriedocumento(codigo_tdo, serie_ser, numero_ser, codigo_suc, usuario_reg, fecha_reg, sistema) 
			VALUES (codigo_tdo, serie_ser, numero_ser, codigo_suc, usuario, now(), sistema);
            
            SELECT LAST_INSERT_ID() INTO id;
			SET Mensaje = 'Serie registrada correctamente';
		ELSE
			UPDATE seriedocumento
			SET codigo_tdo=codigo_tdo,
				serie_ser=serie_ser,
                numero_ser=numero_ser,
                codigo_suc=codigo_suc,
				usuario_mod=usuario,
				fecha_mod=now()
			 WHERE
				codigo_ser=codigo;
                
			 SET id=codigo;
			 SET Mensaje = 'Serie actualizada correctamente';
		END IF;
        
	COMMIT;
    SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarSucursal` (IN `codigo` INT, IN `nombre` VARCHAR(200), IN `direccion` VARCHAR(200), IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
		IF codigo = 0 THEN
			INSERT INTO sucursal(nombre_suc, direccion_suc, usuario_reg) 
				VALUES (nombre, direccion, usuario);
			
            SELECT LAST_INSERT_ID() INTO id;
			SET Mensaje = 'Sucursal registrada correctamente';
		ELSE
			UPDATE sucursal
			SET nombre_suc=nombre,
				direccion_suc=direccion, 
				usuario_mod=usuario,
				fecha_mod=now()
			 WHERE	 codigo_suc=codigo;
             
			 SET id=codigo;
			 SET Mensaje = 'Sucursal actualizada correctamente';
		END IF;
        
	COMMIT;
    SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Actualizartipocambio` (IN `codigo` INT, IN `fecha` DATE, IN `cambioCompra` NUMERIC(12,4), IN `cambioVenta` NUMERIC(12,4), IN `usuario` INT)  BEGIN
	DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
	DECLARE errno INT;
    ##DECLARE existe INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;    
    
	START TRANSACTION;
    	IF codigo = 0 THEN			
			/*
            SELECT COUNT(*)
			INTO existe
			FROM linea
			WHERE estado_lin=1
				and REPLACE(REPLACE(nombre_lin COLLATE utf8_spanish_ci, ' ', ''), '\t', '') = REPLACE(REPLACE(nombre COLLATE utf8_spanish_ci, ' ', ''), '\t', '');

			-- Verificar el resultado y mostrar el mensaje correspondiente
			IF existe = 0 THEN				
            */

				INSERT INTO tipocambio(fecha_tic, cambioCompra_tic, cambioVenta_tic, estado_tic, usuario_reg, fecha_reg) 
                VALUES(fecha, cambioCompra, cambioVenta, 1, usuario, now()) ;
                

				SELECT LAST_INSERT_ID() INTO id;
				SET Mensaje = 'Linea registrada correctamente';                
            /*    
			ELSE
				SET id=0;
				SET Mensaje = 'Linea Duplicada';
			END IF;
            */
		ELSE
			UPDATE tipocambio
			SET fecha_tic=fecha,
				cambioCompra_tic=cambioCompra, 
                cambioVenta_tic=cambioVenta,
				usuario_mod=usuario,                
				fecha_mod=now()
			 WHERE codigo_tic=codigo;
			 
			 SET id=codigo;
			 SET Mensaje = 'Linea actualizada correctamente';
		END IF;
        
	COMMIT;
    SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarTipoDocumento` (IN `codigo` INT, IN `nombre` VARCHAR(50), IN `abreviatura` VARCHAR(5), IN `codigosunat` VARCHAR(5), IN `tipo` VARCHAR(10), IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
		IF codigo = 0 THEN
			INSERT INTO tipodocumento(codigo_tdo, nombre_tdo, abreviatura_tdo, codigosunat_tdo, tipo_tdo, usuario_reg) 
				VALUES (codigo, nombre, abreviatura, codigosunat, tipo, usuario_reg);
			
            SELECT LAST_INSERT_ID() INTO id;
			SET Mensaje = 'Tipo de Documento registrado correctamente';
		ELSE
			UPDATE tipodocumento
			SET nombre_tdo=nombre,
				abreviatura_tdo=abreviatura,
				codigosunat_tdo=codigosunat,	
                tipo_tdo=tipo,
				usuario_mod=usuario,
				fecha_mod=now()
			 WHERE codigo_tdo=codigo;
			 
			 SET id=codigo;
			 SET Mensaje = 'Tipo de Documento actualizado correctamente';
		END IF;
        
	COMMIT;
    SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarTipoPersona` (IN `codigo` INT, IN `nombre` VARCHAR(200), IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
		IF codigo = 0 THEN
			INSERT INTO tipopersona(nombre_tip, usuario_reg) 
				VALUES (nombre, usuario);
			
            SELECT LAST_INSERT_ID() INTO id;
			SET Mensaje = 'Tipo de Persona registrado correctamente';
		ELSE
			UPDATE tipopersona
			SET nombre_tip=nombre,
				usuario_mod=usuario,
				fecha_mod=now()
			 WHERE codigo_tip=codigo;
             
			 SET id=codigo;
			 SET Mensaje = 'Tipo de Persona actualizado correctamente';
		END IF;
        
	COMMIT;
    SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarUnidad` (IN `codigo` INT, IN `nombre` VARCHAR(200), IN `abreviatura` VARCHAR(50), IN `usuario` INT)  BEGIN
	DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
		IF codigo = 0 THEN
			INSERT INTO unidad
			(nombre_uni, abreviatura_uni,estado_uni,usuario_reg,fecha_reg) 
			VALUES (nombre,abreviatura,1,usuario,now());
            SELECT LAST_INSERT_ID() INTO id;
			SET Mensaje = 'Unidad de medida registrada correctamente';
		ELSE
			UPDATE unidad
			SET nombre_uni=nombre,
				abreviatura_uni=abreviatura,
				usuario_mod=usuario,
				fecha_mod=now()
			 WHERE
			 codigo_uni=codigo;
			 SET id=codigo;
			 SET Mensaje = 'Unidad de medida actualizada correctamente';
		END IF;
        
	COMMIT;
    SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AmortizacionCliente` (IN `codigo` INT, IN `sucursal` INT, IN `documento` INT, IN `serie` VARCHAR(4), IN `numero` VARCHAR(7), IN `cliente` INT, IN `fecha` DATE, IN `importe` NUMERIC(12,2), IN `cuenta` INT, IN `recibo` VARCHAR(20), IN `moneda` INT, IN `detalle` VARCHAR(1000), IN `dolar` NUMERIC(10,4), IN `codigo_ven` INT, IN `referencia` INT, IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
		IF codigo = 0 THEN
			INSERT INTO movimientocliente(codigo_suc, codigo_tdo, serie_moc, numero_moc, codigo_cli, tipo_moc, fecha_moc,
							importe_moc, codigo_cta, recibo_moc, fechaVencimiento_moc, codigo_mon, detalle_moc, 
                            codigo_con, dolar_moc, codigo_ven, codigo_szo, codigo_zon, referencia_moc, estado_moc, usuario_reg)
				VALUES (sucursal, documento, LPAD(serie,'4','0'), LPAD(numero,'7','0'), cliente, 'P', fecha,
							importe, cuenta, recibo, fecha, moneda, detalle, 
                            5, dolar, codigo_ven,  1, 1, referencia, 1, usuario);
			
            SELECT LAST_INSERT_ID() INTO id;
			SET Mensaje = 'Amortización registrada correctamente';
            
            update movimientocliente set saldo_moc = saldo_moc - importe where codigo_moc=referencia;
            
            update cuenta set serie_ing = serie_ing + 1 where codigo_cta=cuenta;
            
		ELSE
			UPDATE movimientocliente
			SET codigo_suc=sucursal,
				codigo_tdo=documento,
				serie_moc= LPAD(serie,'4','0'),
				numero_moc=LPAD(numero,'7','0'),
				codigo_cli=cliente,
				fecha_moc=fecha,
				importe_moc=importe,
				saldo_moc=0,
                codigo_cta=cuenta, 
                recibo_moc=recibo,
				##fechaVencimiento_moc=fechaVencimiento_moc,
				codigo_mon=moneda,
				detalle_moc=detalle,
				dolar_moc=dolar,
				##codigo_ven=codigo_ven,
				usuario_mod=usuario,
				fecha_mod=now()
			 WHERE codigo_moc=codigo
				and estado_moc=1;

			 SET id=codigo;
			 SET Mensaje = 'Amortización actualizada correctamente';
		END IF;
        
	COMMIT;
    SELECT id as Respuesta, mensaje as Mensaje;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AmortizacionProveedor` (IN `codigo` INT, IN `sucursal` INT, IN `documento` INT, IN `serie` VARCHAR(4), IN `numero` VARCHAR(7), IN `proveedor` INT, IN `fecha` DATE, IN `importe` NUMERIC(12,2), IN `cuenta` INT, IN `recibo` VARCHAR(20), IN `moneda` INT, IN `detalle` VARCHAR(1000), IN `dolar` NUMERIC(10,4), IN `codigo_ven` INT, IN `referencia` INT, IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
		IF codigo = 0 THEN
			INSERT INTO movimientoproveedor(codigo_suc, codigo_tdo, serie_mop, numero_mop, codigo_pro, tipo_mop, fecha_mop,
							importe_mop, codigo_cta, recibo_mop, fechaVencimiento_mop, codigo_mon, detalle_mop, 
                            codigo_con, dolar_mop, codigo_ven, referencia_mop, estado_mop, usuario_reg)
				VALUES (sucursal, documento, LPAD(serie,'4','0'), LPAD(numero,'7','0'), proveedor, 'C', fecha,
							importe, cuenta, recibo, fecha, moneda, detalle, 
                            5, dolar, codigo_ven,  referencia, 1, usuario);
			
            SELECT LAST_INSERT_ID() INTO id;
			SET Mensaje = 'Amortización registrada correctamente';
            
            update movimientoproveedor set saldo_mop = saldo_mop - importe where codigo_mop=referencia;
            
            update cuenta set serie_egr = serie_egr + 1 where codigo_cta=cuenta;
            
		ELSE
			UPDATE movimientoproveedor
			SET codigo_suc=sucursal,
				codigo_tdo=documento,
				serie_mop= LPAD(serie,'4','0'),
				numero_mop=LPAD(numero,'7','0'),
				codigo_pro=proveedor,
				fecha_mop=fecha,
				importe_mop=importe,
				saldo_mop=0,
                codigo_cta=cuenta, 
                recibo_mop=recibo,
				codigo_mon=moneda,
				detalle_mop=detalle,
				dolar_mop=dolar,
				##codigo_ven=codigo_ven,
				usuario_mod=usuario,
				fecha_mod=now()
			 WHERE codigo_mop=codigo
				and estado_mop=1;

			 SET id=codigo;
			 SET Mensaje = 'Amortización actualizada correctamente';
		END IF;
        
	COMMIT;
    SELECT id as Respuesta, mensaje as Mensaje;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `conceptoIndividual` (IN `fecha_ini` VARCHAR(10), IN `fecha_fin` VARCHAR(10), IN `codigo_con` INT, IN `codigo_suc` INT)  BEGIN
	select moc.fecha_moc,
		CASE WHEN moc.recibo_moc is null THEN CONCAT (tdo.abreviatura_tdo COLLATE utf8_general_ci, '', moc.serie_moc COLLATE utf8_general_ci, '-', moc.numero_moc COLLATE utf8_general_ci)  ELSE moc.recibo_moc END as documento,
		moc.detalle_moc,
        COALESCE(CASE moc.tipo_moc WHEN 'P' THEN moc.importe_moc END,0)as ingreso,
		COALESCE(CASE moc.tipo_moc WHEN 'C' THEN moc.importe_moc END,0)as egreso
	from movimientocliente moc left join
		tipodocumento tdo on tdo.codigo_tdo=moc.codigo_tdo
	where moc.fecha_moc	between fecha_ini and fecha_fin
		and moc.codigo_con = codigo_con
		and moc.codigo_suc= codigo_suc
        and moc.estado_moc=1
	order by moc.fecha_moc,
			moc.codigo_con;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cuentasporPagar` (IN `fecha_fin` VARCHAR(10), IN `codigo_tip` VARCHAR(10), IN `codigo_suc` VARCHAR(10))  BEGIN

	DECLARE todosTipoCliente VARCHAR(10);
    
	SET todosTipoCliente = if(codigo_tip=0,'%',codigo_tip);
    
	SELECT     
		DISTINCT tb.codigo_pro as codigo,    
		tb.proveedor,    
		direccion,    
		soles,    
		dolares,     
		sucursal    
	FROM    
		(    
		SELECT     
			m.codigo_pro,    
			p.nombre_pro as proveedor,    
			p.direccion_pro as direccion,    
			(coalesce(tb1.imp_soles_p,0) - coalesce(tb2.imp_soles_c,0))as soles,    
			(coalesce(tb3.imp_dolar_p,0) - coalesce(tb4.imp_dolar_c,0))as dolares,    
			s.nombre_suc as sucursal    
		FROM     
			movimientoproveedor m inner join 
			proveedor p on (p.codigo_pro=m.codigo_pro)            
			inner join tipopersona t on (t.codigo_tip=p.codigo_tip)    
			inner join sucursal s on (s.codigo_suc=m.codigo_suc)    
			left outer join     
			(    
			SELECT     
				coalesce(sum(mov_prov.importe_mop),0)as imp_soles_p,    
				mov_prov.codigo_pro
			FROM     
				movimientoproveedor mov_prov inner join 
				proveedor on (proveedor.codigo_pro=mov_prov.codigo_pro)  inner join 
				tipopersona t on (t.codigo_tip=proveedor.codigo_tip)    
			WHERE     
				mov_prov.tipo_mop = 'P'    
				and mov_prov.codigo_mon = 1	##'S'    
				and mov_prov.fecha_mop <= fecha_fin
				and proveedor.codigo_tip like todosTipoCliente 
				and mov_prov.codigo_suc like codigo_suc
				and mov_prov.estado_mop=1
			GROUP BY   
				mov_prov.codigo_pro
			) as tb1 on (tb1.codigo_pro=m.codigo_pro)    

			left outer join     
			(    
			SELECT     
				coalesce(sum(mov_prov.importe_mop),0)as imp_soles_c ,    
				mov_prov.codigo_pro
			FROM     
				movimientoproveedor mov_prov inner join 
				proveedor on (proveedor.codigo_pro=mov_prov.codigo_pro) inner join 
				tipopersona t on (t.codigo_tip=proveedor.codigo_tip)    
			WHERE     
				mov_prov.tipo_mop = 'C'    
				and mov_prov.codigo_mon = 1		##'S'    
				and mov_prov.fecha_mop <= fecha_fin
				and proveedor.codigo_tip like todosTipoCliente  
				and mov_prov.codigo_suc like codigo_suc
				AND mov_prov.codigo_con <> 3 ##Compras  
				and mov_prov.estado_mop=1
			GROUP BY   
				mov_prov.codigo_pro
			)as tb2 on (tb2.codigo_pro=m.codigo_pro)    

			left outer join     
			(    
			SELECT     
				coalesce(sum(mov_prov.importe_mop),0)as imp_dolar_p,    
				mov_prov.codigo_pro    
			FROM     
				movimientoproveedor mov_prov inner join 
				proveedor on (proveedor.codigo_pro=mov_prov.codigo_pro) inner join 
				tipoPersona t on (t.codigo_tip=proveedor.codigo_tip)    
			WHERE     
				mov_prov.tipo_mop = 'P'    
				and mov_prov.codigo_mon = 2		##'D'    
				and mov_prov.fecha_mop <= fecha_fin
				and proveedor.codigo_tip like todosTipoCliente
				and mov_prov.codigo_suc like codigo_suc
				and mov_prov.estado_mop=1
			GROUP BY   
				mov_prov.codigo_pro
			)as tb3 on (tb3.codigo_pro=m.codigo_pro)    

			left outer join     
			(    
			SELECT     
				coalesce(sum(mov_prov.importe_mop),0)as imp_dolar_c,    
				mov_prov.codigo_pro
			FROM     
				movimientoproveedor mov_prov inner join 
				proveedor on (proveedor.codigo_pro=mov_prov.codigo_pro) inner join 
				tipopersona t on (t.codigo_tip=proveedor.codigo_tip)    
			WHERE     
				mov_prov.tipo_mop = 'C'    
				and mov_prov.codigo_mon = 2		##'D'    
				and mov_prov.fecha_mop <= fecha_fin
				and proveedor.codigo_tip like todosTipoCliente
				and mov_prov.codigo_suc like codigo_suc
				and mov_prov.estado_mop=1
			GROUP BY   
				mov_prov.codigo_pro
			)as tb4 on (tb4.codigo_pro=m.codigo_pro)    
		WHERE     
			t.codigo_tip like todosTipoCliente
			and m.fecha_mop <= fecha_fin
			and m.codigo_suc like codigo_suc
			and m.estado_mop=1
		GROUP BY   
			m.codigo_pro,    
			p.nombre_pro,  
			p.direccion_pro,    
			tb1.imp_soles_p,    
			tb2.imp_soles_c,    
			tb3.imp_dolar_p,    
			tb4.imp_dolar_c,    
			m.codigo_mon,    
			s.nombre_suc
		)as tb    
	WHERE   
		(tb.soles <> 0 or dolares <> 0)    
	ORDER BY   
		2;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cuentasxCobrar` (IN `hasta` VARCHAR(10), IN `codigo_tip` INT, IN `codigo_suc` INT)  BEGIN
	DECLARE todosTipoPersona VARCHAR(10);

	SET todosTipoPersona = if(codigo_tip=0,'%',codigo_tip);
		
	select cli.codigo_cli,
		cli.nombre_cli,
		cli.direccion_cli,
		tip.nombre_tip as tipoPersona,
		/*cxc.saldoSoles,
		cxc.saldoDolar*/    
		format(cxc.saldoSoles,2) as saldoSoles,
		format(cxc.saldoDolar,2) as saldoDolar
	from cliente cli inner join
		tipopersona tip on tip.codigo_tip=cli.codigo_tip
		left join(
			select DISTINCT cliente.codigo_cli,
				IFNULL(creditos_soles.importe,0) - IFNULL(pagos_soles.importe,0) as saldoSoles,
				IFNULL(creditos_dolar.importe,0) - IFNULL(pagos_dolar.importe,0) as saldoDolar
			from cliente     
			left join
			(
			select sum(moc.importe_moc)as importe, moc.codigo_cli, moc.codigo_mon, moc.codigo_suc
			from movimientocliente moc 
			where moc.tipo_moc='C'
				and moc.codigo_suc=codigo_suc
				and moc.codigo_mon=1
				and moc.fecha_moc <= hasta
				and moc.estado_moc=1
			group by moc.codigo_cli , moc.codigo_mon, moc.codigo_suc 
			)as creditos_soles on creditos_soles.codigo_cli=cliente.codigo_cli
			left join
			(
			select sum(moc.importe_moc)as importe, moc.codigo_cli, moc.codigo_mon, moc.codigo_suc
			from movimientocliente moc 
			where moc.tipo_moc='P'
				and moc.codigo_suc=codigo_suc
				and moc.codigo_mon=1
				and moc.fecha_moc <= hasta
				and moc.estado_moc=1
			group by moc.codigo_cli , moc.codigo_mon, moc.codigo_suc
			)as pagos_soles on pagos_soles.codigo_cli=cliente.codigo_cli  
			
			left join
			(
			select sum(moc.importe_moc)as importe, moc.codigo_cli, moc.codigo_mon, moc.codigo_suc
			from movimientocliente moc 
			where moc.tipo_moc='C'
				and moc.codigo_suc=codigo_suc
				and moc.codigo_mon=2
				and moc.fecha_moc <= hasta
				and moc.estado_moc=1
			group by moc.codigo_cli , moc.codigo_mon, moc.codigo_suc 
			)as creditos_dolar on creditos_dolar.codigo_cli=cliente.codigo_cli
			left join
			(
			select sum(moc.importe_moc)as importe, moc.codigo_cli, moc.codigo_mon, moc.codigo_suc
			from movimientocliente moc 
			where moc.tipo_moc='P'
				and moc.codigo_suc=codigo_suc
				and moc.codigo_mon=2
				and moc.fecha_moc <= hasta
				and moc.estado_moc=1
			group by moc.codigo_cli , moc.codigo_mon, moc.codigo_suc
			)as pagos_dolar on pagos_dolar.codigo_cli=cliente.codigo_cli         
		)as cxc on cxc.codigo_cli=cli.codigo_cli
	where cli.codigo_tip like todosTipoPersona
		and (cxc.saldoSoles <> 0 or cxc.saldoDolar <> 0) 
	order by 4,2;
        
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EditarMovimientoCaja` (IN `codigo` INT, IN `TipoMovimiento` VARCHAR(1), IN `persona` VARCHAR(4))  BEGIN
	CASE persona 
		WHEN 'Clie' THEN
			select moc.codigo_moc as codigo,
				CASE moc.tipo_moc WHEN 'P' THEN 'I' ELSE 'E' END as tipo,
                moc.fecha_moc as fecha,
                moc.codigo_suc,
                moc.codigo_cta,
                moc.recibo_moc as recibo,
                moc.codigo_con,
                moc.importe_moc as importe,
                moc.detalle_moc as detalle,
                case when codigo_cli is null then 0 else 1 end as direccionadoa,               
                moc.codigo_cli as persona
			from movimientocliente moc
			where moc.codigo_moc=codigo;

		WHEN 'Prov' THEN
			select mop.codigo_mop as codigo,
				CASE mop.tipo_mop WHEN 'P' THEN 'I' ELSE 'E' END as tipo,
                mop.fecha_mop as fecha,
                mop.codigo_suc,
                mop.codigo_cta,
                mop.recibo_mop as recibo,
                mop.codigo_con,
                mop.importe_mop as importe,
                mop.detalle_mop as detalle,
                case when codigo_pro is null then 0 else 2 end as direccionadoa,               
                mop.codigo_pro as persona
			from movimientoproveedor mop
			where codigo_mop=codigo;
            ##codigo;            
	END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarAmortizacionCliente` (IN `codigo` INT, IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE existe INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;

		/*
		SELECT COUNT(*)
		INTO existe
		from movimientocliente p left join
			movimientocliente c on c.codigo_moc=p.referencia_moc
		where p.codigo_moc=39
			and p.estado_moc=1
			and c.estado_moc=1;

		-- Verificar el resultado y mostrar el mensaje correspondiente
		IF existe = 0 THEN				
        */
			UPDATE movimientocliente
			SET estado_moc=0,
				usuario_mod=usuario,
				fecha_mod=now()
			WHERE codigo_moc=codigo;  
			
			SET id=codigo;
			SET Mensaje = 'Línea eliminada correctamente';
		/*
        ELSE
			SET id=0;
			SET Mensaje = 'No es posible eliminar la linea porque tiene dependencias';
		END IF;
		*/		
	COMMIT;
	SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarAmortizacionProveedor` (IN `codigo` INT, IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
   
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;

		UPDATE movimientoproveedor
		SET estado_mop=0,
			usuario_mod=usuario,
			fecha_mod=now()
		WHERE codigo_mop=codigo;  
		
		SET id=codigo;
		SET Mensaje = 'Amortización eliminada correctamente';
		
	COMMIT;
	SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarArticulo` (IN `codigo` INT(2), IN `usuario` INT(1))  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
    
		UPDATE articulo
			SET 
				estado_art=0,
				usuario_mod=usuario,
				fecha_mod=now()
		 WHERE codigo_art=codigo;
         
		SET id=codigo;
		SET Mensaje = 'Articulo eliminado correctamente';
	COMMIT;
	SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarBanco` (IN `codigo` INT, IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE existe INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;

		SELECT COUNT(*)
		INTO existe
		from banco 
		where codigo_ban in (select codigo_ban from cuenta where estado_cta=1 and codigo_ban=codigo);

		-- Verificar el resultado y mostrar el mensaje correspondiente
		IF existe = 0 THEN	
			UPDATE banco
			SET estado_ban=0,
				usuario_mod=usuario,
				fecha_mod=now()
			 WHERE codigo_ban=codigo;
			 
			SET id=codigo;
			SET Mensaje = 'Banco eliminado correctamente';
		ELSE
			SET id=0;
			SET Mensaje = 'No es posible eliminar el banco porque tiene dependencias';
		END IF;
        
	COMMIT;
	SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarCliente` (IN `codigo` INT, IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
    
		UPDATE Cliente
		SET estado_cli=0,
			usuario_mod=usuario,
			fecha_mod=now()
		 WHERE codigo_cli=codigo;
         
		SET id=codigo;
		SET Mensaje = 'Cliente eliminado correctamente';
	COMMIT;
	SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarConcepto` (IN `codigo` INT, IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
    
		UPDATE Concepto
		SET estado_con=0,
			usuario_mod=usuario,
			fecha_mod=now()
		 WHERE codigo_con=codigo;
         
		SET id=codigo;
		SET Mensaje = 'Concepto eliminado correctamente';
	COMMIT;
	SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarCuenta` (IN `codigo` INT, IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
    
		UPDATE Cuenta
		SET estado_cta=0,
			usuario_mod=usuario,
			fecha_mod=now()
		 WHERE codigo_cta=codigo;
         
		SET id=codigo;
		SET Mensaje = 'Cuenta eliminada correctamente';
	COMMIT;
	SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarCuentasxCobrar` (IN `codigo` INT, IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE existe INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
		
        SELECT COUNT(*)
		INTO existe
		from movimientocliente c
			left join movimientocliente p on p.referencia_moc=c.codigo_moc
		where c.codigo_moc=codigo
			and c.estado_moc=1
			and p.estado_moc=1;

		-- Verificar el resultado y mostrar el mensaje correspondiente
		IF existe = 0 THEN				
			UPDATE movimientocliente
			SET estado_moc=0,
				usuario_mod=usuario,
				fecha_mod=now()
			 WHERE codigo_moc=codigo;
         
			SET id=codigo;
			SET Mensaje = 'crédito eliminado correctamente';
        ELSE
			SET id=0;
			SET Mensaje = 'No es posible eliminar el crédito porque tiene dependencias';
		END IF;
        
	COMMIT;
	SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarCuentasxPagar` (IN `codigo` INT, IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
    
		UPDATE movimientoProveedor
		SET estado_mop=0,
			usuario_mod=usuario,
			fecha_mod=now()
		 WHERE codigo_mop=codigo;
         
		SET id=codigo;
		SET Mensaje = 'Cuenta x cobrar eliminada correctamente';
	COMMIT;
	SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarDocumento` (IN `codigo` INT, IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
    
		UPDATE documento
		SET estado_doc=0,
			usuario_mod=usuario,
			fecha_mod=now()
		 WHERE codigo_doc=codigo;
         
		SET id=codigo;
		SET Mensaje = 'Documento eliminado correctamente';
	COMMIT;
	SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarGrupoConcepto` (IN `codigo` INT, IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE existe INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;

		SELECT COUNT(*)
		INTO existe
		from grupoConcepto 
		where codigo_gco in (select codigo_gco from concepto where estado_gco=1 and codigo_gco=codigo);

		-- Verificar el resultado y mostrar el mensaje correspondiente
		IF existe = 0 THEN	
			UPDATE grupoConcepto
			SET estado_gco=0,
				usuario_mod=usuario,
				fecha_mod=now()
			 WHERE codigo_gco=codigo;
			 
			SET id=codigo;
			SET Mensaje = 'Grupo de Concepto eliminado correctamente';
		ELSE
			SET id=0;
			SET Mensaje = 'No es posible eliminar el grupo de concepto porque tiene dependencias';
		END IF;
        
	COMMIT;
	SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarLinea` (IN `codigo` INT, IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE existe INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;

		SELECT COUNT(*)
		INTO existe
		from linea 
		where codigo_lin in (select codigo_lin from articulo where estado_art=1 and codigo_lin=codigo);

		-- Verificar el resultado y mostrar el mensaje correspondiente
		IF existe = 0 THEN				
			UPDATE linea
			SET estado_lin=0,
				usuario_mod=usuario,
				fecha_mod=now()
			WHERE codigo_lin=codigo;  
			
			SET id=codigo;
			SET Mensaje = 'Línea eliminada correctamente';
		ELSE
			SET id=0;
			SET Mensaje = 'No es posible eliminar la linea porque tiene dependencias';
		END IF;
				
	COMMIT;
	SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarMarca` (IN `codigo` INT, IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE existe INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;

		SELECT COUNT(*)
		INTO existe
		from marca 
		where codigo_mar in (select codigo_mar from articulo where estado_art=1 and codigo_mar=codigo);

		-- Verificar el resultado y mostrar el mensaje correspondiente
		IF existe = 0 THEN	
			UPDATE marca
				SET estado_mar=0,
					usuario_mod=usuario,
					fecha_mod=now()
			 WHERE codigo_mar=codigo;
			 
			SET id=codigo;
			SET Mensaje = 'Marca eliminada correctamente';
		ELSE
			SET id=0;
			SET Mensaje = 'No es posible eliminar la marca porque tiene dependencias';
		END IF;
        
	COMMIT;
	SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarMoneda` (IN `codigo` INT, IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
    
		UPDATE moneda
		SET estado_mon=0,
			usuario_mod=usuario,
			fecha_mod=now()
		 WHERE codigo_mon=codigo;
         
		SET id=codigo;
		SET Mensaje = 'Moneda eliminada correctamente';
	COMMIT;
	SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarMovimientoCaja` (IN `codigo` INT, IN `tabla` VARCHAR(4), IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
		
	CASE tabla 
		WHEN 'Clie' THEN
			##Validaciòn para que no eliminen los registros generados por otros modulos
			IF EXISTS (select con.nombre_con 
						from movimientocliente mov inner join
							concepto con on con.codigo_con=mov.codigo_con
						where con.sistema=1
							and codigo_moc=codigo)
			THEN
				SET id=codigo;
				SET Mensaje = 'No se puede eliminar la operaciòn';
			ELSE
				UPDATE movimientoCliente
				SET estado_moc=0,
					usuario_mod=usuario,
					fecha_mod=now()
				WHERE codigo_moc=codigo;
				
				SET id=codigo;
				SET Mensaje = 'Movimiento eliminado correctamente';
			END IF;
		WHEN 'Prov' THEN
			UPDATE movimientoProveedor
			SET estado_mop=0,
				usuario_mod=usuario,
				fecha_mod=now()
			WHERE codigo_mop=codigo;
            
            SET id=codigo;
			SET Mensaje = 'Movimiento eliminado correctamente';
	END CASE;

	
    
	COMMIT;
	SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarProveedor` (IN `codigo` INT, IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
    
		UPDATE Proveedor
		SET estado_pro=0,
			usuario_mod=usuario,
			fecha_mod=now()
		 WHERE codigo_pro=codigo;
         
		SET id=codigo;
		SET Mensaje = 'Proveedor eliminado correctamente';
	COMMIT;
	SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarSerieDocumento` (IN `codigo` INT, IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
    
    	UPDATE SerieDocumento
			SET estado_ser=0,
				usuario_mod=usuario,
				fecha_mod=now()
		 WHERE codigo_ser=codigo;
         
		SET id=codigo;
		SET Mensaje = 'Serie eliminada correctamente';
	COMMIT;
	SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarSucursal` (IN `codigo` INT, IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
    
		UPDATE sucursal
			SET 
				estado_suc=0,
				usuario_mod=usuario,
				fecha_mod=now()
		 WHERE codigo_suc=codigo;
         
		SET id=codigo;
		SET Mensaje = 'Sucursal eliminada correctamente';
	COMMIT;
	SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarTipoCambio` (IN `codigo` INT, IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;

    	UPDATE tipocambio
			SET estado_tic=0,
				usuario_mod=usuario,
				fecha_mod=now()
		 WHERE codigo_tic=codigo;
         
		SET id=codigo;
		SET Mensaje = 'Tipo de Cambio eliminado correctamente';
	COMMIT;
	SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarTipoDocumento` (IN `codigo` INT, IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
    
		UPDATE tipodocumento
		SET estado_tdo=0,
			usuario_mod=usuario,
			fecha_mod=now()
		 WHERE codigo_tdo=codigo;
         
		SET id=codigo;
		SET Mensaje = 'Tipo de Documento eliminado correctamente';
	COMMIT;
	SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarTipoPersona` (IN `codigo` INT, IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE existe INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;

		SELECT COUNT(*)
		INTO existe
		from tipoPersona 
		where codigo_tip in (select codigo_tip from cliente where estado_cli=1 and codigo_tip=codigo
							union
							select codigo_tip from proveedor where estado_pro=1 and codigo_tip=codigo);

		-- Verificar el resultado y mostrar el mensaje correspondiente
		IF existe = 0 THEN	
			UPDATE tipoPersona
			SET estado_tip=0,
				usuario_mod=usuario,
				fecha_mod=now()
			 WHERE codigo_tip=codigo;
			 
			SET id=codigo;
			SET Mensaje = 'Tipo de Persona eliminado correctamente';
		ELSE
			SET id=0;
			SET Mensaje = 'No es posible eliminar el tipo de persona porque tiene dependencias';
		END IF;
        
	COMMIT;
	SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarTransferenciaCuenta` (IN `codigo` INT, IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;		
	
	SET SQL_SAFE_UPDATES = 0;

	UPDATE movimientoCliente mop
	LEFT JOIN movimientoCliente moc ON moc.recibo_moc = mop.recibo_moc AND moc.tipo_moc = 'P' 
	SET 
		mop.estado_moc = 0, mop.usuario_mod=usuario, mop.fecha_mod=now(),
		moc.estado_moc = 0, moc.usuario_mod=usuario, moc.fecha_mod=now()
	WHERE 
		mop.codigo_con = 4 
		AND mop.codigo_moc=codigo
		AND mop.estado_moc = 1
		AND mop.tipo_moc = 'C';
        
        
	SET id=codigo;
	SET Mensaje = 'Transferencia eliminada correctamente';
    
	COMMIT;
	SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarUnidad` (IN `codigo` INT, IN `usuario` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
    
		UPDATE unidad 
			SET 
				estado_uni=0,
				usuario_mod=usuario,
				fecha_mod=now()
		 WHERE codigo_uni=codigo;
         
		SET id=codigo;
		SET Mensaje = 'Unidad de medida eliminada correctamente';
	COMMIT;
	SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EstadoCuentaCliente` (IN `fecha_ini` VARCHAR(10), IN `fecha_fin` VARCHAR(10), IN `codigo_cli` INT, IN `codigo_suc` INT)  BEGIN
	/*Declarar variables para el cursor*/
	DECLARE done INT DEFAULT FALSE;

	DECLARE tipo varchar(1);
    DECLARE fecha date;
    DECLARE documento VARCHAR(20);    
	DECLARE detalle VARCHAR(500);
	DECLARE importe_soles numeric(12,2);
	DECLARE importe_dolar numeric(12,2);
	DECLARE movi VARCHAR(1);
	DECLARE cliente VARCHAR(500);
	DECLARE sucursal VARCHAR(500);
	DECLARE moneda VARCHAR(500);
      
	/*Declarar un cursor para seleccionar todos los usuarios*/
	DECLARE cCursor CURSOR FOR
    
select 1 as id,
	moc.fecha_moc,
	CONCAT (tdo.abreviatura_tdo COLLATE utf8_general_ci, '', moc.serie_moc COLLATE utf8_general_ci, '-', moc.numero_moc COLLATE utf8_general_ci) as documento,
	moc.detalle_moc,
    case moc.codigo_mon when 1 then moc.importe_moc else 0 end as importe_soles,
    case moc.codigo_mon when 2 then moc.importe_moc  else 0 end as importe_dolar,
    moc.tipo_moc,
    cli.nombre_cli as cliente,
    mon.nombre_mon as moneda,
    suc.nombre_suc as sucursal
from movimientoCLiente moc inner join
	tipodocumento tdo on tdo.codigo_tdo=moc.codigo_tdo inner join
    cliente cli on cli.codigo_cli=moc.codigo_cli inner join
    moneda mon on mon.codigo_mon=moc.codigo_mon inner join
    sucursal suc on suc.codigo_suc=moc.codigo_suc
where moc.codigo_cli=codigo_cli
	and codigo_con=1	
    and estado_moc=1
    and moc.tipo_moc='C'
    and moc.codigo_suc=codigo_suc
   

UNION


select 1 as id,
	vta.fecha_vta as fecha,
	CONCAT (tdo.abreviatura_tdo COLLATE utf8_general_ci, '', vta.serie_vta COLLATE utf8_general_ci, '-', vta.numero_vta COLLATE utf8_general_ci) as documento,  
    CONCAT( art.nombre_art, ' [' ,vde.cantidad_vde ,' x ', vde.precio_vde, ']') as detalle,
	case vta.codigo_mon when 1 then (vde.cantidad_vde *  (vde.precio_vde -  (vde.precio_vde * (vde.descuento_vde /100)))) else 0 end as importe_soles,
    case vta.codigo_mon when 2 then (vde.cantidad_vde *  (vde.precio_vde -  (vde.precio_vde * (vde.descuento_vde /100)))) else 0 end as importe_dolar,
    'C' as movi,
    cli.nombre_cli as cliente,
    mon.nombre_mon as moneda,
    suc.nombre_suc as sucursal
from venta vta inner join
	venta_detalle vde on vde.codigo_vta = vta.codigo_vta inner join
	articulo art on art.codigo_art=vde.codigo_art inner join
	cliente cli on cli.codigo_cli=vta.codigo_cli inner join
	sucursal suc on suc.codigo_suc=vta.codigo_suc inner join
	tipoDocumento tdo on tdo.codigo_tdo=vta.codigo_tdo inner join
    moneda mon on mon.codigo_mon=vta.codigo_mon
where vta.codigo_cli=codigo_cli
	and vta.codigo_suc=codigo_suc
    and vta.codigo_con=2
    
UNION

select 2 as id,
	moc.fecha_moc,
    (CASE WHEN moc.recibo_moc is null THEN 
		CONCAT (tdo.abreviatura_tdo COLLATE utf8_general_ci, '', moc.serie_moc COLLATE utf8_general_ci, '-', moc.numero_moc COLLATE utf8_general_ci) 
     ELSE 
		moc.recibo_moc 
    END)as documento,       
	moc.detalle_moc,
    case moc.codigo_mon when 1 then moc.importe_moc else 0 end as importe_soles,
    case moc.codigo_mon when 2 then moc.importe_moc else 0 end as importe_dolar,
    moc.tipo_moc,
    cli.nombre_cli as cliente,
    mon.nombre_mon as moneda,
    suc.nombre_suc as sucursal
from movimientoCLiente moc inner join
	cliente cli on cli.codigo_cli=moc.codigo_cli inner join
    moneda mon on mon.codigo_mon=moc.codigo_mon inner join
    sucursal suc on suc.codigo_suc=moc.codigo_suc left join
    tipoDocumento tdo on tdo.codigo_tdo=moc.codigo_tdo
where moc.codigo_cli=codigo_cli
    and estado_moc=1
    and moc.codigo_suc=codigo_suc
    and moc.tipo_moc='P'
order by 2;
	 
	
    
	/*Declarar un handler para manejar el final del cursor*/
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	DROP TABLE IF EXISTS tmpEECC;

	CREATE TEMPORARY TABLE tmpEECC(
		fecha date,
		documento VARCHAR(20),
        detalle varchar(500),
		ingreso_soles numeric(12,2),
        salida_soles numeric(12,2),
        saldo_soles numeric(12,2),
        ingreso_dolar numeric(12,2),
        salida_dolar numeric(12,2),
        saldo_dolar numeric(12,2),
		fila int);
        
        
	/*Abrir el cursor*/
    OPEN cCursor;

	SET @fila = 2;
    SET @lrd_unidades_soles = 0;
    SET @lrd_unidades_ant_soles = 0;
    
    SET @lrd_unidades_dolar = 0;
    SET @lrd_unidades_ant_dolar = 0;
    
    
    SET @ld_cant_soles=0;
    set @lrd_cant_ant_soles=0;
    
    SET @ld_cant_dolar=0;
    set @lrd_cant_ant_dolar=0;
    
    
    /*set @lrd_unidadesDolar =0;*/
    
    
	/*Iniciar el bucle para recorrer las filas del cursor*/
    read_loop: LOOP
		/*Obtener la próxima fila del cursor*/
        FETCH cCursor INTO tipo, fecha, documento, detalle, importe_soles, importe_dolar, movi, cliente, moneda, sucursal;

		/*Salir del bucle si no hay más filas*/
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        /*set @lrd_unidadesDolar = importe_dolar;*/
        
		/*Imprimir el nombre del usuario   */          
		IF movi='C' THEN
			SET @lrd_unidades_soles = (@lrd_unidades_soles + importe_soles);
            SET @lrd_unidades_dolar = (@lrd_unidades_dolar + importe_dolar);
            
		ELSE
			SET @lrd_unidades_soles = (@lrd_unidades_soles - importe_soles);
            SET @lrd_unidades_dolar = (@lrd_unidades_dolar - importe_dolar);
            
		END IF;      
        SET @ld_cant_soles = @lrd_unidades_soles;
        SET @ld_cant_dolar = @lrd_unidades_dolar;
        
        
    
        IF fecha < fecha_ini THEN
			IF movi='C' THEN
				SET @lrd_unidades_ant_soles = (@lrd_unidades_ant_soles + importe_soles);
                SET @lrd_unidades_ant_dolar = (@lrd_unidades_ant_dolar + importe_dolar);
                
            ELSE
				SET @lrd_unidades_ant_soles = (@lrd_unidades_ant_soles - importe_soles);
                SET @lrd_unidades_ant_dolar = (@lrd_unidades_ant_dolar - importe_dolar);
                
            END IF;
            SET @lrd_cant_ant_soles = @lrd_unidades_ant_soles;
            SET @lrd_cant_ant_dolar = @lrd_unidades_ant_dolar;
            
            
		ELSEIF fecha >= fecha_ini and fecha <= fecha_fin THEN
			IF movi='C' THEN
            
				insert into tmpEECC(fecha, documento, detalle, ingreso_soles, ingreso_dolar, salida_soles, salida_dolar, saldo_soles, saldo_dolar, fila)
				values(fecha, documento, detalle, importe_soles, importe_dolar, 0, 0,  @ld_cant_soles , @ld_cant_dolar , @fila);
			ELSE        
				insert into tmpEECC(fecha, documento, detalle, ingreso_soles, ingreso_dolar, salida_soles, salida_dolar, saldo_soles, saldo_dolar, fila)
				values(fecha, documento, detalle, 0, 0, importe_soles, importe_dolar, @ld_cant_soles, @ld_cant_dolar, @fila);
			END IF;
        END IF;
            
        SET @fila = @fila + 1;
        
    END LOOP;

	/*Cerrar el cursor*/
    CLOSE cCursor;

	insert into tmpEECC(fecha, documento, detalle,  ingreso_soles, ingreso_dolar, salida_soles, salida_dolar, saldo_soles, saldo_dolar, fila)
			values(null, '***SALDO ANTERIOR***', '', 0, 0, 0, 0, @lrd_cant_ant_soles, @lrd_cant_ant_dolar, 1);
 
     
    select t.fecha, t.documento, t.detalle,  
		format(t.ingreso_soles,2) as ingreso_soles, 
        format(t.ingreso_dolar,2) as ingreso_dolar, 
        format(t.salida_soles,2) as salida_soles, 
        format(t.salida_dolar,2) as salida_dolar, 
        format(t.saldo_soles,2) as saldo_soles, 
        format(t.saldo_dolar,2) as saldo_dolar, 
        t.fila
    from tmpEECC t
    order by fila;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EstadoCuentaProveedor` (IN `fecha_ini` VARCHAR(10), IN `fecha_fin` VARCHAR(10), IN `codigo_pro` INT, IN `codigo_suc` INT)  BEGIN
	/*Declarar variables para el cursor*/
	DECLARE done INT DEFAULT FALSE;

	DECLARE tipo varchar(1);
    DECLARE fecha date;
    DECLARE documento VARCHAR(20);    
	DECLARE detalle VARCHAR(500);
	DECLARE importe_soles numeric(12,2);
	DECLARE importe_dolar numeric(12,2);
	DECLARE movi VARCHAR(1);
	DECLARE proveedor VARCHAR(500);
	DECLARE sucursal VARCHAR(500);
	DECLARE moneda VARCHAR(500);
      
	/*Declarar un cursor para seleccionar todos los usuarios*/
	DECLARE cCursor CURSOR FOR
		
	select '1' as id,      
		 m.fecha_mop,      
		 (case when m.codigo_tdo is null then       
			m.recibo_mop
		 else       
			CONCAT (tdo.abreviatura_tdo COLLATE utf8_general_ci, '', m.serie_mop COLLATE utf8_general_ci, '-', m.numero_mop COLLATE utf8_general_ci) 
		 end) as documento,   
         m.detalle_mop,
		case m.codigo_mon when 1 then m.importe_mop else 0 end as importe_soles,
		case m.codigo_mon when 2 then m.importe_mop  else 0 end as importe_dolar,    
		 m.tipo_mop,       
		 pro.nombre_pro as proveedor,      
		 mon.nombre_mon as moneda,      
		 suc.nombre_suc as sucursal 
	from movimientoproveedor m inner join
		proveedor pro on pro.codigo_pro=m.codigo_pro inner join
		moneda mon on mon.codigo_mon=m.codigo_mon inner join
		sucursal suc on suc.codigo_suc=m.codigo_suc inner join
		concepto con on con.codigo_con=m.codigo_con inner join
		tipodocumento tdo on tdo.codigo_tdo=m.codigo_tdo
	where m.codigo_pro=codigo_pro
		and m.codigo_suc=codigo_suc
		and m.codigo_con <> 3
		and m.tipo_mop='P'

	UNION

	select '1' as id,      
		 com.fechaemision_com,      
		 CONCAT (tdo.abreviatura_tdo COLLATE utf8_general_ci, '', com.serie_com COLLATE utf8_general_ci, '-', com.numero_com COLLATE utf8_general_ci) as documento, 
		 CONCAT (art.nombre_art , ' [', CONVERT(det.cantidad_cde, CHAR) ,'*', CONVERT(det.precio_cde, CHAR) ,']' ) as detalle, 
		 case com.codigo_mon when 1 then (det.cantidad_cde * det.precio_cde) else 0 end as importe_soles,
		 case com.codigo_mon when 2 then com.total_com  else 0 end as importe_dolar,    
		 'C' as tipo_mop,       
		 pro.nombre_pro as proveedor,      
		 mon.nombre_mon as moneda,      
		 suc.nombre_suc as sucursal 
	from compra com inner join
		compra_detalle det on det.codigo_com=com.codigo_com inner join
		articulo art on art.codigo_art=det.codigo_art inner join
		proveedor pro on pro.codigo_pro=com.codigo_pro inner join
		moneda mon on mon.codigo_mon=com.codigo_mon inner join
		sucursal suc on suc.codigo_suc=com.codigo_suc inner join
		tipodocumento tdo on tdo.codigo_tdo=com.codigo_tdo
	where
		com.codigo_cod=1
		and com.codigo_pro=codigo_pro
		and com.codigo_suc=codigo_suc

	UNION

	select '2' as id,      
		 m.fecha_mop,      
		 (case when m.codigo_tdo is null then       
			m.recibo_mop
		 else       
			CONCAT (tdo.abreviatura_tdo COLLATE utf8_general_ci, '', m.serie_mop COLLATE utf8_general_ci, '-', m.numero_mop COLLATE utf8_general_ci) 
		 end) as documento,      
         m.detalle_mop,
		case m.codigo_mon when 1 then m.importe_mop else 0 end as importe_soles,
		case m.codigo_mon when 2 then m.importe_mop  else 0 end as importe_dolar,    
		 m.tipo_mop,       
		 pro.nombre_pro as proveedor,      
		 mon.nombre_mon as moneda,      
		 suc.nombre_suc as sucursal 
	from movimientoproveedor m inner join
		proveedor pro on pro.codigo_pro=m.codigo_pro inner join
		moneda mon on mon.codigo_mon=m.codigo_mon inner join
		sucursal suc on suc.codigo_suc=m.codigo_suc inner join
		concepto con on con.codigo_con=m.codigo_con left join
		tipodocumento tdo on tdo.codigo_tdo=m.codigo_tdo
	where m.codigo_pro=codigo_pro
		and m.codigo_suc=codigo_suc
		and (m.codigo_cta is null or m.recibo_mop is not null)
		and m.tipo_mop='C'
	order by 2;
	 
	
    
	/*Declarar un handler para manejar el final del cursor*/
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	DROP TABLE IF EXISTS tmpEECC;

	CREATE TEMPORARY TABLE tmpEECC(
		fecha date,
		documento VARCHAR(20),
        detalle varchar(500),
		ingreso_soles numeric(12,2),
        salida_soles numeric(12,2),
        saldo_soles numeric(12,2),
        ingreso_dolar numeric(12,2),
        salida_dolar numeric(12,2),
        saldo_dolar numeric(12,2),
		fila int);
        
        
	/*Abrir el cursor*/
    OPEN cCursor;

	SET @fila = 2;
    SET @lrd_unidades_soles = 0;
    SET @lrd_unidades_ant_soles = 0;
    
    SET @lrd_unidades_dolar = 0;
    SET @lrd_unidades_ant_dolar = 0;
    
    
    SET @ld_cant_soles=0;
    set @lrd_cant_ant_soles=0;
    
    SET @ld_cant_dolar=0;
    set @lrd_cant_ant_dolar=0;
    
    
    /*set @lrd_unidadesDolar =0;*/
    
    
	/*Iniciar el bucle para recorrer las filas del cursor*/
    read_loop: LOOP
		/*Obtener la próxima fila del cursor*/
        FETCH cCursor INTO tipo, fecha, documento, detalle, importe_soles, importe_dolar, movi, proveedor, moneda, sucursal;

		/*Salir del bucle si no hay más filas*/
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        /*set @lrd_unidadesDolar = importe_dolar;*/
        
		/*Imprimir el nombre del usuario   */          
		IF tipo='1' THEN
			SET @lrd_unidades_soles = (@lrd_unidades_soles + importe_soles);
            SET @lrd_unidades_dolar = (@lrd_unidades_dolar + importe_dolar);
            
		ELSE
			SET @lrd_unidades_soles = (@lrd_unidades_soles - importe_soles);
            SET @lrd_unidades_dolar = (@lrd_unidades_dolar - importe_dolar);
            
		END IF;      
        SET @ld_cant_soles = @lrd_unidades_soles;
        SET @ld_cant_dolar = @lrd_unidades_dolar;
        
        
    
        IF fecha < fecha_ini THEN
			IF tipo='1' THEN
				SET @lrd_unidades_ant_soles = (@lrd_unidades_ant_soles + importe_soles);
                SET @lrd_unidades_ant_dolar = (@lrd_unidades_ant_dolar + importe_dolar);
                
            ELSE
				SET @lrd_unidades_ant_soles = (@lrd_unidades_ant_soles - importe_soles);
                SET @lrd_unidades_ant_dolar = (@lrd_unidades_ant_dolar - importe_dolar);
                
            END IF;
            SET @lrd_cant_ant_soles = @lrd_unidades_ant_soles;
            SET @lrd_cant_ant_dolar = @lrd_unidades_ant_dolar;
            
            
		ELSEIF fecha >= fecha_ini and fecha <= fecha_fin THEN
			IF tipo='1' THEN
				insert into tmpEECC(fecha, documento, detalle, ingreso_soles, ingreso_dolar, salida_soles, salida_dolar, saldo_soles, saldo_dolar, fila)
				values(fecha, documento, detalle, importe_soles, importe_dolar, 0, 0,  @ld_cant_soles , @ld_cant_dolar , @fila);
			ELSE        
				insert into tmpEECC(fecha, documento, detalle, ingreso_soles, ingreso_dolar, salida_soles, salida_dolar, saldo_soles, saldo_dolar, fila)
				values(fecha, documento, detalle, 0, 0, importe_soles, importe_dolar, @ld_cant_soles, @ld_cant_dolar, @fila);
			END IF;
        END IF;
            
        SET @fila = @fila + 1;
        
    END LOOP;

	/*Cerrar el cursor*/
    CLOSE cCursor;

	insert into tmpEECC(fecha, documento, detalle,  ingreso_soles, ingreso_dolar, salida_soles, salida_dolar, saldo_soles, saldo_dolar, fila)
			values(null,'', '***SALDO ANTERIOR***', 0, 0, 0, 0, @lrd_cant_ant_soles, @lrd_cant_ant_dolar, 1);
 
    
    select * from tmpEECC order by fila;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `gastosDetallados` (IN `fecha_ini` VARCHAR(10), IN `fecha_fin` VARCHAR(10), IN `codigo_suc` INT)  BEGIN
	select gco.nombre_gco as grupoConcepto,
		moc.fecha_moc,		
        CASE WHEN moc.recibo_moc is null THEN CONCAT (tdo.abreviatura_tdo COLLATE utf8_general_ci, '', moc.serie_moc COLLATE utf8_general_ci, '-', moc.numero_moc COLLATE utf8_general_ci)  ELSE moc.recibo_moc END as documento,
		con.nombre_con as concepto,
		COALESCE(CASE moc.codigo_mon WHEN 1 THEN moc.importe_moc END,0) as soles,
		COALESCE(CASE moc.codigo_mon WHEN 2 THEN moc.importe_moc END,0) as dolares,
		##moc.tipo_moc,
		moc.detalle_moc as detalle
		##(COALESCE(CASE mocc.codigo_mon WHEN 1 THEN moc.importe_moc END,0) + COALESCE(CASE moc.codigo_mon WHEN 2 THEN (moc.importe_moc * ( 3 ))  END,0))as total
	from concepto con inner join
		grupoconcepto gco on gco.codigo_gco=con.codigo_gco inner join
		movimientocliente moc on moc.codigo_con=con.codigo_con left join
		tipodocumento tdo on tdo.codigo_tdo=moc.codigo_tdo
	where gco.esgasto_gco=1
		and moc.tipo_moc='C'
		and moc.fecha_moc between fecha_ini and fecha_fin
		and moc.codigo_suc=codigo_suc
        AND moc.estado_moc=1
	order by gco.nombre_gco, 
		con.nombre_con, 
		moc.fecha_moc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InventarioFisico` (IN `fecha` VARCHAR(10), IN `codigo_lin` INT, IN `codigo_suc` INT)  BEGIN
	DECLARE todosLinea VARCHAR(10);
    DECLARE todosSucursal VARCHAR(10);
    
	SET todosLinea = if(codigo_lin=0,'%',codigo_lin);
	SET todosSucursal = if(codigo_suc=0,'%',codigo_suc);
    
	select art.codigo_art, 
		art.nombre_art, 
		art.unidadm_art,
		lin.nombre_lin,   
		IFNULL(tbcompra.cantidad, 0) - IFNULL(tbventa.cantidad, 0) as stock
	from articulo art inner join
		linea lin on lin.codigo_lin=art.codigo_lin
		left join
		(
		select det.codigo_art, sum(det.cantidad_cde) as cantidad, com.codigo_suc
		from compra com inner join    
			compra_detalle det on det.codigo_com=com.codigo_com
		where com.codigo_suc like todosSucursal
			and com.fechaingreso_com <= fecha
		group by det.codigo_art, com.codigo_suc    
		)as tbcompra on tbcompra.codigo_art=art.codigo_art
		left join
		(
		select det.codigo_art, sum(det.cantidad_vde) as cantidad, vta.codigo_suc
		from venta vta inner join
			venta_detalle det on det.codigo_vta=vta.codigo_vta
		where vta.codigo_suc like todosSucursal
			and vta.fecha_vta <= fecha
		group by det.codigo_art, vta.codigo_suc    
		)as tbventa on tbventa.codigo_art=art.codigo_art
	where art.estado_art=1
		and  (IFNULL(tbcompra.cantidad, 0) - IFNULL(tbventa.cantidad, 0)) <> 0
		and art.codigo_lin like todosLinea
	order by art.nombre_art, lin.nombre_lin;
        
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `kardexFisico` (IN `fecha_ini` VARCHAR(10), IN `fecha_fin` VARCHAR(10), IN `codigo_art` INT, IN `codigo_suc` INT)  BEGIN
	/*Declarar variables para el cursor*/
	DECLARE done INT DEFAULT FALSE;

	DECLARE tipo varchar(1);
	DECLARE articulo VARCHAR(500);
	DECLARE unidadm VARCHAR(10);
	DECLARE sucursal VARCHAR(500);
	DECLARE fecha date;
	DECLARE movi VARCHAR(1);
	DECLARE documento VARCHAR(20);
	DECLARE cantidad numeric(12,2);
	DECLARE cliprov VARCHAR(500);
	DECLARE item int;
      
	/*Declarar un cursor para seleccionar todos los usuarios*/
	DECLARE cCursor CURSOR FOR
	select '1' as tipo,
		art.nombre_art as articulo,
		art.unidadm_art,
		suc.nombre_suc as sucursal,
		com.fechaingreso_com as fecha,
		'C' as movi,
		CONCAT (tdo.abreviatura_tdo COLLATE utf8_general_ci, '', com.serie_com COLLATE utf8_general_ci, '-', com.numero_com COLLATE utf8_general_ci) as documento,
		cde.cantidad_cde,
		pro.nombre_pro as cliprov,
		cde.item_cde
	from compra com inner join
		compra_detalle cde on cde.codigo_com=com.codigo_com inner join
		articulo art on art.codigo_art=cde.codigo_Art inner join
		proveedor pro on pro.codigo_pro=com.codigo_pro inner join
		sucursal suc on suc.codigo_suc=com.codigo_suc inner join
		tipoDocumento tdo on tdo.codigo_tdo=com.codigo_tdo
	where com.codigo_suc= codigo_suc
		and cde.codigo_art= codigo_art
    
	UNION ALL

	select '2' as tipo,
		art.nombre_art as articulo,
		art.unidadm_art,
		suc.nombre_suc as sucursal,
		vta.fecha_vta as fecha,
		'V' as movi,
		CONCAT (tdo.abreviatura_tdo COLLATE utf8_general_ci, '', vta.serie_vta COLLATE utf8_general_ci, '-', vta.numero_vta COLLATE utf8_general_ci) as documento,  
		vde.cantidad_vde,
		cli.nombre_cli as cliprov,
		vde.item_vde	
	from venta vta inner join
		venta_detalle vde on vde.codigo_vta = vta.codigo_vta inner join
		articulo art on art.codigo_art=vde.codigo_art inner join
		cliente cli on cli.codigo_cli=vta.codigo_cli inner join
		sucursal suc on suc.codigo_suc=vta.codigo_suc inner join
		tipoDocumento tdo on tdo.codigo_tdo=vta.codigo_tdo
	where vde.codigo_art= codigo_art
		and vta.codigo_suc= codigo_suc
	order by 5 asc, 6, 7; 
	
    
	/*Declarar un handler para manejar el final del cursor*/
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	DROP TABLE IF EXISTS tmpKardexFisico;

	CREATE TEMPORARY TABLE tmpKardexFisico(
		fecha date,
		documento VARCHAR(20),
		cliprov VARCHAR(500),
        ingreso numeric(12,2),
        salida numeric(12,2),
        saldo numeric(12,2),
		fila int);
        
        
	/*Abrir el cursor*/
    OPEN cCursor;

	SET @fila = 2;
    SET @lrd_unidades = 0;
    SET @lrd_unidades_ant = 0;
    SET @ld_cant =0;
    set @lrd_cant_ant =0;
    
    
	/*Iniciar el bucle para recorrer las filas del cursor*/
    read_loop: LOOP
		/*Obtener la próxima fila del cursor*/
        FETCH cCursor INTO tipo, articulo, unidadm, sucursal, fecha, movi, documento, cantidad, cliprov, item;

		/*Salir del bucle si no hay más filas*/
        IF done THEN
            LEAVE read_loop;
        END IF;
        
		/*Imprimir el nombre del usuario   */          
		IF movi='C' THEN
			SET @lrd_unidades = (@lrd_unidades + cantidad);
		ELSE
			SET @lrd_unidades = (@lrd_unidades - cantidad);
		END IF;      
        SET @ld_cant = @lrd_unidades;
       
        IF fecha < fecha_ini THEN
			IF movi='C' THEN
				SET @lrd_unidades_ant = (@lrd_unidades_ant + cantidad);
            ELSE
				SET @lrd_unidades_ant = (@lrd_unidades_ant - cantidad);
            END IF;
            SET @lrd_cant_ant = @lrd_unidades_ant;
		ELSEIF fecha >= fecha_ini and fecha <= fecha_fin THEN
			IF movi='C' THEN
				insert into tmpKardexFisico(fecha, documento, cliprov, ingreso, salida, saldo, fila)
				values(fecha, documento, cliprov, cantidad, 0, @ld_cant, @fila);
			ELSE        
				insert into tmpKardexFisico(fecha, documento, cliprov, ingreso, salida, saldo, fila)
				values(fecha, documento, cliprov, 0, cantidad, @ld_cant, @fila);
			END IF;
        END IF;
              
        SET @fila = @fila + 1;
        
    END LOOP;

	/*Cerrar el cursor*/
    CLOSE cCursor;

	insert into tmpKardexFisico(fecha, documento, cliprov,  ingreso, salida, saldo, fila)
			values(null, '***SALDO ANTERIOR***', '', 0, 0, @lrd_cant_ant, 1);
  
    
    select * from tmpKardexFisico order by fila;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListaAmortizacionCliente` (IN `tipo` VARCHAR(20), IN `codigo_moc` INT, IN `fecha_ini` VARCHAR(10), IN `fecha_fin` VARCHAR(10), IN `codigo_cli` INT, IN `codigo_suc` INT)  BEGIN
	DECLARE todosCliente VARCHAR(10);
    DECLARE todosSucursal VARCHAR(10);
    
	SET todosCliente = if(codigo_cli=0,'%',codigo_cli);
	SET todosSucursal = if(codigo_suc=0,'%',codigo_suc);
    
	CASE tipo 
		WHEN 'D' THEN
			select m.codigo_moc, 
				m.fecha_moc,
				CONCAT(tdo.abreviatura_tdo ,'.', m.serie_moc , '-',  m.numero_moc) as documento,
				c.nombre_cli,
				mon.abreviatura_mon as moneda,
				format(m.importe_moc,2) as importe_moc,
                format(0,2) as pago_moc,
                format(m.saldo_moc,2) as saldo_moc,
                m.tipo_moc
			from  movimientocliente m inner join 
				cliente c ON (m.codigo_cli=c.codigo_cli)   inner join
				tipodocumento tdo on tdo.codigo_tdo=m.codigo_tdo inner join
				moneda mon on mon.codigo_mon=m.codigo_mon
			where m.estado_moc=1    
				and m.tipo_moc='C'    
				and m.codigo_con=1
                and m.fecha_moc between fecha_ini and fecha_fin
				and m.codigo_suc like todosSucursal
                and m.codigo_cli like todosCliente                
			order by m.fecha_moc;
		
		
        WHEN 'P' THEN
			select m.codigo_moc, 
				m.fecha_moc,
				CONCAT(tdo.abreviatura_tdo ,'.', m.serie_moc , '-',  m.numero_moc) as documento,
				c.nombre_cli,
				mon.abreviatura_mon as moneda,
				format(0,2) as importe_moc,
                format(m.importe_moc,2) as pago_moc,
				format(m.saldo_moc,2) as saldo_moc,
				m.tipo_moc
			from  movimientocliente m inner join 
				cliente c ON (m.codigo_cli=c.codigo_cli)   inner join
				tipodocumento tdo on tdo.codigo_tdo=m.codigo_tdo inner join
				moneda mon on mon.codigo_mon=m.codigo_mon
			where m.estado_moc=1    
				and m.tipo_moc='P'    
				and m.codigo_con=5
				and m.fecha_moc between fecha_ini and fecha_fin
				and m.codigo_suc like todosSucursal
				and m.codigo_cli like todosCliente    
			order by m.fecha_moc;    
        
        WHEN 'T' THEN
			select m.codigo_moc, 
				m.fecha_moc,
				CONCAT(tdo.abreviatura_tdo ,'.', m.serie_moc , '-',  m.numero_moc) as documento,
				c.nombre_cli,
				mon.abreviatura_mon as moneda,
				format(m.importe_moc,2) as importe_moc,
                format(0,2) as pago_moc,
				format(m.saldo_moc,2) as saldo_moc,
				m.tipo_moc
			from  movimientocliente m inner join 
				cliente c ON (m.codigo_cli=c.codigo_cli)   inner join
				tipodocumento tdo on tdo.codigo_tdo=m.codigo_tdo inner join
				moneda mon on mon.codigo_mon=m.codigo_mon
			where m.estado_moc=1    
				and m.tipo_moc='C'    
				and m.codigo_con=1
				and m.fecha_moc between fecha_ini and fecha_fin
				and m.codigo_suc like todosSucursal
				and m.codigo_cli like todosCliente                
			##order by m.fecha_moc;

			UNION ALL

			##select m.referencia_moc, 
            select m.codigo_moc,
				m.fecha_moc,
				CONCAT(tdo.abreviatura_tdo ,'.', m.serie_moc , '-',  m.numero_moc) as documento,
				c.nombre_cli,
				mon.abreviatura_mon as moneda,
				format(0,2) as importe_moc,
                format(m.importe_moc,2) as pago_moc,
				format(m.saldo_moc,2) as saldo_moc,
				m.tipo_moc
			from  movimientocliente m inner join 
				cliente c ON (m.codigo_cli=c.codigo_cli)   inner join
				tipodocumento tdo on tdo.codigo_tdo=m.codigo_tdo inner join
				moneda mon on mon.codigo_mon=m.codigo_mon
			where m.estado_moc=1    
				and m.tipo_moc='P'    
				and m.codigo_con=5
				and m.fecha_moc between fecha_ini and fecha_fin
				and m.codigo_suc like todosSucursal
				and m.codigo_cli like todosCliente                
			##order by 3, 9, 2;
            order by 3, 9, 2, 1;
        
		WHEN 'ED' THEN
			select    
				m.codigo_moc,
				m.codigo_suc,
				suc.nombre_suc,
				m.codigo_tdo,
				tdo.nombre_tdo,
				m.serie_moc,
				m.numero_moc,
				m.codigo_cli,
				c.nombre_cli,
				m.fecha_moc,
				m.importe_moc,
                m.saldo_moc,
                m.codigo_cta,
				m.fechaVencimiento_moc,
				m.codigo_mon,
				mon.nombre_mon,
				m.detalle_moc,
				m.dolar_moc,
				m.codigo_ven,
				m.referencia_moc,
				ref.importe_moc as importe_ref,
				ref.saldo_moc as saldo_ref
			from movimientocliente m inner join 
				cliente c ON (m.codigo_cli=c.codigo_cli)   inner join
				tipodocumento tdo on tdo.codigo_tdo=m.codigo_tdo inner join
				moneda mon on mon.codigo_mon=m.codigo_mon inner join
				sucursal suc on suc.codigo_suc=m.codigo_suc
                left join movimientoCliente ref on ref.codigo_moc=m.referencia_moc
			where m.estado_moc=1
				and m.codigo_moc=codigo_moc;
	
    		WHEN 'EP' THEN
				select    
					m.codigo_moc,
					m.fecha_moc,
					m.codigo_suc,
					m.codigo_cta,
					m.codigo_mon,
					mon.nombre_mon as moneda,
					cta.codigo_ban,
					ban.nombre_ban as banco,
					m.recibo_moc,
					m.dolar_moc,
					m.codigo_cli,
					c.nombre_cli as cliente,
					m.importe_moc,
					m.saldo_moc,
					m.detalle_moc,
					m.codigo_ven,
                    m.codigo_tdo,
                    m.serie_moc,
                    m.numero_moc,
                    m.referencia_moc,
					ref.importe_moc as importe_ref,
					ref.saldo_moc as saldo_ref
				from movimientocliente m inner join 
					cliente c ON (m.codigo_cli=c.codigo_cli)   inner join
					moneda mon on mon.codigo_mon=m.codigo_mon inner join
					cuenta cta on cta.codigo_cta = m.codigo_cta inner join
					banco ban on ban.codigo_ban=cta.codigo_ban	
                    left join movimientoCliente ref on ref.codigo_moc=m.referencia_moc
				where m.estado_moc=1
					and m.codigo_moc=codigo_moc;
					
	END CASE;
        
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListaAmortizacionProveedor` (IN `tipo` VARCHAR(20), IN `codigo` INT, IN `fecha_ini` VARCHAR(10), IN `fecha_fin` VARCHAR(10), IN `cliente` INT, IN `sucursal` INT)  BEGIN
	DECLARE todosProveedor VARCHAR(10);
    DECLARE todosSucursal VARCHAR(10);
    
	SET todosProveedor = if(cliente=0,'%',cliente);
	SET todosSucursal = if(sucursal=0,'%',sucursal);
    
	CASE tipo 
		WHEN 'D' THEN
			select m.codigo_mop, 
				m.fecha_mop,
				CONCAT(tdo.abreviatura_tdo ,'.', m.serie_mop , '-',  m.numero_mop) as documento,
				p.nombre_pro,
				mon.abreviatura_mon as moneda,
				format(m.importe_mop,2) as importe_mop,
                format(0,2) as pago_mop,
                format(m.saldo_mop,2) as saldo_mop,
                m.tipo_mop
			from  movimientoproveedor m inner join 
				proveedor p ON (m.codigo_pro=p.codigo_pro)   inner join
				tipodocumento tdo on tdo.codigo_tdo=m.codigo_tdo inner join
				moneda mon on mon.codigo_mon=m.codigo_mon
			where m.estado_mop=1    
				and m.tipo_mop='P'    
				and m.codigo_con=1
                and m.fecha_mop between fecha_ini and fecha_fin
				and m.codigo_suc like todosSucursal
                and m.codigo_pro like todosProveedor
			order by m.fecha_mop;
		

        WHEN 'P' THEN
			select m.codigo_mop, 
				m.fecha_mop,
				CONCAT(tdo.abreviatura_tdo ,'.', m.serie_mop , '-',  m.numero_mop) as documento,
				p.nombre_pro,
				mon.abreviatura_mon as moneda,
				format(0,2) as importe_mop,
                format(m.importe_mop,2) as pago_mop,
				format(m.saldo_mop,2) as saldo_mop,
				m.tipo_mop
			from  movimientoproveedor m inner join 
				proveedor p ON (m.codigo_pro=p.codigo_pro)   inner join
				tipodocumento tdo on tdo.codigo_tdo=m.codigo_tdo inner join
				moneda mon on mon.codigo_mon=m.codigo_mon
			where m.estado_mop=1    
				and m.tipo_mop='C'    
				and m.codigo_con=5
				and m.fecha_mop between fecha_ini and fecha_fin
				and m.codigo_suc like todosSucursal
				and m.codigo_pro like todosProveedor    
			order by m.fecha_mop;    


        WHEN 'T' THEN
			select m.codigo_mop, 
				m.fecha_mop,
				CONCAT(tdo.abreviatura_tdo ,'.', m.serie_mop , '-',  m.numero_mop) as documento,
				p.nombre_pro,
				mon.abreviatura_mon as moneda,
				format(m.importe_mop,2) as importe_mop,
                format(0,2) as pago_mop,
				format(m.saldo_mop,2) as saldo_mop,
				m.tipo_mop
			from  movimientoproveedor m inner join 
				proveedor p ON (m.codigo_pro=p.codigo_pro)   inner join
				tipodocumento tdo on tdo.codigo_tdo=m.codigo_tdo inner join
				moneda mon on mon.codigo_mon=m.codigo_mon
			where m.estado_mop=1
				and m.tipo_mop='P'
				and m.codigo_con=1
				and m.fecha_mop between fecha_ini and fecha_fin
				and m.codigo_suc like todosSucursal
				and m.codigo_pro like todosProveedor                

			UNION ALL

            select m.codigo_mop,
				m.fecha_mop,
				##CONCAT(tdo.abreviatura_tdo ,'.', m.serie_mop , '-',  m.numero_mop) as documento,
                recibo_mop as documento,
				p.nombre_pro,
				mon.abreviatura_mon as moneda,
				format(0,2) as importe_mop,
                format(m.importe_mop,2) as pago_mop,
				format(m.saldo_mop,2) as saldo_mop,
				m.tipo_mop
			from  movimientoproveedor m inner join 
				proveedor p ON (m.codigo_pro=p.codigo_pro)   inner join
				tipodocumento tdo on tdo.codigo_tdo=m.codigo_tdo inner join
				moneda mon on mon.codigo_mon=m.codigo_mon
			where m.estado_mop=1    
				and m.tipo_mop='C'    
				and m.codigo_con=5
				and m.fecha_mop between fecha_ini and fecha_fin
				and m.codigo_suc like todosSucursal
				and m.codigo_pro like todosProveedor                
            order by nombre_pro, tipo_mop desc, fecha_mop;
      

		WHEN 'ED' THEN
			select    
				m.codigo_mop,
				m.codigo_suc,
				suc.nombre_suc,
				m.codigo_tdo,
				tdo.nombre_tdo,
				m.serie_mop,
				m.numero_mop,
				m.codigo_pro,
				p.nombre_pro,
				m.fecha_mop,
				m.importe_mop,
                m.saldo_mop,
                m.codigo_cta,
				m.fechaVencimiento_mop,
				m.codigo_mon,
				mon.nombre_mon,
				m.detalle_mop,
				m.dolar_mop,
				m.codigo_ven,
				m.referencia_mop,
				ref.importe_mop as importe_ref,
				ref.saldo_mop as saldo_ref
			from movimientoProveedor m inner join 
				proveedor p ON (p.codigo_pro=m.codigo_pro)   inner join
				tipodocumento tdo on tdo.codigo_tdo=m.codigo_tdo inner join
				moneda mon on mon.codigo_mon=m.codigo_mon inner join
				sucursal suc on suc.codigo_suc=m.codigo_suc
                left join movimientoProveedor ref on ref.codigo_mop=m.referencia_mop
			where m.estado_mop=1
				and m.codigo_mop=codigo;
	
    		WHEN 'EP' THEN
				select    
					m.codigo_mop,
					m.fecha_mop,
					m.codigo_suc,
					m.codigo_cta,
					m.codigo_mon,
					mon.nombre_mon as moneda,
					cta.codigo_ban,
					ban.nombre_ban as banco,
					m.recibo_mop,
					m.dolar_mop,
					m.codigo_pro,
					p.nombre_pro as proveedor,
					m.importe_mop,
					m.saldo_mop,
					m.detalle_mop,
					m.codigo_ven,
                    m.codigo_tdo,
                    m.serie_mop,
                    m.numero_mop,
                    m.referencia_mop,
					ref.importe_mop as importe_ref,
					ref.saldo_mop as saldo_ref
				from movimientoproveedor m inner join 
					proveedor p ON (m.codigo_pro=p.codigo_pro)   inner join
					moneda mon on mon.codigo_mon=m.codigo_mon inner join
					cuenta cta on cta.codigo_cta = m.codigo_cta inner join
					banco ban on ban.codigo_ban=cta.codigo_ban	
                    left join movimientoproveedor ref on ref.codigo_mop=m.referencia_mop
				where m.estado_mop=1
					and m.codigo_mop=codigo;
				
	END CASE;
        
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListaCuentasxCobrar` (IN `tipo` VARCHAR(20), IN `codigo_moc` INT, IN `fecha_ini` VARCHAR(10), IN `fecha_fin` VARCHAR(10), IN `codigo_cli` INT, IN `codigo_suc` INT)  BEGIN
	DECLARE todosCliente VARCHAR(10);
    DECLARE todosSucursal VARCHAR(10);
    
	SET todosCliente = if(codigo_cli=0,'%',codigo_cli);
	SET todosSucursal = if(codigo_suc=0,'%',codigo_suc);
    
	CASE tipo 
		WHEN 'L' THEN
			select    
				m.codigo_moc, 
				m.fecha_moc,
				CONCAT(tdo.abreviatura_tdo ,'.', m.serie_moc , '-',  m.numero_moc) as documento,
				c.nombre_cli,
				mon.abreviatura_mon as moneda,
				format(m.importe_moc,2) as importe_moc
			from     
				movimientocliente m inner join 
				cliente c ON (m.codigo_cli=c.codigo_cli)   inner join
				tipodocumento tdo on tdo.codigo_tdo=m.codigo_tdo inner join
				moneda mon on mon.codigo_mon=m.codigo_mon
			where m.estado_moc=1    
				and m.tipo_moc='C'    
				and m.codigo_con=1
                and m.fecha_moc between fecha_ini and fecha_fin
				and m.codigo_suc like todosSucursal
                and m.codigo_cli like todosCliente                
			order by m.fecha_moc;
				
		WHEN 'E' THEN
			select    
				m.codigo_moc,
				m.codigo_suc,
				suc.nombre_suc,
				m.codigo_tdo,
				tdo.nombre_tdo,
				m.serie_moc,
				m.numero_moc,
				m.codigo_cli,
				c.nombre_cli,
				m.fecha_moc,
				m.importe_moc,
                m.saldo_moc,
				m.fechaVencimiento_moc,
				m.codigo_mon,
				mon.nombre_mon,
				m.detalle_moc,
				m.dolar_moc,
				m.codigo_ven
			from     
				movimientocliente m inner join 
				cliente c ON (m.codigo_cli=c.codigo_cli)   inner join
				tipodocumento tdo on tdo.codigo_tdo=m.codigo_tdo inner join
				moneda mon on mon.codigo_mon=m.codigo_mon inner join
				sucursal suc on suc.codigo_suc=m.codigo_suc
			where m.estado_moc=1
				and m.codigo_moc=codigo_moc;
	
	END CASE;
        
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListaCuentasxPagar` (IN `tipo` VARCHAR(20), IN `codigo_mop` INT, IN `fecha_ini` VARCHAR(10), IN `fecha_fin` VARCHAR(10), IN `codigo_pro` INT, IN `codigo_suc` INT)  BEGIN

	DECLARE todosProveedor VARCHAR(10);
    DECLARE todosSucursal VARCHAR(10);
    
	SET todosProveedor = if(codigo_pro=0,'%',codigo_pro);
	SET todosSucursal = if(codigo_suc=0,'%',codigo_suc);
    
	CASE tipo 
		WHEN 'L' THEN
			select    
				m.codigo_mop, 
				m.fecha_mop,
				CONCAT(tdo.abreviatura_tdo ,'.', m.serie_mop , '-',  m.numero_mop) as documento,
				p.nombre_pro,
				mon.abreviatura_mon as moneda,
				format(m.importe_mop,2) as importe_mop
			from     
				MovimientoProveedor m inner join 
				proveedor p ON (m.codigo_pro=p.codigo_pro)   inner join
				tipodocumento tdo on tdo.codigo_tdo=m.codigo_tdo inner join
				moneda mon on mon.codigo_mon=m.codigo_mon
			where m.estado_mop=1    
				and m.tipo_mop='P'    
				and m.codigo_con=1
                and m.fecha_mop between fecha_ini and fecha_fin
				and m.codigo_suc like todosSucursal
                and m.codigo_pro like todosProveedor;          
				
		WHEN 'E' THEN
			select    
				m.codigo_mop,
				m.codigo_suc,
				suc.nombre_suc,
				m.codigo_tdo,
				tdo.nombre_tdo,
				m.serie_mop,
				m.numero_mop,
				m.codigo_pro,
				p.nombre_pro,
				m.fecha_mop,
				m.importe_mop,
				m.fechaVencimiento_mop,
				m.codigo_mon,
				mon.nombre_mon,
				m.detalle_mop,
				m.dolar_mop,
				m.codigo_ven
			from     
				MovimientoProveedor m inner join 
				proveedor p ON (m.codigo_pro=p.codigo_pro)   inner join
				tipodocumento tdo on tdo.codigo_tdo=m.codigo_tdo inner join
				moneda mon on mon.codigo_mon=m.codigo_mon inner join
				sucursal suc on suc.codigo_suc=m.codigo_suc
			where m.estado_mop=1
				and m.codigo_mop=codigo_mop;
	
	END CASE;
        
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarArticulo` (IN `tipo` VARCHAR(20), IN `id` INT)  BEGIN
	CASE tipo 
		WHEN 'L' THEN
        
        
			SELECT a.codigo_art, a.nombre_art, a.abreviatura_art, a.codigobarra_art, a.codigoproveedor_art,
				m.nombre_mar, l.nombre_lin, a.unidadm_art, format(a.costo_art,2) as costo_art, 
				format(a.precio_art,2) as precio_art,  format(a.preciomayorista_art,2) as preciomayorista_art,
                a.stockmin_art,  a.stockmax_art
			FROM articulo a inner join 
				linea l on a.codigo_lin=l.codigo_lin inner join
                marca m on m.codigo_mar=a.codigo_mar
			where a.estado_art=1
			order by a.nombre_art;

		WHEN 'E' THEN
        
			SELECT a.codigo_art, a.nombre_art, a.abreviatura_art, a.codigobarra_art, a.codigoproveedor_art,
				a.codigo_mar, a.codigo_lin, a.unidadm_art, a.tipoimpuesto_art,  
                round(a.precio_art,2) as precio_art,
                round(a.costo_art,2)  as costo_art,
                round(a.costogasto_art,2)  as costogasto_art,
                round(a.preciomayorista_art,2) as preciomayorista_art, 
                a.stockmin_art,  a.stockmax_art
			FROM articulo a inner join 
				linea l on a.codigo_lin=l.codigo_lin inner join
                marca m on m.codigo_mar=a.codigo_mar
			WHERE a.codigo_art=id and  a.estado_art=1
			order by a.nombre_art;

	END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarBanco` (IN `tipo` VARCHAR(20), IN `id` INT)  BEGIN
	CASE tipo 
		WHEN 'L' THEN
			SELECT codigo_ban, nombre_ban, abreviatura_ban
			FROM banco
			WHERE estado_ban=1
			order by nombre_ban;

		WHEN 'E' THEN
			SELECT codigo_ban, nombre_ban, abreviatura_ban
			FROM banco
			WHERE estado_ban=1
				and codigo_ban=id 
			order by nombre_ban;

	END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarCliente` (IN `tipo` VARCHAR(20), IN `id` INT)  BEGIN
	CASE tipo 
		WHEN 'L' THEN
			SELECT c.codigo_cli, c.nombre_cli, c.direccion_cli, c.ciudad_cli, c.telefono_cli, c.codigo_tip, tip.nombre_tip, c.codigo_doc, doc.nombre_doc, c.numero_doc, c.observacion_cli
			FROM cliente c inner join 
				tipopersona tip on c.codigo_tip=tip.codigo_tip inner join 
				documento doc on doc.codigo_doc=c.codigo_doc
			WHERE c.estado_cli=1
			order by c.nombre_cli;

		WHEN 'E' THEN
			SELECT c.codigo_cli, c.nombre_cli, c.direccion_cli, c.ciudad_cli, c.telefono_cli, c.codigo_tip, c.codigo_doc, c.numero_doc, 
					c.codigo_szo, c.email_cli, c.observacion_cli, c.codigo_dis, c.estadosunat_cli, c.condicionsunat_cli, c.usuario_reg,
					dis.codigo_pro, pro.codigo_dep
			FROM cliente c inner join
				distrito dis on dis.codigo_dis=c.codigo_dis inner join
				provincia pro on pro.codigo_pro=dis.codigo_pro 
			WHERE c.estado_cli=1
				and c.codigo_cli=id
			order by c.nombre_cli;

	
		WHEN 'T' THEN
			SELECT 0 as codigo_cli, '<<   TODOS   >>' as nombre_cli, '' as direccion_cli, '' as ciudad_cli, '' as telefono_cli, 0 as codigo_tip, '' as nombre_tip, 0 as codigo_doc, '' as nombre_doc, '' as numero_doc, '' as observacion_cli
            union
			SELECT c.codigo_cli, c.nombre_cli, c.direccion_cli, c.ciudad_cli, c.telefono_cli, c.codigo_tip, tip.nombre_tip, c.codigo_doc, doc.nombre_doc, c.numero_doc, c.observacion_cli
			FROM cliente c inner join 
				tipopersona tip on c.codigo_tip=tip.codigo_tip inner join 
				documento doc on doc.codigo_doc=c.codigo_doc
			WHERE c.estado_cli=1
			order by 1;
            
	END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarCompra` (IN `tipo` VARCHAR(20), IN `codigo_com` INT, IN `fecha_ini` VARCHAR(10), IN `fecha_fin` VARCHAR(10), IN `codigo_pro` INT, IN `codigo_suc` INT)  BEGIN
	DECLARE todosProveedor VARCHAR(10);
    DECLARE todosSucursal VARCHAR(10);
    
	SET todosProveedor = if(codigo_pro=0,'%',codigo_pro);
	SET todosSucursal = if(codigo_suc=0,'%',codigo_suc);
    
	CASE tipo 
		WHEN 'L' THEN
			select c.codigo_com, CONCAT (tdo.abreviatura_tdo, '', c.serie_com , '-', c.numero_com) as documento,  
				c.fechaemision_com as fecha, pro.nombre_pro as proveedor,
				cod.nombre_cod as condicion, mon.nombre_mon as moneda, c.total_com as importe
                ##,c.codigo_suc
			from compra c inner join
				compra_detalle d on d.codigo_com=c.codigo_com inner join
				tipodocumento tdo on tdo.codigo_tdo=c.codigo_tdo inner join
				proveedor pro on pro.codigo_pro=c.codigo_pro inner join
				moneda mon on mon.codigo_mon=c.codigo_cod inner join
				condicion cod on cod.codigo_cod=c.codigo_cod
			where c.fechaemision_com between fecha_ini and fecha_fin
				and c.codigo_suc like todosSucursal
                and c.codigo_pro like todosProveedor
			group by
				tdo.nombre_tdo, c.serie_com, c.numero_com, c.fechaemision_com, pro.nombre_pro, c.total_com,
				mon.nombre_mon, cod.nombre_cod, c.codigo_com;
                
				##order by m.fecha_moc;
				
		WHEN 'E' THEN
			select    
				m.codigo_moc,
				m.codigo_suc,
				suc.nombre_suc,
				m.codigo_tdo,
				tdo.nombre_tdo,
				m.serie_moc,
				m.numero_moc,
				m.codigo_cli,
				c.nombre_cli,
				m.fecha_moc,
				m.importe_moc,
				m.fechaVencimiento_moc,
				m.codigo_mon,
				mon.nombre_mon,
				m.detalle_moc,
				m.dolar_moc,
				m.codigo_ven
			from     
				movimientocliente m inner join 
				cliente c ON (m.codigo_cli=c.codigo_cli)   inner join
				tipodocumento tdo on tdo.codigo_tdo=m.codigo_tdo inner join
				moneda mon on mon.codigo_mon=m.codigo_mon inner join
				sucursal suc on suc.codigo_suc=m.codigo_suc
			where m.estado_moc=1
				and m.codigo_moc=codigo_moc;
	
	END CASE;
        
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarConcepto` (IN `tipo` VARCHAR(20), IN `id` INT)  BEGIN
	CASE tipo 
	WHEN 'L' THEN

		SELECT con.codigo_con, con.nombre_con, gco.nombre_gco
		FROM Concepto con inner join 
			grupoconcepto gco on con.codigo_gco=gco.codigo_gco
		WHERE con.estado_con=1
			and con.sistema=0
		order by con.nombre_con;

	WHEN 'E' THEN

		SELECT con.codigo_con, con.nombre_con, con.codigo_gco, gco.nombre_gco
		FROM Concepto con inner join 
			grupoconcepto gco on con.codigo_gco=gco.codigo_gco
		WHERE con.estado_con=1
			and con.codigo_con=id 
            and con.sistema=0
		order by con.nombre_con;

	END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarCondicion` (IN `tipo` VARCHAR(20), IN `id` INT)  BEGIN
	CASE tipo 
		WHEN 'L' THEN

		select codigo_cod, nombre_cod 
        from condicion
        order by nombre_cod;

		WHEN 'E' THEN

		select codigo_cod, nombre_cod 
        from condicion
		WHERE codigo_cod=id
		order by nombre_cod;

		WHEN 'T' THEN

		SELECT 0 AS codigo_cod, '<<   TODOS   >>'  as nombre_cod
		union
		select codigo_cod, nombre_cod 
        from condicion
		order by nombre_cod;
        
	END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarCuenta` (IN `tipo` VARCHAR(20), IN `id` INT, IN `codigo_suc` INT)  BEGIN
	CASE tipo 
		WHEN 'L' THEN
			SELECT cta.codigo_cta, cta.nombre_cta, cta.codigo_mon, mon.abreviatura_mon, cta.codigo_ban, ban.nombre_ban, cta.titular_cta, cta.codigo_suc, suc.nombre_suc
			FROM cuenta cta inner join 
				banco ban on ban.codigo_ban=cta.codigo_ban inner join 
				moneda mon on mon.codigo_mon=cta.codigo_mon inner join
				sucursal suc on suc.codigo_suc=cta.codigo_suc
			WHERE cta.estado_cta=1
			order by cta.nombre_cta;

		WHEN 'E' THEN
			SELECT cta.codigo_cta, cta.nombre_cta, cta.titular_cta, cta.codigo_mon, cta.codigo_ban,  cta.codigo_suc
			FROM cuenta cta 
			WHERE cta.estado_cta=1
				and cta.codigo_cta=id
			order by cta.nombre_cta;

		WHEN 'T' THEN
			SELECT 0 AS codigo_cta, '<<   TODOS   >>'  as nombre_cta, 0 AS codigo_mon, '' as abreviatura_mon, 0 as codigo_ban, 
				'' as nombre_ban, '' as titular_cta, 0 as codigo_suc, '' as nombre_suc
			union
			SELECT cta.codigo_cta, cta.nombre_cta, cta.codigo_mon, mon.abreviatura_mon, cta.codigo_ban, ban.nombre_ban, cta.titular_cta, cta.codigo_suc, suc.nombre_suc
			FROM cuenta cta inner join 
				banco ban on ban.codigo_ban=cta.codigo_ban inner join 
				moneda mon on mon.codigo_mon=cta.codigo_mon inner join
				sucursal suc on suc.codigo_suc=cta.codigo_suc
			WHERE cta.estado_cta=1
			order by nombre_cta;

		WHEN 'B' THEN
			SELECT cta.codigo_cta, cta.nombre_cta, cta.codigo_mon, mon.abreviatura_mon, cta.codigo_ban, ban.nombre_ban, cta.titular_cta, cta.codigo_suc, suc.nombre_suc
			FROM cuenta cta inner join 
				banco ban on ban.codigo_ban=cta.codigo_ban inner join 
				moneda mon on mon.codigo_mon=cta.codigo_mon inner join
				sucursal suc on suc.codigo_suc=cta.codigo_suc
			WHERE cta.estado_cta=1
				and cta.codigo_suc = codigo_suc
			order by cta.nombre_cta;
            
        WHEN 'LT' THEN
			SELECT cta.codigo_cta, cta.nombre_cta, cta.titular_cta, cta.codigo_mon, cta.codigo_ban,  cta.codigo_suc
			FROM cuenta cta 
			WHERE cta.estado_cta=1
				and cta.codigo_cta <> id
			order by cta.nombre_cta;
            
		WHEN 'LBM' THEN		##Listar Banco y Moneda
			select cta.codigo_ban, ban.nombre_ban, cta.codigo_mon, mon.nombre_mon
			from cuenta cta inner join
				banco ban on ban.codigo_ban=cta.codigo_cta inner join
				moneda mon on mon.codigo_mon=cta.codigo_mon
			where cta.codigo_cta=id
				and estado_cta=1;


		WHEN 'LSD' THEN		##Listar SucursalDestino
			select cta.codigo_suc, suc.nombre_suc
			from cuenta cta inner join 
				sucursal suc on suc.codigo_suc=cta.codigo_suc
			where cta.codigo_cta=id;
            
	END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarDepartamento` (IN `tipo` VARCHAR(20), IN `id` INT)  BEGIN
	CASE tipo 
		WHEN 'L' THEN
			SELECT codigo_dep, nombre_dep
			FROM departamento
			WHERE estado_dep=1
			ORDER BY nombre_dep;

		WHEN 'E' THEN
			SELECT codigo_dep, nombre_dep
			FROM departamento
			WHERE estado_dep=1
				and codigo_dep=id
			ORDER BY nombre_dep;

		/*WHEN 'T' THEN
			SELECT 0 AS codigo_lin, '<<   TODOS   >>' AS nombre_lin
            UNION
			SELECT codigo_lin,
				nombre_lin
			FROM linea
			WHERE estado_lin=1
			ORDER BY nombre_lin;  
         */   
	END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarDeudaAnterior` (IN `codigo_suc` INT)  BEGIN
    SELECT * 
    FROM MovimientoProveedor
    WHERE codigo_suc = codigo_suc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarDistrito` (IN `tipo` VARCHAR(20), IN `id` INT)  BEGIN
	CASE tipo 
		WHEN 'L' THEN
			SELECT codigo_dis, nombre_dis, codigo_pro
			FROM distrito
			WHERE estado_dis=1
				and codigo_pro=id
			ORDER BY codigo_pro;

	END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarDocumento` (IN `tipo` VARCHAR(20), IN `id` INT)  BEGIN
CASE tipo 
WHEN 'L' THEN

SELECT codigo_doc, nombre_doc, codigosunat_doc
FROM documento
WHERE estado_doc=1
order by nombre_doc;

WHEN 'E' THEN

SELECT codigo_doc, nombre_doc, codigosunat_doc
FROM documento
WHERE estado_doc=1
	and codigo_doc=id 
order by nombre_doc;

END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarGrupoConcepto` (IN `tipo` VARCHAR(20), IN `id` INT)  BEGIN
	CASE tipo 
		WHEN 'L' THEN
			SELECT codigo_gco, nombre_gco, CASE esgasto_gco WHEN 1 THEN 'SI' ELSE 'NO' END AS esgasto_gco
			FROM grupoConcepto
			WHERE estado_gco=1
			order by nombre_gco;

		WHEN 'E' THEN
			SELECT codigo_gco, nombre_gco, CASE esgasto_gco WHEN 1 THEN 'SI' ELSE 'NO' END AS esgasto_gco
			FROM grupoConcepto
			WHERE estado_gco=1
				and codigo_gco=id 
			order by nombre_gco;

	END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarLinea` (IN `tipo` VARCHAR(20), IN `id` INT)  BEGIN
	CASE tipo 
		WHEN 'L' THEN
			SELECT codigo_lin,nombre_lin, 
				case serviciotecnico_lin when 0 then 'NO' else 'SI' end serviciotecnico_lin
			FROM linea
			WHERE estado_lin=1
			ORDER BY nombre_lin;

		WHEN 'E' THEN
			SELECT codigo_lin,nombre_lin,
				case serviciotecnico_lin when 0 then 'NO' else 'SI' end serviciotecnico_lin
			FROM linea
			WHERE estado_lin=1 AND
				codigo_lin=id
			ORDER BY nombre_lin;

		WHEN 'T' THEN
			SELECT 0 AS codigo_lin, '<<   TODOS   >>' AS nombre_lin
            UNION
			SELECT codigo_lin,
				nombre_lin
			FROM linea
			WHERE estado_lin=1
			ORDER BY nombre_lin;            
	END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarMarca` (IN `tipo` VARCHAR(20), IN `id` INT)  BEGIN
	CASE tipo 
		WHEN 'L' THEN
			SELECT codigo_mar,
				nombre_mar
			FROM marca
			WHERE estado_mar=1
			ORDER BY nombre_mar;

		WHEN 'E' THEN
			SELECT codigo_mar,
				nombre_mar
			FROM marca
			WHERE estado_mar=1 AND
				codigo_mar=id
			ORDER BY nombre_mar;

		WHEN 'T' THEN
			SELECT 0 AS codigo_mar, '<<   TODOS   >>' AS nombre_mar
            UNION
			SELECT codigo_mar,
				nombre_mar
			FROM marca
			WHERE estado_mar=1
			ORDER BY nombre_mar;   
	END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarMoneda` (IN `tipo` VARCHAR(20), IN `id` INT)  BEGIN
CASE tipo 
WHEN 'L' THEN

SELECT codigo_mon, nombre_mon, abreviatura_mon
FROM moneda mon 
WHERE mon.estado_mon=1
order by mon.nombre_mon;

WHEN 'E' THEN

SELECT codigo_mon, nombre_mon, abreviatura_mon
FROM moneda mon 
WHERE mon.estado_mon=1
	and codigo_mon=id
order by mon.nombre_mon;


END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarMovimientoIngresoEgreso` (IN `fecha_ini` VARCHAR(10), IN `fecha_fin` VARCHAR(10), IN `codigo_cta` INT, IN `codigo_suc` INT)  BEGIN
	/*Declarar variables para el cursor*/
	DECLARE done INT DEFAULT FALSE;

    DECLARE fecha date;
    DECLARE documento VARCHAR(20);    
	DECLARE detalle VARCHAR(1000);
	DECLARE importe numeric(12,2);
	DECLARE referencia VARCHAR(1000);
	DECLARE tipo VARCHAR(1);
    DECLARE fecha_reg datetime;
    DECLARE codigo INT;
    DECLARE tipo_mov VARCHAR(1);
    DECLARE tabla VARCHAR(4);
    
    
							  
	/*Declarar un cursor para seleccionar todos los usuarios*/
	DECLARE cCursor CURSOR FOR

select m.fecha_moc as fecha, 
	case when  m.recibo_moc is null then
		CONCAT (tdo.abreviatura_tdo COLLATE utf8_general_ci, '', m.serie_moc COLLATE utf8_general_ci, '-', m.numero_moc COLLATE utf8_general_ci)
    else 
		m.recibo_moc
    end as documento,
    m.detalle_moc as detalle,
    m.importe_moc as importe,
    ifnull(cli.nombre_cli, con.nombre_con) as referencia,
    case m.tipo_moc when 'P' then 'I' else 'S' end as tipo,
    m.fecha_reg,
    m.codigo_moc as codigo,
    m.tipo_moc as tipo_mov,
    'Clie' as Tabla
from movimientocliente m inner join
	cuenta cta on cta.codigo_cta=m.codigo_cta left join
    tipodocumento tdo on tdo.codigo_tdo=m.codigo_tdo left join
    cliente cli on cli.codigo_cli=m.codigo_cli left join
    concepto con on con.codigo_con=m.codigo_con
where m.codigo_cta = codigo_cta
	and m.codigo_suc=codigo_suc
    and m.tipo_moc='P'
    and m.estado_moc=1



UNION

select m.fecha_moc,
	case when  m.recibo_moc is null then
		CONCAT (tdo.abreviatura_tdo COLLATE utf8_general_ci, '', m.serie_moc COLLATE utf8_general_ci, '-', m.numero_moc COLLATE utf8_general_ci)
    else 
		m.recibo_moc
    end as recibo,
	m.detalle_moc,
    m.importe_moc,
    ifnull(cli.nombre_cli, con.nombre_con) as refe,
    case m.tipo_moc when 'P' then 'I' else 'S' end as tipo
	,m.fecha_reg,
    m.codigo_moc as codigo,
    m.tipo_moc as tipo_mov,
    'Clie' as Tabla 
from movimientocliente m left join
	cliente cli on cli.codigo_cli=m.codigo_cli left join
    concepto con on con.codigo_con=m.codigo_con left join
    cuenta cta on cta.codigo_cta=m.codigo_cta left join
    tipodocumento tdo on tdo.codigo_tdo=m.codigo_tdo
where
	m.tipo_moc='C'
    and m.codigo_cta=codigo_cta
    and m.codigo_suc=codigo_suc
    and m.estado_moc=1
						
 UNION
 
select m.fecha_mop,
	case when  m.recibo_mop is null then
		CONCAT (tdo.abreviatura_tdo COLLATE utf8_general_ci, '', m.serie_mop COLLATE utf8_general_ci, '-', m.numero_mop COLLATE utf8_general_ci)
    else 
		m.recibo_mop
    end as recibo,
	m.detalle_mop,
    m.importe_mop,
    ifnull(pro.nombre_pro, con.nombre_con) as refe,
    case m.tipo_mop when 'P' then 'I' else 'S' end as tipo
	,m.fecha_reg,
    m.codigo_mop as codigo,
    m.tipo_mop as tipo_mov,
    'Prov' as Tabla
from movimientoproveedor m left join
	proveedor pro on pro.codigo_pro=m.codigo_pro left join
    concepto con on con.codigo_con=m.codigo_con left join
    cuenta cta on cta.codigo_cta=m.codigo_cta left join
    tipodocumento tdo on tdo.codigo_tdo=m.codigo_tdo
where m.codigo_cta=codigo_cta
	and m.codigo_suc=codigo_suc
    and m.estado_mop=1
ORDER BY 1, 7, 6, 2;

   
	/*Declarar un handler para manejar el final del cursor*/
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	DROP TABLE IF EXISTS tmpCaja;

	CREATE TEMPORARY TABLE tmpCaja(
		fecha date,
		documento VARCHAR(20),
        detalle varchar(1000),
		ingreso numeric(12,2),
        salida numeric(12,2),
        saldo numeric(12,2),
        referencia varchar(1000),
        fila int,
        codigo INT,
		tipo_mov VARCHAR(1),
		tabla VARCHAR(4)
    );
                
	/*Abrir el cursor*/
    OPEN cCursor;

	SET @fila = 2;
    SET @lrd_unidades = 0;
    SET @lrd_unidades_ant = 0;
	
    SET @ld_cant=0;
    set @lrd_cant_ant=0;

	
	/*Iniciar el bucle para recorrer las filas del cursor*/
    read_loop: LOOP
		/*Obtener la próxima fila del cursor*/
        FETCH cCursor INTO fecha, documento, detalle, importe, referencia, tipo, fecha_reg, codigo, tipo_mov, tabla;

		/*Salir del bucle si no hay más filas*/
        IF done THEN
            LEAVE read_loop;
        END IF;
        
		IF tipo='I' THEN
			SET @lrd_unidades = (@lrd_unidades + importe);
																			            
		ELSE
			SET @lrd_unidades = (@lrd_unidades - importe);
																			            
		END IF;  
        SET @ld_cant = @lrd_unidades;
        
    
        IF fecha < fecha_ini THEN
			IF tipo='I' THEN
				SET @lrd_unidades_ant = (@lrd_unidades_ant + importe);
            ELSE
				SET @lrd_unidades_ant = (@lrd_unidades_ant - importe);               
            END IF;
            SET @lrd_cant_ant = @lrd_unidades_ant;
            
		ELSEIF fecha >= fecha_ini and fecha <= fecha_fin THEN
			IF tipo='I' THEN
            
				insert into tmpCaja(fecha, documento, detalle, ingreso, salida, saldo, referencia, fila, codigo, tipo_mov, tabla)
				values(fecha, documento, detalle, importe, 0, @ld_cant, referencia, @fila, codigo, tipo_mov, tabla);
			ELSE        
				insert into tmpCaja(fecha, documento, detalle, ingreso, salida, saldo, referencia, fila, codigo, tipo_mov, tabla)
				values(fecha, documento, detalle, 0, importe, @ld_cant, referencia, @fila, codigo, tipo_mov, tabla);
			END IF;
        END IF;
    
    
        SET @fila = @fila + 1;
        
    END LOOP;

	/*Cerrar el cursor*/
    CLOSE cCursor;

	insert into tmpCaja(fecha, documento, detalle, ingreso, salida, saldo, referencia, fila)
			values(null, '','***SALDO ANTERIOR***', 0, 0, @lrd_cant_ant, '', 1);
        
    select * from tmpCaja order by fila;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarProveedor` (IN `tipo` VARCHAR(20), IN `id` INT)  BEGIN
	CASE tipo 
		WHEN 'L' THEN
			SELECT p.codigo_pro, p.nombre_pro, p.direccion_pro, p.ciudad_pro, p.telefono_pro, p.codigo_tip, tip.nombre_tip, p.codigo_doc, doc.nombre_doc, p.numero_doc, p.observacion_pro
			FROM proveedor p inner join 
				tipopersona tip on p.codigo_tip=tip.codigo_tip inner join 
				documento doc on doc.codigo_doc=p.codigo_doc
			WHERE estado_pro=1
			order by p.nombre_pro;

		WHEN 'E' THEN
			SELECT p.codigo_pro, p.nombre_pro, p.direccion_pro, p.ciudad_pro, p.telefono_pro, p.codigo_tip, 
				/*tip.nombre_tip, */
                p.codigo_doc, 
                /*doc.nombre_doc,*/ 
                p.numero_doc, p.observacion_pro
			FROM proveedor p 
				/*inner join 
				tipopersona tip on p.codigo_tip=tip.codigo_tip inner join 
				documento doc on doc.codigo_doc=p.codigo_doc*/
			WHERE estado_pro=1
				and p.codigo_pro=id
			order by p.nombre_pro;
            

		WHEN 'T' THEN
			SELECT 0 as codigo_pro, '<<   TODOS   >>' as nombre_pro, '' as direccion_pro, '' as ciudad_pro, '' as telefono_pro,  0 as codigo_tip, '' as nombre_tip, 0 as codigo_doc, '' as nombre_doc, '' as numero_doc, '' as observacion_pro
			union
			SELECT p.codigo_pro, p.nombre_pro, p.direccion_pro, p.ciudad_pro, p.telefono_pro, p.codigo_tip, tip.nombre_tip, p.codigo_doc, doc.nombre_doc, p.numero_doc, p.observacion_pro
			FROM proveedor p inner join 
				tipopersona tip on p.codigo_tip=tip.codigo_tip inner join 
				documento doc on doc.codigo_doc=p.codigo_doc
			WHERE estado_pro=1
			order by 1;
            
END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarProvincia` (IN `tipo` VARCHAR(20), IN `id` INT)  BEGIN
	CASE tipo 
		WHEN 'L' THEN
			SELECT codigo_pro, nombre_pro
			FROM provincia
			WHERE estado_pro=1
				and codigo_dep=id
			ORDER BY nombre_pro;

		
	END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarSerieDocumento` (IN `tipo` VARCHAR(20), IN `id` INT)  BEGIN
	CASE tipo 
		WHEN 'L' THEN
			SELECT ser.codigo_ser as codigo, tdo.nombre_tdo, ser.serie_ser, ser.numero_ser, suc.nombre_suc
			FROM seriedocumento ser inner join
				tipodocumento tdo on tdo.codigo_tdo=ser.codigo_tdo inner join
				sucursal suc on suc.codigo_suc=ser.codigo_suc
			WHERE ser.estado_ser=1
				and tdo.sistema=0
                and tdo.estado_tdo=1
				and ser.sistema=0
			order by tdo.nombre_tdo;

		WHEN 'E' THEN
			SELECT ser.codigo_ser as codigo, ser.codigo_tdo, ser.serie_ser, ser.numero_ser, ser.codigo_suc
			FROM seriedocumento ser 
			WHERE ser.estado_ser=1
				and ser.sistema=0
				and ser.codigo_ser=id;
			

/*
		WHEN 'T' THEN
			SELECT 0 AS codigo_lin, '<<   TODOS   >>' AS nombre_lin
            UNION
			SELECT codigo_lin,
				nombre_lin
			FROM linea
			WHERE estado_lin=1
			ORDER BY nombre_lin;            
*/            
	END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarSerieDocumentos` (IN `tipo` VARCHAR(20), IN `id` INT)  BEGIN
	CASE tipo 
		WHEN 'L' THEN
			
			SELECT ser.codigo_ser as codigo, tdo.nombre_tdo, ser.serie_ser, ser.numero_ser, suc.nombre_suc
			FROM seriedocumento ser inner join
				tipodocumento tdo on tdo.codigo_tdo=ser.codigo_tdo inner join
				sucursal suc on suc.codigo_suc=ser.codigo_suc
			WHERE ser.estado_ser=1
			order by tdo.nombre_tdo;

		WHEN 'E' THEN
			SELECT ser.codigo_ser as codigo, tdo.nombre_tdo, ser.serie_ser, ser.numero_ser, suc.nombre_suc
			FROM seriedocumento ser inner join
				tipodocumento tdo on tdo.codigo_tdo=ser.codigo_tdo inner join
				sucursal suc on suc.codigo_suc=ser.codigo_suc
			WHERE ser.estado_ser=1
				and ser.codigo_ser=id
			order by tdo.nombre_tdo;

/*
		WHEN 'T' THEN
			SELECT 0 AS codigo_lin, '<<   TODOS   >>' AS nombre_lin
            UNION
			SELECT codigo_lin,
				nombre_lin
			FROM linea
			WHERE estado_lin=1
			ORDER BY nombre_lin;            
*/            
	END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarSucursal` (IN `tipo` VARCHAR(20), IN `id` INT)  BEGIN
	CASE tipo 
		WHEN 'L' THEN
			SELECT s.codigo_suc, s.nombre_suc, s.direccion_suc
			FROM sucursal s
			WHERE s.estado_suc=1
			order by s.nombre_suc;

		WHEN 'E' THEN
			SELECT s.codigo_suc, s.nombre_suc, s.direccion_suc
			FROM sucursal s
			WHERE s.estado_suc=1
				and s.codigo_suc=id
			order by s.nombre_suc;

		WHEN 'T' THEN
			select 0 AS codigo_suc, '<<   TODOS   >>' AS nombre_suc, '' AS direccion_suc
            UNION
            SELECT s.codigo_suc, s.nombre_suc, s.direccion_suc
			FROM sucursal s
			WHERE s.estado_suc=1
			order by 1;
            
	END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarTipoCambio` (IN `tipo` VARCHAR(20), IN `id` INT, IN `anio` INT, IN `mes` INT)  BEGIN
	CASE tipo 
		WHEN 'L' THEN
			SELECT codigo_tic, fecha_tic, format(cambioCompra_tic,4) as cambioCompra_tic, format(cambioVenta_tic,4) as cambioVenta_tic            
			FROM tipocambio
			WHERE estado_tic=1
				and year(fecha_tic)=anio
                and month(fecha_tic)=mes
			ORDER BY fecha_tic;

		WHEN 'E' THEN
			SELECT codigo_tic, fecha_tic, cambioCompra_tic, cambioVenta_tic
			FROM tipocambio
			WHERE estado_tic=1
				and codigo_tic=id
			ORDER BY fecha_tic;
       
       WHEN 'A' THEN
			SELECT distinct  year(fecha_tic) as id, year(fecha_tic) as anio
			FROM tipocambio
			WHERE estado_tic=1
			group by year(fecha_tic)
			ORDER BY fecha_tic;

		WHEN 'M' THEN
			SELECT distinct month(fecha_tic) as id,
				case  month(fecha_tic) 
					when 1 then 'ENERO' 
					when 2 then 'FEBRERO' 
					when 3 then 'MARZO' 
					when 4 then 'ABRIL' 
					when 5 then 'MAYO' 
					when 6 then 'JUNIO' 
					when 7 then 'JULIO' 
					when 8 then 'AGOSTO' 
					when 9 then 'SETIEMBRE' 
					when 10 then 'OCTUBRE' 
					when 11 then 'NOVIEMBRE' 
					when 12 then 'DICIEMBRE' 
				end AS nombreMes
			FROM tipocambio
			WHERE estado_tic=1
				and year(fecha_tic)=anio
			ORDER BY fecha_tic;
	

	END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarTipoDocumento` (IN `tipo` VARCHAR(20), IN `id` INT, IN `accion` VARCHAR(10))  BEGIN
	CASE tipo 
	WHEN 'L' THEN
		SELECT codigo_tdo, nombre_tdo, abreviatura_tdo, IFNULL(codigosunat_tdo,'') AS codigosunat_tdo, IFNULL(tipo_tdo,'') AS tipo_tdo
		FROM tipodocumento 
		WHERE estado_tdo=1
			and sistema=0
		order by nombre_tdo;

	WHEN 'E' THEN
		SELECT codigo_tdo, nombre_tdo, abreviatura_tdo, codigosunat_tdo, IFNULL(tipo_tdo,'') AS tipo_tdo
		FROM tipodocumento 
		WHERE estado_tdo=1
			and codigo_tdo=id
            and sistema=0
		order by nombre_tdo;

	WHEN 'B' THEN
		SELECT codigo_tdo, nombre_tdo, abreviatura_tdo, codigosunat_tdo, tipo_tdo
		FROM tipodocumento 
		WHERE estado_tdo=1
			and sistema=0
			AND tipo_tdo COLLATE utf8_general_ci LIKE CONCAT('%', accion, '%');
        
	END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarTipoMovimiento` (IN `tipo` VARCHAR(20), IN `id` INT)  BEGIN
	SELECT codigo_tmo, nombre_tmo
	FROM tipomovimiento
	ORDER BY nombre_tmo desc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarTipoPersona` (IN `tipo` VARCHAR(20), IN `id` INT)  BEGIN
	CASE tipo 
		WHEN 'L' THEN
			SELECT codigo_tip, nombre_tip
			FROM tipopersona
			WHERE estado_tip=1
			order by nombre_tip;

		WHEN 'E' THEN
			SELECT codigo_tip, nombre_tip
			FROM tipopersona
			WHERE estado_tip=1
				and codigo_tip=id 
			order by nombre_tip;
            
		WHEN 'T' THEN
			select 0 AS codigo_tip, '<<   TODOS   >>' AS nombre_tip
            UNION
            SELECT codigo_tip, nombre_tip
			FROM tipopersona
			WHERE estado_tip=1
			order by 1;
            
	END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarTransferenciaCuenta` (IN `tipo` VARCHAR(1), IN `id` INT, IN `sucursal` INT)  BEGIN
	CASE tipo 
		WHEN 'L' THEN
			select origen.codigo_moc, origen.fecha_moc, origen.recibo_moc, cta_origen.nombre_cta as ctaOrigen, 
				cta_destino.nombre_cta as ctaDestino, origen.importe_moc, origen.detalle_moc
			from movimientoCliente origen inner join	##Origen
				cuenta cta_origen on cta_origen.codigo_cta=origen.codigo_cta left join 
				movimientoCliente destino on destino.referencia_moc=origen.codigo_moc  inner join		##Destino
				cuenta cta_destino on cta_destino.codigo_cta=destino.codigo_cta
			where origen.codigo_con=4 		##Concepto transferencia
				and origen.estado_moc=1
				and origen.tipo_moc = 'C'
				and origen.codigo_suc=sucursal
			order by origen.fecha_moc, origen.codigo_moc;

		WHEN 'E' THEN
            select origen.codigo_moc, origen.fecha_moc, origen.recibo_moc, origen.codigo_cta as ctaOrigen, 
				destino.codigo_cta as ctaDestino, origen.importe_moc, origen.detalle_moc, origen.codigo_suc,
                destino.codigo_moc as codigoDestino, destino.codigo_suc as codigosuc_destino, suc.nombre_suc as sucursaldestino
			from movimientoCliente origen inner join	##Origen
				cuenta cta_origen on cta_origen.codigo_cta=origen.codigo_cta left join 
				movimientoCliente destino on destino.referencia_moc=origen.codigo_moc  inner join		##Destino
				cuenta cta_destino on cta_destino.codigo_cta=destino.codigo_cta inner join
                sucursal suc on suc.codigo_suc=destino.codigo_suc
			where origen.codigo_con=4 		##Concepto transferencia
				and origen.estado_moc=1
				and origen.tipo_moc = 'C'
				and origen.codigo_moc=id
			order by origen.fecha_moc, origen.codigo_moc;
            
	END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarUnidad` (IN `tipo` VARCHAR(20), IN `id` INT)  BEGIN
CASE tipo 
WHEN 'L' THEN

SELECT codigo_uni,nombre_uni,abreviatura_uni
FROM unidad 
WHERE estado_uni=1
ORDER BY nombre_uni;

WHEN 'E' THEN

SELECT codigo_uni,nombre_uni,abreviatura_uni
FROM unidad
WHERE estado_uni=1 AND
codigo_uni=id
ORDER BY nombre_uni;

END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarVenta` (IN `tipo` VARCHAR(20), IN `codigo_vta` INT, IN `fecha_ini` VARCHAR(10), IN `fecha_fin` VARCHAR(10), IN `codigo_cli` INT, IN `codigo_suc` INT)  BEGIN
	DECLARE todosCliente VARCHAR(10);
    DECLARE todosSucursal VARCHAR(10);
    
	SET todosCliente = if(codigo_cli=0,'%',codigo_cli);
	SET todosSucursal = if(codigo_suc=0,'%',codigo_suc);
    
	CASE tipo 
		WHEN 'L' THEN
			select vta.codigo_vta, CONCAT (tdo.abreviatura_tdo, '', vta.serie_vta , '-', vta.numero_vta) as documento,  
				vta.fecha_vta as fecha, cli.nombre_cli as cliente,
				cod.nombre_cod as condicion, mon.nombre_mon as moneda, vta.total_vta as importe
			from venta vta inner join
				venta_detalle det on det.codigo_vta=vta.codigo_vta  inner join
				tipodocumento tdo on tdo.codigo_tdo=vta.codigo_tdo inner join
				cliente cli on cli.codigo_cli=vta.codigo_cli inner join
				moneda mon on mon.codigo_mon=vta.codigo_cod inner join
				condicion cod on cod.codigo_cod=vta.codigo_cod
			where vta.fecha_vta between fecha_ini and fecha_fin
				and vta.codigo_suc like todosSucursal
                and vta.codigo_cli like todosCliente
			group by
				tdo.nombre_tdo, vta.serie_vta, vta.numero_vta, vta.fecha_vta, cli.nombre_cli, vta.total_vta,
				mon.nombre_mon, cod.nombre_cod, vta.codigo_vta;
                
				
		WHEN 'E' THEN
			select    
				m.codigo_moc,
				m.codigo_suc,
				suc.nombre_suc,
				m.codigo_tdo,
				tdo.nombre_tdo,
				m.serie_moc,
				m.numero_moc,
				m.codigo_cli,
				c.nombre_cli,
				m.fecha_moc,
				m.importe_moc,
				m.fechaVencimiento_moc,
				m.codigo_mon,
				mon.nombre_mon,
				m.detalle_moc,
				m.dolar_moc,
				m.codigo_ven
			from     
				movimientocliente m inner join 
				cliente c ON (m.codigo_cli=c.codigo_cli)   inner join
				tipodocumento tdo on tdo.codigo_tdo=m.codigo_tdo inner join
				moneda mon on mon.codigo_mon=m.codigo_mon inner join
				sucursal suc on suc.codigo_suc=m.codigo_suc
			where m.estado_moc=1
				and m.codigo_moc=codigo_moc;
	
	END CASE;
        
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_productos` (IN `gama` VARCHAR(50))  BEGIN
	select    
		m.codigo_mop, 
		m.fecha_mop,
		CONCAT(tdo.abreviatura_tdo ,'.', m.serie_mop , '-',  m.numero_mop) as documento,
		p.nombre_pro,
		mon.abreviatura_mon as moneda,
		m.importe_mop
	from     
		MovimientoProveedor m inner join 
		proveedor p ON (m.codigo_pro=p.codigo_pro)   inner join
		tipodocumento tdo on tdo.codigo_tdo=m.codigo_tdo inner join
		moneda mon on mon.codigo_mon=m.codigo_mon
	where m.estado_mop=1    
		and m.tipo_mop='P'    
		and m.codigo_con=1
		and date_format(m.fecha_mop, "%d/%m/%Y") between '01/06/2022' and '11/07/2023';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerNroRecibo` (IN `tipo` VARCHAR(20), IN `codigo_cta` INT)  BEGIN
	CASE tipo 
		WHEN 'I' THEN

		select CONCAT(LPAD(cta.codigo_cta, 3, '0'), '', '-I', '', LPAD(cta.serie_ing + 1, 5, '0'))	as recibo
		from cuenta cta
		where cta.codigo_cta=codigo_cta
			and cta.estado_cta=1;

		WHEN 'E' THEN

		select CONCAT(LPAD(cta.codigo_cta, 3, '0'), '', '-E', '', LPAD(cta.serie_egr + 1, 5, '0'))	as recibo
		from cuenta cta
		where cta.codigo_cta=codigo_cta
			and cta.estado_cta=1;
        
	END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerNrotransferencia` (IN `tipo` VARCHAR(20), IN `codigo_suc` INT)  BEGIN
	select CONCAT(abreviatura_tdo, '','-','', LPAD(sdo.numero_ser + 1, 6, '0'))	as recibo 
	from tipodocumento tdo inner join
		serieDocumento sdo on sdo.codigo_tdo=tdo.codigo_tdo
	where tdo.codigo_tdo=1
		and sdo.estado_ser=1
        and tdo.sistema	=1
		and sdo.codigo_suc=codigo_suc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerTipoCambio` (IN `tipo` VARCHAR(1), IN `fecha` DATE)  BEGIN
	CASE tipo 
		WHEN 'C' THEN
			SELECT format(cambioCompra_tic,4) as tipocambio      
			FROM tipocambio
			WHERE estado_tic=1
				and fecha_tic=fecha
			ORDER BY fecha_tic;

		WHEN 'V' THEN
			SELECT format(cambioVenta_tic,4) as tipocambio            
			FROM tipocambio
			WHERE estado_tic=1
				and fecha_tic=fecha
			ORDER BY fecha_tic;
            
	END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarMovimientoCaja` (IN `codigo` INT, IN `codigo_suc` INT, IN `codigo_pso` INT, IN `fecha` DATE, IN `importe` DECIMAL(12,2), IN `saldo` DECIMAL(12,2), IN `tipo` VARCHAR(1), IN `cuenta` INT, IN `recibo` VARCHAR(10), IN `codigo_mon` INT, IN `detalle` VARCHAR(1000), IN `codigo_con` INT, IN `fechaVencimiento` DATE, IN `dolar` DECIMAL(10,4), IN `codigo_ven` INT, IN `usuario` INT, IN `TipoMovimiento` VARCHAR(1), IN `persona` INT)  BEGIN
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
		SET SQL_SAFE_UPDATES = 0;
		
		IF codigo = 0 THEN	##Registrar
			SET @moneda := (SELECT cta.codigo_mon FROM cuenta cta WHERE cta.codigo_cta = codigo_cta LIMIT 1);
            
			IF persona = 0 OR persona = 1 THEN	##Cliente
				insert into movimientocliente(codigo_suc, codigo_cli, fecha_moc, importe_moc, saldo_moc, tipo_moc, codigo_cta, recibo_moc,  
					codigo_mon, detalle_moc, codigo_con, fechaVencimiento_moc, dolar_moc, codigo_ven, codigo_szo, codigo_zon, usuario_reg)
				values(codigo_suc, codigo_pso, fecha, importe, saldo, tipo, cuenta, recibo,  
					@moneda, detalle, codigo_con, fechaVencimiento, dolar, codigo_ven, 1, 1, usuario);
					
				SELECT LAST_INSERT_ID() INTO id;
				SET Mensaje = 'Movimiento registrado correctamente';
            
			ELSE	##Proveedor
           
				insert into movimientoproveedor(codigo_suc, codigo_pro, fecha_mop, importe_mop, saldo_mop, tipo_mop, codigo_cta, recibo_mop,
					codigo_mon, detalle_mop, codigo_con, fechaVencimiento_mop, dolar_mop, usuario_reg)
				values(codigo_suc, codigo_pso, fecha, importe, saldo, tipo, cuenta, recibo,  
					@moneda, detalle, codigo_con, fechaVencimiento, dolar, usuario);

				SELECT LAST_INSERT_ID() INTO id;
				SET Mensaje = 'Movimiento registrado correctamente';
                
            END IF;
            
            IF TipoMovimiento='I' THEN 		##Ingreso
				update cuenta set serie_ing = serie_ing + 1 where codigo_cta = cuenta;
			ELSE		##Pago
				update cuenta set serie_egr = serie_egr + 1 where codigo_cta = cuenta;
			END IF;
		
        ELSE	##Modificar
			IF persona = 0 OR persona = 1 THEN	##Cliente
				UPDATE movimientocliente
                SET codigo_suc=codigo_suc, 
					codigo_cli=codigo_pso, 
                    fecha_moc=fecha, 
                    importe_moc=importe, 
                    saldo_moc=saldo, 
                    tipo_moc=tipo, 
                    codigo_cta=cuenta, 
                    recibo_moc=recibo,  
                    codigo_mon=codigo_mon, 
                    detalle_moc=detalle, 
                    codigo_con=codigo_con, 
                    fechaVencimiento_moc=fechaVencimiento, 
                    dolar_moc=dolar, 
                    codigo_ven=codigo_ven, 
                    codigo_szo=1, 
                    codigo_zon=1, 
                    usuario_mod=usuario
				WHERE 
                    codigo_moc=codigo;
                    
                    SET Mensaje = 'Movimiento de cliente actualizado correctamente';
                    
            ELSE	##Proveedor
            
            
				UPDATE movimientoproveedor
				SET codigo_suc=codigo_suc, 
					codigo_pro=codigo_pso, 
					fecha_mop=fecha, 
					importe_mop=importe, 
					saldo_mop=saldo, 
					tipo_mop=tipo, 
					codigo_cta=cuenta, 
					recibo_mop=recibo,
					codigo_mon=codigo_mon, 
					detalle_mop=detalle, 
					codigo_con=codigo_con, 
					fechaVencimiento_mop=fechaVencimiento, 
					dolar_mop=dolar, 
					usuario_mod=usuario
				WHERE
					codigo_mop=codigo;
                    
                    SET Mensaje = 'Movimiento de proveedor actualizado correctamente';
                    
			END IF;
			
			 SET id=codigo;
			 
		
		END IF;
        
	COMMIT;
    SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarTransferencia` (IN `codigo` INT, IN `codigo_suc` INT, IN `fecha` DATE, IN `importe` DECIMAL(12,2), IN `saldo` DECIMAL(12,2), IN `codigo_cta_origen` INT, IN `codigo_cta_destino` INT, IN `recibo` VARCHAR(10), IN `detalle` VARCHAR(1000), IN `fechaVencimiento` DATE, IN `dolar` DECIMAL(10,4), IN `codigo_ven` INT, IN `codigo_Destino` INT, IN `codigosuc_Destino` INT, IN `usuario` INT)  BEGIN
	
    DECLARE id int DEFAULT 0;
    DECLARE mensaje varchar(500) DEFAULT '';
    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MENSAJE = MESSAGE_TEXT;
		SELECT 0 AS Respuesta,  CONCAT('MySQL ERROR: ', @ERRNO, ': ', @MENSAJE) as Mensaje;
		ROLLBACK;
    END;
	START TRANSACTION;
		SET SQL_SAFE_UPDATES = 0;

		SET @moneda_codigo_cta_origen := (select codigo_mon from cuenta where codigo_cta=codigo_cta_origen);
		SET @moneda_codigo_cta_destino := (select codigo_mon from cuenta where codigo_cta=codigo_cta_destino);
            
		IF codigo = 0 THEN	##Registrar
			insert into movimientocliente(codigo_suc, fecha_moc, importe_moc, saldo_moc, tipo_moc, codigo_cta, recibo_moc,  
				codigo_mon, detalle_moc, codigo_con, fechaVencimiento_moc, dolar_moc, codigo_ven, codigo_szo, codigo_zon, usuario_reg)
			values(codigo_suc, fecha, importe, saldo, 'C', codigo_cta_origen, recibo,  
				@moneda_codigo_cta_origen, detalle, 4, fechaVencimiento, dolar, codigo_ven, 1,1,usuario);

			SELECT LAST_INSERT_ID() INTO id;
			SET Mensaje = 'Transferencia registrada correctamente';

			insert into movimientocliente(codigo_suc, fecha_moc, importe_moc, saldo_moc, tipo_moc, codigo_cta, recibo_moc,  
				codigo_mon, detalle_moc, codigo_con, fechaVencimiento_moc, dolar_moc, codigo_ven, codigo_szo, codigo_zon, 
                usuario_reg, referencia_moc)
			values(codigosuc_Destino, fecha, importe, saldo, 'P', codigo_cta_destino, recibo,  
				@moneda_codigo_cta_destino, detalle, 4, fechaVencimiento, dolar, codigo_ven, 1,1,
                usuario, id);

			##Transferencia
			update seriedocumento set numero_ser = numero_ser + 1 where codigo_tdo=1 and codigo_suc=codigo_suc and estado_ser=1;
                        
        ELSE	##Modificar
             UPDATE movimientocliente 
             SET codigo_suc = codigo_suc, 
				fecha_moc = fecha, 
                importe_moc = importe, 
                saldo_moc = importe, 
                codigo_cta = codigo_cta_origen, 
                recibo_moc = recibo,  
				codigo_mon = @moneda_codigo_cta_origen, 
                detalle_moc = detalle, 
                fechaVencimiento_moc = fechaVencimiento, 
                dolar_moc = dolar, 
                codigo_ven = codigo_ven, 
                usuario_mod = usuario                
			WHERE codigo_moc = codigo;
            
             UPDATE movimientocliente 
             SET codigo_suc = codigosuc_Destino, 
				fecha_moc = fecha, 
                importe_moc = importe, 
                saldo_moc = importe, 
                codigo_cta = codigo_cta_destino, 
                recibo_moc = recibo,  
				codigo_mon = @moneda_codigo_cta_destino, 
                detalle_moc = detalle, 
                fechaVencimiento_moc = fechaVencimiento, 
                dolar_moc = dolar, 
                codigo_ven = codigo_ven, 
                usuario_mod = usuario
			WHERE codigo_moc = codigo_Destino;
  
			SET id=codigo;
			SET Mensaje = 'Movimiento actualizado correctamente';
		
		END IF;
        
	COMMIT;
    SELECT id as Respuesta, mensaje as Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `saldosCuentas` (IN `fecha_ini` VARCHAR(10), IN `codigo_suc` INT)  BEGIN
	SELECT 
		DISTINCT cuenta.codigo_cta
		,cuenta.nombre_cta
		,banco.nombre_ban AS banco
        
        ,format((COALESCE(SUM(CASE mov_clie.codigo_mon WHEN 1 THEN (CASE mov_clie.tipo_moc WHEN 'P' THEN coalesce(mov_clie.importe_moc,0) ELSE coalesce(mov_clie.importe_moc,0) * (-1) END) END),0) + (coalesce(movprov.importe_soles,0)) - (coalesce(movp_s.importe_soles,0))),2) as soles
        ,format((COALESCE(SUM(CASE mov_clie.codigo_mon WHEN 2 THEN (CASE mov_clie.tipo_moc WHEN 'P' THEN coalesce(mov_clie.importe_moc,0) ELSE coalesce(mov_clie.importe_moc,0) * (-1) END) END),0) - (coalesce(movp_d.importe_dolar,0))),2) as dolar	
        
        
		##,(COALESCE(SUM(CASE mov_clie.codigo_mon WHEN 1 THEN (CASE mov_clie.tipo_moc WHEN 'P' THEN coalesce(mov_clie.importe_moc,0) ELSE coalesce(mov_clie.importe_moc,0) * (-1) END) END),0) + (coalesce(movprov.importe_soles,0)) - (coalesce(movp_s.importe_soles,0))) as soles
		##,(COALESCE(SUM(CASE mov_clie.codigo_mon WHEN 2 THEN (CASE mov_clie.tipo_moc WHEN 'P' THEN coalesce(mov_clie.importe_moc,0) ELSE coalesce(mov_clie.importe_moc,0) * (-1) END) END),0) - (coalesce(movp_d.importe_dolar,0))) as dolar	
        ##,mov_clie.codigo_mon
	FROM cuenta
	INNER JOIN banco ON (cuenta.codigo_ban = banco.codigo_ban)
	LEFT OUTER JOIN movimientocliente mov_clie ON (mov_clie.codigo_cta = cuenta.codigo_cta)
	LEFT OUTER JOIN (
		SELECT sum(mov_prov.importe_mop) AS importe_soles
			,mov_prov.codigo_suc
			,mov_prov.codigo_cta
		FROM movimientoproveedor mov_prov
		WHERE mov_prov.tipo_mop = 'C'
			AND mov_prov.codigo_mon = 1	##'S'
			AND mov_prov.fecha_mop <= fecha_ini
            AND mov_prov.estado_mop=1
		GROUP BY mov_prov.codigo_suc
			,mov_prov.codigo_cta
		) AS movp_s ON (movp_s.codigo_suc = mov_clie.codigo_suc AND movp_s.codigo_cta = mov_clie.codigo_cta)
	LEFT OUTER JOIN (
		SELECT sum(mov_prov.importe_mop) AS importe_soles
			,mov_prov.codigo_suc
			,mov_prov.codigo_cta
		FROM movimientoproveedor mov_prov
		WHERE mov_prov.tipo_mop = 'P'
			AND mov_prov.codigo_mon = 1	##'S'
			AND mov_prov.fecha_mop <= fecha_ini
            AND mov_prov.estado_mop=1
		GROUP BY mov_prov.codigo_suc
			,mov_prov.codigo_cta
		) AS movprov ON (movprov.codigo_suc = mov_clie.codigo_suc AND movprov.codigo_cta = mov_clie.codigo_cta)
	LEFT OUTER JOIN (
		SELECT coalesce(sum(mov_prov.importe_mop), 0) AS importe_dolar
			,mov_prov.codigo_suc
			,mov_prov.codigo_cta
		FROM movimientoproveedor mov_prov
		WHERE mov_prov.tipo_mop = 'C'
			AND mov_prov.codigo_mon = 2	##'D'
			AND mov_prov.fecha_mop <= fecha_ini
            AND mov_prov.estado_mop=1
		GROUP BY mov_prov.codigo_suc
			,mov_prov.codigo_cta
		) AS movp_d ON (movp_d.codigo_suc = mov_clie.codigo_suc AND movp_d.codigo_cta = mov_clie.codigo_cta)
	WHERE mov_clie.codigo_suc LIKE codigo_suc
		AND mov_clie.fecha_moc <= fecha_ini
        AND mov_clie.estado_moc=1
	GROUP BY cuenta.codigo_cta
		,cuenta.nombre_cta
		,banco.nombre_ban
		,mov_clie.codigo_mon
		,movprov.importe_soles
		,movp_s.importe_soles
		,movp_d.importe_dolar
		,cuenta.codigo_suc;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulo`
--

CREATE TABLE `articulo` (
  `codigo_art` int(11) NOT NULL,
  `nombre_art` varchar(500) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `abreviatura_art` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `codigobarra_art` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `codigoproveedor_art` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `codigo_mar` int(11) NOT NULL,
  `codigo_lin` int(11) DEFAULT NULL,
  `unidadm_art` varchar(10) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `tipoimpuesto_art` varchar(1) COLLATE utf8_spanish_ci DEFAULT NULL,
  `precio_art` decimal(12,4) DEFAULT '0.0000',
  `costo_art` decimal(12,4) DEFAULT '0.0000',
  `costogasto_art` decimal(12,4) DEFAULT '0.0000',
  `preciomayorista_art` decimal(12,4) DEFAULT '0.0000',
  `stockmin_art` int(11) DEFAULT '0',
  `stockmax_art` int(11) DEFAULT '0',
  `descontinuado_art` int(11) DEFAULT NULL,
  `estado_art` int(11) DEFAULT '1',
  `usuario_reg` int(11) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_mod` int(11) DEFAULT NULL,
  `fecha_mod` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `articulo`
--

INSERT INTO `articulo` (`codigo_art`, `nombre_art`, `abreviatura_art`, `codigobarra_art`, `codigoproveedor_art`, `codigo_mar`, `codigo_lin`, `unidadm_art`, `tipoimpuesto_art`, `precio_art`, `costo_art`, `costogasto_art`, `preciomayorista_art`, `stockmin_art`, `stockmax_art`, `descontinuado_art`, `estado_art`, `usuario_reg`, `usuario_mod`, `fecha_mod`) VALUES
(1, 'ATOMIZADOR CIFARELLI L3EDA', 'L3EDA', '', 'L3EDA', 1, 1, 'UND', 'G', '2500.0000', '0.0000', '0.0000', '2250.0000', 2, 50, NULL, 1, NULL, NULL, NULL),
(2, 'ACEITE CIFARELLI 2T OLIOTEC 1LT', 'ACEITE 1LT', '', 'HO1LSS2', 10, 10, 'UND', 'G', '24.0000', '0.0000', '0.0000', '24.0000', 5, 100, NULL, 1, NULL, NULL, NULL),
(3, 'ACEITE CIFARELLI 2T OLIOTEC 1GAL', 'ACEITE 1 GL', '', 'HO1GSS2', 10, 10, 'UND', 'G', '100.0000', '0.0000', '0.0000', '95.0000', 5, 100, NULL, 1, NULL, NULL, NULL),
(4, 'ACEITE CIFARELLI 2T OLIOTEC 19L', 'ACEITE 1 BAL', '', 'HO19LS2', 10, 10, 'UND', 'G', '390.0000', '0.0000', '0.0000', '390.0000', 1, 5, NULL, 1, NULL, NULL, NULL),
(5, 'PISTON COMPLETO', 'PISTON CIF', '', '0G01900', 11, 11, 'UND', 'G', '225.0000', '0.0000', '0.0000', '225.0000', 2, 20, NULL, 1, NULL, NULL, NULL),
(6, 'RESORTE AUTOENVOLVENTE Y PLATO', 'WINCHA', '', '0G03300', 11, 11, 'UND', 'G', '65.0000', '0.0000', '0.0000', '65.0000', 2, 20, NULL, 1, NULL, NULL, NULL),
(7, 'PANTALLA DE ALUMINIO CON JUNTAS', 'PATALLA', '', '0G13300', 11, 11, 'UND', 'G', '45.0000', '0.0000', '0.0000', '37.0000', 2, 10, NULL, 1, NULL, NULL, NULL),
(8, 'BASE DE FILTRO DE AIRE (CARB. WALBRO)', 'BASE', '', '0G21200', 11, 11, 'UND', 'G', '55.0000', '0.0000', '0.0000', '55.0000', 2, 20, NULL, 1, NULL, NULL, NULL),
(9, 'TANQUE DE COMBUSTIBLE - CARB. WALBRO -', 'TANQUE GAS', '', '0G21600', 11, 11, 'UND', 'G', '178.0000', '0.0000', '0.0000', '178.0000', 2, 5, NULL, 1, NULL, NULL, NULL),
(10, 'KIT DE CAJA DE ARRANQUE COMPLETA C7', 'CAJA ARRANQUE', '', '0G22101', 11, 11, 'UND', 'G', '198.0000', '0.0000', '0.0000', '198.0000', 2, 5, NULL, 1, NULL, NULL, NULL),
(11, 'BASE DE FILTRO CON PALANCA CHOKE (CARB. WALBRO)', 'BASE FILTRO', '', '0G26700', 11, 11, 'UND', 'G', '55.0000', '0.0000', '0.0000', '55.0000', 2, 20, NULL, 1, NULL, NULL, NULL),
(12, 'KIT PARA POLVOS Y GRANULADOS', 'KIT POLVOS', '', '0G27200', 11, 11, 'UND', 'G', '65.0000', '0.0000', '0.0000', '65.0000', 2, 5, NULL, 1, NULL, NULL, NULL),
(13, 'BOBINA ELECTRONICA', 'BOBINA CIF', '', '0G27701', 11, 11, 'UND', 'G', '220.0000', '0.0000', '0.0000', '220.0000', 2, 20, NULL, 1, NULL, NULL, NULL),
(14, 'TANQUE DE LIQUIDOS L. 17 + KIT', 'TANQUE LIQUIDOS', '', '0G28700', 11, 11, 'UND', 'G', '242.0000', '0.0000', '0.0000', '242.0000', 1, 5, NULL, 1, NULL, NULL, NULL),
(15, 'KIT DE CILINDRO COMPLETO C7 - CARB. WALBRO -', 'CILINDRO', '', '0G31000', 11, 11, 'UND', 'G', '725.0000', '0.0000', '0.0000', '725.0000', 1, 5, NULL, 1, NULL, NULL, NULL),
(16, 'CIGÜEÑAL COMPLETO', 'CIGUEÑAL', '', '200103', 11, 11, 'UND', 'G', '596.0000', '0.0000', '0.0000', '596.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(17, 'ANILLO DE PISTON', 'ANILLOS', '', '300300', 11, 11, 'UND', 'G', '27.0000', '0.0000', '0.0000', '27.0000', 5, 20, NULL, 1, NULL, NULL, NULL),
(18, 'JUNTA DE CILINDRO REINZ (REINZ AFM 34)', 'JUNTA CILINDRO', '', '400203', 11, 11, 'UND', 'G', '16.5000', '0.0000', '0.0000', '16.5000', 2, 20, NULL, 1, NULL, NULL, NULL),
(19, 'PANTALLA DE ALUMINIO CON JUNTAS', 'JUNTA PANTALLA', '', 'OG13300', 11, 11, 'UND', 'G', '37.0000', '0.0000', '0.0000', '37.0000', 2, 20, NULL, 1, NULL, NULL, NULL),
(20, 'JUNTA CARBURADOR', 'JUNTA WYJ', '', '403000', 11, 11, 'UND', 'G', '2.5000', '0.0000', '0.0000', '2.5000', 5, 20, NULL, 1, NULL, NULL, NULL),
(21, 'TUBO DE ESCAPE C7', 'ESCAPE', '', '503900', 11, 11, 'UND', 'G', '165.0000', '0.0000', '0.0000', '165.0000', 2, 5, NULL, 1, NULL, NULL, NULL),
(22, 'JUNTA TUBO DE ESCAPE C7 - NUEVO', 'JUNTA ESCAPE', '', '504800', 11, 11, 'UND', 'G', '16.5000', '0.0000', '0.0000', '16.5000', 5, 20, NULL, 1, NULL, NULL, NULL),
(23, 'FILTRO DE ESPONJA 97', '609900', '', '609900', 11, 11, 'UND', 'G', '20.0000', '0.0000', '0.0000', '18.0000', 5, 20, NULL, 1, NULL, NULL, NULL),
(24, 'CARBURADOR WALBRO WYJ - SIN CHOKE -', 'CARB. WALBRO', '', '611701', 11, 11, 'UND', 'G', '222.0000', '0.0000', '0.0000', '221.0000', 2, 20, NULL, 1, NULL, NULL, NULL),
(25, 'FILTRO DE COMBUSTIBLE', 'FILTRO GAS', '', '', 11, 11, 'UND', 'G', '35.0000', '0.0000', '0.0000', '35.0000', 5, 50, NULL, 1, NULL, NULL, NULL),
(26, 'RESORTE DE TRINQUETE', 'PALANQUITA', '', '801201', 11, 11, 'UND', 'G', '6.3000', '0.0000', '0.0000', '6.3000', 2, 20, NULL, 1, NULL, NULL, NULL),
(27, 'POLEA AUTOENVOLVENTE C7', 'POLEA', '', '1200600', 11, 11, 'UND', 'G', '65.0000', '0.0000', '0.0000', '50.0000', 2, 20, NULL, 1, NULL, NULL, NULL),
(28, 'AMORTIGUADOR', 'AMORTIGUADOR', '', '1204700', 11, 11, 'UND', 'G', '22.0000', '0.0000', '0.0000', '22.0000', 4, 20, NULL, 1, NULL, NULL, NULL),
(29, 'TUBO FLEXIBLE EDA', 'ACORDION', '', '2000801', 11, 11, 'UND', 'G', '90.0000', '0.0000', '0.0000', '74.0000', 2, 20, NULL, 1, NULL, NULL, NULL),
(30, 'BOQUILLA L80', 'L80', '', '2109300', 11, 11, 'UND', 'G', '14.0000', '0.0000', '0.0000', '14.0000', 2, 20, NULL, 1, NULL, NULL, NULL),
(31, 'BASTIDOR L80 (DOBLE PLACA)', 'CHASIS', '', '2101600', 11, 11, 'UND', 'G', '180.0000', '0.0000', '0.0000', '165.0000', 1, 5, NULL, 1, NULL, NULL, NULL),
(32, 'MANGUERA ASPIRACION DE MEZCLA (CARB. WALBRO)', 'MANGUERA GAS', '', '2111300', 11, 11, 'UND', 'G', '22.0000', '0.0000', '0.0000', '22.0000', 5, 50, NULL, 1, NULL, NULL, NULL),
(33, 'MANGUERA RETORNO DE MEZCLA (CARB. WALBRO)', 'MANGUERA RETO', '', '2111400', 11, 11, 'UND', 'G', '19.0000', '0.0000', '0.0000', '19.0000', 5, 50, NULL, 1, NULL, NULL, NULL),
(34, 'REJILLA DESVIADORA ESFERICA', 'REJILLA', '', '2411300', 11, 11, 'UND', 'G', '8.4000', '0.0000', '0.0000', '8.4000', 5, 20, NULL, 1, NULL, NULL, NULL),
(35, 'CORREAS CIFARELLI (PAR)', 'CORREAS', '', '2413001', 11, 11, 'UND', 'G', '110.0000', '0.0000', '0.0000', '110.0000', 2, 5, NULL, 1, NULL, NULL, NULL),
(36, 'CABLE ACELERADOR - CARB. WALBRO -', 'CABLE ACEL', '', '3400100', 11, 11, 'UND', 'G', '45.0000', '0.0000', '0.0000', '35.0000', 2, 20, NULL, 1, NULL, NULL, NULL),
(37, 'RODAJE 6202 C3', 'RODAJE', '', '4000100', 11, 11, 'UND', 'G', '10.5000', '0.0000', '0.0000', '10.5000', 2, 5, NULL, 1, NULL, NULL, NULL),
(38, 'CAPSULA WYJ (CARB. WALBRO)', 'CEBADOR', '', '8210300', 11, 11, 'UND', 'G', '47.0000', '0.0000', '0.0000', '35.0000', 2, 100, NULL, 1, NULL, NULL, NULL),
(39, 'KIT DE MEMBRANAS WYJ (CARB. WALBRO)', 'DIAFRAGMA', '', '8214101', 11, 11, 'UND', 'G', '110.0000', '0.0000', '0.0000', '90.0000', 5, 100, NULL, 1, NULL, NULL, NULL),
(40, 'MOTOPULVERIZADOR ES 726 X 26 LTS/22.5CC/SHINDAIWA', 'SHINDAIWA', '', '19-03-001-200726', 1, 1, 'UND', 'G', '2400.0000', '0.0000', '0.0000', '2350.0000', 1, 6, NULL, 1, NULL, NULL, NULL),
(41, 'MOTOPULVERIZADORA SHP-800 X 25 LT/22.8CC/ECHO', 'ECHO', '', '18-03-002-000800', 1, 1, 'UND', 'G', '2000.0000', '0.0000', '0.0000', '1900.0000', 2, 6, NULL, 1, NULL, NULL, NULL),
(42, 'PULV. AGRICOLA MANUAL JACTO PICON PJH', 'JACTO 20LT', '', '11-01-001-410000', 2, 2, 'UND', 'G', '370.0000', '0.0000', '0.0000', '350.0000', 5, 100, NULL, 1, NULL, NULL, NULL),
(43, 'PULV. AGRICOLA MANUAL JACTO PJ-16 LTS', 'JACTO 16LT', '', '11-01-006-475938', 2, 2, 'UND', 'G', '270.0000', '0.0000', '0.0000', '260.0000', 2, 12, NULL, 1, NULL, NULL, NULL),
(44, 'FUMIGADORA MANUAL DE 20LTS TIPO MOCHILA   PANTHER', 'PANTHER 20LT', '', 'BAJ1060942', 2, 2, 'UND', 'G', '120.0000', '0.0000', '0.0000', '65.0000', 2, 20, NULL, 1, NULL, NULL, NULL),
(45, 'PULVERIZADORA GAS. 2.4HP T/MOCHILA 2T MARCA: PANTHER', 'AZUFRADORA', '', 'BAJ1060935', 1, 1, 'UND', 'G', '570.0000', '0.0000', '0.0000', '570.0000', 1, 5, NULL, 1, NULL, NULL, NULL),
(46, 'SR 440 ATOMIZADOR', 'SR440', '', '4244-011-2630', 1, 1, 'UND', 'G', '1990.0000', '0.0000', '0.0000', '1950.0000', 1, 10, NULL, 1, NULL, NULL, NULL),
(47, 'SR 420 ATOMIZADOR', 'SR420', '', '4203-011-2615', 1, 1, 'UND', 'G', '1700.0000', '0.0000', '0.0000', '1700.0000', 1, 10, NULL, 1, NULL, NULL, NULL),
(48, 'ACEITE STIHL X 1LTS', 'ACEITE 1LT', '', '0781-319-1000', 10, 10, 'UND', 'G', '30.0000', '0.0000', '0.0000', '25.0000', 2, 100, NULL, 1, NULL, NULL, NULL),
(49, 'KIT MOTOSIERRA STIHL MS250 ESP/CAD/GCAD 45CM 3/8P', 'MS250', '', '1123-200-0878', 4, 4, 'UND', 'G', '950.0000', '0.0000', '0.0000', '945.0000', 1, 6, NULL, 1, NULL, NULL, NULL),
(50, 'MANGUERA A/PRESION 8.5MMX100M 120BAR', 'MANGUERA 8.5', '', 'BAJ3010547', 12, 12, 'UND', 'G', '180.0000', '0.0000', '0.0000', '180.0000', 2, 50, NULL, 1, NULL, NULL, NULL),
(51, 'ELEMENTO DE FILTRO DE AIRE COMP. ST', 'FILTRO AIRE', '', '17211Z0Z000', 11, 11, 'UND', 'G', '20.0000', '0.0000', '0.0000', '20.0000', 5, 50, NULL, 1, NULL, NULL, NULL),
(52, 'BUJIA DE ENCENDIDO (CMR5H) ST', 'BUJIA HONDA', '', '31915Z0H003', 11, 11, 'UND', 'G', '10.5000', '0.0000', '0.0000', '10.5000', 5, 50, NULL, 1, NULL, NULL, NULL),
(53, 'FAJA DE DISTRIBUCION (76ZU6 G-310) ST', 'FAJA DISTR', '', '14400Z3F801', 11, 11, 'UND', 'G', '6.3000', '0.0000', '0.0000', '6.3000', 2, 50, NULL, 1, NULL, NULL, NULL),
(54, 'VALVULA DE ADMISION ST', '14711Z3F000', '', 'ADMISION', 11, 11, 'UND', 'G', '7.3500', '0.0000', '0.0000', '7.3500', 2, 20, NULL, 1, NULL, NULL, NULL),
(55, 'POLEA DE ARBOL DE LEVAS ST', 'ROLDANA', '', '14320Z0Z000', 11, 11, 'UND', 'G', '52.0000', '0.0000', '0.0000', '52.0000', 2, 20, NULL, 1, NULL, NULL, NULL),
(56, 'PISTON (STD) ST', 'PISTON HONDA', '', '13101Z3F000', 11, 11, 'UND', 'G', '33.0000', '0.0000', '0.0000', '33.0000', 2, 20, NULL, 1, NULL, NULL, NULL),
(57, 'TUBO DE TANQUE DE COMBUSTIBLE ST', 'MANGUE HOND GAS', '', '17701Z0Z000', 11, 11, 'UND', 'G', '5.3000', '0.0000', '0.0000', '5.3000', 2, 50, NULL, 1, NULL, NULL, NULL),
(58, 'VALVULA DE ESCAPE ST', 'VALVULA ESC HON', '', '14721Z3F000', 11, 11, 'UND', 'G', '9.5000', '0.0000', '0.0000', '9.5000', 2, 20, NULL, 1, NULL, NULL, NULL),
(59, 'ELEMENTO DE FILTRO DE AIRE COMP. ST 25', 'FILTRO AIRE 25', '', '17211Z0H000', 11, 11, 'UND', 'G', '20.0000', '0.0000', '0.0000', '20.0000', 2, 50, NULL, 1, NULL, NULL, NULL),
(60, 'CUBIERTA DE FILTRO DE AIRE ST', 'TAPA FILTRO', '', '17231Z0Z010', 11, 11, 'UND', 'G', '6.3000', '0.0000', '0.0000', '6.3000', 2, 50, NULL, 1, NULL, NULL, NULL),
(61, 'EMPAQUE DE CARBURADOR ST', 'JUNTA CARB HOND', '', '16221Z0Z000', 11, 11, 'UND', 'G', '3.2000', '0.0000', '0.0000', '3.2000', 2, 50, NULL, 1, NULL, NULL, NULL),
(62, 'TUBO DE ACEITE ST', 'TUBO ACEI HONDA', '', '15422Z0Z000', 11, 11, 'UND', 'G', '12.0000', '0.0000', '0.0000', '12.0000', 2, 50, NULL, 1, NULL, NULL, NULL),
(63, 'ACEITE SHINDAIWA X 1LT', 'ACEITE SHIND LT', '', '', 10, 10, 'UND', 'G', '28.0000', '0.0000', '0.0000', '28.0000', 2, 100, NULL, 1, NULL, NULL, NULL),
(64, 'FILTRO DE AIRE P/ES726', 'FILTRO AIR SHIN', '', '', 11, 11, 'UND', 'G', '5.5000', '0.0000', '0.0000', '5.5000', 2, 50, NULL, 1, NULL, NULL, NULL),
(65, 'MOTOSIERRA 395XP 36¨', '395 XP 36', '', '', 4, 4, 'UND', 'G', '3000.0000', '0.0000', '0.0000', '2750.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(66, 'MOTOSIERRA 372XP 28¨', '372XP 28', '', '', 4, 4, 'UND', 'G', '2400.0000', '0.0000', '0.0000', '2300.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(67, 'MOTOSIERRA 120 16', '120', '', '', 4, 4, 'UND', 'G', '800.0000', '0.0000', '0.0000', '700.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(68, 'DESBROZADORA 236R', '236R', '', '', 4, 4, 'UND', 'G', '1750.0000', '0.0000', '0.0000', '1600.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(69, 'DESBROZADORA 143R II', '143R II', '', '', 8, 8, 'UND', 'G', '1650.0000', '0.0000', '0.0000', '1500.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(70, 'RETEN DE ACEITE, 10X20X5 ST', 'RETEN 10X20X5', '', '', 11, 11, 'UND', 'G', '4.2000', '0.0000', '0.0000', '4.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(71, 'RETEN DE ACEITE, 12X24X5 ST', 'RETEN 12X24X5', '', '', 11, 11, 'UND', 'G', '4.2000', '0.0000', '0.0000', '4.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(72, 'ELEVADOR DE VALVULA DE ADMISION COMP. ST', '', '', '', 11, 11, 'UND', 'G', '60.0000', '0.0000', '0.0000', '45.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(73, 'ELEVADOR DE VALVULA DE ESCAPE COMP. ST', '', '', '', 11, 11, 'UND', 'G', '65.0000', '0.0000', '0.0000', '45.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(74, 'FAJA DE DISTRIBUCION (71ZU5 G-310) ST', '', '', '', 11, 11, 'UND', 'G', '14.7000', '0.0000', '0.0000', '14.7000', 0, 0, NULL, 1, NULL, NULL, NULL),
(75, 'ENS. CARBURADOR (WYB 6F) ST', '', '', '', 11, 11, 'UND', 'G', '96.0000', '0.0000', '0.0000', '96.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(76, 'JGO. DE ANILLOS DE PISTON ST', '', '', '', 11, 11, 'UND', 'G', '25.0000', '0.0000', '0.0000', '25.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(77, 'TAPA DE TANQUE DE COMBUSTIBLE ST', '', '', '', 11, 11, 'UND', 'G', '15.6000', '0.0000', '0.0000', '15.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(78, 'ACEITE HONDA PF 4T 10W30  946ML KI', '', '', '', 10, 10, 'UND', 'G', '17.8000', '0.0000', '0.0000', '17.8000', 0, 0, NULL, 1, NULL, NULL, NULL),
(79, 'RETEN DE ACEITE CIFARELLI', '', '', '', 11, 11, 'UND', 'G', '29.0000', '0.0000', '0.0000', '29.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(80, 'TORNILLO FIJADOR DE CARBURADOR', '', '', '', 11, 11, 'UND', 'G', '10.8000', '0.0000', '0.0000', '10.8000', 0, 0, NULL, 1, NULL, NULL, NULL),
(81, 'DIFUSOR REGULABLE M1200', '', '', '', 11, 11, 'UND', 'G', '36.0000', '0.0000', '0.0000', '36.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(82, 'BOMBA PISTON DE 30 L/M EMBOLO CERAMICO', 'BOMBA 30 LT', '', '', 13, 13, 'UND', 'G', '550.0000', '0.0000', '0.0000', '480.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(83, 'BASE PARA MOTOBOMBA 30', '', '', '', 11, 11, 'UND', 'G', '70.0000', '0.0000', '0.0000', '61.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(84, 'MANGUERA DE 13 MM 1/2 X 100 SANSAN', '', '', '', 12, 12, 'UND', 'G', '577.0000', '0.0000', '0.0000', '577.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(85, 'JEBE DE MANGUERA', 'CONEXION DE GOM', '', '', 11, 11, 'UND', 'G', '13.2000', '0.0000', '0.0000', '13.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(86, 'KIT DE CHOKE CARB WALBRO', 'CHOKE', '', '', 11, 11, 'UND', 'G', '11.0000', '0.0000', '0.0000', '11.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(87, 'MOTOPULVERIZADOR CON MOTOR GX35 PANTERA', '', '', '', 11, 11, 'UND', 'G', '1146.0000', '0.0000', '0.0000', '1146.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(88, 'BASE DE FILTRO DE AIRE DELLORTO', '', '', '', 11, 11, 'UND', 'G', '75.0000', '0.0000', '0.0000', '60.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(89, 'PALANCA CON INTERRUPTOR', '', '', '', 11, 11, 'UND', 'G', '45.0000', '0.0000', '0.0000', '45.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(90, 'RESORTE AUTOENVOLVENTE Y PLATO M1200', '', '', '', 11, 11, 'UND', 'G', '36.0000', '0.0000', '0.0000', '36.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(91, 'JUNTA DE TUBO DE ESCAPE', 'JUNTA D ESCAP', '', '', 11, 11, 'UND', 'G', '22.0000', '0.0000', '0.0000', '18.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(92, 'PODADORA EFCO PTX2700 BARRA DE 10\"', '', '', '', 14, 14, 'UND', 'G', '2400.0000', '0.0000', '0.0000', '2200.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(93, 'KIT DE REGILLAS', '', '', '', 11, 11, 'UND', 'G', '25.0000', '0.0000', '0.0000', '25.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(94, 'AISLANTE CARBURADOR WALBRO', 'TOBERA', '', '', 11, 11, 'UND', 'G', '45.0000', '0.0000', '0.0000', '35.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(95, 'BOCA DIFUSORA M1200', '', '', '', 11, 11, 'UND', 'G', '55.0000', '0.0000', '0.0000', '45.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(96, 'MANGUERA DE RETORNO DE MESCLA M1200', '', '', '', 11, 11, 'UND', 'G', '22.0000', '0.0000', '0.0000', '18.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(97, 'DESBROZADORA EFCO 8410', '', '', '', 3, 3, 'UND', 'G', '1700.0000', '0.0000', '0.0000', '1477.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(98, 'ESPOLVOREADORA MATABI POLMAX', '', '', '', 15, 15, 'UND', 'G', '380.0000', '0.0000', '0.0000', '350.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(99, 'KIT DE MOTOSIERRA STIHL MS 382 ESP/CAD/ 75CM', '', '', '', 4, 4, 'UND', 'G', '2350.0000', '0.0000', '0.0000', '2350.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(100, 'KIT MOTOSIERRA STHIL MS 660 ESP/CAD/90CM', '660', '', '', 4, 4, 'UND', 'G', '2900.0000', '0.0000', '0.0000', '2900.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(101, 'MOTOGUADAÑA STIHL FS 250', 'FS250', '', '', 3, 3, 'UND', 'G', '1650.0000', '0.0000', '0.0000', '1370.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(102, 'MOTOGUADAÑA STIHL FS 280', '', '', '', 3, 3, 'UND', 'G', '1800.0000', '0.0000', '0.0000', '1650.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(103, 'ROLLO DE NAYLON NARANJA DE 20 METROS STHIL', '', '', '', 16, 16, 'MT', 'G', '21.0000', '0.0000', '0.0000', '21.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(104, 'ROLLO DE NAYLON ROJO DE 50 METROS STHIL', '', '', '', 16, 16, 'MTS', 'G', '52.5000', '0.0000', '0.0000', '52.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(105, 'TRINQUETE STIHL', '', '', '4116-195-7200', 11, 11, 'UND', 'G', '8.4000', '0.0000', '0.0000', '8.4000', 0, 0, NULL, 1, NULL, NULL, NULL),
(106, 'FILTRO DE AIRE 420', 'FILTRO 420', '', '4203-141-0301', 11, 11, 'UND', 'G', '39.0000', '0.0000', '0.0000', '39.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(107, 'ACEITE STHIL 2T 100 ML', '', '', '', 10, 10, 'UND', 'G', '4.1200', '0.0000', '0.0000', '4.1200', 0, 0, NULL, 1, NULL, NULL, NULL),
(108, 'BOQUILLA AZUL CERAMICA', '', '', '', 7, 7, 'UND', 'G', '11.0300', '0.0000', '0.0000', '11.0300', 0, 0, NULL, 1, NULL, NULL, NULL),
(109, 'TAPA QUICK TEEJET', '', '', '', 17, 17, 'UND', 'G', '4.0000', '0.0000', '0.0000', '4.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(110, 'TEEJET TIP POLIMER', '', '', '', 7, 7, 'UND', 'G', '15.0000', '0.0000', '0.0000', '8.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(111, 'FILTRO MALLA', '', '', '', 7, 7, 'UND', 'G', '15.0000', '0.0000', '0.0000', '10.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(112, 'DIFUSOR DE CERAMICA DC 45', '', '', '', 7, 7, 'UND', 'G', '30.0000', '0.0000', '0.0000', '25.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(113, 'DIFUSOR DE CERAMICA DC -35 3 AGUJEROS', '', '', '', 7, 7, 'UND', 'G', '30.0000', '0.0000', '0.0000', '25.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(114, 'DISCO DE CERAMICA N 6', '', '', '', 7, 7, 'UND', 'G', '15.0000', '0.0000', '0.0000', '10.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(115, 'BOQUILLA DE CERAMICA CONO HUECO MAG1 AZUL', '', '', '', 7, 7, 'UND', 'G', '14.0000', '0.0000', '0.0000', '14.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(116, 'BOQUILLLA DE CERAMICA CONO HUECO MAG 2 NAR', '', '', '', 7, 7, 'UND', 'G', '12.0000', '0.0000', '0.0000', '12.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(117, 'PORTA BOQUILLA DOBLE', '', '', '', 17, 17, 'UND', 'G', '29.0000', '0.0000', '0.0000', '29.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(118, 'JUNTA DE ASIENTO', '', '', '', 16, 16, 'UND', 'G', '1.8700', '0.0000', '0.0000', '1.8700', 0, 0, NULL, 1, NULL, NULL, NULL),
(119, 'BOQUILLA DE CERAMICA CONO HUECO NEGRA', '', '', '', 7, 7, 'UND', 'G', '13.0000', '0.0000', '0.0000', '13.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(120, 'MOCHILA FUMIGADORA A MOTOR M/AOSOLE 25LT', '', '', '', 1, 1, 'UND', 'G', '750.0000', '0.0000', '0.0000', '690.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(121, 'REPUESTO FUMIGADOR MANUAL SET', '', '', '', 17, 17, 'UND', 'G', '25.0000', '0.0000', '0.0000', '20.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(122, 'MOCHILA FUMIGADORA AGRO 15 LITROS', '', '', '', 2, 2, 'UND', 'G', '90.0000', '0.0000', '0.0000', '80.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(123, 'MOCHILA FUMIGADORA AOSOME', '', '', '', 1, 1, 'UND', 'G', '750.0000', '0.0000', '0.0000', '700.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(124, 'MOTOR ENGINE GX35', '', '', '', 8, 8, 'UND', 'G', '690.0000', '0.0000', '0.0000', '690.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(125, 'REPUESTO SPRAYERS ACCESORIOS', '', '', '', 17, 17, 'UND', 'G', '38.0000', '0.0000', '0.0000', '35.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(126, 'MOCHILA DE 30 LITROS', '', '', '', 1, 1, 'UND', 'G', '420.0000', '0.0000', '0.0000', '390.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(127, 'MOCHILA FUMIGADORA', '', '', '', 1, 1, 'UND', 'G', '420.0000', '0.0000', '0.0000', '390.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(128, 'MOCHILA FUMIGADORA 900230', '', '', '', 1, 1, 'UND', 'G', '420.0000', '0.0000', '0.0000', '390.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(129, 'PISTOLA ROCEADORA D-L1', '', '', '', 16, 16, 'UND', 'G', '47.2500', '0.0000', '0.0000', '47.2500', 0, 0, NULL, 1, NULL, NULL, NULL),
(130, 'GATILLO JACTO', '', '', '', 17, 17, 'UND', 'G', '6.3000', '0.0000', '0.0000', '6.3000', 0, 0, NULL, 1, NULL, NULL, NULL),
(131, 'LANZA BRONCE P/MOCHILA', '', '', '', 17, 17, 'UND', 'G', '7.2000', '0.0000', '0.0000', '7.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(132, 'MANGUERA LLAVE T/JACTO', '', '', '', 17, 17, 'UND', 'G', '19.5000', '0.0000', '0.0000', '19.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(133, 'MOTOFUMIGADORA GASOLINERA 30LTS KASO', '', '', '', 1, 1, 'UND', 'G', '500.0000', '0.0000', '0.0000', '465.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(134, 'MOCHILA FUMIGADORA 25 LTS CON MOTOR GX35 4 TIEMPOS KASO', '', '', '', 1, 1, 'UND', 'G', '750.0000', '0.0000', '0.0000', '690.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(135, 'MOTOBOMBA LECCO 2X2', '', '', '', 19, 19, 'UND', 'G', '650.0000', '0.0000', '0.0000', '500.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(136, 'BOMBA DE CAUDAL 3X3 DEREK MOTORS', '', '', '', 19, 19, 'UND', 'G', '1800.0000', '0.0000', '0.0000', '1500.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(137, 'MOCHILA FUMIGADORA MANUAL SOLO 15 LT KAZO', '', '', '', 2, 2, 'UND', 'G', '75.0000', '0.0000', '0.0000', '65.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(138, 'MOCHILA FUMIGADORA MANUAL 16 LT KAZO', '', '', '', 2, 2, 'UND', 'G', '80.0000', '0.0000', '0.0000', '75.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(139, 'CABEZAL HIDROLAVADORA', '', '', '', 13, 13, 'UND', 'G', '300.0000', '0.0000', '0.0000', '260.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(140, 'CAMARA BRONCE', '', '', '4244-180-1100', 17, 17, 'UND', 'G', '42.0000', '0.0000', '0.0000', '42.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(141, 'BUJIA ENCENDIDO MOTOSIERRA 3/4 BM7A', '', '', '', 11, 11, 'UND', 'G', '5.3000', '0.0000', '0.0000', '5.3000', 0, 0, NULL, 1, NULL, NULL, NULL),
(142, 'BUJIA ENCENDIDA MOTOSIERRA 3/4 7321', '', '', '', 11, 11, 'UND', 'G', '5.0000', '0.0000', '0.0000', '5.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(143, 'MOCHILA CON MOTOR 2 TIEMPOS SEPTYNI', '', '', '', 1, 1, 'UND', 'G', '400.0000', '0.0000', '0.0000', '380.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(144, 'ACEITE P/MOTOR 2T 0.1 LT 100ML', '', '', '', 10, 10, 'UND', 'G', '5.0000', '0.0000', '0.0000', '3.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(145, 'PULVEROZADORA GAS 1.1 HP MOCHILA 30LT  4T HONDA', '', '', '', 1, 1, 'UND', 'G', '1287.0000', '0.0000', '0.0000', '1287.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(146, 'MOTOFUMIGADORA 6.5 HP', '', '', '', 1, 1, 'UND', 'G', '972.0000', '0.0000', '0.0000', '972.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(147, 'MANGUERA ALTA PRESION 8.5 50 M TECH FLEX', '', '', '', 12, 12, 'UND', 'G', '99.0000', '0.0000', '0.0000', '99.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(148, 'MOTOBOMBA 3X3 5.5HP PANTHER', '', '', '', 19, 19, 'UND', 'G', '900.0000', '0.0000', '0.0000', '750.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(149, 'MOTOBOMBA 4X4 5.5 HP PANTHER', '', '', '', 19, 19, 'UND', 'G', '1500.0000', '0.0000', '0.0000', '1400.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(150, 'MOTOR GAS 5.5 HP PANTERA', '', '', '', 8, 8, 'UND', 'G', '750.0000', '0.0000', '0.0000', '550.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(151, 'PULVERIZADORA DORSAL SIMETRICA', '', '', '', 2, 2, 'UND', 'G', '350.0000', '0.0000', '0.0000', '330.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(152, 'ATOMIZADOR CIFARELLI 18 L CHINA', '', '', '', 1, 1, 'UND', 'G', '750.0000', '0.0000', '0.0000', '700.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(153, 'FUMIGADORA 3L', '', '', '', 16, 16, 'UND', 'G', '5.2500', '0.0000', '0.0000', '5.2500', 0, 0, NULL, 1, NULL, NULL, NULL),
(154, 'FUMIGADORA 5L', '', '', '', 16, 16, 'UND', 'G', '20.0000', '0.0000', '0.0000', '15.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(155, 'SET ACCESORIOS FUMIGADORA', '', '', '', 16, 16, 'UND', 'G', '10.5000', '0.0000', '0.0000', '10.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(156, 'VASO DE BRONCE', '', '', '', 17, 17, 'UND', 'G', '10.0000', '0.0000', '0.0000', '8.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(157, 'TEE HDPE DENTADA', '', '', '', 16, 16, 'UND', 'G', '0.7200', '0.0000', '0.0000', '0.7200', 0, 0, NULL, 1, NULL, NULL, NULL),
(158, 'PISTON STIHL FS280', '', '', '', 3, 3, 'UND', 'G', '222.0000', '0.0000', '0.0000', '222.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(159, 'COLADOR DE MOCHILA DE FUMIGAR', '', '', '', 16, 16, 'UND', 'G', '6.1000', '0.0000', '0.0000', '6.1000', 0, 0, NULL, 1, NULL, NULL, NULL),
(160, 'PC REPUESTOS', '', '', '', 17, 17, 'UND', 'G', '18.0000', '0.0000', '0.0000', '15.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(161, 'KIT DE MOCHILA DE FUMIGAR', '', '', '', 17, 17, 'UND', 'G', '10.7000', '0.0000', '0.0000', '10.7000', 0, 0, NULL, 1, NULL, NULL, NULL),
(162, 'POLEA 2 1/2', '', '', '', 16, 16, 'UND', 'G', '7.5000', '0.0000', '0.0000', '7.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(163, 'MOTOFUMIGADORA GASOL', '', '', '', 1, 1, 'UND', 'G', '400.0000', '0.0000', '0.0000', '361.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(164, 'MOTOFUMIGADORA A MOTOR JETAGRO 25 LT', '', '', '', 1, 1, 'UND', 'G', '300.0000', '0.0000', '0.0000', '300.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(165, 'REPUESTOS DE FUMIGADORA', '', '', '', 17, 17, 'UND', 'G', '6.0000', '0.0000', '0.0000', '6.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(166, 'PULVERIZADOR 20LT JET AGRO', '', '', '', 2, 2, 'UND', 'G', '63.0000', '0.0000', '0.0000', '63.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(167, 'PC REPUESTOS PARA FUMIGADORA', '', '', '', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '12.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(168, 'REPUESTOS PARA FUMIGADORA', '', '', '', 11, 11, 'UND', 'G', '21.0000', '0.0000', '0.0000', '19.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(169, 'REPUESTO PARA CABEZAL DE FUMIGADORA', '', '', '', 11, 11, 'UND', 'G', '8.0000', '0.0000', '0.0000', '5.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(170, 'FUMIGADORA MANUAL DE 20 LT AGRO IMPACTO', '', '', '', 2, 2, 'UND', 'G', '69.0000', '0.0000', '0.0000', '69.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(171, 'ACCESORIOS', '', '', '', 11, 11, 'UND', 'G', '20.0000', '0.0000', '0.0000', '12.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(172, 'MOCHILA FUMIGADORA 20LT 2 TIEMPOS', '', '', '', 1, 1, 'UND', 'G', '500.0000', '0.0000', '0.0000', '418.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(173, 'MOCHILA FUMIGADORA DE 30LT 4 TIEMPOS', '', '', '', 1, 1, 'UND', 'G', '690.0000', '0.0000', '0.0000', '550.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(174, 'CASQUILLO LATON', '', '', '', 17, 17, 'UND', 'G', '0.6300', '0.0000', '0.0000', '0.6300', 0, 0, NULL, 1, NULL, NULL, NULL),
(175, 'MANGUERA DE FUMIGACION ITALFLEX 5/16', '', '', '', 12, 12, 'UND', 'G', '250.0000', '0.0000', '0.0000', '200.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(176, 'PISTOLA DE LAVADO Y FUMIGACION BRONCE PESADO', '', '', '', 20, 20, 'UND', 'G', '180.0000', '0.0000', '0.0000', '120.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(177, 'ACOPLE CAMLOCK TIPO C 1/2', '', '', '', 16, 16, 'UND', 'G', '18.0000', '0.0000', '0.0000', '12.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(178, 'ACOPLE CAMLOCK TIPO C 3/4', '', '', '', 16, 16, 'UND', 'G', '18.0000', '0.0000', '0.0000', '12.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(179, 'ACOPLE CAMLOCK TIPO C 1', '', '', '', 16, 16, 'UND', 'G', '18.0000', '0.0000', '0.0000', '12.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(180, 'NIPLE GALVANIZADO', '', '', '', 16, 16, 'UND', 'G', '18.0000', '0.0000', '0.0000', '12.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(181, 'NIPLE GALVANIZADO 1/4', '', '', '', 17, 17, 'UND', 'G', '10.0000', '0.0000', '0.0000', '8.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(182, 'RETEN16*28*7', '', '', '', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '10.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(183, 'ESCAMADOS 1/4 NTP', '', '', '', 17, 17, 'UND', 'G', '10.0000', '0.0000', '0.0000', '8.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(184, 'TEE S/16', '', '', '', 17, 17, 'UND', 'G', '10.0000', '0.0000', '0.0000', '8.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(185, 'TEE 1/4', '', '', '', 17, 17, 'UND', 'G', '3.0000', '0.0000', '0.0000', '2.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(186, 'LLAVES DE 1/4 NTP', '', '', '', 17, 17, 'UND', 'G', '15.0000', '0.0000', '0.0000', '13.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(187, 'MOCHILA PULVERIZADORA MANUAL 20 LT HD 550', '', '', '', 2, 2, 'UND', 'G', '300.0000', '0.0000', '0.0000', '270.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(188, 'ATOMIZADOR SOLO 423', '', '', '', 1, 1, 'UND', 'G', '2000.0000', '0.0000', '0.0000', '1800.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(189, 'BOBINA 2300807', '', '', '', 11, 11, 'UND', 'G', '240.0000', '0.0000', '0.0000', '220.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(190, 'CABLE BOWDEN', '', '', '', 11, 11, 'UND', 'G', '35.0000', '0.0000', '0.0000', '28.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(191, 'PASADOR CAMBIO 4074721', '', '', '', 11, 11, 'UND', 'G', '8.5000', '0.0000', '0.0000', '8.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(192, 'RESORTE DE VALVULA P/ES726', '', '', '', 11, 11, 'UND', 'G', '18.0000', '0.0000', '0.0000', '13.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(193, 'TOBERA CHORRO ANCHO', '', '', '', 11, 11, 'UND', 'G', '6.0000', '0.0000', '0.0000', '6.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(194, 'TUBO 4074251', '', '', '', 11, 11, 'UND', 'G', '18.0000', '0.0000', '0.0000', '12.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(195, 'SEGUROS JACTO', '', '', '', 11, 11, 'UND', 'G', '9.6000', '0.0000', '0.0000', '9.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(196, 'MOTOBOMBA LECCO 3X3', '', '', '', 19, 19, 'UND', 'G', '650.0000', '0.0000', '0.0000', '470.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(197, 'MOTOBOMBA 1.5 HP TIEMPOS DEREK MOTORS', '', '', '', 19, 19, 'UND', 'G', '420.0000', '0.0000', '0.0000', '397.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(198, 'TAPON DE AGUA LECCO', '', '', '', 11, 11, 'UND', 'G', '3.0000', '0.0000', '0.0000', '3.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(199, 'TAPA DE TANQUE GASOLINA DEREK MOTORS', '', '', '', 11, 11, 'UND', 'G', '3.6000', '0.0000', '0.0000', '3.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(200, 'ACCSESORIOA DE BOMBA 3X3LECCO', '', '', '', 11, 11, 'UND', 'G', '25.0000', '0.0000', '0.0000', '23.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(201, 'ACCSESORIOA DE BOMBA 2X2 LECCO', '', '', '', 11, 11, 'UND', 'G', '30.0000', '0.0000', '0.0000', '25.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(202, 'CABEZAL DE HIDROLAVADORA AC30A1N KAZO', '', '', '', 13, 13, 'UND', 'G', '450.0000', '0.0000', '0.0000', '350.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(203, 'BOQUILLA MOVIBLE PARA HIDROLAVADORA', '', '', '', 7, 7, 'UND', 'G', '9.6000', '0.0000', '0.0000', '9.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(204, 'BOQUILLA ROSEADORA DE METAL KASO', '', '', '', 20, 20, 'UND', 'G', '20.0000', '0.0000', '0.0000', '17.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(205, 'PISTOLA PARA HIDROLAVADORA DE BRONCE KASO', '', '', '', 20, 20, 'UND', 'G', '35.0000', '0.0000', '0.0000', '32.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(206, 'MANGUERA + LLAVE +LANZA JACTO', '', '', '', 11, 11, 'UND', 'G', '15.6000', '0.0000', '0.0000', '15.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(207, 'ACOPLE PARA DESBROZADORA PARA DRK-390', '', '', '', 11, 11, 'UND', 'G', '35.0000', '0.0000', '0.0000', '30.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(208, 'DESBROZADORA DE MOCHILA 2HP 42.7 CC 1500W DEKERS MOTORS', '', '', '', 3, 3, 'UND', 'G', '600.0000', '0.0000', '0.0000', '550.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(209, 'GENERADOR GASOLINERO 1.5 KW KAZO', '', '', '', 9, 9, 'UND', 'G', '1200.0000', '0.0000', '0.0000', '850.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(210, 'CABEZAL PARA HIDROLAVADORA 50 6.5 HP BASE DORADO KAZO', '', '', '', 13, 13, 'UND', 'G', '300.0000', '0.0000', '0.0000', '250.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(211, 'MOTOR MONOFASICO 1.HP BAJA DEREK MOTORS', '', '', '', 21, 21, 'UND', 'G', '263.0000', '0.0000', '0.0000', '263.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(212, 'LANZA HIDROLAVADORA 45 CM GIRATORIA', '', '', '', 20, 20, 'UND', 'G', '25.0000', '0.0000', '0.0000', '19.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(213, 'MOTOR GAS 5.5 HP HONDA', '', '', '', 8, 8, 'UND', 'G', '1050.0000', '0.0000', '0.0000', '1050.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(214, 'PULVERIZADOR MATABI EVOLUTION 20', '', '', '', 2, 2, 'UND', 'G', '220.0000', '0.0000', '0.0000', '217.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(215, 'MOTOR ESTACIONARIO GX 25 TIPO SD ST', '', '', '', 5, 5, 'UND', 'G', '580.0000', '0.0000', '0.0000', '580.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(216, 'MOTOR GASOLINERO DE 6.5 HP PANTHERA', '', '', '', 8, 8, 'UND', 'G', '350.0000', '0.0000', '0.0000', '350.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(217, 'BUJIA NGK CIFARELLI', '', '', '', 11, 11, 'UND', 'G', '12.6000', '0.0000', '0.0000', '12.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(218, 'ASIENTO DE VALVULA FST', '', '', '', 11, 11, 'UND', 'G', '10.0000', '0.0000', '0.0000', '7.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(219, 'CARBURADOR WALBRO HDA M1200', 'CARBURADO M1200', '', '', 11, 11, 'UND', 'G', '250.0000', '0.0000', '0.0000', '250.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(220, 'VALVULA DE 30 C', '', '', '', 11, 11, 'UND', 'G', '7.3500', '0.0000', '0.0000', '7.3500', 0, 0, NULL, 1, NULL, NULL, NULL),
(221, 'CAPSULA M1200 (CEBADOR)', 'CEVADOR 1200', '', '', 11, 11, 'UND', 'G', '22.0000', '0.0000', '0.0000', '22.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(222, 'KIT DE RETENES LS557', '', '', '', 11, 11, 'UND', 'G', '120.0000', '0.0000', '0.0000', '98.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(223, 'FILTRO DE COMBUSTIBLE', '', '', 'TA19-01', 11, 11, 'UND', 'G', '45.0000', '0.0000', '0.0000', '35.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(224, 'AMORTIGUADOR PARA FUMIGADORA', '', '', 'TA19-02', 11, 11, 'UND', 'G', '30.0000', '0.0000', '0.0000', '25.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(225, 'BOMBA LATON 2T PARA MOTOPULVERIZADOR', '', '', 'TA19-03', 11, 11, 'UND', 'G', '140.0000', '0.0000', '0.0000', '120.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(226, 'BOMBA PISTON CON EMBOLO', '', '', 'TA19-04', 11, 11, 'UND', 'G', '280.0000', '0.0000', '0.0000', '235.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(227, 'BOQUILLA ROCIADORA DE 2 SALIDAS', '', '', 'TA19-05', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '8.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(228, 'BOQUILLA ROCIADORA DE 8 SALIDAS', '', '', 'TA19-06', 11, 11, 'UND', 'G', '18.0000', '0.0000', '0.0000', '15.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(229, 'BOQUILLA DE 2 SALIDAS  ( PLASTICO)', '', '', 'TA19-07', 11, 11, 'UND', 'G', '25.0000', '0.0000', '0.0000', '18.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(230, 'CABLE ACELERADOR PARA MOTOPUL CON MOTO TU26', '', '', 'TA19-07', 11, 11, 'UND', 'G', '45.0000', '0.0000', '0.0000', '35.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(231, 'CARBURADORDE 2 TIEMPOS TU26', 'CARBURADOR TU26', '', 'TA19-08', 11, 11, 'UND', 'G', '28.0000', '0.0000', '0.0000', '22.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(232, 'EMBRAGUE DE FUMIGADORA', '', '', 'TA19-09', 11, 11, 'UND', 'G', '6.0000', '0.0000', '0.0000', '6.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(233, 'EMPAQUETADURA DE MOTOR', '', '', 'TA19-10', 11, 11, 'UND', 'G', '2.0000', '0.0000', '0.0000', '2.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(234, 'FILTRO DE LINEA PARA MOTOPUL.', '', '', 'TA19-11', 11, 11, 'UND', 'G', '6.0000', '0.0000', '0.0000', '6.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(235, 'KIT DE DIAFRAGMA  DE CARBURADOR', '', '', 'TA19-12', 11, 11, 'UND', 'G', '5.3000', '0.0000', '0.0000', '5.3000', 0, 0, NULL, 1, NULL, NULL, NULL),
(236, 'LANZA DE PULVERIZADOR', '', '', 'TA19-13', 20, 20, 'UND', 'G', '10.5000', '0.0000', '0.0000', '10.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(237, 'LANZA RECTA DE 90 CM PARA PULVERIZADOR  ( ALUMINIO)', '', '', 'TA19-14', 20, 20, 'UND', 'G', '12.0000', '0.0000', '0.0000', '12.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(238, 'LANZA RECTA DE 90 CM PARA PULVERIZADOR DE LATON Y 3 VIAS  ( ALUMINIO)', '3 SALIDAS', '', 'TA19-15', 20, 20, 'UND', 'G', '12.0000', '0.0000', '0.0000', '11.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(239, 'MANGUERA DE 1.20 MT ( JEBE CON TERMINAL DE BRONCE)', '', '', 'TA19-16', 11, 11, 'UND', 'G', '10.0000', '0.0000', '0.0000', '10.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(240, 'MOTOPULVERIZADOR CON MOTOR HONDA GX35', '', '', 'TA19-17', 1, 1, 'UND', 'G', '1050.0000', '0.0000', '0.0000', '950.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(241, 'MOTOPULVERIZADOR CON MOTOR 4 TIEMPOS DE 2.5 HP CON BOMBA PISTON', '', '', 'TA19-18', 1, 1, 'UND', 'G', '600.0000', '0.0000', '0.0000', '550.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(242, 'MOTOPULVERIZADOR CON MOTOR 4 TIEMPOS DE 6.5 HP CON BOMBA PISTON DE 30 C (CONDOR 700)', '', '', 'TA19-19', 5, 5, 'UND', 'G', '600.0000', '0.0000', '0.0000', '600.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(243, 'RESORTE S/N ACERO', '', '', 'TA19-20', 11, 11, 'UND', 'G', '30.0000', '0.0000', '0.0000', '20.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(244, 'TERMINAL DE BOQUILLA CON DISCO', '', '', 'TA19-21', 7, 7, 'UND', 'G', '10.0000', '0.0000', '0.0000', '7.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(245, 'TUBO EXTENCION PARA BOQUILLA AMARILLO', '', '', 'TA19-22', 11, 11, 'UND', 'G', '45.0000', '0.0000', '0.0000', '30.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(246, 'TUBO EXTENCION PARA BOQUILLA ROJO', '', '', 'TA19-23', 11, 11, 'UND', 'G', '11.0000', '0.0000', '0.0000', '11.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(247, 'ZAPATA COMPLETA DE TU- 26', '', '', 'TA19-24', 11, 11, 'UND', 'G', '90.0000', '0.0000', '0.0000', '45.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(248, 'CERAMIC 900 PARA MOTOR HONDA GX35', 'CERAMIC HONDA', '', 'CE900H-19', 1, 1, 'UND', 'G', '850.0000', '0.0000', '0.0000', '850.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(249, 'TECNICA 900 MOTOR TU26', 'TU26', '', 'TU26-19', 1, 1, 'UND', 'G', '1200.0000', '0.0000', '0.0000', '400.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(250, 'TORNADO 900 MOTOR  ZONSHENG', 'ZONSHENG', '', 'TO900-19', 1, 1, 'UND', 'G', '750.0000', '0.0000', '0.0000', '141.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(251, 'TURBOJET 4025 MOTOR MITSUBISHI 25LT', 'MITSUBISHI 4025', '', 'TUR4025-19', 1, 1, 'UND', 'G', '900.0000', '0.0000', '0.0000', '800.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(252, 'TURBOJET 800A MOTOR 4T 25LTS', 'TURBOJET 800A', '', '800A-19', 1, 1, 'UND', 'G', '550.0000', '0.0000', '0.0000', '420.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(253, 'SWITCH ACELERADOR', 'ACELERADOR', '', 'AC04-19', 11, 11, 'UND', 'G', '6.0000', '0.0000', '0.0000', '6.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(254, 'FILTRO (LINEA) DE MANO', 'FILTRO LINEA', '', 'FIL04-19', 11, 11, 'UND', 'G', '120.0000', '0.0000', '0.0000', '80.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(255, 'JUNTA DE CARBURADOR', 'JUNTA CARB', '', 'JU04-19', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '10.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(256, 'CONECTOR B62 DE BRONCE 8.5', 'CONECTOR 8.5', '', 'CO04-19', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '10.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(257, 'ZAPATA GX35', 'ZAPATA GX35', '', 'ZA04-19', 11, 11, 'UND', 'G', '6.0000', '0.0000', '0.0000', '6.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(258, 'LANZA RECTA DE 60CM', 'LANZA 60CM', '', 'LA04-19', 11, 11, 'UND', 'G', '28.0000', '0.0000', '0.0000', '26.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(259, 'FABRICK V PACKING', '', '', 'FA04-19', 11, 11, 'UND', 'G', '1.0500', '0.0000', '0.0000', '1.0500', 0, 0, NULL, 1, NULL, NULL, NULL),
(260, 'HOLE JAPAN FAN NOZZLE', '', '', 'HO04-19', 11, 11, 'UND', 'G', '12.0000', '0.0000', '0.0000', '10.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(261, 'MOTOR ESTACIONARIO HONDA GX390', '', '', '', 8, 8, 'UND', 'G', '2400.0000', '0.0000', '0.0000', '2400.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(262, 'DESBROZADORA DE MOCHILA EFCO ESTAR 4410', '', '', '', 3, 3, 'UND', 'G', '1800.0000', '0.0000', '0.0000', '1600.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(263, 'CABLE DE ARRANQUE RETYRACTIL SOGA', '', '', '', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '15.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(264, 'VALVULA DE ESCAPE ST 35', '', '', '', 11, 11, 'UND', 'G', '12.0000', '0.0000', '0.0000', '12.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(265, 'VALVULA DE ADMISION ST 35', '', '', '', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '15.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(266, 'CARBURADOR ST HONDA', '', '', '', 11, 11, 'UND', 'G', '172.0000', '0.0000', '0.0000', '172.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(267, 'POLEA DE ARRANQUE ST', '', '', '', 11, 11, 'UND', 'G', '25.0000', '0.0000', '0.0000', '25.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(268, 'MOTOR EST GX35 TIPO SD DT', '', '', '', 8, 8, 'UND', 'G', '830.0000', '0.0000', '0.0000', '830.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(269, 'MOTOR GAS 5.5 HP PANTHER', '', '', '', 8, 8, 'UND', 'G', '355.0000', '0.0000', '0.0000', '355.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(270, 'DESBROZADORA EVO X 800 CON GX 35 MORI', '', '', '', 3, 3, 'UND', 'G', '1550.0000', '0.0000', '0.0000', '1450.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(271, 'CAPSULA M1200 CEBADOR', '', '', '', 11, 11, 'UND', 'G', '48.0000', '0.0000', '0.0000', '35.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(272, 'ASIENTO VALVULA 35', '', '', '', 11, 11, 'UND', 'G', '2.1000', '0.0000', '0.0000', '2.1000', 0, 0, NULL, 1, NULL, NULL, NULL),
(273, 'CARBURADOR TU26', 'TOBERA', '', '', 11, 11, 'UND', 'G', '20.0000', '0.0000', '0.0000', '20.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(274, 'BOMBA PISTON 80L/M PANTERA', '', '', 'JSSN-80', 13, 13, 'UND', 'G', '850.0000', '0.0000', '0.0000', '750.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(275, 'TANQUE COMBUSTIBLE - CARB. DELLORTO', '', '', 'C12107600', 11, 11, 'UND', 'G', '47.0000', '0.0000', '0.0000', '47.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(276, 'TAPA TANQUE COMBUSTIBLE M1200', '', '', 'C10G65500', 11, 11, 'UND', 'G', '41.5800', '0.0000', '0.0000', '41.5800', 0, 0, NULL, 1, NULL, NULL, NULL),
(277, 'KIT DE MOTOGUADAÑA STIHL FS350', '', '', '', 3, 3, 'UND', 'G', '2300.0000', '0.0000', '0.0000', '1950.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(278, 'KIT DE MOTOSIERRA STHIL MS170', '', '', '', 3, 3, '1', 'G', '700.0000', '0.0000', '0.0000', '650.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(279, 'PULVERIZADOR ELECTRICO PANTERA', 'MOCHILA BATERIA', '', 'FUFST-16DH-1', 22, 22, 'UND', 'G', '215.0000', '0.0000', '0.0000', '201.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(280, 'BUJE DE VENTILADOR', 'BASE VENTILADOR', '', '', 11, 11, '1', 'G', '75.0000', '0.0000', '0.0000', '65.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(281, 'MOTOPULVERIZADOR CON MOTOR TU26 PANTERA 800A', '', '', '', 1, 1, 'UND', 'G', '1250.0000', '0.0000', '0.0000', '1160.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(282, 'MOCHILA FUMIGADORA 20LT/CAMARA BRONCE KAZO', 'KAZO DE BRONCE', '', '', 2, 2, 'UND', 'G', '180.0000', '0.0000', '0.0000', '150.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(283, 'CABEZAL P/HIDROLAVADORA AC-120AN 9.5 HPDORADO KAZO', '', '', '', 13, 13, 'UND', 'G', '820.0000', '0.0000', '0.0000', '700.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(284, 'TRIPODE', '', '', '', 11, 11, 'UND', 'G', '0.0000', '0.0000', '0.0000', '0.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(285, 'MOTOR EST.GX160 TIPO QX1 ST', '', '', 'GX160H2-QX1', 8, 8, 'UND', 'G', '1150.0000', '0.0000', '0.0000', '1150.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(286, 'MOTOGUADAÑA STIHL FS450', '', '', '', 3, 3, 'UND', 'G', '3150.0000', '0.0000', '0.0000', '3000.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(287, 'BUJE DOBLE GUARANY', '', '', '', 11, 11, 'UND', 'G', '7.0000', '0.0000', '0.0000', '5.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(288, 'FILTRO GASOLINA (CARB WALBRO)', '', '', '', 11, 11, 'UND', 'G', '45.0000', '0.0000', '0.0000', '38.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(289, 'FILTRO MALLA 50', '', '', '', 11, 11, 'UND', 'G', '6.5000', '0.0000', '0.0000', '6.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(290, 'DESMALEZADORA SRM-4300/42.7CC/COMP ECHO', 'SRM-4300/42', '', '', 3, 3, 'UND', 'G', '1755.0000', '0.0000', '0.0000', '1755.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(291, 'DESMALEZADORA C230/22.5CC/COMP SHINDAIWA', 'C230/22.5CC/', '', '', 3, 3, 'UND', 'G', '1600.0000', '0.0000', '0.0000', '1500.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(292, 'DESMALEZADORA C350/33.6CC/COMP SHINDAIWA', 'C350/33.6CC', '', '', 3, 3, 'UND', 'G', '2100.0000', '0.0000', '0.0000', '1950.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(293, 'MOTOASPERSORA MB580LA/58.2CC/ECHO', 'MB580LA/58.2', '', '', 1, 1, 'UND', 'G', '1850.0000', '0.0000', '0.0000', '1750.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(294, 'FAJAS  ROULUNDS', '', '', '', 11, 11, 'UND', 'G', '9.5000', '0.0000', '0.0000', '9.5000', 15, 0, NULL, 1, NULL, NULL, NULL),
(295, 'BOMBA PORTABLE 15/LM CON MOTOR ELECTRICO 2HP', '', '', 'WALS-715', 21, 21, 'UND', 'G', '1800.0000', '0.0000', '0.0000', '1600.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(296, 'BOMBA PORTABLE 11/LM CON MOTOR GX35 HONDA', '', '', 'WALS-910S', 1, 1, 'UND', 'G', '1700.0000', '0.0000', '0.0000', '1550.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(297, 'FULL EQUIPADA', '', '', '', 11, 11, 'UND', 'G', '0.0000', '0.0000', '0.0000', '0.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(298, 'MOTOB. AUTOC. 6\" X 6\" 16.HP A/M HMAX.:20M  QMAX.:168M3/H MARCA: PANTHER', '', '', '', 19, 19, 'UND', 'G', '3128.0000', '0.0000', '0.0000', '3128.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(299, 'MANGUERA DE 6X6 PULGADAS', '', '', '', 11, 11, 'UND', 'G', '85.0000', '0.0000', '0.0000', '80.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(300, 'LLANTA TRACTOR 400-8 ARO ROJO', '', '', '', 11, 11, 'UND', 'G', '53.0000', '0.0000', '0.0000', '53.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(301, 'RODAJE 6202 2RSC3 KOYO', '', '', '', 11, 11, 'UND', 'G', '10.5000', '0.0000', '0.0000', '10.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(302, 'MOTOR HORIZONTAL B&S 6.5 HP', '', '', '13U232-0003-01', 8, 8, 'UND', 'G', '633.0000', '0.0000', '0.0000', '633.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(303, 'MEMBRANA REGULADORA 440', 'DIAFRAGMA 440', '', '4116-121-4700', 11, 11, 'UND', 'G', '26.5000', '0.0000', '0.0000', '26.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(304, 'CABLE BOWDEN -420', '', '', '4203-180-1104', 11, 11, 'UND', 'G', '84.0000', '0.0000', '0.0000', '84.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(305, 'CARBURADOR HD45 420', 'TOBERA', '', '4203-120-0610', 11, 11, 'UND', 'G', '265.0000', '0.0000', '0.0000', '265.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(306, 'SEGMENTO DE COMPRENSION Ø 46 X 1,5 MM 420', 'ANILLOS 420', '', '1118-034-3001', 11, 11, 'UND', 'G', '18.0000', '0.0000', '0.0000', '18.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(307, 'JUNTA 440', '', '', '4116-129-0901', 11, 11, 'UND', 'G', '4.0000', '0.0000', '0.0000', '4.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(308, 'BRIDA   420', '', '', '4203-120-2200', 11, 11, 'UND', 'G', '50.0000', '0.0000', '0.0000', '45.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(309, 'REJILLA CONICA 420', '', '', '4203-708-6700', 11, 11, 'UND', 'G', '5.0000', '0.0000', '0.0000', '5.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(310, 'BRIDA INTERMEDIA 440', '', '', '4244-120-2300', 11, 11, 'UND', 'G', '75.0000', '0.0000', '0.0000', '65.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(311, 'CARBURADOR C1Q-S165 440', '', '', '4244-120-0603', 11, 11, 'UND', 'G', '285.0000', '0.0000', '0.0000', '275.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(312, 'CABLE BOWDEN 440', '', '', '4244-180-1100', 11, 11, 'UND', 'G', '120.0000', '0.0000', '0.0000', '110.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(313, 'REJILLA CONICA 440', '', '', '4244-708-6700', 11, 11, 'UND', 'G', '5.5000', '0.0000', '0.0000', '5.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(314, 'BOMBA DE COMBUSTIBLE 440', 'CEBADOR 440', '', '4238-350-6201', 11, 11, 'UND', 'G', '14.0000', '0.0000', '0.0000', '14.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(315, 'SEGMENTO DE COMPRESION Ø 48X1.2 MM 440', '', '', '1125-034-3001', 11, 11, 'UND', 'G', '36.0000', '0.0000', '0.0000', '36.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(316, 'FILTRO DE AIRE - 440', 'FILTRO 440', '', '4223-141-0300', 11, 11, 'UND', 'G', '45.0000', '0.0000', '0.0000', '45.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(317, 'SEGMENTO DE COMPRESION Ø 40X1,5 MM 280', '', '', '4119-034-3003', 11, 11, 'UND', 'G', '22.0000', '0.0000', '0.0000', '22.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(318, 'PISTON Ø 40 MM 280', '', '', '4119-030-2004', 11, 11, 'UND', 'G', '125.0000', '0.0000', '0.0000', '125.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(319, 'PISTON Ø 46 MM -420', '', '', '4203-030-2001', 11, 11, 'UND', 'G', '280.0000', '0.0000', '0.0000', '280.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(320, 'TUBO FLEXIBLE', 'MANGUERA GASOLI', '', '4244-358-0801', 11, 11, 'UND', 'G', '12.0000', '0.0000', '0.0000', '12.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(321, 'CABEZAL DE CORTE AUTOCUT 46-2', '', '', '4003-710-2115', 11, 11, 'UND', 'G', '120.0000', '0.0000', '0.0000', '114.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(322, 'ELECTROB. CENT. 1.0HP 1F 1\"X1\" 110/220V 27MCA@60LPM/HMAX:32MCA QMAX: 105L/MIN', '', '', '', 21, 21, 'UND', 'G', '400.0000', '0.0000', '0.0000', '337.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(323, 'TAPA BASE DE FILTRO DE AIRE', '', '', 'C10613500', 11, 11, 'UND', 'G', '25.0000', '0.0000', '0.0000', '25.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(324, 'CABEZAL DE ASPIRACION', 'FILTRO STHIL', '', '0000-350-3502', 11, 11, 'UND', 'G', '8.7000', '0.0000', '0.0000', '8.7000', 0, 0, NULL, 1, NULL, NULL, NULL),
(325, 'CABEZAL DE CORTE AUTOCUT 40-04 450', 'AUTOCUT 450', '', '4005-710-2100', 11, 11, 'UND', 'G', '145.0000', '0.0000', '0.0000', '125.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(326, 'MANIJA DE PLASTICO PARA SOLO', '', '', '', 11, 11, 'UND', 'G', '9.0000', '0.0000', '0.0000', '9.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(327, 'ASTA LARGO', '', '', '', 11, 11, 'UND', 'G', '12.6000', '0.0000', '0.0000', '12.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(328, 'PORTA ESTOPA', '', '', '', 11, 11, 'UND', 'G', '8.0400', '0.0000', '0.0000', '8.0400', 0, 0, NULL, 1, NULL, NULL, NULL),
(329, 'CORREAS DE MOCHILA DE FUMIGAR', '', '', '', 11, 11, 'UND', 'G', '18.0000', '0.0000', '0.0000', '18.0000', 0, 0, NULL, 1, NULL, NULL, NULL);
INSERT INTO `articulo` (`codigo_art`, `nombre_art`, `abreviatura_art`, `codigobarra_art`, `codigoproveedor_art`, `codigo_mar`, `codigo_lin`, `unidadm_art`, `tipoimpuesto_art`, `precio_art`, `costo_art`, `costogasto_art`, `preciomayorista_art`, `stockmin_art`, `stockmax_art`, `descontinuado_art`, `estado_art`, `usuario_reg`, `usuario_mod`, `fecha_mod`) VALUES
(330, 'RELOJ DE PRESION VERTICAL 1.3/4 SALIDA 1/4 0-100 BAR', '', '', '', 11, 11, 'UND', 'G', '8.0000', '0.0000', '0.0000', '8.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(331, 'GRIPFO BRONCE ROJO MACHO MACHO NTP 1/4 X 1/4', '', '', '', 11, 11, 'UND', 'G', '5.0000', '0.0000', '0.0000', '5.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(332, 'UNION DE BRONCE Y 8.5 MM', '', '', '', 11, 11, 'UND', 'G', '1.2000', '0.0000', '0.0000', '1.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(333, 'TUERCA EXAGONAL BRONCE 1/8', '', '', '', 11, 11, 'UND', 'G', '4.0000', '0.0000', '0.0000', '4.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(334, 'TUERCA EXAGONAL BRONCE 5/32', '', '', '', 11, 11, 'UND', 'G', '4.0000', '0.0000', '0.0000', '4.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(335, 'TUERCA EXAGONAL BRONCE 3/16', '', '', '', 11, 11, 'UND', 'G', '4.0000', '0.0000', '0.0000', '4.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(336, 'TUERCA EXAGONAL BRONCE 1/4', '', '', '', 11, 11, 'UND', 'G', '4.0000', '0.0000', '0.0000', '4.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(337, 'TUERCA EXAGONAL BRONCE 5/16', '', '', '', 11, 11, 'UND', 'G', '4.0000', '0.0000', '0.0000', '4.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(338, 'TUERCA EXAGONAL BRONCE 3/8', '', '', '', 11, 11, 'UND', 'G', '4.0000', '0.0000', '0.0000', '4.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(339, 'TUERCA EXAGONAL BRONCE 7/16', '', '', '', 11, 11, 'UND', 'G', '4.0000', '0.0000', '0.0000', '4.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(340, 'TUERCA EXAGONAL BRONCE 1/2', '', '', '', 11, 11, 'UND', 'G', '5.0000', '0.0000', '0.0000', '5.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(341, 'TUERCA EXAGONAL BRONCE 5/8', '', '', '', 11, 11, 'UND', 'G', '8.0000', '0.0000', '0.0000', '8.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(342, 'TUERCA EXAGONAL BRONCE 3/4', '', '', '', 11, 11, 'UND', 'G', '10.0000', '0.0000', '0.0000', '10.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(343, 'ADAPTADOR 45 MACHO NTP HEMBRA NPSM 14X1/4', '', '', '', 11, 11, 'UND', 'G', '6.0000', '0.0000', '0.0000', '5.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(346, 'ATOMIZADOR DORSAL MOTORIZADO 18L', '', '', '63203', 1, 1, 'UND', 'G', '2350.0000', '0.0000', '0.0000', '2300.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(347, 'TAMBOR DEL CORDON', '', '', '1123-195-0400', 11, 11, 'UND', 'G', '21.0000', '0.0000', '0.0000', '21.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(348, 'PIÑON DE CADENA TIPO ANILLO', '', '', '1123-007-1030', 11, 11, 'UND', 'G', '97.0000', '0.0000', '0.0000', '97.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(349, 'FILTRO DE AIRE 280', '', '', '4119-120-1606', 11, 11, 'UND', 'G', '22.0000', '0.0000', '0.0000', '22.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(350, 'ROLLO DE CADENA 3/8 PICO MICRO', '', '', '3636-000-1640', 11, 11, 'UND', 'G', '2.7000', '0.0000', '0.0000', '2.5600', 0, 0, NULL, 1, NULL, NULL, NULL),
(351, 'ROLLO DE CADENA 3/8', '', '', '3621-000-1640', 11, 11, 'UND', 'G', '2.3700', '0.0000', '0.0000', '2.3700', 0, 0, NULL, 1, NULL, NULL, NULL),
(352, 'ROLLO DE CADENA RAPID SUPER', '', '', '3846-000-1480', 11, 11, 'UND', 'G', '0.2600', '0.0000', '0.0000', '0.2600', 0, 0, NULL, 1, NULL, NULL, NULL),
(353, 'BALANZA DIGITAL 300 KG FERRER', '', '', '', 11, 11, 'UND', 'G', '280.0000', '0.0000', '0.0000', '270.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(355, 'MOCHILA FUMIGAR WJR4025 TIPO GCS', '', '', 'WJR4025T', 1, 1, 'UND', 'G', '1150.0000', '0.0000', '0.0000', '1050.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(356, 'KIT SPRAYERS 4 BOQUILLAS ST', '', '', '', 11, 11, 'UND', 'G', '120.0000', '0.0000', '0.0000', '100.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(358, 'REPUESTO PARA FUMIGADORA MANUAL JET AGRO', '', '', '', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '12.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(359, 'REPUESTOP PARA FUMIGADOR CARBURADOR', '', '', '', 11, 11, 'UND', 'G', '5.4000', '0.0000', '0.0000', '5.4000', 0, 0, NULL, 1, NULL, NULL, NULL),
(360, 'BUJIA ENCEND 5246', '', '', 'CMR4H JP', 11, 11, 'UND', 'G', '10.0000', '0.0000', '0.0000', '10.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(361, 'CABEZAL DE HIDROLAVADORA WL-30H N', '', '', '', 13, 13, 'UND', 'G', '200.0000', '0.0000', '0.0000', '170.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(362, 'FUMIGADORA MANUAL 20 L AGRO IMPACTO WL AI MB 20 AZ', '', '', '', 22, 22, 'UND', 'G', '135.0000', '0.0000', '0.0000', '120.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(363, 'MOCHILA MANUAL 20 L AGRO IMPACTO WL AI B20', '', '', '', 22, 22, 'UND', 'G', '130.0000', '0.0000', '0.0000', '120.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(364, 'ROCIADOR DE 2L', '', '', '', 16, 16, 'UND', 'G', '3.2000', '0.0000', '0.0000', '3.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(365, 'ROCIADOR DE 3 L', '', '', '', 16, 16, 'UND', 'G', '4.2000', '0.0000', '0.0000', '4.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(366, 'CABLE ACELERADOR GX35 TPH 250', '', '', '', 11, 11, 'UND', 'G', '12.0000', '0.0000', '0.0000', '12.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(367, 'CABLE ACELRADOR TU26 TPH 250', '', '', '', 11, 11, 'UND', 'G', '12.0000', '0.0000', '0.0000', '12.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(368, 'ATOMIZADOR MASTER 452 12LTS', '', '', '', 1, 1, 'UND', 'G', '1761.0000', '0.0000', '0.0000', '1761.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(369, 'BOMBA 3X3 ACESORIOS', '', '', '', 11, 11, 'UND', 'G', '220.0000', '0.0000', '0.0000', '210.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(370, 'BOMBA PISTON 30/LM ARGON', '', '', '', 13, 13, 'UND', 'G', '480.0000', '0.0000', '0.0000', '400.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(371, 'BOTELLA DE METAL', '', '', '', 11, 11, 'UND', 'G', '10.5000', '0.0000', '0.0000', '10.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(372, 'BASE DE METAL', '', '', '', 11, 11, 'UND', 'G', '10.0000', '0.0000', '0.0000', '8.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(373, 'VALVULA DE METAL', '', '', '', 11, 11, 'UND', 'G', '3.6000', '0.0000', '0.0000', '3.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(374, 'REPUESTO PARA FUMIGADORA MANUAL CARBURADOR X 1 UND', '', '', '', 11, 11, 'UND', 'G', '6.3000', '0.0000', '0.0000', '6.3000', 0, 0, NULL, 1, NULL, NULL, NULL),
(375, 'CARBURADOR WYB 14D ST', '', '', '16100Z0Z815', 11, 11, 'UND', 'G', '178.0000', '0.0000', '0.0000', '178.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(376, 'ENS. DE CARBURADOR WYB 32 ST', '', '', '16100Z3ED02', 11, 11, 'UND', 'G', '180.0000', '0.0000', '0.0000', '145.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(377, 'MOTOBOMBA A GASOLINA 3 MOTOR 6.5 HP', '', '', '', 19, 19, 'UND', 'G', '650.0000', '0.0000', '0.0000', '558.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(378, 'ARRANCADOR VERTICAL', '', '', '', 11, 11, 'UND', 'G', '19.0000', '0.0000', '0.0000', '19.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(379, 'CAJA ARRANQUE M1200', '', '', '', 11, 11, 'UND', 'G', '55.0000', '0.0000', '0.0000', '49.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(380, 'POLEA AUTOENVOLVENTE M1200', '', '', '', 11, 11, 'UND', 'G', '55.0000', '0.0000', '0.0000', '55.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(381, 'PUÑO DE ARRANQUE', '', '', '', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '15.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(382, 'CUERDA ARRANQUE', '', '', '', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '10.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(383, 'PULVERIZADOR ELECTRICO 18LT SPRAYERS M/JETAGRO', '', '', '', 22, 22, 'UND', 'G', '160.0000', '0.0000', '0.0000', '154.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(384, 'PULVERIZADOR ELECTRICO 20LT SPRAYERS M/JETAGRO', '', '', '', 22, 22, 'UND', 'G', '160.0000', '0.0000', '0.0000', '156.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(385, 'REPUESTOS PARA FUMIGADOR ,CARBURADOR', '', '', '', 11, 11, 'UND', 'G', '6.3000', '0.0000', '0.0000', '6.3000', 0, 0, NULL, 1, NULL, NULL, NULL),
(386, 'REPUESTO PARA FUMIGADORA MANUAL , VIELA DE METAL', '', '', '', 11, 11, 'UND', 'G', '6.3000', '0.0000', '0.0000', '6.3000', 0, 0, NULL, 1, NULL, NULL, NULL),
(387, 'REPUESTO PARA BRUSH CUTER ,TRIMER CHICO', '', '', '', 11, 11, 'UND', 'G', '21.0000', '0.0000', '0.0000', '21.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(388, 'REPUESTO PARA PULVERIZADOR ELECTRICO MINI BOMBA', '', '', '', 11, 11, 'UND', 'G', '10.5000', '0.0000', '0.0000', '10.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(389, 'REPUESTO PARA FUMIGADORA A MOTOR M/JETAGRO', '', '', '', 11, 11, 'UND', 'G', '8.4000', '0.0000', '0.0000', '8.4000', 0, 0, NULL, 1, NULL, NULL, NULL),
(390, 'BOMBA A PISTON 56/LMIN EMBOLO CERAMICO WHALE', '', '', '', 13, 13, 'UND', 'G', '2500.0000', '0.0000', '0.0000', '1950.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(391, 'EJE TRASMISION STARK 4410', '', '', '', 11, 11, 'UND', 'G', '120.0000', '0.0000', '0.0000', '100.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(392, 'ABRAZADERA GALV SIN FIN TAIWAN', '', '', '', 11, 11, 'UND', 'G', '0.6000', '0.0000', '0.0000', '0.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(393, 'LANZA PAJ WL AC 17', '', '', '', 11, 11, 'UND', 'G', '6.0000', '0.0000', '0.0000', '6.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(394, 'CILINDRO CON PISTON PARA FS 280 STHIL', '', '', '', 11, 11, 'UND', 'G', '420.0000', '0.0000', '0.0000', '410.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(395, 'ESMERIL 1 HP DEREK MOTORS', '', '', '', 16, 16, 'UND', 'G', '300.0000', '0.0000', '0.0000', '250.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(396, 'CARBURADOR MOTOR GASOLINERO MOTOBOMBA 4X4 KAZO', '', '', '', 11, 11, 'UND', 'G', '89.0000', '0.0000', '0.0000', '72.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(397, 'LANZA PARA FUMIGAR 5 BOQUILLAS', '', '', '', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '15.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(398, 'MOCHILA FUMIGADORA A PRESION DE 5 LT KAZO', '', '', '', 2, 2, 'UND', 'G', '25.0000', '0.0000', '0.0000', '25.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(399, 'MOCHILA FUMIGADORA  MANUAL DE 16 LT KASO', '', '', '', 2, 2, 'UND', 'G', '90.0000', '0.0000', '0.0000', '78.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(400, 'MOCHILA FUMIGADORA MANUAL KASO 20LT KAZO', '', '', '', 2, 2, 'UND', 'G', '99.0000', '0.0000', '0.0000', '70.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(401, 'CILINDRO BRONCE /TORIGINAL /PMOCHILA S/M', '', '', '', 11, 11, 'UND', 'G', '58.8000', '0.0000', '0.0000', '58.8000', 0, 0, NULL, 1, NULL, NULL, NULL),
(402, 'VALVULA INTERIOR DE BRONCE', '', '', '', 11, 11, 'UND', 'G', '14.6000', '0.0000', '0.0000', '14.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(403, 'CILINDRO GUARANY', '', '', '65007', 2, 2, 'UND', 'G', '15.0000', '0.0000', '0.0000', '15.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(404, 'VALVULA SEMI ESFERICA K5066-ND', '', '', '65066', 11, 11, 'UND', 'G', '0.4600', '0.0000', '0.0000', '0.4600', 0, 0, NULL, 1, NULL, NULL, NULL),
(405, 'ARRANCADOR P/MOCHILA 2TIEMPOS', '', '', '', 11, 11, 'UND', 'G', '75.0000', '0.0000', '0.0000', '50.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(406, 'RE.BOQUILLA SIMPLE', '', '', '', 11, 11, 'UND', 'G', '1.7000', '0.0000', '0.0000', '1.7000', 0, 0, NULL, 1, NULL, NULL, NULL),
(407, 'BUZO COVERSAL BLANCO 50GRS T XL DEREK SAFETY', '', '', '', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '10.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(408, 'PULVERIZADOR C/ACCESORIOS', '', '', '', 11, 11, 'UND', 'G', '27.0000', '0.0000', '0.0000', '23.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(409, 'PISTOLA DE PINTAR', '', '', '', 11, 11, 'UND', 'G', '18.0000', '0.0000', '0.0000', '15.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(410, 'CABEZAL DE FUMIGADOR TF-30H', '', '', '', 11, 11, 'UND', 'G', '480.0000', '0.0000', '0.0000', '350.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(411, 'CARBURADOR 5.5 HP', '', '', '', 11, 11, 'UND', 'G', '18.0000', '0.0000', '0.0000', '18.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(412, 'MOTOBOMBA DE 2 ´ JET AGRO', '', '', '', 19, 19, 'UND', 'G', '650.0000', '0.0000', '0.0000', '600.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(413, 'TUBO CUADRADO', '', '', '', 16, 16, 'UND', 'G', '45.0000', '0.0000', '0.0000', '40.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(414, 'BOQUILLA 80 02 AMARILLA', '', '', '', 7, 7, 'UND', 'G', '12.0000', '0.0000', '0.0000', '9.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(415, 'VENTILADOR M1200', '', '', '', 11, 11, 'UND', 'G', '120.0000', '0.0000', '0.0000', '100.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(416, 'REGULADOR DE PRESION PESADO 80', '', '', '', 11, 11, 'UND', 'G', '55.0000', '0.0000', '0.0000', '55.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(417, 'CABLE ACELERACION CON PERNO', '', '', '', 11, 11, 'UND', 'G', '12.0000', '0.0000', '0.0000', '12.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(418, 'MANGUERA FUMIGACION CON TERMINALES 700 PSI 13MM', '', '', '', 11, 11, 'UND', 'G', '387.0000', '0.0000', '0.0000', '387.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(420, 'DESBROZADORA B450/AUS CC', '', '', '', 3, 3, 'UND', 'G', '2200.0000', '0.0000', '0.0000', '2000.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(421, 'MOTOBOMBA DE AGUA DE 3\"', '', '', '', 19, 19, 'UND', 'G', '400.0000', '0.0000', '0.0000', '250.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(422, 'MOTOBOMBA DE AGUA DE 2\"', '', '', '', 19, 19, 'UND', 'G', '400.0000', '0.0000', '0.0000', '350.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(423, 'ALARGADERA DE 1.80  CM WHALE', '', '', '', 11, 11, 'UND', 'G', '55.0000', '0.0000', '0.0000', '50.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(424, 'LANAZA HIDROLAVADORA 200 CM P/GIRATORIA', '', '', '', 20, 20, 'UND', 'G', '180.0000', '0.0000', '0.0000', '90.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(425, 'LANZA HIDROLAVADORA 200 CM P/GIRATORIA', '', '', '', 20, 20, 'UND', 'G', '35.0000', '0.0000', '0.0000', '30.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(426, 'PISTOLA RESEADORA METAL KAZO', '', '', '', 20, 20, 'UND', 'G', '13.0000', '0.0000', '0.0000', '13.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(427, 'MOCHILA FUMIGADORA PORTATIL 8  LTS KAZO', '', '', '', 2, 2, 'UND', 'G', '50.0000', '0.0000', '0.0000', '45.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(428, 'PORTA MICRO C/ROSCA METAL', '', '', '', 11, 11, 'UND', 'G', '2.8000', '0.0000', '0.0000', '2.8000', 0, 0, NULL, 1, NULL, NULL, NULL),
(429, 'MICROFONO INALANBRICO DIGITAL 50-80 MTS', '', '', '', 11, 11, 'UND', 'G', '375.0000', '0.0000', '0.0000', '375.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(430, 'NAYLON /GUADAÑA NEGRO', '', '', '', 11, 11, 'UND', 'G', '300.0000', '0.0000', '0.0000', '300.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(431, 'PERCEPCION', '', '', '', 16, 16, 'UND', 'G', '0.0000', '0.0000', '0.0000', '0.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(432, 'CAJA ARRANQUE TU26 FST', '', '', '', 11, 11, 'UND', 'G', '25.0000', '0.0000', '0.0000', '22.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(433, 'CAJA ARRANQUE GX35 FST', '', '', '', 11, 11, 'UND', 'G', '20.0000', '0.0000', '0.0000', '20.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(434, 'BOQUILLA PLASTICA DE 02 ORIFICIOS FST', '', '', '', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '12.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(435, 'BOQUILLA METALICA S FST', '', '', '', 11, 11, 'UND', 'G', '10.0000', '0.0000', '0.0000', '10.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(436, 'SACAVUELTAS DE 8.5 L MM FST', '', '', '', 11, 11, 'UND', 'G', '12.0000', '0.0000', '0.0000', '12.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(437, 'SACAVUELTAS DE 8.5 MM FST', '', '', '', 11, 11, 'UND', 'G', '10.5000', '0.0000', '0.0000', '10.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(438, 'BUJIA GX35 FST', '', '', '', 11, 11, 'UND', 'G', '20.0000', '0.0000', '0.0000', '15.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(439, 'MANOMETRO 32W-45 FST', '', '', '', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '15.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(440, 'CABLE ACELERADOR GX35 FST', '', '', '', 11, 11, 'UND', 'G', '10.0000', '0.0000', '0.0000', '10.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(441, 'ABRAZADERA PRESNADO', '', '', '', 11, 11, 'UND', 'G', '0.2200', '0.0000', '0.0000', '0.2200', 0, 0, NULL, 1, NULL, NULL, NULL),
(442, 'TUBO DE CONEXIONES 16HD-1', '', '', '', 11, 11, 'UND', 'G', '16.0000', '0.0000', '0.0000', '15.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(443, 'VOLTIMETRO 16DH-1', '', '', '', 11, 11, 'UND', 'G', '3.9900', '0.0000', '0.0000', '3.9900', 0, 0, NULL, 1, NULL, NULL, NULL),
(444, 'REGULADOR DE INTENSIDAD', '', '', '', 11, 11, 'UND', 'G', '10.0000', '0.0000', '0.0000', '10.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(445, 'TOMA DE CARGADOR', '', '', '', 11, 11, 'UND', 'G', '4.5600', '0.0000', '0.0000', '4.5600', 0, 0, NULL, 1, NULL, NULL, NULL),
(446, 'INTERRUPTOR', '', '', '', 11, 11, 'UND', 'G', '4.0000', '0.0000', '0.0000', '4.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(447, 'CARBURADOR DE 9.0', '', '', '', 11, 11, 'UND', 'G', '120.0000', '0.0000', '0.0000', '100.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(448, 'CABEZAL DE HIDROLAVADORA WL -120 H(V)', '', '', '', 13, 13, 'UND', 'G', '600.0000', '0.0000', '0.0000', '550.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(449, 'MOTOR GASOLINERO DE 13 HP', '', '', '', 8, 8, 'UND', 'G', '540.0000', '0.0000', '0.0000', '540.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(450, 'BOTELLA', '', '', '', 11, 11, 'UND', 'G', '25.0000', '0.0000', '0.0000', '21.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(451, 'VALVULA DE BRONCE', '', '', '', 11, 11, 'UND', 'G', '2.1000', '0.0000', '0.0000', '2.1000', 0, 0, NULL, 1, NULL, NULL, NULL),
(452, 'PISTON 048 STHIL  P/SR440', '', '', '4244-030-2006', 11, 11, 'UND', 'G', '290.0000', '0.0000', '0.0000', '290.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(453, 'SELLO MECANICO', '', '', '', 11, 11, 'UND', 'G', '18.0000', '0.0000', '0.0000', '18.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(454, 'SOGILLA ARRANQUE GX390', '', '', '', 11, 11, 'UND', 'G', '8.4000', '0.0000', '0.0000', '8.4000', 0, 0, NULL, 1, NULL, NULL, NULL),
(455, 'LLAVE BUJIA', '', '', '', 11, 11, 'UND', 'G', '10.5000', '0.0000', '0.0000', '10.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(456, 'FA301-12', '', '', '', 11, 11, 'UND', 'G', '4.2000', '0.0000', '0.0000', '4.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(457, 'CILINDRO COMPLETO 660', '', '', '', 11, 11, 'UND', 'G', '250.0000', '0.0000', '0.0000', '150.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(458, 'MANGUERA DE 2 PARA MOTOBOMBA NARANJA', '', '', '', 11, 11, 'UND', 'G', '18.0000', '0.0000', '0.0000', '15.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(459, 'LLAVE DE PASO PVC', '', '', '', 11, 11, 'UND', 'G', '10.5000', '0.0000', '0.0000', '10.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(460, 'NIPLE PVC', '', '', '', 11, 11, 'UND', 'G', '5.0000', '0.0000', '0.0000', '4.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(461, 'KIT DE REPARACION BOMBA APS 145', '', '', '', 11, 11, 'UND', 'G', '1500.0000', '0.0000', '0.0000', '1390.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(463, 'TURBO JET 20DA', '', '', '', 1, 1, 'UND', 'G', '125.0000', '0.0000', '0.0000', '120.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(464, 'TURBOJETT 80WP  MOTOBOMBA 3X3', '', '', '', 19, 19, 'UND', 'G', '550.0000', '0.0000', '0.0000', '130.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(465, 'CONECTOR DE LATON', '', '', '', 11, 11, 'UND', 'G', '4.2000', '0.0000', '0.0000', '4.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(466, 'CONECTOR LATON B59', '', '', '', 11, 11, 'UND', 'G', '6.0000', '0.0000', '0.0000', '6.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(467, 'CONECTOR DE LATON B', '', '', '', 11, 11, 'UND', 'G', '2.7000', '0.0000', '0.0000', '2.7000', 0, 0, NULL, 1, NULL, NULL, NULL),
(468, 'CONECTOR DE LATON B62', '', '', '', 11, 11, 'UND', 'G', '7.0000', '0.0000', '0.0000', '5.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(469, 'CONECTOR DE LATON A', '', '', '', 11, 11, 'UND', 'G', '2.7000', '0.0000', '0.0000', '2.7000', 0, 0, NULL, 1, NULL, NULL, NULL),
(470, 'CARBURADOR BIGDIN GX35', '', '', '', 11, 11, 'UND', 'G', '22.0000', '0.0000', '0.0000', '22.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(471, 'CARBURADOR YIMBA 2 TIEMPOS', '', '', '', 11, 11, 'UND', 'G', '22.0000', '0.0000', '0.0000', '22.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(472, 'VALVULA 30H', '', '', '', 11, 11, 'UND', 'G', '1.2000', '0.0000', '0.0000', '1.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(473, 'BOMBA DE LATON 4T', '', '', '', 11, 11, 'UND', 'G', '100.0000', '0.0000', '0.0000', '94.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(474, 'BOMBA DE LATON P14', '', '', '', 11, 11, 'UND', 'G', '130.0000', '0.0000', '0.0000', '124.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(475, 'EMPAQUETADURA', '', '', '', 11, 11, 'UND', 'G', '1.0000', '0.0000', '0.0000', '1.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(476, 'RODAMIENTO 608', '', '', '', 11, 11, 'UND', 'G', '0.4000', '0.0000', '0.0000', '0.4000', 0, 0, NULL, 1, NULL, NULL, NULL),
(477, 'RODAMIENTOS 6200', '', '', '', 11, 11, 'UND', 'G', '0.8000', '0.0000', '0.0000', '0.8000', 0, 0, NULL, 1, NULL, NULL, NULL),
(478, 'RODAMIENTO 6201', '', '', '', 11, 11, 'UND', 'G', '1.5000', '0.0000', '0.0000', '1.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(479, 'MANGUERA CORTA 15 CM', '', '', '', 11, 11, 'UND', 'G', '2.5500', '0.0000', '0.0000', '2.5500', 0, 0, NULL, 1, NULL, NULL, NULL),
(480, 'CABLE COMP ACELERADOR', '', '', '', 11, 11, 'UND', 'G', '1.0000', '0.0000', '0.0000', '1.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(481, 'EMBOLO', '', '', '', 11, 11, 'UND', 'G', '4.5000', '0.0000', '0.0000', '4.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(482, 'DISCO DE BOQUILLA', '', '', '', 11, 11, 'UND', 'G', '1.0000', '0.0000', '0.0000', '0.8000', 0, 0, NULL, 1, NULL, NULL, NULL),
(483, 'FILTRO COMBUSTIBLE', '', '', '', 11, 11, 'UND', 'G', '1.0000', '0.0000', '0.0000', '1.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(484, 'PLACA BASE GX35', '', '', '', 11, 11, 'UND', 'G', '1.2000', '0.0000', '0.0000', '1.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(485, 'BOQUILLA JAPAN', '', '', '', 11, 11, 'UND', 'G', '4.0000', '0.0000', '0.0000', '4.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(486, 'BASE METAL WL-AC-07', '', '', '', 11, 11, 'UND', 'G', '13.0000', '0.0000', '0.0000', '10.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(487, 'VALVULA DE BRONCE WL-AC-01', '', '', '', 11, 11, 'UND', 'G', '2.1000', '0.0000', '0.0000', '2.1000', 0, 0, NULL, 1, NULL, NULL, NULL),
(488, 'BOQUILLA PVC AZUL WL-B02', '', '', '', 11, 11, 'UND', 'G', '10.0000', '0.0000', '0.0000', '8.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(489, 'KIT PODADORA DE ALTURA STHIL KM85R HTC/', '', '', '', 3, 3, 'UND', 'G', '2300.0000', '0.0000', '0.0000', '2280.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(490, 'CUERDA DE ARRANQUE 4.5 MMX100M PT', '', '', '', 11, 11, 'UND', 'G', '0.8000', '0.0000', '0.0000', '0.8000', 0, 0, NULL, 1, NULL, NULL, NULL),
(491, 'CABEZAL HIDROLAVADORA AC30A1N KAZO', '', '', '', 13, 13, 'UND', 'G', '300.0000', '0.0000', '0.0000', '260.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(492, 'ANILLO DE JEBEP/CABEZAL 6.5 HP 25PCS KAZO', '', '', '', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '3.4000', 0, 0, NULL, 1, NULL, NULL, NULL),
(493, 'ANILLO DE JEBEP/CABEZAL 9 HP 25PCS KAZO', '', '', '', 11, 11, 'UND', 'G', '16.0000', '0.0000', '0.0000', '14.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(494, 'LANZA HIDROLAVADORA 90CMP/GIRATORIA', '', '', '', 11, 11, 'UND', 'G', '19.0000', '0.0000', '0.0000', '19.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(495, 'LANZA HIDROLAVADORA 90CM KAZO', '', '', '', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '12.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(496, 'PANEL SOLAR 2W6V 03A 135X140X17MM 1X5 CABLES 2MTS SANWIN', '', '', '', 23, 23, 'UND', 'G', '14.0000', '0.0000', '0.0000', '14.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(497, 'PANEL SOLAR 3W6V0.3A135X220X19MM 1X5CABLES 2MTS', '', '', '', 23, 23, 'UND', 'G', '18.0000', '0.0000', '0.0000', '18.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(498, 'PANEL SOLAR5W6V0.83A180X270X17MM 1X5CABLES 2MTS', '', '', '', 23, 23, 'UND', 'G', '24.0000', '0.0000', '0.0000', '24.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(499, 'LAMPARA DE EMERGENCIA 24LEDSC/BATERIALI-ON SANWIN', '', '', '', 11, 11, 'UND', 'G', '48.0000', '0.0000', '0.0000', '48.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(501, 'MOTOSIERRA PT720 25\" 3/8', '', '', '', 4, 4, 'UND', 'G', '1260.0000', '0.0000', '0.0000', '1260.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(502, 'BARRA DE 25 \" PT 3/8', '', '', '', 11, 11, 'UND', 'G', '120.0000', '0.0000', '0.0000', '100.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(503, 'CADENA CUADRADA 3/8', '', '', '', 11, 11, 'UND', 'G', '0.6800', '0.0000', '0.0000', '0.6800', 0, 0, NULL, 1, NULL, NULL, NULL),
(506, 'FS 280 MOTODESMALEZADORA,DM 300-3', '', '', '4119-204-0014', 3, 3, 'UND', 'G', '1757.0000', '0.0000', '0.0000', '1757.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(510, 'FS 250 MOTODESMALEZADORA,DM 250-3', '', '', '', 3, 3, 'UND', 'G', '1400.0000', '0.0000', '0.0000', '1370.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(511, 'CUERDA DE ARRANQUE EMAK', '', '', '', 11, 11, 'UND', 'G', '135.0000', '0.0000', '0.0000', '120.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(512, 'MANGUERA DE SUCCION', '', '', '', 11, 11, 'UND', 'G', '34.0000', '0.0000', '0.0000', '34.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(513, 'BPMBA A PISTON 34L/M EMBOLO CERAMICO WHALE', '', '', '', 13, 13, 'UND', 'G', '980.0000', '0.0000', '0.0000', '950.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(516, 'MOTOGUADAÑA 47 9 CC 2 HP GX 50 HONDA 4 T', '', '', '', 3, 3, 'UND', 'G', '1800.0000', '0.0000', '0.0000', '1500.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(517, 'MOTOR GAS 6.5 HP A/M 1C HONDA GP200', '', '', '', 8, 8, 'UND', 'G', '990.0000', '0.0000', '0.0000', '990.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(518, 'TANQUE DE GASOLINA 1 GALON', '', '', '', 11, 11, 'UND', 'G', '35.0000', '0.0000', '0.0000', '32.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(519, 'ACEITE P/MOTOR SAE 10W30 X 1/4 GALON', '', '', '', 10, 10, 'UND', 'G', '16.2200', '0.0000', '0.0000', '16.2200', 0, 0, NULL, 1, NULL, NULL, NULL),
(520, 'MOTOGUADAÑA UMK450T', '', '', '', 3, 3, 'UND', 'G', '1870.0000', '0.0000', '0.0000', '1850.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(521, 'GRIFO REGULADOR DE LIQUIDOS', '', '', '', 11, 11, 'UND', 'G', '25.0000', '0.0000', '0.0000', '25.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(522, 'PUL. AGRICOLA MANUAL JACTO HD-400', '', '', '11-01-002-4600716', 2, 2, 'UND', 'G', '280.0000', '0.0000', '0.0000', '250.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(523, 'PULV AGRICOLA MANUAL JACTO XP-20', '', '', '11-01-003-200418', 2, 2, 'UND', 'G', '220.0000', '0.0000', '0.0000', '220.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(525, 'PULV AGRICOLA MOTORIZADA JACTO', '', '', '11-03-004-70020', 1, 1, 'UND', 'G', '1850.0000', '0.0000', '0.0000', '1600.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(528, 'MOTOAZADA GODDYEAR GY700TL 7HP', '', '', '', 24, 24, 'UND', 'G', '3900.0000', '0.0000', '0.0000', '3600.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(529, 'FERRULA BAJA PRESION 1/4', '', '', '', 11, 11, 'UND', 'G', '0.6000', '0.0000', '0.0000', '0.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(530, 'MANGUERA DE FUMIGACION CON TERMINALES 600PSI5/16', '', '', '', 12, 12, 'UND', 'G', '0.5000', '0.0000', '0.0000', '0.4500', 0, 0, NULL, 1, NULL, NULL, NULL),
(532, 'ATOMIZADOR CIFARELLI M1200', '', '', '', 1, 1, 'UND', 'G', '2200.0000', '0.0000', '0.0000', '2100.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(533, 'ACEITE GALON SHINDAIWA', '', '', '', 10, 10, 'UND', 'G', '90.0000', '0.0000', '0.0000', '90.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(534, 'SEGMENTO DE PISTON 2048116', '', '', '', 11, 11, 'UND', 'G', '19.2000', '0.0000', '0.0000', '19.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(535, 'MANGUERA PVC LOY-FLAT 2\" LECCO', '', '', '', 12, 12, 'UND', 'G', '350.0000', '0.0000', '0.0000', '300.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(536, 'MANGUERA PVC LOY-FLAT 3\" LECCO', '', '', '', 12, 12, 'UND', 'G', '480.0000', '0.0000', '0.0000', '420.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(537, 'ACCESORIOS BOMBA 3X3, LECCO', '', '', '', 11, 11, 'UND', 'G', '45.0000', '0.0000', '0.0000', '35.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(538, 'VALVULA ACERO AC 120', '', '', '', 11, 11, 'UND', 'G', '8.9000', '0.0000', '0.0000', '8.9000', 0, 0, NULL, 1, NULL, NULL, NULL),
(539, 'LANZA P/HIDROLAVADO, S/M', '', '', '', 20, 20, 'UND', 'G', '21.0000', '0.0000', '0.0000', '21.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(540, 'MOTOSIERRA 24, DEREK MOTORS', '', '', '', 4, 4, 'UND', 'G', '450.0000', '0.0000', '0.0000', '450.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(541, 'DESBROZADORA 2HP 42.7CC 1500W DEREK', '', '', '', 3, 3, 'UND', 'G', '0.0000', '0.0000', '0.0000', '0.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(542, 'DESBROZADORA 2HP 42.7CC 1500W', '', '', '', 3, 3, 'UND', 'G', '650.0000', '0.0000', '0.0000', '550.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(544, 'KIT DE BARRA DE PULVERIZACION', '', '', '', 6, 6, 'UND', 'G', '1200.0000', '0.0000', '0.0000', '1000.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(545, 'DESTORNILLADOR D CUT', '', '', '', 11, 11, 'UND', 'G', '12.6000', '0.0000', '0.0000', '12.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(546, 'TAPA DE TANQUE DE COMBUSTIBLE', '', '', '', 11, 11, 'UND', 'G', '28.0000', '0.0000', '0.0000', '28.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(547, 'LANZA DE PULVERIZACION DE 60 CM LXC 202', '', '', '', 20, 20, 'UND', 'G', '125.0000', '0.0000', '0.0000', '120.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(548, 'ADAPTADOR DE 13 MM', '', '', '', 11, 11, 'UND', 'G', '7.0000', '0.0000', '0.0000', '5.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(549, 'BOQUILLA EN CERAMICA D 1MM', '', '', '', 11, 11, 'UND', 'G', '10.0000', '0.0000', '0.0000', '8.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(550, 'ELECTROB. PERIFERICA 0.5HP 1F 24M@20LPM 1\"', '', '', '', 25, 25, 'UND', 'G', '170.0000', '0.0000', '0.0000', '150.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(551, 'ELECTROB. PERIFERICA 0.5HP 1F HMAX:35M QMAX:', '', '', '', 25, 25, 'UND', 'G', '150.0000', '0.0000', '0.0000', '135.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(552, 'BOQUILLA REGULABLE ROJA', '', '', '13-01-002-415024', 11, 11, 'UND', 'G', '10.0000', '0.0000', '0.0000', '8.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(553, 'BOQUILLA CONICA ATR 0.5 /BLANCO', '', '', '13-02-005-470360', 7, 7, 'UND', 'G', '24.0000', '0.0000', '0.0000', '24.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(554, 'DESBROZADORA EVOX 800 CON GX50 MORI', '', '', '', 3, 3, 'UND', 'G', '1800.0000', '0.0000', '0.0000', '1550.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(556, 'BOMBA PISTON 34 LM CON MOTOR GP160 WHALE', '', '', '', 5, 5, 'UND', 'G', '2200.0000', '0.0000', '0.0000', '2100.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(557, 'PULVERIZADOR ELECTRICO PANTHERA 20 LTS', '', '', '', 22, 22, 'UND', 'G', '225.0000', '0.0000', '0.0000', '210.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(558, 'FAJAS A 39 BOMBA', '', '', '', 11, 11, 'UND', 'G', '12.6000', '0.0000', '0.0000', '12.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(559, 'EQUIPO DE PROTECCION IND.', '', '', '', 11, 11, 'UND', 'G', '180.0000', '0.0000', '0.0000', '180.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(560, 'MOTOR GAS. 5.5HP A/M 1C OHV 3600RPM', '', '', '', 8, 8, 'UND', 'G', '430.0000', '0.0000', '0.0000', '430.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(561, 'MOTOR GAS. 5.5HP A/M 1C 170F', '', '', '', 8, 8, 'UND', 'G', '350.0000', '0.0000', '0.0000', '350.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(562, 'MOTOFUMIG. 5.5HP 570PSI C/MANG. 100M. H170F', '', '', '', 8, 8, 'UND', 'G', '990.0000', '0.0000', '0.0000', '990.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(563, 'ACEITE P/MOTOR SAE20W50 X 1/4 GALON [20W50]', '', '', '', 10, 10, 'UND', 'G', '25.0000', '0.0000', '0.0000', '20.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(564, 'PULV AGRICOLA MANUAL JACTO XP12', '', '', '', 2, 2, 'UND', 'G', '230.0000', '0.0000', '0.0000', '200.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(565, 'PULV PORTATIL DE MANO JACTO HH5', '', '', '', 2, 2, 'UND', 'G', '80.0000', '0.0000', '0.0000', '80.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(566, 'POLEA EN V 5.5 6.5 ALUMINIO', '', '', '', 11, 11, 'UND', 'G', '7.4000', '0.0000', '0.0000', '7.4000', 0, 0, NULL, 1, NULL, NULL, NULL),
(567, 'GENERADOR DE 1.0 KW 220 V 60HZ V RATO', '', '', '', 9, 9, 'UND', 'G', '1150.0000', '0.0000', '0.0000', '900.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(568, 'PULVERIZADOR MATABI SUPER AGRO 20', '', '', '', 2, 2, 'UND', 'G', '300.0000', '0.0000', '0.0000', '250.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(569, 'SR 450 ATOMIZADOR', '', '', '4144-0011-2663', 1, 1, 'UND', 'G', '2000.0000', '0.0000', '0.0000', '2000.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(571, 'MOTOBOMBA AUTOSEVANTE 4X4 CON MOTOR DE 10 HP', '', '', '', 19, 19, 'UND', 'G', '2200.0000', '0.0000', '0.0000', '440.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(572, 'CAMPANA DE 2 TIEPOS', '', '', '', 11, 11, 'UND', 'G', '30.0000', '0.0000', '0.0000', '22.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(573, 'CORREAS DE MOCHILA A MOTOR', '', '', '', 11, 11, 'UND', 'G', '21.0000', '0.0000', '0.0000', '21.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(574, 'ARRANCADOR DE 4 TIEMPOS', '', '', '', 11, 11, 'UND', 'G', '40.0000', '0.0000', '0.0000', '35.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(575, 'FAJA CONTINENTAL A39', '', '', '', 11, 11, 'UND', 'G', '11.8100', '0.0000', '0.0000', '11.8100', 0, 0, NULL, 1, NULL, NULL, NULL),
(576, 'PERNOS', '', '', '', 11, 11, 'UND', 'G', '2.0000', '0.0000', '0.0000', '1.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(577, 'CAJA REDUCTORA 4137 STHIL FS250 FS450', '', '', '', 11, 11, 'UND', 'G', '298.0000', '0.0000', '0.0000', '280.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(578, 'MODULO DE IGNICION STHIL 4134 -400-1312', '', '', '', 11, 11, 'UND', 'G', '190.0000', '0.0000', '0.0000', '180.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(579, 'GATILLO UNIVERSAL', '', '', '', 11, 11, 'UND', 'G', '4.9200', '0.0000', '0.0000', '4.9200', 0, 0, NULL, 1, NULL, NULL, NULL),
(580, 'CARBURADOR COMPLETO P/SHP800', '', '', '', 11, 11, 'UND', 'G', '350.0000', '0.0000', '0.0000', '300.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(581, 'TEE HDPE DENTADA 16 MM IIRITEC', '', '', '', 11, 11, 'UND', 'G', '2.0000', '0.0000', '0.0000', '1.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(582, 'PCS FUMIGADORA MANUAL  20 LT SPRAYER', '', '', '', 2, 2, 'UND', 'G', '75.0000', '0.0000', '0.0000', '60.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(583, 'PCS FUMIGADORA MANUAL 20LT SPRAYER', '', '', '', 2, 2, 'UND', 'G', '100.0000', '0.0000', '0.0000', '80.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(584, 'CONECTORES DE 1/2', '', '', '', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '12.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(585, 'NIPLES DE 1/2 X 1/4', '', '', '', 11, 11, 'UND', 'G', '8.5000', '0.0000', '0.0000', '8.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(586, 'KIT CAJA ARRANQUE M1200', '', '', '', 11, 11, 'UND', 'G', '180.0000', '0.0000', '0.0000', '165.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(587, 'FS 235 MOTODESMALEZADORA', '', '', '4151-200-0018', 3, 3, 'UND', 'G', '1800.0000', '0.0000', '0.0000', '1200.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(589, 'HT 103 PODADORA DE ALTURA,30CM/12\",71PM3', '', '', '4182-200-0140', 3, 3, 'UND', 'G', '2500.0000', '0.0000', '0.0000', '2000.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(591, 'MS 651 MOTOSIERRA,90CM/36\",46RM', '', '', '1144-200-0232', 4, 4, 'UND', 'G', '2800.0000', '0.0000', '0.0000', '2750.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(592, 'HILO CORTE CUADRADO Ø 3,0 MM X 53,0 M AMARILLO', '', '', '0000-930-2644', 11, 11, 'UND', 'G', '57.0000', '0.0000', '0.0000', '57.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(593, 'PULVERIZADORA 20 LTS', '', '', '', 2, 2, 'UND', 'G', '2.8800', '0.0000', '0.0000', '288.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(594, 'RUEDAS DE AIRE TRACTOR', '', '', '', 11, 11, 'UND', 'G', '54.0000', '0.0000', '0.0000', '54.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(595, 'EMBRAGUE GY6125', '', '', '', 11, 11, 'UND', 'G', '150.0000', '0.0000', '0.0000', '140.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(596, 'RECIPIENTE CAJUELA', '', '', '', 11, 11, 'UND', 'G', '90.0000', '0.0000', '0.0000', '65.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(597, 'CUBIERTA INDICADORES', '', '', '', 11, 11, 'UND', 'G', '50.0000', '0.0000', '0.0000', '38.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(598, 'CERRADURA DE ASIENTO', '', '', '', 11, 11, 'UND', 'G', '20.0000', '0.0000', '0.0000', '15.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(599, 'KIT DE CERRADURAS', '', '', '', 11, 11, 'UND', 'G', '150.0000', '0.0000', '0.0000', '135.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(600, 'ARNET PRINCIPAL', '', '', '', 11, 11, 'UND', 'G', '150.0000', '0.0000', '0.0000', '140.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(601, 'ARNET SUPLEMENTARIO', '', '', '', 11, 11, 'UND', 'G', '50.0000', '0.0000', '0.0000', '45.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(602, 'AMORTIGUADOR POSTERIOR', '', '', '', 11, 11, 'UND', 'G', '140.0000', '0.0000', '0.0000', '120.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(603, 'PORTA CELULAR', '', '', '', 11, 11, 'UND', 'G', '50.0000', '0.0000', '0.0000', '45.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(604, 'VASO PARA MOCHILA FUMIGAR', '', '', '', 11, 11, 'UND', 'G', '16.8000', '0.0000', '0.0000', '16.8000', 0, 0, NULL, 1, NULL, NULL, NULL),
(605, 'BOTELLA PARA MOCHILA DE FUMIGAR', '', '', '', 11, 11, 'UND', 'G', '61.0000', '0.0000', '0.0000', '61.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(606, 'PERNOS MILIMETRICOS', '', '', '', 11, 11, 'UND', 'G', '140.0000', '0.0000', '0.0000', '135.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(607, 'GRASA AMARILLA', '', '', '', 11, 11, 'UND', 'G', '17.0000', '0.0000', '0.0000', '15.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(608, 'BUJIA ENCENDIDO ECOLOG.E/P', '', '', 'BP5EY', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '10.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(609, 'EXTENSION CROMADA PARA MOCHILA DE FUMIGAR', '', '', '', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '15.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(610, 'MOCHILA ULV', '', '', '', 26, 26, 'UND', 'G', '360.0000', '0.0000', '0.0000', '347.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(611, 'THERMONEVULIZADOR', '', '', '', 27, 27, 'UND', 'G', '668.0000', '0.0000', '0.0000', '668.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(612, 'PROTECTOR FACIAL', '', '', '', 28, 28, 'UND', 'G', '4.2000', '0.0000', '0.0000', '4.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(613, 'MASCARA RESPIRATORIA', '', '', '', 29, 29, 'UND', 'G', '3.6000', '0.0000', '0.0000', '3.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(614, 'GAFAS PROTECTORAS', '', '', '', 30, 30, 'UND', 'G', '1.3600', '0.0000', '0.0000', '1.3600', 0, 0, NULL, 1, NULL, NULL, NULL),
(615, 'PULVERIZADOR', '', '', '', 1, 1, 'UND', 'G', '750.0000', '0.0000', '0.0000', '700.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(616, 'PRENSA DE MANGUERA', '', '', '', 11, 11, 'UND', 'G', '254.0000', '0.0000', '0.0000', '254.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(617, 'CONECTOR DE MANGUERA', '', '', '', 11, 11, 'UND', 'G', '1.2700', '0.0000', '0.0000', '1.2700', 0, 0, NULL, 1, NULL, NULL, NULL),
(618, 'CONECTOR DE MANGUERA 8.5', '', '', '', 11, 11, 'UND', 'G', '1.0000', '0.0000', '0.0000', '1.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(619, 'LANZA RECTA', '', '', '', 11, 11, 'UND', 'G', '12.0000', '0.0000', '0.0000', '10.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(620, 'PISTON', '', '', '', 11, 11, 'UND', 'G', '12.0000', '0.0000', '0.0000', '12.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(621, 'ANILLO DE PISTON JOLD', '', '', '', 11, 11, 'UND', 'G', '6.0000', '0.0000', '0.0000', '5.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(622, 'BOQUILLA PARA PULVERIZAR', '', '', '', 11, 11, 'UND', 'G', '1.5000', '0.0000', '0.0000', '0.9500', 0, 0, NULL, 1, NULL, NULL, NULL),
(623, 'NAYLON 3.0', '', '', '', 11, 11, 'UND', 'G', '10.8000', '0.0000', '0.0000', '10.8000', 0, 0, NULL, 1, NULL, NULL, NULL),
(624, 'NAYLON 2', '', '', '', 11, 11, 'UND', 'G', '10.8000', '0.0000', '0.0000', '10.8000', 0, 0, NULL, 1, NULL, NULL, NULL),
(625, 'CONECTORES', '', '', '', 11, 11, 'UND', 'G', '48.0000', '0.0000', '0.0000', '45.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(626, 'ELECTROB CENT 5.5 HP 3F 220V', '', '', '', 25, 25, 'UND', 'G', '1500.0000', '0.0000', '0.0000', '1400.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(627, 'FAJA LISA B46', '', '', '', 11, 11, 'UND', 'G', '18.9000', '0.0000', '0.0000', '18.9000', 0, 0, NULL, 1, NULL, NULL, NULL),
(628, 'MOTOSIERRA EFCO MTH 560 BARRA DE 20´', '', '', '', 4, 4, 'UND', 'G', '684.0000', '0.0000', '0.0000', '684.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(629, 'MOTOR DIESEL DE 10 HP 418 C ARRANQUE ELECTRICO', '', '', '', 8, 8, 'UND', 'G', '1600.0000', '0.0000', '0.0000', '1450.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(630, 'CABLE ACELERADOR M1200', '', '', '', 11, 11, 'UND', 'G', '58.0000', '0.0000', '0.0000', '45.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(631, 'BOMBA PISTON 133L/M EMBOLO CERAMICO', '', '', '', 13, 13, 'UND', 'G', '2980.0000', '0.0000', '0.0000', '2800.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(632, 'EXTENCION DE CORRIENTE', '', '', '', 11, 11, 'UND', 'G', '26.0000', '0.0000', '0.0000', '26.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(633, 'ADAPTADOR TOMA MULTIPLE', '', '', '', 11, 11, 'UND', 'G', '8.0000', '0.0000', '0.0000', '6.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(634, 'MOTOR GASOLINERO DE 5.5 HP PANTERA', '', '', '', 8, 8, 'UND', 'G', '400.0000', '0.0000', '0.0000', '400.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(635, 'JUNTA EXTERNA TUBO DE ESCAPE L3EVO', '', '', '', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '15.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(636, 'NANOMETRO DE 30', '', '', '', 11, 11, 'UND', 'G', '32.0000', '0.0000', '0.0000', '32.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(637, 'BUJIA GX35', '', '', '', 11, 11, 'UND', 'G', '10.5000', '0.0000', '0.0000', '10.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(638, 'JUNTA DE CILINDRO PTX2700', '', '', '', 11, 11, 'UND', 'G', '23.9400', '0.0000', '0.0000', '23.9400', 0, 0, NULL, 1, NULL, NULL, NULL),
(639, 'MOTOFUMIGADORA SR420', '', '', '', 1, 1, 'UND', 'G', '2000.0000', '0.0000', '0.0000', '1800.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(640, 'KIT COMPLETO DE MOCHILA DE FUMIGAR', '', '', '', 11, 11, 'UND', 'G', '9.4500', '0.0000', '0.0000', '9.4500', 0, 0, NULL, 1, NULL, NULL, NULL),
(641, 'ACEITE PARA MOTORES 2T 100ML', '', '', '', 10, 10, 'UND', 'G', '2.8000', '0.0000', '0.0000', '2.8000', 0, 0, NULL, 1, NULL, NULL, NULL),
(642, 'MOTOPULVERIZADOR CON MOTOR GX35', '', '', '', 1, 1, 'UND', 'G', '290.0000', '0.0000', '0.0000', '290.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(643, 'PULVERIZADOR KXF-H16E2', '', '', '', 31, 31, 'UND', 'G', '40.0000', '0.0000', '0.0000', '35.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(644, 'PULVERIZADOR KXF-002', '', '', '', 31, 31, 'UND', 'G', '12.0000', '0.0000', '0.0000', '9.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(645, 'BOMBA DE PULVERIZADOR', '', '', '', 32, 32, 'UND', 'G', '20.0000', '0.0000', '0.0000', '18.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(646, 'CONECTOR, SG-021, SG-023, SG-0', '', '', '', 11, 11, 'UND', 'G', '4.5200', '0.0000', '0.0000', '4.5200', 0, 0, NULL, 1, NULL, NULL, NULL),
(647, 'LLAVE DE PASO DE BOLA', '', '', '', 11, 11, 'UND', 'G', '3.0000', '0.0000', '0.0000', '2.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(648, 'PULVERIZADOR 20LT S/M KFX-H16E2', '', '', '', 2, 2, 'UND', 'G', '37.0000', '0.0000', '0.0000', '37.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(649, 'PULVERIZADOR VOLPI V-BLACK KOMFORT 16L', '', '', '', 2, 2, 'UND', 'G', '210.0000', '0.0000', '0.0000', '210.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(650, 'MOTOR GAS. 5.5HP A/M 1C OHV 163CC C/ALERTA', '', '', '', 8, 8, 'UND', 'G', '1200.0000', '0.0000', '0.0000', '1200.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(651, 'MOTOR ELECT. TRI(B) 5.5HPX1800RPM 220V/380V', '', '', '', 21, 21, 'UND', 'G', '518.0000', '0.0000', '0.0000', '518.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(652, 'MOTOR GAS. 13.0HP A/M 1C OHV 389CC 3600RPM', '', '', '', 8, 8, 'UND', 'G', '770.0000', '0.0000', '0.0000', '770.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(653, 'TECLE MANUAL 3.0TON 3.0M DE IZAJE', '', '', '', 21, 21, 'UND', 'G', '500.0000', '0.0000', '0.0000', '380.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(654, 'FAJA B 60 BANDO', '', '', '', 11, 11, 'UND', 'G', '22.0000', '0.0000', '0.0000', '22.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(655, 'MODULO DE IGNICIÓN STIHL 4134-400-1312 STIHL,STIHL', 'BOBINA FS250', '', '', 11, 11, 'UND', 'G', '180.0000', '0.0000', '0.0000', '180.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(656, 'FILTRO DE AIRE STIHL FS 450. 4134-141-0300,STIH', 'FILTRO 250', '', '', 11, 11, 'UND', 'G', '48.0000', '0.0000', '0.0000', '48.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(657, 'MOTOR GASOLINERO DE 22 HP', '', '', '', 8, 8, 'UND', 'G', '2580.0000', '0.0000', '0.0000', '2580.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(658, 'MOCHILA FUMIGADORA MANUAL GOODYEAR', '', '', '', 2, 2, 'UND', 'G', '260.0000', '0.0000', '0.0000', '260.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(659, 'MOTOAZADA GOOYEAR GY1000TL 7 HP', '', '', '', 24, 24, 'UND', 'G', '3720.0000', '0.0000', '0.0000', '3720.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(660, 'MOCHILA MANUAL GOODYEAR GY1600HS 16L', '', '', '', 2, 2, 'UND', 'G', '265.0000', '0.0000', '0.0000', '245.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(661, 'DESBROZADORA GOODYEAR GY52BCA 51.CC AVS', '', '', '', 3, 3, 'UND', 'G', '950.0000', '0.0000', '0.0000', '900.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(662, 'MOTOSIERRA GOODYEAR GY62CS 61.5 CC 22', '', '', '', 4, 4, 'UND', 'G', '850.0000', '0.0000', '0.0000', '850.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(663, 'SOPORTE APORCADOR A PATAS PANZER FERRARI', '', '', '', 11, 11, 'UND', 'G', '150.0000', '0.0000', '0.0000', '138.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(664, 'APORCADOR EXTENSIBLE PRO Y BARRA AJUSTE ALTURA', '', '', '', 11, 11, 'UND', 'G', '450.0000', '0.0000', '0.0000', '420.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(665, 'JUEGO DE RUEDAS METALICAS SIN EJES  DIAMETRO 520 ATR', '', '', '', 11, 11, 'UND', 'G', '1210.0000', '0.0000', '0.0000', '1100.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(666, 'EJE EXTENSIBLE CON DIFERENCIAL DE HEXAGONO DE 23MM', '', '', '', 11, 11, 'UND', 'G', '75.0000', '0.0000', '0.0000', '75.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(667, 'SILICONA', '', '', '', 11, 11, 'UND', 'G', '9.6000', '0.0000', '0.0000', '9.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(668, 'MANGUERA MULTIUSO', '', '', '', 11, 11, 'UND', 'G', '8.4000', '0.0000', '0.0000', '8.4000', 0, 0, NULL, 1, NULL, NULL, NULL),
(669, 'BRIDA INTERMEDIA 420', '', '', '', 11, 11, 'UND', 'G', '75.0000', '0.0000', '0.0000', '65.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(670, 'BATERIA 16HD', '', '', '', 11, 11, 'UND', 'G', '65.0000', '0.0000', '0.0000', '60.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(671, 'VALVULA LS475', '', '', '', 11, 11, 'UND', 'G', '26.0000', '0.0000', '0.0000', '26.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(672, 'KIT DE RETENES LS547', '', '', '', 11, 11, 'UND', 'G', '65.0000', '0.0000', '0.0000', '65.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(673, 'TANQUE DE COMBUSTIBLE 110', '', '', '', 11, 11, 'UND', 'G', '165.0000', '0.0000', '0.0000', '150.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(674, 'MANGUERA DE CARBURADOR DE 5.5', '', '', '', 11, 11, 'UND', 'G', '4.2000', '0.0000', '0.0000', '4.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(675, 'CONEXIONES DE 1/4', '', '', '', 11, 11, 'UND', 'G', '9.5000', '0.0000', '0.0000', '9.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(676, 'RODAMIENTO RIGIDO DE BOLAS 15X35X11', '', '', '', 11, 11, 'UND', 'G', '10.0000', '0.0000', '0.0000', '10.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(677, 'TUERCA FLANGE', '', '', '', 11, 11, 'UND', 'G', '7.3500', '0.0000', '0.0000', '7.3500', 0, 0, NULL, 1, NULL, NULL, NULL),
(678, 'PERNOS MILIMETRICO', '', '', '', 11, 11, 'CAJA', 'G', '18.9000', '0.0000', '0.0000', '18.9000', 0, 0, NULL, 1, NULL, NULL, NULL),
(679, 'TERMINALES DE TUBO', '', '', '', 11, 11, 'UND', 'G', '25.2000', '0.0000', '0.0000', '25.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(680, 'PERNO SOKET', '', '', '', 11, 11, 'UND', 'G', '0.2500', '0.0000', '0.0000', '0.2300', 0, 0, NULL, 1, NULL, NULL, NULL),
(681, 'ACOPLE MACHO', '', '', '', 11, 11, 'UND', 'G', '10.0000', '0.0000', '0.0000', '8.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(682, 'UNION', '', '', '', 11, 11, 'UND', 'G', '4.2000', '0.0000', '0.0000', '4.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(683, 'MOTOAZADA GOODYEAR GY6100TL DE 13 HP', '', '', '', 24, 24, 'UND', 'G', '5940.0000', '0.0000', '0.0000', '5940.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(684, 'MOTOR GASOLINERO 16 HP T/KH', '', '', '', 8, 8, 'UND', 'G', '796.0000', '0.0000', '0.0000', '796.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(685, 'MANGUERA DE SUCCION 2.3MT', '', '', '', 11, 11, 'UND', 'G', '29.6400', '0.0000', '0.0000', '29.6400', 0, 0, NULL, 1, NULL, NULL, NULL),
(686, 'RACK ESTRELLA 26 A 55', '', '', '', 11, 11, 'UND', 'G', '50.0000', '0.0000', '0.0000', '50.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(687, 'RACK P/MONITOR 13 A 27', '', '', '', 11, 11, 'UND', 'G', '90.0000', '0.0000', '0.0000', '90.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(688, 'ACEITE PARA MOTORES 2TIEMP (1000ML)', '', '', '', 10, 10, 'UND', 'G', '24.0000', '0.0000', '0.0000', '24.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(689, 'ESCAMADO', '', '', '', 11, 11, 'UND', 'G', '19.0000', '0.0000', '0.0000', '19.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(690, 'MANGUERA DE 3 PARA MOTOBOMBA', '', '', '', 11, 11, 'UND', 'G', '27.0000', '0.0000', '0.0000', '27.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(691, 'RETENES 0685G', '', '', '', 11, 11, 'UND', 'G', '11.5000', '0.0000', '0.0000', '11.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(692, 'PULVERIZADOR TURBOJET KXF-H16E2 20LTS', '', '', '', 2, 2, 'UND', 'G', '46.0000', '0.0000', '0.0000', '46.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(693, 'RP20-U1R200 BATERIA', '', '', '', 11, 11, 'UND', 'G', '162.0000', '0.0000', '0.0000', '162.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(694, 'BV04 BORNE DE BATERIA', '', '', '', 11, 11, 'UND', 'G', '8.5000', '0.0000', '0.0000', '8.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(695, 'MOTOPULVERIZADOR CERAMIC 900 FST', '', '', '', 1, 1, 'UND', 'G', '700.0000', '0.0000', '0.0000', '700.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(696, 'MOTOPULVERIZADOR TECNICA  900FST', '', '', '', 1, 1, 'UND', 'G', '400.0000', '0.0000', '0.0000', '380.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(697, 'PULVERIZADOR ELECTRICO TURBOJET 16DH-1 FST', '', '', '', 22, 22, 'UND', 'G', '130.0000', '0.0000', '0.0000', '130.0000', 0, 0, NULL, 1, NULL, NULL, NULL);
INSERT INTO `articulo` (`codigo_art`, `nombre_art`, `abreviatura_art`, `codigobarra_art`, `codigoproveedor_art`, `codigo_mar`, `codigo_lin`, `unidadm_art`, `tipoimpuesto_art`, `precio_art`, `costo_art`, `costogasto_art`, `preciomayorista_art`, `stockmin_art`, `stockmax_art`, `descontinuado_art`, `estado_art`, `usuario_reg`, `usuario_mod`, `fecha_mod`) VALUES
(698, 'JUEGO DE ARRANQUE S-35', '', '', '', 11, 11, 'UND', 'G', '35.4000', '0.0000', '0.0000', '35.4000', 0, 0, NULL, 1, NULL, NULL, NULL),
(699, 'MOTOR GX160 TIPO QX1 ST', '', '', '', 8, 8, 'UND', 'G', '1050.0000', '0.0000', '0.0000', '1000.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(700, 'MS 250 MOTOSIERRA 40 CM/16\" 63 PMC', '', '', '1123-200-0877', 4, 4, 'UND', 'G', '850.0000', '0.0000', '0.0000', '850.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(701, 'GARRUCHA CFRENO 6 ROJO ACRILICO', '', '', '', 11, 11, 'UND', 'G', '205.0000', '0.0000', '0.0000', '205.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(702, 'TUERCA IZQUIERDA PARA MOTOGUADAÑA', '', '', '', 11, 11, 'UND', 'G', '1.5000', '0.0000', '0.0000', '1.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(703, 'ESPALDAR PARA MOTOGUADAÑA', '', '', '', 11, 11, 'UND', 'G', '23.0000', '0.0000', '0.0000', '23.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(704, 'CARBURADOR SOLO NUEVO', '', '', '', 11, 11, 'UND', 'G', '40.0000', '0.0000', '0.0000', '35.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(705, 'DISCO PLATEADO PARA ALFALFA', '', '', '', 11, 11, 'UND', 'G', '35.0000', '0.0000', '0.0000', '30.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(706, 'GRASERA DE MOCHILA A MOTOR', '', '', '', 11, 11, 'UND', 'G', '5.3000', '0.0000', '0.0000', '5.3000', 0, 0, NULL, 1, NULL, NULL, NULL),
(707, 'CAMPANA DE 2 TIEMPOS', '', '', '', 11, 11, 'UND', 'G', '12.5000', '0.0000', '0.0000', '12.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(708, 'TAPA ROJA  DE 4 TIEMPOS PARA MOCHILA DE MOTOR', '', '', '', 11, 11, 'UND', 'G', '16.8000', '0.0000', '0.0000', '16.8000', 0, 0, NULL, 1, NULL, NULL, NULL),
(709, 'CARBURADOR HD-28A SR420', '', '', '', 11, 11, 'UND', 'G', '300.0000', '0.0000', '0.0000', '290.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(710, 'FILTRO DE AIRE SR420', '', '', '', 11, 11, 'UND', 'G', '42.0000', '0.0000', '0.0000', '35.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(711, 'MOTOSIERRA STHIL MS-260 C/EQUIPO DE CORTE 20 PULG', '', '', '', 4, 4, 'UND', 'G', '1800.0000', '0.0000', '0.0000', '1700.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(712, 'MOTODESMALEZADORA STHIL FS-280 C/DM 300', '', '', '', 3, 3, 'UND', 'G', '2000.0000', '0.0000', '0.0000', '1900.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(713, 'NIPLE MANGUERA DE 1/2 X 1/4 NTP', '', '', '', 11, 11, 'UND', 'G', '5.8000', '0.0000', '0.0000', '5.8000', 0, 0, NULL, 1, NULL, NULL, NULL),
(714, 'NIPLE MACHO GALVANIZADO', '', '', '', 11, 11, 'UND', 'G', '2.0000', '0.0000', '0.0000', '1.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(715, 'BOCA DIFUSORA', '', '', 'C12100100', 11, 11, 'UND', 'G', '38.0000', '0.0000', '0.0000', '35.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(717, 'BARRA DE 20\" 325 \" MTH 560', '', '', '', 11, 11, 'UND', 'G', '125.0000', '0.0000', '0.0000', '115.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(718, 'CADENA CUADRADA', '', '', '', 11, 11, 'UND', 'G', '75.0000', '0.0000', '0.0000', '70.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(719, 'PLATO DE RODADURA STHIL', '', '', '', 11, 11, 'UND', 'G', '19.0000', '0.0000', '0.0000', '19.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(720, 'TUERCA DE SEGURIDAD CON COLLAR M10X1', '', '', '', 11, 11, 'UND', 'G', '21.0000', '0.0000', '0.0000', '21.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(721, 'DISCO DE APRIETE', '', '', '', 11, 11, 'UND', 'G', '21.0000', '0.0000', '0.0000', '21.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(722, 'CINTILLO DE PLASTICO BLANCA DE LARGO BOLSAX100 PCS', '', '', '', 11, 11, 'UND', 'G', '8.4000', '0.0000', '0.0000', '8.4000', 0, 0, NULL, 1, NULL, NULL, NULL),
(723, 'MOTOR GASOLINERO DE 16 HP T/H', '', '', '', 8, 8, 'UND', 'G', '840.0000', '0.0000', '0.0000', '840.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(725, 'BOMBA A PISTON 30/LIM EMBOLO ACERO WHALE', '', '', '', 13, 13, 'UND', 'G', '810.0000', '0.0000', '0.0000', '700.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(726, 'MANGUERA DE SUCCION 3', '', '', '', 11, 11, 'UND', 'G', '400.0000', '0.0000', '0.0000', '350.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(727, 'MASCARA ABS AMARILLA CMICA KAZO', '', '', '', 11, 11, 'UND', 'G', '10.0000', '0.0000', '0.0000', '10.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(728, 'CABLE ACERO GALBANIZADO', '', '', '', 11, 11, 'UND', 'G', '155.0000', '0.0000', '0.0000', '135.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(729, 'TAPA PLASTICO PARA MOCHILA DE FUMIGAR', '', '', '', 11, 11, 'UND', 'G', '8.7100', '0.0000', '0.0000', '8.7100', 0, 0, NULL, 1, NULL, NULL, NULL),
(730, 'ALINEADOR DE ALFALFA', '', '', '', 11, 11, 'UND', 'G', '75.0000', '0.0000', '0.0000', '65.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(731, 'CORREAS DE MOCHILA FUMIGAR MANUAL', '', '', '', 11, 11, 'UND', 'G', '13.2000', '0.0000', '0.0000', '13.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(732, 'POLIPASTO ELECTRICO 1600W 100/500KG 220V', '', '', '', 33, 33, 'UND', 'G', '682.0000', '0.0000', '0.0000', '682.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(733, 'ARRANCADOR DE DOS TIEPOS 3 ORIFICIOS', '', '', '', 11, 11, 'UND', 'G', '45.0000', '0.0000', '0.0000', '40.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(734, 'PISTON PARA SOLO MANUAL', '', '', '', 11, 11, 'UND', 'G', '14.2000', '0.0000', '0.0000', '14.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(735, 'CARBURADOR HD-28A 420', '', '', '', 11, 11, 'UND', 'G', '320.0000', '0.0000', '0.0000', '300.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(736, 'JUNTA  CARBURADOR 420', '', '', '', 11, 11, 'UND', 'G', '7.0000', '0.0000', '0.0000', '7.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(737, 'MS 651 MOTOSIERRA 75/CM/30\",46RM', '', '', '1144-200-0228', 4, 4, 'UND', 'G', '2500.0000', '0.0000', '0.0000', '2450.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(739, 'FS-120 MOTODESMALEZADORA DM250-3 AUTOCUT 25-2', '', '', '4134-200-0327', 3, 3, 'UND', 'G', '1350.0000', '0.0000', '0.0000', '1200.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(740, 'PISTOLA ROSEADORA METAL KAZO', '', '', '', 11, 11, 'UND', 'G', '16.0000', '0.0000', '0.0000', '16.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(741, 'PISTOLA ROCIADOR ALTA PRESION /EUROPEO', '', '', '', 11, 11, 'UND', 'G', '145.0000', '0.0000', '0.0000', '130.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(742, 'MODULO DE IGNICION CARBURADOR SR440', '', '', '', 11, 11, 'UND', 'G', '255.0000', '0.0000', '0.0000', '240.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(743, 'CABLE STHIL 440', '', '', '', 11, 11, 'UND', 'G', '165.0000', '0.0000', '0.0000', '155.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(747, 'FRENO HIDRAULICO', '', '', '', 11, 11, 'UND', 'G', '2100.0000', '0.0000', '0.0000', '2000.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(748, 'LLAVE DE PASO DE 30 1/4 8.5 MM', '', '', '', 11, 11, 'UND', 'G', '20.0000', '0.0000', '0.0000', '15.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(749, 'INTERRUPTOR 16HD-1', '', '', '', 11, 11, 'UND', 'G', '3.2000', '0.0000', '0.0000', '3.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(750, 'RUEDAS DE JEBE MASISO', '', '', '', 11, 11, 'UND', 'G', '66.0000', '0.0000', '0.0000', '66.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(753, 'MOTOAZADA GOOYEAR GY6000TL', '', '', '', 34, 34, 'UND', 'G', '5800.0000', '0.0000', '0.0000', '5500.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(754, 'PULVERIZADOR MANUAL GOODYEAR GY2000 20L', '', '', '', 2, 2, 'UND', 'G', '150.0000', '0.0000', '0.0000', '150.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(756, 'AMTOMIZADOR GOODYEAR GY3100MDS', '', '', '', 1, 1, 'UND', 'G', '1500.0000', '0.0000', '0.0000', '1350.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(757, 'ATOMIZADOR GOOYEARGY52000MD', '', '', '', 1, 1, 'UND', 'G', '1500.0000', '0.0000', '0.0000', '1300.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(758, 'ATOMIZADOR GOODYEAR GY8300MDS', '', '', '', 1, 1, 'UND', 'G', '1650.0000', '0.0000', '0.0000', '1500.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(759, 'TUERCA M6HC', '', '', '', 11, 11, 'UND', 'G', '12.5000', '0.0000', '0.0000', '12.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(760, 'BOQUILLA ATF 80-025 LILA CONO LLENO', '', '', '', 7, 7, 'UND', 'G', '24.0000', '0.0000', '0.0000', '24.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(761, 'BOQUILLA ATF80 AMARILLA', '', '', '', 7, 7, 'UND', 'G', '23.0600', '0.0000', '0.0000', '23.0600', 0, 0, NULL, 1, NULL, NULL, NULL),
(762, 'BOQUILLA ROJA CONO VACIO 80', '', '', '', 7, 7, 'UND', 'G', '15.6000', '0.0000', '0.0000', '15.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(763, 'BOQUILLA', '', '', '', 7, 7, 'UND', 'G', '25.0000', '0.0000', '0.0000', '19.8000', 0, 0, NULL, 1, NULL, NULL, NULL),
(764, 'ESCALERA DE TIJERA', '', '', '', 11, 11, 'UND', 'G', '350.0000', '0.0000', '0.0000', '300.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(765, 'PULVERIZADOR VOLPI V BLACK KONFORT', '', '', '', 2, 2, 'UND', 'G', '40.0000', '0.0000', '0.0000', '40.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(766, 'CHECK PITON DE 3', '', '', '', 11, 11, 'UND', 'G', '120.0000', '0.0000', '0.0000', '110.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(767, 'MOTOBOMBA A MOTOR DE 2 TIEMPOS', '', '', '', 19, 19, 'UND', 'G', '480.0000', '0.0000', '0.0000', '450.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(768, 'ACELERADOR STHIL', '', '', '', 11, 11, 'UND', 'G', '35.0000', '0.0000', '0.0000', '28.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(769, 'CABEZA ASPIRADORA 420', '', '', '', 11, 11, 'UND', 'G', '23.1000', '0.0000', '0.0000', '23.1000', 0, 0, NULL, 1, NULL, NULL, NULL),
(770, 'CORDON DE ARRANQUE', '', '', '1113-195-8200', 11, 11, 'UND', 'G', '7.0000', '0.0000', '0.0000', '7.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(771, 'MANIJA PARA MOCHILA DE FUMIGAR', '', '', '', 11, 11, 'UND', 'G', '10.9200', '0.0000', '0.0000', '10.9200', 0, 0, NULL, 1, NULL, NULL, NULL),
(772, 'FILTRO DE GASOLINA PARA FS280', '', '', '', 11, 11, 'UND', 'G', '25.0000', '0.0000', '0.0000', '20.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(773, 'CARBURADOR PARA MOCHILA SR420', '', '', '', 11, 11, 'UND', 'G', '298.0000', '0.0000', '0.0000', '280.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(774, 'TUBO FLEXIBLE STHIL SR420', '', '', '4203-358-7701', 11, 11, 'UND', 'G', '33.6000', '0.0000', '0.0000', '33.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(775, 'SVD AMONIO  X LT', 'AMONIO', '', '', 35, 35, 'UND', 'G', '38.0000', '0.0000', '0.0000', '35.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(776, 'CIERRE DE DEPOSITO MS250', '', '', '', 11, 11, 'UND', 'G', '32.0000', '0.0000', '0.0000', '32.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(777, 'CADENA DE 3/8 820 DIENTES', '', '', '', 11, 11, 'UND', 'G', '110.0000', '0.0000', '0.0000', '100.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(778, 'CORTE DE ALFALFA 2 ST', '', '', '', 11, 11, 'UND', 'G', '80.0000', '0.0000', '0.0000', '80.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(779, 'KIT COSECHERO UMK ST', '', '', '', 11, 11, 'UND', 'G', '50.0000', '0.0000', '0.0000', '50.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(780, 'TORNILLO PARA CHAPA STHIL', '', '', '', 11, 11, 'UND', 'G', '4.7000', '0.0000', '0.0000', '4.7000', 0, 0, NULL, 1, NULL, NULL, NULL),
(781, 'JUNTA DE PANTALLA', '', '', '', 11, 11, 'UND', 'G', '8.0000', '0.0000', '0.0000', '8.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(782, 'CUERDA DE ARRANQUE N 5 ROTARY', '', '', '', 11, 11, 'UND', 'G', '7.3000', '0.0000', '0.0000', '7.3000', 0, 0, NULL, 1, NULL, NULL, NULL),
(783, 'MS 260 MOTOSIERRA 50 CM 20\" 26RM', '', '', '1121-200-0404', 4, 4, 'UND', 'G', '1700.0000', '0.0000', '0.0000', '1700.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(784, 'MS 661 MOTOSIERRA 90CM/36\" 46RM', '', '', '1144-200-0350', 4, 4, 'UND', 'G', '2900.0000', '0.0000', '0.0000', '2900.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(785, 'JUNTA DE CILINDRO STHIL  SR420', '', '', '4203-029-2300', 11, 11, 'UND', 'G', '10.5000', '0.0000', '0.0000', '10.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(786, 'MOTOCULTOR 2.6 KW62CC 2800 RPM', '', '', '', 24, 24, 'UND', 'G', '1100.0000', '0.0000', '0.0000', '1100.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(787, 'BOMBA DE AGUA 3X3', '', '', '', 19, 19, 'UND', 'G', '580.0000', '0.0000', '0.0000', '550.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(788, 'CABEZAL P/HIDROLAVADORA', '', '', '', 13, 13, 'UND', 'G', '400.0000', '0.0000', '0.0000', '370.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(789, 'ARRANCADOR TU26', '', '', '', 11, 11, 'UND', 'G', '32.0000', '0.0000', '0.0000', '28.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(790, 'CARBURADOR 6.5 HP', '', '', '', 11, 11, 'UND', 'G', '30.0000', '0.0000', '0.0000', '30.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(791, 'CILINDRO CON PISTON 046 MM', '', '', '4203-020-1201', 11, 11, 'UND', 'G', '650.0000', '0.0000', '0.0000', '630.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(792, 'PULVERIZADOR DORSAL SIMETRICO SP20 ND', '', '', '', 2, 2, 'UND', 'G', '350.0000', '0.0000', '0.0000', '300.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(793, 'BUJIA CJ6 WS7E BM7A-W22M-U', '', '', '', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '12.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(794, 'BUJIA NGK BPMR8Y', '', '', '', 11, 11, 'UND', 'G', '14.0000', '0.0000', '0.0000', '14.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(795, 'PRE FILTRO STHIL SR420', '', '', '4203-120-1500', 11, 11, 'UND', 'G', '42.0000', '0.0000', '0.0000', '42.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(796, 'MOTOBOMBA AUTOC 2X2 7 HP  GAS', '', '', '', 19, 19, 'UND', 'G', '650.0000', '0.0000', '0.0000', '600.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(797, 'FILTRO DE AIRE - MS250', '', '', '1123-120-1612', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '15.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(798, 'FILTRO DE AIRE- FS-250', '', '', '4134-141-0300', 11, 11, 'UND', 'G', '28.0000', '0.0000', '0.0000', '28.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(799, 'TUBO FLEXIBLE TIPO ACORDEON', '', '', '4203-701-6102', 11, 11, 'UND', 'G', '35.0000', '0.0000', '0.0000', '35.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(800, 'MODULO DE IGNICION', '', '', '4244-400-1308', 11, 11, 'UND', 'G', '218.0000', '0.0000', '0.0000', '218.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(801, 'PLATO DE RODADURA', '', '', '4119-713-3100', 11, 11, 'UNS', 'G', '8.3000', '0.0000', '0.0000', '8.3000', 0, 0, NULL, 1, NULL, NULL, NULL),
(802, 'CORDON DE ARRANQUE 03.5X960 MM', '', '', '1113-195-8200', 11, 11, 'UND', 'G', '6.5000', '0.0000', '0.0000', '6.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(803, 'SILENCIADOR STHIL SR 420 4203-140-0601', '', '', '', 11, 11, 'UND', 'G', '120.0000', '0.0000', '0.0000', '120.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(804, 'CABLE GAS STHIL 4128-182-3203', '', '', '', 11, 11, 'UND', 'G', '85.0000', '0.0000', '0.0000', '80.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(805, 'TAPA DEL RECIPIENTE 4244-700-0903 STHIL', '', '', '', 11, 11, 'UND', 'G', '102.0000', '0.0000', '0.0000', '102.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(806, 'MOTOFUMIGADORA SR420 4203-011-2615', '', '', '', 1, 1, 'UND', 'G', '1950.0000', '0.0000', '0.0000', '1900.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(807, 'REJILLA CONICA 4203-708-6700', '', '', '', 11, 11, 'UND', 'G', '21.0000', '0.0000', '0.0000', '21.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(808, 'CASQUILLO 4002-713-8307', '', '', '', 11, 11, 'UND', 'G', '14.0000', '0.0000', '0.0000', '14.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(809, 'CONECTOR DE MANGUERA 8.5 MM TUERCA MARIPOSA', '', '', '', 11, 11, 'UND', 'G', '6.0000', '0.0000', '0.0000', '6.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(810, 'JUNTA 4203-129-0900 SR42', '', '', '', 11, 11, 'UND', 'G', '8.4000', '0.0000', '0.0000', '8.4000', 0, 0, NULL, 1, NULL, NULL, NULL),
(811, 'CARGADOR 16HD-1', '', '', '', 11, 11, 'UND', 'G', '22.0000', '0.0000', '0.0000', '22.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(812, 'BOMBA PORTABLE 25L/MIN CON MOTOR GP160 WHALE', '', '', 'WALS-725GPH', 5, 5, 'UND', 'G', '2550.0000', '0.0000', '0.0000', '2400.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(813, 'CADENA CUADRADA 325 CALIBRE 058 R 100P CON ESLABON DE SEGURIDAD', '', '', '', 11, 11, 'UND', 'G', '75.0000', '0.0000', '0.0000', '70.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(814, 'CADENA CUADRADA 3/8 CALIBRE 063 R 100P', '', '', '', 11, 11, 'UND', 'G', '0.6000', '0.0000', '0.0000', '0.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(815, 'DOSIFICADOR MATABI DOSER 20', '', '', '', 2, 2, 'UND', 'G', '450.0000', '0.0000', '0.0000', '450.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(816, 'PUNTA INYECTORA DOSER', '', '', '', 11, 11, 'UND', 'G', '20.0000', '0.0000', '0.0000', '20.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(817, 'BUJIA', '', '', '1110-400-7005', 11, 11, 'UND', 'G', '10.5000', '0.0000', '0.0000', '10.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(818, 'FILTRO DE AIRE SR 440', '', '', '4223-141-0300', 11, 11, 'UND', 'G', '36.0000', '0.0000', '0.0000', '36.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(819, 'MS 310 3/8\" P MOTOSIERRA 50 CM / 20\" 36 RS', '', '', '1127-200-0398', 4, 4, 'UND', 'G', '1750.0000', '0.0000', '0.0000', '1750.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(820, 'BOQUILLA ABANICO AMARILLA', '', '', '', 11, 11, 'UND', 'G', '10.0000', '0.0000', '0.0000', '8.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(821, 'TUBO DE ESCAPE EVO', '', '', '', 11, 11, 'UND', 'G', '180.0000', '0.0000', '0.0000', '170.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(822, 'BOQUILLA DOBLE HERBICIDA MORY', '', '', '', 11, 11, 'UND', 'G', '75.0000', '0.0000', '0.0000', '65.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(823, 'BOMBA DE AGUA', '', '', 'BQR10', 19, 19, 'UND', 'G', '470.0000', '0.0000', '0.0000', '440.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(824, 'CABEZAL PA/HIDROLAVADORA', '', '', 'BR328CZ', 5, 5, 'UND', 'G', '1400.0000', '0.0000', '0.0000', '1300.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(825, 'MOCHILA FUMIGADORA BAR', '', '', '9001304E', 1, 1, 'UND', 'G', '800.0000', '0.0000', '0.0000', '750.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(826, 'MOCHILA P/FUMIGADORA', '', '', 'BRF30A', 1, 1, 'UND', 'G', '633.0000', '0.0000', '0.0000', '633.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(827, 'VALVULA LLAVE DE PASE', '', '', 'B16', 11, 11, 'UND', 'G', '4.6000', '0.0000', '0.0000', '4.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(828, 'BOQUI ABAN PLA NARANJA', '', '', '65587', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '10.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(829, 'TUERCA DE SEGURIDAD CON COLLAR M10X1 IZQUIERDO', '', '', '4126-6427600', 11, 11, 'UND', 'G', '9.5000', '0.0000', '0.0000', '9.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(830, 'HILO DE CORTE CUADRADO NEGRO 33MM X 137', '', '', '0000930-2622', 11, 11, 'UND', 'G', '119.0000', '0.0000', '0.0000', '119.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(831, 'RODAMIENTO RANURADO DE BOLAS 15X38X11', '', '', '9523-003-4301', 11, 11, 'UND', 'G', '38.0000', '0.0000', '0.0000', '38.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(832, 'RETEN 15X25X5', '', '', '9639-003-1585', 11, 11, 'UND', 'G', '14.2000', '0.0000', '0.0000', '14.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(833, 'CILINDRO CON PISTON 048 MM', '', '', '4244-020-1251', 11, 11, 'UND', 'G', '624.0000', '0.0000', '0.0000', '624.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(834, 'JUNTA DE SILENCIADOR', '', '', '1115-149-0600', 11, 11, 'UND', 'G', '3.3600', '0.0000', '0.0000', '3.3600', 0, 0, NULL, 1, NULL, NULL, NULL),
(835, 'SILENCIADOR 440', '', '', '4244-140-0600', 11, 11, 'UND', 'G', '88.0000', '0.0000', '0.0000', '88.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(836, 'TUBO FLEXIBLE TIPO ACORDEON 440', '', '', '4244-701-6104', 11, 11, 'UND', 'G', '37.0000', '0.0000', '0.0000', '37.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(837, 'CILINDRO CON PISTON 046 MM  420', '', '', '4203-020-1201', 11, 11, 'UND', 'G', '750.0000', '0.0000', '0.0000', '680.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(838, 'JUNTA DE CILINDRO 420', '', '', '4203-029-2300', 11, 11, 'UND', 'G', '6.0000', '0.0000', '0.0000', '6.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(839, 'JUNTA DE SILENCIADOR STHIL', '', '', '', 11, 11, 'UND', 'G', '4.0000', '0.0000', '0.0000', '4.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(840, 'ENCHUFE DE BUJIA', '', '', '1106-405-1000', 11, 11, 'UND', 'G', '17.0000', '0.0000', '0.0000', '17.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(841, 'JUEGO DE JUNTAS', '', '', '4203-007-1050', 11, 11, 'UND', 'G', '52.0000', '0.0000', '0.0000', '52.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(842, 'GRIFO DE CIERRE 420', '', '', '4203-700-4501', 11, 11, 'UND', 'G', '60.0000', '0.0000', '0.0000', '60.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(843, 'DOSIFICADOR', '', '', '4203-700-4501', 11, 11, 'UND', 'G', '17.0000', '0.0000', '0.0000', '17.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(844, 'SILENCIADOR 420', '', '', '4203-140-0601', 11, 11, 'UND', 'G', '80.0000', '0.0000', '0.0000', '80.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(845, 'INDICADOR DE REVOLUCION EDT 9', '', '', '5910-850-1100', 11, 11, 'UND', 'G', '350.0000', '0.0000', '0.0000', '330.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(846, 'DOSIFICADOR 1', '', '', '4203-708-4003', 11, 11, 'UND', 'G', '17.0000', '0.0000', '0.0000', '17.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(847, 'MOTOBOMBA WL20XH TIPO DR ST', '', '', 'WL20XHDR', 19, 19, 'UND', 'G', '1750.0000', '0.0000', '0.0000', '1450.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(848, 'MANGUERA FUMIGACION CON TERMINALES 600 PSI 1/2 PULGADAS', '', '', '1020361020', 11, 11, 'UND', 'G', '380.0000', '0.0000', '0.0000', '380.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(849, 'ABRAZADERA TIPO NORMA ACERADA W1 9MM 8 12', '', '', '30AW100812', 11, 11, 'UND', 'G', '0.7000', '0.0000', '0.0000', '0.7000', 0, 0, NULL, 1, NULL, NULL, NULL),
(850, 'ABRAZADERA INDUSTRIAL ACERADA W1 T 509L', '', '', '30A1006063', 11, 11, 'UND', 'G', '10.0000', '0.0000', '0.0000', '8.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(851, 'ABRAZADERA INDUSTRIAL ACERADA W1 T 511', '', '', '', 11, 11, 'UND', 'G', '6.0000', '0.0000', '0.0000', '5.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(852, 'DESBROZADORA 2HP 42 7CC 1500W DEREK MOTORS', '', '', 'DRK 430', 3, 3, 'UND', 'G', '650.0000', '0.0000', '0.0000', '600.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(853, 'BUJIA PARA MOTOSIERRA', '', '', 'LT 27', 11, 11, 'UND', 'G', '5.0000', '0.0000', '0.0000', '5.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(854, 'CABEZAL PARA DESBROZADORA HONDA', '', '', '', 11, 11, 'UND', 'G', '12.0000', '0.0000', '0.0000', '12.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(855, 'HONDA CONDOR', '', '', '', 11, 11, 'UND', 'G', '2600.0000', '0.0000', '0.0000', '2400.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(856, 'CUCHILLA CHALEADORA GRANDE', '', '', '', 11, 11, 'UND', 'G', '14.7000', '0.0000', '0.0000', '14.7000', 0, 0, NULL, 1, NULL, NULL, NULL),
(857, 'CUCHILLA CHALEADORA PEQUEÑA', '', '', '', 11, 11, 'UND', 'G', '14.7000', '0.0000', '0.0000', '14.7000', 0, 0, NULL, 1, NULL, NULL, NULL),
(858, 'FILTRO DE MOTOSIERRA', '', '', '', 11, 11, 'UND', 'G', '30.0000', '0.0000', '0.0000', '25.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(859, 'FILTRO DE AIRE PARA MOTOSIERRA', '', '', '', 11, 11, 'UND', 'G', '48.3000', '0.0000', '0.0000', '48.3000', 0, 0, NULL, 1, NULL, NULL, NULL),
(860, 'CILINDRO ND', '', '', '', 11, 11, 'UND', 'G', '16.0000', '0.0000', '0.0000', '16.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(861, 'NIPLE DE MANGUERA 1/2 X 1/4 NPT', '', '', '', 11, 11, 'UND', 'G', '7.0000', '0.0000', '0.0000', '7.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(862, 'CABEZAL DE ASPIRACION STIHL 0000-350-3518 P/MS361,MS381', '', '', '', 11, 11, 'UND', 'G', '23.1000', '0.0000', '0.0000', '23.1000', 0, 0, NULL, 1, NULL, NULL, NULL),
(863, 'CARBURADOR WT-215 STIHL 1123-120-0605 P/MS250', '', '', '', 11, 11, 'UND', 'G', '250.0000', '0.0000', '0.0000', '230.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(864, 'CARBURADOR 4137/28 4137-120-0628 KA85R', '', '', '', 11, 11, 'UND', 'G', '210.0000', '0.0000', '0.0000', '200.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(865, 'CIERRE DEL DEPOSITO 0000-350-0533 P/MS250,STIH', '', '', '', 11, 11, 'UND', 'G', '38.0000', '0.0000', '0.0000', '38.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(866, 'ESPADA ROLLOMATIC 45CM/18 MS 250. 3005-000-4817', '', '', '', 11, 11, 'UND', 'G', '147.0000', '0.0000', '0.0000', '147.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(867, 'CADENA 3/8 (820 DIENTES) P/ ESP 18\" MS- 250. 3636-000-1640,STIHL', '', '', '', 11, 11, 'UND', 'G', '85.0000', '0.0000', '0.0000', '80.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(868, 'FILTRO DE AIRE STIHL 1123-120-1612,STIHL', '', '', '', 11, 11, 'UND', 'G', '40.0000', '0.0000', '0.0000', '35.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(869, 'PIÑON DE CADENA 3/8 P/MS 250. 1123-640-2073', '', '', '', 11, 11, 'UND', 'G', '110.0000', '0.0000', '0.0000', '98.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(870, 'ACEITE PARA MOTORES DE 2 TIEMPOS (100ML) 7032-874-0001', '', '', '', 10, 10, 'UND', 'G', '3.1200', '0.0000', '0.0000', '3.1200', 0, 0, NULL, 1, NULL, NULL, NULL),
(871, 'LLAVE DE IMPACTO NEUM. 1\" 2200N.M 3900RPM', '', '', '', 16, 16, 'UND', 'G', '670.0000', '0.0000', '0.0000', '650.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(872, 'JAULA DE AGUJAS 10X13X10 STIHL MS 250. 9512-933-2260', '', '', '', 11, 11, 'UND', 'G', '35.0000', '0.0000', '0.0000', '30.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(873, 'SOPORTE', '', '', '', 11, 11, 'UND', 'G', '18.0000', '0.0000', '0.0000', '18.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(874, 'TANQUE PARA MOCHILA CIFARELLI', '', '', '', 11, 11, 'UND', 'G', '75.0000', '0.0000', '0.0000', '70.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(875, 'FILTRO DE AIRE VELO 1119-120-1628 P/ 381 STIHL', '', '', '', 11, 11, 'UND', 'G', '65.0000', '0.0000', '0.0000', '65.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(876, 'DIFUSOR REGULABLE', '', '', '', 11, 11, 'UND', 'G', '36.0000', '0.0000', '0.0000', '36.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(877, 'MODULO DE INGNICION 4203-400-1302- PSR420 STIHL', '', '', '', 11, 11, 'UND', 'G', '264.0000', '0.0000', '0.0000', '264.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(878, 'THERMO', '', '', '', 11, 11, 'UND', 'G', '138.0000', '0.0000', '0.0000', '138.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(879, 'THERMO 1 LT', '', '', '', 11, 11, 'UND', 'G', '93.1200', '0.0000', '0.0000', '93.1200', 0, 0, NULL, 1, NULL, NULL, NULL),
(880, 'ARRANCADOR TIPO CIFARELLI', '', '', '', 11, 11, 'UND', 'G', '80.0000', '0.0000', '0.0000', '75.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(881, 'CARBURADOR TIPO HONDA', '', '', '', 11, 11, 'UND', 'G', '45.0000', '0.0000', '0.0000', '45.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(882, 'ARRANCADOR DE 4 TIEMPOS NEGRO', '', '', '', 11, 11, 'UND', 'G', '55.0000', '0.0000', '0.0000', '45.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(883, 'MS 382 MOTOSIERRA 75 CM /30\" 36 RM', '', '', '1119-200-0283', 4, 4, 'UND', 'G', '2400.0000', '0.0000', '0.0000', '2400.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(884, 'ACUMULADORDE PRESION- ND', '', '', '', 11, 11, 'UND', 'G', '145.0000', '0.0000', '0.0000', '130.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(885, 'APLICADORDORSAL DE GRANULOS - ND', '', '', '', 11, 11, 'UND', 'G', '1050.0000', '0.0000', '0.0000', '850.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(886, 'BOQUI.ABAN.PLA.AMA-2F80YE - ND', '', '', '', 11, 11, 'UND', 'G', '12.0000', '0.0000', '0.0000', '10.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(887, 'INYECTORDE SUELO- ND', '', '', '', 11, 11, 'UND', 'G', '331.0000', '0.0000', '0.0000', '331.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(888, 'KIT DE JUNTAS DEL MOTOR- I - ND', '', '', '', 11, 11, 'UND', 'G', '150.0000', '0.0000', '0.0000', '139.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(889, 'PISTONCONANILLO- I U7731 - ND', '', '', '', 11, 11, 'UND', 'G', '320.0000', '0.0000', '0.0000', '298.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(890, 'RETENEDORTBY 17X30X7 KIT C/2 - I - ND', '', '', '', 11, 11, 'UND', 'G', '63.0000', '0.0000', '0.0000', '63.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(891, 'VALVULA DESCARGA SUP-3 - ND', '', '', '', 11, 11, 'UND', 'G', '36.0000', '0.0000', '0.0000', '36.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(892, 'MOTOGIADAÑA UMK435T TIPO EDT ST', '', '', '', 3, 3, 'UND', 'G', '2000.0000', '0.0000', '0.0000', '1850.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(893, 'MOTOBOMBA DE AGUA WB30XH TIPO DR ST', '', '', 'WB30XH2DR', 19, 19, 'UND', 'G', '1670.0000', '0.0000', '0.0000', '1670.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(894, 'GENERADOR EG1000 TIPO S ST', '', '', 'EG1000S', 9, 9, 'UND', 'G', '1650.0000', '0.0000', '0.0000', '1650.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(895, 'GENERADOR EZ3000CX TIPO S ST', '', '', 'EZ3000CXS', 9, 9, 'UND', 'G', '2075.0000', '0.0000', '0.0000', '2075.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(896, 'CARBURADOR 4134/22 COD. 4134-120-0622,STIHL', '', '', '', 11, 11, 'UND', 'G', '250.0000', '0.0000', '0.0000', '235.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(897, 'ATOMIZADORA 3WF 3A', '', '', '', 1, 1, 'UND', 'G', '410.0000', '0.0000', '0.0000', '410.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(898, 'MOTOSIERRA BN 5800 SC SPADA 24', '', '', '', 4, 4, 'UND', 'G', '480.0000', '0.0000', '0.0000', '480.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(899, 'CARRETILLA BUGI LLANTA CON CAMARA CHASIS GALVANIZADO', '', '', '', 11, 11, 'UND', 'G', '220.0000', '0.0000', '0.0000', '200.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(900, 'PALANCA RECTA', '', '', '', 11, 11, 'UND', 'G', '31.5000', '0.0000', '0.0000', '31.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(901, 'RASTRILLO DE 12 DIENTES  MANGO MADERA', '', '', '', 11, 11, 'UND', 'G', '12.0000', '0.0000', '0.0000', '12.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(902, 'PERNOS MM HC', '', '', '', 11, 11, 'UND', 'G', '25.8000', '0.0000', '0.0000', '25.8000', 0, 0, NULL, 1, NULL, NULL, NULL),
(903, 'TRAPO INDUSTRIAL', '', '', '', 11, 11, 'UND', 'G', '3.8000', '0.0000', '0.0000', '3.8000', 0, 0, NULL, 1, NULL, NULL, NULL),
(904, 'CAMPANA GRANDE', '', '', '', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '15.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(905, 'ZAPATA 4 TIEMPOS CG-430', '', '', '', 11, 11, 'UND', 'G', '12.6000', '0.0000', '0.0000', '12.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(906, 'CAMPANA CHICA', '', '', '', 11, 11, 'UND', 'G', '11.0000', '0.0000', '0.0000', '11.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(907, 'TAPA TU40', '', '', '', 11, 11, 'UND', 'G', '6.2400', '0.0000', '0.0000', '6.2400', 0, 0, NULL, 1, NULL, NULL, NULL),
(908, 'CARBURADOR DE 6.5 HP P19', '', '', '', 11, 11, 'UND', 'G', '80.0000', '0.0000', '0.0000', '70.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(909, 'FILTRO DE AIRE HD2 0000-140-4402 P/660,STIHL', '', '', '', 11, 11, 'UND', 'G', '78.0000', '0.0000', '0.0000', '78.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(910, 'JAULA DE AGUJAS 10X16X13 9512-933-2382 P/660,STIHL', '', '', '', 11, 11, 'UND', 'G', '40.0000', '0.0000', '0.0000', '35.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(911, 'NIU PIÑON DE CADENA TIPO ANILLO .404 0000-642-1207 P/070.MS660. MS780,STIHL', '', '', '', 11, 11, 'UND', 'G', '40.0000', '0.0000', '0.0000', '40.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(912, 'TUBO FLEXIBLE 1124-358-7700 P/660,STIHL', '', '', '', 11, 11, 'UND', 'G', '31.5000', '0.0000', '0.0000', '31.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(913, 'BOQUILLA WHALE', '', '', '', 11, 11, 'UND', 'G', '45.0000', '0.0000', '0.0000', '35.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(914, 'CAJA ABRAZADERA 200 UND', '', '', '', 11, 11, 'UND', 'G', '90.0000', '0.0000', '0.0000', '85.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(915, 'LLAVE TIPO T', '', '', '', 11, 11, 'UND', 'G', '33.6000', '0.0000', '0.0000', '33.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(916, 'TAMBOR DE CORDON', '', '', '', 11, 11, 'UND', 'G', '25.5000', '0.0000', '0.0000', '25.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(917, 'CARBURADOR 4134/22', '', '', '', 11, 11, 'UND', 'G', '290.0000', '0.0000', '0.0000', '285.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(918, 'TUBO FLEXIBLE 1', '', '', '', 11, 11, 'UND', 'G', '16.0000', '0.0000', '0.0000', '16.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(919, 'CARBURADOR 2300558B', '', '', '', 11, 11, 'UND', 'G', '270.0000', '0.0000', '0.0000', '270.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(920, 'BOQUILLA MAG AMARILLA', '', '', '', 7, 7, 'UND', 'G', '14.0700', '0.0000', '0.0000', '14.0700', 0, 0, NULL, 1, NULL, NULL, NULL),
(921, 'ATR ORANGE BOQUILLA NARANJA', '', '', '', 7, 7, 'UND', 'G', '27.0000', '0.0000', '0.0000', '27.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(922, 'MS 661 MOTOSIERRA 90 CM /36 46 RM', '', '', '1144-200-0350', 4, 4, 'UND', 'G', '3100.0000', '0.0000', '0.0000', '3100.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(923, 'HIDROLAVADORA C/BN 30A MANGU 50 MTS', '', '', 'BN-S30T', 5, 5, 'UND', 'G', '1400.0000', '0.0000', '0.0000', '1400.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(924, 'TUBO CUADRADO MATE', '', '', '', 11, 11, 'UND', 'G', '40.0000', '0.0000', '0.0000', '40.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(925, 'TRANCA CHINA', '', '', '', 11, 11, 'UND', 'G', '171.0000', '0.0000', '0.0000', '171.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(926, 'LIMA REDONDO1/4 3/8 P*40X200 MM 5605-772-4006', '', '', '', 11, 11, 'UND', 'G', '6.6000', '0.0000', '0.0000', '6.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(927, 'LANZA HIDROLAVADORA 90 CM GIRATORIA', '', '', '', 11, 11, 'UND', 'G', '22.0000', '0.0000', '0.0000', '22.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(928, 'BOQUILLA ATF80 AZUL', '', '', '', 11, 11, 'UND', 'G', '35.0000', '0.0000', '0.0000', '30.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(929, 'BOQUILLA ATF80 AMARILLA ALBUZ', '', '', '', 11, 11, 'UND', 'G', '35.0000', '0.0000', '0.0000', '30.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(930, 'PCS MOTOFUMIGADORA 4 TIEMPOS MAKISHIMA', '', '', '', 1, 1, 'UND', 'G', '360.0000', '0.0000', '0.0000', '360.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(931, 'CARBURADOR HONDA 4 T GX 35', '', '', '', 11, 11, 'UND', 'G', '48.0000', '0.0000', '0.0000', '48.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(932, 'ACEITE P MOTOR DE 2TIEMPOS  100 ML', '', '', '', 10, 10, 'UND', 'G', '3.6000', '0.0000', '0.0000', '3.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(933, 'LLAVE DE IMPACTO NEUM 1/2 \"', '', '', '', 16, 16, 'UND', 'G', '260.0000', '0.0000', '0.0000', '250.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(934, 'LLAVE DE IMPACTO NEUM 1 \"', '', '', '', 16, 16, 'UND', 'G', '650.0000', '0.0000', '0.0000', '650.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(935, 'BOMBA DE ENGRASE NEUMAT 30 L', '', '', '', 16, 16, 'UND', 'G', '750.0000', '0.0000', '0.0000', '690.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(936, 'RESORTE 1118-195-3500 P/MS250, SR420', '', '', '', 11, 11, 'UND', 'G', '10.0000', '0.0000', '0.0000', '9.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(937, 'TAMBOR DEL CORDON 1123-195-0400 P/MS250', '', '', '', 11, 11, 'UND', 'G', '29.4000', '0.0000', '0.0000', '29.4000', 0, 0, NULL, 1, NULL, NULL, NULL),
(938, 'BOMBA DE AGUA BR30RD', '', '', 'BR30RD', 19, 19, 'UND', 'G', '480.0000', '0.0000', '0.0000', '480.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(939, 'BOMBA DE AGUA BRQ40', '', '', 'BRQ40', 19, 19, 'UND', 'G', '1500.0000', '0.0000', '0.0000', '1400.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(940, 'MANGUERA 12MHOUSE', '', '', '12MHOSE', 11, 11, 'UND', 'G', '12.9000', '0.0000', '0.0000', '12.9000', 0, 0, NULL, 1, NULL, NULL, NULL),
(941, 'BOMBA DE AGUA BRQ10', '', '', 'BRQ10', 19, 19, 'UND', 'G', '550.0000', '0.0000', '0.0000', '480.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(942, 'REPUESTO PARA FUMIGADOR DIAFRAGMA DE CARBURADOR 4CM', '', '', '', 11, 11, 'UND', 'G', '10.5000', '0.0000', '0.0000', '10.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(943, 'REPUESTO PARA BRUSH DISCO X 10 PUNTAS', '', '', '', 11, 11, 'UND', 'G', '12.6000', '0.0000', '0.0000', '12.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(944, 'REPUESTO PARA MOTOBOMBA CODO PARA BOMBA', 'CODO PARA BOMBA', '', 'JET00176', 11, 11, 'UND', 'G', '100.0000', '0.0000', '0.0000', '98.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(945, 'REPUESTO PARA FUMIGADORA MANUAL CORREA', 'CORREA', '', 'JET00215', 11, 11, 'UND', 'G', '6.0000', '0.0000', '0.0000', '6.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(946, 'MANGUERA EN ROLLO X 100 MT M JETAGRO', 'ROLLO MANGUERA', '', 'JET00932', 11, 11, 'UND', 'G', '132.0000', '0.0000', '0.0000', '132.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(947, 'REPUESTO PARA MIST DUSTER DIAFRAGMA DE CARBURADOR 4CM', 'DIAFRAGMA', '', 'JET00136', 11, 11, 'UND', 'G', '21.0000', '0.0000', '0.0000', '21.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(948, 'REPUESTO PARA FUMIGADORA MANUAL LANZA X 30 CM', 'LANZA MANUAL', '', 'JET0017', 11, 11, 'UND', 'G', '12.6000', '0.0000', '0.0000', '12.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(949, 'REPUESTO PARA FUMIGADORA MANUAL GATILLO DE MANIJA', 'GATILLO MANIJA', '', 'JET0045', 11, 11, 'UND', 'G', '1.6000', '0.0000', '0.0000', '1.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(950, 'REPUESTO PARA FUMIGADORA MOTOR BOQUILLA NEGRA', 'BOQUILLA NEGRA', '', 'JET0094', 11, 11, 'UND', 'G', '7.9000', '0.0000', '0.0000', '7.9000', 0, 0, NULL, 1, NULL, NULL, NULL),
(951, 'PULVERIZADOR MANUAL 15 LT KNAPSACK SPRAYER M JETAGRO', 'FUMIGADORA JET', '', 'JET00314', 11, 11, 'UND', 'G', '65.0000', '0.0000', '0.0000', '59.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(952, 'PULVERIZADOR MANUAL 20 LT KNAPSACK SPRAYER M JETAGRO', 'PULVERIZADOR 20', '', 'JET-20AC', 11, 11, 'UND', 'G', '68.0000', '0.0000', '0.0000', '59.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(953, 'FUMIGADORA MANUAL 20 LT KNAPSACK SPRAYER M JETAGRO', 'FUMIGADORA 20', '', 'JET000896', 11, 11, 'UND', 'G', '100.0000', '0.0000', '0.0000', '100.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(954, 'CABEZAL DE FUMIGADOR COD TF2431 M JETAGRO', 'CABEZAL', '', 'TF-2431', 11, 11, 'UND', 'G', '400.0000', '0.0000', '0.0000', '385.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(955, 'REPUESTO PARA FUMIGADOR LANZA DE ACERO X15CM', 'LANZA ACERO', '', 'JET0098', 11, 11, 'UND', 'G', '10.5000', '0.0000', '0.0000', '10.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(956, 'REPUESTO PARA MIST DUSTER CORREA', 'CORREA', '', 'JET00300', 11, 11, 'UND', 'G', '9.5000', '0.0000', '0.0000', '9.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(957, 'MANGUERA CON MANIJA M JETAGRO', 'MANGUERA MANIJA', '', 'JET00163', 11, 11, 'UND', 'G', '16.2000', '0.0000', '0.0000', '16.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(958, 'REPUESTO PARA MOTOBOMBA CODO PARA BOMBA 0', 'CODO BOMBA', '', 'JET00177', 11, 11, 'UND', 'G', '73.5000', '0.0000', '0.0000', '73.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(959, 'REPUESTO PARA FUMIGADORA MANUAL GATILLO DE MANIJA 0', 'GATILLO', '', 'JET0036', 11, 11, 'UND', 'G', '2.1000', '0.0000', '0.0000', '2.1000', 0, 0, NULL, 1, NULL, NULL, NULL),
(960, 'REPUESTO PARA MIST DUSTER MINI TANQUE DE GASOLINA X 15 CM', 'MINI TANQUE', '', 'JET00322', 11, 11, 'UND', 'G', '12.6000', '0.0000', '0.0000', '12.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(961, 'REPUESTO PARA MIST DUSTER SOPORTE DE METAL X 25CM', 'SOPORTE METAL', '', 'JET00933', 11, 11, 'UND', 'G', '12.5000', '0.0000', '0.0000', '12.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(962, 'REPUESTO PARA MIST DUSTER KIT DE BOQUILLAS ACCESORIOS', 'KIT DE BOQUILLA', '', 'JET0064', 11, 11, 'UND', 'G', '15.7500', '0.0000', '0.0000', '15.7500', 0, 0, NULL, 1, NULL, NULL, NULL),
(963, 'REPUESTO PARA MIST DUSTER KIT DE BOQUILLAS', 'KIT BOQUILLAS', '', 'JET0063', 11, 11, 'UND', 'G', '15.7500', '0.0000', '0.0000', '15.7500', 0, 0, NULL, 1, NULL, NULL, NULL),
(964, 'REPUESTO PARA MIST DUSTER TUBO FLEXIBLE PLASTICO X15CM', 'TUBO FLEXIBLE', '', 'JET00214', 11, 11, 'UND', 'G', '9.4500', '0.0000', '0.0000', '9.4500', 0, 0, NULL, 1, NULL, NULL, NULL),
(965, 'REPUESTO PARA MIST DUSTER VALVULA DE AGUA', 'VALVULA AGUA', '', '856', 11, 11, 'UND', 'G', '5.3000', '0.0000', '0.0000', '5.3000', 0, 0, NULL, 1, NULL, NULL, NULL),
(966, 'REPUESTO MIST DUSTER CUERDA DE ARRANQUE', 'CUERDA ARRANQUE', '', '861', 11, 11, 'UND', 'G', '4.8000', '0.0000', '0.0000', '4.8000', 0, 0, NULL, 1, NULL, NULL, NULL),
(967, 'REPUESTO PARA FUMIGADOR CARBURADOR', 'CARBURADOR', '', 'JET 00217', 11, 11, 'UND', 'G', '21.0000', '0.0000', '0.0000', '21.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(968, 'REPUESTO PARA FUMIGADORA MOTOR  MEDIDOR DE PRESION', 'MEDIDOR PRESION', '', 'JET00151', 11, 11, 'UND', 'G', '84.0000', '0.0000', '0.0000', '84.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(969, 'REPUESTO PARA FUMIGADORA MOTOR  M JETAGRO', '', '', 'JET00200', 11, 11, 'UND', 'G', '2.1000', '0.0000', '0.0000', '2.1000', 0, 0, NULL, 1, NULL, NULL, NULL),
(970, 'REPUESTO PARA FUMIGADOR JALADOR CHICO', 'JALADOR CHICO', '', 'JET00124', 11, 11, 'UND', 'G', '10.5000', '0.0000', '0.0000', '10.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(971, 'REPUESTO PARA FUMIGADOR A MOTOR EMPAQUE DE PLASTICO', 'EMPAQUE PLASTIC', '', 'JET0051', 11, 11, 'UND', 'G', '5.2500', '0.0000', '0.0000', '5.2500', 0, 0, NULL, 1, NULL, NULL, NULL),
(972, 'REPUESTO PARA FUMIGADOR MOTOR EMPAQUE PLASTICO', 'EMPAQUE PLASTIC', '', 'JET0052', 11, 11, 'UND', 'G', '5.4000', '0.0000', '0.0000', '5.4000', 0, 0, NULL, 1, NULL, NULL, NULL),
(973, 'REPUESTO PARA FUMIGADOR MOTOR MEDIDOR PRESION', 'MEDIDOR PRESION', '', 'JET0042', 11, 11, 'UND', 'G', '21.0000', '0.0000', '0.0000', '21.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(974, 'REPUESTO PULVERIZADOR ELECTRICO MINI BOMBA', 'MINI BOMBA', '', 'JET00269', 11, 11, 'UND', 'G', '42.0000', '0.0000', '0.0000', '42.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(975, 'REPUESTO PARA FUMIGADOR CORREA', 'CORREA', '', 'JET00131', 11, 11, 'UND', 'G', '12.6000', '0.0000', '0.0000', '12.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(976, 'CIERRE DEL DEPOSITO STIHL FS280 4116-350-0502', '', '', '', 11, 11, 'UND', 'G', '42.0000', '0.0000', '0.0000', '42.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(977, 'MANGUERA DE 1 PULGADA PRESADA', '', '', '', 11, 11, 'UND', 'G', '47.5000', '0.0000', '0.0000', '47.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(978, 'CABEZAL DE CERAMICA DE 70 TF', '', '', '', 11, 11, 'UND', 'G', '1050.0000', '0.0000', '0.0000', '890.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(979, 'RESORTE PARA CIFARELLI NUEVO', '', '', '', 11, 11, 'UND', 'G', '3.5000', '0.0000', '0.0000', '3.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(980, 'CABEZAL DE CORTE AUTOCUT46-2 STIHL 4003-710-2115', '', '', '', 11, 11, 'UND', 'G', '150.0000', '0.0000', '0.0000', '145.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(981, 'BOMBA  PORTABLE 25L MIN CON MOTOR ELECTRICO 3 HP', '', '', '', 21, 21, 'UND', 'G', '2700.0000', '0.0000', '0.0000', '2650.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(982, 'MOTOFUMIGADORA STIHL 4244-011-2630', '', '', '', 1, 1, 'UND', 'G', '2300.0000', '0.0000', '0.0000', '2300.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(983, 'BR328CZ CABEZAL DE HIDROLAVADORA', '', '', '', 5, 5, 'UND', 'G', '1340.0000', '0.0000', '0.0000', '1340.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(984, 'LLANTA DE GOMA', '', '', '', 11, 11, 'UND', 'G', '72.0000', '0.0000', '0.0000', '72.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(985, 'MANGUERA 1/2 JEBE', '', '', '', 11, 11, 'UND', 'G', '73.5000', '0.0000', '0.0000', '73.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(986, 'FUMIGADORA MANUAL 20 LTS SPRAYER JET AGRO', '', '', '', 2, 2, 'UND', 'G', '98.0000', '0.0000', '0.0000', '98.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(987, 'BRUSH CUTTER DESBROZADORA JETAGRO', '', '', '', 3, 3, 'UND', 'G', '450.0000', '0.0000', '0.0000', '380.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(988, 'REPUESTO PARA FUMIGADORA MOTOR MEDIDOR DE PRESION', '', '', '', 11, 11, 'UND', 'G', '84.0000', '0.0000', '0.0000', '84.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(989, 'MOTOBOMBA A MOTOR JET25DW', '', '', '', 19, 19, 'UND', 'G', '400.0000', '0.0000', '0.0000', '350.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(990, 'BOMBA DE ACEITE MS381 1119-640-3200', '', '', '', 11, 11, 'UND', 'G', '260.0000', '0.0000', '0.0000', '250.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(991, 'MODULO DE IGNICION 4244-400-1308 SR430', '', '', '', 11, 11, 'UND', 'G', '265.0000', '0.0000', '0.0000', '265.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(992, 'BOCA DIFUSORA M1200 SOLA', '', '', '', 11, 11, 'UND}', 'G', '55.0000', '0.0000', '0.0000', '48.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(993, 'MOTOPULVERIZADOR 20 L CON MOTOR TU 26 PANTERA', '', '', '', 1, 1, 'UND', 'G', '356.0000', '0.0000', '0.0000', '356.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(994, 'CONTROLADOR Y REGULADOR DE PRESION 20 E', '', '', '', 11, 11, 'UND', 'G', '12.0000', '0.0000', '0.0000', '12.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(995, 'BOMBA D/ENGRASE NEUMAT. 40L 1300G/MIN 55:1', '', '', '', 16, 16, 'UND', 'G', '1050.0000', '0.0000', '0.0000', '950.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(996, 'BOMBA D/ENGRASE NEUMAT. 30L 800G/MIN 50:1', '', '', '', 16, 16, 'UND', 'G', '604.0000', '0.0000', '0.0000', '604.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(997, 'LLAVE DE IMPACTO NEUM. 1\" 2200N.M 3900RPM01/2', '', '', '', 11, 11, 'UND', 'G', '659.0000', '0.0000', '0.0000', '659.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(998, 'LLANTA ARO 14 RADIAL (GP328)', '', '', '', 11, 11, 'UND', 'G', '115.0000', '0.0000', '0.0000', '115.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(999, 'MOTOFUMIGADORA STIHL SR440 4244-011-2630', '', '', '', 1, 1, 'UND', 'G', '2400.0000', '0.0000', '0.0000', '2350.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1000, 'VALVULA DE ENSAMBLE DE ACERO INOXIDABLE', '', '', '', 11, 11, 'UND', 'G', '2.7300', '0.0000', '0.0000', '2.7300', 0, 0, NULL, 1, NULL, NULL, NULL),
(1001, 'GRIFO BRONCE ROJO MACHO 1/4', '', '', '', 11, 11, 'UND', 'G', '5.0000', '0.0000', '0.0000', '5.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1002, 'ARRANCADOR', '', '', '', 11, 11, 'UND', 'G', '8.5000', '0.0000', '0.0000', '8.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1003, 'MANGUERA FUMIGACION CON TERMINALES 700 PSI 1/2', '', '', '', 11, 11, 'UND', 'G', '410.0000', '0.0000', '0.0000', '410.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1004, 'RELOJ DE PRESION VERTICAL 3/4 SALIDA', '', '', '', 11, 11, 'UND', 'G', '11.0000', '0.0000', '0.0000', '11.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1005, 'ARRANCADOR INCLINADO', '', '', '', 11, 11, 'UND', 'G', '35.0000', '0.0000', '0.0000', '30.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1006, 'JUNTA DE ASIENTO TQ', '', '', '', 11, 11, 'UND', 'G', '2.1500', '0.0000', '0.0000', '2.1500', 0, 0, NULL, 1, NULL, NULL, NULL),
(1007, 'BOQUILLA CONO HUECO CERAMICA', '', '', '', 11, 11, 'UND', 'G', '18.0000', '0.0000', '0.0000', '15.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1008, 'PORTA BOQUILLA DOBLE LATON 1/4', '', '', '', 11, 11, 'UND', 'G', '68.0000', '0.0000', '0.0000', '68.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1009, 'MOTOGUADAÑA 38.8 CC 1.6 HP GX35', '', '', '', 3, 3, 'UND', 'G', '1704.0000', '0.0000', '0.0000', '1704.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1010, 'PRENSA 6 P TALADRO D COLUMNA', '', '', '', 16, 16, 'UND', 'G', '95.0000', '0.0000', '0.0000', '95.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1011, 'BOBINA COMPLETA', '', '', '', 11, 11, 'UND', 'G', '460.0000', '0.0000', '0.0000', '450.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1012, 'ACEITE X 1 GALON', '', '', '', 10, 10, 'UND', 'G', '92.0000', '0.0000', '0.0000', '92.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1013, 'BOMBA PISTON 80L/MIN EMBOLO ACERO', '', '', '', 13, 13, 'UND', 'G', '750.0000', '0.0000', '0.0000', '700.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1014, 'EMBOLO 30 123X30', '', '', '', 11, 11, 'UND', 'G', '28.0000', '0.0000', '0.0000', '28.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1015, 'TAPA DEL STÁRTER CON MECANISMO DE ARRANQUE 4244-190-0304', '', '', '', 11, 11, 'UND', 'G', '168.0000', '0.0000', '0.0000', '168.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1016, 'ACEITE PARA MOTORES DE 2 TIEMPOS (1000ML) COD 7032-874-0003,', '', '', '', 10, 10, 'UND', 'G', '30.0000', '0.0000', '0.0000', '30.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1017, 'CULTIVADOR GASOLINA 13 HP AM', '', '', '', 24, 24, 'UND', 'G', '2700.0000', '0.0000', '0.0000', '2700.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1018, 'MOSIERRA 272 ESPADA DE 30', '', '', '', 4, 4, 'UND', 'G', '1050.0000', '0.0000', '0.0000', '1050.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1019, 'ATOMIZADORA MODELO 3WF600', '', '', '', 1, 1, 'UND', 'G', '706.0000', '0.0000', '0.0000', '706.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1020, 'MOCHILA ELECTRICA BLANCA Y NARANJA', '', '', '', 22, 22, 'UND', 'G', '150.0000', '0.0000', '0.0000', '150.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1021, 'COMPRENSORA DE 9 LITROS DENTAL', '', '', '', 11, 11, 'UND', 'G', '480.0000', '0.0000', '0.0000', '450.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1022, 'WINCHA 8 MTS', '', '', '', 11, 11, 'UND', 'G', '31.5000', '0.0000', '0.0000', '31.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1023, 'BOQUILLA DIFUSORA ROJA COMPLETA', '', '', '', 11, 11, 'UND', 'G', '26.0000', '0.0000', '0.0000', '26.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1024, 'VASO PARA MOCHILA JACTO NUEVO', '', '', '', 11, 11, 'UND', 'G', '25.0000', '0.0000', '0.0000', '22.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1025, 'PALANCA PARA MOCHILA DE FUMIGAR', '', '', '', 11, 11, 'UND', 'G', '14.2000', '0.0000', '0.0000', '14.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1026, 'BASE PARA MOCHILA DE FUMIGAR', '', '', '', 11, 11, 'UND', 'G', '40.0000', '0.0000', '0.0000', '36.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1027, 'HIDROLAVADORAS CON MOTOR GASOLINERO 6.5 HP', '', '', '', 5, 5, 'UND', 'G', '970.0000', '0.0000', '0.0000', '970.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1028, 'ACELERADOR STIHL 4203-182-1003 P/420', '', '', '', 11, 11, 'UND', 'G', '35.0000', '0.0000', '0.0000', '30.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1029, 'CARBURADOR HD-28A 4203-120-0610 P/420', '', '', '', 11, 11, 'UND', 'G', '350.0000', '0.0000', '0.0000', '330.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1030, 'PULVERIZADOR  SOLO DOMESTIC', '', '', '', 2, 2, 'UND', 'G', '280.0000', '0.0000', '0.0000', '280.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1031, 'MODULO DE IGNICION 4203-400-1302 P420', '', '', '', 11, 11, 'UND', 'G', '286.0000', '0.0000', '0.0000', '286.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1032, 'ABRAZADORA CAJA X 600', '', '', '', 11, 11, 'UND', 'G', '190.0000', '0.0000', '0.0000', '185.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1033, 'PERNOS 5.8 CAJA', '', '', '', 11, 11, 'UND', 'G', '6.9000', '0.0000', '0.0000', '6.9000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1034, 'ANILLO PLANO', '', '', '', 11, 11, 'UND', 'G', '13.0000', '0.0000', '0.0000', '12.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1035, 'BUJIA ENCENDI CMR5H', '', '', '', 11, 11, 'UND', 'G', '11.6000', '0.0000', '0.0000', '11.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1036, 'CARBURADOR SR430', '', '', '', 11, 11, 'UND', 'G', '350.0000', '0.0000', '0.0000', '330.0000', 0, 0, NULL, 1, NULL, NULL, NULL);
INSERT INTO `articulo` (`codigo_art`, `nombre_art`, `abreviatura_art`, `codigobarra_art`, `codigoproveedor_art`, `codigo_mar`, `codigo_lin`, `unidadm_art`, `tipoimpuesto_art`, `precio_art`, `costo_art`, `costogasto_art`, `preciomayorista_art`, `stockmin_art`, `stockmax_art`, `descontinuado_art`, `estado_art`, `usuario_reg`, `usuario_mod`, `fecha_mod`) VALUES
(1037, 'ARRANCADOR DE 13 HP', '', '', '', 11, 11, 'UND', 'G', '40.0000', '0.0000', '0.0000', '46.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1038, 'TANQUE DE GASOLINA 423', '', '', '', 11, 11, 'UND', 'G', '56.4000', '0.0000', '0.0000', '56.4000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1039, 'ARRANCADOR GX25', '', '', '', 11, 11, 'UND', 'G', '40.0000', '0.0000', '0.0000', '37.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1040, 'ZAPATA 4 TIEMPOS', '', '', '', 11, 11, 'UND', 'G', '17.5000', '0.0000', '0.0000', '17.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1041, 'ARRANCADOR 4 TIEMPOD', '', '', '', 11, 11, 'UND', 'G', '21.0000', '0.0000', '0.0000', '21.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1042, 'BOMBA DLAVADORA FUMIGADORA HL 30J2 WELKER', '', '', '', 13, 13, 'UND', 'G', '480.0000', '0.0000', '0.0000', '450.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1043, 'BOMBA LAVADORA FUMIGADORA', '', '', '', 13, 13, 'UND', 'G', '1050.0000', '0.0000', '0.0000', '950.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1044, 'LANZA DE 4 BOQUILLAS RB13', '', '', '', 11, 11, 'UND', 'G', '18.0000', '0.0000', '0.0000', '18.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1045, 'SIERRA CIRCULAR DIAMANTADA', '', '', '', 11, 11, 'UND', 'G', '23.0000', '0.0000', '0.0000', '23.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1046, 'TAPERS X CAJA', '', '', '', 11, 11, 'UND', 'G', '332.8000', '0.0000', '0.0000', '332.8000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1047, 'MOTOFUMIG. 5.5HP 570PSI 100M GX160H1QX1', '', '', '', 5, 5, 'UND', 'G', '2100.0000', '0.0000', '0.0000', '2100.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1048, 'MOTOPULVERIZADOR  20LT CON MOTOR TU26', '', '', '', 1, 1, 'UND', 'G', '410.0000', '0.0000', '0.0000', '410.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1049, 'FILTRO DE AIRE GX35', '', '', '', 11, 11, 'UND', 'G', '6.0000', '0.0000', '0.0000', '6.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1050, 'MOTOSIERRA ZOMAX', '', '', '', 4, 4, 'UND', 'G', '780.0000', '0.0000', '0.0000', '780.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1051, 'ASPIRADORA PARA POLVO Y LIQUIDO', '', '', '', 36, 36, 'UND', 'G', '700.0000', '0.0000', '0.0000', '600.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1052, 'BUJIA 6521 MM7A', '', '', '', 11, 11, 'UND', 'G', '9.5000', '0.0000', '0.0000', '9.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1053, 'TRINQUETE 1125-195-7200 MS210', '', '', '', 11, 11, 'UND', 'G', '6.3000', '0.0000', '0.0000', '6.3000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1054, 'ESCALERA', '', '', '', 11, 11, 'UND', 'G', '690.0000', '0.0000', '0.0000', '670.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1055, 'FAJAS A42', '', '', '', 11, 11, 'UND', 'G', '10.5000', '0.0000', '0.0000', '10.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1056, 'MOCHILA MANUAL DE 2 LTS CAMPANA BRONCE', '', '', '', 11, 11, 'UND', 'G', '198.0000', '0.0000', '0.0000', '198.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1057, 'EMPUÑADORA D65', '', '', '', 11, 11, 'UND', 'G', '35.0000', '0.0000', '0.0000', '35.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1058, 'BOMBA DE ACEITE 381 STHIL 1119-640-3200', '', '', '', 11, 11, 'UND', 'G', '270.0000', '0.0000', '0.0000', '250.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1059, 'FILTRO DE AIRE 4203-1403-0301 SR420', '', '', '', 11, 11, 'UND', 'G', '42.0000', '0.0000', '0.0000', '42.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1060, 'BOQUILLA REGULABLE AZUL (SOLO OBSEQUIO)', '', '', '', 11, 11, 'UND', 'G', '0.0000', '0.0000', '0.0000', '0.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1061, 'MOTODESMALEZADORA STHIL FS 280 CON DM 300-3', '', '', '', 3, 3, 'UND', 'G', '2600.0000', '0.0000', '0.0000', '2500.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1062, 'AHOYADORA MANUAL DE 1.9HP 52CC 2T', '', '', '', 16, 16, 'UND', 'G', '2500.0000', '0.0000', '0.0000', '2400.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1063, 'BROCA DE PERFORACION DE 6\" P/AHOYADORA', '', '', '', 16, 16, 'UND', 'G', '550.0000', '0.0000', '0.0000', '500.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1064, 'ACEITE P/MOTOR D/2TIEMPOS 0.1LT. (P/1GAL', '', '', '', 10, 10, 'UND', 'G', '3.4700', '0.0000', '0.0000', '3.4700', 0, 0, NULL, 1, NULL, NULL, NULL),
(1065, 'MOTOCULTIVADOR PETROLERO 10 HP NEGRO', '', '', '', 24, 24, 'UND', 'G', '4500.0000', '0.0000', '0.0000', '4200.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1066, 'CARBURADOR DE 4 TIEMPOS GX 35', '', '', '', 11, 11, 'UND', 'G', '45.0000', '0.0000', '0.0000', '45.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1067, 'CORTADORA DE CESPED', '', '', '', 3, 3, 'UND', 'G', '550.0000', '0.0000', '0.0000', '480.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1068, 'MOTOR EST GP200 TIPO QH1  ST', '', '', '', 8, 8, 'UND', 'G', '980.0000', '0.0000', '0.0000', '980.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1069, 'MS 250 MOTOSIERRA 45 CM 63 PMC 1123-200-0878', '', '', '', 4, 4, 'UND', 'G', '1100.0000', '0.0000', '0.0000', '1100.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1070, 'TUBO FLEXIBLE M1200', '', '', '', 11, 11, 'UND', 'G', '78.0000', '0.0000', '0.0000', '78.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1071, 'DEPOSITO GASOLINA 2700351', '', '', '', 11, 11, 'UND', 'G', '270.0000', '0.0000', '0.0000', '250.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1072, 'BOQUILLA CONO HUECO NARANJA', '', '', '', 7, 7, 'UND', 'G', '15.0000', '0.0000', '0.0000', '15.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1073, 'MANGUERA RETORNO DE MESCLA', '', '', '', 11, 11, 'UND', 'G', '4.5000', '0.0000', '0.0000', '4.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1074, 'LLAVE DE IMPACTO NEUM. 3/4\" 1200N.M 5600RPM', '', '', '', 16, 16, 'UND', 'G', '550.0000', '0.0000', '0.0000', '500.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1075, 'HIDROLAVADORA C/BN-30 A C/MANGU', '', '', '', 5, 5, 'UND', 'G', '1400.0000', '0.0000', '0.0000', '1400.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1076, 'AHOYADORA COLOR NARANJA 2 TIEMPOS', '', '', '', 4, 4, 'UND', 'G', '890.0000', '0.0000', '0.0000', '890.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1077, 'AHOYADORA ROJA 4 TIEMPOS GX35', '', '', '', 37, 37, 'UND', 'G', '850.0000', '0.0000', '0.0000', '776.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1078, 'MOTOBOMBA DE 1*1 NEGRO', '', '', '', 19, 19, 'UND', 'G', '480.0000', '0.0000', '0.0000', '480.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1079, 'MOTOBOMBA GASOL 1.5 * 1.5  NEGRO', '', '', '', 19, 19, 'UND', 'G', '535.0000', '0.0000', '0.0000', '535.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1080, 'MOTOR GASOLINERO 3.5 HP', '', '', '', 8, 8, 'UND', 'G', '420.0000', '0.0000', '0.0000', '420.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1081, 'CARBURADOR DE 3WF -600 WLABRO', '', '', '', 11, 11, 'UND', 'G', '190.0000', '0.0000', '0.0000', '180.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1082, 'MOCHILA FUMIGADORA BARI', '', '', '', 1, 1, 'UND', 'G', '546.0000', '0.0000', '0.0000', '546.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1083, 'CORATORA DE CESPED DELUXE  HRN216VKA ST', '', '', '', 38, 38, 'UND', 'G', '3000.0000', '0.0000', '0.0000', '2800.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1084, 'MOTOR ESTACIONARIO GX50 TIPO SD TD', '', '', '', 8, 8, 'UND', 'G', '965.0000', '0.0000', '0.0000', '965.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1085, 'EJEMPLO', '', '', '', 11, 11, 'UND', 'G', '30.0000', '0.0000', '0.0000', '22.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1086, 'ACEITE MOTOR SAE20W50 X1/4 GALON', '', '', '', 10, 10, 'UND', 'G', '15.4200', '0.0000', '0.0000', '15.4200', 0, 0, NULL, 1, NULL, NULL, NULL),
(1087, 'JERI PLAST', '', '', '', 11, 11, 'UND', 'G', '50.0000', '0.0000', '0.0000', '45.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1088, 'AGUJA METAL', '', '', '', 11, 11, 'UND', 'G', '3.0000', '0.0000', '0.0000', '2.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1089, 'MANGUERA DE 8.5 MMX100 M SAM SAM', '', '', '', 12, 12, 'UND', 'G', '370.0000', '0.0000', '0.0000', '370.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1090, 'MANGUERA DE 13 MM X100 SAM SAM', '', '', '', 12, 12, 'UND', 'G', '577.0000', '0.0000', '0.0000', '577.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1091, 'BUJE VENTILADOR EVO', '', '', '', 11, 11, 'UND', 'G', '75.0000', '0.0000', '0.0000', '70.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1092, 'MS 661 MOTOSIERRA 75 CM /30 46RM', '', '', '1144-200-0445', 4, 4, 'UND', 'G', '3750.0000', '0.0000', '0.0000', '3700.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1093, 'CARBURADOR HD-45', 'TOBERA', '', '4203-120-0610', 11, 11, 'UND', 'G', '310.0000', '0.0000', '0.0000', '310.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1094, 'MS 651 MOTOSIERRA 75 CM 30 46RM', '', '', '1144-200-0355', 4, 4, 'UND', 'G', '3250.0000', '0.0000', '0.0000', '3250.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1095, 'MODULO DE IGNICION 420', '', '', '4203-400-1302', 11, 11, 'UND', 'G', '253.0000', '0.0000', '0.0000', '253.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1096, 'KIT RETENES LS 547', '', '', '', 11, 11, 'UND', 'G', '89.0000', '0.0000', '0.0000', '89.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1097, 'REPUESTO PARA FUMIGADORA MANUAL REGISTRO', '', '', '', 11, 11, 'UND', 'G', '5.2500', '0.0000', '0.0000', '5.2500', 0, 0, NULL, 1, NULL, NULL, NULL),
(1098, 'REPUESTO PARA FUMIGADORA MANUAL MANGUERA', '', '', '', 11, 11, 'UND', 'G', '4.0000', '0.0000', '0.0000', '3.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1099, 'REPUESTO PARA FUMIGADORA MANUAL VALVULA', '', '', '', 11, 11, 'UND', 'G', '4.2000', '0.0000', '0.0000', '4.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1100, 'REPUESTO PARA FUMIGADORA MANUAL BOQUILLA', '', '', '', 11, 11, 'UND', 'G', '3.5000', '0.0000', '0.0000', '3.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1101, 'REPUESTO PARA FUMIGADORA MANUAL VARILLA', '', '', '', 11, 11, 'UND', 'G', '3.6000', '0.0000', '0.0000', '3.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1102, 'REPUESTO PARA FUMIGADORA MANUAL VASO METAL', '', '', '', 11, 11, 'UND', 'G', '6.0000', '0.0000', '0.0000', '6.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1103, 'AMORTIGUADOR 767', 'AMORTIGUADOR', '', '1204700', 11, 11, 'UND', 'G', '7.5000', '0.0000', '0.0000', '7.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1104, 'CUCHILLA ROJA GRANDE', '', '', '', 11, 11, 'UND', 'G', '12.6000', '0.0000', '0.0000', '12.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1105, 'TAPA DE MOTOBOMBA', '', '', '', 11, 11, 'UND', 'G', '4.3200', '0.0000', '0.0000', '4.3200', 0, 0, NULL, 1, NULL, NULL, NULL),
(1106, 'DISCO PLATEADO  ALFALFA', '', '', '', 11, 11, 'UND', 'G', '35.0000', '0.0000', '0.0000', '30.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1107, 'TUBO ROJO DE SALIDA', '', '', '', 11, 11, 'UND', 'G', '25.2000', '0.0000', '0.0000', '25.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1108, 'PERNO DE ZAPATA', '', '', '', 11, 11, 'UND', 'G', '3.7000', '0.0000', '0.0000', '3.7000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1109, 'BOBINA PARA MOCHILA DE FUMIGAR', '', '', '', 11, 11, 'UND', 'G', '56.0000', '0.0000', '0.0000', '56.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1110, 'ACOPLE STANDAR', '', '', '', 11, 11, 'UND', 'G', '4.2000', '0.0000', '0.0000', '4.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1111, 'ACEITE X 1 GALON 50 1 SHINDAIWA', '', '', '', 10, 10, 'UND', 'G', '76.0000', '0.0000', '0.0000', '76.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1112, 'LANZA HIDROLAVADORA 90 CM CABEZA GIRATORIA', '', '', '', 11, 11, 'UND', 'G', '25.0000', '0.0000', '0.0000', '22.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1113, 'LANZA DE 5 SALIDAS', '', '', '', 11, 11, 'UND', 'G', '22.0000', '0.0000', '0.0000', '22.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1114, 'BOQUILLA MOVIBLE P HIDROLAVADORA', '', '', '', 11, 11, 'UND', 'G', '10.5000', '0.0000', '0.0000', '10.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1115, 'PISTOLA SPRAY PULVERIZADORA', '', '', '', 11, 11, 'UND', 'G', '21.6000', '0.0000', '0.0000', '21.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1116, 'MOTOR EST GX160 TIPO QX1 ST', '', '', '', 8, 8, 'UND', 'G', '860.0000', '0.0000', '0.0000', '860.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1117, 'LANZA CON CAPUCHA 90 CM WHALE', '', '', '', 20, 20, 'UND', 'G', '55.0000', '0.0000', '0.0000', '55.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1118, 'NANOMETRO WHALE', '', '', '', 11, 11, 'UND', 'G', '32.0000', '0.0000', '0.0000', '32.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1119, 'TAPA DEL ESTARTER CON MECANISMO DE ARRANQUE', '', '', '', 11, 11, 'UND', 'G', '186.0000', '0.0000', '0.0000', '186.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1120, 'ESPOL PLUS MATA ORMIGAS', '', '', '', 11, 11, 'UND', 'G', '70.0000', '0.0000', '0.0000', '70.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1121, 'EMBOLO P/SHP 800', '', '', '', 11, 11, 'UND', 'G', '160.0000', '0.0000', '0.0000', '150.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1122, 'GENER. 5500W 1F GAS. A/M-A/E 220V 60HZ', '', '', '', 9, 9, 'UND', 'G', '2200.0000', '0.0000', '0.0000', '2150.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1123, 'FUMIGADORA MANUAL DE 20LTS TIPO MOCHILA', '', '', '', 2, 2, 'UND', 'G', '78.0000', '0.0000', '0.0000', '78.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1124, 'ACEITE P/MOTOR D/2TIEMPOS 0.1LT H', '', '', '', 10, 10, 'UND', 'G', '3.3600', '0.0000', '0.0000', '3.3600', 0, 0, NULL, 1, NULL, NULL, NULL),
(1125, 'ACEITE P/MOTOR D/2TIEMPOS X 4000ML ( 4 LTR)', '', '', '', 10, 10, 'UND', 'G', '100.0000', '0.0000', '0.0000', '95.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1126, 'CARBURADOR (WYB 14D) ST', '', '', '16100Z0Z815', 11, 11, 'UND', 'G', '167.0000', '0.0000', '0.0000', '167.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1127, 'JGO. DE ANILLOS DE PISTON ST HONDA', '', '', '13010ZM5000', 11, 11, 'UND', 'G', '25.0000', '0.0000', '0.0000', '25.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1128, 'ENS. ARRANQUE RETRACTIL ST HONDA', '', '', '', 11, 11, 'UND', 'G', '37.0000', '0.0000', '0.0000', '37.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1129, 'ENS. EMBRAGUE ST HONDA', '', '', '22000Z0Z003', 11, 11, 'UND', 'G', '35.0000', '0.0000', '0.0000', '35.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1130, 'JEBE DE MONTAJE DE BOMBA ST', '', '', '78230YH3000', 11, 11, 'UND', 'G', '16.0000', '0.0000', '0.0000', '16.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1131, 'MOCHILA FUMIGADORAK', '', '', 'BR900K', 1, 1, 'UND', 'G', '450.0000', '0.0000', '0.0000', '450.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1132, 'MOCHILA FUMIGADORA M', '', '', 'BRQ30A', 1, 1, 'UND', 'G', '670.0000', '0.0000', '0.0000', '670.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1133, 'VALVULA ESTACIONARIO', '', '', 'B16', 11, 11, 'UND', 'G', '1.3500', '0.0000', '0.0000', '1.3500', 0, 0, NULL, 1, NULL, NULL, NULL),
(1134, 'ACOPLES', '', '', 'CPL3', 11, 11, 'UND', 'G', '45.0000', '0.0000', '0.0000', '40.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1135, 'CARBURADOR D 3WF-600 WALBRO', '', '', '', 11, 11, 'UND', 'G', '190.0000', '0.0000', '0.0000', '180.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1136, 'REPUESTO PARA FUMIGADORA A MOTOR  MEDIDOR DE PRESION', '', '', '', 11, 11, 'UND', 'G', '105.0000', '0.0000', '0.0000', '102.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1137, 'REPUESTO PARA FUMIGADORA A MOTOR', '', '', '', 11, 11, 'UND', 'G', '5.0000', '0.0000', '0.0000', '4.8000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1138, 'REPUESTO PARA FUMIGADORA A MOTOR JET AGRO', '', '', '', 11, 11, 'UND', 'G', '7.4000', '0.0000', '0.0000', '7.4000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1139, 'MOTOBOMBA A MOTOR JET AGRO', '', '', '', 19, 19, 'UND', 'G', '240.0000', '0.0000', '0.0000', '230.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1140, 'REPUESTO DE MIST DUSTER BOBINA', '', '', '', 11, 11, 'UND', 'G', '21.0000', '0.0000', '0.0000', '19.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1141, 'REPUESTO PARA MIST DUSTER MINI  TANQUE DE GASOLINA X 15 CM', '', '', '', 11, 11, 'UND', 'G', '22.0000', '0.0000', '0.0000', '21.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1142, 'REPUESTO PARA MIST DUSTER TANQUE DE AGUA', '', '', '', 11, 11, 'UND', 'G', '50.0000', '0.0000', '0.0000', '48.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1143, 'REPUESTO PARA FUMIGADOR TAPA PLASTICA', '', '', '', 11, 11, 'UND', 'G', '6.0000', '0.0000', '0.0000', '5.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1144, 'REPUESTO PARA MIST DUSTER TUBO FLWXIBLE PLASTICO X 15 CM', '', '', '', 11, 11, 'UND', 'G', '11.0000', '0.0000', '0.0000', '10.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1145, 'REPUESTO PARA MIST DUSTER PLAQUITA DE METAL', '', '', '', 11, 11, 'UND', 'G', '6.5000', '0.0000', '0.0000', '6.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1146, 'REPUESTO PARA MIST DUSTER BOQUILLAS ACCESORIOS', '', '', '', 11, 11, 'UND', 'G', '11.0000', '0.0000', '0.0000', '10.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1147, 'REPUESTO PARA FUMIGADORA MANUAL', '', '', '', 11, 11, 'UND', 'G', '5.0000', '0.0000', '0.0000', '4.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1148, 'REPUESTO PARA FUMIGADORA CORREA', '', '', '', 11, 11, 'UND', 'G', '7.3500', '0.0000', '0.0000', '7.3500', 0, 0, NULL, 1, NULL, NULL, NULL),
(1149, 'REPUESTO PARA FUMIGADORA LANZA DE ACERO', '', '', '', 11, 11, 'UND', 'G', '9.6000', '0.0000', '0.0000', '9.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1150, 'REPUESTO PARA FUMIGADORA BOQUILLA NEGRA', '', '', '', 11, 11, 'UND', 'G', '13.0000', '0.0000', '0.0000', '12.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1151, 'REPUESTO PARA FUMIGADORA GANCHITO DE METAL', '', '', '', 11, 11, 'UND', 'G', '3.0000', '0.0000', '0.0000', '2.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1152, 'REPUESTO PARA FUMIGADORA PLAQUIRA METALL', '', '', '', 11, 11, 'UND', 'G', '4.0000', '0.0000', '0.0000', '3.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1153, 'REPUESTO PARA FUMIGADOR A MOTOR JET AGRO', '', '', '', 11, 11, 'UND', 'G', '8.0000', '0.0000', '0.0000', '7.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1154, 'REPUESTO PARA FUMIGADOR MANUAL JET AGRO', '', '', '', 11, 11, 'UND', 'G', '6.3000', '0.0000', '0.0000', '6.3000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1155, 'REPUESTO PARA FUMIGADORA TAPA PORTA ESTOPA', '', '', '', 11, 11, 'UND', 'G', '5.5000', '0.0000', '0.0000', '4.8000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1156, 'REPUESTO PARA FUMIGADORA GANCHO DE METAL', '', '', '', 11, 11, 'UND', 'G', '0.4200', '0.0000', '0.0000', '0.4200', 0, 0, NULL, 1, NULL, NULL, NULL),
(1157, 'REPUESTO PARA FUMIGADORA MANUAL MANGUERA X 1.20 MT', '', '', '', 11, 11, 'UND', 'G', '6.5000', '0.0000', '0.0000', '6.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1158, 'REPUESTO PARA FUMIGADOR A MOTOR JET', '', '', '', 11, 11, 'UND', 'G', '21.0000', '0.0000', '0.0000', '21.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1159, 'REPUESTO PARA FUMIGADORA JALADOR CHICO', '', '', '', 11, 11, 'UND', 'G', '11.0000', '0.0000', '0.0000', '9.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1160, 'REPUESTO PARA FUMIGADOR A MOTOR JETAGRO', '', '', '', 11, 11, 'UND', 'G', '32.0000', '0.0000', '0.0000', '30.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1161, 'REPUESTO PARA FUMIGADORA SET PISTON ANILLOS', '', '', '', 11, 11, 'UND', 'G', '35.0000', '0.0000', '0.0000', '33.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1162, 'REPUESTO PARA FUMIGADORA CAMPANA CHICA', '', '', '', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '14.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1163, 'BRUSH CUTTER DESBROZDORA  JET AGRO', '', '', '', 3, 3, 'UND', 'G', '900.0000', '0.0000', '0.0000', '850.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1164, 'FUMIGADORA MANUAL 20 LTS', '', '', '', 2, 2, 'UND', 'G', '89.2500', '0.0000', '0.0000', '89.2500', 0, 0, NULL, 1, NULL, NULL, NULL),
(1165, 'MEMBRANA 1005300.06', '', '', '', 11, 11, 'UND', 'G', '11.0000', '0.0000', '0.0000', '10.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1166, 'ANILLO DE JUNTA 5X1,5VITON', '', '', '', 11, 11, 'UND', 'G', '40.0000', '0.0000', '0.0000', '38.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1167, 'ANILLO DE JUNTA 1,5X1VITON', '', '', '', 11, 11, 'UND', 'G', '29.4000', '0.0000', '0.0000', '29.4000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1168, 'JUNTA 805000.02', '', '', '', 11, 11, 'UND', 'G', '8.4000', '0.0000', '0.0000', '8.4000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1169, 'JUNTA 1007101.05', '', '', '', 11, 11, 'UND', 'G', '6.0000', '0.0000', '0.0000', '5.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1170, 'JUNTA 1007101.06', '', '', '', 11, 11, 'UND', 'G', '26.0000', '0.0000', '0.0000', '25.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1171, 'MANGUERA DE SUCCION 1 1/2', '', '', '', 11, 11, 'UND', 'G', '71.0000', '0.0000', '0.0000', '71.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1172, 'REPUESTO DE FUMIGADORA VIELA DE METAL', '', '', '', 11, 11, 'UND', 'G', '9.5000', '0.0000', '0.0000', '8.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1173, 'SEMBRADORA MANUAL', '', '', '', 39, 39, 'UND', 'G', '840.0000', '0.0000', '0.0000', '750.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1174, 'ATOMIZADOR 3WF-3A NARANJA', '', '', '', 1, 1, 'UND', 'G', '372.0000', '0.0000', '0.0000', '372.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1175, 'ATOMIZADOR MODELO 3WF-600', '', '', '', 1, 1, 'UND', 'G', '850.0000', '0.0000', '0.0000', '800.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1176, 'ATOMIZADORA 3WF-808 20LTS', '', '', '', 1, 1, 'UND', 'G', '490.0000', '0.0000', '0.0000', '490.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1177, 'MOTOBOMBA GASOLINA 3.5 HP', '', '', '', 19, 19, 'UND', 'G', '520.0000', '0.0000', '0.0000', '510.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1178, 'TORNILLO CILINDRICO MSX25', '', '', '', 11, 11, 'UND', 'G', '4.2000', '0.0000', '0.0000', '4.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1179, 'JAULA DE AGUJAS', '', '', '', 11, 11, 'UND', 'G', '36.0000', '0.0000', '0.0000', '35.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1180, 'PUNTA CURVA', '', '', '', 11, 11, 'UND', 'G', '0.0000', '0.0000', '0.0000', '0.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1181, 'PUNTA REGULABLE', '', '', '', 11, 11, 'UND', 'G', '0.0000', '0.0000', '0.0000', '0.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1182, 'CARBURADOR SOLO', '', '', '', 11, 11, 'UND', 'G', '260.0000', '0.0000', '0.0000', '260.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1183, 'BUJIA SOLO', '', '', '', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '15.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1184, 'MS382 MOTOSIERRA 75CM/30\" 36RM 1119-200-0283', '', '', '', 4, 4, 'UND', 'G', '2680.0000', '0.0000', '0.0000', '2650.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1185, 'PIÑOM DE CADENA 1/4', '', '', '', 11, 11, 'UND', 'G', '75.0000', '0.0000', '0.0000', '72.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1186, 'CEDENA STIHL OLEOMATIC', '', '', '', 11, 11, 'UND', 'G', '105.0000', '0.0000', '0.0000', '99.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1187, 'GUIA DE CADENA ROLOMATIC DE 1/4', '', '', '', 11, 11, 'UND', 'G', '145.0000', '0.0000', '0.0000', '145.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1188, 'PIÑON DE CADENA 1/4 PICO', '', '', '', 11, 11, 'UND', 'G', '73.5000', '0.0000', '0.0000', '73.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1189, 'MOCHILA FUMIGADORA C MOTOR WI-900 TU 26', '', '', '', 1, 1, 'UND', 'G', '380.0000', '0.0000', '0.0000', '380.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1190, 'CARBURADOR WALBRO C43', '', '', '', 11, 11, 'UND', 'G', '95.0000', '0.0000', '0.0000', '90.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1191, 'CADENA 3/8 ESP 250', '', '', '', 11, 11, 'UND', 'G', '78.0000', '0.0000', '0.0000', '70.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1192, 'LLAVE DE IMPACTO NEUM. 1\" 2200N.M', '', '', '', 16, 16, 'UND', 'G', '4700.0000', '0.0000', '0.0000', '4650.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1193, 'LLAVE DE IMPACTO NEUM. 1/2 REXON', '', '', '', 16, 16, 'UND', 'G', '220.0000', '0.0000', '0.0000', '210.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1194, 'LLAVE DE IMPACTO NEUM. 1\" 2200N.M 3900RP', '', '', '', 16, 16, 'UND', 'G', '675.0000', '0.0000', '0.0000', '650.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1195, 'LLAVE DE IMPACTO NEUM. 1/2\" P', '', '', '', 16, 16, 'UND', 'G', '235.0000', '0.0000', '0.0000', '225.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1196, 'UNIONES MIXTA', '', '', '', 11, 11, 'UND', 'G', '9.5000', '0.0000', '0.0000', '9.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1197, 'ABRAZADERA GALV', '', '', '', 11, 11, 'UND', 'G', '0.3700', '0.0000', '0.0000', '0.2100', 0, 0, NULL, 1, NULL, NULL, NULL),
(1198, 'PCS VALVULA REPUESTO DE FUMIGADORA MANUAL', '', '', '', 11, 11, 'UND', 'G', '5.8000', '0.0000', '0.0000', '5.8000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1199, 'SET REPUESTO DE FUMIGADORA MANUAL', '', '', '', 11, 11, 'UND', 'G', '30.0000', '0.0000', '0.0000', '30.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1200, 'MOTOBOMBA AUTOCEBANTE 4X4 10 HP', '', '', '', 19, 19, 'UND', 'G', '2200.0000', '0.0000', '0.0000', '2200.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1201, 'PCS REPUESTO PARA FUMIGADORA BASE METAL', '', '', '', 11, 11, 'UND', 'G', '21.0000', '0.0000', '0.0000', '21.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1202, 'AHOYADORA 2 TIEMPOS 52CC BN520A', '', '', '', 39, 39, 'UND', 'G', '626.0000', '0.0000', '0.0000', '626.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1203, 'AHOYADORA 2 TIEMPOS 52CC BN520B', '', '', '', 39, 39, 'UND', 'G', '637.0000', '0.0000', '0.0000', '637.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1204, 'MOTOBOMBA GASOL 1X5 1X5', '', '', '', 19, 19, 'UND', 'G', '534.0000', '0.0000', '0.0000', '534.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1205, 'PULV DORSAL SIMETRICO SP 20 L', '', '', '', 2, 2, 'UND', 'G', '1.0000', '0.0000', '0.0000', '1.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1206, 'BROCA DE AHOYADORA 10CM*80CM*02CM', '', '', '', 11, 11, 'UND', 'G', '61.0000', '0.0000', '0.0000', '61.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1207, 'BROCA DE AHOYADORA 15CM*80CM*02CM', '', '', '', 11, 11, 'UND', 'G', '76.0000', '0.0000', '0.0000', '76.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1208, 'BROCA DE AHOYADORA 20CM*80CM*02CM', '', '', '', 11, 11, 'UND', 'G', '94.0000', '0.0000', '0.0000', '94.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1209, 'BROCA DE AHOYADORA 25CM*80CM*02CM', '', '', '', 11, 11, 'UND', 'G', '118.0000', '0.0000', '0.0000', '118.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1210, 'BROCA DE AHOYADORA 30CM*80CM*02CM', '', '', '', 11, 11, 'UND', 'G', '136.0000', '0.0000', '0.0000', '136.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1211, 'EXTENSOR DE AHOYADORA 50CM', '', '', '', 11, 11, 'UND', 'G', '29.0000', '0.0000', '0.0000', '29.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1212, 'EXTENSOR DE AHOYADORA 60CM', '', '', '', 11, 11, 'UND', 'G', '32.0000', '0.0000', '0.0000', '32.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1213, 'EXTENSOR DE AHOYADORA 80CM', '', '', '', 11, 11, 'UND', 'G', '35.0000', '0.0000', '0.0000', '35.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1214, 'EXTENSOR DE AHOYADORA 1M', '', '', '', 11, 11, 'UND', 'G', '39.0000', '0.0000', '0.0000', '39.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1215, 'BOMBA PISTON COMPLETA WHALE BEST 533C', '', '', '', 13, 13, 'UND', 'G', '2800.0000', '0.0000', '0.0000', '2800.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1216, 'MANGA BD CRISTAL 26 X 2', '', '', '', 11, 11, 'MTS', 'G', '18.0000', '0.0000', '0.0000', '18.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1217, 'CARBURADOR 40 CC RUXING', '', '', '', 11, 11, 'UND', 'G', '40.0000', '0.0000', '0.0000', '40.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1218, 'CAJA12 SPRY LIMPIA CARBURADOR DE 356 ML ONZ', '', '', '', 11, 11, 'UND', 'G', '129.0000', '0.0000', '0.0000', '129.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1219, 'TAPER 2 LITIUN MULTIPROPOSITO ROJO 210 GRS', '', '', '', 11, 11, 'UND', 'G', '0.0000', '0.0000', '0.0000', '0.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1220, 'CAJA 12 LITIUN MULTIPROPOSITO ROJO 210 GRS', '', '', '', 11, 11, 'UND', 'G', '78.0000', '0.0000', '0.0000', '78.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1221, 'CAJA 12 LITIUN MULTIPROPOSITO ROJO 120 GRS', '', '', '', 11, 11, 'UND', 'G', '93.0000', '0.0000', '0.0000', '93.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1222, 'CAJ12 RAYDEN GASOLINA MONOGRADO 50 DE 1 LT', '', '', '', 10, 10, 'UND', 'G', '126.0000', '0.0000', '0.0000', '126.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1223, 'CAJ12 BLINDAX 10W30 1/4 GALON', '', '', '', 10, 10, 'UND', 'G', '208.0000', '0.0000', '0.0000', '208.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1224, 'MS 250 MOTOSIERRA 45CM/18 63PMC', '', '', '1123-200-0878', 4, 4, 'UND', 'G', '1084.0000', '0.0000', '0.0000', '1084.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1225, 'GATA T TORRE DE 3TN', '', '', '', 11, 11, 'UND', 'G', '154.0000', '0.0000', '0.0000', '154.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1226, 'CABEZAL DE ALTA PRESION CERAMICO MODELO LU 30CGM', '', '', '', 13, 13, 'UND', 'G', '384.0000', '0.0000', '0.0000', '384.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1227, 'CABEZAL DE ALTA PRESION CERAMICO MODELO LU 30SCM', '', '', '', 13, 13, 'UND', 'G', '390.0000', '0.0000', '0.0000', '390.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1228, 'CABEZAL DE ALTA PRESION CERAMICO MODELO LU 30C M', '', '', '', 13, 13, 'UND', 'G', '498.0000', '0.0000', '0.0000', '498.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1229, 'CABEZAL DE ALTA PRESION CERAMICO MODELO LU 340C M', '', '', '', 13, 13, 'UND', 'G', '833.0000', '0.0000', '0.0000', '833.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1230, 'GENERADOR GASOLINERO DE 2.5/2.8 KW', '', '', '', 9, 9, 'UND', 'G', '1380.0000', '0.0000', '0.0000', '1380.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1231, 'GENERADOR GASOLINERO DE 7 KW', '', '', '', 9, 9, 'UND', 'G', '2688.0000', '0.0000', '0.0000', '2688.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1232, 'MANGA PLASTICA', '', '', '', 11, 11, 'UND', 'G', '3.1500', '0.0000', '0.0000', '3.1500', 0, 0, NULL, 1, NULL, NULL, NULL),
(1233, 'MS 170 3/8 MOTOSIERRA 40 CM 16 63 PM3', '', '', '1130-200-0508', 4, 4, 'UND', 'G', '860.0000', '0.0000', '0.0000', '850.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1234, 'MANG PVC AUTOMOTRIZ ACARAMELADA 3X6MM 1/8', '', '', '', 11, 11, 'UND', 'G', '18.6000', '0.0000', '0.0000', '18.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1235, 'MAN NITRILO P GASOLINA SIN LONA', '', '', '', 11, 11, 'UND', 'G', '96.0000', '0.0000', '0.0000', '96.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1236, 'EMP JEBE NATURAL X 1 MTS EUROFLEX MM 3.2 MM', '', '', '', 11, 11, 'UND', 'G', '96.0000', '0.0000', '0.0000', '96.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1237, 'CORREAS BANDO LISA TIPO A 1/2 SELLO ROJO', '', '', '', 11, 11, 'UND', 'G', '12.0000', '0.0000', '0.0000', '12.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1238, 'MOTOBOMBA GASOL 3.5 HP 1.5 X1.5', '', '', 'BN-WP15', 19, 19, 'UND', 'G', '530.0000', '0.0000', '0.0000', '530.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1239, 'EMBOLO PLASTICO PJH', '', '', '', 11, 11, 'UND', 'G', '0.0000', '0.0000', '0.0000', '0.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1240, 'PERNO MILIMETRICO 5.8', '', '', '', 11, 11, 'UND', 'G', '0.1200', '0.0000', '0.0000', '0.1200', 0, 0, NULL, 1, NULL, NULL, NULL),
(1241, 'TUERCA 6.5', '', '', '', 11, 11, 'UND', 'G', '0.4200', '0.0000', '0.0000', '0.4200', 0, 0, NULL, 1, NULL, NULL, NULL),
(1242, 'PERNO MILIMETRICO 5', '', '', '', 11, 11, 'UND', 'G', '0.0900', '0.0000', '0.0000', '0.0900', 0, 0, NULL, 1, NULL, NULL, NULL),
(1243, 'FUMIGADORA A MOTOR 25 LT JET2020', '', '', '', 1, 1, 'UND', 'G', '210.0000', '0.0000', '0.0000', '210.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1244, 'REPUESTO PARA FUMIGADORA TAPA PORTA ESTOP', '', '', '', 11, 11, 'UND', 'G', '2.1000', '0.0000', '0.0000', '2.1000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1245, 'REPUESTO PARA FUMIGADORA CAMPAN CHICA', '', '', '', 11, 11, 'UND', 'G', '4.2000', '0.0000', '0.0000', '4.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1246, 'CAMPAN CHICA', '', '', '', 11, 11, 'UND', 'G', '6.3000', '0.0000', '0.0000', '6.3000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1247, 'BOMBA DE AGUA BR20', '', '', 'BR20RD', 19, 19, 'UND', 'G', '530.0000', '0.0000', '0.0000', '530.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1248, 'MANGUERA D SUCCION', '', '', '', 11, 11, 'UND', 'G', '42.0000', '0.0000', '0.0000', '42.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1249, 'FILTRO EST', '', '', '', 11, 11, 'UND', 'G', '8.4000', '0.0000', '0.0000', '8.4000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1250, 'CARBURADRO GX50', '', '', '', 11, 11, 'UND', 'G', '38.0000', '0.0000', '0.0000', '38.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1251, 'MANGUERA FLEX', '', '', '', 11, 11, 'UND', 'G', '19.0000', '0.0000', '0.0000', '19.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1252, 'TUBO DESCARGA', '', '', '', 11, 11, 'UND', 'G', '23.0000', '0.0000', '0.0000', '23.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1253, 'TUBO ESPARCIDOR', '', '', '', 11, 11, 'UND', 'G', '30.0000', '0.0000', '0.0000', '30.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1254, 'BASES PARA HIDROLAVADORA', '', '', '', 11, 11, 'UND', 'G', '69.0000', '0.0000', '0.0000', '69.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1255, 'CARRETA PARA HIFROLAVADORA', '', '', '', 11, 11, 'UND', 'G', '242.0000', '0.0000', '0.0000', '242.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1256, 'MOTOBOMBA 2X2 7 HP', '', '', '', 19, 19, 'UND', 'G', '590.0000', '0.0000', '0.0000', '590.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1257, 'ESPOLVOREADOR DORSAL SUPER4 ND', '', '', '', 15, 15, 'UND', 'G', '985.0000', '0.0000', '0.0000', '900.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1258, 'MOTOFUMIGADORA VARILLERA DE 4 TIEMPOS LU-900A', '', '', '', 1, 1, 'UND', 'G', '525.0000', '0.0000', '0.0000', '525.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1259, 'LANZA DE MANOPLA 40 BAR 60 CM', '', '', '', 11, 11, 'UND', 'G', '175.0000', '0.0000', '0.0000', '175.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1260, 'ADAPTADOR DE 13 M M', '', '', '', 11, 11, 'UND', 'G', '13.0000', '0.0000', '0.0000', '13.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1261, 'ROLLO DE CADENA C85 100\" HUSWARNA', '', '', '', 11, 11, 'UND', 'G', '2.3500', '0.0000', '0.0000', '2.3500', 0, 0, NULL, 1, NULL, NULL, NULL),
(1262, 'ZAPATA DE EMBRAG. COMPLET. P/577', '', '', '', 11, 11, 'UND', 'G', '193.0000', '0.0000', '0.0000', '193.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1263, 'TORNILLO TENSADOR DE CADENA P/577', '', '', '', 11, 11, 'UND', 'G', '7.0000', '0.0000', '0.0000', '7.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1264, 'PASADOR DE AJUSTE P/757-577-488', '', '', '', 11, 11, 'UND', 'G', '8.5000', '0.0000', '0.0000', '8.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1265, 'MANGUERA PARA HIDRO DE 100 MTS', '', '', '', 12, 12, 'UND', 'G', '225.0000', '0.0000', '0.0000', '225.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1266, 'MOTOFUMIGADORA CON TUBO MODELO TM30A', '', '', '', 2, 2, 'UND', 'G', '640.0000', '0.0000', '0.0000', '640.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1267, 'LANZA HIDROLAVADORA 35CM', '', '', '', 11, 11, 'UND', 'G', '12.0000', '0.0000', '0.0000', '12.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1268, 'MOCHILA GASOLINERA 4 TIEMPOS', '', '', '', 1, 1, 'UND', 'G', '600.0000', '0.0000', '0.0000', '600.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1269, 'CAJA24 EP 2 LITHIUN MULTIPROPOSITO AMARILLO 210GR', '', '', '', 11, 11, 'UND', 'G', '85.0000', '0.0000', '0.0000', '85.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1270, 'CAJ24 EP2 LITHIUN MULTIPROPOSITO ROJO 120GR', '', '', '', 11, 11, 'UND', 'G', '57.0000', '0.0000', '0.0000', '57.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1271, 'SEGMENTO COMPRESION 056X1.2 MM', '', '', '', 11, 11, 'UND', 'G', '45.0000', '0.0000', '0.0000', '45.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1272, 'PULVERIZADOR GOIZPER SALUD PUBLICA', '', '', '', 2, 2, 'UND', 'G', '225.0000', '0.0000', '0.0000', '225.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1273, 'EMPUÑADURA 4800170', '', '', '', 11, 11, 'UND', 'G', '55.0000', '0.0000', '0.0000', '55.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1274, 'TOBERA REGULABLE', '', '', '', 11, 11, 'UND', 'G', '23.0000', '0.0000', '0.0000', '23.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1275, 'BOMBA DE COMBUSTIBLE', '', '', '', 11, 11, 'UND', 'G', '27.0000', '0.0000', '0.0000', '27.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1276, 'FILTRO ADICIONAL', '', '', '', 11, 11, 'UND', 'G', '7.0000', '0.0000', '0.0000', '7.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1277, 'BOMBA DE COMBUSTIBLE FS 250', '', '', '', 11, 11, 'UND', 'G', '23.5200', '0.0000', '0.0000', '23.5200', 0, 0, NULL, 1, NULL, NULL, NULL),
(1278, 'LANZA WHALE 90CM', '', '', '', 11, 11, 'UND', 'G', '82.0000', '0.0000', '0.0000', '82.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1279, 'PISTOLA SPRAY PULVERIZADORA DH1', '', '', '', 11, 11, 'UND', 'G', '19.3000', '0.0000', '0.0000', '19.3000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1280, 'PISTOLA ROCIADOR ALTA PRESION EUROPEO', '', '', '', 11, 11, 'UND', 'G', '126.0000', '0.0000', '0.0000', '126.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1281, 'CABEZAL HIDROLAVADORA AC 120AN', '', '', '', 13, 13, 'UND', 'G', '1152.0000', '0.0000', '0.0000', '1152.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1282, 'MOTOSIERRA 24\" 3.3HP DEREK MOTORS', '', '', '', 4, 4, 'UND', 'G', '540.0000', '0.0000', '0.0000', '540.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1283, 'CINTA DE EMBALAJE', '', '', '', 11, 11, 'UND', 'G', '4.3000', '0.0000', '0.0000', '4.3000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1284, 'CINTA FILM 45CM', '', '', '', 11, 11, 'UND', 'G', '24.0000', '0.0000', '0.0000', '24.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1285, 'TUBO FLEXIBLE S', '', '', '', 11, 11, 'UND', 'G', '18.0000', '0.0000', '0.0000', '18.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1286, 'FILTRO DE AIRE S', '', '', '', 11, 11, 'UND', 'G', '35.0000', '0.0000', '0.0000', '35.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1287, 'CADENA STHIL OLEOMATIC', '', '', '', 11, 11, 'UND', 'G', '90.0000', '0.0000', '0.0000', '90.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1288, 'CADENA STHIL OLEOMATIC 12', '', '', '', 11, 11, 'UND', 'G', '108.0000', '0.0000', '0.0000', '108.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1289, 'PIÑON DE CADENA S', '', '', '', 11, 11, 'UND', 'G', '90.0000', '0.0000', '0.0000', '90.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1290, 'LANZA WHALE RECTA 90CM', '', '', '', 11, 11, 'UND', 'G', '77.0000', '0.0000', '0.0000', '77.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1291, 'KIT DE JUNTAS', '', '', '', 11, 11, 'UND', 'G', '142.0000', '0.0000', '0.0000', '142.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1292, 'MANGUERA DE 8.5 X 100 MTS', '', '', '', 11, 11, 'UND', 'G', '281.0000', '0.0000', '0.0000', '281.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1293, 'MODULOD IGNICION S', '', '', '', 11, 11, 'UND', 'G', '295.0000', '0.0000', '0.0000', '295.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1294, 'ATOMIZADOR 25 LT 35.8 CC 1.3 HP', '', '', '', 15, 15, 'UND', 'G', '551.0000', '0.0000', '0.0000', '551.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1295, 'MOTOSIERRA STHIL MS 250', '', '', '', 4, 4, 'UND', 'G', '1150.0000', '0.0000', '0.0000', '1150.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1296, 'CADENA STHIL OLEAMATIC 18 PULGA', '', '', '', 11, 11, 'UND', 'G', '75.6000', '0.0000', '0.0000', '75.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1297, 'FILTRO DE AIRE MS250', '', '', '', 11, 11, 'UND', 'G', '22.8000', '0.0000', '0.0000', '22.8000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1298, 'BATERIA ETNA', '', '', '', 11, 11, 'UND', 'G', '280.0000', '0.0000', '0.0000', '280.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1299, 'REPUESTO PARA FUMIGADORA MANUAL CAMARA', '', '', '', 11, 11, 'UND', 'G', '63.0000', '0.0000', '0.0000', '63.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1300, 'JUNTA 1125-129-0500', '', '', '', 11, 11, 'UND', 'G', '12.0000', '0.0000', '0.0000', '12.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1301, 'CARBURADOR 4244-120-0611', '', '', '', 11, 11, 'UND', 'G', '325.0000', '0.0000', '0.0000', '325.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1302, 'BATERIA ETNA 12 VOLTIOS', '', '', '', 11, 11, 'UND', 'G', '285.0000', '0.0000', '0.0000', '285.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1303, 'CADENA OLEOMATIC DE 16 PG', '', '', '', 11, 11, 'UND', 'G', '84.0000', '0.0000', '0.0000', '84.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1304, 'CADENA STHIL 16 PG', '', '', '', 11, 11, 'UND', 'G', '85.0000', '0.0000', '0.0000', '85.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1305, 'AMORTIGUADORES DLT', '', '', '', 11, 11, 'UND', 'G', '150.0000', '0.0000', '0.0000', '150.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1306, 'ABRAZADERA DE MANGUERA 5/8 ZINC', '', '', '', 11, 11, 'UND', 'G', '0.3200', '0.0000', '0.0000', '0.3200', 0, 0, NULL, 1, NULL, NULL, NULL),
(1307, 'REDUC DE CAMPANA', '', '', '', 11, 11, 'UND', 'G', '28.0000', '0.0000', '0.0000', '28.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1308, 'MOTOR GASOLINERO DE 15 HP', '', '', '', 8, 8, 'UND', 'G', '1010.0000', '0.0000', '0.0000', '1010.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1309, 'PINON DE CADENA 3/8PULG PICCO 7D', '', '', '', 11, 11, 'UND', 'G', '85.0000', '0.0000', '0.0000', '85.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1310, 'GUIA DE CADENA ROLLOMATIC DE 18 PULG', '', '', '', 11, 11, 'UND', 'G', '182.0000', '0.0000', '0.0000', '182.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1311, 'SINFIN', '', '', '', 11, 11, 'UND', 'G', '26.0000', '0.0000', '0.0000', '26.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1312, 'MOCHILA DE FUMIGAR DE 4 TIEMPOS', '', '', '', 1, 1, 'UND', 'G', '600.0000', '0.0000', '0.0000', '600.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1313, 'MOTOR EST. GX160 TIPO QAB3 ST', '', '', '', 8, 8, 'UND', 'G', '1168.0000', '0.0000', '0.0000', '1168.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1314, 'CARBURADOR C1Q-100335G', '', '', '1123-120-0631', 1, 1, 'UND', 'G', '204.0000', '0.0000', '0.0000', '204.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1315, 'GUÍA R 45CM/18\" 1,3MM/0.050\" 3/8\" P', '', '', '3005-000-4817', 11, 11, 'UND', 'G', '160.0000', '0.0000', '0.0000', '160.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1316, '63 PM3 PICCO MICRO ROLLO DE CADENA', '', '', '3636-000-1640', 11, 11, 'UND', 'G', '1689.6000', '0.0000', '0.0000', '1689.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1317, 'LIMA REDONDA 3,5X150', '', '', '5605-771-3506', 11, 11, 'UND', 'G', '5.7000', '0.0000', '0.0000', '5.7000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1318, 'CABLE BOWDEN', '', '', '4203-180-1104', 11, 11, 'UND', 'G', '106.0000', '0.0000', '0.0000', '106.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1319, 'FILTRO DE AIRE', '', '', '4203-141-0301', 11, 11, 'UND', 'G', '40.0000', '0.0000', '0.0000', '40.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1320, 'BRIDA INTERMEDIA', '', '', '4244-120-2300', 11, 11, 'UND', 'G', '36.0000', '0.0000', '0.0000', '36.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1321, 'TUBO FLEXIBLE TIPO ACORDEÓN', '', '', '4203-701-6102', 11, 11, 'UND', 'G', '41.0000', '0.0000', '0.0000', '41.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1322, 'FILTRO DE AIRE FS 250', '', '', '4134-141-0300', 11, 11, 'UND', 'G', '27.0000', '0.0000', '0.0000', '27.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1323, 'JUNTA SR 440', '', '', '4244-129-0900', 11, 11, 'UND', 'G', '5.0000', '0.0000', '0.0000', '5.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1324, 'JUNTA CAR 440', '', '', '1125-129-0500', 11, 11, 'UND', 'G', '2.3000', '0.0000', '0.0000', '2.3000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1325, 'PIÑÓN DE CADENA 3/8\" PICCO 7D', '', '', '1123-640-2072', 11, 11, 'UND', 'G', '69.0000', '0.0000', '0.0000', '69.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1326, 'SINFÍN', '', '', '1123-640-7102', 11, 11, 'UND', 'G', '18.2000', '0.0000', '0.0000', '18.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1327, 'RESORTE STIHL', '', '', '1123-647-2400', 11, 11, 'UND', 'G', '3.1000', '0.0000', '0.0000', '3.1000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1328, 'WP 300 BOMBA DE AGUA', '', '', 'VB03-011-2000', 19, 19, 'UND', 'G', '1250.0000', '0.0000', '0.0000', '1250.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1329, 'WP600(ROW) BOMBA DE AGUA', '', '', 'VB04-011-2000', 19, 19, 'UND', 'G', '1470.0000', '0.0000', '0.0000', '1470.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1330, 'QB60 BOMBA PERIFERICA PARA AGUA 0.5 HP', '', '', '', 40, 40, 'UND', 'G', '147.0000', '0.0000', '0.0000', '147.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1331, 'QB80 BOMBA PERIFERICA PARA AGUA 1HP', '', '', '', 25, 25, 'UND', 'G', '260.0000', '0.0000', '0.0000', '260.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1332, 'VLK QB 60N BOMBA PERIFERICA ROJA 0.5 HP', '', '', '', 25, 25, 'UND', 'G', '160.0000', '0.0000', '0.0000', '160.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1333, 'CPM158 ELECTROBOMBA CENTRIFUGA 1HP', '', '', '', 25, 25, 'UND', 'G', '336.0000', '0.0000', '0.0000', '336.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1334, 'DTM20 ELECTROBOMBA CENTRIFUGA 2X2 2HP', '', '', '', 25, 25, 'UND', 'G', '675.0000', '0.0000', '0.0000', '675.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1335, 'JET-100ST BOMBA JET ACERADA', '', '', '', 25, 25, 'UND', 'G', '391.0000', '0.0000', '0.0000', '391.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1336, 'STARTER REBOBINADO', '', '', '', 11, 11, 'UND', 'G', '152.0000', '0.0000', '0.0000', '152.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1337, 'MS382 MOTOSIERRA 75CM/30 36RM 1119-200-0283', '', '', '', 4, 4, 'UND', 'G', '2625.0000', '0.0000', '0.0000', '2625.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1338, 'ATOMISADORA 17LTS 77CC 5HP', '', '', '', 1, 1, 'UND', 'G', '922.0000', '0.0000', '0.0000', '922.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1339, 'MANG. AUTOMOTRIZ TRANSPARENTE', '', '', '', 11, 11, 'UND', 'G', '76.0000', '0.0000', '0.0000', '76.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1340, 'MANGUERA PARA HIDRO DE 100 MTS 13MM MOD LU03B M', '', '', '', 12, 12, 'UND', 'G', '480.0000', '0.0000', '0.0000', '480.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1341, 'CABEZAL DE ALTA PRESION CERAMICO MODELO LU30SC M', '', '', '', 13, 13, 'UND', 'G', '387.0000', '0.0000', '0.0000', '387.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1342, 'LANZA PARA HIDROLAVADORA DE 90 CM SIN CAPUCHA CURVO', '', '', '', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '15.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1343, 'CILINDRO CON PISTON 1123-020-1209 MS250', '', '', '', 11, 11, 'UND', 'G', '520.0000', '0.0000', '0.0000', '520.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1344, 'PERNOS MILIMETRICOS CA', '', '', '', 11, 11, 'UND', 'G', '90.0000', '0.0000', '0.0000', '90.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1345, 'FAJAS A41', '', '', '', 11, 11, 'UND', 'G', '11.0000', '0.0000', '0.0000', '11.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1346, 'CARBURADOR GX160', '', '', '', 11, 11, 'UND', 'G', '36.0000', '0.0000', '0.0000', '36.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1347, 'CARBURADOR GX390', '', '', '', 11, 11, 'UND', 'G', '41.0000', '0.0000', '0.0000', '41.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1348, 'KIT DE AD/ESC GX160', '', '', '', 11, 11, 'UND', 'G', '17.0000', '0.0000', '0.0000', '17.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1349, 'ARRANCADOR 160', '', '', '', 11, 11, 'UND', 'G', '21.5000', '0.0000', '0.0000', '21.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1350, 'ARRANCADOR GX390', '', '', '', 11, 11, 'UND', 'G', '31.0000', '0.0000', '0.0000', '31.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1351, 'SOQUILLAGX160', '', '', '', 16, 16, 'UND', 'G', '3.0000', '0.0000', '0.0000', '3.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1352, 'SOGILLA ARRANQUE', '', '', '', 11, 11, 'UND', 'G', '3.0000', '0.0000', '0.0000', '3.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1353, 'LANZA MANOPOLA 600 15 BRAGLIA', '', '', '', 11, 11, 'UND', 'G', '179.0000', '0.0000', '0.0000', '179.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1354, 'PISTOLA DE ALTA PRESION POWER SPRAYER', '', '', '', 11, 11, 'UND', 'G', '78.0000', '0.0000', '0.0000', '78.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1355, 'BR20BL  BOMBA DE AGUA', '', '', '', 19, 19, 'UND', 'G', '620.0000', '0.0000', '0.0000', '620.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1356, 'BOMBA DE COMBUSTIBLE 0000-350-6201 FS250', '', '', '', 11, 11, 'UND', 'G', '42.0000', '0.0000', '0.0000', '42.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1357, 'ROLLO DE MANGUERA DE 2 PULGADAS', '', '', '', 12, 12, 'UND', 'G', '1100.0000', '0.0000', '0.0000', '1100.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1358, 'ACOPLE DE 2', '', '', '', 11, 11, 'UND', 'G', '55.0000', '0.0000', '0.0000', '55.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1359, 'MOCHILA FUMIGADORA WJR4025 TIPO GCS', '', '', '', 11, 11, 'UND', 'G', '2350.0000', '0.0000', '0.0000', '2350.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1360, 'TOBERA CHORRO ANCHO 4074263', '', '', '', 11, 11, 'UND', 'G', '14.0000', '0.0000', '0.0000', '14.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1361, 'MANGUERA PARA HIDRO DE 100MTS LU02M', '', '', '', 12, 12, 'UND', 'G', '191.0000', '0.0000', '0.0000', '191.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1362, 'CABEZAL DE ALTA PRESION MODELO LU30G1', '', '', '', 13, 13, 'UND', 'G', '271.0000', '0.0000', '0.0000', '271.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1363, 'GEN GAS DE 5.05 5KW MOD MB6500-04M', '', '', '', 9, 9, 'UND', 'G', '2164.0000', '0.0000', '0.0000', '2164.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1364, 'MOLINO ELECTRICO DE 2HP MONOFASICO F150 MARCA', '', '', '', 11, 11, 'UND', 'G', '756.0000', '0.0000', '0.0000', '756.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1365, 'UNION HEMBRA 1/4', '', '', '', 11, 11, 'UND', 'G', '4.6000', '0.0000', '0.0000', '4.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1366, 'CABEZAL ASPIRACION 420', '', '', '', 11, 11, 'UND', 'G', '17.0000', '0.0000', '0.0000', '17.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1367, 'MOTOR ESTACIONARIO HONDA', '', '', '', 8, 8, 'UND', 'G', '1230.0000', '0.0000', '0.0000', '1230.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1368, 'MOCHILA DE FUMIGAR 4 TIEMPOS MODELO 900A', '', '', '', 1, 1, 'UND', 'G', '600.0000', '0.0000', '0.0000', '600.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1369, 'MANGUERA DE SUCCION 2', '', '', '', 11, 11, 'UND', 'G', '26.5000', '0.0000', '0.0000', '26.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1370, 'BOMBA DE COMBUSTIBLE 4238-350-6201', '', '', '', 11, 11, 'UND', 'G', '40.0000', '0.0000', '0.0000', '40.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1371, 'REPUESTO PARA CABEZAL FUMIGADOR', '', '', '', 11, 11, 'UND', 'G', '29.5000', '0.0000', '0.0000', '29.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1372, 'SILICONA AUTOMOTRIS', '', '', '', 11, 11, 'UND', 'G', '20.5000', '0.0000', '0.0000', '20.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1373, 'CARBURADOR 4244/11 SR440', '', '', '', 11, 11, 'UND', 'G', '310.0000', '0.0000', '0.0000', '310.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1374, 'JUEGOS DE PROTECCIÓN PARA LA CABEZA FUNCTION BASIC', '', '', '', 11, 11, 'UND', 'G', '170.0000', '0.0000', '0.0000', '170.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1375, 'CABLE BOWDEN SR420', '', '', '4203-180-1111', 11, 11, 'UND', 'G', '105.0000', '0.0000', '0.0000', '105.0000', 0, 0, NULL, 1, NULL, NULL, NULL);
INSERT INTO `articulo` (`codigo_art`, `nombre_art`, `abreviatura_art`, `codigobarra_art`, `codigoproveedor_art`, `codigo_mar`, `codigo_lin`, `unidadm_art`, `tipoimpuesto_art`, `precio_art`, `costo_art`, `costogasto_art`, `preciomayorista_art`, `stockmin_art`, `stockmax_art`, `descontinuado_art`, `estado_art`, `usuario_reg`, `usuario_mod`, `fecha_mod`) VALUES
(1376, 'RODAMIENTO 6202L', '', '', '', 11, 11, 'UND', 'G', '14.5000', '0.0000', '0.0000', '14.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1377, 'TUERCA HEX', '', '', '', 11, 11, 'UND', 'G', '0.0600', '0.0000', '0.0000', '0.0600', 0, 0, NULL, 1, NULL, NULL, NULL),
(1378, 'ABRAZADERA 01', '', '', '', 11, 11, 'UND', 'G', '1.0000', '0.0000', '0.0000', '1.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1379, 'PISTOLA M 94 MARCA SIRFRAN', '', '', '', 11, 11, 'UND', 'G', '120.0000', '0.0000', '0.0000', '120.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1380, 'LANZA TURBO M 2011 SIN RACORD GIRATORIO', '', '', '', 11, 11, 'UND', 'G', '300.0000', '0.0000', '0.0000', '300.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1381, 'CORTADORA DE CESPED,M:ASHMAR, MOD:AS 5800R', '', '', '', 3, 3, 'UND', 'G', '660.0000', '0.0000', '0.0000', '660.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1382, 'CORTADORA DE CESPED ASHMAR MOD: AS 5700R', '', '', '', 3, 3, 'UND', 'G', '636.0000', '0.0000', '0.0000', '636.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1383, 'MOCHILA DE FUMIGAR DE 4TIEMPOS', '', '', '', 1, 1, 'UND', 'G', '600.0000', '0.0000', '0.0000', '600.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1384, 'GUIA DE CADENA STIHL DUROMATIC DE 36 PULG', '', '', '', 11, 11, 'UND', 'G', '510.0000', '0.0000', '0.0000', '510.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1385, 'CADENA STHIL OLEOMATIC 24 PULG', '', '', '', 11, 11, 'UND', 'G', '163.0000', '0.0000', '0.0000', '163.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1386, 'REPUESTO PARA FUMIGADORA MANUAL JETAGRO', '', '', '', 11, 11, 'UND', 'G', '10.0000', '0.0000', '0.0000', '10.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1387, 'REPUESTO PARA PULVERIZADOR CAMPNA CHICA', '', '', '', 11, 11, 'UND', 'G', '10.0000', '0.0000', '0.0000', '10.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1388, 'REPUESTO MIST DUSTER BOBINA', '', '', '', 11, 11, 'UND', 'G', '42.0000', '0.0000', '0.0000', '42.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1389, 'REPUESTO MIST DUSTER MINI TANQUE GASOLINA X 15 CM', '', '', '', 11, 11, 'UND', 'G', '34.0000', '0.0000', '0.0000', '34.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1390, 'REPUESTO MIST DUSTER CORREA', '', '', '', 11, 11, 'UND', 'G', '27.0000', '0.0000', '0.0000', '27.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1391, 'REPUESTO MIST DUSTER CILINDRO DE METAL X 20 CM', '', '', '', 11, 11, 'UND', 'G', '102.0000', '0.0000', '0.0000', '102.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1392, 'REPUESTO MIST DUSTER JALADOR CHICO', '', '', '', 11, 11, 'UND', 'G', '36.0000', '0.0000', '0.0000', '36.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1393, 'REPUESTO MIST DUSTER VALVULA AGUA', '', '', '', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '15.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1394, 'REPUESTO MIST DUSTER KIT BOQUILLAS ACCESORIOS', '', '', '', 11, 11, 'UND', 'G', '21.0000', '0.0000', '0.0000', '21.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1395, 'REPUESTO FUMIGADOR CABLE ACELERADOR', '', '', '', 11, 11, 'UND', 'G', '17.0000', '0.0000', '0.0000', '17.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1396, 'REPUESTO FUMIGADOR CORREA', '', '', '', 11, 11, 'UND', 'G', '17.0000', '0.0000', '0.0000', '17.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1397, 'REPUESTO MIST DUSTER M JETAGRO', '', '', '', 11, 11, 'UND', 'G', '42.0000', '0.0000', '0.0000', '42.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1398, 'ACCESORIO', '', '', '', 11, 11, 'UND', 'G', '20.0000', '0.0000', '0.0000', '20.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1399, 'MOTOBOMBA DE 2X2 CON MOTOR RATO 6.5 HP', '', '', '', 19, 19, 'UND', 'G', '800.0000', '0.0000', '0.0000', '800.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1400, 'MOTOBOMBA DE 3X3 COMO MOTOR RATO DE 6.5 HP', '', '', '', 19, 19, 'UND', 'G', '900.0000', '0.0000', '0.0000', '900.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1401, 'HT 105 PODADORA DE ALTURA 30CM/12 71PM3', '', '', '', 14, 14, 'UND', 'G', '2310.0000', '0.0000', '0.0000', '2310.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1402, 'SIERRA CIRCULAR 225-48', '', '', '', 11, 11, 'UND', 'G', '168.0000', '0.0000', '0.0000', '168.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1403, 'CIGUEÑAL 4134-030-0406', '', '', '', 11, 11, 'UND', 'G', '325.0000', '0.0000', '0.0000', '325.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1404, 'RETEN12X12X25 STIHL 9640-003-1195', '', '', '', 11, 11, 'UND', 'G', '25.0000', '0.0000', '0.0000', '25.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1405, 'MOTOFUMIGADORA VARILLERA DE 2T LU900-M', '', '', '', 1, 1, 'UND', 'G', '390.0000', '0.0000', '0.0000', '390.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1406, 'AHOYADORA DE 2 TIEMPOS CMODELO MKT2T', '', '', '', 37, 37, 'UND', 'G', '520.0000', '0.0000', '0.0000', '520.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1407, 'AHOYADORA DE 2 TIEMPOS CMODELO MKT2T MARCA', '', '', '', 37, 37, 'UND', 'G', '555.0000', '0.0000', '0.0000', '555.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1408, 'GUADAÑA MULTIUSO DE 2 TIEMPOS MODELO MK-MK520', '', '', '', 3, 3, 'UND', 'G', '1000.0000', '0.0000', '0.0000', '1000.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1409, 'JUEGO DE ARANDELAS Y CONTRATAVAS', '', '', '', 11, 11, 'UND', 'G', '7.0000', '0.0000', '0.0000', '7.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1410, 'CARBURADOR COMPLETO PES726', '', '', '', 11, 11, 'UND', 'G', '370.0000', '0.0000', '0.0000', '370.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1411, 'ARRANCADOR TU26 1', '', '', '', 11, 11, 'UND', 'G', '22.0000', '0.0000', '0.0000', '22.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1412, 'VALVULA B16', '', '', '', 11, 11, 'UND', 'G', '8.0000', '0.0000', '0.0000', '8.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1413, 'PISTOLA ROCEADORA', '', '', '', 11, 11, 'UND', 'G', '27.0000', '0.0000', '0.0000', '27.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1414, 'CORREAS ACOLCHADAS FST', '', '', '', 11, 11, 'UND', 'G', '22.0000', '0.0000', '0.0000', '22.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1415, 'LLAVE DE PASO 1/4 8.5 MM', '', '', '', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '15.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1416, 'MANG PVC SUCC AGUA TRANS NARANJA 2 \"', '', '', '', 12, 12, 'UND', 'G', '868.0000', '0.0000', '0.0000', '868.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1417, 'MANG PVC SUCC AGUA TRANS NARANJA 3\"', '', '', '', 12, 12, 'UND', 'G', '1554.0000', '0.0000', '0.0000', '1554.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1418, 'ABRAZADERA INDUSTRIAL', '', '', '', 11, 11, 'UND', 'G', '9.5000', '0.0000', '0.0000', '9.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1419, 'MOTOR ESTACIONARIO GX35 TIP SD ST', '', '', '', 8, 8, 'UND', 'G', '936.0000', '0.0000', '0.0000', '936.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1420, 'MOTOBOMBA 1 1/2 AUTOSEBANTE', '', '', '', 19, 19, 'UND', 'G', '600.0000', '0.0000', '0.0000', '600.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1421, 'BOMBA DE CAUDAL 4X4 C100 JOPCO', '', '', '', 13, 13, 'UND', 'G', '850.0000', '0.0000', '0.0000', '850.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1422, 'MOTOR DIESEL DE 10 HP 418CC ARRANQUE ELECTRICO', '', '', '', 8, 8, 'UND', 'G', '1680.0000', '0.0000', '0.0000', '1680.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1423, 'PASTILLA CERAMICA DEL', '', '', '', 11, 11, 'UND', 'G', '46.0000', '0.0000', '0.0000', '46.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1424, 'PASTILLA POST', '', '', '', 11, 11, 'UND', 'G', '42.0000', '0.0000', '0.0000', '42.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1425, 'MOTOSIERRA STIHL MS 250 CON GUIA DE CADENA', '', '', '', 4, 4, 'UND', 'G', '1050.0000', '0.0000', '0.0000', '1050.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1426, 'MOCHILA ROCIADOR DE 4 TIEMPOS MKP-35', '', '', '', 1, 1, 'UND', 'G', '600.0000', '0.0000', '0.0000', '600.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1427, 'MOTOFUMIGADORA VARILLERA DE 4 TIEMPOS M LU 900A M', '', '', '', 1, 1, 'UND', 'G', '480.0000', '0.0000', '0.0000', '480.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1428, 'MOT AUT DE 3X3 CON MOTOR MODELO MB-30 M', '', '', '', 19, 19, 'UND', 'G', '484.0000', '0.0000', '0.0000', '484.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1429, 'ACEITE X 100ML 50 1 SHINDAIWA 100ML', '', '', '', 10, 10, 'UND', 'G', '0.0000', '0.0000', '0.0000', '0.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1430, 'MOCHILA FUMIGADORA WJR4025 TIPO GCM ST A', '', '', '', 1, 1, 'UND', 'G', '2200.0000', '0.0000', '0.0000', '1980.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1431, 'CAJA20 BLINDAX HD 50 DOYPACK DE 1L', '', '', '', 10, 10, 'UND', 'G', '208.0000', '0.0000', '0.0000', '208.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1432, 'CAJA BLINDAX SUPER 10W30 API 1/4', '', '', '', 10, 10, 'UND', 'G', '208.0000', '0.0000', '0.0000', '208.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1433, 'NYLON 0.27 ROJO', '', '', '', 11, 11, 'UND', 'G', '1015.0000', '0.0000', '0.0000', '1015.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1434, 'CARBURADOR 4244/11', '', '', '4244-120-0611', 11, 11, 'UND', 'G', '296.0000', '0.0000', '0.0000', '296.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1435, 'FS 120 MOTODESMALEZADORA DM250-3 AUTOCUT 25-2', '', '', '', 3, 3, 'UND', 'G', '1250.0000', '0.0000', '0.0000', '1250.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1436, 'PANTALLA PROTECTORA PARA LA CARA FUCTION', '', '', '0000-884-0251', 11, 11, 'UND', 'G', '116.0000', '0.0000', '0.0000', '116.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1437, 'APARATO ABRE REMACHES NG4', '', '', '5805-012-7500', 11, 11, 'UND', 'G', '1162.0000', '0.0000', '0.0000', '1162.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1438, 'APARATO REMACHADOR NG5', '', '', '5805-012-7510', 11, 11, 'UND', 'G', '1167.0000', '0.0000', '0.0000', '1167.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1439, 'CABEZAL DE ASPIRACION 1', '', '', '0000-350-3502', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '15.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1440, 'LANZA MANOPLA 40 BAR 60 CM', '', '', '', 11, 11, 'UND', 'G', '150.0000', '0.0000', '0.0000', '150.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1441, 'REPUESTO PARA FUMIGAR A MOTO JET AGRO', '', '', '', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '15.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1442, 'REPUESTO PARA MIT DUSSER PLAQUITA METAL', '', '', '', 11, 11, 'UND', 'G', '19.0000', '0.0000', '0.0000', '19.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1443, 'ATOMIZADOR SOLO 423 EVO 14 LTS', '', '', '', 1, 1, 'UND', 'G', '2305.0000', '0.0000', '0.0000', '2300.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1444, 'ATOMIZADORA SOLO 423 EVO MAX 18 LTS', '', '', '', 10, 10, 'UND', 'G', '2305.0000', '0.0000', '0.0000', '2300.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1445, 'RODAMIENTO RIGIDO S 1HIL DE BOLAS 15X35X11', '', '', '', 11, 11, 'UND', 'G', '14.0000', '0.0000', '0.0000', '14.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1446, 'SILICONA GRISS FORMADOR DE EMPAQUETADURA', '', '', '', 11, 11, 'UND', 'G', '5.0000', '0.0000', '0.0000', '5.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1447, 'VALVULA DE EMSANBLE DE ACERO INOXIDABLE 22MM', '', '', '', 11, 11, 'UND', 'G', '2.0000', '0.0000', '0.0000', '2.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1448, 'ARRANCADOR PARA MOTOR GX35', '', '', '', 11, 11, 'UND', 'G', '14.0000', '0.0000', '0.0000', '14.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1449, 'BOMBA HIDROLAVADORA CON MOTOR CABEZAL 26', '', '', '', 11, 11, 'UND', 'G', '600.0000', '0.0000', '0.0000', '600.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1450, 'BOMBA HIDROLAVADORA CON MOTOR CABEZAL 30A CON CARRETA', '', '', '', 5, 5, 'UND', 'G', '1070.0000', '0.0000', '0.0000', '1070.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1451, 'BOMBA HIDROLAVADORA CON MOTOR CABEZAL 30A', '', '', '', 5, 5, 'UND', 'G', '822.0000', '0.0000', '0.0000', '822.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1452, 'TANQUE FUMIGADOR 160LTS CON RUEDAS Y CARRETA  MANGUERA', '', '', '', 5, 5, 'UND', 'G', '1392.0000', '0.0000', '0.0000', '1392.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1453, 'MOCHILA FUMIGADORA 30LTS DE 4 TIEMPOS 139H', '', '', '', 1, 1, 'UND', 'G', '535.0000', '0.0000', '0.0000', '535.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1454, 'CILINDRO + PISTON SOLO423', '', '', '', 11, 11, 'UND', 'G', '600.0000', '0.0000', '0.0000', '600.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1455, 'MANIJA DE PLASTICO', '', '', '', 11, 11, 'UND', 'G', '6.0000', '0.0000', '0.0000', '6.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1456, 'SET MANGUERA LANZA', '', '', '', 11, 11, 'UND', 'G', '5.0000', '0.0000', '0.0000', '5.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1457, 'REPUESTO PARA MIST DUSTER BOBINA', '', '', '', 11, 11, 'UND', 'G', '42.0000', '0.0000', '0.0000', '42.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1458, 'REPUESTO PARA PULVERIZADOR CAMPANA CHICA', '', '', '', 11, 11, 'UND', 'G', '8.4000', '0.0000', '0.0000', '8.4000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1459, 'REPUESTO PARA FUMIGADORA MANUAL CORREA1', '', '', '', 11, 11, 'UND', 'G', '9.6000', '0.0000', '0.0000', '9.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1460, 'REPUESTO PARA MIST DUSTER DIAGRAGMA DE CARBURADOR 4 CM', '', '', '', 11, 11, 'UND', 'G', '54.0000', '0.0000', '0.0000', '54.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1461, 'REPUESTO PARA FUMIGADORA A MOTOR ENPAQUE DE PLASTICO', '', '', '', 11, 11, 'UND', 'G', '21.0000', '0.0000', '0.0000', '21.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1462, 'REPUESTO PARA MIST DUSTER MINI TANQUE DE GASOLINA', '', '', '', 11, 11, 'UND', 'G', '33.6000', '0.0000', '0.0000', '33.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1463, 'MANGUERA PARA HIDROLAVADORA DE 100 MTS MOD MB02C', '', '', '', 11, 11, 'UND', 'G', '47.0000', '0.0000', '0.0000', '47.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1464, 'AHOYADORA DE 2 TIEMPOS MODELO MKA2T MARCA MOTORKRAFT CON BROCA', '', '', '', 11, 11, 'UND', 'G', '528.0000', '0.0000', '0.0000', '528.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1465, 'MANIJA PLASTICOM', '', '', '', 11, 11, 'UND', 'G', '5.1500', '0.0000', '0.0000', '5.1500', 0, 0, NULL, 1, NULL, NULL, NULL),
(1466, 'REPUESTO LANZA TIGUE', '', '', '', 11, 11, 'UND', 'G', '5.4000', '0.0000', '0.0000', '5.4000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1467, 'SET DE MANGUERA Y LANZA DE PLASTICO', '', '', '', 11, 11, 'UND', 'G', '5.2000', '0.0000', '0.0000', '5.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1468, 'CODO PLASTICO', '', '', '', 11, 11, 'UND', 'G', '2.2000', '0.0000', '0.0000', '2.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1469, 'MANGUERA DE DESCARJA 4 PULGADAS', '', '', '', 12, 12, 'UND', 'G', '7.0000', '0.0000', '0.0000', '7.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1470, 'MANGUERA DE SUCCION DE 4 PULGADAS', '', '', '', 11, 11, 'UND', 'G', '38.0000', '0.0000', '0.0000', '38.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1471, 'ABRAZADERA DE 4 PULGADAS', '', '', '', 11, 11, 'UND', 'G', '14.0000', '0.0000', '0.0000', '14.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1472, 'MANGUERA DE DESCARGA DE 3 PULGADAS', '', '', '', 12, 12, 'UND', 'G', '5.0000', '0.0000', '0.0000', '5.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1473, 'LANZA DE FUMIGACION P56 90 CM WHALE', '', '', '', 11, 11, 'UND', 'G', '80.0000', '0.0000', '0.0000', '80.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1474, 'MOT AUT DE 3X3 CON MOTOR MOD MB-30A M', '', '', '', 19, 19, 'UND', 'G', '700.0000', '0.0000', '0.0000', '700.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1475, 'ABRAZADERA INDUSTRIAL 3P', '', '', '', 11, 11, 'UND', 'G', '14.0000', '0.0000', '0.0000', '14.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1476, 'MOTOB AUTOC 3X3 7 HP QMAX', '', '', '', 19, 19, 'UND', 'G', '768.0000', '0.0000', '0.0000', '738.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1477, 'MOTOBOMBA AUTOC 3X3 7 HP H170F', '', '', '', 19, 19, 'UND', 'G', '692.0000', '0.0000', '0.0000', '692.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1478, 'TANQUE GASOLINA 1 GAL', '', '', '', 11, 11, 'UND', 'G', '30.0000', '0.0000', '0.0000', '30.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1479, 'REPUESTOS SOLO ULV', '', '', '', 17, 17, 'UND', 'G', '450.0000', '0.0000', '0.0000', '450.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1480, 'CADENA 3/8 820 DIENTES P ESP MS 250 3636-000-1640', '', '', '', 11, 11, 'UND', 'G', '2.4000', '0.0000', '0.0000', '2.4000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1481, 'ESPADA R 30CM/12 1.1', '', '', '', 11, 11, 'UND', 'G', '165.0000', '0.0000', '0.0000', '165.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1482, 'MANGUERA DE SUCCION DE 3 PULGADAS', '', '', '', 11, 11, 'MTS', 'G', '28.0000', '0.0000', '0.0000', '28.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1483, 'MANGUERA DE DESCARGA 3 P', '', '', '', 11, 11, 'MTS', 'G', '6.0000', '0.0000', '0.0000', '6.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1484, 'FILTRO ADICIONAL STHIL', '', '', '', 11, 11, 'UND', 'G', '14.5000', '0.0000', '0.0000', '14.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1485, 'CARBURADOR FS280 4119-120-0602', '', '', '', 11, 11, 'UND', 'G', '220.0000', '0.0000', '0.0000', '220.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1486, 'PASADOR TENSOR 660 1125-640-1900', '', '', '', 11, 11, 'UND', 'G', '30.0000', '0.0000', '0.0000', '30.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1487, 'JUEGO ENGRANAJE TORNILLO TENSOR 1125-007-1021', '', '', '', 11, 11, 'UND', 'G', '60.0000', '0.0000', '0.0000', '60.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1488, 'FILTRO DE AIRE HD2', '', '', '', 11, 11, 'UND', 'G', '84.0000', '0.0000', '0.0000', '84.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1489, 'ESPADA DUROMATIC 75 CM', '', '', '', 11, 11, 'UND', 'G', '396.0000', '0.0000', '0.0000', '396.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1490, 'AHOYADORA DE 2 TIEMPOS', '', '', '', 39, 39, 'UND', 'G', '480.0000', '0.0000', '0.0000', '480.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1491, 'GUADAÑA MULTIFUNCIONAL', '', '', '', 3, 3, 'UND', 'G', '1050.0000', '0.0000', '0.0000', '1050.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1492, 'MOTOSIERRA CON ESPADA DE 20 P JS 250', '', '', '', 4, 4, 'UND', 'G', '510.0000', '0.0000', '0.0000', '510.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1493, 'GENERADOR HONDA E3000', '', '', '', 9, 9, 'UND', 'G', '2260.0000', '0.0000', '0.0000', '2260.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1494, 'BOMBA DE AGUA PERIFERICA LECCO', '', '', '', 40, 40, 'UND', 'G', '138.0000', '0.0000', '0.0000', '138.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1495, 'PISTOLA ALTA PRESION EUROPEO', '', '', '', 11, 11, 'UND', 'G', '120.0000', '0.0000', '0.0000', '120.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1496, 'ACELERADOR COMPLETO', '', '', '', 11, 11, 'UND', 'G', '10.0000', '0.0000', '0.0000', '10.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1497, 'VALVULA WHALE', '', '', '', 11, 11, 'UND', 'G', '22.0000', '0.0000', '0.0000', '22.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1498, 'KIT RETENES 30 WHALE', '', '', '', 11, 11, 'UND', 'G', '74.0000', '0.0000', '0.0000', '74.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1499, 'PULVERIZADOR DORSAL SIMETRICO 10 LTS', '', '', '', 2, 2, 'UND', 'G', '260.0000', '0.0000', '0.0000', '260.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1500, 'MULTIPLAGAS', '', '', '', 11, 11, 'UND', 'G', '58.0000', '0.0000', '0.0000', '58.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1501, 'MULTIPLAGAS X0250', '', '', '', 11, 11, 'UND', 'G', '4.0000', '0.0000', '0.0000', '4.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1502, 'CARBURADOR 413422 4134-120-0622 FS250', '', '', '', 11, 11, 'UND', 'G', '250.0000', '0.0000', '0.0000', '250.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1503, 'CABLE BOWDEN 4128-180-1122', '', '', '', 11, 11, 'UND', 'G', '120.0000', '0.0000', '0.0000', '120.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1504, 'CARBURADOR C1Q SS1D 4134-120-0651', '', '', '', 11, 11, 'UND', 'G', '250.0000', '0.0000', '0.0000', '250.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1505, 'CABEZAL DE CORTE AUTOCUT 36-2', '', '', '4002-710-2170', 11, 11, 'UND', 'G', '120.0000', '0.0000', '0.0000', '120.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1506, 'VLK-QB-60N BOMBA PERIFERICA 0.5 HP', '', '', '', 11, 11, 'UND', 'G', '150.0000', '0.0000', '0.0000', '150.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1507, 'SUNCHO RETRACTIL', '', '', '', 11, 11, 'UND', 'G', '5.0000', '0.0000', '0.0000', '5.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1508, 'ELEMENTO DE AIRE GX160', '', '', '', 11, 11, 'UND', 'G', '11.0000', '0.0000', '0.0000', '11.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1509, 'INTERRUPTOR ON OF', '', '', '', 11, 11, 'UND', 'G', '3.6000', '0.0000', '0.0000', '3.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1510, 'CHUPON DE BUJIA ESTAC', '', '', '', 11, 11, 'UND', 'G', '4.2000', '0.0000', '0.0000', '4.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1511, 'EMBRAGUE NTC', '', '', '', 11, 11, 'UND', 'G', '9.6000', '0.0000', '0.0000', '9.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1512, 'MOTOBOMBA GASOL 1*1 NEGRO', '', '', '', 19, 19, 'UND', 'G', '380.0000', '0.0000', '0.0000', '380.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1513, 'MANGUERA DE ALTA PRESION AZUL', '', '', '', 12, 12, 'UND', 'G', '280.0000', '0.0000', '0.0000', '280.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1514, 'LANZA CAPUCHA GIRATORIA 90CM', '', '', '', 11, 11, 'UND', 'G', '25.0000', '0.0000', '0.0000', '25.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1515, 'PISTOLA FY 36', '', '', '', 11, 11, 'UND', 'G', '20.0000', '0.0000', '0.0000', '20.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1516, 'LANZA FY2', '', '', '', 11, 11, 'UND', 'G', '17.0000', '0.0000', '0.0000', '17.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1517, 'LANZA FY5', '', '', '', 11, 11, 'UND', 'G', '18.0000', '0.0000', '0.0000', '18.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1518, 'CUCHILLA BELLOTA GRANDE', '', '', '', 11, 11, 'UND', 'G', '18.0000', '0.0000', '0.0000', '18.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1519, 'BUJIA 2300106', '', '', '', 11, 11, 'UND', 'G', '15.0000', '0.0000', '0.0000', '15.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1520, 'ABRZAZADERA 5/8', '', '', '', 11, 11, 'UND', 'G', '0.2700', '0.0000', '0.0000', '0.2700', 0, 0, NULL, 1, NULL, NULL, NULL),
(1521, 'JUEGO DE ARANDELAS Y TRABAS DE FIJACIÓN', '', '', '', 11, 11, 'UND', 'G', '7.0000', '0.0000', '0.0000', '7.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1522, 'BOQUILLA REGULABLE N. 3- AZUL', '', '', '', 11, 11, 'UND', 'G', '7.0000', '0.0000', '0.0000', '7.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1523, 'KIT EMBOLO PLASTICO PJH-9000', '', '', '', 11, 11, 'UND', 'G', '7.0000', '0.0000', '0.0000', '7.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1524, 'REGISTRO COMPLETO', '', '', '', 11, 11, 'UND', 'G', '25.0000', '0.0000', '0.0000', '25.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1525, 'AGUJA DE LATON DEL REGISTRO', '', '', '', 11, 11, 'UND', 'G', '8.0000', '0.0000', '0.0000', '8.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1526, 'BOQUILLA KEMATAL SERIE-80- JEF-02 AMARILLA', '', '', '', 11, 11, 'UND', 'G', '8.5000', '0.0000', '0.0000', '8.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1527, 'CILINDRO COMPLETO', '', '', '', 11, 11, 'UND', 'G', '46.0000', '0.0000', '0.0000', '46.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1528, 'BOQUILLA CONICA JA-1-AZUL', '', '', '', 11, 11, 'UND', 'G', '14.0000', '0.0000', '0.0000', '14.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1529, 'EMPAQUETADURA /PRENSA-ESTOPA 7 X 50.6', '', '', '', 11, 11, 'UND', 'G', '3.0000', '0.0000', '0.0000', '3.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1530, 'TAPA CON DIAFRAGMA', '', '', '', 11, 11, 'UND', 'G', '17.0000', '0.0000', '0.0000', '17.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1531, 'BOQUILLA JSF 110-015 VERDE', '', '', '', 11, 11, 'UND', 'G', '13.0000', '0.0000', '0.0000', '13.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1532, 'PULV. AGRIC. MANUAL JACTO PICON PERU PJH X 20 LTS', '', '', '', 2, 2, 'UND', 'G', '0.0000', '0.0000', '0.0000', '0.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1533, 'PULV. AGRICOLA MOTORIZADA JACTO PJM-25/ COMP.', '', '', '', 1, 1, 'UND', 'G', '2000.0000', '0.0000', '0.0000', '2000.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1534, 'MOTOFUMIGADORA VARILLERA DE 2T MOD LU-900 M', '', '', '', 1, 1, 'UND', 'G', '350.0000', '0.0000', '0.0000', '350.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1535, 'MOTOSIERRA 18\" NT4560 CRAFTOP:', '', '', '', 4, 4, 'UND', 'G', '765.0000', '0.0000', '0.0000', '765.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1536, 'MOTOSIERRA 12\" NT2500 CRAFTOP:', '', '', '', 4, 4, 'UND', 'G', '671.0000', '0.0000', '0.0000', '671.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1537, 'MOTOSIERRA 16\" NT3760 CRAFTOP', '', '', '', 4, 4, 'UND', 'G', '670.0000', '0.0000', '0.0000', '670.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1538, 'MOTOSIERRA 20\" NT5260 CRAFTOP:', '', '', '', 4, 4, 'UND', 'G', '782.0000', '0.0000', '0.0000', '782.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1539, 'MOTOSIERRA 22\" NT5860 CRAFTOP', '', '', '', 4, 4, 'UND', 'G', '930.0000', '0.0000', '0.0000', '930.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1540, 'MOTOSIERRA 24\" NT6260 CRAFTOP:', '', '', '', 4, 4, 'UND', 'G', '930.0000', '0.0000', '0.0000', '930.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1541, 'MOTOPULVERIZADOR AMC 900A', '', '', '', 1, 1, 'UND', 'G', '533.0000', '0.0000', '0.0000', '533.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1542, 'CODO COMPLETO NEGRO', '', '', '', 11, 11, 'UND', 'G', '87.0000', '0.0000', '0.0000', '87.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1543, 'MANGUERA PARA HIDR. DE 50 M MOD. LU-02N M. MAESBARR', '', '', '', 12, 12, 'UND', 'G', '73.0000', '0.0000', '0.0000', '73.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1544, 'MANGUERA PARA HIDR. DE 30 M. MOD. LU-02P MARCA MAESBARR', '', '', '', 12, 12, 'UND', 'G', '49.0000', '0.0000', '0.0000', '49.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1545, 'MOTOFUMIGADORA CON TUBO MODELO TM-30A S/M', '', '', '', 1, 1, 'UND', 'G', '576.0000', '0.0000', '0.0000', '576.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1546, 'MOT. AUT. DE 3X3 CON MOTOR MODELO WB-30 M. HONDA', '', '', '', 19, 19, 'UND', 'G', '1128.0000', '0.0000', '0.0000', '1128.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1547, 'MOTOR GASOLINERO COLOR NEGRO MOD. MB-420A M. MAESBARR', '', '', '', 8, 8, 'UND', 'G', '839.0000', '0.0000', '0.0000', '839.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1548, 'CABEZAL DE ALTA PRESION CERAMICO MODELO LU-340C M. MAESBARR', '', '', '', 13, 13, 'UND', 'G', '600.0000', '0.0000', '0.0000', '600.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1549, 'CABEZAL DE ALTA PRESION MODELO LU-80 MARCA MAESBARR', '', '', '', 13, 13, 'UND', 'G', '462.0000', '0.0000', '0.0000', '462.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1550, 'CABEZAL DE ALTA PRESION MODELO LU-120A MARCA MAESBARR', '', '', '', 13, 13, 'UND', 'G', '564.0000', '0.0000', '0.0000', '564.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1551, 'AHOYADORA DE 4 TIEMPOS MODELO MKA-4T', '', '', '', 39, 39, 'UND', 'G', '540.0000', '0.0000', '0.0000', '540.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1552, 'MOTOGUADAÑA MODELO MK25 MARCA MOTORKRAFT DE 4T', '', '', '', 3, 3, 'UND', 'G', '455.0000', '0.0000', '0.0000', '455.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1553, 'MOTOGUADAÑA MULTIKIT DE 4 TIEMPOS MODELO MK-MK35MARCA', '', '', '', 3, 3, 'UND', 'G', '780.0000', '0.0000', '0.0000', '780.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1554, 'MOTOSIERRA MODELO MK250 MARCA MOTORKRAFT', '', '', '', 4, 4, 'UND', 'G', '420.0000', '0.0000', '0.0000', '420.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1555, 'MOTOSIERRA CON ESPADA DE 30 PULGADAS', '', '', '', 4, 4, 'UND', 'G', '720.0000', '0.0000', '0.0000', '720.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1556, 'MOTOSIERRA CON ESPADA DE 28 PULGADAS', '', '', '', 4, 4, 'UND', 'G', '744.0000', '0.0000', '0.0000', '744.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1557, 'FUMIGADORA MANUAL DE 20 LITROS MAKIN VERDE', '', '', '', 2, 2, 'UND', 'G', '70.0000', '0.0000', '0.0000', '70.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1558, 'MANIJA PLASTICA', '', '', '', 11, 11, 'UND', 'G', '5.2000', '0.0000', '0.0000', '5.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1559, 'TRINQUETE 1125-195-7200', '', '', '125-195-7200', 11, 11, 'UND', 'G', '4.5000', '0.0000', '0.0000', '4.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1560, 'TRINQUETE 4116-195-7200', '', '', '4116-195-7200', 11, 11, 'UND', 'G', '4.5000', '0.0000', '0.0000', '4.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1561, 'TUBO CIRCU 3/4', '', '', '', 11, 11, 'UND', 'G', '15.5000', '0.0000', '0.0000', '15.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1562, 'DISCO CORTE', '', '', '', 11, 11, 'UND', 'G', '3.5000', '0.0000', '0.0000', '3.5000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1563, 'ACEITE HONDA PF SS 4T 10W30 (CJA=12U) 1L KI', '', '', '', 10, 10, 'UND', 'G', '265.0000', '0.0000', '0.0000', '265.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1564, 'ACEITE SINTENTICO HIGH CUALYTI', '', '', '', 10, 10, 'UND', 'G', '30.0000', '0.0000', '0.0000', '30.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1565, 'VARILLA 304 6 SALIDAS', '', '', '', 11, 11, 'UND', 'G', '71.0000', '0.0000', '0.0000', '71.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1566, 'VARILLA 304 5 SALIDAS', '', '', '', 11, 11, 'UND', 'G', '61.0000', '0.0000', '0.0000', '61.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1567, 'VARILLA 304 4 SALIDAS', '', '', '', 11, 11, 'UND', 'G', '51.0000', '0.0000', '0.0000', '51.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1568, 'VARILLA 304 3 SALIDAS', '', '', '', 11, 11, 'UND', 'G', '41.0000', '0.0000', '0.0000', '41.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1569, 'VARILLA 304 2 SALIDAS', '', '', '', 11, 11, 'UND', 'G', '36.0000', '0.0000', '0.0000', '36.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1570, 'LLAVE DE PASO POWER', '', '', '', 11, 11, 'UND', 'G', '26.0000', '0.0000', '0.0000', '26.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1571, 'LANZA AZUL M2', '', '', '', 11, 11, 'UND', 'G', '36.0000', '0.0000', '0.0000', '36.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1572, 'LANZA M2 DORADO', '', '', '', 11, 11, 'UND', 'G', '36.0000', '0.0000', '0.0000', '36.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1573, 'LANZA E4 90 CM', '', '', '', 11, 11, 'UND', 'G', '31.0000', '0.0000', '0.0000', '31.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1574, 'BOQUILLA E4-2 CAPUCHA ROJA HILO BROMCE', '', '', '', 11, 11, 'UND', 'G', '19.0000', '0.0000', '0.0000', '19.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1575, 'BOQUILLA ROJA 201', '', '', '', 11, 11, 'UND', 'G', '36.0000', '0.0000', '0.0000', '36.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1576, 'BOQUILLA CAPUCHA ROJA CHINA E4-1', '', '', '', 11, 11, 'UND', 'G', '16.0000', '0.0000', '0.0000', '16.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1577, 'DISCOS YOSHIMI 60 T', '', '', '', 11, 11, 'UND', 'G', '31.0000', '0.0000', '0.0000', '31.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1578, 'DISCOS YOSHIMI 40 T', '', '', '', 11, 11, 'UND', 'G', '31.0000', '0.0000', '0.0000', '31.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1579, 'DISCO DE 12 PULGADAS YOSHIMI 40 T', '', '', '', 11, 11, 'UND', 'G', '41.0000', '0.0000', '0.0000', '41.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1580, 'DISCO DE 12 PULGADAS YOSHIMI 60 T', '', '', '', 11, 11, 'UND', 'G', '41.0000', '0.0000', '0.0000', '41.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1581, 'FILTRO DE GASOLINA MODELO WALBRO', '', '', '', 11, 11, 'UND', 'G', '5.0000', '0.0000', '0.0000', '5.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1582, 'CARGADOR DE BATERIA DE LITIO', '', '', '', 11, 11, 'UND', 'G', '20.0000', '0.0000', '0.0000', '20.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1583, 'CARGADOR DE BATERIA ACIDO', '', '', '', 11, 11, 'UND', 'G', '20.0000', '0.0000', '0.0000', '20.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1584, 'PULVERIZADORA YOSHIMI HONDA GX-35 X 25 LITROS', '', '', '', 1, 1, 'UND', 'G', '1400.0000', '0.0000', '0.0000', '1400.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1585, 'PISTOLA ROCIADORA ALTA PRESION', '', '', '', 11, 11, 'UND', 'G', '103.0000', '0.0000', '0.0000', '103.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1586, 'MOTOR PETROLERO JIANGYANG DE 24 HP ARRANQUE ELECTRICO ENFRIA', '', '', '', 8, 8, 'UND', 'G', '3203.0000', '0.0000', '0.0000', '3203.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1587, 'BOMBA DE AGUA YARMAX BOMBA DE 4 PULGADAS NACIONAL CON POLEA', '', '', '', 13, 13, 'UND', 'G', '1110.0000', '0.0000', '0.0000', '1110.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1589, 'CARRETA PARA ARO 13', '', '', '', 11, 11, 'UND', 'G', '1000.0000', '0.0000', '0.0000', '1000.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1590, 'ACEITE PETROLERO', '', '', '', 10, 10, 'UND', 'G', '132.0000', '0.0000', '0.0000', '132.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1591, 'BATERIA 1 PLACAS', '', '', '', 11, 11, 'UND', 'G', '270.0000', '0.0000', '0.0000', '270.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1592, 'CHEK DE 6X6', '', '', '', 11, 11, 'UND', 'G', '90.0000', '0.0000', '0.0000', '90.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1593, 'MANGUERA DE 4 PULGADAS', '', '', '', 11, 11, 'UND', 'G', '48.0000', '0.0000', '0.0000', '48.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1594, 'CORTADORA DE TUBOS', '', '', '', 11, 11, 'UND', 'G', '39.0000', '0.0000', '0.0000', '39.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1595, 'REPUESTO PARA MOCHILA FUMIGADORA MANUAL', '', '', '', 11, 11, 'UND', 'G', '10.5500', '0.0000', '0.0000', '10.5500', 0, 0, NULL, 1, NULL, NULL, NULL),
(1596, 'SET DE MANIJA VARILLA Y MANGUERA', '', '', '', 11, 11, 'UND', 'G', '5.0000', '0.0000', '0.0000', '5.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1597, 'CABEZAL DE ALTA PRESION MODELO MB30G-1', '', '', '', 13, 13, 'UND', 'G', '255.0000', '0.0000', '0.0000', '255.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1598, 'CABEZAL DE ALTA PRESION MODELO MT30', '', '', '', 13, 13, 'UND', 'G', '189.0000', '0.0000', '0.0000', '189.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1599, 'MOTOPULVERIZADOR AMC 800F TU26', '', '', '', 1, 1, 'UND', 'G', '438.0000', '0.0000', '0.0000', '438.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1600, 'MOTOR AMC 140F', '', '', '', 8, 8, 'UND', 'G', '280.0000', '0.0000', '0.0000', '280.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1601, 'FS 55 MOTODESMALEZADORA,AUTOCUT 27-2', '', '', '4140-200-0417', 3, 3, 'UND', 'G', '710.0000', '0.0000', '0.0000', '710.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1602, 'FS 38 MOTODESMALEZADORA', '', '', '4140-011-2377', 3, 3, 'UND', 'G', '550.0000', '0.0000', '0.0000', '550.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1603, 'FS 280 MOTODESMALEZADORA,DM 305-2', '', '', '4119-200-0018', 3, 3, 'UND', 'G', '2148.0000', '0.0000', '0.0000', '2148.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1604, 'PROTECTOR DE APLICACION', '', '', '', 11, 11, 'UND', 'G', '50.2600', '0.0000', '0.0000', '50.2600', 0, 0, NULL, 1, NULL, NULL, NULL),
(1605, 'SOPORTE TANQUE DE LIQUIDOS M1200', '', '', '', 11, 11, 'UND', 'G', '63.0000', '0.0000', '0.0000', '63.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1606, 'EMPAQUETADURA /PRENSA-ESTOPA 7 X 50.6 JACTO', '', '', '', 11, 11, 'UND', 'G', '2.2000', '0.0000', '0.0000', '2.2000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1607, 'PORTA PRENSA ESTOPA 62', '', '', '', 11, 11, 'UND', 'G', '4.4000', '0.0000', '0.0000', '4.4000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1608, 'JUEGO DE ARANDELAS Y CONTRACLAVIJAS', '', '', '', 11, 11, 'UND', 'G', '5.9000', '0.0000', '0.0000', '5.9000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1609, 'PALANCA CON MANIJA', '', '', '', 11, 11, 'UND', 'G', '25.8000', '0.0000', '0.0000', '25.8000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1610, 'CINTA COMPLETA /CORREA COMPLETA', '', '', '', 11, 11, 'UND', 'G', '25.0000', '0.0000', '0.0000', '25.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1611, 'JUEGO DE ARANDELAS Y TRABAS DE FIJACIÓNN', '', '', '', 11, 11, 'UND', 'G', '5.9000', '0.0000', '0.0000', '5.9000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1612, 'BOQUILLA KEMATAL SERIE-80- JEF-02 AMARILLA J', '', '', '', 11, 11, 'UND', 'G', '8.6000', '0.0000', '0.0000', '8.6000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1613, 'MANGUERA PARA HIDR 100MT MB03C M', '', '', '', 12, 12, 'UND', 'G', '180.0000', '0.0000', '0.0000', '180.0000', 0, 0, NULL, 1, NULL, NULL, NULL),
(1614, 'CABEZAL DE ALTA PRESION CERAMICO MB120', '', '', '', 13, 13, 'UND', 'G', '875.0000', '0.0000', '0.0000', '875.0000', 0, 0, NULL, 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `banco`
--

CREATE TABLE `banco` (
  `codigo_ban` int(11) NOT NULL,
  `nombre_ban` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `abreviatura_ban` varchar(20) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `estado_ban` int(11) DEFAULT '1',
  `usuario_reg` int(11) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_mod` int(11) DEFAULT NULL,
  `fecha_mod` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `banco`
--

INSERT INTO `banco` (`codigo_ban`, `nombre_ban`, `abreviatura_ban`, `estado_ban`, `usuario_reg`, `usuario_mod`, `fecha_mod`) VALUES
(1, 'BANCO DE CREDITO DEL PERU', NULL, 1, NULL, NULL, NULL),
(2, 'CAJA', NULL, 1, NULL, NULL, NULL),
(3, 'VISA', NULL, 1, NULL, NULL, NULL),
(4, 'BANCO CONTINENTAL', NULL, 1, NULL, NULL, NULL),
(5, 'CARTERA', NULL, 1, NULL, NULL, NULL),
(7, 'BANCO DE COMERCIO', NULL, 1, NULL, NULL, NULL),
(10, 'BANCO FINANCIERO', NULL, 1, NULL, NULL, NULL),
(11, 'BANCO INTERAMERICANO DE FINANZAS', NULL, 1, NULL, NULL, NULL),
(12, 'BANCO SCOTIABANK', NULL, 1, NULL, NULL, NULL),
(13, 'CITIBANK', NULL, 1, NULL, NULL, NULL),
(14, 'INTERBANK', NULL, 1, NULL, NULL, NULL),
(15, 'MIBANCO', NULL, 1, NULL, NULL, NULL),
(16, 'HSBC BANK', NULL, 1, NULL, NULL, NULL),
(17, 'BANCO FALABELLA', NULL, 1, NULL, NULL, NULL),
(18, 'BANCO RIPLEY', NULL, 1, NULL, NULL, NULL),
(19, 'AZTECA', NULL, 1, NULL, NULL, NULL),
(20, 'CREDISCOTIA', NULL, 1, NULL, NULL, NULL),
(21, 'EDYFICAR', NULL, 1, NULL, NULL, NULL),
(22, 'FINANCIERA CONFIANZA S.A.', NULL, 1, NULL, NULL, NULL),
(23, 'FINANCIERA TFC S.A.', NULL, 1, NULL, NULL, NULL),
(24, 'FINANCIERA CREAR', NULL, 1, NULL, NULL, NULL),
(25, 'SOLUCIÓN FINANCIERA DE CRÉDITO', NULL, 1, NULL, NULL, NULL),
(26, 'CMAC AREQUIPA', NULL, 1, NULL, NULL, NULL),
(27, 'CMAC LIMA', NULL, 1, NULL, NULL, NULL),
(28, 'CMAC CUSCO', NULL, 1, NULL, NULL, NULL),
(29, 'CCMAC DEL SANTA', NULL, 1, NULL, NULL, NULL),
(30, 'CMAC HUANCAYO', NULL, 1, NULL, NULL, NULL),
(31, 'CMAC ICA', NULL, 1, NULL, NULL, NULL),
(32, 'CMAC MAYNAS', NULL, 1, NULL, NULL, NULL),
(33, 'CMAC PAITA', NULL, 1, NULL, NULL, NULL),
(34, 'CMAC PISCO', NULL, 1, NULL, NULL, NULL),
(35, 'CMAC PIURA', NULL, 1, NULL, NULL, NULL),
(36, 'CMAC SULLANA', NULL, 1, NULL, NULL, NULL),
(37, 'CMAC TRUJILLO', NULL, 1, NULL, NULL, NULL),
(38, 'CMAC TACNA', NULL, 1, NULL, NULL, NULL),
(39, 'BANCO DE LA NACION', NULL, 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `codigo_cli` int(11) NOT NULL,
  `nombre_cli` varchar(500) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `direccion_cli` varchar(500) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `ciudad_cli` varchar(500) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `telefono_cli` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `codigo_tip` int(11) DEFAULT NULL,
  `codigo_doc` int(11) DEFAULT NULL,
  `numero_doc` varchar(20) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `codigo_szo` int(11) NOT NULL,
  `email_cli` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `observacion_cli` varchar(1000) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `codigo_dis` int(11) NOT NULL,
  `estadosunat_cli` int(11) DEFAULT '1',
  `condicionsunat_cli` varchar(10) COLLATE utf8_spanish_ci DEFAULT NULL,
  `estado_cli` int(11) DEFAULT '1',
  `usuario_reg` int(11) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_mod` int(11) DEFAULT NULL,
  `fecha_mod` timestamp NULL DEFAULT NULL,
  `sistema` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`codigo_cli`, `nombre_cli`, `direccion_cli`, `ciudad_cli`, `telefono_cli`, `codigo_tip`, `codigo_doc`, `numero_doc`, `codigo_szo`, `email_cli`, `observacion_cli`, `codigo_dis`, `estadosunat_cli`, `condicionsunat_cli`, `estado_cli`, `usuario_reg`, `usuario_mod`, `fecha_mod`, `sistema`) VALUES
(1, 'VARIOS', '', '', '', 1, 1, '0', 1, 'JUAN.SOFT@HOTMAIL.COM', '', 130308, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2, 'COLLANTES SOLIS LEONARDO ANDRE', '', '', '', 1, 2, '10740224757', 1, 'TCNOAGRO@HOTMAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(4, 'HONDA DEL PERU S.A', 'AV. REPUBLICA DE PANAMA NRO. 3545 INT. 501 URB. LIMATAMBO LIMA - LIMA - SAN ISIDRO', '', '', 1, 2, '20103733015', 1, 'MICORREO@MAIL.COM', '', 140124, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(5, 'ONETO VALLE SEBASTIAN NICOLAS', 'CALLE JOSE QUIÑONES 051 PIMENTEL', '', '', 1, 2, '10167988917', 1, 'MICORREO@MAIL.COM', '', 130110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(6, 'FARMEX S A', 'CAL.DEAN VALDIVIA NRO. 148 DPTO. 07 URB. JARDIN LIMA - LIMA - SAN ISIDRO', '', '', 1, 2, '20100141583', 1, 'MICORREO@MAIL.COM', '', 140124, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(7, 'NEGOCIOS ALARCON DIAZ EMPRESA INDIVIDUAL DE RESPONSABILIDAD LIMITADA', '----IV ETAPA MZA. H LOTE. 5A A.H. LA CURVA TUMBES - ZARUMILLA - AGUAS VERDES', '', '', 1, 2, '20601343691', 1, 'MICORREO@MAIL.COM', '', 230304, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(8, 'AGROEXPORTADORA SOL DE OLMOS S.A.C.', 'AV. MALECON DE LA RESERVA NRO 275 INT. 203 DEP. 601', '', '', 1, 2, '20556450600', 1, 'MVILCHEZT@HOTMAIL.COM', '', 140115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(9, 'RMC SEED PRODUCERS S.A.C.', 'CAL.SAN PABLO NRO. 145 P.J. CRUZ DE CHALPON LAMBAYEQUE - LAMBAYEQUE - OLMOS', '', '', 1, 2, '20557314386', 1, 'MICORREO@MAIL.COM', '', 130308, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(10, 'KORILIZ S. A.', 'JR. LOS FORESTALES NRO. 444 URB. LAS ACACIAS (ALT CDRA 5 AV CONSTRUCTORES) LIMA - LIMA - LA MOLINA', '', '', 1, 2, '20130517987', 1, 'TCNOAGRO.COM.PE', '', 140110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(11, 'PLANTACIONES DEL SOL S.A.C', 'CAL.TORRES PAZ NRO. 683 INT. 401 (CERCA A LA AVENIDA BALTA) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20550858461', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(12, 'UNIVERSIDAD ALAS PERUANAS S.A.', 'AV. SAN FELIPE NRO. 1109 LIMA - LIMA - JESUS MARIA', '', '', 1, 2, '20303063766', 1, 'J_BAZAN_U@UAP.EDU.PE', '', 140133, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(13, 'AGRICOLA LA FLORIDA SAC', 'AV. MIGUEL ANGEL NRO 183 URB. FIORI', '', '', 1, 2, '20480141785', 1, 'MICORREO@MAIL.COM', '', 140126, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(14, 'CORPORACION AGRICOLA FRUTOS DEL NORTE SOCIEDAD ANONIMA CERRADA', '----CARRETERA HUANCABAMBA KM. 8.75 (PORTON COLOR VERDE-PLANTACION DE BANANOS) PIURA - MORROPON - LA MATANZA', '', '', 1, 2, '20525537413', 1, 'MICORREO@MAIL.COM', '', 190408, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(15, 'NEBULOSA E.I.R.L.', 'CAL.NEW YORK NRO. 197 INT. C P.J. ZAMORA LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20601996040', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(16, 'CONSTRUCCION Y ADMINISTRACION S.A.', 'AV. JAVIER PRADO ESTE NRO. 4109 URB. SANTA CONSTANZA LIMA - LIMA - SANTIAGO DE SURCO', '', '', 1, 2, '20109565017', 1, 'MICORREO@MAIL.COM', '', 140130, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(17, 'AGRICOLA CAMPO NOBLE SOCIEDAD ANONIMA CERRADA', 'AV. SANTA CRUZ NRO 888', '', '', 1, 2, '20600720679', 1, 'MICORREO@MAIL.COM', '', 140115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(18, 'VIVEROS GENESIS SAC', 'CAL.LOS TEJEDORES NRO. 187 URB. INDUSTRIAL VULCANO LIMA - LIMA - ATE', '', '', 1, 2, '20517933318', 1, 'ECASTRO@VIVEROSGENESIS.COM', '', 140103, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(19, 'JUAN', '', '', '', 1, 1, '41691965', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(20, 'ROISER GOMES SANCHES', '', '', '', 1, 1, '75908019', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(21, 'LEONARDO COLLANTES SOLIS', '', '', '', 1, 1, '74022475', 1, 'TCNOAGRO@HOTMAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(22, 'GENOVEVA MONTALVO MORILLAS', '', '', '', 1, 1, '17445807', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(23, 'COLCHADO CHEVEZ ALVARO VICTOR RAUL', '', '', '', 1, 1, '46032094', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(24, 'TRANSPORTES Y SERVICIOS MERETZ SOCIEDAD ANONIMA CERRADA', 'CAL.MIGUEL GRAU LOTE. 31 CENTRO (COSTADO CLUB CASUARINAS) LAMBAYEQUE - CHICLAYO - REQUE', '', '', 1, 2, '20600602960', 1, 'TRANSPORTESYSERVICIOSMERETZ@GMAIL.COM', '', 130111, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(25, 'AGRICOLA SAN ISIDRO SOCIEDAD ANONIMA CERRADA', 'AV. PRIMAVERA NRO. 405 LAMBAYEQUE - LAMBAYEQUE - MOTUPE', '', '', 1, 2, '20479793078', 1, 'JOLSAMEN@HOTMAIL.COM', '', 130307, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(26, 'ROJAS ABAD JORGE ARMANDO', '', '', '', 1, 2, '10408344145', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(27, 'EL MOLINO DEL AGRICULTOR SAC', 'CAR.PANAMERICANA NORTE KM. 777 LAMBAYEQUE - LAMBAYEQUE - LAMBAYEQUE', '', '', 1, 2, '20487886611', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(28, 'CONSTRUCTORA E INMOBILIARIA RDJ S.A.C.', 'CAL.HORACIO CACHAY NRO. 140 LIMA - LIMA - LA VICTORIA', '', '', 1, 2, '20602537588', 1, 'MICORREO@MAIL.COM', '', 140109, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(29, 'MAESTRIA EN SERVICIOS DILIGENTES SAC', 'CAL.MANUEL MARIA IZAGA NRO. 740 INT. 201 URB. CERCADO DE CHICLAYO LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20313218083', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(30, 'MOLINERA DEL CENTRO S.C.R.LTDA.', '----KILOMETRO 777.6 NRO. S-N CARRET LAMBAYEQUE (POR EL GRIFO LOS ANGELES-COSTADO DELICIA) LAMBAYEQUE - LAMBAYEQUE - LAMBAYEQUE', '', '', 1, 2, '20396102057', 1, 'CONTABILIDAD@MOLINERADELCENTRO.COM.PE', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(31, 'EMPRESA AZUCARERA DEL NORTE S.A.C.', 'CAR.FERREÑAFE NRO. 12.6 (KM. 12.6 CARR. FERREÑAFE) LAMBAYEQUE - CHICLAYO - PICSI', '', '', 1, 2, '20479437875', 1, 'MICORREO@MAIL.COM', '', 130109, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(32, 'INSTITUCION EDUCATIVA PRIVADA SANTO TORI BIO DE MOGROVEJO', 'AV. AUGUSTO B LEGUIA NRO. 2598 URB. CRUZ DE CHALPON LAMBAYEQUE - CHICLAYO - JOSE LEONARDO ORTIZ', '', '', 1, 2, '20352736547', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(33, 'MANFREDO SOTERO LOPEZ', '', '', '', 1, 1, '41759105', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(34, 'VIDAURRE INOÑAN ALEJANDRO', '', '', '', 1, 1, '80368467', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(35, 'PEDRO SIGMOL GUSMAN', '', '', '', 1, 1, '16179253', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(36, 'ALBERTO SANTA MARIA SANDOVAL', '', '', '', 1, 1, '17639723', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(37, 'SANTIAGO GONZALES PISFIL', '', '', '', 1, 1, '16679556', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(38, 'DOMINGO SANTAMARIA DE LA CRUZ', '', '', '921407129', 1, 1, '7373582', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(39, 'LORENZO CAMISAN GONZALES', '', '', '', 1, 1, '3231592', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(40, 'ERASMO CRIZANTO TIQUILLAHUANCA', '', '', '996629524', 1, 1, '17592360', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(41, 'JHONY ALBERTO BANCES SANDOVAL', '', '', '', 1, 1, '41969157', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(42, 'BAZAN MUÑOZ RUTH NOEMI', '', '', '', 1, 2, '10420417581', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(43, 'JAIME TEJADA INOÑAN', '', '', '', 1, 1, '80321985', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(44, 'CARMEN DEL PILAR VILLANUEVA', '', '', '', 1, 1, '41767456', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(47, 'FRANCISCO ROMAN CHAPOÑAN ZEÑA', '', '', '', 1, 3, '', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(48, 'MIGUEL ANGEL GARCIA BARRETO', '', '', '', 1, 3, '', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(49, 'MATEO CHAPOÑAN FARROÑAN', '', '', '', 1, 3, '', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(50, 'LORENZO ACOSTA MERINO', '', '', '979036857', 1, 1, '17565532', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(51, 'NATIVIDAD CAMPOS CRUZ', '', '', '955809070', 1, 1, '41087360', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(52, 'EBER ASTONITAS RUIZ', '', '', '975381647', 1, 1, '43660559', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(53, 'EBARISTO HERRERA AGIPE', '', '', '986697960', 1, 1, '27985688', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(54, 'H Y M QHSE CONSULTORIA S.A.C.', 'CAL.MOISES VALIENTE NRO. 220 URB. LOS PRECURSORES MAGISTERI LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20600369548', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(55, 'ALEJANDRO TABOADA ROJAS', '', '', '969271095', 1, 1, '16657436', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(56, 'MARIO CHAPOÑAN VALDERA', '', '', '9300147184', 1, 1, '17621057', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(57, 'COMPAÑIA ARROCERA DEL PACIFICO S.R.L.', 'BL. EDIFICIO H NRO. 0 DPTO. 104 C.H. AGRUPACION HIPOLITOUNANUE (FRENTE CUADRA 14 AV.JULIO C. TELLO) LIMA - LIMA - LINCE', '', '', 1, 2, '20478061430', 1, 'MICORREO@MAIL.COM', '', 140111, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(58, 'FRUSAN AGRO S.A.C.', 'AV. CAMINO REAL NRO. 1281 INT. 803 URB. SANTA ISABEL LIMA - LIMA - SAN ISIDRO', '', '', 1, 2, '20600235738', 1, 'MICORREO@MAIL.COM', '', 140124, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(59, 'ICVU', '', '', '', 1, 3, '', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(60, 'IGLESIA CRISTIANA CON VISION Y UNCION', 'CAL.VICTOR RAUL HAYA DE LA T. NRO. 293 P.J. MURO Y DIEGO FERRE LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20480529678', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(61, 'CHIMU AGROPECUARIA S.A.', 'AV. ESPAÑA NRO. 1340 URB. CENTRO CIVICO LA LIBERTAD - TRUJILLO - TRUJILLO', '', '', 1, 2, '20132373958', 1, 'MICORREO@MAIL.COM', '', 120101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(62, 'AGROINDUSTRIAS AIB S.A', 'AV. RICARDO PALMA NRO. 894 LIMA - LIMA - MIRAFLORES', '', '', 1, 2, '20104420282', 1, 'MICORREO@MAIL.COM', '', 140115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(63, 'EDILBERTO VIGO FLORES', '', '', '', 1, 1, '43080860', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(64, 'AGRICOLA RANCHERIA S.A.', 'CAL. VICENTE DE LA VEGA NRO 664 INT. 1 CENTRO DE CHICLAYO', '', '', 1, 2, '20480065825', 1, 'TCNOAGRO@HOTMAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(65, 'AGRO INDUSTRIAL INKA WORLD S.A.C.', 'AV. JOSE CARLOS MARIATEGUI MZA. C LOTE 11 ASC. ESTRELLA SOLAR', '', '', 1, 2, '20600791771', 1, 'MICORREO@MAIL.COM', '', 140105, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(66, 'CIFUMIGA E.I.R.L.', 'MZA. D LOTE. 9 URB. CÑSAR VALLEJO (SECCIÑN 2) AREQUIPA - AREQUIPA - PAUCARPATA', '', '', 1, 2, '20455477957', 1, 'MICORREO@MAIL.COM', '', 40109, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(67, 'JUAN MARTINEZ VASQUEZ', '', '', '', 1, 1, '41759105', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(68, 'EDUARDO CUBAS PERALES', '', '', '', 1, 1, '27261185', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(69, 'NERIO ZARABIA ROMERO', '', '', '', 1, 1, '19196831', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(70, 'ASIA IMPORT S.A.C.', 'AV. SANTA ROSA DE COLLANAC LOTE. 64A C.C. DE COLLANAC (MANCHAY) LIMA - LIMA - PACHACAMAC', '', '', 1, 2, '20535599646', 1, 'MICORREO@MAIL.COM', '', 140116, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(71, 'GEOMAP SERVICE KUELAP S.R.L. GSK S.R.L.', 'MZA. A LOTE. 9 APV. EL ROSAL DE NARANJAL (LA TRANQUERA DE VIPOL) LIMA - LIMA - SAN MARTIN DE PORRES', '', '', 1, 2, '20522450872', 1, 'MICORREO@MAIL.COM', '', 140126, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(72, 'PEDRO SANTISTEBAN FARROÑAN', '', '', '', 1, 1, '17636348', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(73, 'SEGUNDO RUIZ MARRUFO', '', '', '', 1, 1, '27575011', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(74, 'JOSE RAUL TEJADA AYALA', '', '', '', 1, 1, '17640376', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(75, 'AGRICOLA BGS S.A.C.', 'JR. PEDRO IRIGOYEN NRO 186', '', '', 1, 2, '20537677962', 1, 'YACKYLINE.CRISANTO@AGRICOLABGS.PE', '', 140130, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(76, 'JUAN MANUEL TUÑOQUE BANCES', '', '', '', 1, 1, '43552244', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(77, 'GUILLERMO RAUL ANTON AMAYA', '', '', '', 1, 1, '17632712', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(78, 'JANETT ESQUEN SIALER', '', '', '', 1, 1, '16729300', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(79, 'JOSE ALARCON SIRLOPU', '', '', '', 1, 1, '25476030', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(80, 'JUAN DE DIOS GUERRA IGNACIO', '', '', '', 1, 1, '27975852', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(81, 'WILBERTO CORONADO INGA', '', '', '', 1, 1, '17615858', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(82, 'MIGUEL TANTARICO CHERO', '', '', '', 1, 1, '17547425', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(83, 'JOSE EDUARDO ZEÑA ACOSTA', '', '', '', 1, 1, '17563858', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(84, 'CELSO SANDOVAL BANCES', '', '', '', 1, 1, '17607925', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(85, 'AGRO EXPORTACION PUMA SAC', 'AV. LAS LEYENDAS NRO. 210 INT. 901A URB. LAS LEYENDAS (FRENTE A METRO LA MARINA - 901-A)', '', '', 1, 2, '20553560927', 1, 'AGROPUMA@HOTMAIL.COM', '', 140127, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(86, 'AVICOLA LA COLPA S.R.L.', 'CAL.JOHN F.KENNEDY NRO. 365 URB. BOLOGNESI (REF.365A) LAMBAYEQUE - CHICLAYO - JOSE LEONARDO ORTIZ', '', '', 1, 2, '20600318595', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(87, 'MAXIMINA VIDAURRE SANTISTEBAN', '', '', '', 1, 1, '17633914', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(88, 'JESUS ANDONAIRE RAMOS', '', '', '', 1, 1, '7511546', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(89, 'BERTHA SERRANO TIMANA', '', '', '', 1, 1, '17584588', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(90, 'TECNICA E INNOVACION AGRICOLA E.I.R.L.', 'AV. LUIS GONZALES NRO. 1456 CERCADO LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20600653122', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(91, 'SANTOS FAUSTINO VENTURA TUÑOQUE', '', '', '', 1, 1, '45148747', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(92, 'MANUEL SANCHEZ FLOREZ', '', '', '', 1, 1, '16473711', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(93, 'VICTOR SIESQUEN SONDOVAL', '', '', '', 1, 1, '80617092', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(94, 'DOROTEO CORONADO MOLLE', '', '', '', 1, 1, '16686164', 1, 'TCNOAGRO@HOTMAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(95, 'COMERCIAL MOLINERA SAN LUIS SAC', 'CAL.7 MZA. C1 LOTE. 11 URB. LAS VEGAS LIMA - LIMA - PUENTE PIEDRA', '', '', 1, 2, '20218786261', 1, 'MICORREO@MAIL.COM', '', 140119, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(96, 'CONTRATISTAS E INVERSIONES K & L SOCIEDAD ANONIMA CERRADA', 'CAL.COLOMBIA NRO. 401 (ALT. CDRA 11 AV. BRASIL) LIMA - LIMA - PUEBLO LIBRE (MAGDALENA VIEJA)', '', '', 1, 2, '20545428793', 1, 'MICORREO@MAIL.COM', '', 140117, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(97, 'SCHILLER TECHNOLOGY SRL', 'CAL.MANUEL MARIA IZAGA NRO. 956 INT. 1 CERCADO DE CHICLAYO LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20479661325', 1, 'TCNOAGRO@HOTMAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(98, 'JUAN DIEZ DE LA OLIVA', '', '', '', 1, 1, '26732838', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(99, 'JOSE MARTINEZ', '', '', '', 1, 3, '', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(100, 'SANTOS IVAN MENDOZA PAICO', '', '', '', 1, 1, '44987949', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(101, 'MIRITZA SANCHEZ BOCANEGRA', '', '', '', 1, 1, '16570444', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(102, 'CE DIEGO FERRE SOSA', 'AV. MARISCAL CASTILLA NRO. 895 LAMBAYEQUE - CHICLAYO - MONSEFU', '', '', 1, 2, '20479464333', 1, 'MICORREO@MAIL.COM', '', 130106, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(103, 'JUAN SANCHEZ', '', '', '', 1, 3, '', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(104, 'OMAR SANCHEZ', '', '', '', 1, 3, '', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(105, 'MARCO', '', '', '', 1, 3, '', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(106, 'PASCUAL CORONADO LLONTOP', '', '', '', 1, 1, '17187996', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(107, 'CESAR SUCLUPE ACOSTA', '', '', '', 1, 1, '42188369', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(108, 'DANY FUENTES AREVALO', '', '', '', 1, 1, '41036992', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(109, 'FRANCISCO DIAZ SANCHEZ', '', '', '', 1, 1, '16777018', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(110, 'JOSE PURISACA SILVA', '', '', '', 1, 1, '77381518', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(111, 'ADERLI RISCO SANCHES', '', '', '', 1, 1, '46841780', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(112, 'DANIEL SANDOVAL SANCHEZ', '', '', '', 1, 1, '17600323', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(113, 'LLAUCE TEJADA EUGENIO', '', '', '', 1, 1, '17523749', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(114, 'MARIO NILO FARRO', '', '', '', 1, 1, '16520001', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(115, 'MARLON MINAYA ROSALES', '', '', '', 1, 1, '41372216', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(116, 'EDWIN ARRUNATEGUI MORE', '', '', '', 1, 1, '45636004', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(117, 'SANTIAGO SANTISTEBAN ZEÑA', '', '', '', 1, 1, '17607835', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(118, 'SANTIAGO CAPO CUEVA', '', '', '', 1, 1, '40901987', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(119, 'MARTIN SUAREZ DE LA CRUZ', '', '', '', 1, 1, '17621913', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(120, 'ANANIAS GALVEZ VILLALOBOS', 'CHOTA', '', '', 1, 1, '46523054', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(121, 'ASOCIACION FE Y ALEGRIA DEL PERU', 'JR.CAHUIDE 884 JESUS MARIA LIMA', '', '', 1, 2, '20145915326', 1, 'MICORREO@MAIL.COM', '', 140133, 0, '', 1, NULL, NULL, NULL, 0),
(122, 'OSCAR CONCHA GUTIERRES', '', '', '', 1, 1, '16516060', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(123, 'DASA LLANTAS SAC', 'CALLE PEDRO RUIZ MZ 136 LT 12 PJ ANTONIO RAYMONDY LA VICTORIA CHICLAYO', '', '', 1, 2, '20603361009', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(124, 'AGRO TRANSPORTES DE GRANOS Y FERTILIZANTES M & M SOCIEDAD ANONIMA CERRADA', 'CAL. SAN PABLO NRO 108 CENTRO PACORA', '', '', 1, 2, '20602602380', 1, 'MICORREO@MAIL.COM', '', 130309, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(125, 'FRUTICOLA OLMOS EMPRESA INDIVIDUAL DE RESPONSABILIDAD LIMITADA', 'MZA. C LOTE. 1 URB. LA ESTACION (LOTES 1-15 Y 16A TERCER MALECON) LAMBAYEQUE - CHICLAYO - PIMENTEL', '', '', 1, 2, '20600514483', 1, 'DFERNANDEZ@FRUTICOLAOLMOS.COM', '', 130110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(126, 'TORRES OCHOA JOSE DEL CARMEN', '', '', '', 1, 2, '10415757218', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(127, 'JU<', '', '', '', 1, 3, '', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(128, 'TEODOSIA TUÑOQUE SANDOVAL', '', '', '', 1, 1, '17567899', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(129, 'EMPRESA AGRO INDUSTRIAL EL MILAGRO SAC', 'AV. LA CULTURA. NRO. 701 INT. 78 OTR. PASAJE REAL S/N INT.78 DEL MERCADO DE PRODUCTORES DE SANTA ANITA. (ESPALDA DE HOSP. H.VALDIZAN CARR.CENTRAL) LIMA - LIMA - SANTA ANITA', '', '', 1, 2, '20480239912', 1, 'MICORREO@MAIL.COM', '', 140143, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(130, 'CESAR SILVA LUMBA', '', '', '', 1, 1, '41587868', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(131, 'CONSTRUCCIONES METALICAS Y MONTAJE ABG S.R.L.', 'CAL.4 MZA. D LOTE. 1 URB. GRIMANESA PROV. CONST. DEL CALLAO - PROV. CONST. DEL CALLAO - CALLAO', '', '', 1, 2, '20122545637', 1, 'MICORREO@MAIL.COM', '', 240101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(132, 'JOSE ELVIS HUANCA CULQUICONDOR', '', '', '', 1, 1, '80375528', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(133, 'SEMILLAS SIPAN EMPRESA INDIVIDUAL DE RESPONSABILIDAD LIMITADA', 'CAL.JUANA CASTRO DE BULNES NRO. 530 CERCADO FERREÑAFE (ALTURA CDRA 4 AV.NICANOR CARMONA) LAMBAYEQUE - FERREÑAFE - FERREÑAFE', '', '', 1, 2, '20103294348', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(134, 'JUAN ERASMO MARTINEZ MUÑOZ', '', '', '', 1, 1, '41691965', 1, 'MICORREO@MAIL.COM', 'CIFARELLI', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(135, '2SFD CONSULTORES & CONSTRUCTORES S.R.L.', 'CAL.LA MARINA NRO. 525 SEC. LOS AROMOS CAJAMARCA - JAEN - JAEN', '', '', 1, 2, '20480774397', 1, 'PESAN1308@GMAIL.COM', '', 60801, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(136, 'CESAR PEREZ CORONADO', '', '', '', 1, 1, '9451051', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(137, 'COSTA DEL SOL S A', 'AV. SALAVERRY NRO. 3060 LIMA - LIMA - MAGDALENA DEL MAR', '', '', 1, 2, '20231843460', 1, 'CAGUIRRE@COSTADELPERU.COM', '', 140114, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(138, 'CARLOS CASTRO OROSCO', '', '', '962460258', 1, 1, '17544410', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(139, 'JORGUE VALLENA MORI', '', '', '', 1, 1, '42796098', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(140, 'SEGUNDO CARRANZA MEJIA', '', '', '', 1, 1, '27371159', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(141, 'JHON MARCOS ZARPAN', 'VILLA EL MILAGRO', '', '985924822', 1, 1, '16620800', 1, 'MICORREO@MAIL.COM', 'CEFERINO', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(142, 'JULIO CAICEDO FLORES', '', 'CHACUPE', '920597316', 1, 1, '16791911', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(143, 'MANAYAY RODRIGUEZ CRISPIN VIRGILIO', '', '', '', 1, 2, '10436527531', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(144, 'SANCHES SANTISTEBAN DEMETRIO', '', '', '', 1, 1, '17607859', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(145, 'HECTOR MONSALVE SALAS', '', '', '', 1, 1, '27279805', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(146, 'INVERSIONES SERVICIOS MULTIPLES HUAROC E.I.R.L', 'CAL.LOS VIÑEDOS MZA. F LOTE. 35 C.P. EL CALICHE (ALT.DEL KM 33.5 DE LA PANAMERICANA NORTE) LIMA - LIMA - PUENTE PIEDRA', '', '', 1, 2, '20518646380', 1, 'MICORREO@MAIL.COM', '', 140119, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(147, 'ESTRATA S.A.C.', 'CAL.EL ENGRANAJE MZA. A LOTE. 4 URB. IND LA MILLA (ALTURA SERPOST) LIMA - LIMA - SAN MARTIN DE PORRES', '', '', 1, 2, '20601314691', 1, 'ESTRATA.MAGADALENA@HOTMAIL.COM', '', 140119, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(148, 'DISTRIBUIDORA FERRETERA MIRANDA S.A.C.', 'AV. LUIS GONZALES NRO. 1557 URB. SAN LUIS (POR EL INSTITUTO IDAT) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20600595432', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(149, 'HUERTO GENESIS S.A.C.', 'CAL.LOS TEJEDORES NRO. 187 URB. INDUSTRIAL VULCANO LIMA - LIMA - ATE', '', '', 1, 2, '20523020561', 1, 'ECRUZ@VIVEROSGENESIS.COM.PE', '', 140103, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(150, 'MUNICIPALIDAD SE ILLIMO', '', '', '', 1, 3, '', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(151, 'DEFER SERVICIOS INDUSTRIALES SOCIEDAD COMERCIAL DE RESPONSABILIDAD LIMITADA', 'CAL.LAMBAYEQUE NRO. 631 P.J. SANTA ROSA LAMBAYEQUE - LAMBAYEQUE - LAMBAYEQUE', '', '', 1, 2, '20600257332', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(152, 'AGRICOLA MGR E.I.R.L.', 'AV. DOS DE MAYO NRO 461 CENTRO', '', '', 1, 2, '20479908827', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(153, 'MUNICIPALIDAD DISTRITAL DE ILLIMO', 'CAL.REAL NRO. 444 LAMBAYEQUE - LAMBAYEQUE - ILLIMO', '', '', 1, 2, '20170302134', 1, 'REINVA1981@HOTMAIL.COM', '', 130303, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(154, 'VASQUES AGUILAR JULIO', '', '', '999979712', 1, 1, '27362729', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(155, 'JUAN MIO TORREZ', '', '', '996813555', 1, 1, '43915287', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(156, 'BELTIN TORRES ROMERO', '', '', '980667850', 1, 1, '46543337', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(157, 'HELI RIMARACHIN CARRANZA', '', '', '', 1, 1, '41860581', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(158, 'ZAPATA SAAVEDRA DENNIS MANUEL', '', '', '', 1, 2, '10167823985', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(159, 'MUNICIPALIDAD CIUDAD ETEN', '', '', '', 1, 3, '70227127', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(160, 'MUNICIPALIDAD DISTRITAL DE CIUDAD ETEN', 'CAL.PEDRO RUIZ NRO. 579 CENTRO (CENTRO PARQUE PRINCIPAL) LAMBAYEQUE - CHICLAYO - ETEN', '', '', 1, 2, '20147103299', 1, 'MICORREO@MAIL.COM', '', 130103, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(161, 'ABELARDO FARROÑAN CHAPOÑAN', '', '', '', 1, 1, '17616515', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(162, 'HEBERTH DAVID SUYON BANCES', '', '', '941183005', 1, 1, '43037862', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(163, 'LA SUSPENSION, FRENOS Y SERVICIOS E.I.R.L.', 'AV. AUGUSTO B. LEGUIA NRO. 879 URB. SAN LORENZO (ESQUINA AV. LUIS GONZALES. HORARIO 9-5 P) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20561317101', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(164, 'AGROCORAL E.I.R.L.', 'AV. ARICA NRO 1765 URB. CAMPODONICO', '', '', 1, 2, '20604085641', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(165, 'EMPRESA AGROINDUSTRIAL POMALCA S.A.A.', 'CAR.CHICLAYO A CHONGOYAPE KM. 07 (FRENTE A LA IGLESIA DE POMALCA) LAMBAYEQUE - CHICLAYO - POMALCA', '', '', 1, 2, '20163898200', 1, 'NCABREJOS@POMALCA.COM.PE', '', 130118, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(166, 'CERNA BECERRA WILMER', 'PASCUAL PUYEN 115 MORROPE', '', '', 1, 2, '10164582049', 1, 'MICORREO@MAIL.COM', '', 130306, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(167, 'AMC CORPORATION EIRL', 'AV.UNIVERSITARIA 840 -SAN MIGUEL LIMA', '', '', 1, 2, '20601791448', 1, 'MICORREO@MAIL.COM', '', 140127, 0, '', 1, NULL, NULL, NULL, 0),
(168, 'AGROCENTRO N&B SOCIEDAD COMERCIAL DE RESPONSABILIDAD LIMITADA', 'AV. CHACHAPOYAS NRO 3049', '', '', 1, 2, '20539061501', 1, 'MICORREO@MAIL.COM', '', 10701, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(169, 'AGRO VELMON S.A.C.', 'AV. LA LIBERTAD NRO 0873', '', '', 1, 2, '20602902031', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(170, 'NEGOCIOS ELECTROAGRICOLAS S.A.C', 'CAL.GRAL PEDRO SILVA NRO. 524 URB. SAN ANTONIO (ALT CDRA 2 JUAN DE LA FUENTE) LIMA - LIMA - MIRAFLORES', '', '', 1, 2, '20440115498', 1, 'MICORREO@MAIL.COM', '', 140115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(171, 'MARGISOL S.R.L.', 'AV. ALFONSO UGARTE NRO. 093 DPTO. 402 RIVERA DEL MAR LAMBAYEQUE - CHICLAYO - PIMENTEL', '', '', 1, 2, '20604561931', 1, 'TCNOAGRO@MAIL.COM', '', 130110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(172, 'AGRICOLA HMPM SOCIEDAD ANONIMA', 'CAL. TORRES PAZ NRO 777', '', '', 1, 2, '20487422895', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(173, 'MORE CHUPAN ENRIQUE', '', '', '', 1, 2, '10335689114', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(174, 'SOLUCIONES HIDRICAS PERFORACIONES Y CONSTRUCCIONES S.A.C.', 'AV. MIGUEL GRAU NRO. 1615 (FRENTE AL PARQUE ZONAL) LAMBAYEQUE - CHICLAYO - LA VICTORIA', '', '', 1, 2, '20600624301', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(175, 'PRODUCTORES ORGANICOS DIAZ & CAMPOS S.A.C.', 'CAL.ETEN NRO. 162 URB. SANTA VICTORIA LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20561245861', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(176, 'MOLINOÑS CRISTO MORADO S.A.C.', 'AV. ALFREDO BENAVIDES NRO. 4895 INT. 201 URB. PROLONGACION BENAVIDES LIMA - LIMA - SANTIAGO DE SURCO', '', '', 1, 2, '20480821573', 1, 'MICORREO@MAIL.COM', '', 140130, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(177, 'LUIS VALDIVIA', '', '', '', 1, 3, '', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(178, 'LUIS VALDIVIA CASAS', '', '', '', 1, 1, '26953330', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(179, 'AGRO FRANCCESCA E.I.R.L.', 'AV. LOS A NGELES MZA. C LOTE. 14 Z.I. PARQUE INDUSTRIA L LIMA - LIMA - ATE', '', '', 1, 2, '20482244310', 1, 'TUCORREO@GMAIL.COM', '', 140103, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(180, 'MARTINEZ MUÑOZ JUAN ERASMO', '', '', '', 1, 2, '10416919653', 1, 'TCNOAGRO@HOTMAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(181, 'GANDULES', '', '', '', 1, 3, '', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(182, 'OBCITRUS S.R.L.', 'AV. AUGUSTO B  LEGUIA NRO 219', '', '', 1, 2, '20600845170', 1, 'MICORREO@MAIL.COM', '', 130308, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(183, 'GRIFO MI AMANDITA E.I.R.L.', 'AV. AGRICULTURA NRO. 1101 A.H. VILLA HERMOSA (EX GRIFO ROSARIO) LAMBAYEQUE - CHICLAYO - JOSE LEONARDO ORTIZ', '', '', 1, 2, '20479961981', 1, 'GRUPOMIARMANDITA@HOTMAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(184, 'AGRO ARROZ SRL', 'CAL. LOS ROSALES NRO 195 URB. SANTA VICTORIA', '', '', 1, 2, '20561414646', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(185, 'CMDS AGRO S.A.C.', 'CAL.ZARUMILLA NRO. 249 P.J. MARTIR JOSE OLAYA LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20601468027', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(186, 'AGROCENTRO INDUSTRIAL DEL PERU S.R.L.', 'JR. UNION NRO S/N POMACOCHAS', '', '', 1, 2, '20538952398', 1, 'MICORREO@MAIL.COM', '', 10306, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(187, 'FASERVI C Y G E.I.R.L', 'MZA. T INT. 304 URB. PINOS DE LA PLATA (CAL CONDOMINIO RES. LOS PINOS. PTA 4) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20561296007', 1, 'MIGUELEJD1976@GMAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(188, 'AGROINDUSTRIA SILVANO E.I.R.L.', 'CAL. LOS PINOS NRO SN C.P. VILLA HERMOSA', '', '', 1, 2, '20604503958', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(189, 'NEGOCIACION AGRICOLA GANADERA LA PARED S.A.', 'AV. CHINCHAYSUYO NRO. 440 URB. FEDERICO VILLARREAL LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20479660353', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(190, 'NEGOCIOS Y SERVICIOS MULTIPLES SAN FRANCISCO S.A.C', 'CAL.LIMA NRO. 307 PIURA - PIURA - LA UNION', '', '', 1, 2, '20484265578', 1, 'MICORREO@MAIL.COM', '', 190106, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(191, 'CARLOS MARTIN MARIN CHAVEZ', '', '', '', 1, 1, '74065328', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(192, 'TRAPANI CULTIVARES PERU SAC', 'AV. RICARDO ANGULO NRO. 776 INT. 301 URB. CORPAC (A LA ESPALDA DEL OVALO QUIÑONEZ) LIMA - LIMA - SAN ISIDRO', '', '', 1, 2, '20600708997', 1, 'MICORREO@MAIL.COM', '', 140124, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(193, 'ORGANICA E.I.R.L', 'AV. LUIS GONZALES NRO. 1315 INT. 205 (SEGUNDO PISO) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20480013868', 1, 'CJASESORESCONSULTORES@GMAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(194, 'RAMEQSA E.I.R.L.', '----MODULO C, SECTOR 2 MZA. E-04 LOTE. 13 CIUDAD MAJES AREQUIPA - CAYLLOMA - MAJES', '', '', 1, 2, '20456332332', 1, 'MICORREO@MAIL.COM', '', 40220, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(195, 'AGRICOLA AGR EIRL', 'AV. DOS DE MAYO NRO 461 CENTRO', '', '', 1, 2, '20479908746', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(196, 'TPS SEMILLAS SOCIEDAD ANONIMA CERRADA', 'JR. LUIS N. SAENZ NRO. 465 DPTO. 501 BLOQUE A LIMA - LIMA - JESUS MARIA', '', '', 1, 2, '20603807678', 1, 'MICORREO@MAIL.COM', '', 140133, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(197, 'AGRICOLA HERMELINDA S.R.L.', 'AV. FERNANDO B. TERRY NRO 306 P.J. TUPAC AMARU', '', '', 1, 2, '20603328761', 1, 'TCNOAGRO@HOTMAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(198, 'RISCO ZUNE OSCAR MAXIMILIANO', '', '', '', 1, 2, '10167041332', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(199, 'PABLO PUSE ARROLLO', '', '', '', 1, 1, '41791261', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(200, 'VIVAR SOCIEDAD ANONIMA CERRADA', 'CAL.HUAYNA CAPAC NRO. 1268 LAMBAYEQUE - CHICLAYO - LA VICTORIA', '', '', 1, 2, '20437447552', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(201, 'EMPRESA AGRO PALTO PAYAC S.R.L.', '----PARCELA NRO. REF SAN JUAN - LA ZARANDA (PARCELA 10772,HOSPEDAJE BOSQUE DE POMAC) LAMBAYEQUE - FERREÑAFE - PITIPO', '', '', 1, 2, '20538980251', 1, 'MICORREO@MAIL.COM', '', 130204, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(202, 'CARRANZA LEON JOSE SANTOS', '', '', '', 1, 2, '10273707609', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(203, 'AGRICOLA PAMPA BAJA S.A.C.', 'CAL. ERNESTO GUNTHER NRO 245 URB. PARQUE INDUSTRIAL', '', '', 1, 2, '20411808972', 1, 'MICORREO@MAIL.COM', '', 40101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(204, 'CMAC PIURA S.A.C.', 'JR. AYACUCHO NRO. 353 CENTRO CIVICO (PALACIO MUNICIPAL) PIURA - PIURA - PIURA', '', '', 1, 2, '20113604248', 1, 'MICORREO@MAIL.COM', '', 190101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(205, 'NAYSOL CONTRATISTAS Y SERVICIOS GENERALES S.R.L.', 'AV. CRISTOBAL DE PERALTA SUR NRO. 1625 DPTO. 501 URB. VALLE HERMOSO (ESPALDA DE CASINELLI PUENTE BENVIDES) LIMA - LIMA - SANTIAGO DE SURCO', '', '', 1, 2, '20561254851', 1, 'MICORREO@MAIL.COM', '', 140130, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(206, 'AGRICOLA MAQUEN S.A.C', 'CAL. NAYLAMP NRO 195 CERCADO', '', '', 1, 2, '20487589919', 1, 'JUAN.SOFT@HOTMAIL.COM', '', 130304, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(207, 'ROSSANA BRAVO ALARCON', '', '', '', 1, 1, '40053659', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(208, 'IGLESIA CRISTIANA CASA DEL REY MINISTRIES DEVELOPMENT', 'CAL.CRISTOBAL COLON NRO. 141 CERCADO DE CHICLAYO LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20561363553', 1, 'LARSO7@HOTMAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(209, 'NATIVIDAD BASTUREN ASTONITAS', '', '', '', 1, 1, '80118160', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(210, 'NEW EXPO S.A.C.', 'CAL.RENEE DESCARTES NRO. 377 Z.I. SANTA RAQUEL II ETAPA (ESPALDA CDRA 25 AV SEPARADORA INDUSTRIAL) LIMA - LIMA - ATE', '', '', 1, 2, '20427896740', 1, 'MICORREO@MAIL.COM', '', 140103, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(211, 'FUNDO BELESSIA S.A.C.', 'C.RUVALLE JEQUETEPEQUE NRO. 427 SEC. PAMPAS DE CERRO COLORADO (OTRO NRO. 428) LA LIBERTAD - CHEPEN - PACANGA', '', '', 1, 2, '20603610947', 1, 'ADMINISTRACION@FUNDOBELESSIA.COM', '', 120902, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(212, 'COMERCIAL AGRICOLA VISTA ALEGRE E.I.R.L.', '----PROLONGACION LIMA NRO. 1001 LA LIBERTAD - PACASMAYO - SAN JOSE', '', '', 1, 2, '20396811295', 1, 'MICORREO@MAIL.COM', '', 50106, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(213, 'TRISTAN BLANCO CESAR', '', '', '', 1, 2, '10166317253', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(214, 'CATAPA SOCIEDAD ANONIMA CERRADA', 'AV. LOS INCAS NRO. 136 URB. LA VICTORIA LAMBAYEQUE - CHICLAYO - LA VICTORIA', '', '', 1, 2, '20480823355', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(215, 'SERVICIOS & TRANSPORTES VIDAURRE S.A.C.', 'CAL.28 DE JULIO NRO. 212 CAS. CRUZ DEL MEDANO LAMBAYEQUE - LAMBAYEQUE - MORROPE', '', '', 1, 2, '20603656343', 1, 'MICORREO@MAIL.COM', '', 130306, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(216, 'ESPINOSA BURNEO EDUARDO GERARDO', '', '', '', 1, 2, '10026059653', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(217, 'PEPPERS AMERICA S.A.C.', 'JR. MANUEL MENDEZ NRO. 672 URB. STA. CATALINA LIMA - LIMA - LA VICTORIA', '', '', 1, 2, '20522951146', 1, 'MICORREO@MAIL.COM', '', 140109, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(218, 'JUAN IDROGO TOCAS', '', '', '', 1, 1, '27575326', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(219, 'LEANDRO SANCHES BERNILLA', '', '', '', 1, 1, '47882459', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(220, 'SERVICIOS DIVERSOS MIGUEL ANGEL E.I.R.L.', 'CAL.SAN JOSE NRO. 493 LAMBAYEQUE - LAMBAYEQUE - MOTUPE', '', '', 1, 2, '20479601934', 1, 'MICORREO@MAIL.COM', '', 130307, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(221, 'SERVITRAC R & M S.A.C.', 'MZA. C LOTE. 15 URB. CHIMU (1ER PISO) LA LIBERTAD - TRUJILLO - TRUJILLO', '', '', 1, 2, '20600373821', 1, 'MICORREO@MAIL.COM', '', 120101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(222, 'MARIANI CAFFERATA JOSE FRANCISCO', '', '', '', 1, 2, '10165898899', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(223, 'CRISTIAN SANTAMARIA FLORES', '', '', '', 1, 1, '43922736', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(224, 'CELESTINO HURTADO GAMBOA', '', '', '', 1, 1, '3676339', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(225, 'NEGOCIOS Y TRANSPORTES FERNANDEZ SOCIEDAD COMERCIAL DE RESPONSABILIDAD LIMITADA', 'CAL.LORETO NRO. S/N PLAYA SUR (FRENTE AL 116 CUADRA UNICA) TUMBES - ZARUMILLA - AGUAS VERDES', '', '', 1, 2, '20409218939', 1, 'MICORREO@MAIL.COM', '', 230304, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(226, 'INVERSIONES LUCIANA T Y C E.I.R.L.', 'JR. ALAMIRO CALDERON NRO. 597 SEC. ALTO PACASMAYO LA LIBERTAD - PACASMAYO - PACASMAYO', '', '', 1, 2, '20600539176', 1, 'INVERSIONESLUCIANA@GMAIL.COM', '', 120506, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(227, 'LUIS FRANCISCO ASENCIO RAMOS', '', '', '', 1, 1, '17574080', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(228, 'GRUPO LF INDUSTRIAL E.I.R.L.', 'MZA. Q LOTE. 5B2 COMP.TERRENOS CAMPOY (COSTADO VIDRIERIA MILAGROS C.E. LACOMUN) LIMA - LIMA - SAN JUAN DE LURIGANCHO', '', '', 1, 2, '20603752709', 1, 'MICORREO@MAIL.COM', '', 140137, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(229, 'ELEAZAR VARGAS PEREZ', '', '', '', 1, 1, '28115754', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(230, 'JESUS GUTIERRES INOÑAN', '', '', '', 1, 1, '16747963', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(231, 'PUNTO NEGRO E.I.R.L.', 'MZA. R LOTE. 8 RES. PUERTAS DEL SOL - CHACUPE LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20480456263', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(232, 'LUIS FELIPE FLOREZ SANCHEZ', '', '', '', 1, 1, '17544174', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(233, 'CAYCAY UGAZ MIGUEL ARTURO', '', '', '', 1, 2, '10419246684', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(234, 'ORGANIC ANDES FOOD SOCIEDAD ANONIMA CERRADA', 'AV. LOS CASTAÑOS NRO. 310 DPTO. 1006 LIMA - LIMA - SAN ISIDRO', '', '', 1, 2, '20600993853', 1, 'MICORREO@MAIL.COM', '', 140124, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(235, 'ADS RED DE INGENIEROS E.I.R.L.', 'CAL. FEDERICO VILLARREAL NRO 384 URB. LOS PARQUES', '', '', 1, 2, '20602023479', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(236, 'CASTRO CENTURION CESAR AGUSTO', '', '', '', 1, 1, '17544138', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(237, 'ABEL YEN JIIMENEZ', '', '', '', 1, 1, '16754227', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(238, 'ANIVAL LUCIO CARMONA CAMPOS', '', '', '', 1, 1, '16580892', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(239, 'AGRO OLMOS S.R.L', 'CAR.PANAMERICANA ANTIGUA KM. 91.5 CENTRO OLMOS (FRENT GRIF OLMOS-PREGUNTAR FREDY CARBAJA) LAMBAYEQUE - LAMBAYEQUE - OLMOS', '', '', 1, 2, '20480402252', 1, 'ANTONIO.PEDREROS@GMAIL.COM', '', 130308, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(240, 'GANADERA EL MILAGRO S.A.C.', 'AV. JOSE BALTA NRO. 031 LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20479436470', 1, 'TCNOAGRO@HOTMAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(241, 'BAZAN MALCA MARCOS ISMAEL', '', '', '', 1, 2, '10455122665', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(242, 'UNIVERSIDAD NACIONAL PEDRO RUIZ GALLO - LAMBAYEQUE', '', '', '', 1, 3, '', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(243, 'SHUMAN PRODUCE PERU SOCIEDAD ANONIMA CERRADA', 'AV. PARDO Y ALIAGA NRO. 695 DPTO. PISO INT. 11 URB. CHACARILLA SANTA CRUZ LIMA - LIMA - SAN ISIDRO', '', '', 1, 2, '20514006823', 1, 'CTORRES@SHUMANPERU.COM', '', 140124, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(244, 'SOCIEDAD AGRICOLA MOCHE NORTE S.A.', 'AV. BENAVIDES NRO. 474 DPTO. 204 LIMA - LIMA - MIRAFLORES', '', '', 1, 2, '20510360428', 1, 'MICORREO@MAIL.COM', '', 140115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(245, 'INGENIERIA 360 S.A.C.', 'AV. LA LIBERTAD NRO. 890 URB. FEDERICO VILLARREAL LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20600678435', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(246, 'CARLITA INVERSIONES E.I.R.L.', 'MZA. C LOTE. 25 URB. CONDOMINIO EL JOCKEY LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20487608565', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(247, 'VIRU S.A.', 'CAR.PANAMERICANA NORTE KM. 521 (A 1260 MTS CARRET. PANAM. NORTE KM 521) LA LIBERTAD - VIRU - VIRU', '', '', 1, 2, '20373860736', 1, 'JBENITESO@VIRU.COM.PE', '', 30612, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(248, 'AGRONEGOCIOS Y SERVICIOS SAM S.A.C.', 'CAL. JOSE MERCEDES ANTEPARRA NRO 169 INT. 03', '', '', 1, 2, '20604896275', 1, 'MICORREO@MAIL.COM', '', 130307, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(249, 'NEOCAMPO S.A.C.', 'CAL.LAS ORQUIDEAS MZA. F LOTE. 8 LA ENCALADA (PROL.FATIMA PASAN VILLA VALLEJIANA 2 CDS) LA LIBERTAD - TRUJILLO - VICTOR LARCO HERRERA', '', '', 1, 2, '20559931731', 1, 'MICORREO@MAIL.COM', '', 120107, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(250, 'EXPRESO CONACHE E.I.R.L.', 'CAR.HUANCHACO KM. 11 LOTE. A INT. 10.5 A.H. HUANCHAQUITO ALTO LA LIBERTAD - TRUJILLO - HUANCHACO', '', '', 1, 2, '20482711465', 1, 'MICORREO@MAIL.COM', '', 120102, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(251, 'CRUZ MONTALVAN ELADIO', '', '', '', 1, 2, '10166768301', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(252, 'VALDERA SIESQUEN JUAN', '', '', '', 1, 2, '10415985636', 1, 'SERBIMEL@HOTMAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(253, 'ORGANIZACION INTERNAC NUEVA ACROPOLIS', 'AV. JAVIER PRADO ESTE NRO. 465 LIMA - LIMA - SAN ISIDRO', '', '', 1, 2, '20113015765', 1, 'MICORREO@MAIL.COM', '', 140124, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(254, 'WENSJOE ALCANTARA CESAR', '', '', '', 1, 2, '10102677833', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(255, 'INVERSIONES SUR ANDINA S.A.C.', 'AV. RICARDO PALMA NRO. 1250 LIMA - LIMA - MIRAFLORES', '', '', 1, 2, '20603951477', 1, 'VISALOT10@GMAIL.COM', '', 140115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(256, 'JUAN FERNANDO BEL ACHA', '', '', '', 1, 2, '10722103373', 1, 'MICORREO@MAIL.COM', '', 190601, 0, '', 1, NULL, NULL, NULL, 0),
(257, 'RICARDO REQUEJO SANTOS', '', '', '', 1, 1, '16657874', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(258, 'ALEX DANIEL MORALES ARROYO', '', '', '', 1, 1, '48452177', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(259, 'MOTOFUERZA S.A.C.', 'CAL.LOS AVIADORES NRO. 108 DPTO. 101 LIMA - LIMA - SANTIAGO DE SURCO', '', '', 1, 2, '20478217898', 1, 'MICORREO@MAIL.COM', '', 140130, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(260, 'AGRICOLA SAN JUAN DE LA CALERA SA', 'INT. 01 MZA. C LOTE 1 15 URB. LA ESTACION', '', '', 1, 2, '20479694924', 1, 'MICORREO@MAIL.COM', '', 130110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(261, 'SUSANA ROMELIA RAMIREZ SOPLAPUCO', '', '', '', 1, 1, '42061275', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(262, 'LEODAN CALLE CASTILLO', '', '', '', 1, 1, '44948758', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(263, 'LUIS RODAS TERAN', '', '', '', 1, 1, '19324684', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(264, 'ONG EDUCAR SEMBRANDO', '', '', '', 1, 3, '', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(265, 'SERRATO MONTALVAN JOSE LUIS', '', '', '', 1, 2, '10167847876', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(266, 'OYOLA BURGA JUAN CARLO', '', '', '', 1, 1, '42348285', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(267, 'AGRO EXPORT EL LIMON S.R.L.', 'CAL. ANCON NRO 154 URB. SANTA VICTORIA', '', '', 1, 2, '20601873827', 1, 'MSRIOSSILVA@GMAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(268, 'ISABEL VERA FACIO', '', '', '', 1, 1, '7822017', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(269, 'TARRILLO MILIAN SEGUNDO MEDARDO', '', '', '', 1, 2, '10804847001', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(270, 'MARIA LUCRESIA SANTISTEBAN VIDAURRE', '', '', '', 1, 1, '17611523', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(271, 'GAS INTERNATIONAL MURILLO SAC', 'AV. EL SOL MZA. K1 LOTE. 12 URB. LA CAMPIÑA (ESQUINA AV. GUARDIA CIVIL, AV. EL SOL) LIMA - LIMA - CHORRILLOS', '', '', 1, 2, '20506736341', 1, 'MICORREO@MAIL.COM', '', 140108, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(272, 'SEMILLAS & GENETICA SOCIEDAD ANONIMA CERRADA', 'MZA. B LOTE. 24 URB. LA ENSENADA (I ETAPA) LAMBAYEQUE - CHICLAYO - PIMENTEL', '', '', 1, 2, '20604115079', 1, 'JIBERICO16@GMAIL.COM', '', 130110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(273, 'SEMILLAS PIURANAS SOCIEDAD ANONIMA CERRADA', 'JR. CHORRILLOS NRO. 409 PIURA - PIURA - CATACAOS', '', '', 1, 2, '20525952747', 1, 'MICORREO@MAIL.COM', '', 190104, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(274, 'JORGUE REQUEJO SANTOS', '', '', '', 1, 1, '16449337', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(275, 'MONTES FERNANDEZ COSME EDUARDO', '', '', '', 1, 2, '10304075631', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(276, 'AGRICOLA ZEIT ORGANISCH SOCIEDAD ANONIMA CERRADA', 'AV. MIGUEL GRAU NRO 1563 DEP. E501 CND. LOS CEDROS DE LA VICTORIA', '', '', 1, 2, '20487723151', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(277, 'ASALDE CASAS CARLA EMPERATRIZ', '', '', '', 1, 2, '10167989735', 1, 'MOTO.REPUESTOS-CHICLAYO@HOTMAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(278, 'ROMERO GOMEZ DAVID ERASMO', '', '', '', 1, 2, '10427629703', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(279, 'IRMA FERNANDEZ HERNANDEZ', '', '', '', 1, 1, '42891778', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(280, 'MORALES CHUNGA JOSE EULEUTERIO', '', '', '', 1, 1, '16582972', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(281, 'JUAN DIAZ NUÑEZ', '', '', '', 1, 1, '40998458', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(282, 'JOSE SALAZAR QUISPE', '', '', '', 1, 1, '43520083', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(283, 'JENNY FARRO TEPE', '', '', '', 1, 1, '40451291', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(284, 'JESUS GUTIERREZ INOÑAN', '', '', '', 1, 1, '16747963', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(285, 'PERCY GUEVARA RODRIGUEZ', '', '', '', 1, 1, '40695878', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(286, 'MARTIN HUAMAN CHAVEZ', '', '', '', 1, 1, '72427125', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(287, 'MANUEL LARA TOCAS', '', '', '', 1, 1, '60397691', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(288, 'WILIAN SANPEN SANCHEZ', '', '', '', 1, 1, '43714317', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(289, 'PEDRO BANCES SANCHEZ', '', '', '', 1, 1, '43056075', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(290, 'SANDOVAL VERA JESUS', '', '', '', 1, 1, '41916133', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(291, 'MIGUEL TUÑOQUE MERINO', '', '', '', 1, 1, '48061425', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(292, 'JORGUE MILIAN GABRIEL', '', '', '', 1, 1, '16722044', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(293, 'REBAZA HUAMAN GENARO ASUNCION', '', '', '', 1, 2, '10166774034', 1, 'TCNOAGRO@HOTMAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(294, 'SEGOVIA VASQUEZ REYNA', '', '', '', 1, 1, '42911851', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(295, 'MAI S.A.', 'CAL.FILIPINAS NRO. 221 TUMBES - TUMBES - TUMBES', '', '', 1, 2, '20132677825', 1, 'MICORREO@MAIL.COM', '', 230101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0);
INSERT INTO `cliente` (`codigo_cli`, `nombre_cli`, `direccion_cli`, `ciudad_cli`, `telefono_cli`, `codigo_tip`, `codigo_doc`, `numero_doc`, `codigo_szo`, `email_cli`, `observacion_cli`, `codigo_dis`, `estadosunat_cli`, `condicionsunat_cli`, `estado_cli`, `usuario_reg`, `usuario_mod`, `fecha_mod`, `sistema`) VALUES
(296, 'PULVERIZADORES GABI SOCIEDAD COMERCIAL DE RESPONSABILIDAD LIMITADA', 'CAL.PANAMERICANA NRO. 827 LAMBAYEQUE - LAMBAYEQUE - ILLIMO', '', '', 1, 2, '20601491444', 1, 'MICORREO@MAIL.COM', '', 130303, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(297, 'DE LA CRUZ PURIHUAMAN SANDRA', '', '', '', 1, 2, '10464703115', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(298, 'VIVERO CASA VERDE DE MOTUPE E.I.R.L.', 'CAL. CESAR VALLEJOS NRO 104 URB. VILLA RICA', '', '', 1, 2, '20602478298', 1, 'MICORREO@MAIL.COM', '', 130307, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(299, 'INVERAGRO SAN MARTIN DE PORRAS S.A.C.', 'CAR.FERNANDO BELAUNDE TERRY NRO. 0 INT. A BARRIO EL EDEN (KM. 296 + 400) AMAZONAS - BONGARA - JAZAN', '', '', 1, 2, '20479862738', 1, 'VISALOT10@GMAIL.COM', '', 10312, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(300, 'INVERSIONES MARDI E.I.R.L.', 'CAL.SACSAYHUAMAN CDRA. 1 NRO. S/N SECTOR PUEBLO LIBRE CAJAMARCA - JAEN - JAEN', '', '', 1, 2, '20487594670', 1, 'MARDI.EIRL@GMAIL.COM', '', 60801, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(301, 'AGRO INVERSIONES EL SEMBRADOR E.I.R.L.', 'CAL. ARICA NRO 1745 URB. SAN MARTIN', '', '', 1, 2, '20600912306', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(302, 'JOSE TANCO', '', '', '', 1, 1, '29621051', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(303, 'CESAR YUPTON CHAVEZ', '', '', '', 1, 1, '41060006', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(304, 'COTRINA TARRILLO EMERITA', '', '', '', 1, 2, '10272953614', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(305, 'EMP. COGAFE CONTRATISTAS Y CONSULTORES INGENIEROS SAC.', 'AV. HUANUCO NRO. 115A BAR. SAN PEDRO CAJAMARCA - CAJAMARCA - CAJAMARCA', '', '', 1, 2, '20325976455', 1, 'MICORREO@MAIL.COM', '', 60101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(306, 'ADMINISTRADORA DE NEGOCIOS AGROINDUSTRIALES SOCIEDAD ANONIMA CERRADA - ADMINISTRADORA DE NEGOCIOS AG', 'AV. LAS PALMERAS NRO 540 INT. 301E URB. CAMACHO', '', '', 1, 2, '20549883207', 1, 'MICORREO@MAIL.COM', '', 140110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(307, 'AF INMOBILIARIA SOCIEDAD ANONIMA CERRADA', 'AV. LUIS GONZALES NRO 1315 URB. CERCADO DE CHICLAYO', '', '', 1, 2, '20480423501', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(308, 'CASAGRANO', 'CAL.OASIS NRO. 160 DPTO. 201 URB. REMIGIO SILVA ET.5 (COSTADO DEL MERCADO DEL PUEBLO) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20561351032', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(309, 'DORALIZA BUSTAMANTE MAITA', '', '', '', 1, 1, '19326415', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(310, 'ROMARACHIN CIEZA SANTOS', '', '', '', 1, 1, '27415076', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(311, 'PAVIMENTOS Y OBRAS VIALES SAC', 'CAL.INCANATO NRO. 528 INT. A P.J. GARCES (PISO 3) LAMBAYEQUE - CHICLAYO - JOSE LEONARDO ORTIZ', '', '', 1, 2, '20480392788', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(312, 'ABANTO LEIVA MARIA AGRIPINA', '', '', '', 1, 2, '10193238331', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(313, 'RONALD YOVANI MAZA CHAVEZ', '', '', '', 1, 1, '41995389', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(314, 'CONSORCIO S Y C SOCIEDAD ANONIMA CERRADA', 'CAL.JORGE POLAR NRO. 107 URB. VICTORIA AREQUIPA - AREQUIPA - AREQUIPA', '', '', 1, 2, '20454502877', 1, 'MICORREO@MAIL.COM', '', 40101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(315, 'JAMBOREE S.R.L.', 'AV. JOSE BALTA NRO. 665 INT. 402 (4TO. PISO) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20103187002', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(316, 'MONTENEGRO TENORIO MARIO', '', '', '', 1, 2, '10336423681', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(317, 'AGRICOLA ALAYA SOCIEDAD ANONIMA CERRADA', 'AV. SANTA CRUZ NRO. 888 (PISO 4) LIMA - LIMA - MIRAFLORES', '', '', 1, 2, '20600750276', 1, 'MICORREO@MAIL.COM', '', 140115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(318, 'SERVICIOS GENERALES HERLEPARA', '', '', '', 1, 2, '10032187566', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(319, 'LIVA SOCIEDAD DE RESPONSABILIDAD LTDA.', 'CAL.LOS HORCONES MZA. O LOTE. 3 URB. LA CAPULLANA (ALTURA DE LA CUADRA 6 DE LOS VICUS) LIMA - LIMA - SANTIAGO DE SURCO', '', '', 1, 2, '20113676231', 1, 'MICORREO@MAIL.COM', '', 140130, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(320, 'GREGORIO GUEVARA JULCA', '', '', '', 1, 1, '27700070', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(321, 'MACO REYNOZA JOSE BALTAZAR', '', '', '', 1, 1, '17592420', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(322, 'EIBY FERNANDEZ GALINDO', '', '', '', 1, 1, '73022248', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(323, 'SANCHEZ SEMPERTEGUI REYNALDO', '', '', '', 1, 2, '10164941880', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(324, 'OSBALDO SIESQUEN BRAVO', '', '', '', 1, 1, '42584609', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(325, 'INVERSIONES EULER S.A.C.', 'CAR.CENTRAL NRO. 3080 INT. Y6 URB. INDUSTRIAL SANTA ROSA LIMA - LIMA - ATE', '', '', 1, 2, '20605164618', 1, 'MICORREO@MAIL.COM', '', 140103, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(326, 'INVERSIONES AGRICOLAS LA PAMPA DORADA S.R.L.', 'CAL.SAN PEDRO NRO. 629 PBLO.PAIJAN LA LIBERTAD - ASCOPE - PAIJAN', '', '', 1, 2, '20600299001', 1, 'MICORREO@MAIL.COM', '', 120806, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(327, 'ESTEVES MONTERO MANUEL MARTIN', '', '', '', 1, 2, '10192527631', 1, 'MANUELESTEVESMONTERO@GMAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(328, 'VILLARREAL TORRES EDDSSON GENARO', '', '', '', 1, 2, '10176317197', 1, 'GRUCOVI_OLMOS@HOTMAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(329, 'AGRICOLA SAN AGUSTIN EIRL', 'AV. DOS DE MAYO NRO 461 CENTRO', '', '', 1, 2, '20272085766', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(330, 'ELADIO ALVITRES OLANO', '', '', '', 1, 1, '19321893', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(331, 'AGRONEGOCIOS LA VIÑA FRUITS SOCIEDAD ANONIMA CERRADA', 'CAL. PALESTINA NRO 118 URB. MIRAFLORES', '', '', 1, 2, '20600696328', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(332, 'AGROINDUSTRIAL RACALI SOCIEDAD ANONIMA CERRADA', 'CAL. LOSSAUCES NRO 118 URB. SANTA VICTORIA', '', '', 1, 2, '20601097592', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(333, 'SERVICIOS GRALES SMP', 'AV. REPUBLICA DE CHILE NRO. 614 INT. 301 (ESPALDA CDRA 6 AV. ARENALES) LIMA - LIMA - JESUS MARIA', '', '', 1, 2, '20428865058', 1, 'MICORREO@MAIL.COM', '', 140133, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(334, 'SERVICIOS GENERALES LOS CHURRES S.A.C.', 'AV. ROOSEVELT NRO. 5527 DPTO. 206 BAR. BARRIO MEDICO LIMA - LIMA - SURQUILLO', '', '', 1, 2, '20492430227', 1, 'MICORREO@MAIL.COM', '', 140131, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(335, 'CAMPOS GUEVARA JUAN APARICIO', '', '', '', 1, 2, '10164886633', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(336, 'CESAR AUGUSTO DAVILA DIAZ', 'CHONGOYAPE', '', '', 1, 1, '16711259', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(337, 'EQ SOLUCIONES EMPRESARIALES S.A.C.', 'CAL.LOS SEMBRADORES NRO. 235 P.J. ENRIQUE LOPEZ ALBUJAR LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20604575681', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(338, 'SAUL BANCES CHAPOÑAN', '', '', '', 1, 1, '16744891', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(339, 'VEGA MERA ALEJANDRO', '', '', '', 1, 2, '10272460049', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(340, 'SAMUEL RABINES TERROES', '', '', '', 1, 1, '46288857', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(341, 'JUAN MORE INGA', '', '', '', 1, 1, '19323832', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(342, 'COLEGIO MEDICO DEL PERU', 'AV SALAVERRY 120', '', '', 1, 2, '20139589638', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(343, 'VASQUEZ CIEZA MARIA ROSA', '', '', '', 1, 2, '10174225830', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(344, 'RM PACKING & SERVICE SOCIEDAD ANONIMA CERRADA', 'CAL.LOS TULIPANES NRO. 188 INT. 503 (FRENTE A LA EMBAJADA DE USA) LIMA - LIMA - SANTIAGO DE SURCO', '', '', 1, 2, '20600847717', 1, 'MICORREO@MAIL.COM', '', 140130, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(345, 'JORGUE LUIS PORRAZ', '', '', '', 1, 1, '80479463', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(346, 'INTIPUNKU S.A.C.', 'CAL.COLONIAJE NRO. 132 URB. SAN CARLOS (FRENTE AL PARQUE) LAMBAYEQUE - CHICLAYO - JOSE LEONARDO ORTIZ', '', '', 1, 2, '20603676131', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(347, 'ESTELA CHAMAYA GUSTAVO', '', '', '', 1, 2, '10459422205', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(348, 'COORPORACION INDUSTRIAL RISIERY S.A.C.', 'JR. 24 DE JUNIO NRO. S/N (2 CUADRAS DEL PARQUE PRINCIPAL) CAJAMARCA - CHOTA - HUAMBOS', '', '', 1, 2, '20605302921', 1, 'MICORREO@MAIL.COM', '', 60608, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(349, 'SEGUNDO MORENO VIDAURRE', 'MOCHUMI', '', '', 1, 1, '17560543', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(350, 'BRAVO SILVA JOSE MISAEL', '', '', '', 1, 1, '27296144', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(351, 'FRAGAMI CORP EIRL', 'AV. UNIVERSITARIA NRO. 840 INT. 06 URB. PANDO ET. CUATRO LIMA - LIMA - SAN MIGUEL', '', '', 1, 2, '20522843921', 1, 'MICORREO@MAIL.COM', '', 140127, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(352, 'MARICRUZ DELGADO TELLO', '', '', '', 1, 1, '76851533', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(353, 'LATERCER S.A.C.', 'AV. LAS TORRES MZA. S-N LOTE. 27 (PARADERO PARAISO) LIMA - LIMA - LURIGANCHO', '', '', 1, 2, '20514134155', 1, 'MICORREO@MAIL.COM', '', 140112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(354, 'CHAVESTA RAMOS LUIS ROBERTO', '', '', '', 1, 1, '42945162', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(355, 'NORNBELL GARCIA GARCIA', '', 'BUENOS AIRES', '', 1, 1, '43155615', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(356, 'BENITES SOPLAPUCO JUAN', 'MOTUPE', '', '944300204', 1, 1, '17570846', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(357, 'SILVA GARCIA JORGE LUIS', 'AV. LOS TREBOLES 433 URB. MIRAFLORES - CHICLAYO', '', '', 1, 2, '10480868388', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(358, 'ISIDRO SOSA RAMIREZ', 'CARRETERA SAN JOSE', '', '', 1, 1, '16428903', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(359, 'TIRADO CASTILLO LUIS ANTERO', '', 'PACASMAYO', '', 1, 1, '8982889', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(360, 'CAMPOS RUIZ SEGUNDO', '', '', '', 1, 1, '19242855', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(361, 'MARIA MURRUGARRA BUENO', '', '', '', 1, 1, '44480837', 1, 'MICORREO@MAIL.COM', 'GUADALUPE', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(362, 'WENDY COTRINA', '', '', '', 1, 1, '45687062', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(363, 'HEBERT OYOLA AGUILAR', '', '', '', 1, 1, '17631225', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(364, 'CUBAS DIAZ ARIO HILDEBRANDO', '', '', '', 1, 2, '10272410041', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(365, 'COINSSA PERU S.A.C', 'MZA. A43 LOTE. 3A SEC. HUACA DE LOS CHINOS (CARRETERA CHICLAYO - CHOTA) LAMBAYEQUE - CHICLAYO - TUMAN', '', '', 1, 2, '20561190276', 1, 'MICORREO@MAIL.COM', '', 130120, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(366, 'JHON OTERO DAVILA', '', '', '', 1, 1, '73123515', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(367, 'SANTISTEBAN ACOSTA ALBERTO', '', '', '', 1, 2, '10174256786', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(368, 'FRANCO MENDOZA REQUEJO', '', '', '', 1, 1, '40769182', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(369, 'LUIS MIGUEL VILCHEZ VALERA', '', '', '', 1, 1, '76333886', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(370, 'AGENCIA DE COMUNICACION MEDIA S.R.L.', 'MZA. G LOTE 1 A.H. SAUL CANTORAL', '', '', 1, 2, '20600434005', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(371, 'JUAN QUIROZ LEIVA', '', '', '', 1, 1, '19215439', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(372, 'PERFORACIONES Y SERVICIOS GENERALES JB Y G SAC', 'CAL.ELIAS AGUIRRE NRO. 810 INT. B SEC. EL POTRERO LAMBAYEQUE - CHICLAYO - REQUE', '', '', 1, 2, '20539010931', 1, 'MICORREO@MAIL.COM', '', 130111, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(373, 'ATALAYA SAMPOS MARIA CELINDA', '', '', '', 1, 1, '44356867', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(374, 'CHIRINOS SANCHEZ ALEX', '', '', '', 1, 2, '10167825597', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(375, 'JOSE FELIBERTO DAMIAN ELIAS', '', '', '', 1, 1, '41973493', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(376, 'MARLENY ODAR HUANCAS', '', '', '', 1, 1, '3879614', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(377, 'SALATIEL MESTANZA MENDOZA', '', 'UDIMA', '', 1, 1, '16719479', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(378, 'MANUEL GUMERCINDO MENDOZA GUAYABAL', '', 'CHEPEN', '', 1, 1, '41883999', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(379, 'ELIS HERNADEZ PIÑIN VILLEGAS', '', 'SAPILLICA', '', 1, 1, '77276668', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(380, 'WALTER JORGUE CORREA CABRERA', '', '', '', 1, 1, '19220262', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(381, 'LUIS CHATILAN QUISPE', '', 'CAJAMARCA', '', 1, 1, '40080576', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(382, 'V & S INVERSIONES INC S.A.C.', 'MZA. B LOTE. 20 A.H. LOS JAZMINES (A UNA CDRA. HOSPEDAJE LOS JAZMINES) PIURA - PAITA - PAITA', '', '', 1, 2, '20604672318', 1, 'MICORREO@MAIL.COM', '', 190501, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(383, 'ROGEL PADILLA ALAYO', '', '', '', 1, 1, '27985482', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(384, 'HILARIO CORNEJO MECHAN', '', '', '', 1, 1, '16761966', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(385, 'AVILA RIVERA ISAURO', '', '', '', 1, 1, '3688515', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(386, 'JOSE VICENTE PAZ HERNANDEZ', '', '', '', 1, 1, '17544057', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(387, 'EUGENIA LOPEZ HURATDO', '', '', '', 1, 1, '16543218', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(388, 'MAURO GUEVARA CUBAS', '', '', '', 1, 1, '45526651', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(389, 'JOSE ELIS CALDERON ABANTO', '', '', '', 1, 1, '47142459', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(390, 'CONSORCIO INMOBILIARIO DEL NORTE SOCIEDAD ANONIMA CERRADA', 'CAL.SAN JOSE NRO. 531 INT. 302 LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20479846961', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(391, 'ELMER EUGENIO BRAVO FERNANDEZ', '', '', '', 1, 1, '45334922', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(392, 'MARIA MERCEDES JRS E.I.R.L.', 'CAL. LUIS MIROQUESADA NRO 172 DEP. 4 URB. PANDO', '', '', 1, 2, '20517485650', 1, 'MICORREO@MAIL.COM', '', 140127, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(393, 'CARLOS SUCLUPE MILLAN', '', '', '', 1, 1, '17524054', 1, 'MVILCHEZT@HOTMAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(394, 'E & E INSTALACIONES Y SERVICIOS NORTE SOCIEDAD COMERCIAL DE RESPONSABILIDAD LIMITADA', 'AV. ORIENTE NRO. 133 URB. SAN JUAN LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20601793912', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(395, 'SANTISTEBAN VIDAURRE JHONY PEDRO', 'MORROPE', '', '931742946', 1, 1, '46817331', 1, 'MICORREO@MAIL.COM', '', 130306, 0, '', 1, NULL, NULL, NULL, 0),
(396, 'AGRO INVERSIONES VALLESOL SOCIEDAD ANÓNIMA CERRADA.', 'CAL. PALESTINA NRO 118 URB. MIRAFLORES', '', '', 1, 2, '20487491439', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(397, 'CESAR CHANAME ZUTA', '', '', '', 1, 1, '42077691', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(398, 'JOSE MERCEDES SAAVEDRA SANCHEZ', '', '', '', 1, 1, '17576421', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(399, 'O & S OTERO SAC', 'MZA. U LOTE. 13 URB. SANTA MARGARITA LAMBAYEQUE - CHICLAYO - LA VICTORIA', '', '', 1, 2, '20539271149', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(400, 'CHUCUPE S.A.', 'AV. LUIS GONZALES NRO. 115 LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20103516341', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(401, 'MARCO ANTONIO ELIAS CORREA', '', '', '', 1, 1, '43596028', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(402, 'ASTOCHADO VILLOSLADA AVINAEL', '', '', '', 1, 1, '44636981', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(403, 'JOSE MANUAL VASQUEZ BANCES', '', 'CIUDAD DE DIOS', '976024726', 1, 1, '76814933', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(404, 'ELVIS SANTA MARIA CHOZO', '', '', '', 1, 1, '47511388', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(405, 'LUIS HUACAL RUIZ', '', '', '', 1, 1, '27568030', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(406, 'WILMER OMAR CENTURION MEDINA', '', '', '', 1, 1, '41578281', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(407, 'INVERSIONES BESA S.A.C', 'CAL.LOS PINOS MZA. B LOTE. 06 INT. 01 URB. SANTA TERESITA (CERCA AL COLEGIO SOR ANA DE LOS ANGELES) LAMBAYEQUE - LAMBAYEQUE - LAMBAYEQUE', '', '', 1, 2, '20604940291', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(408, 'AGROINDUSTRIAS EXPORTADORAS VIVEROS ORGANICOS NANCHOC & SERVICIOS E.I.R.L. - AEVONS E.I.R.L.', 'JR. JUNIN NRO 1155', '', '', 1, 2, '20604428506', 1, 'MICORREO@MAIL.COM', '', 60101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(409, 'MONTOYA VALERA WEIMAR GROBES', 'SANTA CLARA', '', '', 1, 1, '33668913', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(410, 'TORRES FLORINDEZ LIZBETH NAVRATILOVA', '', '', '', 1, 2, '10436688836', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(411, 'MANUEL BANCES CAJUSOL', '', '', '', 1, 1, '17403152', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(412, 'FITOSANIDAD PERU E.I.R.L.', 'MZA. L LOTE. 21 URB. VILLAS DEL NORTE LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20601671990', 1, 'JUAN.SOFT@HOTMAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(413, 'FERNANDO PIZARRO MACALOPU', '', 'FERREÑAFE', '985210369', 1, 1, '17446408', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(414, 'JOSE DE LA CRUZ LARIOS', '', 'PIMENTEL', '', 1, 1, '16634099', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(415, 'VICENTE SANTAMARIA CHAPOÑAN', '', '', '', 1, 1, '41786977', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(416, 'SANDOVAL PISCOYA JOSE JUAN', 'PACORA', '', '', 1, 1, '7560285', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(417, 'SANTOS RAMOS SEGUNDO RAMON', '', '', '', 1, 2, '10715760164', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(418, 'ROSA SANCHEZ ISLA', '', '', '', 1, 1, '19184951', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(419, 'MANUAL MANAYAY VILCABANA', '', '', '', 1, 1, '41644312', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(420, 'WILLIAM MARTINEZ PANTA', '', '', '', 1, 1, '17435813', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(421, 'WALTER MANUEL LEYVA YGNACIO', '', 'BOLIVAR SAN MIGUEL CAJAMARCA', '976240934', 1, 1, '43911417', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(422, 'AGRICOLA TIERRA RAJADA S.A.C.', 'CAL.TOMAS CHOCANO MZA. N LOTE. 5 URB. SMP -VILLA SOL 3E LIMA - LIMA - LOS OLIVOS', '', '', 1, 2, '20560198397', 1, 'MICORREO@MAIL.COM', '', 140142, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(423, 'BOZELT S.A.C', 'MZA. G LOTE. 23 ASOC LOS CLAVELES (ALT ENTRADA COLEGIO MIGUEL GRAU) LIMA - LIMA - LURIN', '', '', 1, 2, '20546891012', 1, 'MICORREO@MAIL.COM', '', 140113, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(424, 'EDWIN DE LA CRUZ MARIN', '', 'PACASMAYO', '942363683', 1, 1, '46793391', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(425, 'PEREZ DIAZ YUDIT', '', '', '', 1, 2, '10775422004', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(426, 'LUIS ALBERTO TUMES PANTA', '', '', '', 1, 1, '17623626', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(427, 'JUAN CARLOS MENOR DIAZ', '', '', '', 1, 1, '16798474', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(428, 'SEGUNDO MANUEL QUIROZ CRUZ', '', '', '', 1, 1, '27377845', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(429, 'ELMER DE LA CRUZ SANTAMARIA', '', '', '', 1, 1, '44239528', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(430, 'FRANCISCO VALDERA CHAPOÑAN', '', 'LAMBAYEQUE', '966206476', 1, 1, '40066980', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(431, 'MAURO MAXIMO LOPEZ JARA', '', 'CAJAMARCA', '949416333', 1, 1, '16407240', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(432, 'VENTURA OLIVOS JOSE HEBERT', '', '', '', 1, 2, '10445822553', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(433, 'VALDERS COBEÑAS JULIO CESAR', '', '', '', 1, 1, '45588308', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(434, 'ANA MARIBEL ASENJO CORNEJO', '', '', '', 1, 1, '40227209', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(435, 'GENARO ACOSTA CORONADO', '', 'MUY FINCA PUNTO 9', '', 1, 1, '17527306', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(436, 'EL ALAMO VERDE AGROPECUARIA S.A.C.', '----EDIFICIO NRO. 04 DPTO. 102 C.H. FONAVI II (A 200 MTS DE SUNAT) CAJAMARCA - CAJAMARCA - CAJAMARCA', '', '', 1, 2, '20604764018', 1, 'MICORREO@MAIL.COM', '', 60101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(437, 'GEREMIAS ROMERO LINGAN', '', 'CHEPEN', '', 1, 1, '27961934', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(438, 'HERNAN RAMOS BUSTAMANTE', '', '', '', 1, 1, '27408777', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(439, 'LUSMILA MORALES PAUCAR', '', '', '', 1, 1, '44207445', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(440, 'LUIS ALBERTO CHAVEZ DIAZ', '', '', '', 1, 1, '46587033', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(441, 'LUIS ORLANDO LLONTOP LLONTOP', '', '', '', 1, 1, '16778060', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(442, 'ELMER DIAZ SANTA MARIA', '', '', '', 1, 1, '41910643', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(443, 'PILADORA NUEVO HORIZONTE SOCIEDAD ANONIMA CERRADA', 'CAL.PROLONGACION MIGUEL GRAU KM. 2.5 (CARRETERA MONSEFU) LAMBAYEQUE - CHICLAYO - LA VICTORIA', '', '', 1, 2, '20480409346', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(444, 'SANTISTEBAN SANTISTEBAN JUAN', '', 'LAMBAYEQUE', '944632898', 1, 1, '42531817', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(445, 'FRANCISCO  SANCHEZ PORTAL', '', '', '', 1, 1, '40158066', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(446, 'DAVID JUNIOR MANRIQUE LITANO', '', '', '', 1, 1, '47525675', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(447, 'WILMER VASQUEZ LOZADA', '', '', '', 1, 1, '44278244', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(448, 'JOSE MIGUEL RAMON GONZALES', '', '', '', 1, 1, '45933362', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(449, 'BALTAZAR PISFIL CUSTODIO', '', '', '', 1, 1, '16679988', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(450, 'JUAN SANTA MARIA SANDOVAL', '', '', '', 1, 1, '17616186', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(451, 'ELEODORO SANTISTEBAN QUIROZ', '', 'MOCHUMI', '929975200', 1, 1, '17523639', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(452, 'CAPUÑAY PISFIL OSCAR', '', '', '', 1, 2, '10166287567', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(453, 'MEDINA', '', '', '', 1, 1, '16729300', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(454, 'JOSE MORA VELASQUEZ', '', '', '', 1, 1, '16798907', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(455, 'FRANCISCO SANCHES PUICON', '', '', '', 1, 1, '16766221', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(456, 'ELMER RAMIREZ CALLE', '', 'CHULUCANAS', '975050136', 1, 1, '32543499', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(457, 'GILMER PRADO MONDRAGON', '', 'PERICO SAN IGNACIO', '915967605', 1, 1, '16705949', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(458, 'COLEGIO MANUEL PARDO', 'AV. S. LUIS GONZALES NRO. 1415 CERCADO LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20103416982', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(459, 'ALADINO MORI CENTURION', '', '', '', 1, 1, '834549', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(460, 'LUIS ORLANDO CIESQUEN SANCHEZ', '', 'MOCHUMI', '996239376', 1, 1, '17623989', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(461, 'VICENTE FARRO RAMOS', '', 'HUAMANTANGA', '927646406', 1, 1, '16739220', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(462, 'LUIS ALBERTO VASQUEZ MONTAÑO', '', 'MOCHUMI PUEBLO NUEVO', '917905425', 1, 1, '8557570', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(463, 'RODAS CABANILLAS MARIO ENIN', '', 'BOLIVAR', '973033180', 1, 1, '27991703', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(464, 'PEDRO CORONADO BANCES', '', 'LAMBAYEQUE', '947697057', 1, 1, '42559717', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(465, 'CATALINA LOPEZ FERNANDEZ', '', '', '', 1, 1, '47090804', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(466, 'LLAGIENDO SANTOS JOSE VIRGILIO', '', '', '', 1, 1, '16675643', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(467, 'VICENTE JULCA MENDOZA', '', 'CATACHE  UDIMA', '939192259', 1, 1, '16595550', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(468, 'JOSE DEL CARMEN GOMEZ MONJA', '', '', '', 1, 1, '80521185', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(469, 'ANDREZ VILLEGAS GUEANILO', '', 'LAMBAYEQUE', '927711858', 1, 1, '33569307', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(470, 'GRIFO TOBI EIRL', 'CAL.CHINCHAYSUYO NRO. 190 (INGRESANDO A MORROPE) LAMBAYEQUE - LAMBAYEQUE - MORROPE', '', '', 1, 2, '20352931323', 1, 'MICORREO@MAIL.COM', '', 130306, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(471, 'MANUEL DE LA CRUZ ACOSTA BANCES', '', '', '', 1, 1, '16441379', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(472, 'LORENZO SECLEN NIQUEN', '', '', '', 1, 1, '17526723', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(473, 'JOSE GONZALO SUCLUPE YAMPUPE', '', 'FERREÑAFE', '929678064', 1, 1, '47210102', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(474, 'ANTONY QUIROZ SERNAQUE', '', '', '', 1, 1, '16471813', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(475, 'CESAR BANCES MINBELA', '', 'TUCUME', '', 1, 1, '80584696', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(476, 'CARLOS ALBERTO SANDOVAL SIESQUEN', '', '', '', 1, 1, '17628942', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(477, 'DISTRIBUIDORA NORTE PACASMAYO SRL', 'CAL.LA COLONIA NRO. 150 URB. EL VIVERO LIMA - LIMA - SANTIAGO DE SURCO', '', '', 1, 2, '20131644524', 1, 'MICORREO@MAIL.COM', '', 140130, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(478, 'EDGAR CHAPOÑAN FERNADEZ', '', 'MOCHUMI', '960388507', 1, 1, '42941261', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(479, 'MIRIAN ESPERANZA CESPEDES BARRETO', '', '', '', 1, 1, '17557263', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(480, 'ELMER JULCA SUXE', '', '', '', 1, 1, '41146235', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(481, 'CORPORACION NEBUSI S.A.C.', 'CAL.ARISTIDES SOLOGUREN NRO. 110A URB. VILLA SOL ET. CUATRO LIMA - LIMA - LOS OLIVOS', '', '', 1, 2, '20570860098', 1, 'MICORREO@MAIL.COM', '', 140142, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(482, 'JOSE PAIVA VALDIVIESO', '', '', '', 1, 1, '44638844', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(483, 'SANTISTEBAN BANCES RICARDO', '', '', '', 1, 1, '17547223', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(484, 'WILIAN DIAZ GUEVARA', '', 'FERREÑAFE', '983810537', 1, 1, '75983499', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(485, 'JESUS SANCHEZ PERALEZ', '', 'MUYFINCA MOCHUMI', '958401635', 1, 1, '16769141', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(486, 'CHERO PECHE PEDRO', '', '', '', 1, 1, '17523560', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(487, 'NIÑO DAMIAN VICTOR', '', '', '', 1, 2, '10002012702', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(488, 'MARIA DORISA BUSTAMANTE DIAZ', '', 'MOCHUMI', '978951176', 1, 1, '16722959', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(489, 'GEINER PAISIG', '', '', '', 1, 1, '44132854', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(490, 'CARLOS MORALES OLIVA', '', '', '', 1, 1, '16571405', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(491, 'ELEODORO MEJIA CAMPOS', '', 'CHACUPE', '944612084', 1, 1, '43001596', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(492, 'ARANDA GOMEZ JULIO MANUEL', '', 'PAIJAN', '948951951', 1, 2, '10180678315', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'NO HABIDO<', 1, NULL, NULL, NULL, 0),
(493, 'AGRICOLA INVERAGRO S.A.C.', 'JR. SACSAHUAMAN NRO 180', '', '', 1, 2, '20601964261', 1, 'MICORREO@MAIL.COM', '', 10312, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(494, 'HIPOLITO CORONADO PURISACA', '', 'MOCHUMI', '973818467', 1, 1, '17556547', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(495, 'JOSE CHAPOÑAN SANDOVAL', '', 'MOCUPE', '', 1, 1, '10376148', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(496, 'JOSE PEDRO ALGELES RUIZ', '', '', '', 1, 1, '45188258', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(497, 'VELA DE LA CRUZ JORGE JAVIER', '', '', '', 1, 2, '10175442419', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(498, 'YERSON RAUL NIQUEN CHAPILLIQUEN', '', 'LAMBAYEQUE', '954690779', 1, 1, '74769183', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(499, 'HUMBERTO SUCLUPE BALLENA', '', 'MORROPE', '928215297', 1, 1, '41784612', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(500, 'AGUSTIN SECLEN SANTISTEBAN', '', 'MOCHUMI MUY FINCA', '998160718', 1, 1, '42432912', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(501, 'MIÑOPE CAICEDO MIGUEL ANGEL', '', 'CHACUPE', '958620697', 1, 1, '43632107', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(502, 'AGRO INDUSTRIAS ELIZONDO S.A.C.', 'CAL. LOS DIAMANTES NRO 168 URB. PATAZCA', '', '', 1, 2, '20479928852', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(503, 'ANASTACIO QUICIO RIOS', '', 'CIUDAD DE DIOS FUNDO HUABAL', '979204939', 1, 1, '16710615', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(504, 'HENRRY SANDOVAL VIDAURRE', '', 'MOCHUMI', '956624490', 1, 1, '71529734', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(505, 'VARGAS CERCADO APOLINAR MENELO', '', '', '', 1, 1, '43414070', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(506, 'NOVOA HONORIO SANTOS GERMAN', '', '', '', 1, 2, '10279253669', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(507, 'JOSE SANTIAGO LLANOS AGAPITO', '', 'FERREÑAFE', '916523687', 1, 1, '17446786', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(508, 'ROSENDO VIDAURRE MORALES', '', 'TUCUME POSITOS', '925343942', 1, 1, '17608178', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(509, 'GRUPO ERCRUZ SOCIEDAD COMERCIAL DE RESPONSABILIDAD LIMITADA', 'AV. AUGUSTO B LEGUIA NRO. 2035 P.J. LUIS HEYSEN LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20603265816', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(510, 'SEMILLAS AMANECER E.I.R.L.', 'CAL.VICTORIA REQUEJO MZA. B LOTE. 9 URB. ALTO PERU LAMBAYEQUE - FERREÑAFE - FERREÑAFE', '', '', 1, 2, '20605808337', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(511, 'SEGUNDO RENAN VILLEGAS MONTALVO', '', 'CONCHUCOS', '968516920', 1, 1, '45132807', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(512, 'MAXIMO REYES BARRIOS', '', 'OLMOS', '986007165', 1, 1, '42377517', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(513, 'TERAN TERRONES LASTENIA', '', '', '', 1, 2, '10415896200', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(514, 'FUENTES AGROINDUSTRIALES S.A.C.', 'CAL.LOS JACARANDAS NRO. 441 URB. SANTA VICTORIA LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20605189823', 1, 'EFUENTESO097@GMAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(515, 'SANTOS CHAPOÑAN SANTAMARIA', '', 'TUCUME POSITOS', '900803061', 1, 1, '17564245', 1, 'MICORREO@MAIL.COM', '', 130312, 0, '', 1, NULL, NULL, NULL, 0),
(516, 'DAVILA CARRASCO KALY ELIZABETH', '', '', '978251384', 1, 1, '42911246', 1, 'MICORREO@MAIL.COM', '', 130102, 0, '', 1, NULL, NULL, NULL, 0),
(517, 'LLUEN CORNEJO WALTER', '', '', '', 1, 2, '10167651521', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(518, 'VENTURA SANCHEZ JUAN CARLOS', '', 'REYNOZA', '942061238', 1, 1, '41324095', 1, 'MICORREO@MAIL.COM', '', 130312, 0, '', 1, NULL, NULL, NULL, 0),
(519, 'JOBINO PURIHUAMAN VILCABANA', '', 'TAYAPAMPA', '974511170', 1, 1, '17417550', 1, 'MICORREO@MAIL.COM', '', 130202, 0, '', 1, NULL, NULL, NULL, 0),
(520, 'PURIHUAMAN VILCABANA JOBINO', '', '', '', 1, 2, '10174175506', 1, 'MICORREO@MAIL.COM', '', 130202, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(521, 'GERONIMO TERRONES AREVALO', '', 'CORRAL DE PALOS', '998545643', 1, 1, '16608907', 1, 'MICORREO@MAIL.COM', '', 130116, 0, '', 1, NULL, NULL, NULL, 0),
(522, 'INGRID CRISEET GOICOCHEA REQUEJO', '', '', '941543211', 1, 1, '71532445', 1, 'MICORREO@MAIL.COM', 'CULTIVO PALTO', 60902, 0, '', 1, NULL, NULL, NULL, 0),
(523, 'ORLANDO IPANAQUE SANPEN', '', 'FUNDO EL HIGO', '939246835', 1, 1, '41493711', 1, 'MICORREO@MAIL.COM', '', 130110, 0, '', 1, NULL, NULL, NULL, 0),
(524, 'JOSELITO VILLANUEVA GONZALES', '', 'FALA', '978174969', 1, 1, '17640839', 1, 'MICORREO@MAIL.COM', '', 130201, 0, '', 1, NULL, NULL, NULL, 0),
(525, 'VICENTE VALDERA INOÑAN', '', 'TRANCA FALUPE', '', 1, 1, '17626270', 1, 'MICORREO@MAIL.COM', '', 130312, 0, '', 1, NULL, NULL, NULL, 0),
(526, 'JOSE MANUEL GOMEZ MORAN', '', 'LOS BANCES', '', 1, 1, '17602951', 1, 'MICORREO@MAIL.COM', '', 130312, 0, '', 1, NULL, NULL, NULL, 0),
(527, 'LORENZO SANTISTEBAN LLAUCE', '', '', '999982298', 1, 1, '17557886', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(528, 'SOPLAPUCO PURIZACA NATIVIDAD', '', '', '', 1, 1, '17570897', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(529, 'CARLOS SANDOVAL', '', '', '', 1, 1, '16729429', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(530, 'LUIS ROJAS MENDOZA', '', '', '', 1, 1, '97432990', 1, 'MICORREO@MAIL.COM', '', 130204, 0, '', 1, NULL, NULL, NULL, 0),
(531, 'MARGARITA PARRAGUEZ VILCHEZ', '', '', '', 1, 1, '8847622', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(532, 'PABLE VELASQUEZ QUESQUEN', '', '', '', 1, 1, '16517142', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(533, 'LUIS TUÑOQUE CHOZO', '', '', '', 1, 1, '77430816', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(534, 'MANUEL ASUNCION MIL', '', '', '', 1, 1, '16413344', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(535, 'VICTOR SANTA MARIA SANDOVAL', '', '', '', 1, 1, '76972557', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(536, 'JUAN VIDAURRE SANDOVAL', '', '', '', 1, 1, '17634170', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(537, 'JAIME HUAMAN ROMERO', '', '', '', 1, 1, '48182030', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(538, 'ROBERTO CADENILLAS DELGADO', '', '', '', 1, 1, '27438643', 1, 'MICORREO@MAIL.COM', '', 130201, 0, '', 1, NULL, NULL, NULL, 0),
(539, 'MANUEL BANCES', '', '', '', 1, 1, '42437135', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(540, 'MARIO DARWIN SANCHEZ FLORES', '', '', '', 1, 1, '77034663', 1, 'MICORREO@MAIL.COM', '', 130204, 0, '', 1, NULL, NULL, NULL, 0),
(541, 'JULIO ADIAS SALAZAR VIDAURRE', '', '', '', 1, 1, '45643799', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(542, 'JOSE ANTONIO GONZALES GARCIA', '', '', '', 1, 1, '77390824', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(543, 'FELIX SANCHEZ SUARES', '', '', '', 1, 1, '27260036', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(544, 'HEINER AVELLANEDA QUISPE', '', '', '989768145', 1, 1, '80589245', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(545, 'EPIFANIO MENOR FERNADEZ', '', '', '99097208', 1, 1, '80432855', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(546, 'ISAIAS  GALINDO ROJAS', '', '', '967548838', 1, 1, '43914747', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(547, 'GAVINO ASTOCHADO VILLOSLADA', '', '', '', 1, 1, '41990520', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(548, 'AGUSTIN CORONADO VENTURA', '', '', '', 1, 1, '10694880', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(549, 'JUAQUIN PAZ LOZANO', '', '', '961302982', 1, 1, '43189188', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(550, 'ERNESTO CHANAME FERNANDEZ', '', '', '19242715', 1, 1, '19242712', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(551, 'PERUANA DEL ARROZ S.A.C', 'CAL.7 DE ENERO NRO. 867 INT. 202 CERCADO DE CHICLAYO (PUERTA DE REJAS AZULES) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20487768333', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(552, 'EDGARDO SILVA PAIVA', '', '', '935418513', 1, 1, '41352608', 1, 'MICORREO@MAIL.COM', '', 190101, 0, '', 1, NULL, NULL, NULL, 0),
(553, 'ELIGIO CARRERA URIOL', '', '', '', 1, 1, '47959868', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(554, 'ALBERTO REYES', '', '', '', 1, 1, '44133648', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(555, 'IPANAQUE CAPUÑAY DANIEL', '', '', '', 1, 1, '16593113', 1, 'MICORREO@MAIL.COM', '', 130110, 0, '', 1, NULL, NULL, NULL, 0),
(556, 'VICENTE CUSTODIO LAINES', '', '', '', 1, 1, '16555619', 1, 'MICORREO@MAIL.COM', '', 130304, 0, '', 1, NULL, NULL, NULL, 0),
(557, 'LUIS ALBERTO ACOSTA VENTURA', '', '', '', 1, 1, '41202890', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(558, 'GRANOS Y CEREALES S.A.C.', 'MZA. Q LOTE. 9 URB. LA PARADA LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20487601714', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(559, 'ALADINO MENA OCHOA', '', '', '979642190', 1, 3, '41684418', 1, 'MICORREO@MAIL.COM', '', 130102, 0, '', 1, NULL, NULL, NULL, 0),
(560, 'COMERCIALIZADORA EXPORTADORA INBC SRL', 'CAL.LAS GARDENIAS NRO. 164 DPTO. 401 URB. VALLE HERMOSO DE MONTERRICO (164-168-172 CERCA A COLEG LAS CASUARINAS) LIMA - LIMA - SANTIAGO DE SURCO', '', '', 1, 2, '20480109971', 1, 'MICORREO@MAIL.COM', '', 140130, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(561, 'ASEL INGENIEROS SRLTDA.', 'NRO. F Z.I. ZONA IND II ETAPA (ESPALDA CLUB DE TIRO DE PIURA) PIURA - PIURA - PIURA', '', '', 1, 2, '20398211414', 1, 'MICORREO@MAIL.COM', '', 190101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(562, 'FUNDO AGRICOLA SANTA ELENA E.I.R.L', 'AV. BALTA NRO. 370 INT. 301 (OFICINA) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20314112114', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(563, 'LEVI PERES GUEVARA', '', '', '', 1, 1, '33827548', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(564, 'ELIDER CHAVAR MENDOZA', '', 'TALAMBO', '983087579', 1, 1, '46195979', 1, 'MICORREO@MAIL.COM', '', 120901, 0, '', 1, NULL, NULL, NULL, 0),
(565, 'GARCIA IDROGO LAURIANO', '', '', '', 1, 2, '10266418898', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(566, 'ALFREDO JAVIER CORNEJO PISFIL', '', '', '948653639', 1, 1, '42811759', 1, 'MICORREO@MAIL.COM', '', 130106, 0, '', 1, NULL, NULL, NULL, 0),
(567, 'FRANCISCO CHAVEZ SANDOVAL', '', '', '995744489', 1, 1, '16593194', 1, 'MICORREO@MAIL.COM', 'ARROZ', 130312, 0, '', 1, NULL, NULL, NULL, 0),
(568, 'WILMER CUBAS VILLALOBOS', '', '', '943437219', 1, 1, '80626130', 1, 'MICORREO@MAIL.COM', '', 60614, 0, '', 1, NULL, NULL, NULL, 0),
(569, 'LUIS CASTILLO CENTURION', '', '', '', 1, 1, '16445224', 1, 'MICORREO@MAIL.COM', '', 130115, 0, '', 1, NULL, NULL, NULL, 0),
(570, 'NEMECIO DE LA CRUZ SANTAMARIA', '', '', '958458569', 1, 1, '17599704', 1, 'MICORREO@MAIL.COM', '', 130312, 0, '', 1, NULL, NULL, NULL, 0),
(571, 'SANDOVAL MORALES ROMAN ELIVORIO', '', '', '', 1, 2, '10085351147', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(572, 'LUIS ALBERTO MORENO INOÑAN', '', '', '', 1, 1, '2846947', 1, 'MICORREO@MAIL.COM', '', 190601, 0, '', 1, NULL, NULL, NULL, 0),
(573, 'SOCIEDAD AGRICOLA MARIA AUXILIADORA SOCIEDAD ANONIMA CERRADA', 'CAR.PANAMERICANA ANTIGUA KM. 90 FND. MARIA AUXILIADORA LAMBAYEQUE - LAMBAYEQUE - OLMOS', '', '', 1, 2, '20602196829', 1, 'MICORREO@MAIL.COM', '', 130308, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(574, 'AUGUSTO HURTADO DELGADO', '', '', '927921326', 1, 1, '41313973', 1, 'MICORREO@MAIL.COM', '', 130114, 0, '', 1, NULL, NULL, NULL, 0),
(575, 'AGRONORTE DEL PERU SOCIEDAD ANONIMA CERRADA', 'CAL.LOS ALISOS MZA. L1 LOTE. 20 C.P. VILLA HERMOSA 6 ETAPA LAMBAYEQUE - CHICLAYO - JOSE LEONARDO ORTIZ', '', '', 1, 2, '20600445759', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(576, 'FLORES PEREZ MARIA DOMITILA', '', '', '', 1, 2, '10411058749', 1, 'MICORREO@MAIL.COM', '', 130102, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(577, 'ASERRADERO EL ARBOLITO SOCIEDAD ANONIMA CERRADA', 'CAL.HUASCAR NRO. 1047 P.J. URRUNAGA LAMBAYEQUE - CHICLAYO - JOSE LEONARDO ORTIZ', '', '', 1, 2, '20480747748', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(578, 'MELENDRES VELASCO EDILBERTO MANASES', '', '', '', 1, 2, '10032405679', 1, 'MICORREO@MAIL.COM', '', 190101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(579, 'ACOSTA FARRO EMILIO', '', 'SIAPULE BAJO', '924663570', 1, 1, '17531394', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(580, 'ANIVAL ZULOETA FERNANDEZ', '', '', '927910764', 1, 1, '33575271', 1, 'MICORREO@MAIL.COM', '', 10203, 0, '', 1, NULL, NULL, NULL, 0),
(581, 'HALEMA S.A.C.', 'AV. VIRREY CONDE DE LEMOS NRO. 231 URB. LA COLONIAL PROV. CONST. DEL CALLAO - PROV. CONST. DEL CALLAO - CALLAO', '', '', 1, 2, '20123316658', 1, 'MICORREO@MAIL.COM', '', 240101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(582, 'WALTER SERNA RODRIGUEZ', '', 'CAPOTE', '929884852', 1, 1, '16684975', 1, 'MICORREO@MAIL.COM', '', 130109, 0, '', 1, NULL, NULL, NULL, 0),
(583, 'FAMILY FOODS S.A.C.', 'AV. MARISCAL NIETO NRO. 480 INT. 14 URB. CAMPODONICO (BLOCK A - 3 ER PISO) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20604176884', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(584, 'RIVERA MALACATOS VICTOR RAUL', '', '', '', 1, 2, '10031289586', 1, 'MICORREO@MAIL.COM', '', 190101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(585, 'CORREA WAN WILDER ENRIQUE', '', '', '', 1, 2, '10176126014', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(586, 'ECO AGRICOLA OLMOS SOCIEDAD ANONIMA CERRADA', 'CAL.ALFONSO UGARTE NRO. 812 (TERCER PISO) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20487544141', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(587, 'DANPER AGRICOLA LA VENTUROSA S.A.C.', 'CAR.INDUSTRIAL A LAREDO NRO. S/N FND. BARRIO NUEVO (A150 MTS OVALO LA MARINA CAMINO A LAREDO) LA LIBERTAD - TRUJILLO - MOCHE', '', '', 1, 2, '20477542833', 1, 'MICORREO@MAIL.COM', '', 60616, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(588, 'DANPER AGRICOLA OLMOS S.A.C.', 'CAR.INDUSTRIAL A LAREDO NRO. S/N FND. BARRIO NUEVO (A150 MTS OVALO LA MARINA CAMINO A LAREDO) LA LIBERTAD - TRUJILLO - MOCHE', '', '', 1, 2, '20539927494', 1, 'MICORREO@MAIL.COM', '', 60616, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(589, 'XIMENA VARGAS LEGUA', '', '', '', 1, 1, '71048735', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(590, 'MUNICIP. PROVINCIAL DE FERREÑAFE', 'CAL.NICANOR CARMONA NRO. 436 CENTRO (EN EL PARQUE CENTRAL) LAMBAYEQUE - FERREÑAFE - FERREÑAFE', '', '', 1, 2, '20162368452', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(591, 'E.C.L. SERVICIOS GENERALES DAYNOR E.I.R.L', 'MZA. 193 LOTE. 10-A INT. 1 OTR. CENTRO LAMBAYEQUE - CHICLAYO - TUMAN', '', '', 1, 2, '20601669561', 1, 'MICORREO@MAIL.COM', '', 130120, 0, 'NO HABIDO<', 1, NULL, NULL, NULL, 0),
(592, 'GRUPO MOLINERO CONTRERAS ASTORAYME SAC', 'CAR.A MOCCE CADAP NRO. S/N INT. E C.P. CPME LAMBAYEQUE (ANTES DEL PEAJE A MOCCE) LAMBAYEQUE - LAMBAYEQUE - LAMBAYEQUE', '', '', 1, 2, '20538986292', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(593, 'CORTE SUPERIOR DE JUSTICIA DE LAMBAYEQUE', 'CAL.SAN JOSE NRO. 1070 CERCADO LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20487872319', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(594, 'MUNICIPALIDAD DISTRITAL DE TUMAN', 'AV. EL TREN NRO. S/N (EX CUNA MATERNAL-PARTE JUBILADO) LAMBAYEQUE - CHICLAYO - TUMAN', '', '', 1, 2, '20396073791', 1, 'MICORREO@MAIL.COM', '', 130120, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(595, 'CLINICA DEL PACIFICO S.A.', 'AV. JOSE LEONARDO ORTIZ NRO. 420 URB. CERCADO DE CHICLAYO LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20103269319', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(596, 'DELCOR FABRICACIONES SAC', 'CAL.YURIMAGUAS NRO. 180 INT. 201 URB. CHICLAYO LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20480606176', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(597, '2R SERVICIOS Y CONSTRUCCION S.A.C.', 'CAL. AGRICULTURA NRO 915 P.J. MARIA PARADO DE BELLIDO', '', '', 1, 2, '20605907432', 1, 'JUAN.SOFT@HOTMAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(598, 'CALDERON BERNILLA FLORENTINO NICANOR', '', '', '', 1, 2, '10004614696', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(599, 'CENTRO DEL RIÑON DEL NORTE SOCIEDAD ANONIMA CERRADA', 'CAL.FRANCISCO CABRERA NRO. 1400 CENTRO DE CHICLAYO SUAZO LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20561197874', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(600, 'ITNOVATE S.R.L.', 'CAL.EDEN NRO. 168 URB. EL PARAISO (A ESPALDAS DEL CEMENTERIO EL CARMEN) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20600022360', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(601, 'H2OLMOS S.A.', 'AV. VICTOR ANDRES BELAUNDE NRO. 280 INT. 403 URB. EL ROSARIO LIMA - LIMA - SAN ISIDRO', '', '', 1, 2, '20523611250', 1, 'MFARIAS@H2CTO.COM', '', 140124, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(602, 'SAN ANTONIO TRADE SOCIEDAD ANONIMA CERRADA', 'AV. GRAU 275', '', '', 1, 2, '20480230451', 1, 'IVAN.MENDOZA@GSA.COM.PE', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(603, 'ESTACION BOLOGNESI S.R.LTDA', 'AV CIRCUNVALACION 160 PIURA -PIURA-PIURA', '', '', 1, 2, '20347237028', 1, 'MICORREO@MAIL.COM', '', 190101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(604, 'FEMISALUD SRL', 'CAL.7 DE ENERO NRO. 462 CERCADO DE CHICLAYO LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20479840769', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(605, 'GERENCIA REGIONAL DE SALUD', 'AV. SALAVERRY NRO. 1610 URB. QUINONEZ LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20163833094', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0);
INSERT INTO `cliente` (`codigo_cli`, `nombre_cli`, `direccion_cli`, `ciudad_cli`, `telefono_cli`, `codigo_tip`, `codigo_doc`, `numero_doc`, `codigo_szo`, `email_cli`, `observacion_cli`, `codigo_dis`, `estadosunat_cli`, `condicionsunat_cli`, `estado_cli`, `usuario_reg`, `usuario_mod`, `fecha_mod`, `sistema`) VALUES
(606, 'INVERSIONES MUYA S.A.C.', 'AV. MONTE BLANCO NRO. 305 URB. RINCONADA ALTA ET. DOS LIMA - LIMA - LA MOLINA', '', '', 1, 2, '20555348887', 1, 'MICORREO@MAIL.COM', '', 140110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(607, 'INDUSTRIAL PUCALA S.A.C.', 'AV. PIONEROS DE ROCHDALE NRO. S/N LAMBAYEQUE - CHICLAYO - PUCALA', '', '', 1, 2, '20437281646', 1, 'MICORREO@MAIL.COM', '', 130119, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(608, 'VEOLIA SERVICIOS PERU S.A.C.', 'CAL.ELIAS AGUIRRE NRO. 605 INT. 1001 (1 CUADRA DE LA HUACA PUCLLANA) LIMA - LIMA - MIRAFLORES', '', '', 1, 2, '20519176263', 1, 'MICORREO@MAIL.COM', '', 140115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(609, 'MUNICIPALIDAD DISTRITAL DE TOCMOCHE', 'CAL.18 DE SETIEMBRE NRO. S/N CERCADO (PLAZA DE ARMAS) CAJAMARCA - CHOTA - TOCMOCHE', '', '', 1, 2, '20180961705', 1, 'MICORREO@MAIL.COM', '', 60616, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(610, 'DISTRIBUIDORA ALIMENTOS DEL VALLE S.A.C.', 'AV. JUAN PABLO II NRO. 385 DPTO. 301 LA LIBERTAD - TRUJILLO - TRUJILLO', '', '', 1, 2, '20600416155', 1, 'MICORREO@MAIL.COM', '', 120101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(611, 'MIRANDA COLLAZOS RICARDO DAVID', 'LOS PINOS 245 SANTA VICTORIA', '', '', 1, 2, '10167334747', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(612, 'CONCESIONARIA TRASVASE OLMOS S.A.', 'AV. VICTOR ANDRES BELAUNDE NRO. 280 INT. 403 URB. EL ROSARIO LIMA - LIMA - SAN ISIDRO', '', '', 1, 2, '20509093521', 1, 'MFARIAS@H2CTO.COM', '', 140124, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(613, 'DISTRIBUIDORA BMC S.A.C.', 'CAL.ALMENDRAS MZA. C LOTE. 12 URB. LA ARBOLEDA LA LIBERTAD - TRUJILLO - TRUJILLO', '', '', 1, 2, '20605138277', 1, 'MICORREO@MAIL.COM', '', 120101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(614, 'PERAMAS SANCHEZ JUAN CARLOS', '', '', '', 1, 2, '10166894315', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(615, '& SOMOS 365 S.A.C.', 'CAL.JOSE PARDO NRO. 130 (2 PISO) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20539186389', 1, 'JUAN.SOFT@HOTMAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(616, 'SERVICENTRO LIBERTAD SAC.', 'AV. GONZALO UGAZ SALCEDO NRO. 09 SEC. CERCADO (FRENTE AL OVALO PACASMAYO) LA LIBERTAD - PACASMAYO - PACASMAYO', '', '', 1, 2, '20482018140', 1, 'MICORREO@MAIL.COM', '', 120506, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(617, 'GRIFO SAN ANTONIO E.I.R.LTDA.', 'AV PANAMERICANA NORTE KM 3', '', '', 1, 2, '20270382551', 1, 'LUCIANA.HOYOS@GSA.COMM.PE', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(618, 'JUNTA DE PROPIETARIOS DEL CONDOMINIO LOS PARQUES DE SAN GABRIEL', 'AV. BELAUNDE CON ESQUINA AV PROGRESO -REMIGIO SILVA NRO. 100 DPTO. 803 INT. T 07 CND. LOS PARQUES DE SAN GABRIEL (TORRE6-DPTO403,TOR04-DPTO102,TO3-DPTO303) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20601390621', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(619, 'MEGA GAS S.A.C', 'JR. LOS GALLOS MZA. E LOTE. 13 (LAS PRADERAS DE LURIN-ZONA INDUSTRIAL) LIMA - LIMA - LURIN', '', '', 1, 2, '20507312277', 1, 'MICORREO@MAIL.COM', '', 140113, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(620, 'HARPER INGENIEROS S.A.C', 'CAL.12 DE OCTUBRE NRO. 225 (CUADRA 4 DE LA AV. DE LA MANUEL SEOANE) LAMBAYEQUE - CHICLAYO - LA VICTORIA', '', '', 1, 2, '20487625656', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(621, 'CONTROL AUTOMATION E.I.R.L.', 'CAL.TUPAC INCA YUPANQUI NRO. 1943 URB. EL TREBOL ET. CUATRO LIMA - LIMA - LOS OLIVOS', '', '', 1, 2, '20392889231', 1, 'CARLOS.CHICOMA@AUTOCONPERU.COM', '', 140142, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(622, 'HEREDIA OBLITAS DENNYS HELI', '', '', '', 1, 2, '10464240964', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(623, 'MOLINO SAN FERNANDO S.R.L.', 'CAR.PANAMERICANA NORTE NRO. 778 (KM. 778.5 - FRENTE A MOLINERA TROPICAL) LAMBAYEQUE - LAMBAYEQUE - LAMBAYEQUE', '', '', 1, 2, '20479364207', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(624, 'PROMOTORA M & M S.R.L.', 'CAL.PAUL HARRIS NRO. 1760 LAMBAYEQUE - CHICLAYO - LA VICTORIA', '', '', 1, 2, '20480413700', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(625, 'ESTACION DE SERVICIOS EL CARIBE S.A.C', 'CAR.PANAMERICANA NORTE KM. 778 INT. 5 (COSTADO MOLINO SAN FERNANDO) LAMBAYEQUE - LAMBAYEQUE - LAMBAYEQUE', '', '', 1, 2, '20480082321', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(626, 'ALBITRES AGUIRRE MARINA LIDIA', 'AV CAMPO AMOR MZ 16 LT 02 JR JAZMINEZ', '', '', 1, 2, '10335883786', 1, 'MICORREO@MAIL.COM', '', 230301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(627, 'NEGOCIOS SICAR SOCIEDAD COMERCIAL DE RESPONSABILIDAD LIMITADA', 'CAL.DANIEL ALCIDES CARRION NRO. 444 C.P. ARTESANOS INDEPENDIENTES (CERCA A 8 DE AGOSTO) LAMBAYEQUE - CHICLAYO - JOSE LEONARDO ORTIZ', '', '', 1, 2, '20479577294', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(628, 'CONTRALORIA GENERAL DE LA REPUBLICA', 'JR. CORONEL CAMILO CARRILLO NRO. 114 URB. SANTA BEATRIZ LIMA - LIMA - JESUS MARIA', '', '', 1, 2, '20131378972', 1, 'MICORREO@MAIL.COM', '', 140133, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(629, 'CRONOS AGROINDUSTRIAS SOCIEDAD ANONIMA CERRADA', 'CAL.CRISTOBAL COLON NRO. 390 INT. 2 CERCADO DE CHICLAYO LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20601650518', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(630, 'VENDO NORTE S.A.C.', 'JR. EDGAR ZUÑIGA NRO. 139 URB. LA VIÑA (ENTRE CDRA 3 Y 4 AV ROSA TORO) LIMA - LIMA - SAN LUIS', '', '', 1, 2, '20601175810', 1, 'MICORREO@MAIL.COM', '', 140138, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(631, 'LOGISTICA E INVERSIONES SOBRE RUEDAS E.I.R.L.', 'AV. CARLOS VALDERRAMA NRO. 491 DPTO. 301 URB. LAS QUINTANAS LA LIBERTAD - TRUJILLO - TRUJILLO', '', '', 1, 2, '20605037314', 1, 'MICORREO@MAIL.COM', '', 120101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(632, 'STALNO S.A.C.', 'CAL.VIRU NRO. 1080 LAMBAYEQUE - CHICLAYO - LA VICTORIA', '', '', 1, 2, '20603727551', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(633, 'SUYON GAMARRA JUAN SANTIAGO', '', '', '', 1, 2, '10167599112', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(634, 'INDUAMERICA CHICLAYO SAC', 'CAR.PANAMERICANA NORTE KM. 775 LAMBAYEQUE - LAMBAYEQUE - LAMBAYEQUE', '', '', 1, 2, '20561347868', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(635, 'CASABLANCA CARGO EXPRESS EIRL', 'CAR.PANAMERICANA NORTE NRO. 779 CAS. MUY FINCA PTO NUEVE (COSTADO DE CREDITEX) LAMBAYEQUE - LAMBAYEQUE - LAMBAYEQUE', '', '', 1, 2, '20539149343', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(636, 'MAFABE SERVICIOS GENERALES E.I.R.L.', 'AV. GRAN CHIMU NRO. 753 P.J. EL BOSQUE LAMBAYEQUE - CHICLAYO - LA VICTORIA', '', '', 1, 2, '20605245332', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(637, 'ONCORAD S.A.C.', 'AV. JOSE LEONARDO ORTIZ NRO. 423 URB. CERCADO DE CHICLAYO LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20543036961', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(638, 'MULTISERVICIOS ELECTROTEC E.I.R.L.', '----SECTOR 20 DE ENERO MZA. M2 LOTE. 20 LAMBAYEQUE - CHICLAYO - POMALCA', '', '', 1, 2, '20602474250', 1, 'MICORREO@MAIL.COM', '', 130118, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(639, 'INDUSTRIAS INDEKA S.A.C.', '----SANTO TOMAS Y ANEXOS PARCELA NRO. 15 SEC. SANTO TOMAS (ESPALDAS DEL MOLINO SEMPER) LAMBAYEQUE - LAMBAYEQUE - LAMBAYEQUE', '', '', 1, 2, '20603260911', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(640, 'CEM ENERGY MANAGEMENT QUALITY E.I.R.L.', 'CAL.MANCO INCA NRO. 322 LAMBAYEQUE - CHICLAYO - LA VICTORIA', '', '', 1, 2, '20601537550', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(641, 'A Y J ENERGYS S.R.L.', 'PRO.VENEZUELA NRO. 835 P.J. MEDIO MUNDO LAMBAYEQUE - CHICLAYO - JOSE LEONARDO ORTIZ', '', '', 1, 2, '20561227706', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(642, 'ZEYTRON IMPORTACIONES S.A.C.', 'CAL.LAS SABILAS NRO. 494 URB. SAN HILARION ET. DOS LIMA - LIMA - SAN JUAN DE LURIGANCHO', '', '', 1, 2, '20523358686', 1, 'MICORREO@MAIL.COM', '', 140137, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(643, 'INVERSIONES ADVENTISTAS B', 'AV. SANTA ELVIRA MZA. F3 LOTE. 04 A.H. ROSALES DE PRO LIMA - LIMA - LOS OLIVOS', '', '', 1, 2, '20488142802', 1, 'MICORREO@MAIL.COM', '', 140142, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(644, 'MUNICIPALIDAD DE LAGUNAS MOCUPE', 'JR. LIMA NRO. 456 CERCADO DE MOCUPE LAMBAYEQUE - CHICLAYO - LAGUNAS', '', '', 1, 2, '20162213254', 1, 'MICORREO@MAIL.COM', '', 130105, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(645, 'NUEVAS SOLUCIONES DEL AGRO TECNIFICADO S.A.C', 'CAL.SAN FELIPE NRO. 830 URB. NVO SAN LORENZO (ALTURA MAR. CORNEJO Y VENEZUELA) LAMBAYEQUE - CHICLAYO - JOSE LEONARDO ORTIZ', '', '', 1, 2, '20487721612', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(646, 'ENERGIA Y ORGANIZACION DE SISTEMAS S.A.', 'JR. FAUSTINO QUISPE NRO. 351 URB. MIRAFLORES JUNIN - HUANCAYO - EL TAMBO', '', '', 1, 2, '20281244222', 1, 'MICORREO@MAIL.COM', '', 110113, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(647, 'CALDERON & FLORES SAC', 'MZA. C LOTE. 10 URB. SOL DE PIMENTEL (GALILEA) LAMBAYEQUE - CHICLAYO - PIMENTEL', '', '', 1, 2, '20603683693', 1, 'MICORREO@MAIL.COM', '', 130110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(648, 'VICTOR VASQUEZ CIEZA', '', '', '', 1, 1, '27402000', 1, 'MICORREO@MAIL.COM', '', 120901, 0, '', 1, NULL, NULL, NULL, 0),
(649, 'SILVESTRE AGUILAR CAMPOS', '', '', '', 1, 1, '43833887', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(650, 'GILBER VENTURA SANTISTEBAN', '', '', '', 1, 1, '41949852', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(651, 'MERINO OYOLA JULIO GONZALO', '2 MAYO760  LAMBAYEQUE', '', '', 1, 2, '10409672201', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(652, 'TUBOS Y POSTES CHACUPE S.A.C.', 'AV. MIGUEL GRAU SEC. CHACUPE ALTO KM. 3.3', '', '', 1, 2, '20601628890', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(653, 'LUCAVET E.I.R.L.', 'PRO.IQUITOS NRO. 555 SEC. LAS FLORES CAJAMARCA - JAEN - JAEN', '', '', 1, 2, '20600386043', 1, 'MICORREO@MAIL.COM', '', 60801, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(654, 'DISTRIBUIDORA COMERCIAL BUSTAMANTE SRL', 'AV. CHOTA NRO. 20 ACAPULCO (EN PLENA AV.CHOTA) LAMBAYEQUE - CHICLAYO - TUMAN', '', '', 1, 2, '20479958689', 1, 'MICORREO@MAIL.COM', '', 130120, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(655, 'MUNICIPALIDAD DISTRITAL DE SANTA CRUZ', 'CAL.9 DE MAYO NRO. 34 CAJAMARCA - CUTERVO - SANTA CRUZ', '', '', 1, 2, '20222223173', 1, 'MICORREO@MAIL.COM', '', 20708, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(656, 'CAJA MUNICIPAL DE AHORRO Y CREDITO DE PAITA S.A.', 'JR. PLAZA DE ARMAS NRO. 176 INT. 178 RES. CENTRO DE LA CIUDAD (CENTRO DE LA CIUDAD) PIURA - PAITA - PAITA', '', '', 1, 2, '20102361939', 1, 'MICORREO@MAIL.COM', '', 190501, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(657, 'CORREA CARBONEL ELVIA CELESTE', '', '', '', 1, 2, '10409892901', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(658, 'CARDENAS FONSECA JAIME', '', '', '', 1, 2, '10098685061', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(659, 'INVERSIONES FRANIS EMPRESA INDIVIDUAL DE RESPONSABILIDAD LIMITADA', 'PJ SANTA ANA AV. CHICLAYO S/N SECTOR CULPN J.L.O CHICLAYO -LAMBAYEQUE', '', '', 1, 2, '20548394997', 1, 'MICORREO@MAIL.COM', '', 140143, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(660, 'KAR & MA S.A.C', 'CAL.SAN GABRIEL NRO. 260 URB. SANTA MARIA LAMBAYEQUE - CHICLAYO - JOSE LEONARDO ORTIZ', '', '', 1, 2, '20480078218', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(661, 'MUNICIPALIDAD DISTRITAL DE LAJAS', 'JR. 28 DE JULIO NRO. 231 CAJAMARCA - CHOTA - LAJAS', '', '', 1, 2, '20220666507', 1, 'MICORREO@MAIL.COM', '', 60609, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(662, 'MUNDACA BRAVO OSCAR ENRIQUE', '', '', '', 1, 2, '10442368274', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(663, 'FERROTUMI S.A.C.', 'CAR.PANAMERICANA NRO. 475 CENTRO (COSTADO INSTITUTO TECNOLOGICO ILLIMO) LAMBAYEQUE - LAMBAYEQUE - ILLIMO', '', '', 1, 2, '20561323926', 1, 'MICORREO@MAIL.COM', '', 130303, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(664, 'GANDULES INC SAC', 'AV. JAVIER PRADO ESTE NRO. 6210 (OFICINA 402 EDIFICIO PARK OFFICE) LIMA - LIMA - LA MOLINA', '', '', 1, 2, '20504004415', 1, 'JUAN.SOFT@HOTMAIL.COM', '', 140110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(665, 'MUNICIPALIDAD DISTRITAL DE SAN JOSE', 'CAL.BOLOGNESI NRO. S/N (CUADRA 3) LAMBAYEQUE - LAMBAYEQUE - SAN JOSE', '', '', 1, 2, '20163164401', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(666, 'MOLISAM I S.A.C.', 'CAR.PANAMERICANA NORTE ANTIGU KM. 4 CAS. MOCCE (PASANDO EL PEAJE MOCCE A LADO CREDITEX) LAMBAYEQUE - LAMBAYEQUE - LAMBAYEQUE', '', '', 1, 2, '20539149424', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(667, 'REENCAUCHADORA AMERICANA SAC', 'AV. LOS INCAS NRO. 125 LA VICTORIA LAMBAYEQUE - CHICLAYO - LA VICTORIA', '', '', 1, 2, '20352810615', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(668, 'INVERSIONES RCT S.A.C.', 'AV. JOSE BALTA NRO. 1149 FERIA BALTA (STAND 1000- 2DO PISO) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20479414158', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(669, 'CORPORACION KING SOLUCIONES SOCIEDAD ANONIMA CERRADA', 'MZA. F LOTE. 01 URB. FERMIN AVILA MORON LAMBAYEQUE - CHICLAYO - PIMENTEL', '', '', 1, 2, '20605157280', 1, 'MICORREO@MAIL.COM', '', 130110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(670, 'COOPERATIVA DE AHORRO Y CRÑDITO SAN MARTÑN DE PORRES LTDA.', 'JR. MAYNAS NRO. 100 (FRENTE A PLAZA DE ARMAS E IGLESIA) SAN MARTIN - SAN MARTIN - TARAPOTO', '', '', 1, 2, '20146809341', 1, 'MICORREO@MAIL.COM', '', 210601, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(671, 'LOPES GARCIA JUAN MIGUEL', '', '', '', 1, 1, '46923043', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(672, 'CLINICA MATERNA INFANTIL BELEN EIRL', 'CAL.EL DORADO NRO. 1379 URB. BOLOGNESI LAMBAYEQUE - CHICLAYO - JOSE LEONARDO ORTIZ', '', '', 1, 2, '20480213794', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(673, 'MUNICIPALIDAD DE NUEVA ARICA', 'CAL.MIGUEL GRAU NRO. 851 CERCADO DE NVA ARICA LAMBAYEQUE - CHICLAYO - NUEVA ARICA', '', '', 1, 2, '20162368533', 1, 'MICORREO@MAIL.COM', '', 130107, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(674, 'IPANAQUE OROSCO ISRAEL ABIMAEL', '', '', '', 1, 2, '10423068901', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(675, 'FRUTAS Y VEGETALES AURA EMPRESA INDIVIDUAL DE RESPONSABILIDAD LIMITADA', 'AV. GRAU NRO. 925 DPTO. 502 URB. SANTA VICTORIA (BLOCK D) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20600543661', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(676, 'ZETA GAS ANDINO S.A.', 'AV. NESTOR GAMBETA MZA. MI LOTE. SN FND. EX FUNDO OQUENDO PROV. CONST. DEL CALLAO - PROV. CONST. DEL CALLAO - VENTANILLA', '', '', 1, 2, '20262254268', 1, 'MICORREO@MAIL.COM', '', 240106, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(677, 'PEREZ SALAZAR VICTOR DANIEL', '', '', '', 1, 2, '10166999435', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(678, 'GEOSINTETICOS E INSTALACIONES S.A.C.', 'MZA. J LOTE. 7 ASOC DE VIV LOS CLAVELES (A LA ALTURA DEL PARAD. LA CRUZ) LIMA - LIMA - LURIN', '', '', 1, 2, '20509264431', 1, 'MICORREO@MAIL.COM', '', 140113, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(679, 'GROUP HERNANDEZ S.A.C.', 'AV. PEDRO RUIZ NRO. 948 INT. 890 LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20604438790', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(680, 'ROBINSON ALBARRAN SIGUAS', '', '', '', 1, 1, '45893891', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(681, 'NEGOCIOS E INVERSIONES DESERET EIRL', 'CAL.GOLGOTA NRO. 195 P.J. CRUZ DE LA ESPERANZA LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20601860881', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(682, 'BIODIAGNOSTICA DEL NORTE G & R S.R.L.', 'CAL.ATAHUALPA NRO. 369 C.P.M SAN CARLOS LAMBAYEQUE - CHICLAYO - JOSE LEONARDO ORTIZ', '', '', 1, 2, '20603497024', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(683, 'REPUESTOS SERVICIOS Y MOLINERIA EAM E.I.R.L.', 'CAL.28 DE JULIO NRO. 477 P.J. DIEGO FERRE LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20605961828', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(684, 'DIRECCION SUB REGIONAL DE SALUD CUTERVO', 'JR. BENJAMIN DUBLE NRO. 458 CAJAMARCA - CUTERVO - CUTERVO', '', '', 1, 2, '20368945715', 1, 'MICORREO@MAIL.COM', '', 60501, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(685, 'AGROSOLTEC S.R.LTDA.', 'JR. LOS GLADIOLOS NRO. 150 BR PUEBLO NUEVO CAJAMARCA - CAJAMARCA - CAJAMARCA', '', '', 1, 2, '20369117433', 1, 'MICORREO@MAIL.COM', '', 60101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(686, 'COMERCIALIZADORA Y DISTRIBUIDORA JIMENEZ SAC', 'CAL.GARCILAZO DE LA VEGA NRO. 127 LOTE. 30 URB. EL RETABLO II ETAPA (ESPALDA DEL BOULEVARD EL RETABLO) LIMA - LIMA - COMAS', '', '', 1, 2, '20122138161', 1, 'MICORREO@MAIL.COM', '', 140106, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(687, 'DISTRIBUCIONES & CONSTRUCCIONES JONIJA S.A.C.', 'AV. EL IMPERIO NRO. 1296 P.J. ANTONIO RAIMONDI LAMBAYEQUE - CHICLAYO - LA VICTORIA', '', '', 1, 2, '20602963757', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(688, 'EMPRESA DE SERV. MULTIPLES VARAMAX S.R..L.', 'CAL.ALMIRANTE MIGUEL GRAU NRO. 523 LAMBAYEQUE - LAMBAYEQUE - LAMBAYEQUE', '', '', 1, 2, '20463821535', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(689, 'MULTISERVICIOS Y DISTRIBUCIONES AGRICOLAS LUHAMAR RAMOS E.I.R.L.', 'JR. ZARUMILLA NRO. 504 CENTRO CAJAMARCA - SANTA CRUZ - SANTA CRUZ', '', '', 1, 2, '20488043901', 1, 'MICORREO@MAIL.COM', '', 20708, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(690, 'COOPERATIVA AGRARIA \" FRONTERA SAN IGNACIO \" LTDA.', 'JR. SANTA ROSA NRO. 500 CERCADO (JR. SANTA ROSA 500-5002) CAJAMARCA - SAN IGNACIO - SAN IGNACIO', '', '', 1, 2, '20113940515', 1, 'MICORREO@MAIL.COM', '', 61101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(691, 'ZAVALETA MARTINEZ MARIA FRANCISCA', '', '', '', 1, 2, '10165984396', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(692, 'GERMAN SEGURA DIAZ', '', '', '', 1, 1, '42792074', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(693, 'AGUSTIN AGUINAGA FERNANDEZ', '', '', '', 1, 1, '40653021', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(694, 'MULTISERVICIOS MAPESA S.R.L.', '----CARRETERA POMALCA MZA. J LOTE. 3 P.J. MIRAFLORES (FRENTE A TOLDOS ALISSON Y JARDIN FATIMA3) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20479931721', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(695, 'ASOCIACION DE PEQUEÑOS COMERCIANTES DEL MERCADO TIPO A', 'CAL.GRAN CHIMU NRO. CDA9 P.J. EL BOSQUE (OFICINA DE ADMINISTRACION) LAMBAYEQUE - CHICLAYO - LA VICTORIA', '', '', 1, 2, '20105833904', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(696, 'AGRO LATAM S.A.C.', 'AV. CIRCUNVALACION CLUB GOLF NRO 154 INT. 1801 URB. CAMACHO', '', '', 1, 2, '20603361092', 1, 'MICORREO@MAIL.COM', '', 140130, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(697, 'DAIRA SAC', 'AV. VENEZUELA 2582', '', '', 1, 2, '20538976815', 1, 'MICORREO@MAIL.COM', '', 130112, 0, '', 1, NULL, NULL, NULL, 0),
(698, 'ROQUE HUAMAN ORLANDO', '', '', '', 1, 2, '10167096889', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(699, 'CASTAÑEDA CABRERA CARLOS ALBERTO', 'HUAYNA CAPAC 1020  CHICLAYO LA VICTORIA', '', '', 1, 2, '10444485154', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(700, 'NEFRO CIX S.A.C.', 'AV. MANUEL PARDO NRO. 620 URB. SAN LUIS LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20601042151', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(701, 'SERVICIOS Y TRANSPORTE DE AGREGADOS POMPEYO S.A.C.', 'AV. GRAN CHIMU NRO. 360 URB. LA VICTORIA SC. TRES LAMBAYEQUE - CHICLAYO - LA VICTORIA', '', '', 1, 2, '20536988671', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(702, 'JOSE PERES', '', '', '', 1, 3, '', 1, 'JUAN.SOFT@HOTMAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(703, 'AYMAR CONSULTORA CONSTRUCTORA CONTRERAS SAC', 'JR. PORVENIR NRO. SN (JR. PORVENIR 030) CAJAMARCA - CUTERVO - CUTERVO', '', '', 1, 2, '20602228887', 1, 'MICORREO@MAIL.COM', '', 60501, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(704, 'FACUNDO', 'AV. BOLIVAR 1830 J LO', '', '', 1, 3, '', 1, 'JUAN.SOFT@MAIL.COM', '', 130104, 0, '', 1, NULL, NULL, NULL, 0),
(705, 'CONSORCIO CHONGOYAPE', 'PZA.SAN FRANCISCO NRO. 208 LIMA - LIMA - BARRANCO', '', '', 1, 2, '20603591004', 1, 'MICORREO@MAIL.COM', '', 140125, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(706, 'JORGUE PERLECHE TERRONES', '', '', '', 1, 1, '41984130', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(707, 'BURGA VILLALOBOS JERSON ALDAIR', '', '', '', 1, 1, '76823107', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(708, 'REPRESENTACIONES VIVISA S.R.LTDA', 'CAL.MANCO INCA NRO. 867 LAMBAYEQUE - CHICLAYO - LA VICTORIA', '', '', 1, 2, '20313894453', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(709, 'BERNAL LLONTOP FELIPE', '', '', '', 1, 2, '10166008111', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(710, 'SUPERCIX E.I.R.L', 'CAL.LAS MALVINAS NRO. 227 URB. SAN EDUARDO LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20602949401', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(711, 'MUNICIPALIDAD DISTRITAL DE YAUYUCAN', 'CAL.CAJAMARCA NRO. S/N (PLAZA DE ARMAS) CAJAMARCA - SANTA CRUZ - YAUYUCAN', '', '', 1, 2, '20186864906', 1, 'MICORREO@MAIL.COM', '', 60909, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(712, 'KEMANA SOCIEDAD ANONIMA CERRADA', 'AV. CHACRA CERRO MZA. FF LOTE. 10 URB. EX FUNDO CHACRA CERRO LIMA - LIMA - COMAS', '', '', 1, 2, '20562965492', 1, 'MICORREO@MAIL.COM', '', 140106, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(713, 'DISTRIBUCIONES DANNA E.I.R.L.', 'CAL.EL MOLINO NRO. 103 CAS. BATANGRANDE (COSTADO PARADERO DE COLECTIVOS) LAMBAYEQUE - FERREÑAFE - PITIPO', '', '', 1, 2, '20601141729', 1, 'MICORREO@MAIL.COM', '', 130204, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(714, 'PRODUCTOS E INSUMOS MOCHICAS EIRL', 'CAL.PACHACUTEC NRO. 1743 LAMBAYEQUE - CHICLAYO - LA VICTORIA', '', '', 1, 2, '20479680036', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(715, 'CESAR MAMANI YANA', '', '', '', 1, 1, '44591214', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(716, 'FERT & RIEGO PLAST E.I.R.L.', 'CAL.CALLE 01 NRO. 191 P.J. AMPLIACION 9 DE OCTUBRE (CERCA ANTENA RADIO PROGRAMAS) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20487416062', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(717, 'EMPRESA AGROINDUSTRIAL TUMAN S.A.A.', 'AV. EL TRABAJO NRO. SN (KM 17 CARRTERA CHONGOYAPE,EXCOOPERATIVA) LAMBAYEQUE - CHICLAYO - TUMAN', '', '', 1, 2, '20136009614', 1, 'MICORREO@MAIL.COM', '', 130120, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(718, 'MADRE JUANA S.A.C.', 'JR. LAMBAYEQUE NRO. 118 URB. 28 DE JULIO LAMBAYEQUE - CHICLAYO - SANTA ROSA', '', '', 1, 2, '20487381765', 1, 'MICORREO@MAIL.COM', '', 10510, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(719, 'TEJADA SANTAMARIA VDA DE SUCLUPE MARIA TOMASA', '', '', '', 1, 2, '10166002708', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(720, 'PEGAMENTOS DEL NORTE S.A.C.', 'AV. EL TRIUNFO NRO. S/N P.J. CRUZ DE LA ESPERANZA (ALTURA DEL CRUCE SAN JOSE - PORTÑN AZUL) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20601846064', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(721, 'A.R.L. & M. ENEQUE INGENIERIA E IMPORTACIONES S.A.C.', 'CAL. ALFONSO UGARTE NRO 1247 CERCADO DE CHICLAYO', '', '', 1, 2, '20602746241', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(722, 'OBRAS DE INGENIERIA Y CONSULTORIAS EN GENERAL E.I.R.L.', 'CAL.LAS TABLAS NRO. 162 INT. A URB. BANCARIOS LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20603515189', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(723, 'TURISMO CIVA S.A.C.', 'JR. SANCHO DE RIVERA NRO. 1184 URB. MONSERRATE LIMA - LIMA - LIMA', '', '', 1, 2, '20102427891', 1, 'MICORREO@MAIL.COM', '', 140101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(724, 'SALAZAR TOCHON SAUL', '', '', '', 1, 2, '10403758961', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(725, 'INTIPA FOODS S.A.C.', 'JR. RAYMONDI NRO. 110 BAR. LA ESPERANZA (FRENTE AL COLISEO MULTIUSOS) ANCASH - HUAYLAS - CARAZ', '', '', 1, 2, '20224133929', 1, 'MICORREO@MAIL.COM', '', 20701, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(726, 'MIGUEL ANGEL CESPEDES MORA', '', '', '', 1, 1, '47228706', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(727, 'PROCESADORA FRUTICOLA S.A.', 'CAL.MANUEL MARIA IZAGA NRO. 556 (5TO. PISO) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20136036778', 1, 'CGONZALES@PROFUSA.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(728, 'MILUSKA JOHANY VASQUEZ VASQUEZ', '', '', '', 1, 2, '10462511391', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(729, 'DHMONT S.A.C. CONTRATISTAS GENERALES', 'AV. ANGAMOS ESTE NRO. 1648 DPTO. 404 (ENTRE AV. REP. DE PANAMA Y TOMAS MARSANO) LIMA - LIMA - SURQUILLO', '', '', 1, 2, '20108664640', 1, 'MICORREO@MAIL.COM', '', 140131, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(730, 'COMERCIALIZADORA Y SERVICIOS CESHER S.A.C.', 'CAL.TUMBES NORTE NRO. 170 DPTO. 201 INT. C URB. PATAZCA (COSTADO DE CLARO SALAVERRY) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20539237803', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(731, 'SOCIEDAD AGRICOLA POZO SANTO S.A.C.', 'AV. ANGAMOS OESTE NRO. 1551 DPTO. 203 URB. CHACARILLA SANTA CRUZ SANTA ISABEL LIMA - LIMA - MIRAFLORES', '', '', 1, 2, '20551153381', 1, 'JUAN.SOFT@HOTMAIL.COM', '', 140115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(732, 'SCALAR PROYECTOS Y CONSTRUCCIONES S.R.L.', 'CAL.LOS INCAS NRO. 169 P.J. SAN FRANCISCO LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20561290220', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(733, 'COMISION DE USUARIOS DE AGUA LAMBAYEQUE', 'CAL.HUASCAR NRO. 720 LAMBAYEQUE - LAMBAYEQUE - LAMBAYEQUE', '', '', 1, 2, '20196022571', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(734, 'PROCAMPO SA', 'CAL.SALVADOR CARMONA NRO. 216 URB. INDUSTRIAL VULCANO LIMA - LIMA - ATE', '', '', 1, 2, '20268784625', 1, 'MICORREO@MAIL.COM', '', 140103, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(735, 'HOGAR CLINICA SAN JUAN DE DIOS CHICLAYO', 'NRO. 10 CAS. PIMENTEL LAMBAYEQUE - CHICLAYO - PIMENTEL', '', '', 1, 2, '20437310841', 1, 'MICORREO@MAIL.COM', '', 130110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(736, 'BALDEON ARRATEA MAGDALENA', '', '', '', 1, 2, '10447337342', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(737, 'HENRY PERES REVOLLEDO', '', '', '', 1, 1, '41308206', 1, 'MICORREO@MAIL.COM', '', 230101, 0, '', 1, NULL, NULL, NULL, 0),
(738, 'AGRO INDUSTRIA JUANITO S.A.C', 'CAR. PANAMERICANA NORTE NRO 779', '', '', 1, 2, '20395514203', 1, 'TCNOAGRO@HOTMAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(739, 'AMSEQ S.A.', '----PARCELA 1 MZA. B LOTE. 5 Z.I. VILLA EL SALVADOR LIMA - LIMA - VILLA EL SALVADOR', '', '', 1, 2, '20600853318', 1, 'JTRONCOSO@3AAMSEQ.COM.PE', '', 140141, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(740, 'PILADORA LA MERCED S.R.L', 'CAR.A FERREÑAFE KM. 03 P.J. UPIS CESAR VALLEJOS (A LA ALTURA DEL KM 3 DE CARRETERA FERREÑ) LAMBAYEQUE - CHICLAYO - JOSE LEONARDO ORTIZ', '', '', 1, 2, '20438252089', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(741, 'TESEN CHAVEZ CARLOS ALBERTO', '', '', '', 1, 2, '10167476525', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(742, 'CODIGAL EIRL', 'CAL.SAN JOSE NRO. 571 INT. 402 (4TO PISO) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20600231449', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(743, 'MUNICIPALIDAD DISTRITAL DE NIEPOS', 'CAL.CORONEL ISAIAS FLORE NRO. S/N CAJAMARCA - SAN MIGUEL - NIEPOS', '', '', 1, 2, '20174715972', 1, 'MICORREO@MAIL.COM', '', 61006, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(744, 'SEHIGA CONSULTORIA Y PROYECTOS SOCIEDAD COMERCIAL DE RESPONSABILIDAD LIMITADA', 'OTR.IV ETAPA MZA. B LOTE. 16 URB. VILLAS DE LA ENSENADA LAMBAYEQUE - CHICLAYO - PIMENTEL', '', '', 1, 2, '20561344176', 1, 'MICORREO@MAIL.COM', '', 130110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(745, 'GRUBEN E.I.R.L.', 'MZA. O LOTE. 21 C.H. VILLA CALIFORNIA (CERCA A CANAL DE BALAREZO) PIURA - PIURA - CASTILLA', '', '', 1, 2, '20603738307', 1, 'MICORREO@MAIL.COM', '', 10113, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(746, 'NATCLOUD ANALYTICS CONSULTING E.I.R.L.', 'AV. BRASIL NRO. 840 DPTO. 305 LIMA - LIMA - BREÑA', '', '', 1, 2, '20605718320', 1, 'MICORREO@MAIL.COM', '', 140104, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(747, 'CIENCIAS GENERALES SOCIEDAD ANONIMA', 'CAL.NICOLAS GUTIERREZ NRO. 553 CAJAMARCA - JAEN - JAEN', '', '', 1, 2, '20603724705', 1, 'MICORREO@MAIL.COM', '', 60801, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(748, 'PACHECO RAMOS HERNAN LEOPOLDO', 'AV. SANTA ROSA SN PJ JUAN VELASCO ALVARADO HUARMACA', '', '', 1, 2, '10032187566', 1, 'MICORREO@MAIL.COM', '', 190101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(749, 'SECURGRAMA S.R.L.', 'CAL.RODIN MZA. F2 LOTE. 2 URB. CALERA DE LA MERCED (AV. AVIACION CUADRA 38) LIMA - LIMA - SURQUILLO', '', '', 1, 2, '20348938704', 1, 'MICORREO@MAIL.COM', '', 140131, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(750, 'COAR NORTH S.A.C.', 'CAL.LIBERTAD NRO. 175 C.P.M. LAS MERCEDES LAMBAYEQUE - CHICLAYO - JOSE LEONARDO ORTIZ', '', '', 1, 2, '20561415880', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(751, 'RUBBER NORTH S.A.C.', 'AV. MIGUEL GRAU NRO. 1563 DPTO. 401 CONDOMINIO LOS CEDROS (BLOCK D DPTO 401) LAMBAYEQUE - CHICLAYO - LA VICTORIA', '', '', 1, 2, '20488101286', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(752, 'MEDALI VASQUEZ AMAYA', 'PITIPO', '', '', 1, 1, '16807916', 1, 'MICORREO@MAIL.COM', '', 130204, 0, '', 1, NULL, NULL, NULL, 0),
(753, 'VEGETALES BOZELT SAC', 'AV. MANUEL A. ODRIA MZA. T LOTE. 124 URB. SAN JUAN DE DIOS (SECTOR 3247 FRNT A CAMPO DPOSTIVO EL REY) JUNIN - TARMA - TARMA', '', '', 1, 2, '20600736508', 1, 'MICORREO@MAIL.COM', '', 110501, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(754, 'FLAVIO GARCIA GARCIA', 'TUMBES', '', '', 1, 1, '42606992', 1, 'MICORREO@MAIL.COM', '', 230101, 0, '', 1, NULL, NULL, NULL, 0),
(755, 'VARGAS CABANILLAS FANY ROSMERY', 'TRUJILLO', '', '', 1, 2, '10403631090', 1, 'MICORREO@MAIL.COM', '', 120101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(756, 'JOSE BAUTISTA VASQUEZ', 'CAJAMARCA', '', '', 1, 1, '40631345', 1, 'MICORREO@MAIL.COM', '', 60616, 0, '', 1, NULL, NULL, NULL, 0),
(757, 'COMUNIDAD TRAPEROS DE EMAUS', 'MZA. B LOTE. . URB. PROGRESIVA METROPOLITANA (ALTURA DE TIENDAS MACRO) LA LIBERTAD - TRUJILLO - TRUJILLO', '', '', 1, 2, '20396816921', 1, 'MICORREO@MAIL.COM', '', 120101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(758, 'CORDOVA DELGADO LEDID', 'CALLE SARA BULLON 153 URB. SAN FRANCISCO', '', '', 1, 2, '10463767381', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(759, 'GRUPO ASEPSIA SAC', 'MZA. C LOTE 01 URB. LOS ALAMOS', '', '', 1, 2, '20539278313', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(760, 'EMERSON RONALD QUISPE RODRIGUEZ', '', '', '', 1, 1, '19331117', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(761, 'RAMON RIOS', '', '', '', 1, 3, '', 1, 'TAROGUE169@HOTMAIL.COM', '', 130201, 0, '', 1, NULL, NULL, NULL, 0),
(762, 'AGROTIENDAS EL EDEN S.A.C.', 'MZA. D LOTE 8 CPM PAKATNAMU', '', '', 1, 2, '20560007397', 1, 'MICORREO@MAIL.COM', '', 120503, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(763, 'RIOS VALDERA HUBERT MANUEL', '', '', '', 1, 2, '10418115241', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(764, 'CENTRO DE INSPECCIONES TECNICAS DEL NORTE S.A.C.', 'CAR.PANAMERICANA NORTE KM. 775 MZA. B LOTE. 05 HABILITACIÑN INDUSTRIAL-TIPO 3 LAMBAYEQUE - LAMBAYEQUE - LAMBAYEQUE', '', '', 1, 2, '20602378820', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(765, 'RAMIREZ SILVA ROSA LAURA', '', '', '', 1, 2, '10416402154', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(766, 'AGROINDUSTRIAS Y SERVICIOS GENERALES EL CHOLOCANO EMPRESA INDIVIDUAL DE RESPONSABILIDAD LIMITADA', 'JR. FRAY MARTIN NRO 106 CENTRO CHULUCANAS', '', '', 1, 2, '20605842756', 1, 'MICORREO@MAIL.COM', '', 190401, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(767, 'MARCO GONZALES DIAZ', '', '', '', 1, 1, '16676911', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(768, 'REFRIGERACION HOJEMA S.R.L.', 'CAL.HUANUCO NRO. 530 (1ER PISO - FRENTE DE MAPFRE) PIURA - PIURA - PIURA', '', '', 1, 2, '20526488581', 1, 'MICORREO@MAIL.COM', '', 190101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(769, 'INDUSTRIAS MASTER GROUP S.A.C', 'CAR.PANAMERICANA NORTE KM 807 KM. 807 MZA. A CAS. PAREDONES BAJOS (FRENTE AL COLEGIO SAN ISIDRO 109040) LAMBAYEQUE - LAMBAYEQUE - MORROPE', '', '', 1, 2, '20602641610', 1, 'MICORREO@MAIL.COM', '', 130306, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(770, 'ANTONIO PEDREROS', '', '', '', 1, 3, '', 1, 'JUAN.SOFT@HOTMAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(771, 'MUNICIPALIDAD DISTRITAL DE KANARIS', 'CAL.SAN MARTIN MZA. 17 LOTE. 13 (EN LA PLAZA DE ARMAS) LAMBAYEQUE - FERREÑAFE - CAÑARIS', '', '', 1, 2, '20176249111', 1, 'JHOWIBERI94@HOTMAIL.COM', '', 130203, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(772, 'INVERSIONES DAVID VG E.I.R.L.', 'CAL.JUAN CUGLIEVAN NRO. 1460 CERCADO DE CHICLAYO (MCDO MODELO - SECTOR CAYANCA) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20603478437', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(773, 'CLINICA SAN PEDRO APOSTOL S.R.L.', 'AV. GRAU NRO. 636 CENT. MANCORA PIURA - TALARA - MANCORA', '', '', 1, 2, '20526176261', 1, 'MICORREO@MAIL.COM', '', 190705, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(774, 'EMPRESA JEHOVA PODEROSO GIGANTE E.I.R.L.', 'MZA. G2 LOTE. 20 A.H. ANSIETA ALTA LIMA - LIMA - EL AGUSTINO', '', '', 1, 2, '20569300194', 1, 'MICORREO@MAIL.COM', '', 140135, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(775, 'SANDOVAL SANDOVAL JUAN', '', '', '', 1, 2, '10165303917', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(776, 'MEDINA CORONEL ESTANISLAO', '', '', '', 1, 2, '10445725434', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(777, 'BANUS DEL SUR S.A.C.', 'MZA. S LOTE. 06 URB. EL SANTUARIO LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20605690131', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(778, 'ESTACION EXPERIMENTAL AGRARIA VISTA FLORIDA', 'CAR.A FERREÑAFE KM. 08 VISTA FLORIDA LAMBAYEQUE - CHICLAYO - PICSI', '', '', 1, 2, '20538977030', 1, 'MICORREO@MAIL.COM', '', 130109, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(779, 'AGRO OLMOS EXPORT S.A.C.', 'CAR. PANAMERICANA NORTE KM. 91.5', '', '', 1, 2, '20604524483', 1, 'MICORREO@MAIL.COM', '', 130308, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(780, 'ROJAS GUEVARA LUIS ORLANDO', '', '', '', 1, 2, '10164843900', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(781, 'PEDRAZA ALTAMIRANO MARY KELY', '', '', '', 1, 2, '10730107442', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(782, 'PRAXAIR PERU SRL', 'AV. ALFREDO BENAVIDES NRO. 801 INT. PI11 URB. MIRAFLORES (AV.PASEO DE LA REPUBLICA5887-5895,PISO11) LIMA - LIMA - MIRAFLORES', '', '', 1, 2, '20338570041', 1, 'MICORREO@MAIL.COM', '', 140115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(783, 'FELICAZU E.I.R.L.', 'MZA. E LOTE. 7 URB. LA PRADERA (AL COSTADO DE LA UNIVERSIDAD) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20539136527', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(784, 'CORONEL BURGA GEINER', '', '', '', 1, 1, '71205082', 1, 'JEINER_92_CB@HOTMAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(785, 'FERNANDEZ CARRERO ROSARIO', '', '', '', 1, 1, '80130833', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(786, 'AGRO GUADALUPE E.I.R.L.', 'PJ. CELSO DIAZ NRO A-7', '', '', 1, 2, '20605461825', 1, 'MICORREO@MAIL.COM', '', 140501, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(787, 'RENTERIA MENDOZA LUIS ALBERTO', '', '', '', 1, 2, '10166686631', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(788, 'DISTRIBUIDORA DE PORCELANATOS JHERY SOCIEDAD ANONIMA CERRADA', 'AV. TOMAS MARZANO NRO. 607 URB. V VICTORIA LIMA - LIMA - SURQUILLO', '', '', 1, 2, '20550709385', 1, 'MICORREO@MAIL.COM', '', 140131, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(789, 'SERVICIOS MULTIPLES UBILLUS E.I.R.L.', 'CAL.DIEGO FERRE NRO. 166 LAMBAYEQUE - LAMBAYEQUE - JAYANCA', '', '', 1, 2, '20487841782', 1, 'MICORREO@MAIL.COM', '', 130304, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(790, 'SUIT MONTERRICO S.A.C.', 'PRO.BOLOGNESI NRO. SN (COSTADO GRIFO PRIMAX) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20602664946', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(791, 'HOSPITAL REGIONAL LAMBAYEQUE', '', '', '', 1, 3, '', 1, 'JUAN.SOFT@HOTMAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(792, 'ROSA ELVIRA DELGADO MIRANDA', '', '', '', 1, 1, '40471715', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(793, 'COMUNIDAD CAMPESINA SANTA LUCIA DE FERREÑAFE', 'AV. ANDRES AVELINO CACERES NRO. 274 P.J. SAN MARTIN DE PORRAS LAMBAYEQUE - FERREÑAFE - FERREÑAFE', '', '', 1, 2, '20190385648', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(794, 'HENRY PAUL SOBERON CABANILLAS', '', '', '', 1, 1, '44331488', 1, '', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(795, 'RIVERA ABAD LEIREN', '', '', '', 1, 2, '15441022422', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(796, 'MOLINERIAS GRUPO RAM S.A.C.', 'CAR.PANAMERICANA NORTE KM. 777 PREDIO STO TOMAS Y ANEXOS (PARCELA 42) LAMBAYEQUE - LAMBAYEQUE - LAMBAYEQUE', '', '', 1, 2, '20480096208', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(797, 'ATENAS INGENIEROS SAC', 'CAL.LOS CALIFAS NRO 157 URB SALAMANCA (ESPALDAS DE PLAZA VEA) LIMA - LIMA - ATE', '', '', 1, 2, '20521571889', 1, 'TCNOAGRO@HOTMAIL.COM', '', 140103, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(798, 'ROBERT AGUANTA GUEVARA', '', '', '', 1, 1, '76969270', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(799, 'CONSTRUCTORA MTL E.I.R.L.', 'CAL.GERMAN SCHEREIBER NRO. 276 URB. SANTA ANA LIMA - LIMA - SAN ISIDRO', '', '', 1, 2, '20537175193', 1, 'MICORREO@MAIL.COM', '', 140124, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(800, 'CONSTRUCTORA VSTL E.I.R.L.', 'PQ. UNION PANAMERICANA NRO. 128 INT. C URB. BALCONCILLO LIMA - LIMA - LA VICTORIA', '', '', 1, 2, '20600396987', 1, 'MICORREO@MAIL.COM', '', 140109, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(801, 'COMERCIAL LAVAGNA S.A.C.', 'CAL.PARQUE INDUSTRIAL MZA. E LOTE. 4 Z.I. PARQUE INDUSTRIAL LAMBAYEQUE - CHICLAYO - PIMENTEL', '', '', 1, 2, '20103129061', 1, 'MICORREO@MAIL.COM', '', 130110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(802, 'SR & LV CONSULTORIA ACABADOS Y SERVICIOS GENERALES S.A.C.', 'MZA. F1 LOTE. 7 DERRAMA MAGISTERIAL LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20604979103', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(803, 'VILLA SALUD SA', 'ALM.DE LA ENCANTADA NRO. 170 URB. LA ENCANTADA (176-178-POR LOS CEDROS DE VILLA) LIMA - LIMA - CHORRILLOS', '', '', 1, 2, '20308267874', 1, 'MICORREO@MAIL.COM', '', 140108, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(804, 'T', 'AV. LOS EUCALIPTOS NRO. 947 URB. UNIVERSAL ET. TRES (TERCER PISO) LIMA - LIMA - SANTA ANITA', '', '', 1, 2, '20566032717', 1, 'MICORREO@MAIL.COM', '', 140143, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(805, 'T - LIMPIO', 'AV. LOS EUCALIPTOS NRO. 947 URB. UNIVERSAL ET. TRES (TERCER PISO) LIMA - LIMA - SANTA ANITA', '', '', 1, 2, '20566032717', 1, 'MICORREO@MAIL.COM', '', 140143, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(806, 'ACOSTA SANDOVAL JOSE', '', '', '', 1, 1, '41693860', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(807, 'CARLOS VARGAS HERNANDEZ', '', '', '', 1, 1, '48417605', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(808, 'DANIEL MUJICA JULON', '', '', '', 1, 1, '45807788', 1, 'MICORREO@MAIL.COM', '', 120901, 0, '', 1, NULL, NULL, NULL, 0),
(809, 'COMISION DE USUARIOS DEL SUBSECTOR HIDRAULICO MONSEFU', 'CAL.SIMON BOLIVAR NRO. 312 LAMBAYEQUE - CHICLAYO - MONSEFU', '', '', 1, 2, '20314033753', 1, 'MICORREO@MAIL.COM', '', 130106, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(810, 'HOYOS MUNDACA GABRIEL', '', '', '', 1, 2, '10412050121', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(811, 'CARLOMAN ROMERO AMPUERO', '', '', '', 1, 1, '16695650', 1, 'MICORREO@MAIL.COM', '', 130114, 0, '', 1, NULL, NULL, NULL, 0),
(812, 'LIMABANDA S.A.C.', 'AV. MARISCAL ORBEGOSO NRO. 120 URB. EL PINO LIMA - LIMA - SAN LUIS', '', '', 1, 2, '20101312519', 1, 'MICORREO@MAIL.COM', '', 140138, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(813, 'ALFREDO ENRIQUE PINILLOS NEGRON', '', '', '', 1, 1, '16626540', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(814, 'SAN ROQUE S.A.', 'CAR. PANAMERICANA NORTE KM. 780', '', '', 1, 2, '20103342091', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(815, 'MANUEL JAIME SIESQUEN VALDERA', '', '', '', 1, 1, '47868931', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(816, 'D Y L FRIO E.I.R.L.', 'AV. FERNANDO BELAUNDE NRO. 585 URB. LA PRIMAVERA II ETAPA LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20536053116', 1, 'JUAN.SOFT@HOTMAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(817, 'PEDRO LUIS TAICA TERRONES', '', '', '', 1, 1, '43155884', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(818, 'JOSE PAZ RIVADENEYRA', '', '', '', 1, 1, '17588937', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(819, 'WILMER VILLAREAL SANCHES', '', '', '', 1, 1, '46335783', 1, 'MICORREO@MAIL.COM', '', 130308, 0, '', 1, NULL, NULL, NULL, 0),
(820, 'WILMWE VIRREAL SANCHEZ', '', '', '', 1, 1, '46335783', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(821, 'NEGOCIOS DEL NORTE CAMPO VERDE E.I.R.L.', 'CAL.LOS NARANJOS NRO. 229 INT. 9 URB. EL GOLF (ENTRE CALLES LOS MANGOS Y COCOTEROS) LA LIBERTAD - TRUJILLO - VICTOR LARCO HERRERA', '', '', 1, 2, '20559779254', 1, 'HUERYAK78@HOTMAIL.COM', '', 120107, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(823, 'ADOLFO PAICO OLIVA', '', '', '', 1, 1, '17612875', 1, 'MICORREO@MAIL.COM', '', 130308, 0, '', 1, NULL, NULL, NULL, 0),
(824, 'FUNTEC SOLUTIONS S.A.C.', 'CAL.SARA BULLON NRO. 153 URB. SAN FRANCISCO LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20606153768', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(825, 'VALDIVIA RAMIRES SEGUNDO ELOY', '', '', '', 1, 1, '16562895', 1, 'MICORREO@MAIL.COM', '', 130115, 0, '', 1, NULL, NULL, NULL, 0),
(826, 'LAON S.A.C.', 'AV. ESPAÑA NRO. 305 INT. 302 U.V. SANTA ROSA LA LIBERTAD - TRUJILLO - TRUJILLO', '', '', 1, 2, '20601842603', 1, 'MICORREO@MAIL.COM', '', 120101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(827, 'JUNTA DE USUARIOS DEL SECTOR HIDRAULICO MENOR CHANCAY LAMBAYEQUE CLASE A', 'CAL.JUAN BUENDIA NRO. 145 URB. PATAZCA LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20177641449', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(828, 'OFICINA REGIONAL NORTE', 'CAL.MANCO CAPAC NRO. 450 LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20353982878', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(829, 'CLINICA DE SALUD OCUPACIONAL PREVENTIVA S.A.C.', 'CAL.FRANCISCO CUNEO NRO. 680 URB. PATAZCA (ESQUINA A 1 CUADRA DE MAESTRO HOMECENTER) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20488004086', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(830, 'CHILON GAMONAL EDITH', 'ALFONSO UGARTE 1650', '', '', 1, 2, '10416357841', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(831, 'CONSTRUCTORA ULISES E.I.R.L.', 'AV. 28 DE JULIO NRO. 100 (CERCA AL MALECON) AMAZONAS - BAGUA - BAGUA', '', '', 1, 2, '20487466167', 1, 'MICORREO@MAIL.COM', '', 10205, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(832, 'INTERCONEXIONES OCANEY E.I.R.L.', 'CAL.LAS BETANIAS NRO. 231 SEC. SANTA EMILIA CAJAMARCA - JAEN - JAEN', '', '', 1, 2, '20601052432', 1, 'MICORREO@MAIL.COM', '', 60801, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(833, 'JESUS VALENTIN PAICO CARILLO', '', '', '965119386', 1, 1, '74562785', 1, 'MICORREO@MAIL.COM', '', 60611, 0, '', 1, NULL, NULL, NULL, 0),
(834, 'MARINO CHUQUE VAZQUES', 'BATAN GRANDE', '', '', 1, 1, '27745674', 1, 'MICORREO@MAIL.COM', '', 130204, 0, '', 1, NULL, NULL, NULL, 0),
(835, 'CONSORCIO DEMOCRACIA', 'CAL.MARAÑON NRO. S/N C.P. CHIRIACO (A UNA CUADRA DE LA PLAZA DE CHIRIACO) AMAZONAS - BAGUA - IMAZA', '', '', 1, 2, '20605649123', 1, 'MICORREO@MAIL.COM', '', 10206, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(836, 'GLOBAL ENGINEERING PROJECTS E.I.R.L.', 'AV. LOS SAUCES MZA. Y LOTE. 32 URB. LOS NOGALES (II ETAPA) LAMBAYEQUE - CHICLAYO - PIMENTEL', '', '', 1, 2, '20601258171', 1, 'MICORREO@MAIL.COM', '', 130110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(837, 'REYES CALDERON VICTOR', '', '', '', 1, 1, '47617053', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(838, 'PILADORA DE ARROZ EL MARAÑON EIRL', 'CAR.PANAMERICANA NORTE NRO. 778 OTR. CARRETERA LAMBAYEQUE LAMBAYEQUE - LAMBAYEQUE - LAMBAYEQUE', '', '', 1, 2, '20271127066', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(839, 'SERVICIOS GENERALES J.C.C S.R.L.', 'CAL.28 DE JULIO NRO. 630 LAMBAYEQUE - LAMBAYEQUE - MOCHUMI', '', '', 1, 2, '20488068301', 1, 'MICORREO@MAIL.COM', '', 130305, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(840, 'GROUP XIOMARA CHICLAYO SOCIEDAD ANONIMA CERRADA', 'AV. LUIS GONZALES NRO. 1536 URB. SAN LUIS LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20601792754', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(841, 'YABUTA MATZUDA AUGUSTO ENRIQUE', '', '', '', 1, 2, '10164605022', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(842, 'CASINO PERSONAL SUBALTERNO GUARDIA CIVIL', 'CAL.NATURALEZA NRO. 143 URB. SAN LUIS LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20188001875', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(843, 'INVERSIONES E INGENIERIA V & CH EMPRESA INDIVIDUAL DE RESPONSABILIDAD LIMITADA', 'CAL.HUAMANTANGA NRO. 1665 (SEC. PUEBLO NUEVO) CAJAMARCA - JAEN - JAEN', '', '', 1, 2, '20600026101', 1, 'MICORREO@MAIL.COM', '', 60801, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(844, 'AGRICOLA GAYE E.I.R.L.', 'AV. GENERAL CESAR CANEVARO NRO 1524 DEP. 303 URB. RISSO', '', '', 1, 2, '20605946411', 1, 'MICORREO@MAIL.COM', '', 140111, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(845, 'AGRICOLA ALLIUM S.A.C.', 'CAL.PIURA NRO. 487 DPTO. 404 LIMA - LIMA - MIRAFLORES', '', '', 1, 2, '20603333978', 1, 'MICORREO@MAIL.COM', '', 140115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(846, 'DIAZ QUEZADA PERCY', '', '', '', 1, 2, '10166988859', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(847, 'TOURS ANGEL DIVINO SAC', 'AV. JORGE CHAVEZ NRO. 1365 URB. CAMPODONICO LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20395419715', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(848, 'SERVICIOS GENERALES E INSUMOS PARA LA INDUSTRIA G & C E.I.R.L.', 'AV. JOSE GABRIEL DE CONDORCANQUI NRO. 2046 P.J. LA ESPERANZA LA LIBERTAD - TRUJILLO - LA ESPERANZA', '', '', 1, 2, '20559838013', 1, 'MICORREO@MAIL.COM', '', 60904, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(849, 'ELOI SANTOYO DIAZ', '', '', '990536932', 1, 1, '17625369', 1, 'MICORREO@MAIL.COM', '', 130304, 0, '', 1, NULL, NULL, NULL, 0),
(850, 'FREDY MUÑOZ LESMA', '', '', '917130138', 1, 1, '72090970', 1, 'MICORREO@MAIL.COM', '', 120903, 0, '', 1, NULL, NULL, NULL, 0),
(851, 'VICTOR LLONTOP YUMPO', '', '', '', 1, 1, '16497707', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(852, 'ASPROAG PUENTE TULIPE', 'MZA. A LOTE. 18 SERUR PUENTE TULIPE LAMBAYEQUE - CHICLAYO - PATAPO', '', '', 1, 2, '20606024682', 1, 'TENORIOOSC32@GMAIL.COM', '', 130117, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(853, 'MI CONSUELO S.R.L.', 'JR. JOSE OLAYA NRO. 150 DPTO. 502 (ALT. CDRA. 23 DE AV. LA PAZ) LIMA - LIMA - SAN MIGUEL', '', '', 1, 2, '20480244169', 1, 'MICORREO@MAIL.COM', '', 140127, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(854, 'LLONTOP CORNEJO LUIS ALBERTO', '', '', '', 1, 2, '10166279505', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(855, 'AGRO EXPORTADORA CAHUAC S.A.C.', 'MZA. A LOTE 25A URB. LA CALETA', '', '', 1, 2, '20504942253', 1, 'MICORREO@MAIL.COM', '', 21301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(856, 'CANTERA PATAPO LA VICTORIA SA', 'CAR.CHONGOYAPE KM. 4 CAS. LAS CANTERAS (CASETA DE CONTROL) LAMBAYEQUE - CHICLAYO - PATAPO', '', '', 1, 2, '20480515961', 1, 'MICORREO@MAIL.COM', '', 130117, 0, 'HABIDO', 1, NULL, NULL, NULL, 0);
INSERT INTO `cliente` (`codigo_cli`, `nombre_cli`, `direccion_cli`, `ciudad_cli`, `telefono_cli`, `codigo_tip`, `codigo_doc`, `numero_doc`, `codigo_szo`, `email_cli`, `observacion_cli`, `codigo_dis`, `estadosunat_cli`, `condicionsunat_cli`, `estado_cli`, `usuario_reg`, `usuario_mod`, `fecha_mod`, `sistema`) VALUES
(857, 'INMOBILIARIA & CONSTRUCTORA COSTA AZUL S.A.C.', '----CAMPO KM. 7 CARRETERA PIMENTEL (ENTRADA DE CARITAS - FUNDO LA JOYITA) LAMBAYEQUE - CHICLAYO - PIMENTEL', '', '', 1, 2, '20487921891', 1, 'MICORREO@MAIL.COM', '', 130110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(858, 'NEGOCIOS SERRATY S.A.C.', 'AV. JOSE BALTA NRO. 915 INT. 207 (INT. 207-208) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20601169011', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(859, 'G&R SERVICIOS SRL', 'AV. 28 DE JULIO NRO. 31 LA LIBERTAD - PACASMAYO - PACASMAYO', '', '', 1, 2, '20481844305', 1, 'MICORREO@MAIL.COM', '', 120506, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(860, 'E & C SERVICIOS MULTIPLES IN HOUSE S.A.C.', '----UNION NRO. 801 LA LIBERTAD (A DOS CDRAS DE LA MUNICIPALIDAD DE COMAS) LIMA - LIMA - COMAS', '', '', 1, 2, '20603470274', 1, 'MICORREO@MAIL.COM', '', 140106, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(861, 'PEDRO HERRERA MIÑOPE', '', '', '', 1, 1, '16595808', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(862, 'DE LA CRUZ SANTA MARIA MANUEL', '', '', '', 1, 1, '42620884', 1, 'MICORREO@MAIL.COM', '', 130312, 0, '', 1, NULL, NULL, NULL, 0),
(863, 'MALCA BRINGAS CELSO', '', '', '', 1, 2, '10193288176', 1, 'MICORREO@MAIL.COM', '', 120902, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(864, 'JULIO CESAR VALDERA COBEÑAS', '', '', '921379798', 1, 1, '45588308', 1, 'MICORREO@MAIL.COM', '', 130306, 0, '', 1, NULL, NULL, NULL, 0),
(865, 'GLADIS CABANILLAS ABANTO', '', '', '', 1, 1, '19208351', 1, 'MICORREO@MAIL.COM', '', 120902, 0, '', 1, NULL, NULL, NULL, 0),
(866, 'PROGRAMA DE DESARROLLO DE SANIDAD AGROPE', 'AV. LA MOLINA NRO. 1915 (FRENTE A LA UNIV AGRARIA PUERTA 1) LIMA - LIMA - LA MOLINA', '', '', 1, 2, '20414251561', 1, 'MICORREO@MAIL.COM', '', 140110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(867, 'SERVICIO NACIONAL DE SANIDAD AGRARIA', 'AV. LA MOLINA NRO. 1915 LIMA - LIMA - LA MOLINA', '', '', 1, 2, '20131373075', 1, 'MICORREO@MAIL.COM', '', 140110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(868, 'ICT GROUP S.A.C.', 'JR. MANUEL DEL PINO NRO. 864 URB. SANTA BEATRIZ LIMA - LIMA - LIMA', '', '', 1, 2, '20600535928', 1, 'MICORREO@MAIL.COM', '', 140101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(869, 'SENADOR JACINTO JOSE LUIS', '', '', '', 1, 2, '10165912778', 1, 'MICORREO@MAIL.COM', '', 130110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(870, 'TARRILLO CHICOMA SEGUNDO DEMETRIO', '', '', '', 1, 2, '10166947338', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(871, 'COPERAMHYG S.R.L.', 'CAL.JOHN F. KENNEDY NRO. 850 P.J. SAN MARTIN (CERCA COMEDOR DE UNIVERSIDAD F-CREMA) LAMBAYEQUE - LAMBAYEQUE - LAMBAYEQUE', '', '', 1, 2, '20600456343', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(872, 'GRAU LOGISTICA EXPRESS S.A.C.', 'CAL.1 NRO. 253 URB. FDO. BOCANEGRA ALTO (FRENTE AL AEROPUERTO JORGE CHAVEZ) PROV. CONST. DEL CALLAO - PROV. CONST. DEL CALLAO - CALLAO', '', '', 1, 2, '20600876211', 1, 'MICORREO@MAIL.COM', '', 240101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(873, 'DISTRINORTE S.A.C.', 'CAL.LA UNION NRO. 655 LAMBAYEQUE - CHICLAYO - LA VICTORIA', '', '', 1, 2, '20604723036', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(874, 'D & D CONTRATISTAS GENERALES E.I.R.L.', 'AV. MACHU PICCHU NRO. 116 URB. SAN JUAN BAUTISTA (MZ. Q LT. 21 - PARALELA AV. ALAMEDA SUR) LIMA - LIMA - CHORRILLOS', '', '', 1, 2, '20513714026', 1, 'MICORREO@MAIL.COM', '', 140108, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(875, 'ROMERO IZQUIERDO JORGE JUNIOR', '', '', '', 1, 2, '10444048307', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(876, 'LOPEZ VELLO DAVID JOSE', '', '', '', 1, 1, '32130192', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(877, 'CERNUSE E.I.R.L.', 'AV. JOSE BALTA NRO. 989 (TERCER PISO) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20561296341', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(878, 'INVERSIONES CONSTRUCCIONES Y SERVICIOS SAN FRANCISCO SAC', 'AV. FERNANDO BELAUNDE TERRY NRO. 648 CAJAMARCA - JAEN - JAEN', '', '', 1, 2, '20539158334', 1, 'MICORREO@MAIL.COM', '', 60801, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(879, 'GERENCIA SUB REGIONAL CONDORCANQUI', 'JR. AMAZONAS NRO. 200 JUAN VELASCO ALVARADO AMAZONAS - CONDORCANQUI - NIEVA', '', '', 1, 2, '20438491318', 1, 'MICORREO@MAIL.COM', '', 10601, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(880, 'GRUPO & INVERSIONES GINESTANO S.A.C.', 'AV. SAN JUAN MZA. A LOTE. 01 (GRIFO EL NORTEÑO PANAMERICA NORTE) LIMA - LIMA - PUENTE PIEDRA', '', '', 1, 2, '20553777586', 1, 'MICORREO@MAIL.COM', '', 140119, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(881, 'GAMARRA MUJICA MARCO ANTONIO', '', '', '', 1, 1, '19323460', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(882, 'DISTRIBUCIONES & IMPORTACIONES MUNDO FERRETEROS S.A.C.', 'CAL.LETICIA NRO. 550 LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20605146539', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(883, 'JORGUE LLUEN LLUEN', '', '', '', 1, 1, '16760093', 1, 'MICORREO@MAIL.COM', '', 130115, 0, '', 1, NULL, NULL, NULL, 0),
(884, 'CONSULTORA & CONSTRUCTORA ELIRID S.A.C.', 'CAL.LOS CARRIZOS MZA. M LOTE. 5 P.J. LOPEZ ALBUJAR LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20601664195', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(885, 'INVERS SERVIS MAKI S.A.C.', 'CAL.FEDERICO VILLAREAL NRO. 384 URB. LOS PARQUES LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20602010288', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(886, 'AGROKARU S.A.C.', 'CAR. ANTIGUA PANAMERICANA NORT FND. ALDANA Y ARANCIBIA KM. 64.4', '', '', 1, 2, '20547533497', 1, 'SANDRA@AGROKARU.COM', '', 130307, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(887, 'NARCISO CRIZANTO TIQUILLAGUIANCA', '', '', '', 1, 1, '6508995', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(888, 'AGROINVERSIONES PEJE S.A.C', 'AV. LA CULTURA NRO 808 INT. B103 GRAN MERCADO MAYORISTA- G', '', '', 1, 2, '20603253222', 1, 'MICORREO@MAIL.COM', '', 140143, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(889, 'AGROINDUSTRIAL DEL PERU SOCIEDAD ANONIMA CERRADA', 'AV. REPUBLICA DE PANAMA NRO. 2461 URB. SANTA CATALINA (ENTRE VIA EXPRESA Y JAVIER PRADO) LIMA - LIMA - LA VICTORIA', '', '', 1, 2, '20506475288', 1, 'MICORREO@MAIL.COM', '', 140109, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(890, 'EDAGAR SAMORA LORA', '', '', '', 1, 1, '16767034', 1, 'MICORREO@MAIL.COM', '', 130105, 0, '', 1, NULL, NULL, NULL, 0),
(891, 'COMISION DE REGANTES SUB SECTOR DE RIEGO CIUDAD ETEN', 'CAL.PEDRO RUIZ NRO. 648 CENTRO LAMBAYEQUE - CHICLAYO - ETEN', '', '', 1, 2, '20193214364', 1, 'MICORREO@MAIL.COM', '', 130103, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(892, 'COMISION DE USUARIOS DEL SUB SECTOR HIDRAULICO MOCHUMI', 'CAL.FEDERICO VILLAREAL NRO. 098 URB. MOCHUMI LAMBAYEQUE - LAMBAYEQUE - MOCHUMI', '', '', 1, 2, '20174494518', 1, 'MICORREO@MAIL.COM', '', 130305, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(893, 'ABRAHAN SANTA CRUZ', '', '', '', 1, 1, '46681316', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(894, 'ANTHOLIN LUCAS NAVARRO TUME', '', '', '931126981', 1, 1, '48383334', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(895, 'SANTOS FARFAN SALCEDO', '', '', '', 1, 1, '80543442', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(896, 'JOSE CHAPOÑAN RODRGUEZ', '', '', '', 1, 1, '42263695', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(897, 'TORRES GUIDINO ROLANDO ESMILTON', '', '', '', 1, 1, '16678023', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(898, 'MUNICIPALIDAD DISTRITAL DE POMALCA', 'AV. APOLINARIO SALCEDO NRO. S/N (EX HOSPITAL POMALCA) LAMBAYEQUE - CHICLAYO - POMALCA', '', '', 1, 2, '20396129508', 1, 'MICORREO@MAIL.COM', '', 130118, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(899, 'REYES INOÑAN FAUSTINO RUBEN', 'ASOCIACION LAS COLINAS 1ERA ETAPA MZN LT5 LOS DOMINICOS CALLAO - CALLAO', '', '', 1, 2, '10408338552', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(900, 'OLBER CALINCORDOVA PALACIOS', '', '', '', 1, 1, '70613328', 1, 'MICORREO@MAIL.COM', '', 190101, 0, '', 1, NULL, NULL, NULL, 0),
(901, 'MANUALA MAYRA IPANAQUE', '', '', '', 1, 1, '16657839', 1, 'MICORREO@MAIL.COM', '', 130110, 0, '', 1, NULL, NULL, NULL, 0),
(902, 'RUTH JARA FUSTAMANTE', '', '', '', 1, 1, '45917151', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(903, 'TECNI MOTORS DEL PERU E.I.R.L.', 'CAL.FRANCISCO CUNEO NRO. 1150 INT. A URB. PATAZCA INDUSTRIAL (FRANCISCO CUNEO 1150A-FRENTE A COMISARIA) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20487467139', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(904, 'JOSE MARCELINO GUEVARA', '', '', '', 1, 1, '40296592', 1, 'MICORREO@MAIL.COM', '', 60501, 0, '', 1, NULL, NULL, NULL, 0),
(905, 'DISTRIBUCIONES E.M.I. S.A.C.', 'AV. ARICA NRO. 815 URB. CERCADO DE CHICLAYO LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20352813711', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(906, 'CUEVA VEGA LUIS ENRIQUE', '', '', '', 1, 1, '27969293', 1, 'MICORREO@MAIL.COM', '', 61003, 0, '', 1, NULL, NULL, NULL, 0),
(907, 'LADY LESLI FERNANDEZ VALLEJOS', '', '', '', 1, 1, '74094557', 1, 'MICORREO@MAIL.COM', '', 60501, 0, '', 1, NULL, NULL, NULL, 0),
(908, 'LUIS PORFIRIO SANCHEZ DE LA CRUZ', '', '', '948237241', 1, 1, '17447431', 1, 'MICORREO@MAIL.COM', '', 130202, 0, '', 1, NULL, NULL, NULL, 0),
(909, 'LUIS ALBERTO AGUILAR RAMOS', '', '', '', 1, 1, '27428795', 1, 'MICORREO@MAIL.COM', '', 190601, 0, '', 1, NULL, NULL, NULL, 0),
(910, 'CERNA VASQUEZ ENO ELIUT', 'UPIS SAN MARTIN MZJ LOTE 27', '', '', 1, 2, '10458084748', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(911, 'JOSE FELICIANO SANCHEZ GONZALES', '', '', '', 1, 1, '16627418', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(912, 'DESINFECCION SANITIZACION LIMPIEZA SOLUCIONES INTEGRALES SAC', 'CAL.CORONEL LEONCIO PRADO NRO. 1711 P.J. SAN ANTONIO LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20606137550', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(913, 'JOSE BALTAZAR BALLENA GUERRERO', '', '', '955214248', 1, 1, '46121120', 1, 'MICORREO@MAIL.COM', '', 130111, 0, '', 1, NULL, NULL, NULL, 0),
(914, 'AGROBEANS SRL', 'CAL. AREQUIPA NORTE NRO 254 URB. PATAZCA', '', '', 1, 2, '20480229011', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(915, 'PETRONILA LIDA BURGA DE LA CRUZ', '', '', '', 1, 1, '17630823', 1, 'MICORREO@MAIL.COM', '', 130310, 0, '', 1, NULL, NULL, NULL, 0),
(916, 'THE GOLD CORPORATION SOCIEDAD COMERCIAL DE RESPONSABILIDAD LIMITADA', 'CAL.JUAN VELASCO ALVARADO NRO. 0266 CENT. LA UNION (CERCA A FUNERARIA SANTOS) PIURA - PIURA - LA UNION', '', '', 1, 2, '20602601316', 1, 'MICORREO@MAIL.COM', '', 40405, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(917, 'MONTENEGRO PERALES MALIS EDITA', '', '', '', 1, 2, '10438873258', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(918, 'NEGOCIACIONES INTI QURI S.A.C.', 'CAL.LOS CLAVELES NRO. 148 URB. SANTA VICTORIA LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20600653122', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(919, 'NEGOCIACIONES IBIS EMPRESA INDIVIDUAL DE RESPONSABILIDAD LIMITADA', 'JR. LAS MORERAS NRO. 122 INT. 87 URB. LA PORTADA DE CERES LIMA - LIMA - SANTA ANITA', '', '', 1, 2, '20602512186', 1, 'MICORREO@MAIL.COM', '', 140143, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(920, 'EBE SANTISTEBAN SUCLUPE', '', '', '', 1, 1, '42460256', 1, 'MICORREO@MAIL.COM', '', 230101, 0, '', 1, NULL, NULL, NULL, 0),
(921, 'IVAN GONZALES AYASTA', '', '', '', 1, 1, '75521823', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(922, 'COMERCIAL MAQUIMOTORS EIRL', 'AV. NICOLAS ARRIOLA NRO. 2000 URB. MARISCAL RAMON CASTILLA (EN LA MISMA CUADRA DE TRANSPORTES MOLINA) LIMA - LIMA - SAN LUIS', '', '', 1, 2, '20527401853', 1, 'MICORREO@MAIL.COM', '', 140138, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(923, 'COMUNIDAD CAMPESINA SAN JULIAN DE MOTUPE', 'CAL.SAN JOSE NRO. 179 LAMBAYEQUE - LAMBAYEQUE - MOTUPE', '', '', 1, 2, '20202410121', 1, 'MICORREO@MAIL.COM', '', 130307, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(924, 'CINTHIA RICRA REYES', '', '', '944224306', 1, 1, '45933635', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(925, 'AGRICOLA SANTA LUCIA S.A.', 'AV. CENTENARIO NRO 346 INT. 4', '', '', 1, 2, '20279153708', 1, 'MICORREO@MAIL.COM', '', 100205, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(926, 'JULIO CESAR NEPO MORA', '', '', '', 1, 1, '42127631', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(927, 'SERVICIOS INTEGRADOS DE LIMPIEZA SA (SIL SA)', 'CAL.LOS NEGOCIOS NRO. 336 URB. LIMATAMBO LIMA - LIMA - SURQUILLO', '', '', 1, 2, '20100362598', 1, 'MICORREO@MAIL.COM', '', 140131, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(928, 'SAN JOSE CONTRATISTAS Y SERVICIOS GENERALES SAC', 'CAL.ARENALES NRO. 347A P.J. DIEGO FERRE (ESPALDAS DE PROMART) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20491617439', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(929, 'BASF PERUANA S A', 'AV. OSCAR R BENAVIDES NRO. 5915 Z.I. PQUE INTERNACION PROV. CONST. DEL CALLAO - PROV. CONST. DEL CALLAO - CALLAO', '', '', 1, 2, '20100006376', 1, 'MICORREO@MAIL.COM', '', 240101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(930, 'AGRO QALLARIY SOCIEDAD ANONIMA CERRADA - AGRO QALLARIY S.A.C.', 'CAL. EL PARQUE NRO 142 URB. SANTA ISABEL', '', '', 1, 2, '20602887473', 1, 'MICORREO@MAIL.COM', '', 190101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(931, 'AGRO-ESCUTE EMPRESA INDIVIDUAL DE RESPONSABILIDAD LIMITADA', 'CAL. 7 DE ENERO NRO 633 INT. 201 CERCADO DE CHICLAYO', '', '', 1, 2, '20602445977', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(932, 'SANTOS INGARUCA RICHARD DAVID', 'JR. JOSE OLAYA 1037', '', '', 1, 2, '10100461175', 1, 'MICORREO@MAIL.COM', '', 210601, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(933, 'JULIO PEREZ COTRINA', '', '', '', 1, 1, '16547613', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(934, 'CONSTRUCTORA Y CONSULTORA QUETZAL S.A.C.', 'CAL.LA FLORIDA NRO. 688B URB. SAN EDUARDO (LA FLORIDA 688-B SEGUNDO PISO) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20487655563', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(935, 'CELSTINO CORREA CEPEDES', '', '', '997441000', 1, 1, '27413161', 1, 'MICORREO@MAIL.COM', '', 60611, 0, '', 1, NULL, NULL, NULL, 0),
(936, 'LUIS ALBERTO BENITES SUCLUPE', '', '', '', 1, 1, '16741725', 1, 'MICORREO@MAIL.COM', '', 130312, 0, '', 1, NULL, NULL, NULL, 0),
(937, 'ARQUITRONICA S.A.C.', 'MZA. I LOTE. 3 URB. EL INGENIERO (ESPALDA DE COLEGIO DE OBSTETRAS) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20600679377', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(938, 'LOPEZ MANOSALVA JUAN CARLOS', '', '', '', 1, 1, '41351737', 1, 'MICORREO@MAIL.COM', '', 120901, 0, '', 1, NULL, NULL, NULL, 0),
(939, 'LIVIA CHAVEZ FRAWK ROGER', '', '', '', 1, 2, '10439368689', 1, 'MICORREO@MAIL.COM', '', 190101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(940, 'SABINO DIAZ SANCHEZ', '', '', '', 1, 1, '17616381', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(941, 'RODAS CERDAN JOSE LEONARDO', 'UDIMA', '', '968735550', 1, 1, '41475391', 1, 'MICORREO@MAIL.COM', '', 60902, 0, '', 1, NULL, NULL, NULL, 0),
(942, 'SANIDAD AGROPECUARIA S.A.C.', 'CAL.FRANCISCO CABRERA NRO. 112 CERCADO LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20162201914', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(943, 'MEDICAL DRUG SOCIEDAD ANONIMA CERRADA', 'CAL.EUGENIO MOYA NRO. 278 URB. CERCADO DE CHICLAYO LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20487558878', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(944, 'MIGUEL CABANILLAS MENDOZA', '', '', '974899900', 1, 1, '45528197', 1, 'MICORREO@MAIL.COM', '', 120902, 0, '', 1, NULL, NULL, NULL, 0),
(945, 'IE SAGRADO CORAZON DE JESUS', 'PEDRO HUARMACA', '', '', 1, 3, '', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(946, 'SANTOS MANUEL APONTE CAMACHO', '', '', '', 1, 1, '3652689', 1, 'MICORREO@MAIL.COM', '', 190601, 0, '', 1, NULL, NULL, NULL, 0),
(947, 'MUNICIPALIDAD DISTRITAL DE OLMOS', 'CAL.SANTO DOMINGO NRO. 886 CERCADO LAMBAYEQUE - LAMBAYEQUE - OLMOS', '', '', 1, 2, '20175975315', 1, 'MICORREO@MAIL.COM', '', 130308, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(948, 'DEPOSITO PAKATNAMU E.I.R.L.', 'AV. AUGUSTO B. LEGUIA NRO. 1050 URB. SAN LORENZO LAMBAYEQUE - CHICLAYO - JOSE LEONARDO ORTIZ', '', '', 1, 2, '20131719559', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(949, 'HEBERT CORDOVA PINTADO', '', '', '', 1, 1, '3374072', 1, 'MICORREO@MAIL.COM', '', 190404, 0, '', 1, NULL, NULL, NULL, 0),
(950, 'ALMACENES LOGISTICOS AGROINDUSTRIALES DEL PERU SOCIEDAD ANONIMA CERRADA', 'AV. JOSE BALTA NRO. 1149 INT. 200 (IFICINA 200 PISO 2DO) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20601715181', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(951, 'CHAVEZ TIRADO HEYNER ALBITER', 'CASERIO PAMPA DE LINO ANEXO ASOC LAS PALMERAS', '', '', 1, 2, '10486009361', 1, 'ANYETHAGRO@OUTLOOK.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(952, 'F & E INGENIEROS CIVILES S.R.L.', 'ALM.LOS PICAFLORES NRO. 166 INT. 202 URB. CHACARILLA DEL ESTANQUE LIMA - LIMA - SAN BORJA', '', '', 1, 2, '20561383317', 1, 'MICORREO@MAIL.COM', '', 140140, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(953, 'SOCIEDAD PUBLICA DE BENEFICENCIA CUTERV', 'JR. COMERCIO NRO. 452 CAJAMARCA - CUTERVO - CUTERVO', '', '', 1, 2, '20196021095', 1, 'MICORREO@MAIL.COM', '', 60501, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(954, 'VICTOR HUGO SERNAQUE PALMA', '', '', '', 1, 1, '45900619', 1, 'MICORREO@MAIL.COM', '', 120901, 0, '', 1, NULL, NULL, NULL, 0),
(955, 'NESYSER KUSQUE SERRATO', '', '', '', 1, 1, '75359610', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(956, 'CARRERA DAVALOS LALDY ISAIAS', 'JR. BUENOS AIRES 188 YONAN CONTUMAZA CAJAMARCA', '', '', 1, 2, '10271642241', 1, 'MICORREO@MAIL.COM', '', 60408, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(957, 'JOSE RODRIGUEZ PEREZ', '', '', '988679832', 1, 1, '45388674', 1, 'MICORREO@MAIL.COM', '', 130304, 0, '', 1, NULL, NULL, NULL, 0),
(958, 'LIBRERIA E IMPORTADORA DIEGO ANDRE E.I.R.L.', 'JR. EZEQUIEL MONTOYA NRO. 449 CENT CHOTA CAJAMARCA - CHOTA - CHOTA', '', '', 1, 2, '20601466130', 1, 'MICORREO@MAIL.COM', '', 60601, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(959, 'SEGUNDO GERARDO SORRILLA CIEZA', '', '', '959013150', 1, 1, '33575223', 1, 'MICORREO@MAIL.COM', '', 120901, 0, '', 1, NULL, NULL, NULL, 0),
(960, 'MILTON ALFONZO RUIZ', '', '', '', 1, 1, '42893247', 1, 'MICORREO@MAIL.COM', '', 120503, 0, '', 1, NULL, NULL, NULL, 0),
(961, 'FREDY PÁUCAR LARICO DNI', '', '', '', 1, 1, '44761789', 1, 'MICORREO@MAIL.COM', '', 40413, 0, '', 1, NULL, NULL, NULL, 0),
(962, 'INTELEC PERU S.A.C.', 'CAL.FELIPE DE ZELA NRO. 505 URB. LOS FICUS LIMA - LIMA - SANTA ANITA', '', '', 1, 2, '20265753460', 1, 'MICORREO@MAIL.COM', '', 140143, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(963, 'FUMIGACIONES DESINFECCIONES SERVICIOS GENERALES VITA MALATESTA E.I.R.L.', 'PJ. INDEPENDENCIA NRO. 137 P.J. JOSE SANTOS CHOCANO LAMBAYEQUE - CHICLAYO - JOSE LEONARDO ORTIZ', '', '', 1, 2, '20601128773', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(964, 'ALJUFA SAC', 'AV. BATANGRANDE NRO. 100 U.V. HECTOR AURICH SOTO LAMBAYEQUE - FERREÑAFE - FERREÑAFE', '', '', 1, 2, '20480651554', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(965, 'PITERSON ALARCON ROJAS', '', '', '', 1, 1, '40073491', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(966, 'MAGALY MACO ODAR', '', '', '932965861', 1, 1, '45248859', 1, 'MICORREO@MAIL.COM', '', 130308, 0, '', 1, NULL, NULL, NULL, 0),
(967, 'CABRERA ALARCON RENE', '', '', '', 1, 2, '10418322832', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(968, 'GRIMALDO TOCTO BAUTISTA', 'NUMERO SERIE 03U58TS', '', '', 1, 1, '27428484', 1, 'MICORREO@MAIL.COM', '', 130201, 0, '', 1, NULL, NULL, NULL, 0),
(969, 'JUAN CARLOS YAIPEN LLONTOP', '', '', '', 1, 1, '45402610', 1, 'MICORREO@MAIL.COM', '', 130106, 0, '', 1, NULL, NULL, NULL, 0),
(970, 'FRANCISCO JULCA BURGA', '', '', '950217665', 1, 1, '10554635', 1, 'MICORREO@MAIL.COM', '', 60902, 0, '', 1, NULL, NULL, NULL, 0),
(971, 'JORGUE MACALUPU SIESQUEN', '', '', '', 1, 1, '17403294', 1, 'MICORREO@MAIL.COM', '', 130201, 0, '', 1, NULL, NULL, NULL, 0),
(972, 'MOISES FREDY FERNANDEZ ALFARO', '', '', '', 1, 1, '16695675', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(973, 'GLORIA CORTEZ CHICOMA', '', '', '', 1, 1, '17570174', 1, 'MICORREO@MAIL.COM', '', 130307, 0, '', 1, NULL, NULL, NULL, 0),
(974, 'JOSE DIONISIO TORRES CHAVARRIA', '', '', '', 1, 1, '27924253', 1, 'MICORREO@MAIL.COM', '', 120508, 0, '', 1, NULL, NULL, NULL, 0),
(975, 'I.E. NÑ 10006 \"ARTURO SCHUTT Y SACO\"', 'AV. CHICLAYO NRO. 2221 LAMBAYEQUE - CHICLAYO - CHONGOYAPE', '', '', 1, 2, '20602106846', 1, 'MICORREO@MAIL.COM', '', 130102, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(976, 'PAUL SISNEROS RAMOS', '', '', '926158378', 1, 1, '3678422', 1, 'MICORREO@MAIL.COM', '', 190601, 0, '', 1, NULL, NULL, NULL, 0),
(977, 'PEDRO GALLO NUÑEZ', '', '', '', 1, 1, '43445638', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(978, 'JOSE LUIS MANAYALLI BARBOZA', '', '', '956716518', 1, 1, '45108119', 1, 'MICORREO@MAIL.COM', '', 130202, 0, '', 1, NULL, NULL, NULL, 0),
(979, 'JAIME IRIGOIN MEGO', '', '', '965656171', 1, 1, '48040484', 1, 'MICORREO@MAIL.COM', '', 60619, 0, '', 1, NULL, NULL, NULL, 0),
(980, 'MARFREEZE S.A.C.', 'JR. INDUSTRIALES NRO. 587 INT. PSO1 (ALT CDRA 4 DE CONSTRUCTORES) LIMA - LIMA - LA MOLINA', '', '', 1, 2, '20602721231', 1, 'MICORREO@MAIL.COM', '', 140110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(981, 'FABRINOR ACEROS D & E E.I.R.L', 'AV. PEDRO RUIZ GALLO NRO. 448 URB. EL PORVENIR (FRENTE DE CASA BEBE) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20603354363', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(982, 'ASENJO CARRANZA CARLOS FERNANDO', '', '', '', 1, 2, '10720510176', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(983, 'BRIONES SILVA DAVID MAGNO', 'VIA EVITAMIENDO 669 PACASMAYO', '', '', 1, 2, '10192310046', 1, 'MICORREO@MAIL.COM', '', 120506, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(984, 'OVER ELIAS SILVA BELLO', '', '', '', 1, 1, '80445216', 1, 'MICORREO@MAIL.COM', '', 130105, 0, '', 1, NULL, NULL, NULL, 0),
(985, 'CRISTIAN ANGELO TENORIO LEONARDO', '', '', '', 1, 1, '76563425', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(986, 'CARLOS GONZALES DIAZ', '', '', '', 1, 1, '16730005', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(987, 'HUERTA ROJAS NOE', '', '', '', 1, 2, '10102660060', 1, 'MICORREO@MAIL.COM', '', 190101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(988, 'RAMIREZ BAQUERIZO JOSE JHONATAN', 'OLLANTAY 290', '', '', 1, 2, '10450427549', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(989, 'JOHN ALVARADO LOPEZ', '', '', '', 1, 1, '41644262', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(990, 'EMPRESA ESTRELLA SANTA DIVINA S.R.L', 'AV. TUMBES NRO. 450 TUMBES - TUMBES - TUMBES', '', '', 1, 2, '20603875312', 1, 'MICORREO@MAIL.COM', '', 230101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(991, 'FUNDO LA BODEGA S.A.C.', 'CAL.LOS AYMARAS NRO. 180 URB. MARANGA LIMA - LIMA - SAN MIGUEL', '', '', 1, 2, '20600638131', 1, 'MICORREO@MAIL.COM', '', 140127, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(992, 'INVERSIONES MARISAGUA S.A.C.', 'CAL.ALFONSO UGARTE NRO. 974 DPTO. 201 CENTRO (2DO PISO) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20480348967', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(993, 'NUCLEO EJECUTOR DE ACTIVIDADES DE MANTENIMIENTO DE CANALES DE RIEGO DEL SUB SECTOR HIDRAULICO ARROZAL', '', '', '', 1, 1, '17617535', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(994, 'RUIZ ARCA YULLIANA DEL CARMEN', 'LUIS GONZALES 739 CERCADO', '', '', 1, 2, '10405645241', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(995, 'MARCOS FALEN MARTINEZ', 'PARAGUAY MZ LOTE 26', '', '', 1, 1, '16775276', 1, 'MICORREO@MAIL.COM', '', 130112, 0, '', 1, NULL, NULL, NULL, 0),
(996, 'SYNGENTA CROP PROTECTION SA, SUCURSAL DEL PERU', 'AV. MANUEL OLGUÑN NRO. 335 INT. 808 URB. LOS GRANADOS LIMA - LIMA - SANTIAGO DE SURCO', '', '', 1, 2, '20501511740', 1, 'MICORREO@MAIL.COM', '', 140130, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(997, 'NEGOCIOS TURISTICOS DEL NORTE S.A.C', 'AV. REDUCTO NRO. 1278 LIMA - LIMA - MIRAFLORES', '', '', 1, 2, '20352730425', 1, 'MICORREO@MAIL.COM', '', 140115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(998, 'PLANTA DE RESERVA FRIA DE GENERACION DE ETEN S.A.', 'CAL.AMADOR MERINO REYNA NRO. 267 INT. 902 (EDIFICIO PARQUE PLAZA) LIMA - LIMA - SAN ISIDRO', '', '', 1, 2, '20544229118', 1, 'MICORREO@MAIL.COM', '', 140124, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(999, 'JESUS ORTIZ MILLONES', '', '', '', 1, 1, '16689851', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1000, 'ALEJANDRO TINEO CARRASCO', '', '', '', 1, 1, '45680705', 1, 'MICORREO@MAIL.COM', '', 190101, 0, '', 1, NULL, NULL, NULL, 0),
(1001, 'MIGUEL ANGEL GASTELO DELGADO', '', '', '', 1, 1, '43650061', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1002, 'INGENIERIA CIVIL MONTAJES S.A.', 'AV. FELIPE S. SALAVERRY NRO. 650 URB. PATAZCA (PISO 10) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20353947614', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1003, 'CELEDONIA VARGAS GONZA', '', '', '920141936', 1, 1, '80421974', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1004, 'WILMER DAMIAN BARRETO', '', '', '944622364', 1, 1, '45912910', 1, 'MICORREO@MAIL.COM', '', 130312, 0, '', 1, NULL, NULL, NULL, 0),
(1005, 'CARLOS ALBERTO YARLAQUE MONTALVO', '', '', '939105288', 1, 1, '17628467', 1, 'MICORREO@MAIL.COM', '', 130306, 0, '', 1, NULL, NULL, NULL, 0),
(1006, 'INVERSIONES & NEGOCIOS TIMANA SAC', 'JR. HIPOLITO UNANUE NRO. 1352 DPTO. 20 INT. 214 URB. EL PORVENIR LIMA - LIMA - LA VICTORIA', '', '', 1, 2, '20605788395', 1, 'MICORREO@MAIL.COM', '', 140109, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1007, 'COSECHA SEGURA S.A.C.', 'MZA. O LOTE. 19 URB. LOS COCOS DEL CHIPE PIURA - PIURA - PIURA', '', '', 1, 2, '20600734670', 1, 'JUAN.SOFT@HOTMAIL.COM', '', 190101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1008, 'I.E. NÑ11098 JUAN PABLO II', 'CAL.LLOQUE LLUPANQUI NRO. 1875 P.J. EL BOSQUE LAMBAYEQUE - CHICLAYO - LA VICTORIA', '', '', 1, 2, '20602164803', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1009, 'CHAPOÑAN FARROÑAN ROBERTO CARLOS', '', '', '916011987', 1, 2, '10431356444', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1010, 'MAXIMO RAMOS NAQUICHE', '', '', '957487691', 1, 1, '41002115', 1, 'MICORREO@MAIL.COM', '', 130205, 0, '', 1, NULL, NULL, NULL, 0),
(1011, 'REPUESTOS Y FERRETERIA CRISTOPHER CAR E.I.R.L.', 'CAL.JUAN BUENDIA NRO. 430 Z.I. PATAZCA LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20601003962', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1012, 'CHAPOÑAN BANCES RAUL', '', '', '900568015', 1, 1, '17634265', 1, 'MICORREO@MAIL.COM', '', 130312, 0, '', 1, NULL, NULL, NULL, 0),
(1013, 'FUERZA AEREA DEL PERU', 'AV. LA PERUANIDAD NRO. SN CAMPO DE MARTE (NOTIF. A DIRECCION GENERAL DE ECONOMIA) LIMA - LIMA - JESUS MARIA', '', '', 1, 2, '20144364059', 1, 'MICORREO@MAIL.COM', '', 140133, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1014, 'MUCCHING RAMIREZ VICTOR DANIEL', 'URB.  SAN ANTONIO MZA C LOTE 35', '', '', 1, 2, '10414062518', 1, 'MICORREO@MAIL.COM', '', 190101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1015, 'GARCIA TUESTA ANDREA PAOLA', 'CALLE IQUITOS 360 URB. QUIÑONES', '', '', 1, 2, '10717899461', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1016, 'AYAY MENDOZA SAQUEO', '', '', '', 1, 1, '19229558', 1, 'MICORREO@MAIL.COM', '', 120501, 0, '', 1, NULL, NULL, NULL, 0),
(1017, 'JULCA AYAY JULIO FRANKLIN', '', '', '', 1, 1, '42727596', 1, 'MICORREO@MAIL.COM', '', 120501, 0, '', 1, NULL, NULL, NULL, 0),
(1018, 'INSTITUCION EDUCATIVA PRIVADA SANTO TORIBIO DE MOGROVEJO', 'AV. AUGUSTO B LEGUIA NRO. 2598 URB. CRUZ DE CHALPON LAMBAYEQUE - CHICLAYO - JOSE LEONARDO ORTIZ', '', '', 1, 2, '20352736547', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1019, 'SERVICIX E.I.R.L.', 'PJ. RIO CUMBIL NRO. 150 URB. FEDERICO VILLARREAL (2DO PISO) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20600770463', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1020, 'CASTREJON VASQUEZ JOSE ABEL', '', '', '', 1, 2, '10192551370', 1, 'MICORREO@MAIL.COM', '', 120901, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1021, 'DIEGO WILFREDO VILCHEZ JIRON', '', '', '', 1, 1, '47054116', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1022, 'VILCHEZ GIRON JERSON LANDER', '', '', '', 1, 2, '10481991027', 1, 'MICORREO@MAIL.COM', '', 190601, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1023, 'CARMEN MARTINEZ CANALES', '', '', '', 1, 1, '17639379', 1, 'MICORREO@MAIL.COM', '', 60101, 0, '', 1, NULL, NULL, NULL, 0),
(1024, 'SERVICIOS MULTIPLES JOACO SOCIEDAD COMERCIAL DE RESPONSABILIDAD LIMITADA', 'AV. PANAMERICANA NORTE NRO. 371 DPTO. B URB. BANCARIOS LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20602470289', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1025, 'DIEGO WILFREDO VILCHES GIRON', '', '', '', 1, 1, '47054116', 1, 'MICORREO@MAIL.COM', '', 190601, 0, '', 1, NULL, NULL, NULL, 0),
(1026, 'EMPRESA DE TRANSPORTES CHICLAYO S.A.', 'AV. JOSE LEONARDO ORTIZ NRO. 010 LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20103626448', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1027, 'JORGUE UCEDA GONZALES', '', '', '', 1, 1, '16723301', 1, 'MICORREO@MAIL.COM', '', 130106, 0, '', 1, NULL, NULL, NULL, 0),
(1028, 'PROYECTO ESPECIAL DE INFRAESTRUCTURA DE TRANSPORTE NACIONAL', 'JR. ZORRITOS NRO. 1203 LIMA CERCADO LIMA - LIMA - LIMA', '', '', 1, 2, '20503503639', 1, 'MICORREO@MAIL.COM', '', 140101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1029, 'MARTIN VILLEGAS VILCHEZ', '', '', '978401905', 1, 1, '17529821', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(1030, 'GARCIA PEREZ JORGE ANTONIO', '', '', '', 1, 2, '10416090403', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1031, 'CARLOS ALDANA CALDERON', '', '', '', 1, 1, '46190747', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1032, 'FILIBERTO GARCIA TAFUR', '', '', '937593600', 1, 1, '46517383', 1, 'MICORREO@MAIL.COM', '', 10409, 0, '', 1, NULL, NULL, NULL, 0),
(1033, 'LUIS PORTILLA TORO', '', '', '', 1, 1, '16800435', 1, 'MICORREO@MAIL.COM', '', 60801, 0, '', 1, NULL, NULL, NULL, 0),
(1034, 'CUBAS VILLALOBOS WILMER', '', '', '', 1, 1, '80626130', 1, 'MICORREO@MAIL.COM', '', 60101, 0, '', 1, NULL, NULL, NULL, 0),
(1035, 'CYTOPERU SOCIEDAD ANONIMA CERRADA', 'AV. ISAAC NEWTON NRO. 138 Z.I. SAN FRANCISCO (ENTRE EL PQE.LOS ANILLOS Y AV. FARADAY) LIMA - LIMA - ATE', '', '', 1, 2, '20520757423', 1, 'MICORREO@MAIL.COM', '', 140103, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1036, 'CORPORACION BIM SAC', 'CAL.TAHUANTINSUYO NRO. 1018 URB. SAN LORENZO LAMBAYEQUE - CHICLAYO - JOSE LEONARDO ORTIZ', '', '', 1, 2, '20480023235', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1037, 'HENRRY WILMER DAVILA BRAVO', '', '', '', 1, 1, '27430144', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1038, 'ESTUDIOS GEOTECNICOS Y ENSAYOS DE LABORATORIOS EMPRESA INDIVIDUAL DE RESPONSABILIDAD LIMITADA', 'CAL.AUGUSTO B. LEGUIA NRO. 1001 (CERCA DE COMPAÑÑA DE BOMBEROS) LAMBAYEQUE - FERREÑAFE - FERREÑAFE', '', '', 1, 2, '20600414004', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1039, 'JORGUE LUIS ODAR ROQUE', '', '', '', 1, 1, '45172093', 1, 'MICORREO@MAIL.COM', '', 130308, 0, '', 1, NULL, NULL, NULL, 0),
(1040, 'MACO MACO SANTOS HELBERT', '', '', '', 1, 2, '10176319181', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1041, 'ADELA ABIGAIL RODAS CASTAÑEDA', '', '', '', 1, 1, '71315318', 1, 'MICORREO@MAIL.COM', '', 120901, 0, '', 1, NULL, NULL, NULL, 0),
(1042, 'JUAN ANTONIO HERRERA PERES', '', '', '', 1, 1, '17448902', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1043, 'SEGUNDO JAVIER DIAZ CHAVEZ', '', '', '', 1, 1, '41314320', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1044, 'RIOJA HEREDIA EMERSON ALEXANDER', '', '', '', 1, 2, '10458242688', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1045, 'ORDONEZ COLLANTES HEBERTH YAIR', '', '', '978199880', 1, 1, '76748923', 1, 'MICORREO@MAIL.COM', '', 130119, 0, '', 1, NULL, NULL, NULL, 0),
(1046, 'JANY MIGUEL SAUCEDO MALCA', '', '', '', 1, 1, '80239865', 1, 'MICORREO@MAIL.COM', '', 120901, 0, '', 1, NULL, NULL, NULL, 0),
(1047, 'MARIANO SANTISTEBAN SOSA', '', '', '', 1, 1, '45185324', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1048, 'PUNTO ROJO FUMIGACIONES SOCIEDAD ANONIMA CERRADA', 'CAL.GAMMA NRO. 208 URB. PARQUE INTERNACIONAL (3ER PISO - ALT. PUERTA 5 DE LA UNMS) PROV. CONST. DEL CALLAO - PROV. CONST. DEL CALLAO - CALLAO', '', '', 1, 2, '20507865951', 1, 'MICORREO@MAIL.COM', '', 240101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1049, 'DMG', 'CAL.FAUSTINO SARMIENTO NRO. 243 CENTR CHICLAYO LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20604825025', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1050, 'LUIS CARLOS SARAVIA SANDOVAL', '', '', '', 1, 1, '41162695', 1, 'MICORREO@MAIL.COM', '', 60401, 0, '', 1, NULL, NULL, NULL, 0),
(1051, 'GRANJA SANTA MARCELA S.R.L.', 'AV. LOS ANGELES MZA. C LOTE. 14 Z.I. PARQUE INDUSTRIAL LIMA - LIMA - ATE', '', '', 1, 2, '20275928721', 1, 'MICORREO@MAIL.COM', '', 140103, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1052, 'ABARCA JARAMILLO ANTONIA', '', '', '', 1, 2, '10278249854', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1053, 'SERVIMOTOR E.I.R.L', 'AV. LUIS ANTONIO EGUIGUREN NRO. 1048 CENTRO DE PIURA (AL COSTADO GRIFO NEVADO) PIURA - PIURA - PIURA', '', '', 1, 2, '20440983261', 1, 'MICORREO@MAIL.COM', '', 190101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1054, 'TRANSPORTES J Y H EMANUEL E.I.R.L.', 'MZA. D LOTE. 14 URB. SANTA ELVIRA LA LIBERTAD - CHEPEN - CHEPEN', '', '', 1, 2, '20603514581', 1, 'MICORREO@MAIL.COM', '', 120901, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1055, 'JOSE CHAPOÑAN ZEÑA', '', '', '', 1, 1, '74820624', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(1056, 'VICTOR CORONADO ARROYO', '', '', '', 1, 1, '17617447', 1, 'ELIZAODAR@GMAIL.COM', '', 130308, 0, '', 1, NULL, NULL, NULL, 0),
(1057, 'TOMY ROJAS REYES', '', '', '', 1, 1, '44118892', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1058, 'BENITES ZUÑIGA FRESIA DEL PILAR', 'CALLE LAS PALMERAS CUADRA 3 URB. LOS ANGELES', '', '', 1, 2, '10277201378', 1, 'MICORREO@MAIL.COM', '', 60801, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1059, 'RAMOS MARZANA JESUS CARLOS', '', '', '', 1, 2, '10453607335', 1, 'MICORREO@MAIL.COM', '', 120101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1060, 'EJECUCION MANTENIMIENTO DE OBRAS DE INGENIERIA S.R.L.', 'CAL.TORRES PAZ NRO. 758 LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20487814114', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1061, 'IDELSO BAZAN MILIAN', '', '', '', 1, 1, '16665556', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1062, 'VALDERA MONTALVO EDGAR ABEL', 'CALLE NESTOR NAVARRO 118 URB LA PRIMAVERA 4 ETAPA', '', '', 1, 2, '10476375431', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1063, 'CORPORACION AGRICOLA OLMOS S.A.', 'AV. ALFREDO BENAVIDES NRO. 1944 INT. 504 URB. EL ROSEDAL (EDIFICIO SWISS TOWER) LIMA - LIMA - MIRAFLORES', '', '', 1, 2, '20563196387', 1, 'MICORREO@MAIL.COM', '', 40107, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1064, 'COBEÑAS SERNAQUE ROSA', '', '', '', 1, 2, '10028823199', 1, 'MICORREO@MAIL.COM', '', 190101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1065, 'JORGE CALVAY CRISANTO', '', '', '', 1, 1, '41907808', 1, 'MICORREO@MAIL.COM', '', 130308, 0, '', 1, NULL, NULL, NULL, 0),
(1066, 'JORGUE LUIS CHAVES RUBIO', '', '', '', 1, 1, '19254669', 1, 'MICORREO@MAIL.COM', '', 120901, 0, '', 1, NULL, NULL, NULL, 0),
(1067, 'RED DE DISTRIBUCION GALVEZ SOCIEDAD ANONIMA CERRADA', 'CAL.TERESA DE CALCUTA KM. 001 FND. CHACUPE (ANTIGUA CARRETERA MONSEFU) LAMBAYEQUE - CHICLAYO - LA VICTORIA', '', '', 1, 2, '20508457457', 1, 'CONTATABILIDADREGIGAL@LADRILLOSITALPERU.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1068, 'ZEÑA CARRASCO GERMAN ARMANDO', '', '', '', 1, 2, '10733245510', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1069, 'YNOÑAN ZEÑA RAUL', '', '', '912065151', 1, 1, '42619260', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(1070, 'ANDRES LLONTOP FIGUEROA', '', '', '', 1, 1, '17414848', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1071, 'SOLIS GASTRONOMICA SOCIEDAD ANONIMA CERRADA SOLIS GASTRONOMICA S.A.C.', 'AV. REDUCTO NRO. 1278 URB. ARMENDARIZ (ALT 28 DE JULIO CON LA AV. REDUCTO) LIMA - LIMA - MIRAFLORES', '', '', 1, 2, '20548121672', 1, 'MICORREO@MAIL.COM', '', 140115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1072, 'UGAZ & UGAZ INGENIEROS SRL', 'AV. JOSE QUIÑONES 066', '', '', 1, 2, '20561275344', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1073, 'I.E N 10023', 'CAL.FRANCISCO CABRERA NRO. 1486 P.J. SUAZO LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20602149839', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1074, 'ANGEL CIEZA HURTADO', '', '', '', 1, 1, '1153943', 1, 'MICORREO@MAIL.COM', '', 210508, 0, '', 1, NULL, NULL, NULL, 0),
(1075, 'CINDY SAMPEN PECHE', '', '', '', 1, 1, '46350673', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1076, 'FERRE URRUTIA CARLOS', '', '', '', 1, 2, '10165956601', 1, 'MICORREO@MAIL.COM', '', 130111, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1077, 'EDITA TORRES GAMARRA', '', '', '', 1, 1, '16469396', 1, 'MICORREO@MAIL.COM', '', 61007, 0, '', 1, NULL, NULL, NULL, 0),
(1078, 'INGESA ORIENTE S.A.C.', 'CAL.VICENTE DE LA VEGA NRO. 298 URB. EL PORVENIR (INTERIOR C) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20601045266', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1079, 'JAIME SANTACRUZ CIENFUEGOS', '', '', '', 1, 1, '19247291', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1080, 'GILMER CUBAS PINEDO', '', '', '', 1, 1, '70880163', 1, 'MICORREO@MAIL.COM', '', 130111, 0, '', 1, NULL, NULL, NULL, 0),
(1081, 'PADILLA ALAYO ULMER ARCELIO', '', '', '', 1, 2, '10164800721', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1082, 'CLAV INVER AGRICOLA E.I.R.L.', 'CAL.PAUL HARRIS NRO. 1710 URB. LA VICTORIA SC. TRES LAMBAYEQUE - CHICLAYO - LA VICTORIA', '', '', 1, 2, '20488089723', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1083, 'UNIDAD EJECUTORA 004 GERENCIA ADMINISTRATIVA DE LAMBAYEQUE', 'AV. MANUEL MARIA IZAGA NRO. 115 CENTRO LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20487879241', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1084, 'MILTON IVAN SUCLUPE SATORNICIO', '', '', '', 1, 1, '45450911', 1, 'MICORREO@MAIL.COM', '', 190303, 0, '', 1, NULL, NULL, NULL, 0),
(1085, 'DEMETRIO VERA VASQUEZ', '', '', '', 1, 1, '27275300', 1, 'MICORREO@MAIL.COM', '', 130204, 0, '', 1, NULL, NULL, NULL, 0),
(1086, 'ERIKSON CHUJUTALLI PAJAMA', '', '', '', 1, 1, '43061516', 1, 'MICORREO@MAIL.COM', '', 130312, 0, '', 1, NULL, NULL, NULL, 0),
(1087, 'RAUL FERNANDO RAMIRES SOPLAPUCO', '', '', '', 1, 1, '43162327', 1, 'MICORREO@MAIL.COM', '', 130308, 0, '', 1, NULL, NULL, NULL, 0),
(1088, 'FRUTOS TROPICALES DEL NORTE SA', 'CAL.EL MAESTRO NRO. 610 INT. 1 (KM 848 ANTIGUA CAR PAN NORTE) LAMBAYEQUE - LAMBAYEQUE - MOTUPE', '', '', 1, 2, '20394897249', 1, 'MICORREO@MAIL.COM', '', 130307, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1089, 'MIGUEL CHAVEZ CADENILLAS', '', '', '959602075', 1, 1, '44314729', 1, 'MICORREO@MAIL.COM', '', 130111, 0, '', 1, NULL, NULL, NULL, 0),
(1090, 'MORALES INGENIERO EIRL', 'JR. SAN MARTIN NRO. 430 LA LIBERTAD - CHEPEN - CHEPEN', '', '', 1, 2, '20481945322', 1, 'MICORREO@MAIL.COM', '', 120901, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1091, 'GRUPO MCM AMBIENTAL SOCIEDAD ANONIMA CERRADA', 'JR. LOS PINOS NRO. 105 PROV. CONST. DEL CALLAO - PROV. CONST. DEL CALLAO - BELLAVISTA', '', '', 1, 2, '20602692419', 1, 'MICORREO@MAIL.COM', '', 60802, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1092, 'SANCHEZ ALFARO JORGE MISAEL', 'CALLE TRADICCIONES 466', '', '', 1, 2, '10412005355', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1093, 'LADY DIANA PRETELL SAMAN', 'BAGUA CHICA', '', '', 1, 1, '42000160', 1, 'MICORREO@MAIL.COM', '', 10205, 0, '', 1, NULL, NULL, NULL, 0),
(1094, 'JORGUE CHERO CHANDUY', '', '', '927335110', 1, 1, '45061576', 1, 'MICORREO@MAIL.COM', '', 130306, 0, '', 1, NULL, NULL, NULL, 0),
(1095, 'JOSE CHUZON DAVILA', '', '', '', 1, 1, '42337335', 1, 'MICORREO@MAIL.COM', '', 130308, 0, '', 1, NULL, NULL, NULL, 0),
(1096, 'CHUZON DAVILA JOSE TEOFILO', '', '', '', 1, 2, '10423373356', 1, 'MICORREO@MAIL.COM', '', 130308, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1097, 'CORPORACION FABRINOX EIRL', 'AV. LA UNION NRO. 1125 URB. LA VICTORIA SC. UNO LAMBAYEQUE - CHICLAYO - LA VICTORIA', '', '', 1, 2, '20606495405', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1098, 'PEDRO AYALA MANAYAY', '', '', '921443145', 1, 1, '16506015', 1, 'MICORREO@MAIL.COM', '', 120901, 0, '', 1, NULL, NULL, NULL, 0),
(1099, 'INVERSIONES & NEGOCIOS PAREDES S.A.C', 'CAL.FRANCISCO CUNEO NRO. 922 URB. PATAZCA (A MEDIA CUADRA DEL BCP) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20487769909', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1100, 'EDUAR MARTINEZ', '', '', '', 1, 1, '45792924', 1, 'MICORREO@MAIL.COM', '', 130112, 0, '', 1, NULL, NULL, NULL, 0),
(1101, 'CUZCO CRUZ MARIA HORMECINDA', '', '', '', 1, 2, '10748330360', 1, 'MICORREO@MAIL.COM', '', 60403, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1102, 'JOSE ALBERTO SERQUEN CHAVESTA', '', '', '', 1, 1, '17414169', 1, 'MICORREO@MAIL.COM', '', 130201, 0, '', 1, NULL, NULL, NULL, 0),
(1103, 'RONALDO OLIVOS VENTURA', '', '', '992769005', 1, 1, '75882977', 1, 'MICORREO@MAIL.COM', '', 60902, 0, '', 1, NULL, NULL, NULL, 0),
(1104, 'VICTOR GONZALES VITON', '', '', '', 1, 1, '46798811', 1, 'MICORREO@MAIL.COM', '', 130115, 0, '', 1, NULL, NULL, NULL, 0),
(1105, 'JHON BAYONA PINGO', '', '', '957501498', 1, 1, '76267693', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(1106, 'HEINER EMILI ALAYA ESPINOZA', '', '', '991165440', 1, 1, '10388098', 1, 'MICORREO@MAIL.COM', '', 61010, 0, '', 1, NULL, NULL, NULL, 0),
(1107, 'CONSTRUCTORA VALLE REQUE S.A.C.', 'AV. V RAUL HAYA TORRE NRO. 349 LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20603865830', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1108, 'JOSE ELMER BANCES RIOJAS', '', '', '', 1, 1, '48277014', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1109, 'IE10179 GUSTAVO MONME LLONA', 'LA CAPILLA CENTRAL -OLMOS', '', '', 1, 1, '16738147', 1, 'MICORREO@MAIL.COM', '', 130308, 0, '', 1, NULL, NULL, NULL, 0),
(1110, 'IEI 338 -CASHIRCA', 'CASHIRCA-SALAS', '', '', 1, 1, '16681511', 1, 'MICORREO@MAIL.COM', '', 130310, 0, '', 1, NULL, NULL, NULL, 0),
(1111, 'MARTINEZ VASQUEZ PEDRO JAIME', 'MARISCAL NIETO 480 TIENDA 1', '', '', 1, 2, '10165864471', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1112, 'I.E 82923 AGUA AZUL', 'LA FLORIDA SAN MIGUEL', '', '', 1, 1, '16702009', 1, 'MICORREO@MAIL.COM', '', 61003, 0, '', 1, NULL, NULL, NULL, 0),
(1113, 'ALEX BENABIDES FERNANDEZ', '', '', '', 1, 1, '75719182', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1114, 'PESQUERA SANTA CATALINA S.A.C.', 'CAL.MIGUEL GRAU NRO. 381 CENTRO SAN JOSE LAMBAYEQUE - LAMBAYEQUE - SAN JOSE', '', '', 1, 2, '20479849715', 1, 'MICORREO@MAIL.COM', '', 50106, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1115, 'IE1579-LA PORTADA PULAN', 'PULAN', '', '', 1, 1, '28104265', 1, 'MICORREO@MAIL.COM', '', 60906, 0, '', 1, NULL, NULL, NULL, 0),
(1116, 'PRETELL SAMAN LADY DIANA', '', '', '', 1, 2, '10420001601', 1, 'MICORREO@MAIL.COM', '', 10205, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1117, 'TECNORIEGO SOLUTIONS S.A.C.', 'CAL.LAMBAYEQUE NRO. 170 LAMBAYEQUE - CHICLAYO - JOSE LEONARDO ORTIZ', '', '', 1, 2, '20600028554', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1118, 'AUTOMAN CHICLAYO E.I.R.L.', 'NRO. S-N Z.I. FDO ARENALES SUBLO INT.E1 (PARQUE INDUSTRIAL-LADO EMPRESA CHEMA) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20526140151', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1119, 'ORTIZ GARCIA MARCO', 'CALLE LOS QUIPUS 206 REQUE', '', '', 1, 2, '10806767161', 1, 'MICORREO@MAIL.COM', '', 130111, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1120, 'JOSE OLANO YLATOMA', '', '', '', 1, 1, '17448940', 1, 'MICORREO@MAIL.COM', '', 130304, 0, '', 1, NULL, NULL, NULL, 0),
(1121, 'CARLOS SANDOVAL VALDERA', '', '', '', 1, 1, '16744737', 1, 'MICORREO@MAIL.COM', '', 130312, 0, '', 1, NULL, NULL, NULL, 0),
(1122, '11173 VICTOR RAUL HAYA DE LA TORRE_GUAYAQUIL', '', '', '', 1, 1, '3220443', 1, 'MICORREO@MAIL.COM', '', 130116, 0, '', 1, NULL, NULL, NULL, 0),
(1123, 'DISTRIBUIDORA LINARES S.A.C.', 'MZA. I LOTE. A SEC. VALDIVIA ALTA UC PAR 220 III 6-12 LA LIBERTAD - TRUJILLO - HUANCHACO', '', '', 1, 2, '20440199578', 1, 'MICORREO@MAIL.COM', '', 120102, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1124, 'COMERCIAL CHRISTOPHER EL CHINO E.I.R.L.', 'CAL.JOSE PARDO NRO. 458 (FRENT VIVERO F-BLANCA REJAS BLANCAS) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20601364116', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1125, 'CIEZA VASQUEZ JUSTINO', 'AV. MARISCAL CASTILLA 547', '', '', 1, 2, '10011558980', 1, 'MICORREO@MAIL.COM', '', 60801, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1126, 'ROBERTO NUÑEZ FUSTAMANTE', '', '', '998713009', 1, 1, '27428655', 1, 'MICORREO@MAIL.COM', '', 130117, 0, '', 1, NULL, NULL, NULL, 0),
(1127, 'ERNESTO CHAVEZ TERRONES', '', '', '978075177', 1, 1, '40654635', 1, 'MICORREO@MAIL.COM', '', 120901, 0, '', 1, NULL, NULL, NULL, 0),
(1128, 'CONCESIONES LEON DEL NORTE EMPRESA INDIVIDUAL DE RESPONSABILIDAD LIMITADA', 'CAL.SAN MARTIN NRO. 218 CENTRO (SALIDA ASIA GRIFO MENI CASA ACEN RECARGA) LAMBAYEQUE - LAMBAYEQUE - OLMOS', '', '', 1, 2, '20600221354', 1, 'MICORREO@MAIL.COM', '', 130308, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1129, 'INSTITUCION EDUCATIVA INICIAL NÑ 501', 'NRO. S/N C.P. PONCOY (DETRAS DEL CEMENTERIO) LAMBAYEQUE - CHICLAYO - MONSEFU', '', '', 1, 2, '20602152236', 1, 'MICORREO@MAIL.COM', '', 130106, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1130, 'LEYVA AGUILAR SAHARA GARDENIA', 'LA VICTORIA', '', '', 1, 2, '10164406151', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1131, 'I.E821047_MEMBRILLIAR', '', '', '', 1, 1, '27969098', 1, 'MICORREO@MAIL.COM', '', 61001, 0, '', 1, NULL, NULL, NULL, 0),
(1132, 'I.E82798_LIMONCITO LA FLORIDA', 'CAJAMARCA', '', '', 1, 1, '27970342', 1, 'MICORREO@MAIL.COM', '', 61001, 0, '', 1, NULL, NULL, NULL, 0),
(1133, 'I.E82764_NARANJO_NIEPOS', 'SAN MIGUEL,CAJAMARCA', '', '', 1, 1, '16525263', 1, 'MICORREO@MAIL.COM', '', 61001, 0, '', 1, NULL, NULL, NULL, 0),
(1134, 'I.E.P16432 SANMIGUEL,CUTERVO', 'SANJUAN DE CUTERVO', '', '', 1, 1, '27267163', 1, 'MICORREO@MAIL.COM', '', 60501, 0, '', 1, NULL, NULL, NULL, 0),
(1135, 'I.E.PN.16432 SAN JUAN DE CUTERVO', 'SAN JUAN DE CUTERVO', '', '', 1, 1, '27267163', 1, 'MICORREO@MAIL.COM', '', 60101, 0, '', 1, NULL, NULL, NULL, 0),
(1136, 'GROUP PROYECT SOCIEDAD COMERCIAL DE RESPONSABILIDAD LIMITADA', 'NRO. SN C.P. RAMIS (4TO SECTOR KM 41.5 CARRETERA JUL-HUANC) PUNO - HUANCANE - TARACO', '', '', 1, 2, '20448297382', 1, 'MICORREO@MAIL.COM', '', 200508, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1137, 'I.E14936 ALEJANDRO SANCHEZ ARTEAGA HIGUERON PAMPA', 'HIGUERON PAMPA', '', '', 1, 1, '41032294', 1, 'MICORREO@MAIL.COM', '', 190303, 0, '', 1, NULL, NULL, NULL, 0),
(1138, 'I.E.I. NÑ008 NIÑOS MENSAJEROS DE LA PAZ', 'CAL.LA COLLA NRO. 1497 P.J. LA VICTORIA LAMBAYEQUE - CHICLAYO - LA VICTORIA', '', '', 1, 2, '20602131387', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1139, 'AGROPUCALA S.A.A.', 'AV. PIONEROS DE ROCHDALE NRO. SN (COSTADO DE LA MUNICIPALIDAD DE PUCALA) LAMBAYEQUE - CHICLAYO - PUCALA', '', '', 1, 2, '20113657872', 1, 'MICORREO@MAIL.COM', '', 130119, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1140, 'GRUPO PESQUERO MAR NORT E.I.R.L.', 'MZA. H LOTE. 7 URB. JORGE CHAVEZ II ETAPA PROV. CONST. DEL CALLAO - PROV. CONST. DEL CALLAO - CALLAO', '', '', 1, 2, '20605502173', 1, 'MICORREO@MAIL.COM', '', 240101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1141, 'DEYVIS VISLAO', '', '', '', 1, 1, '77813521', 1, 'MICORREO@MAIL.COM', '', 60101, 0, '', 1, NULL, NULL, NULL, 0);
INSERT INTO `cliente` (`codigo_cli`, `nombre_cli`, `direccion_cli`, `ciudad_cli`, `telefono_cli`, `codigo_tip`, `codigo_doc`, `numero_doc`, `codigo_szo`, `email_cli`, `observacion_cli`, `codigo_dis`, `estadosunat_cli`, `condicionsunat_cli`, `estado_cli`, `usuario_reg`, `usuario_mod`, `fecha_mod`, `sistema`) VALUES
(1142, 'DESARROLLO INNOVACION Y TECNOLOGIA DE SERVICIOS S.A.C', 'AV. JOSE PARDO NRO. 335 EL CARMEN LIMA - LIMA - COMAS', '', '', 1, 2, '20507687084', 1, 'MICORREO@MAIL.COM', '', 140106, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1143, 'I.E. N° 11015 \"COMANDANTE ELIAS AGUIRRE\"', 'AV. JOSE BALTA NRO. 862 LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20602149391', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1144, 'I.E.P82771_EL PRADO', 'SAN MIGUEL CAJAMARCA', '', '', 1, 1, '27962735', 1, 'MICORREO@MAIL.COM', '', 61001, 0, '', 1, NULL, NULL, NULL, 0),
(1145, 'I.E.P. RODEOPAMPA', 'CASERIO RODEOPAMPA_EL PRADO', '', '', 1, 1, '27961032', 1, 'MICORREO@MAIL.COM', '', 61009, 0, '', 1, NULL, NULL, NULL, 0),
(1146, 'PABLO DE LA CRUZ SARMIENTO', '', '', '948424451', 1, 1, '17577519', 1, 'MICORREO@MAIL.COM', '', 130307, 0, '', 1, NULL, NULL, NULL, 0),
(1147, 'I.E 82567 TEMPLADERA', 'TEMPLADERA', '', '', 1, 1, '27143867', 1, 'MICORREO@MAIL.COM', '', 60401, 0, '', 1, NULL, NULL, NULL, 0),
(1148, 'EDILBERTO VALLEJOS CORONADO', '', '', '', 1, 1, '40763253', 1, 'MICORREO@MAIL.COM', '', 130117, 0, '', 1, NULL, NULL, NULL, 0),
(1149, 'JOSE VASQUEZ RAMIREZ', '', '', '', 1, 1, '16548159', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1150, 'EMPRESA ADMINISTRADORA VIVEBIEN SOCIEDAD COMERCIAL DE RESPONSABILIDAD LIMITADA', 'CAL.LA PLATA NRO. 173 URB. SAN EDUARDO LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20561383155', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1151, 'CIRILO DE LA CRUZ MARTINEZ', '', '', '920384272', 1, 1, '40172750', 1, 'MICORREO@MAIL.COM', '', 130307, 0, '', 1, NULL, NULL, NULL, 0),
(1152, 'JOSELITO SANCHEZ PLASENCIA', '', '', '', 1, 1, '27143746', 1, 'MICORREO@MAIL.COM', '', 120506, 0, '', 1, NULL, NULL, NULL, 0),
(1153, 'INVERSIONES NANDO´S CHICKEN SAC', 'AV. TACNA NRO. 516 LAMBAYEQUE - FERREÑAFE - FERREÑAFE', '', '', 1, 2, '20561278441', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1154, 'LA VIGA S.A.', 'AV. TOMAS MARSANO NRO. 2813 INT. 603 LIMA - LIMA - SANTIAGO DE SURCO', '', '', 1, 2, '20100150736', 1, 'MICORREO@MAIL.COM', '', 140130, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1155, 'ANDREAS STIHL S.R.L.', 'AV. ENRIQUE CANAVAL Y MOREYRA NRO. 480 INT. 16 URB. LIMATAMBO (OFICINA 1601B) LIMA - LIMA - SAN ISIDRO', '', '', 1, 2, '20604020761', 1, 'MICORREO@MAIL.COM', '', 140124, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1156, 'CHAVEZ FLORES CHARITO', 'CALLE FRANCISCO BOLOGNESI 639 OYOTUN', '', '', 1, 2, '10435009323', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1157, 'VILELA PUELLES LUIS ALBERTO', 'CAL. CAHUIDE MAZ 168 LT 2 LA VICTORIA', '', '', 1, 2, '10402613314', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1158, 'HIPOLITO CHERO NAMUCHE', 'PIURA', '', '', 1, 1, '80263042', 1, 'MICORREO@MAIL.COM', '', 190101, 0, '', 1, NULL, NULL, NULL, 0),
(1159, 'LUCANO ZELADA DAVID DANIEL', 'MZ A LT S/N CAS SAN VICENTE DE PAUL LONGOTEA BOLIVAR', '', '', 1, 2, '10411690461', 1, 'MICORREO@MAIL.COM', '', 120204, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1160, 'FERNANDO ZEGARRA ZELADA', '', '', '', 1, 1, '41614504', 1, 'MICORREO@MAIL.COM', '', 120204, 0, '', 1, NULL, NULL, NULL, 0),
(1161, 'SETAMI E.I.R.L.', '----CERCADO MZA. C LOTE. 03 C.P. SANTA ANA (CRUCE AV. LORA Y LORA Y AV. VENEZUELA) LAMBAYEQUE - CHICLAYO - JOSE LEONARDO ORTIZ', '', '', 1, 2, '20488085493', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1162, 'IE N° 10547', 'MUTUY LLAMA', '', '', 1, 1, '27393612', 1, 'MICORREO@MAIL.COM', '', 60610, 0, '', 1, NULL, NULL, NULL, 0),
(1163, 'REYNOSA SANCHEZ MARY LUZ', '', '', '', 1, 2, '10400918584', 1, 'MICORREO@MAIL.COM', '', 130312, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1164, 'JULIO VALDERA VERA', '', '', '933379793', 1, 1, '17598797', 1, 'MICORREO@MAIL.COM', '', 130312, 0, '', 1, NULL, NULL, NULL, 0),
(1165, 'MIMADERO S.A.C.', 'CAL.EL MILAGRO NRO. 251 P.J. CASA BLANCA ETAPA I (FRENTE EL PAMPON) LAMBAYEQUE - CHICLAYO - JOSE LEONARDO ORTIZ', '', '', 1, 2, '20602650236', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1166, 'CAVALDI SAC CONTRATISTAS GENERALES', 'CAL.MATIAS MAESTRO NRO. 896 URB. EL BOSQUE (ESPALDA DE CUADRA 8 GUZMAN BARRON) LA LIBERTAD - TRUJILLO - TRUJILLO', '', '', 1, 2, '20481547513', 1, 'MICORREO@MAIL.COM', '', 120101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1167, 'RODRIGUES SEVERINO YOVANA GISELA', 'MOTUPE', '', '', 1, 1, '46883936', 1, 'MICORREO@MAIL.COM', '', 130307, 0, '', 1, NULL, NULL, NULL, 0),
(1168, 'ASICA FARMS S.A.C.', 'AV. EL GOLF NRO. 681 URB. LAS PALMERAS DEL GOLF LA LIBERTAD - TRUJILLO - VICTOR LARCO HERRERA', '', '', 1, 2, '20600483596', 1, 'MICORREO@MAIL.COM', '', 120107, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1169, 'A-F & ASOCIADOS S.A.C', 'JR. REPUBLICA DE PANAMA NRO 250 URB. TORRES ARAUJO', '', '', 1, 2, '20481206104', 1, 'MICORREO@MAIL.COM', '', 120101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1170, 'JESUS ALBERTO CHISCOL PUICON', '', '', '', 1, 1, '75683145', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1171, 'EUDEN GALLARDO MONTEZA', 'ZAÑA', '', '', 1, 1, '27386378', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1172, 'INGENIERIA AGRICOLA SOCIEDAD ANONIMA CERRADA', 'AV. AUGUSTO B. LEGUIA NRO. 294 URB. NAZARETH LAMBAYEQUE - FERREÑAFE - FERREÑAFE', '', '', 1, 2, '20561363391', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1173, 'SANTA SOFIA DEL SUR S.A.C.', 'JR. JOSE DIONISIO ANCHORENA NRO. 433 (ENTRE CUADRAS 31 Y 32 DE AV. SALAVERRY) LIMA - LIMA - MAGDALENA DEL MAR', '', '', 1, 2, '20510865627', 1, 'MICORREO@MAIL.COM', '', 140114, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1174, 'MARIA MARGARITA ALDANA DE ANTON', '', '', '', 1, 1, '2741724', 1, 'MICORREO@MAIL.COM', '', 130306, 0, '', 1, NULL, NULL, NULL, 0),
(1175, 'RAVICRUZVA E.I.R.L.', 'AV. MIGUEL GRAU NRO. 1017 URB. SANTA VICTORIA (3 PISO) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20606379227', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1176, 'AGRICOLA CERRO PRIETO S.A.', 'CAL.DEAN VALDIVIA NRO. 111 INT. 1002 LIMA - LIMA - SAN ISIDRO', '', '', 1, 2, '20461642706', 1, 'MICORREO@MAIL.COM', '', 140124, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1177, 'BIDALI ZARANGO HERRERA', '', '', '', 1, 1, '43771092', 1, 'MICORREO@MAIL.COM', '', 60809, 0, '', 1, NULL, NULL, NULL, 0),
(1178, 'NANCY SALAS CHAVEZ', 'LAMBAYEQUE', '', '', 1, 1, '44719798', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1179, 'FACTORIA CURO E.I.R.L', 'CAL.LAS ERAS NRO. 175 URB. SAN LORENZO LAMBAYEQUE - CHICLAYO - JOSE LEONARDO ORTIZ', '', '', 1, 2, '20480176228', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1180, 'MARCELINO PEREZ CORONEL', '', '', '941677423', 1, 1, '17449927', 1, 'MICORREO@MAIL.COM', '', 130307, 0, '', 1, NULL, NULL, NULL, 0),
(1181, 'MOTUPAL SOCIEDAD ANONIMA CERRADA', 'JR. QUIÑONES NRO. 64 LAMBAYEQUE - CHICLAYO - PIMENTEL', '', '', 1, 2, '20602024963', 1, 'MICORREO@MAIL.COM', '', 130110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1182, 'IE I 1913 JESUS EL DIVINO MAESTRO - SIXTO BALAREZO', '', '', '', 1, 3, '0', 1, 'MICORREO@MAIL.COM', '', 120503, 0, '', 1, NULL, NULL, NULL, 0),
(1183, 'FERNANDO MESONES BONILLA', '', '', '', 1, 1, '16411691', 1, 'MICORREO@MAIL.COM', '', 60611, 0, '', 1, NULL, NULL, NULL, 0),
(1184, 'ANDREZ CHAPOÑAN SUCLUPE', '', '', '960571767', 1, 1, '80541158', 1, 'MICORREO@MAIL.COM', '', 130306, 0, '', 1, NULL, NULL, NULL, 0),
(1185, 'FIDEL OBLITAS LA TORRE', '', '', '939009939', 1, 1, '27384124', 1, 'MICORREO@MAIL.COM', '', 130304, 0, '', 1, NULL, NULL, NULL, 0),
(1186, 'IVAN VASQUEZ VASQUEZ', '', '', '952826288', 1, 1, '43328543', 1, 'MICORREO@MAIL.COM', '', 130204, 0, '', 1, NULL, NULL, NULL, 0),
(1187, 'NELSON LEZCANO CORONEL', '', '', '976043321', 1, 1, '44639249', 1, 'MICORREO@MAIL.COM', '', 130120, 0, '', 1, NULL, NULL, NULL, 0),
(1188, 'ERNESTO MAYRA VASQUEZ', '', '', '', 1, 1, '46002457', 1, 'MICORREO@MAIL.COM', '', 130311, 0, '', 1, NULL, NULL, NULL, 0),
(1189, 'ARO CONSTRUCTORA Y MINEROS EIRL', 'AV. JOSE GALVEZ NRO. 1146 LIMA - LIMA - LIMA', '', '', 1, 2, '20547282559', 1, 'MICORREO@MAIL.COM', '', 140101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1190, 'TORIBIO SANCHEZ CARLOS', '', '', '', 1, 1, '44620709', 1, 'MICORREO@MAIL.COM', '', 130202, 0, '', 1, NULL, NULL, NULL, 0),
(1191, 'FARROÑAN OJEDA ROSA JANET', 'CALLE VICNETE LA VEGA 844 INT. A', '', '', 1, 2, '10167072092', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1192, 'MARCIAL MONDRAGON FERNADEZ', '', '', '', 1, 1, '47526093', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1193, 'SANCHEZ SANTAMARIA SATURNINO', '', '', '', 1, 2, '10176210562', 1, 'MICORREO@MAIL.COM', '', 130306, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1194, 'FLOGAING CONTRATISTAS GENERALES S.A.C.', 'JR. SIMON BOLIVAR NRO. REF. (CDRA 01,FRENTE COL.PRIM 16296,FACH.CELES) AMAZONAS - CONDORCANQUI - NIEVA', '', '', 1, 2, '20480686692', 1, 'MICORREO@MAIL.COM', '', 10601, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1195, 'MARCO SANTOS LLAGUENTO', '', '', '912136012', 1, 1, '17444060', 1, 'MICORREO@MAIL.COM', '', 130309, 0, '', 1, NULL, NULL, NULL, 0),
(1196, 'AGRICOLA SAN FELIPE EIRL', 'AV. DOS DE MAYO NRO 461', '', '', 1, 2, '20313472206', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1197, 'BELLAVISTA S.A.C.', 'CAL.MARAÑON NRO. 162 BARR. LA INTENDENCIA LA LIBERTAD - TRUJILLO - TRUJILLO', '', '', 1, 2, '20482224556', 1, 'MICORREO@MAIL.COM', '', 120101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1198, 'PERSY RUIZ ORTIZ', '', '', '', 1, 1, '42727837', 1, 'MICORREO@MAIL.COM', '', 120506, 0, '', 1, NULL, NULL, NULL, 0),
(1199, 'JOSE MIGUEL MORANTE MORAN', '', '', '959546384', 1, 1, '17529454', 1, 'MICORREO@MAIL.COM', '', 130312, 0, '', 1, NULL, NULL, NULL, 0),
(1200, 'JESS MAN OPERACIONES LOGISTICAS EMPRESARIALES S.A.C.', '----5TA ETAPA MZA. H-5 LOTE. 4 URB. MONTERRICO LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20538956032', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1201, 'ALIPIO SILVA DAVILA', '', '', '929269757', 1, 1, '27391476', 1, 'MICORREO@MAIL.COM', '', 130117, 0, '', 1, NULL, NULL, NULL, 0),
(1202, 'FLORES SALAZAR OMAR HUMBERTO', '', '', '', 1, 2, '10431132970', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1203, 'JOSE ALVARADO RODRIGUEZ', '', '', '', 1, 1, '70764938', 1, 'MICORREO@MAIL.COM', '', 130204, 0, '', 1, NULL, NULL, NULL, 0),
(1204, 'EDGAR ALBERTO ZAMORA LARA', 'MOCUPE LAGUNA', '', '997913385', 1, 1, '16767034', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1205, 'FEDERICO PISFIL PUYEN', '', '', '978829636', 1, 1, '16728528', 1, 'MICORREO@MAIL.COM', '', 130111, 0, '', 1, NULL, NULL, NULL, 0),
(1206, 'MANUEL VILLENA BARBOZA', '', '', '', 1, 1, '16799216', 1, 'MICORREO@MAIL.COM', '', 130116, 0, '', 1, NULL, NULL, NULL, 0),
(1207, 'IE MANUEL ANTONIO MESONES MURO', 'LIMON DE PORCUYA', '', '', 1, 1, '0', 1, 'MICORREO@MAIL.COM', '', 190303, 0, '', 1, NULL, NULL, NULL, 0),
(1208, 'CIRILO ALTAMIRANO CONSANCHIRON', '', '', '979053324', 1, 1, '16596761', 1, 'MICORREO@MAIL.COM', '', 130204, 0, '', 1, NULL, NULL, NULL, 0),
(1209, 'JONER ERLI SANTACRUZ', '', '', '959475320', 1, 1, '45223101', 1, 'MICORREO@MAIL.COM', '', 130204, 0, '', 1, NULL, NULL, NULL, 0),
(1210, 'ANIBAL COLLANTES OLIVOS', '', '', '', 1, 1, '40867863', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1211, 'DANNY SERQUEN FLORES', '', '', '950252900', 1, 1, '45104908', 1, 'MICORREO@MAIL.COM', '', 130115, 0, '', 1, NULL, NULL, NULL, 0),
(1212, 'IE N° 1182 PASMILLAN', '', '', '', 1, 1, '0', 1, 'MICORREO@MAIL.COM', '', 190303, 0, '', 1, NULL, NULL, NULL, 0),
(1213, 'ISIDRO  ELIAS BALLENA', '', '', '9799217775', 1, 1, '17620542', 1, 'MICORREO@MAIL.COM', '', 130106, 0, '', 1, NULL, NULL, NULL, 0),
(1214, 'RAUL AGUILAR ABAD', '', 'MOCUPE', '971771960', 1, 1, '40307569', 1, 'MICORREO@MAIL.COM', '', 130115, 0, '', 1, NULL, NULL, NULL, 0),
(1215, 'ROSA MALABER CALLIRGOS', '', 'UDIMA', '976307703', 1, 1, '10551304', 1, 'MICORREO@MAIL.COM', '', 60902, 0, '', 1, NULL, NULL, NULL, 0),
(1216, 'JHON KELVIN IZQUIERDO SANTA CRUZ', '', '', '996259834', 1, 1, '71631606', 1, 'MICORREO@MAIL.COM', '', 60909, 0, '', 1, NULL, NULL, NULL, 0),
(1217, 'GARCIA BULNES WILDER ORLANDO', '', '', '', 1, 2, '10175620490', 1, 'MICORREO@MAIL.COM', '', 130305, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1218, 'SEBASTIAN GONZALES PISFIL', '', '', '', 1, 1, '16555145', 1, 'MICORREO@MAIL.COM', '', 130106, 0, '', 1, NULL, NULL, NULL, 0),
(1219, 'ACOSTA DE LA CRUZ SALUSTIANO', '', '', 'CP CAPILLA SANTA ROS', 1, 1, '17618831', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1220, 'ROJAS JUAREZ AGUSTIN', '', '', '', 1, 1, '42649641', 1, 'MICORREO@MAIL.COM', '', 130205, 0, '', 1, NULL, NULL, NULL, 0),
(1221, 'NESTOR JESUS SEGUNDO LLAGUENTO', '', 'BATAN GRANDE', '921490896', 1, 1, '41111444', 1, 'MICORREO@MAIL.COM', '', 130204, 0, '', 1, NULL, NULL, NULL, 0),
(1222, 'JESUS WILMER VASQUEZ DELGADO', '', '', '', 1, 1, '42229052', 1, 'MICORREO@MAIL.COM', '', 10205, 0, '', 1, NULL, NULL, NULL, 0),
(1223, 'CARLOS ELMER DAVILA ROJAS', 'BATANGRANDE_ DESAGUADERO', '', '', 1, 1, '16706536', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1224, 'DELTA INDUSTRY S.A.C.', 'AV. EL TOMASAL NRO. 820 DPTO. 503 INT. A URB. HUERTOS DE SAN ANTONIO (EDIFICIO 1) LIMA - LIMA - SANTIAGO DE SURCO', '', '', 1, 2, '20604318611', 1, 'MICORREO@MAIL.COM', '', 140130, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1225, 'DAVID BRAVO MONTENGRO', '', '', '', 1, 1, '40398474', 1, 'MICORREO@MAIL.COM', '', 60601, 0, '', 1, NULL, NULL, NULL, 0),
(1226, 'FABRICA DE ENVASES DE VIDRIO NUEVO MURANO S.A.C', 'AV. JOSE FAUSTINO SANCHEZ CARRION NRO. 609 INT. 1301 URB. SAN FELIPE LIMA - LIMA - JESUS MARIA', '', '', 1, 2, '20550452163', 1, 'MICORREO@MAIL.COM', '', 140133, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1227, 'JOSE CHAPOÑAN ALAMO', '', '', '921483272', 1, 1, '47248800', 1, 'MICORREO@MAIL.COM', '', 130306, 0, '', 1, NULL, NULL, NULL, 0),
(1228, 'JOSE SANTA MARIA ZEÑA', '', '', '943523543', 1, 1, '17615795', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(1229, 'OLEGARIO VIDAURE BALLENA', '', 'LA CRUZ', '937726357', 1, 1, '41034523', 1, 'MICORREO@MAIL.COM', '', 130306, 0, '', 1, NULL, NULL, NULL, 0),
(1230, 'CESAR AUGUSTO CAVANILLAS CASTRO', '', '', '', 1, 1, '27974805', 1, 'MICORREO@MAIL.COM', '', 61013, 0, '', 1, NULL, NULL, NULL, 0),
(1231, 'JAVIER AROYO NEVADO', 'LAS ARANDAS', '', '', 1, 1, '40876557', 1, 'MICORREO@MAIL.COM', '', 130204, 0, '', 1, NULL, NULL, NULL, 0),
(1232, 'BAZAN NAPANGA HENRY DANIEL', 'MANZANA C LOTE 2 CHOZICA DEL NORTE', '', '', 1, 2, '10452904565', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1233, 'JOSE WILMER LEZAMA TORRES', '', '', '946711191', 1, 1, '40520567', 1, 'MICORREO@MAIL.COM', '', 61204, 0, '', 1, NULL, NULL, NULL, 0),
(1234, 'SEGUNDO FRANCISCO SECLEN VALDERA', '', '', '925248490', 1, 1, '80321790', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(1235, 'EDGAR LADRID TORRES', 'HUARMACA', '', '', 1, 1, '3216694', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1236, 'VID AGRO S.A.C.', 'AV. INGENIEROS NORTE NRO. 251 URB. LA MERCED (FTE COL LA MERCED) LIMA - LIMA - ATE', '', '', 1, 2, '20502630378', 1, 'MICORREO@MAIL.COM', '', 140103, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1237, 'SEGUNDO ILARIO', 'CASERIO MUYSIL', '', '', 1, 1, '47694791', 1, 'MICORREO@MAIL.COM', '', 130310, 0, '', 1, NULL, NULL, NULL, 0),
(1238, 'CONGELADOS Y SERVICIOS GMG S.R.L', 'JR. 03 DE OCTUBRE NRO. 118 CENTRO CALETA LA CRUZ (FRENTE A LA MUNICIPALIDAD DE LA CRUZ) TUMBES - TUMBES - LA CRUZ', '', '', 1, 2, '20409420096', 1, 'MICORREO@MAIL.COM', '', 230103, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1239, 'EMPRESA DE TRANSPORTES EL DORADO SAC', 'CAL.TACNA NRO. 351 TUMBES - TUMBES - TUMBES', '', '', 1, 2, '20132670146', 1, 'MICORREO@MAIL.COM', '', 230101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1240, 'LUIS ALBERTO VIDAURRE BANCES', '', '', '954112803', 1, 1, '31554775', 1, 'MICORREO@MAIL.COM', '', 130303, 0, '', 1, NULL, NULL, NULL, 0),
(1241, 'DILMER SILVA', '', '', '', 1, 1, '45075877', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1242, 'SANTA SOFIA DEL SUR SAC', 'DIONICIO ANCHORENA 431-433', '', '', 1, 2, '20510865627', 1, 'MICORREO@MAIL.COM', '', 140114, 0, '', 1, NULL, NULL, NULL, 0),
(1243, 'CARMEN ACOSTA CHOZO', '', '', '', 1, 1, '17531335', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(1244, 'GRUPO DE APOYO A LA JUVENTUD ESTUDIANTIL LAMBAYEQUE E.I.R.L.', 'CAL.SANJOSE NRO. 415 URB. CERCADO DE CHICLAYO (SEGUNDO PISO) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20487478688', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1245, 'SINDY FUENTES FUENTES', '', '', '', 1, 1, '45680758', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1246, 'SEMILLAS VALLEY SAC', 'AV . RICARDO ANGULO 776 INT 301 URB CORPAC SAN ISIDRO LIMA', '', '', 1, 2, '20603836520', 1, 'MICORREO@MAIL.COM', '', 140124, 0, '', 1, NULL, NULL, NULL, 0),
(1247, 'JHONNY SOTERO ZETA', '', '', '', 1, 1, '41053631', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1248, 'BANUS DEL SUR SAC', 'URB. EL SANTUARIO MZ S LT 6', '', '', 1, 2, '20605690131', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1249, 'ASOCIACION BANANEROS ORGANICOS OLMOS BANOL', 'OLMOS', '', '', 1, 2, '20603417021', 1, 'MICORREO@MAIL.COM', '', 130308, 0, '', 1, NULL, NULL, NULL, 0),
(1250, 'RAMOS RAMIREZ WALTER EDWIN', 'CAL. JESUS BERA FERNANDES 955 URB. SAN GERMAN', '', '', 1, 2, '10076323751', 1, 'MICORREO@MAIL.COM', '', 140126, 0, '', 1, NULL, NULL, NULL, 0),
(1251, 'LANCER SAC', 'COCOTEROS 450-UPIS SAN MIGUEL', '', '', 1, 2, '20605617434', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1252, 'KIBE CONSTRUCCIONES GENERALES SAC', 'AV . SAN FELIPE 1011 DPTO 1803 RES. SAN FELIPE', '', '', 1, 2, '20488071603', 1, 'MICORREO@MAIL.COM', '', 140133, 0, '', 1, NULL, NULL, NULL, 0),
(1253, 'DISTRIBUCIONES OLANO S.A.C', 'CAL. LEONCIO PRADO NRO. 549 URB. EL PORVENIR', '', '', 1, 2, '20103365628', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1254, 'INVERSIONES AGROPECUARIA CAMPO VERDE EIRL', 'JR. REVILLA PEREZ NRO. 137 BAR. LA MERCED (ESQUINA CON JR 11 DE FEBRERO) CAJAMARCA - CAJAMARCA - CAJAMARCA', '', '', 1, 2, '20529564474', 1, 'MICORREO@MAIL.COM', '', 60101, 0, '', 1, NULL, NULL, NULL, 0),
(1255, 'MUNICIPALIDAD DISTRITAL DE PIMENTEL', 'CAL.LEONCIO PRADO NRO. 143 CERCADO LAMBAYEQUE - CHICLAYO - PIMENTEL', '', '', 1, 2, '20164032613', 1, 'MICORREO@MAIL.COM', '', 130110, 0, '', 1, NULL, NULL, NULL, 0),
(1256, 'ELMER PAZ MALAVER', '', 'UDIMA', '940099368', 1, 1, '21074545', 1, 'MICORREO@MAIL.COM', '', 60902, 0, '', 1, NULL, NULL, NULL, 0),
(1257, 'LILIANA RODRIGUEZ BARBOZA', '', '', '', 1, 1, '8230834', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1258, 'CONSTRUCTORA FRANCIA E.I.R.L.', 'MZA. K LOTE. 43 URB. LOS ROBLES LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20606885459', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1259, 'JOSE ZABALETA CORONEL', '', '', '', 1, 1, '48168940', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1260, 'JULIO REQUEJO GUEVARA', '', '', '', 1, 1, '28109223', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1261, 'GUTIERREZ YARLAQUE JOSE DEL CARMEN', 'MZ D LT 28 DPTO 201 URB. ALAMEDA DE LA RIVERA', '', '', 1, 2, '10443780896', 1, 'YARLAQUE07@GMAIL.COM', '', 140103, 0, '', 1, NULL, NULL, NULL, 0),
(1262, 'PEDRO FALEN SANTISTEBAN', '', '', '984792787', 1, 1, '17586314', 1, 'MICORREO@MAIL.COM', '', 130309, 0, '', 1, NULL, NULL, NULL, 0),
(1263, 'TULLUME RELUZ JAVIER', '', 'CHACUPE', '943081773', 1, 1, '44057876', 1, 'MICORREO@MAIL.COM', '', 130115, 0, '', 1, NULL, NULL, NULL, 0),
(1264, 'LUIS ZELADA MENDOZA', '', 'TENBLADERA', '978608085', 1, 1, '80628260', 1, 'MICORREO@MAIL.COM', '', 60401, 0, '', 1, NULL, NULL, NULL, 0),
(1265, 'REGULO CARRANZA OBLITAS', '', '', '945624800', 1, 1, '17449857', 1, 'MICORREO@MAIL.COM', '', 130206, 0, '', 1, NULL, NULL, NULL, 0),
(1266, 'JOSE ZULUOETA RAMOS', '', '', '916318914', 1, 1, '76040864', 1, 'MICORREO@MAIL.COM', '', 130201, 0, '', 1, NULL, NULL, NULL, 0),
(1267, 'VERDUM PERÚ S.A.C', 'CAR.PARAMERICANA NORTE NRO 3.5 CHICLAYO', '', '', 1, 2, '20394862704', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1268, 'ANGEL RAMIRO CRUZADO BENAVIDES', '', '', '', 1, 1, '16717726', 1, 'MICORREO@MAIL.COM', '', 60701, 0, '', 1, NULL, NULL, NULL, 0),
(1269, 'INDUSTRIA DEL PALLET DEL NORTE S.A.C', 'MZA. D LOTE. 12 P.J. CRUZ DE MEDIANÍA LAMBAYEQUE - LAMBAYEQUE - MORROPE', '', '', 1, 2, '20603673558', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1270, 'SERMYFAB S.A.C.', 'MZA. A LOTE. 10 URB. RICARDO ARIZOLA (ANTES DE LA GERENCIA DE TRANSPORTES) LAMBAYEQUE - CHICLAYO - PIMENTEL', '', '', 1, 2, '20600047982', 1, 'MICORREO@MAIL.COM', '', 130110, 0, '', 1, NULL, NULL, NULL, 0),
(1271, 'MANUEL JESUS SUAREZ EFFIO', '', '', '989194142', 1, 1, '17434551', 1, 'MICORREO@MAIL.COM', '', 130201, 0, '', 1, NULL, NULL, NULL, 0),
(1272, 'GARCIA SANTAMARIA LEONCIO', '', '', '988948415', 1, 1, '41642454', 1, 'MICORREO@MAIL.COM', 'SR440', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(1273, 'MANUEL HURTADO FAILOC', '', '', '967707257', 1, 1, '60162722', 1, 'MICORREO@MAIL.COM', '', 130307, 0, '', 1, NULL, NULL, NULL, 0),
(1274, 'CARLOS ARMANDO RODAS DIAZ', '', '', '916684220', 1, 1, '71315345', 1, 'MICORREO@MAIL.COM', '', 120901, 0, '', 1, NULL, NULL, NULL, 0),
(1275, 'ECOVIVESOCIAL S.A.C.', 'AV. JOSE PARDO NRO. 223 URB. SURQUILLO LIMA - LIMA - MIRAFLORES', '', '', 1, 2, '20601900662', 1, 'MICORREO@MAIL.COM', '', 140136, 0, '', 1, NULL, NULL, NULL, 0),
(1276, 'AGRICOLA SANTA AMALIA S.R.L', 'CAL.MANUEL MARIA IZAGA NRO. 740 INT. 306 LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20487872661', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1277, 'VERGARA FLORES MIGUEL ANGEL', 'CHIMBOTE', '', '', 1, 1, '32885214', 1, 'MICORREO@MAIL.COM', '', 20322, 0, '', 1, NULL, NULL, NULL, 0),
(1278, 'VIDAURRE BANCES MARITZA ELIZABETH', '', '', '94534040411', 1, 1, '17558032', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(1279, 'JOEL SANTISTEBAN VILCHEZ', '', '', '', 1, 1, '45223208', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(1280, 'CONSTRUCTORA SAN JUAN SRL', 'CAL.ALCANFORES NRO. 761 DPTO. 1001 (TORRE A) LIMA - LIMA - MIRAFLORES', '', '', 1, 2, '20103639426', 1, 'MICORREO@MAIL.COM', '', 140115, 0, '', 1, NULL, NULL, NULL, 0),
(1281, 'CARLOS REVILLA VERASTEGUI', '', '', '', 1, 1, '44238664', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1282, 'JOSE VILUCO BALLENA', '', '', '960889196', 1, 1, '16781010', 1, 'MICORREO@MAIL.COM', '', 130115, 0, '', 1, NULL, NULL, NULL, 0),
(1283, 'HUGO BURGA SANCHEZ', '', '', '942455765', 1, 1, '42002644', 1, 'MICORREO@MAIL.COM', '', 60601, 0, '', 1, NULL, NULL, NULL, 0),
(1284, 'MANUEL MANAYAY VILCABANA', '', '', '970179288', 1, 1, '41644312', 1, 'MICORREO@MAIL.COM', '', 130201, 0, '', 1, NULL, NULL, NULL, 0),
(1285, 'MONTENEGRO PITA JUAN CARLOMAN', 'LEONCIO PRADO 1655', '', '', 1, 2, '10273805708', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1286, 'NALDY EVELY FLORIAN ALVA', '', '', '', 1, 1, '44333704', 1, 'MICORREO@MAIL.COM', '', 120901, 0, '', 1, NULL, NULL, NULL, 0),
(1287, 'GUEVARA DAMIAN ROOSVELT', '', '', '933307494', 1, 1, '76738019', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(1288, 'MESTA SANTISTEBAN SANTOS', '', '', '945766031', 1, 1, '17542194', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(1289, 'MIGUEL ANGEL MIÑOPE CAICEDO', '', '', '958620697', 1, 1, '43632167', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1290, 'DOMINGO JULCA GALINDO', '', 'UDIMA', '998019783', 1, 1, '40099684', 1, 'MICORREO@MAIL.COM', '', 60902, 0, '', 1, NULL, NULL, NULL, 0),
(1291, 'SOCIEDAD AGRICOLA MOCHE NORTE S.A', 'JEQUETEPEQUE S/N FUNDO CERRO COLORADO', '', '', 1, 2, '20510360428', 1, 'MICORREO@MAIL.COM', '', 120902, 0, '', 1, NULL, NULL, NULL, 0),
(1292, 'ZEUS P', '', '', '', 1, 2, '10073142437', 1, 'MICORREO@MAIL.COM', '', 140101, 0, '', 1, NULL, NULL, NULL, 0),
(1293, 'JUNIOR RAMOS SANDOVAL', '', '', '942498959', 1, 1, '46944947', 1, 'MICORREO@MAIL.COM', '', 130312, 0, '', 1, NULL, NULL, NULL, 0),
(1294, 'GARCIA SANCHEZ GUZMARO', 'CALLE JOSE GALVEZ 16 CPM LIMON CARRO', '', '', 1, 2, '10193210398', 1, 'MICORREO@MAIL.COM', '', 120503, 0, '', 1, NULL, NULL, NULL, 0),
(1295, 'GONZALO CHAPOÑAN SIESQUEN', '', 'ARBOL SOL', '', 1, 1, '17621036', 1, 'MICORREO@MAIL.COM', '', 130306, 0, '', 1, NULL, NULL, NULL, 0),
(1296, 'REPRESENTACIONES Y SERVICIOS A & T S.R.L.', 'CAL.COSMOS NRO. 177 P.J. SAN ANTONIO', '', '', 1, 2, '20602274901', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1297, 'RAUL AMARANTO CARRILLO LLAGUENTO', '', '', '957062783', 1, 1, '17404794', 1, 'MICORREO@MAIL.COM', '', 60611, 0, '', 1, NULL, NULL, NULL, 0),
(1298, 'CIMA SAC', 'ALFONZO HUGARTE 640', '', '', 1, 2, '20479482153', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1299, 'CHICONA CARRILLO SANTOS ADAN', '', '', '924596721', 1, 1, '17601973', 1, 'MICORREO@MAIL.COM', '', 130312, 0, '', 1, NULL, NULL, NULL, 0),
(1300, 'SONIA GASDALI DIAZ LOPEZ', 'CALLE SUGRE 304 FERREÑAFE', '', '', 1, 2, '10193365260', 1, 'MICORREO@MAIL.COM', '', 130201, 0, '', 1, NULL, NULL, NULL, 0),
(1301, 'RAMON ANTONIO ARIAS FARRO', '', '', '', 1, 2, '10191880493', 1, 'MICORREO@MAIL.COM', '', 120501, 0, '', 1, NULL, NULL, NULL, 0),
(1302, 'RAF BARCENES SAC', '', '', '', 1, 2, '20601489725', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1303, 'ALBERTO FLORES CHAVESTA', '', 'CHACUPE', '949556478', 1, 1, '16456059', 1, 'MICORREO@MAIL.COM', '', 130115, 0, '', 1, NULL, NULL, NULL, 0),
(1304, 'AGROFALMA Y CONSULTORES EIRL', 'CALLE CAMPO PIMENTEL KM4', '', '', 1, 2, '20600722833', 1, 'MICORREO@MAIL.COM', '', 130110, 0, '', 1, NULL, NULL, NULL, 0),
(1305, 'KING KONG LLAMPAYEC ERIL', '', '', '', 1, 2, '20480606842', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1306, 'GILBERTO REEQUEJO SEGURA', '', 'MUY FINCA', '943269876', 1, 1, '17410404', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(1307, 'BITOSI CHICLAYO S.A.C.', 'CAL.SAN PABLO NRO. 650 C.P. PACORA LAMBAYEQUE - LAMBAYEQUE - PACORA', '', '', 1, 2, '20607034347', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1308, 'ANSCORP SECURITY', 'FOUSET 560', '', '', 1, 2, '10470805809', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1309, 'LUIS CONSUELO SERNAQUEN  YARLEQUE', 'CHICLAYO', '', '', 1, 2, '10167072343', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1310, 'INMOBILIARIA  NOVATERRA ASOCIADOS SAC', 'CARRETERA REQUE PUERTO ETEN KM3.8', '', '', 1, 2, '20606541482', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1311, 'OSCAR OSWALDO  SANTIAGO LARA', 'CHICLAYO', '', '', 1, 2, '10802615669', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1312, 'ADAN SILVA SANCHEZ', 'CHICLAYO', '', '', 1, 1, '9794394', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1313, 'VIRGUILIO MALAVER CRUZADO', 'CASERIO NUEVO POR VENIR -CATACHE', '', '', 1, 3, '1027988672', 1, 'MICORREO@MAIL.COM', '', 60902, 0, '', 1, NULL, NULL, NULL, 0),
(1314, 'GRUPO FERNANDEZ PERU SAC', 'JR ANAXIMANDRO VEGA 770', '', '', 1, 2, '20529425351', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1315, 'AGRÍCOLA EEB PERÚ S.A.', 'MZA. B LOTE 25 URB. SAN EDUARDO', '', '', 1, 2, '20600834488', 1, 'MICORREO@MAIL.COM', '', 190101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1316, 'MARTIN SALAZAR RELUZ', '', 'CHACUPE BAJO', '952889409', 1, 1, '16559899', 1, 'MICORREO@MAIL.COM', '', 130115, 0, '', 1, NULL, NULL, NULL, 0),
(1317, 'FLOGAING CONTRATISTAS GENERALES SAC', 'SIMON BOLIVAR S/N NIEVA', '', '979594999', 1, 2, '20480686692', 1, 'MICORREO@MAIL.COM', '', 10601, 0, '', 1, NULL, NULL, NULL, 0),
(1318, 'MANUEL CAJUSOL DELGADO', '', '', '', 1, 1, '41863840', 1, 'MICORREO@MAIL.COM', '', 130102, 0, '', 1, NULL, NULL, NULL, 0),
(1319, 'NORBERTO CHAPOÑAN FARRO', '', '', '', 1, 2, '10175877750', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1320, 'CRUZ SUYON COBEÑAS', '', '', '', 1, 1, '1691961', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1321, 'LEONCIO SEGUNDO TRUJILLO', 'CASERIO PAREDONES CHONGOYAPE', '', '', 1, 1, '47353379', 1, 'MICORREO@MAIL.COM', '', 130102, 0, '', 1, NULL, NULL, NULL, 0),
(1322, 'RAYMUNDO VILLEGAS DE SUCLUPE ANA JULIA', 'CAMPIÑA MUY FINCA S/N', '', '', 1, 1, '16740795', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(1323, 'VIRGUILIO ZEÑA', 'CASERIO SIALUPE BACA', '', '', 1, 1, '41674031', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1324, 'JOSE CAJUSOL VALDERA', '', '', '916986334', 1, 1, '17559258', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(1325, 'FERREYROS S.A.', 'KM792 CARRETERA LAMBAYEQUE', '', '', 1, 2, '20100028698', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1326, 'LUIS ZULUETA MONTENGRO', '', '', '990136568', 1, 1, '40680319', 1, 'MICORREO@MAIL.COM', '', 190601, 0, '', 1, NULL, NULL, NULL, 0),
(1327, 'SEGUNDO LLONTOP AGAPITO', '', '', '925549526', 1, 1, '75973756', 1, 'MICORREO@MAIL.COM', '', 130106, 0, '', 1, NULL, NULL, NULL, 0),
(1328, 'MARTIN ALFREDO FARFAN FERNANDEZ', '', '', '975301601', 1, 1, '48394367', 1, 'MICORREO@MAIL.COM', '', 130204, 0, '', 1, NULL, NULL, NULL, 0),
(1329, 'DANGNER MAXIMO MARCELO TUÑOQUE', '', '', '922441757', 1, 1, '80319990', 1, 'MICORREO@MAIL.COM', '', 130204, 0, '', 1, NULL, NULL, NULL, 0),
(1330, 'LEONARDO DE LA CRUZ CARLOS', '', 'BATANGRANDE', '935477956', 1, 1, '17419059', 1, 'MICORREO@MAIL.COM', '', 130204, 0, '', 1, NULL, NULL, NULL, 0),
(1331, 'LUIS ALBERTO CORONADO DAMIAN', '', '', '934491907', 1, 1, '44459291', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(1332, 'LLONTOP RELUZ DOMINGO', '', 'CHACUPE', '998457787', 1, 1, '16717109', 1, 'MICORREO@MAIL.COM', '', 130115, 0, '', 1, NULL, NULL, NULL, 0),
(1333, 'GUERRERO & VERA S.A.C.', 'MZA. C LOTE. 6 URB. PRO INDUSTRIAL (A DOS CUADRAS DE REVISIONES TECNICAS VEH) LIMA - LIMA - SAN MARTIN DE PORRES', '', '', 1, 2, '20601970687', 1, 'MICORREO@MAIL.COM', '', 140126, 0, '', 1, NULL, NULL, NULL, 0),
(1334, 'SANTOS ALEJANDRO APONTE ORTIZ', '', '', '', 1, 1, '3652681', 1, 'MICORREO@MAIL.COM', '', 190601, 0, '', 1, NULL, NULL, NULL, 0),
(1335, 'AGRICOLA MEZCU S.A.C', 'CAR. ANTIGUA PANAMERICANA NORT FND. SANTO TOMAS KM. 827', '', '', 1, 2, '20561128635', 1, 'MICORREO@MAIL.COM', '', 130304, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1336, 'MENDOZA GAMARRA ROSA', '', '', '912848629', 1, 1, '75929129', 1, 'MICORREO@MAIL.COM', '', 60101, 0, '', 1, NULL, NULL, NULL, 0),
(1337, 'HERRERA BECERRA XAVIER ALEXANDER', '', '', '987685939', 1, 1, '75564225', 1, 'MICORREO@MAIL.COM', '', 130114, 0, '', 1, NULL, NULL, NULL, 0),
(1338, 'GRUPO MALDONADO E INVERSIONES S.A.C', 'MZA. G1 LOTE. 06 OTR. PARQUE INDUSTRIAL PARCELA DOS LIMA - LIMA - VILLA EL SALVADOR', '', '', 1, 2, '20548649065', 1, 'MICORREO@MAIL.COM', '', 140101, 0, '', 1, NULL, NULL, NULL, 0),
(1339, 'CARLOS ZAVALETA CUBAS', '', 'BATANGRANDE', '935611464', 1, 1, '16672811', 1, 'MICORREO@MAIL.COM', '', 130201, 0, '', 1, NULL, NULL, NULL, 0),
(1340, 'BAJAC CONTRATISTAS GENERALES EIRL', 'CARRERETA A REQUE MZ B LOTE 5 URB PUERTAS DEL SOL LA VICTORIA CHICLAYO', '', '', 1, 2, '20488104978', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1341, 'ARSENIO GUERRERO CARRASCO', '', '', '', 1, 1, '2854512', 1, 'MICORREO@MAIL.COM', '', 190101, 0, '', 1, NULL, NULL, NULL, 0),
(1342, 'ELEODORO CHUQUITUCTO NARRO', '', '', '', 1, 1, '19189327', 1, 'MICORREO@MAIL.COM', '', 120501, 0, '', 1, NULL, NULL, NULL, 0),
(1343, 'CESAR DOMINGUEZ RAMOS', '', '', '', 1, 1, '72654428', 1, 'MICORREO@MAIL.COM', '', 130110, 0, '', 1, NULL, NULL, NULL, 0),
(1344, 'JOSE  JOEL SANCHEZ CAJUSOL', '', '', '', 1, 2, '10478012263', 1, 'MICORREO@MAIL.COM', '', 120101, 0, '', 1, NULL, NULL, NULL, 0),
(1345, 'JOSE JOEL SANCHEZ CAJUSOL', '', '', '', 1, 2, '10478012263', 1, 'JOELSANCHEZ_93@HOTMAIL.COM', '', 120101, 0, '', 1, NULL, NULL, NULL, 0),
(1346, 'OSCAR PASCO VIDAL', '', '', '', 1, 1, '27674293', 1, 'MICORREO@MAIL.COM', '', 120503, 0, '', 1, NULL, NULL, NULL, 0),
(1347, 'JESUS QUINTANA VELASQUEZ', '', '', '', 1, 1, '48305869', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1348, 'JOSE DE LA ROSA MILLONES CAMPOS', '', '', '', 1, 1, '17429676', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1349, 'DIEGO OBANDO', '', '', '', 1, 1, '74050809', 1, 'MICORREO@MAIL.COM', '', 130308, 0, '', 1, NULL, NULL, NULL, 0),
(1350, 'VLADIMIR LUCAS JUAREZ GUAYANAY', '', '', '', 1, 1, '43426360', 1, 'MICORREO@MAIL.COM', '', 190101, 0, '', 1, NULL, NULL, NULL, 0),
(1351, 'ROJAS GAMONAL ANTHONY JESUS', 'MORROPON', '', '', 1, 2, '10776791615', 1, 'MICORREO@MAIL.COM', '', 190101, 0, '', 1, NULL, NULL, NULL, 0),
(1352, 'ANGEL CHAVEZTA RELUZ', 'CHACUPE', '', '', 1, 1, '16761955', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1353, 'JOSE MERCES PORTAL EUGENIO', '', '', '', 1, 1, '19199830', 1, 'MICORREO@MAIL.COM', '', 60101, 0, '', 1, NULL, NULL, NULL, 0),
(1354, 'KENEDY MICHAEL BUSTOS GUSMAN', '', '', '', 1, 1, '44094482', 1, 'MICORREO@MAIL.COM', '', 120101, 0, '', 1, NULL, NULL, NULL, 0),
(1355, 'MARAKOS GRILL SAC', 'AV . SANTA VICTORIA 470 URB. SANTA VICTORIA', '', '', 1, 2, '20605066942', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1356, 'JESICA GARCIA SANTISTEBAN', '', 'MUY FINCA', '952221783', 1, 1, '42955899', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(1357, 'MILANS GENERAL SERVICES EIRL', 'JR. SANTA ASUNCION NRO. 425 (OBISPADO) CAJAMARCA - CHOTA - CHOTA', '', '', 1, 2, '20606989904', 1, 'MICORREO@MAIL.COM', '', 60601, 0, '', 1, NULL, NULL, NULL, 0),
(1358, 'ROGELIO FERNANDEZ CARHUAJULCA', '', 'ZAÑA', '', 1, 1, '16738307', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1359, 'AGROPECUARIA CARPENA EIRL', 'KM 792 PANMERICANA NORTE', '', '', 1, 2, '20561208400', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1360, 'CONTRUCTORA CHUCAS EIRL', 'CALLE LOS INCAS 664 MORROPE', '', '', 1, 2, '20601396115', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1361, 'LINDE PERU S.R.L', 'AV. ALFREDO BENAVIDES NRO. 801 INT. PI11 URB. MIRAFLORES (AV.PASEO DE LA REPUBLICA5887-5895,PISO11)', '', '', 1, 2, '20338570041', 1, 'MICORREO@MAIL.COM', '', 140136, 0, '', 1, NULL, NULL, NULL, 0),
(1362, 'RUBI CORREA PERES', '', '', '', 1, 1, '45613442', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1363, 'INVERSIONES & SERVICIOS MULTIPLES JADE K.M. S.A.C.', 'MZA. B LOTE. 09 C.P. NUEVO HORIZONTE (ULTIMA CALLE DE ALFONSO UGARTE)', '', '', 1, 2, '20601772281', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1364, 'THE GOLD CORPORATION SOCIEDAD COMERCIAL DE RESPONSABILIDAD LIMITADA - THE GOLD CORPORATION S.R.L', 'CAL.LIBERTAD MZ. 167 LOTE 22 MZA. 167 LOTE. 22 OTR. CENT. LA UNION (CERCA A ESCUELA DE SUB OFICIALES PNP) PIURA - PIURA - LA UNION', '', '', 1, 2, '20602601316', 1, 'MICORREO@MAIL.COM', '', 190106, 0, '', 1, NULL, NULL, NULL, 0),
(1365, 'FRANCISCO DELGADO CLAVO', '', '', '942466618', 1, 1, '17448343', 1, 'MICORREO@MAIL.COM', '', 130201, 0, '', 1, NULL, NULL, NULL, 0),
(1366, 'MIGUEL CHAVESTA GAMARRA', '', 'CHACUPE ALTO', '928399104', 1, 1, '40346089', 1, 'MICORREO@MAIL.COM', '', 130115, 0, '', 1, NULL, NULL, NULL, 0),
(1367, 'MARCIAL CUEVA QUIROZ', 'PACASMAYO', '', '', 1, 1, '28066600', 1, 'MICORREO@MAIL.COM', '', 120503, 0, '', 1, NULL, NULL, NULL, 0),
(1368, 'DHMONT SAC CONTRATISTAS GENERALES', 'AV ANGAMOS ESTE 1648 OF 404', '', '', 1, 2, '20108664640', 1, 'MICORREO@MAIL.COM', '', 140131, 0, '', 1, NULL, NULL, NULL, 0),
(1369, 'NEYSER DELGADO FERNANDEZ', '', 'ZAÑA', '978810034', 1, 1, '74296062', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1370, 'JOSE MERCEDES SANTA MARIA SANDOVAL', '', 'CRUZ BLANCA', '916050964', 1, 1, '17545803', 1, 'MICORREO@MAIL.COM', '', 130312, 0, '', 1, NULL, NULL, NULL, 0),
(1371, 'MUNICIPALIDAD DISTRITAL DE SAN CARLOS', 'JR. SANTA CATALINA NRO. S/N (PLAZA DE ARMAS) AMAZONAS - BONGARA - SAN CARLOS', '', '', 1, 2, '20350033557', 1, 'MICORREO@MAIL.COM', '', 10308, 0, '', 1, NULL, NULL, NULL, 0),
(1372, 'NVERSIONES AGROFE BYD S.A.C.', 'CAL.HUMBOLT NRO. 461 P.J. SAN ANTONIO', '', '', 1, 2, '20601999235', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1373, 'JOSE VICTOR AGUILAR SANTISTEBAN', '', 'PUNTO 4', '929339053', 1, 1, '41488739', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(1374, 'TITO FERNANDEZ CHUQUE', '', '', '945081373', 1, 1, '16749835', 1, 'MICORREO@MAIL.COM', '', 130102, 0, '', 1, NULL, NULL, NULL, 0),
(1375, 'CRUZ JIMENEZ CARMEN VICTORIA', 'CALLE UNION 560', '', '', 1, 2, '10458407725', 1, 'MICORREO@MAIL.COM', '', 190301, 0, '', 1, NULL, NULL, NULL, 0),
(1376, 'EDUARDO RAMOS SANTA MARIA', '', '', '', 1, 1, '17556463', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1377, 'JESUS INOÑAY ROJAS', 'FERREÑAFE', '', '', 1, 1, '17401304', 1, 'MICORREO@MAIL.COM', '', 130201, 0, '', 1, NULL, NULL, NULL, 0),
(1378, 'INVERSIONES Y SERVICIOS MULTIPLES FLORENCIA S.A.C.', 'CAL.HUSARES DE JUNIN NRO. 868 P.J. GARCES LAMBAYEQUE - CHICLAYO - JOSE LEONARDO ORTIZ', '', '', 1, 2, '20605560157', 1, 'MICORREO@MAIL.COM', '', 130112, 0, '', 1, NULL, NULL, NULL, 0),
(1379, 'VIMALCA E.I.R.L.', 'JR. MANOA NRO. 617 DPTO. 02 URB. CHACRA COLORADA LIMA - LIMA - BREÑA', '', '', 1, 2, '20487789764', 1, 'MICORREO@MAIL.COM', '', 140104, 0, '', 1, NULL, NULL, NULL, 0),
(1380, 'SALINAS AVENDAÑO MARIO', 'CALLE CIRO ALEGRIA S/N', '', '', 1, 2, '10093770779', 1, 'MICORREO@MAIL.COM', '', 10601, 0, '', 1, NULL, NULL, NULL, 0),
(1381, 'DISTRIBUCIONES OLANO S.A.C.', 'CAL.LEONCIO PRADO NRO. 549 URB. EL PORVENIR LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20103365628', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1382, 'BIOTECNOLOGIAS INTERNACIONALES SOCIEDAD ANONIMA CERRADA', 'MZA. O LOTE. 30 URB. LAS PALMAS LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20487645762', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1383, 'AGUSTIN SAMPEN SANCHEZ', '', '', '943997269', 1, 1, '16410716', 1, 'MICORREO@MAIL.COM', '', 130115, 0, '', 1, NULL, NULL, NULL, 0),
(1384, 'ROY CHARLES SANDOVAL MORENO', 'JR. FRANCIA 641', '', '', 1, 2, '10415001865', 1, 'MICORREO@MAIL.COM', '', 140109, 0, '', 1, NULL, NULL, NULL, 0),
(1385, 'NORVIL SANTACRUZ SANCHEZ', '', '', '', 1, 1, '48336130', 1, 'MICORREO@MAIL.COM', '', 210101, 0, '', 1, NULL, NULL, NULL, 0),
(1386, 'EFIGENIO TERRONES RAMIREZ', '', '', '', 1, 1, '16761170', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1387, 'REYES DE LA CRUZ FERMIN', 'CHICLAYO', '', '', 1, 1, '73540011', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1388, 'CBM ELECTROMECANICA & CONSTRUCCIONES S.A.C.', 'CAL.IRMA SAAVEDRA DE SOSA NRO. 162 LOT. GILBERTO TORRES MURO LAMBAYEQUE - LAMBAYEQUE - MOTUPE', '', '', 1, 2, '20605318372', 1, 'MICORREO@MAIL.COM', '', 130307, 0, '', 1, NULL, NULL, NULL, 0),
(1389, 'JOSE ALBERTO MARTINEZ VASQUEZ', '', '', '', 1, 2, '10423982026', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1390, 'ALEJANDRA ISABEL COLCHADO RODRIGUEZ', 'ZAÑA', '', '', 1, 1, '74776452', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1391, 'SANTOS ALBERTO GIRON CARDOZA', '', '', '', 1, 2, '10166422847', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1392, 'LUIS MORALES VENTURA', '', '', '950124312', 1, 1, '47672550', 1, 'MICORREO@MAIL.COM', '', 130201, 0, '', 1, NULL, NULL, NULL, 0),
(1393, 'JOSE CALDERON SANCHEZ', '', '', '964725033', 1, 1, '45362755', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1394, 'JOSE LUIS MEDINA OLAYA', '', '', '', 1, 1, '44001820', 1, 'MICORREO@MAIL.COM', '', 190601, 0, '', 1, NULL, NULL, NULL, 0),
(1395, 'AGRO CORRECTORES DEL PERU SOCIEDAD COMERCIAL DE RESPONSABILIDAD LIMITADA', 'MZA. N LOTE 1 URB. EL INGENIERO I', '', '', 1, 2, '20538966933', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1396, 'HUMBERTO AGUILAR ZAPANA', '', '', '', 1, 1, '43105471', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1397, 'M&M INGENIERIA OBRAS Y SERVICIOS EIRL', 'AV VICTOR RAUL HAYA DE LA TORRE 1508', '', '', 1, 2, '20487908526', 1, 'MICORREO@MAIL.COM', '', 130115, 0, '', 1, NULL, NULL, NULL, 0),
(1398, 'VARAYOC AGRO S.A.C', '-LA ENCALADA NRO. 1090 INT. 401', '', '', 1, 2, '20602375189', 1, 'MICORREO@MAIL.COM', '', 140130, 0, '', 1, NULL, NULL, NULL, 0),
(1399, 'INVERSIONES Y NEGOCIOS LASAMI SAC', 'CAL.SAN MARTIN NRO. 870 CENTRO (ALTURA C.4 PARALELA AL PARQUE) LAMBAYEQUE - LAMBAYEQUE - OLMOS', '', '', 1, 2, '20539236319', 1, 'MICORREO@MAIL.COM', '', 130308, 0, '', 1, NULL, NULL, NULL, 0),
(1400, 'IMPORTACIONES AARON E.I.R.L.', 'MZA. 27 LOTE. 46 A.H. JESUS DE NAZARENO (2DO PISO) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20606035951', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1401, 'OFFIRE SERVICIOS GENERALES E.I.R.L', 'AV. FERNANDO BELAUNDE TERRY NRO. 660 RES. VILLA FAP LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20607620416', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1402, 'S & M FOODS SOCIEDAD ANONIMA CERRADA - S & M FOODS S.A.C.', 'CAL. MIGUEL ALJOVIN NRO 277 URB. EL ROSEDAL', '', '', 1, 2, '20542089106', 1, 'MICORREO@MAIL.COM', '', 40107, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1403, 'C & J SERVILUZ E.I.R.L.', 'AV. RAMON CASTILLA NRO. 373 LAMBAYEQUE - LAMBAYEQUE - LAMBAYEQUE', '', '', 1, 2, '20606321253', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1404, 'ERIKA CRUZ CUEVA', '', '', '', 1, 1, '72507961', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1405, 'ASOCIACION DE PRODUCTORES AGROPECUARIOS VALLE VERDE DE RODRIGUEZ DE MENDOZA', 'AV. JUAN PARDO DE MIGUEL NRO. 635 AMAZONAS - RODRIGUEZ DE MENDOZA - SAN NICOLAS', '', '', 1, 2, '20600682386', 1, 'MICORREO@MAIL.COM', '', 10501, 0, '', 1, NULL, NULL, NULL, 0),
(1406, 'MARTHA NORIEGA', '', '', '', 1, 1, '6531007', 1, 'MICORREO@MAIL.COM', '', 120101, 0, '', 1, NULL, NULL, NULL, 0),
(1407, 'FUNDO LA BODEGA S.A.C.', 'CAL.LOS AYMARAS NRO. 180 URB. MARANGA LIMA - LIMA - SAN MIGUEL', '', '', 1, 2, '20600638131', 1, 'MICORREO@MAIL.COM', '', 140127, 0, '', 1, NULL, NULL, NULL, 0),
(1408, 'LEONCITO SOCIEDAD ANONIMA', 'CAL.HUAYNA CAPAC NRO. 1795 LAMBAYEQUE - CHICLAYO - LA VICTORIA', '', '', 1, 2, '20479675971', 1, 'MICORREO@MAIL.COM', '', 130115, 0, '', 1, NULL, NULL, NULL, 0),
(1409, 'NEGOCIOS GENERALES LEIMART E.I.R.L.', 'CAL.LOS QUIPUS NRO. 770 URB. LA VICTORIA SC. CUATRO LAMBAYEQUE - CHICLAYO - LA VICTORIA', '', '', 1, 2, '20606328355', 1, 'MICORREO@MAIL.COM', '', 130115, 0, '', 1, NULL, NULL, NULL, 0),
(1410, 'ELVIS DIAS CASTILLO', '', '', '', 1, 1, '27144454', 1, 'MICORREO@MAIL.COM', '', 120501, 0, '', 1, NULL, NULL, NULL, 0),
(1411, 'CUBAS CORREA MANUEL JESUS', '', '', '', 1, 2, '10279632449', 1, 'MICORREO@MAIL.COM', '', 61001, 0, '', 1, NULL, NULL, NULL, 0),
(1412, 'FRANK COLCHON ESQUIVES', '', 'REQUE', '', 1, 1, '43110194', 1, 'MICORREO@MAIL.COM', '', 130115, 0, '', 1, NULL, NULL, NULL, 0),
(1413, 'JULIO GARCIA GALVEZ', '', '', '', 1, 1, '46490586', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1414, 'FARFAN CASTILLO JULIO ARMANDO', '', '', '', 1, 1, '40781250', 1, 'MICORREO@MAIL.COM', '', 120903, 0, '', 1, NULL, NULL, NULL, 0),
(1415, 'ROJAS CHANCAFE SARA ADELINA', 'CHICLAYO', '', '', 1, 2, '10405050396', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1416, 'EMPRESA AGRO PALTO PAYAC S.R.L.', '----PARCELA NRO. REF SAN JUAN - LA ZARANDA (PARCELA 10772,HOSPEDAJE BOSQUE DE POMAC) LAMBAYEQUE - FERREÑAFE - PITIPO', '', '', 1, 2, '20538980251', 1, 'MICORREO@MAIL.COM', '', 130204, 0, '', 1, NULL, NULL, NULL, 0),
(1417, 'MARIA ZEÑA ROQUE', '', '', '', 1, 1, '41480290', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1418, 'CABANILLAS ORTIZ JAMER HUILE', 'CALLE HUACA BLANCA ALTA 07 ASENT. H. HUACA BLANCA ALTA', '', '', 1, 1, '19324846', 1, 'MICORREO@MAIL.COM', '', 120902, 0, '', 1, NULL, NULL, NULL, 0),
(1419, 'AGRICOLA PUEMAPE S.A.C. - AGROPUE S.A.C.', 'CAR. PUEMAPE FND. CARRETERA A PUEMAPE KM. 6.30', '', '', 1, 2, '20603679513', 1, 'MICORREO@MAIL.COM', '', 120501, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1420, 'INDUAMERICA TRADE S.A', 'CRT F. BELAUNDE T. KM. 462 EL PORVENIR (PLANTA INDUSTRIAL RIOJA) SAN MARTIN - RIOJA - RIOJA', '', '', 1, 2, '20531524579', 1, 'MICORREO@MAIL.COM', '', 210501, 0, '', 1, NULL, NULL, NULL, 0),
(1421, 'MIRIAN SOLEDAD GARCIA OCHOA', '', 'REQUE', '', 1, 1, '16777171', 1, 'MICORREO@MAIL.COM', '', 130115, 0, '', 1, NULL, NULL, NULL, 0),
(1422, 'JUAN SUCLUPE LLONTOP', '', '', '944322028', 1, 1, '47704134', 1, 'MICORREO@MAIL.COM', '', 130306, 0, '', 1, NULL, NULL, NULL, 0),
(1423, 'HECTOR ESCRIBANO LLAUCE', '', '', '', 1, 2, '10434300571', 1, 'MICORREO@MAIL.COM', '', 130201, 0, '', 1, NULL, NULL, NULL, 0),
(1424, 'VALENCIA SEBASTIANI LUIS ROBERTO', '', '', '', 1, 2, '10167188040', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1425, 'HUGO AMBROSIO ORELLANO SANCHEZ', '', '', '955766213', 1, 1, '17630501', 1, 'MICORREO@MAIL.COM', '', 130307, 0, '', 1, NULL, NULL, NULL, 0),
(1426, 'EDUARDO VELAZQUEZ TELLO', '', '', '', 1, 1, '27715734', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1427, 'JOSE MANUEL CORNEJO MEDINA', '', '', '', 1, 1, '41091815', 1, 'MICORREO@MAIL.COM', '', 190601, 0, '', 1, NULL, NULL, NULL, 0),
(1428, 'CENTRO MEDICO LA REVA SOCIEDAD ANONIMA CERRADA', 'CAL.VICENTE DE LA VEGA NRO. 1236 CERCADO DE CHICLAYO LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20600398378', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1429, 'GRUBEN EIRL', 'C.H VILLA CALIFORNIA MZ O LT 21', '', '', 1, 2, '20603738307', 1, 'MICORREO@MAIL.COM', '', 190101, 0, '', 1, NULL, NULL, NULL, 0),
(1430, 'CORPORACION FERRETERA ERI E.I.R.L.', 'AV. ARICA NRO. 1138 LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20604232628', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1431, 'NOR 3 PERU SOCIEDAD ANONIMA CERRADA - N3PERU S.A.C.', 'AV. CRISTOBAL DE PERALTA SUR NRO. 231 DPTO. 401 URB. VALLE HERMOSO DE MONTERRICO ZONA ESTE LIMA - LIMA - SANTIAGO DE SURCO', '', '', 1, 2, '20601702267', 1, 'MICORREO@MAIL.COM', '', 140101, 0, '', 1, NULL, NULL, NULL, 0),
(1432, 'FACTORIA QUIROZ Y SERVICIOS GENERALES E.I.R.L.', 'CAL.AREQUIPA -NORTE NRO. 303 PATAZCA INDUSTRIAL LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20561180041', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1433, 'ABANTO URBINA HECTOR CELSO', '', '', '', 1, 2, '10430458294', 1, 'MICORREO@MAIL.COM', '', 120901, 0, '', 1, NULL, NULL, NULL, 0),
(1434, 'JAVIER CARLOS DE LA CRUZ', '', '', '', 1, 1, '44896179', 1, 'MICORREO@MAIL.COM', '', 130206, 0, '', 1, NULL, NULL, NULL, 0),
(1435, 'AGROEXPORTADORA LA QUINA S.A.C', 'MZA. 12 LOTE 12 URB. LA PURISIMA', '', '', 1, 2, '20607449571', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1436, 'CURIMAPU PERU SOCIEDAD ANONIMA CERRADA', 'CAL.CALLE PALMA MAJESTUOSA NRO. B2 URB. URBANIZACIÓN LOS COCOS DEL CHIPE PIURA - PIURA - PIURA', '', '', 1, 2, '20606218371', 1, 'MICORREO@MAIL.COM', '', 190101, 0, '', 1, NULL, NULL, NULL, 0),
(1437, 'AGROINDUSTRIAS & COMERCIO SOCIEDAD ANONIMA', 'NRO S.N. OTR. PREDIO EL TORO', '', '', 1, 2, '20487800831', 1, 'MICORREO@MAIL.COM', '', 130106, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1438, 'CARRASCO CASTREJON CRUZ', '', '', '', 1, 2, '10435831821', 1, 'MICORREO@MAIL.COM', '', 60101, 0, '', 1, NULL, NULL, NULL, 0),
(1439, 'CONSORCIO SUPERVISOR ACRUTA - EURO', 'AV. MARISCAL LA MAR NRO. 638 DPTO. 304 URB. FUNDO SANTA CRUZ (ENTRE LA MAR CON JOAQUIN CAPELO) LIMA - LIMA - MIRAFLORES', '', '', 1, 2, '20607104639', 1, 'MICORREO@MAIL.COM', '', 140115, 0, '', 1, NULL, NULL, NULL, 0),
(1440, 'CROPS PROTECTION S.A.C.', 'CAL.MICAELA BASTIDAS MZA. F LOTE. 21 URB. ALTO MOCHICA (ATRAS DEL GRIFO REPSOL) LA LIBERTAD - TRUJILLO - TRUJILLO', '', '', 1, 2, '20600672631', 1, 'MICORREO@MAIL.COM', '', 120101, 0, '', 1, NULL, NULL, NULL, 0),
(1441, 'WALTER DAMIAN SANDOLVAL', '', '', '988446616', 1, 1, '17561909', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(1442, 'ITAL IMPORT DE MAQUINARIAS S.A.C.', 'CAL.DIEGO FERRE NRO. 239- (DIEGO FERRE 241 FINAL AVENIDA BRASIL) LIMA - LIMA - MAGDALENA DEL MAR', '', '', 1, 2, '20304584948', 1, 'MICORREO@MAIL.COM', '', 140128, 0, '', 1, NULL, NULL, NULL, 0),
(1443, 'CORONEL HUAMAN GERSON JEREL', '', '', '', 1, 2, '10710988833', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1444, 'INTERAMERICANA NORTE S.A.C', 'MZA. 240 LOTE. 02 INT. . Z.I. ANTIGUA DE PIURA PIURA - PIURA - PIURA', '', '', 1, 2, '20483998270', 1, 'MICORREO@MAIL.COM', '', 190101, 0, '', 1, NULL, NULL, NULL, 0);
INSERT INTO `cliente` (`codigo_cli`, `nombre_cli`, `direccion_cli`, `ciudad_cli`, `telefono_cli`, `codigo_tip`, `codigo_doc`, `numero_doc`, `codigo_szo`, `email_cli`, `observacion_cli`, `codigo_dis`, `estadosunat_cli`, `condicionsunat_cli`, `estado_cli`, `usuario_reg`, `usuario_mod`, `fecha_mod`, `sistema`) VALUES
(1445, 'ILUSTRE COLEGIO DE ABOGADOS DE LAMBAYEQUE', 'CAL.JOSE CARLOS MARIATEGUI MZA. G LOTE. 16 URB. ARTURO CABREJOS FALLA (CON LOS ROSALES Y MARIATEGUI) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20180966332', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1446, 'HEINER AVELLANEDA BRAVO', '', '', '948691459', 1, 1, '27720761', 1, 'MICORREO@MAIL.COM', '', 60501, 0, '', 1, NULL, NULL, NULL, 0),
(1447, 'MARCO ANOTONIO SAMAME SILVA', '', '', '', 1, 1, '27377768', 1, 'MICORREO@MAIL.COM', '', 60101, 0, '', 1, NULL, NULL, NULL, 0),
(1448, 'AGRO EXPORT EL LIMON S.R.L', 'CAL. ANCON NRO 154 URB. SANTA VICTORIA', '', '', 1, 2, '20601873827', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1449, 'CONSULTORIA Y MONTAJE EDMATEDE S.A.C.', 'MZA. J LOTE. 19 URB. LA PRADERA LAMBAYEQUE - CHICLAYO - PIMENTEL', '', '', 1, 2, '20606680661', 1, 'MICORREO@MAIL.COM', '', 130110, 0, '', 1, NULL, NULL, NULL, 0),
(1450, 'PRECINSERG CONTRATISTAS GENERALES E.I.R.L.', 'PRO.LEGUIA MZA. B LOTE. 2 P.J. JORGE BASADRE LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20605841865', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1451, 'MANECA GRUPO EMPRESARIAL S.A.C.', 'NRO. 598 URB. MATEO PUMACAHUA (DETRÁS MARIANITO FERRO C2P) CUSCO - CUSCO - WANCHAQ', '', '', 1, 2, '20607763632', 1, 'MICORREO@MAIL.COM', '', 70101, 0, '', 1, NULL, NULL, NULL, 0),
(1452, 'GRAU LOGISTICA EXPRESS S.A.', 'CAL.1 NRO. 253 URB. FDO. BOCANEGRA ALTO (FRENTE AL AEROPUERTO JORGE CHAVEZ) PROV. CONST. DEL CALLAO - PROV. CONST. DEL CALLAO - CALLAO', '', '', 1, 2, '20600876211', 1, 'MICORREO@MAIL.COM', '', 140101, 0, '', 1, NULL, NULL, NULL, 0),
(1453, 'ASOCIACIÓN DE PRODUCTORES AGROINDUSTRIALES TUCAC ALTO', 'NRO. S/N CAS. TUCAC ALTO CAJAMARCA - CHOTA - QUEROCOTO', '', '', 1, 2, '20606524731', 1, 'MICORREO@MAIL.COM', '', 60614, 0, '', 1, NULL, NULL, NULL, 0),
(1454, 'COMERCIAL RAFAEL NORTE SOCIEDAD ANONIMA CERRADA', 'AV. CIRCUNVALACION MZA. J LOTE. 11-A A.H. SANTA CRUZ (ALTURA OVALO) PIURA - PIURA - TAMBO GRANDE', '', '', 1, 2, '20526058578', 1, 'MICORREO@MAIL.COM', '', 190109, 0, '', 1, NULL, NULL, NULL, 0),
(1455, 'GALVEZ ASOCIADOS S.A.C', 'JR. SAN MARTIN NRO. 706 INT. 2 (SEGUNDO PISO) CAJAMARCA - CHOTA - CHOTA', '', '', 1, 2, '20495811736', 1, 'MICORREO@MAIL.COM', '', 60601, 0, '', 1, NULL, NULL, NULL, 0),
(1456, 'SOPORTE SYSTEM S.A.C', 'CAL.2 MZA. Q LOTE. 18 URB. PRO 7MA ET. LIMA - LIMA - SAN MARTIN DE PORRES', '', '', 1, 2, '20605634029', 1, 'MICORREO@MAIL.COM', '', 140126, 0, '', 1, NULL, NULL, NULL, 0),
(1457, 'NKAFERRO PERÚ S.A.C.', 'AV. ARGENTINA NRO. 3441 (COSTADO DE MINKA) PROV. CONST. DEL CALLAO - PROV. CONST. DEL CALLAO - CALLAO', '', '', 1, 2, '20519305098', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1458, 'MANUEL TORRES CAMPOS', 'PIMENTEL - CHICLAYO', '', '', 1, 2, '10165390348', 1, 'MICORREO@MAIL.COM', '', 130110, 0, '', 1, NULL, NULL, NULL, 0),
(1459, 'SERVICIOS GENERALES MOPA E.I.R.L.', 'MZA. G LOTE. 7 INT. 4PIS URB. LOS JAZMINES LA LIBERTAD - TRUJILLO - TRUJILLO', '', '', 1, 2, '20605150374', 1, 'MICORREO@MAIL.COM', '', 120101, 0, '', 1, NULL, NULL, NULL, 0),
(1460, 'PARRAS NUEVAS S.A.C.', 'JR. FRANCISCO MORENO NRO. 389 URB. CERCADO DE LIMA LIMA - LIMA - SURQUILLO', '', '', 1, 2, '20601263506', 1, 'MICORREO@MAIL.COM', '', 140131, 0, '', 1, NULL, NULL, NULL, 0),
(1461, 'ASOCIACION DE POBALADORES SECTOR ZAPOTE - MOTUPE', '', '', '', 1, 1, '8653978', 1, 'MICORREO@MAIL.COM', '', 130307, 0, '', 1, NULL, NULL, NULL, 0),
(1462, 'PEÑA MONDRAGON JHON MARLON', '', '', '', 1, 1, '47460914', 1, 'MICORREO@MAIL.COM', '', 130307, 0, '', 1, NULL, NULL, NULL, 0),
(1463, 'JORGE JOEL LLAMO MEDINA', '', '', '', 1, 2, '10411545291', 1, 'MICORREO@MAIL.COM', '', 130308, 0, '', 1, NULL, NULL, NULL, 0),
(1464, 'LUBRICENTRO VIRGEN MARIA MAGDALENA E.I.R.L.', 'VIA DE EVITAMIENTO CDRA 24 NRO. -- CAS. AJOSCANCHA (FRNT TALLER BIGOTE - POR GRIFO TEPSA) CAJAMARCA - CAJAMARCA - CAJAMARCA', '', '', 1, 2, '20600869192', 1, 'MICORREO@MAIL.COM', '', 60101, 0, '', 1, NULL, NULL, NULL, 0),
(1465, 'ANA ELIZABET CASTRO MEGO', '', '', '', 1, 1, '16681433', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1466, 'YTALA ADRIA SALAZAR DIAZ', '', '', '', 1, 1, '16623091', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1467, 'PROCESOS MUCHIK SOCIEDAD DE RESPONSABILIDAD LIMITADA', 'CAL.EL CAMPAMENTO NRO. 04 CAS. CHACUPE LAMBAYEQUE - CHICLAYO - MONSEFU', '', '', 1, 2, '20600094212', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1468, 'AVES DEL TAMBO S.A.C.', 'CAL.POEMAS HUMANOS NRO. 190 URB. CESAR VALLEJO LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20607704318', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1469, 'ORTIZ LOSSIO S.R.L.', 'AV. SALAVERRY NRO. 3060 INT. 401 LIMA - LIMA - MAGDALENA DEL MAR', '', '', 1, 2, '20103594571', 1, 'MICORREO@MAIL.COM', '', 140114, 0, '', 1, NULL, NULL, NULL, 0),
(1470, 'HEALTH LAB SOCIEDAD ANONIMA CERRADA', 'CAL.JOSE DE LA TORRE UGARTE NRO. 373 URB. CHICLAYO ET. DOS LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20602343678', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1471, 'UNIDAD EJECUTORA 108 PROGRAMA NACIONAL DE INFRAESTRUCTURA EDUCATIVA', 'JR. CARABAYA NRO. 341 URB. CERCADO DE LIMA LIMA - LIMA - LIMA', '', '', 1, 2, '20514347221', 1, 'MICORREO@MAIL.COM', '', 140101, 0, '', 1, NULL, NULL, NULL, 0),
(1472, 'DAMIAN CERQUERA', '', '', '', 1, 1, '16779328', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1473, 'CRUZADO ARMAS OLGA TOMASA', '', '', '', 1, 2, '10166160419', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1474, 'NAMERICA FM E.I.R.L.', 'PRO.VICTOR ANDRES BELAUNDE NRO. 149 URB. REMIGIO SILVA ET. DOS LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20602305130', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1475, 'CONSTRUCCIONES CORONA SCRL', 'AV. GRAU NRO. 350 DPTO. 404 RES. EDIFICIO GRAN PLAZA LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20479953024', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1476, 'NIXON CENTURION LOPEZ', '', '', '', 1, 1, '48491289', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1477, 'IEI 450 EL PALMO LOS BOLICHES', '', '', '', 1, 1, '40484400', 1, 'MICORREO@MAIL.COM', '', 130308, 0, '', 1, NULL, NULL, NULL, 0),
(1478, 'ALMACENES ASWAN S.A.C', '----ETAPA A MZA. 03 LOTE. 01 A.H. CAMPO AMOR TUMBES - ZARUMILLA - ZARUMILLA', '', '', 1, 2, '20600078446', 1, 'MICORREO@MAIL.COM', '', 230301, 0, '', 1, NULL, NULL, NULL, 0),
(1479, 'I.E.N° 11222 \"SAN FRANCISCO DE PAREDONES\" SAN JOSE .', 'SAN JOSE', '', '', 1, 1, '16806936', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1480, 'EDUARDO MONTALVO GARCIA', '', '', '', 1, 1, '16652854', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1481, 'INVERSIONES AGRICOLAS RIO GRANDE SOCIEDAD ANONIMA CERRADA', 'JR. TARMA NRO. 269 DPTO. 201 CERCADO DE LIMA LIMA - LIMA - LIMA', '', '', 1, 2, '20603812906', 1, 'MICORREO@MAIL.COM', '', 140101, 0, '', 1, NULL, NULL, NULL, 0),
(1482, 'SIPAN DISTRIBUCIONES SOCIEDAD ANONIMA CERRADA', 'CAR.NUEVA MONSEFU KM. 2.7 SEC. CHACUPE (AL COSTADO MOLINO NUEVO HORIZONTE) LAMBAYEQUE - CHICLAYO - LA VICTORIA', '', '', 1, 2, '20479504068', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1483, 'AVICOLA CHAVA E.I.R.L.', 'AV. JOSE BALTA NRO. 031 LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20602679315', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1484, 'ZC IDEAL GROUP S.A.', 'JR. FRAY ANGÉLICO NRO. 250 INT. 101 LIMA - LIMA - SAN BORJA', '', '', 1, 2, '20600924282', 1, 'MICORREO@MAIL.COM', '', 140140, 0, '', 1, NULL, NULL, NULL, 0),
(1485, 'CORPORACION D & JOAKO E.I.R.L.', 'NAZARETH NRO. 859 P.J. ZAMORA (ESPALDAS DEL CRUZ DEL SUR) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20600123948', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1486, 'GUZMAN RAMIREZ BRAVO', '936685471', '', '', 1, 1, '27288691', 1, 'MICORREO@MAIL.COM', '', 60501, 0, '', 1, NULL, NULL, NULL, 0),
(1487, 'JUAN BENAVIDES', 'JR SGTO MOJICA 105 CASERIO MATAPALO', '', '', 1, 1, '43482749', 1, 'MICORREO@MAIL.COM', '', 230302, 0, '', 1, NULL, NULL, NULL, 0),
(1488, 'SOLUCIONES INDUSTRIALES WINSAN S.A.C.', 'CAL.NICOLAS CARNERO NRO. 139 P.J. SAN JUAN (ESPALDAS DEL CENTRO DE SALUD DE MOTUPE) LAMBAYEQUE - LAMBAYEQUE - MOTUPE', '', '', 1, 2, '20602401406', 1, 'MICORREO@MAIL.COM', '', 130307, 0, '', 1, NULL, NULL, NULL, 0),
(1489, 'JOGE ALCIDES', '', '', '', 1, 1, '33959409', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1490, 'CITV REVIPERU S.A.C.', 'CAR.PANAMERICANA NORTE KM. 773 PANAMERICANA NORTE (AL COSTADO DEL GRIFO SAN ANTONIO) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20603852215', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1491, 'JOSE JONATHAN RAMIREZ BAQUERIZO', 'CALLE OLLANTAY 290 LA VICTORIA', '', '', 1, 2, '10450427549', 1, 'MICORREO@MAIL.COM', '', 130115, 0, '', 1, NULL, NULL, NULL, 0),
(1492, 'PROYECTOS E INVERSIONES AKROPOLIS S.A.C', 'AV. LOS INCAS NRO. 1054 URB. LA VICTORIA SC. TRES PARC. A LAMBAYEQUE - CHICLAYO - LA VICTORIA', '', '', 1, 2, '20604473846', 1, 'MICORREO@MAIL.COM', '', 130115, 0, '', 1, NULL, NULL, NULL, 0),
(1493, 'JOSE MANUEL PUICON FACUNDO', '', '', '', 1, 1, '71743305', 1, 'MICORREO@MAIL.COM', '', 130307, 0, '', 1, NULL, NULL, NULL, 0),
(1494, 'ICETT DIAS GUERRERO', '', '', '', 1, 1, '41518583', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1495, 'JADVA CONTRATISTAS GENERALES E.I.R.L.', 'CAL.NANCY GUTIERREZ VALERA MZA. A LOTE. 35 C.P. ENCARNACION LAMBAYEQUE - CHICLAYO - JOSE LEONARDO ORTIZ', '', '', 1, 2, '20604874981', 1, 'MICORREO@MAIL.COM', '', 130112, 0, '', 1, NULL, NULL, NULL, 0),
(1496, 'EDGAR PAUL PALACIOS ASALDE', 'CATACAOS', '', '', 1, 1, '70554223', 1, 'MICORREO@MAIL.COM', '', 190104, 0, '', 1, NULL, NULL, NULL, 0),
(1497, 'AGROCAMPO INVERSIONES SAC', 'CAL. MINERIAS NRO 365 URB. LOS FICUS', '', '', 1, 2, '20606800488', 1, 'MICORREO@MAIL.COM', '', 140143, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1498, 'SERVICIOS GENERALES MARSEN SAC', 'CAL.ATAHUALPA LOTE. 5A CENTRO (CERCA A UNA INSTITUCION EDUCATIVA) LAMBAYEQUE - CHICLAYO - PIMENTEL', '', '', 1, 2, '20539214340', 1, 'MICORREO@MAIL.COM', '', 130110, 0, '', 1, NULL, NULL, NULL, 0),
(1499, 'FLORES CASTAÑEDA VICTOR MANUEL', '1 ERO DE MAYO 378 URRUNAGA JOSE LEONARDO ORTIZ CHICLAYO', '', '', 1, 2, '10166770390', 1, 'MICORREO@MAIL.COM', '', 130112, 0, '', 1, NULL, NULL, NULL, 0),
(1500, 'EDUARDO A.E NORIEGA A', 'AV. LUIS GONZALES 766 OF 16', '', '', 1, 2, '10164013800', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1501, 'IEI N° 420 FANNY ABANTO CALLE', 'CAHUIDE JAYANCA', '', '', 1, 1, '40159257', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1502, 'IE 11177 JOSE SANTOS CHOCANO GASTAÑODI', 'CAHUIDE JAYANCA', '', '', 1, 1, '16666977', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1503, 'SIXTO ATALAYA ATALAYA', 'LAGUNAS MOCUPE', '', '', 1, 1, '80055664', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1504, 'WALDIR PINTADO CARMEN', '', '', '', 1, 1, '40613498', 1, 'MICORREO@MAIL.COM', '', 190101, 0, '', 1, NULL, NULL, NULL, 0),
(1505, 'FELMIG MOTOR S REPRESENTACIONES GEN EIRL', 'CALLE LOS EJIDOS DEL NORTE S/N', '', '', 1, 2, '20440703837', 1, 'MICORREO@MAIL.COM', '', 190101, 0, '', 1, NULL, NULL, NULL, 0),
(1506, 'VIANCA MARILIN ELERA GUERRERO', 'MZ D2 LT 10 AH LA PRIMAVERA I ETAPA CASTILLA PIURA', '', '', 1, 2, '10432136677', 1, 'MICORREO@MAIL.COM', '', 190101, 0, '', 1, NULL, NULL, NULL, 0),
(1507, 'FUNDO DON JOSUE S.A.C.', 'MZA. K LOTE. 24 P.J. FRANCISCO BOLOGNESI LAMBAYEQUE - FERREÑAFE - MANUEL ANTONIO MESONES MURO', '', '', 1, 2, '20607254631', 1, 'MICORREO@MAIL.COM', '', 130206, 0, '', 1, NULL, NULL, NULL, 0),
(1508, 'FUMIGACIONES CIELO SRL', 'CAL.LOS TAMBOS NRO. 1347 LAMBAYEQUE - CHICLAYO - LA VICTORIA', '', '', 1, 2, '20480035675', 1, 'MICORREO@MAIL.COM', '', 130115, 0, '', 1, NULL, NULL, NULL, 0),
(1509, 'KAIROS KIDS PALACIO DEL BEBE S.A.C', 'AV. LUIS GONZALES NRO. 1330 CERCADO DE CHICLAYO LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20606153555', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1510, 'MARIANA PATRICIA TALLEDO MENDEZ', '', '', '', 1, 1, '74162504', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1511, 'HILDER CABRERA DELGADO', 'CHICLAYO', '', '', 1, 2, '10732628954', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1512, 'FLORES MIRANDA WILDER', 'CP PORTA DE LA SIERRA SAN JOSE PACASMAYO', '', '', 1, 2, '10266410226', 1, 'MICORREO@MAIL.COM', '', 120506, 0, '', 1, NULL, NULL, NULL, 0),
(1513, 'SANTOS CUEVA MABEL', '', '', '', 1, 2, '10485612624', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1514, 'I.E. 11033 MARIO SAMAME BOGGIO', 'AV VICTOR MURO 1145', '', '', 1, 1, '0', 1, 'MICORREO@MAIL.COM', '', 130201, 0, '', 1, NULL, NULL, NULL, 0),
(1515, 'I.E.I. N° 419 SANTA MARIA MAGDALENA', 'LA PAMPA MORROPE', '', '', 1, 1, '16704129', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1516, 'SERVICIO AGRICOLA LATINO SOCIEDAD ANONIMA CERRADA', 'CAL.EDUARDO SAN CRISTOBAL NRO. 1783 URB. SAN PABLO (ALT. CDRA. 6 AV. AVIACION) LIMA - LIMA - LA VICTORIA', '', '', 1, 2, '20510871783', 1, 'MICORREO@MAIL.COM', '', 140109, 0, '', 1, NULL, NULL, NULL, 0),
(1517, 'FRUTOS DEL NORTE SANTA MARTHA SAC', 'AV. JOSE LEONARDO ORTIZ NRO. 156 INT. 402 URB. LOS PARQUES LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20606134381', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1518, 'ARACELY GASDALY VILCHERREZ  GIL', 'CHICLAYO', '', '', 1, 2, '10776657897', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1519, 'ANTERO SIESQUEN SANTISTEBAN', 'CASERIO LAS PAMPAS', '', '', 1, 1, '16744676', 1, 'MICORREO@MAIL.COM', '', 130306, 0, '', 1, NULL, NULL, NULL, 0),
(1520, 'JOEL NAVARRO SALDIVAR', 'TAMBO REAL BATAN GRANDE', '', '', 1, 2, '10483900258', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1521, 'GRACENORT FOOD S.A.C.', 'CAR.PANAMERICANA NORTE KM. 783 SEC. SEC. MOCCE LAMBAYEQUE - LAMBAYEQUE - LAMBAYEQUE', '', '', 1, 2, '20605367047', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1522, 'COMUNIDAD CAMPESINA DE SANTA ROSA', 'SANTA ROSA', '', '', 1, 1, '0', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1523, 'PUBLINTEX S.A.C.', 'CAL.FRANCISCO GRAÑA NRO. 652 URB. SANTA CATALINA LIMA - LIMA - LA VICTORIA', '', '', 1, 2, '20600484533', 1, 'MICORREO@MAIL.COM', '', 140101, 0, '', 1, NULL, NULL, NULL, 0),
(1524, 'LUIS OBLITAS SAMAME', 'PUCALA', '', '', 1, 1, '43585473', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1525, 'NOE CORRALES HERRERA', '', '', '', 1, 1, '71632933', 1, 'MICORREO@MAIL.COM', '', 60501, 0, '', 1, NULL, NULL, NULL, 0),
(1526, 'GLINT SAC', 'AV. DEL RIO NRO. 484 URB. BAHIA LIMA - LIMA - PUEBLO LIBRE (MAGDALENA VIEJA)', '', '', 1, 2, '20546671161', 1, 'MICORREO@MAIL.COM', '', 140117, 0, '', 1, NULL, NULL, NULL, 0),
(1527, 'TUBOS Y POSTES CHACUPE S.A.C', 'TUBOS Y POSTES CHACUPE S.A.C.', '', '', 1, 2, '20601628890', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1528, 'CYNTHIA RICRA REYES', '', '', '', 1, 1, '45933635', 1, 'MICORREO@MAIL.COM', '', 130201, 0, '', 1, NULL, NULL, NULL, 0),
(1529, 'I.E N° 16425', 'CASA BLANCA PIMPINGOS', '', '', 1, 1, '0', 1, 'MICORREO@MAIL.COM', '', 60501, 0, '', 1, NULL, NULL, NULL, 0),
(1530, 'FERNANDO VERA CIEZA', '', '', '', 1, 1, '74455305', 1, 'MICORREO@MAIL.COM', '', 60501, 0, '', 1, NULL, NULL, NULL, 0),
(1531, 'PIZBAD S.A.C', 'C.RUSECTOR LA CHABELA NRO. 140 CAS. CIENEGUILLO CENTRO PIURA - SULLANA - SULLANA', '', '', 1, 2, '20607943908', 1, 'MICORREO@MAIL.COM', '', 190101, 0, '', 1, NULL, NULL, NULL, 0),
(1532, 'CORPORACION AGRICOLA OLMOS SOCIEDAD ANONIMA', 'AV. ALFREDO BENAVIDES NRO. 1944 INT. 504 URB. EL ROSEDAL (EDIFICIO SWISS TOWER)', '', '', 1, 2, '20563196387', 1, 'MICORREO@MAIL.COM', '', 140115, 0, '', 1, NULL, NULL, NULL, 0),
(1533, 'DYRANI S.A.C.', 'CAL.NICOLAS REBAZA NRO. 627 URB. LAS QUINTANAS LA LIBERTAD - TRUJILLO - TRUJILLO', '', '', 1, 2, '20606597828', 1, 'MICORREO@MAIL.COM', '', 120101, 0, '', 1, NULL, NULL, NULL, 0),
(1534, 'INMOBILIARIA CONDOMINIOS DE CHICLAYO S.A.C.', 'CAL.7 DE ENERO NRO. 579 CERCADO DE CHICLAYO LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20603889704', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1535, 'MI CAUTIVO DE AYABACA SOCIEDAD ANONIMA CERRADA', 'CAR.PANAMERICANA NORTE NRO. 777 (KM 777.8 PUENTE SAN NICOLAS) LAMBAYEQUE - LAMBAYEQUE - LAMBAYEQUE', '', '', 1, 2, '20480433999', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1536, 'RANCHO PANCHO S.A.C', 'AV. PETIT THOUARS NRO. 5029 DPTO. 403 LIMA - LIMA - MIRAFLORES', '', '', 1, 2, '20604534349', 1, 'MICORREO@MAIL.COM', '', 140115, 0, '', 1, NULL, NULL, NULL, 0),
(1537, 'VARGAS TARRILLO ARSENIO', '', '', '', 1, 2, '10414778106', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1538, 'REPRESENTACIONES Y SERVICIOS INGENIEROS S.R.L.', 'NRO. F INT. 9-A URB. LA ARBOLEDA (A ESPALDAS DE LA UPAO) LA LIBERTAD - TRUJILLO - TRUJILLO', '', '', 1, 2, '20198746992', 1, 'MICORREO@MAIL.COM', '', 120101, 0, '', 1, NULL, NULL, NULL, 0),
(1539, 'MULTISERVICIOS CRISMOTOR S E.I.R.L.', 'JR. SAN JOSE NRO. 412 CAS. MONTE SULLON (AL COSTADO DE LA CAPILLA SAN MARTIN) PIURA - PIURA - CATACAOS', '', '', 1, 2, '20607998524', 1, 'MICORREO@MAIL.COM', '', 190104, 0, '', 1, NULL, NULL, NULL, 0),
(1540, 'CORPORACION ANDINA DE NEGOCIOS E.I.R.L.', 'AV. LUIS GONZALES NRO. 1530 LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20479955744', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1541, 'CONSTRUCTORA E INMOBILIARIA LEONARDO DA VINCI E.I.R.L', 'CAL.LIMA NRO. 781 CENTRO CHEPEN (A CUATRO CUADRAS DE PLAZA DE ARMAS) LA LIBERTAD - CHEPEN - CHEPEN', '', '', 1, 2, '20477340700', 1, 'MICORREO@MAIL.COM', '', 120901, 0, '', 1, NULL, NULL, NULL, 0),
(1542, 'ZENAIDA SOLEDAD CABRERA QUISPE', 'INCANATO 508', '', '', 1, 1, '16691031', 1, 'MICORREO@MAIL.COM', '', 130112, 0, '', 1, NULL, NULL, NULL, 0),
(1543, 'DYRANI S.A.C', 'CAL.NICOLAS REBAZA NRO. 627 URB. LAS QUINTANAS LA LIBERTAD - TRUJILLO - TRUJILLO', '', '', 1, 2, '20606597828', 1, 'MICORREO@MAIL.COM', '', 120101, 0, '', 1, NULL, NULL, NULL, 0),
(1544, 'EINER ROJAS LOPEZ', '', '', '', 1, 1, '33422051', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(1545, 'MAFTAL EIRL', 'CALLE LOS SAUCOS NUMERO 172- PRIMER PISO ,LILMA,LIMA ,LOS OLIVOS', '', '', 1, 2, '20533279661', 1, 'MICORREO@MAIL.COM', '', 140142, 0, '', 1, NULL, NULL, NULL, 0),
(1546, 'CONSORCIO DIANA PAOLA Y CONSULTORES SAC', 'CALLE VIRGEN DEL CARMEN NUMERO 7 CASERIO CACHINCHE', '', '', 1, 2, '20607557765', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1547, 'COLEGIO SAN AGUSTIN', 'CAR.A PIMENTEL NRO. KM08 CARRETERA A PIMENTEL LAMBAYEQUE - CHICLAYO - PIMENTEL', '', '', 1, 2, '20103560757', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1548, 'CDSP 583', 'SAN MIGUEL DE PAICO', '', '', 1, 1, '80375561', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1549, 'MEDINA NUÑEZ JOYCE JIOVANA', '', '', '', 1, 2, '10403358989', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1550, 'IEI 029- VIRGEN DE GUADALUPE', 'CALLE NIEPOS S/N - NUEVA ARICA', '', '', 1, 2, '20602233694', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1551, 'SALAZAR CORNEJO JUAN PABLO', '', '', '', 1, 2, '10415687562', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1552, 'SALAZAR CORNEJO JUANPABLO', 'CAL. CESAR VALLEJO 145 PJ SANTA ROSA', '', '', 1, 2, '10415687562', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1553, 'MOLINERA DEL CENTRO S.C.R.LTDA.', 'CAL.LOS PINOS NRO. 156 OFICINA B12 EDIFICIO SUR (COSTADO OECHSLE-ALT CDRA 2 AV BENAVIDES) LIMA - LIMA - MIRAFLORES', '', '', 1, 2, '20396102057', 1, 'MICORREO@MAIL.COM', '', 140115, 0, '', 1, NULL, NULL, NULL, 0),
(1554, 'MERLY LISBET MORALES ROBLES', '', '', '', 1, 1, '43620515', 1, 'MICORREO@MAIL.COM', '', 190104, 0, '', 1, NULL, NULL, NULL, 0),
(1555, 'SAMUEL ROJAS BOCANEGRA', 'ROMA 260 URRUNAGA JOSE LEONARDO ORTIZ', '', '', 1, 2, '10165375632', 1, 'MICORREO@MAIL.COM', '', 130112, 0, '', 1, NULL, NULL, NULL, 0),
(1556, 'PORTENTO INVERSIONES GLOBAL SOCIEDAD ANONIMA CERRADA', 'CAL.SAN JOSE NRO. 761 INT. 16 CENTRO DE CHICLAYO (CENTRO COMERCIAL UBICENTRO) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20487634132', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1557, 'ERIKSON OMAR MONTEZA CARRASCO', 'CHONGOYAPE', '', '', 1, 2, '10414017911', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1558, 'DAVID PEREZ DIAZ', '', '', '', 1, 1, '16577097', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1559, 'SAN LUIS ASOCIADOS E.I.R.L.', 'CAR.PANAMERICANA NORTE KM. 2.5 (FRENTE AL GRIFO NOR ORIENTE) LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20480689101', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1560, 'IE 215-NIÑO DEL SABER', 'CALLE VICTORIA S/N', '', '', 1, 1, '17814485', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1561, 'TEODORO HUIMAN MONDRAGON', 'CHICLAYO', '', '', 1, 2, '10166115219', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1562, 'EMPRESA SALUDABLE EN TRATAMIENTO Y TECNICAS AGRARIAS S.A.C', 'CAL.EL ENGRANAJE MZA. A LOTE. 4 URB. IND LA MILLA (ALTURA SERPOST) LIMA - LIMA - SAN MARTIN DE PORRES', '', '', 1, 2, '20601314691', 1, 'MICORREO@MAIL.COM', '', 140126, 0, '', 1, NULL, NULL, NULL, 0),
(1563, 'VIDAURRE SANCHEZ PEDRO', '', '', '', 1, 1, '80319599', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1564, 'VALDERA TEJADA JUANA ISABEL', '', '', '', 1, 2, '10167447215', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1565, 'SERGIO DANIEL LLONTOP SANTAMARIA', '', '', '', 1, 1, '75878486', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1566, 'VERA MORI PATRICIA DEL ROCIO', 'CALLAE SAN MARTIN 1137 PJ SEÑOR DE LA JUSTICIA', '', '', 1, 2, '10608686431', 1, 'MICORREO@MAIL.COM', '', 130201, 0, '', 1, NULL, NULL, NULL, 0),
(1567, 'GILMER ALRCON RUBIO', '', '', '', 1, 1, '42600808', 1, 'MICORREO@MAIL.COM', '', 120901, 0, '', 1, NULL, NULL, NULL, 0),
(1568, 'ANGEL BERNABE ORDOÑEZ / ALBERTO ESQUEN MAYANGA', '', '', '', 1, 1, '17590009', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1569, 'VENTURA SANDOVAL BENIGNO', '', '', '', 1, 1, '17621807', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1570, 'JESUS GALLARDO ROQUE', '', '', '', 1, 1, '47477973', 1, 'MICORREO@MAIL.COM', '', 130308, 0, '', 1, NULL, NULL, NULL, 0),
(1571, 'MARPROTEIN FISH S.A.C.', 'AV. CIRCUNVALACION CLUB GOLF LOS INCAS NRO. 202 INT. 1102 URB. CLUB GOLF LOS INCAS LIMA - LIMA - SANTIAGO DE SURCO', '', '', 1, 2, '20608203851', 1, 'MICORREO@MAIL.COM', '', 140101, 0, '', 1, NULL, NULL, NULL, 0),
(1572, 'MARTIN RODRIGUEZ URCIA', '', '', '', 1, 1, '16764823', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1573, 'JILMER ALARCON RUBIO', '', '', '', 1, 1, '42600808', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1574, 'CONSTRUCTORA E INMOBILIARIA TITANIO S.A.C.', 'CAL. CORONEL LEONCIO PRADO NRO 270', '', '', 1, 2, '20561291463', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1575, 'HERRERA PEREZ YANETH', 'CUTERVO', '', '', 1, 2, '10460575805', 1, 'MICORREO@MAIL.COM', '', 60501, 0, '', 1, NULL, NULL, NULL, 0),
(1576, 'HERCAT E.I.R.L', 'MZA. C LOTE. 1 URB. SAN FRANCISCO (A ESPALDAS DEL CEO VIRGEN DE FATIMA) LAMBAYEQUE - LAMBAYEQUE - LAMBAYEQUE', '', '', 1, 2, '20605067582', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1577, 'TODO EQUIPOS & SERVICIO DEL PERU E.I.R.L.', 'AV. GULLMAN NRO. 294 URB. LOS MAGISTRADOS PIURA (AL COSTADO DEL HOTEL LEO) PIURA - PIURA - PIURA', '', '', 1, 2, '20600683749', 1, 'MICORREO@MAIL.COM', '', 190101, 0, '', 1, NULL, NULL, NULL, 0),
(1578, 'JOSE DEL CARMEN DE LA CRUZ ACOSTA', '', '', '', 1, 1, '17602057', 1, 'MICORREO@MAIL.COM', '', 130116, 0, '', 1, NULL, NULL, NULL, 0),
(1579, 'ALFONSO VERONA TANTARICO', '', '', '', 1, 1, '16502845', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1580, 'NUSATEC S.A.C', 'CAL. SAN FELIPE NRO. 830 NVO SAN LORENZO (ALTURA MAR. CORNEJO Y VENEZUELA)', '', '', 1, 2, '20487721612', 1, 'MICORREO@MAIL.COM', '', 130112, 0, '', 1, NULL, NULL, NULL, 0),
(1581, 'C.G. MICH-INVERSIONES Y SERVICIOS S.A.C.', 'CAL.MIGUEL GRAU NRO. 0370 CENTR MOCHUMI (A MEDIA CDRA. DE PARQUE PRINCIPAL) LAMBAYEQUE - LAMBAYEQUE - MOCHUMI', '', '', 1, 2, '20601458919', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(1582, 'CONSTRUCTORA CALDERON & PAICO S.A.C.', 'JR. MANUEL DEL PINO NRO. 582 DPTO. 303 URB. SANTA BEATRIZ LIMA - LIMA - LIMA', '', '', 1, 2, '20553983569', 1, 'MICORREO@MAIL.COM', '', 140101, 0, '', 1, NULL, NULL, NULL, 0),
(1583, 'TARRI CAMPO E.I.R.L.', 'CAL.MAXIMILIANO OYOLA MZA. 3 LOTE. 26 INT. B P.J. CRUZ DE CHALPON LAMBAYEQUE - LAMBAYEQUE - OLMOS', '', '', 1, 2, '20600864450', 1, 'MICORREO@MAIL.COM', '', 130308, 0, '', 1, NULL, NULL, NULL, 0),
(1584, 'AGROINDUSTRIAS SAN FRANCISCO S.A.C', 'MZA. C3 LOTE 14 DEP. 301 COO. SANTA AURELIA', '', '', 1, 2, '20438341421', 1, 'MICORREO@MAIL.COM', '', 140143, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1585, 'NOVAGRO AG S.A.C', 'MZA C12 LT 8 PARQUE INDUSTRIAL LA LIBERTAD LA ESPERANZA', '', '', 1, 2, '20477464263', 1, 'MICORREO@MAIL.COM', '', 120111, 0, '', 1, NULL, NULL, NULL, 0),
(1586, 'FUNDO LA BODEGA S.A.C', 'CAL.LOS AYMARAS NRO. 180 URB. MARANGA LIMA - LIMA - SAN MIGUEL', '', '', 1, 2, '20600638131', 1, 'MICORREO@MAIL.COM', '', 140127, 0, '', 1, NULL, NULL, NULL, 0),
(1587, 'MATFAL EMPRESA INDIVIDUAL DE RESPONSABILIDAD LIMITADA - MATFAL E.I.R.L.', 'CAL.LOS SAUCOS NRO. 171 INT. 101 URB. MICAELA BASTIDAS (PRIMER PISO) LIMA - LIMA - LOS OLIVOS', '', '', 1, 2, '20533279661', 1, 'MICORREO@MAIL.COM', '', 140142, 0, '', 1, NULL, NULL, NULL, 0),
(1588, 'MOLINO SAMAN S.R.L.', 'AV. CESAR VALLEJO NRO. 1403 DPTO. 1001 URB. RISSO LIMA - LIMA - LINCE', '', '', 1, 2, '20397854397', 1, 'MICORREO@MAIL.COM', '', 140111, 0, '', 1, NULL, NULL, NULL, 0),
(1589, 'VIME SERVER E.I.R.L.', 'CAL.SANTA ANA MZA. 67 LOTE. 03 P.J. SANTA ANA (COSTADO DE LA COMISARIA) LAMBAYEQUE - LAMBAYEQUE - LAMBAYEQUE', '', '', 1, 2, '20603497946', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1590, 'TRANSBER S.A.C.', 'CAL.CADMIO NRO. 129 URB. INDUSTRIAL GRIMANESA (109 -135- ALT CUADRA 29 AV. ELMER FAUCE) PROV. CONST. DEL CALLAO - PROV. CONST. DEL CALLAO - CALLAO', '', '', 1, 2, '20101158927', 1, 'MICORREO@MAIL.COM', '', 140101, 0, '', 1, NULL, NULL, NULL, 0),
(1591, 'JOSE CHERO BENITES', '', '', '', 1, 2, '10415280781', 1, 'MICORREO@MAIL.COM', '', 190101, 0, '', 1, NULL, NULL, NULL, 0),
(1592, 'CONSEGESA S.A.', 'JR. ARICA NRO. 290 URB. LA MERCED JUNIN - CHANCHAMAYO - CHANCHAMAYO', '', '', 1, 2, '20121797314', 1, 'MICORREO@MAIL.COM', '', 110401, 0, '', 1, NULL, NULL, NULL, 0),
(1593, 'ASESORES Y CONSULTORES VELASQUEZ ING & ASOCIADOS S.A.C.', 'CAL.TORRES PAZ NRO. 770 LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20539002911', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1594, 'ORLANDO DENIS BONILLA BRAVO', '', '', '', 1, 1, '75522457', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1595, 'WILIAN ROLANDO RUIZ CARREÑO', '', '', '', 1, 1, '43482367', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1596, 'JUNIOR BALCAZAR', '', '', '', 1, 1, '41786642', 1, 'MICORREO@MAIL.COM', '', 190101, 0, '', 1, NULL, NULL, NULL, 0),
(1597, 'APLICACION TECNOLOGICA DEL AUTOMOVIL IRH S.A.C.', 'CAL.VICTOR R HAYA DE LA TORRE NRO. 2770 LAMBAYEQUE - CHICLAYO - LA VICTORIA', '', '', 1, 2, '20605208593', 1, 'MICORREO@MAIL.COM', '', 130115, 0, '', 1, NULL, NULL, NULL, 0),
(1598, 'NEGOCIOS GENERALES COSISE E.I.R.L.', 'MZA. P3 LOTE. 14 INT. 01 URB. COSSIO DEL POMAR (ESPALDAS DE COLEGIO ENTRE PAMPONES) PIURA - PIURA - CASTILLA', '', '', 1, 2, '20600355989', 1, 'MICORREO@MAIL.COM', '', 190103, 0, '', 1, NULL, NULL, NULL, 0),
(1599, 'CHEN NIÑO JOSE LUIS', 'CHICLAYO', '', '', 1, 2, '10704638481', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1600, 'JOSE LUIS PERLECHE SAMILLAN', '', '', '', 1, 1, '16550651', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1601, 'IPROMEC PERU SOCIEDAD ANONIMA CERRADA - IPROMEC PERU S.A.C.', 'MZA. R-1 LOTE 40 URB. SN DIEGO VIPOL 1ET.', '', '', 1, 2, '20522104613', 1, 'MICORREO@MAIL.COM', '', 140126, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1602, 'REUPO VALLEJOS VICTOR ARTURO', 'AV. AGUSTO B LEGUIA 330', '', '', 1, 2, '10402638163', 1, 'MICORREO@MAIL.COM', '', 130201, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1603, 'EDUCAR SEMBRANDO ONGD', 'CAL.15 NRO. 199 URB. LAS MAGNOLIAS (A 2 CDRAS. DE LA MERCED) LIMA - LIMA - SANTIAGO DE SURCO', '', '', 1, 2, '20520861166', 1, 'MICORREO@MAIL.COM', '', 140101, 0, '', 1, NULL, NULL, NULL, 0),
(1604, 'INVERSIONES MI AUGUSTO OSWALDO SOCIEDAD ANONIMA CERRADA', 'CAL.03 DE MAYO NRO. 209 CAS. LETIRA (ALT. COLEGIO ABRAHAM LUIS NUNURA) PIURA - SECHURA - VICE', '', '', 1, 2, '20600944461', 1, 'MICORREO@MAIL.COM', '', 190802, 0, '', 1, NULL, NULL, NULL, 0),
(1605, 'CORPORACION CHAVARRIA E.I.R.L.', 'CAL. LOS TULIPANES MZA. B LOTE 05 A.H. LOS PARQUES', '', '', 1, 2, '20607878502', 1, 'MICORREO@MAIL.COM', '', 100105, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1606, 'JULIO CESAR GUEVARA ALVARADO', '', '', '', 1, 1, '26612766', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1607, 'DAISY CATALINA CHAVEZ JULCA', '', '', '', 1, 1, '41697221', 1, 'MICORREO@MAIL.COM', '', 120101, 0, '', 1, NULL, NULL, NULL, 0),
(1608, 'CASTILLO & LOPEZ CONTRATISTAS E INVERSIONES GENERALES SAC', 'AV. EL EJERCITO NRO 1210 C.P. JOSE CARLOS MARIATEGUI', '', '', 1, 2, '20561216411', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1609, 'LUIS FERNANDO DIAZ CENTURION', '', '', '', 1, 1, '70835511', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1610, 'DRYWALL CONSTRUYE S.A.C', 'CAL.TUMBES NORTE NRO. 296 URB. PATAZCA LAMBAYEQUE - CHICLAYO - CHICLAYO', '', '', 1, 2, '20606141841', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1611, 'PEDRO AVILA JABO', '', '', '', 1, 1, '42496408', 1, 'MICORREO@MAIL.COM', '', 190208, 0, '', 1, NULL, NULL, NULL, 0),
(1612, 'ROGER RODRIGO LOAYZA', '', 'BATAN GRANDE', '925345531', 1, 1, '42022938', 1, 'MICORREO@MAIL.COM', '', 130204, 0, '', 1, NULL, NULL, NULL, 0),
(1613, 'TRANSFORMACIONES AGROQUIMICAS Y SERVICIOS SOCIEDAD ANONIMA CERRADA', 'JR. LA MARINA NRO 31 C.P. LA GARITA', '', '', 1, 2, '20604731845', 1, 'MICORREO@MAIL.COM', '', 130110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1614, 'AGRICOLA LA TEJERIA E.I.R.L.', 'INT. 01 MZA. C LOTE 1 15 URB. LA ESTACION', '', '', 1, 2, '20480631791', 1, 'MICORREO@MAIL.COM', '', 130110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1615, 'WALTER LLONTOP VIDAURRE', '', '', '', 1, 1, '45720253', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1616, 'CONSORCIO VIAL LA ESPERANZA', 'JR. EZEQUIEL MONTOYA NRO 349', '', '', 1, 2, '20606948639', 1, 'MICORREO@MAIL.COM', '', 60601, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1617, 'TELMA DEL PERU S.A.C.', 'MZA. A LOTE 02 URB. LA PARADA', '', '', 1, 2, '20487599809', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1618, 'HUMBERTO ROJAS SANCHEZ', '', 'UDIMA', '973265801', 1, 1, '16730300', 1, 'MICORREO@MAIL.COM', '', 60902, 0, '', 1, NULL, NULL, NULL, 0),
(1619, 'BENITES FIESTAS WALTER', '-', '', '', 1, 2, '10166891294', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1620, 'HANS VLADIMIR ALARCON BERNAL', '', '', '', 1, 1, '41691964', 1, 'MICORREO@MAIL.COM', '', 60507, 0, '', 1, NULL, NULL, NULL, 0),
(1621, 'TAPULLIMA ISUIZA ELMA', '', '', '', 1, 2, '10009666953', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1622, 'ROLI YOVAR RAFAEL GARCIA', 'CHEPEN', '', '', 1, 1, '41520728', 1, 'MICORREO@MAIL.COM', '', 120902, 0, '', 1, NULL, NULL, NULL, 0),
(1623, 'AMBROSIO MENDOZA GUERRA', '', '', '', 1, 1, '16797247', 1, 'MICORREO@MAIL.COM', '', 130107, 0, '', 1, NULL, NULL, NULL, 0),
(1624, 'H & H GLOBAL CORP EMPRESA INDIVIDUAL DE RESPONSABILIDAD LIMITADA', 'AV. MARIANO MELGAR NRO 215', '', '', 1, 2, '20603117141', 1, 'MICORREO@MAIL.COM', '', 61101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1625, 'HOYOS VASQUEZ JOSE ENRIQUE', '-', '', '', 1, 2, '10166465422', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1626, 'JIMENEZ FALLA HILDEBRANDO', '-', '', '', 1, 2, '10175733162', 1, 'MICORREO@MAIL.COM', '', 130307, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1627, 'VICTOR CESAR CARRION MONTEZA', '', 'BATAN GRANDE', '', 1, 1, '41382462', 1, 'MICORREO@MAIL.COM', '', 130204, 0, '', 1, NULL, NULL, NULL, 0),
(1628, 'FELIPE CALLE CALLE', '', '', '', 1, 1, '46405787', 1, 'MICORREO@MAIL.COM', '', 190101, 0, '', 1, NULL, NULL, NULL, 0),
(1629, 'ALFREDO DE LA CRUZ SUCLUPE', '', '', '', 1, 1, '41395514', 1, 'MICORREO@MAIL.COM', '', 130312, 0, '', 1, NULL, NULL, NULL, 0),
(1630, 'HUARIPATA HERRERA JAVIER', '-', '', '', 1, 2, '10074847591', 1, 'MICORREO@MAIL.COM', '', 60801, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1631, 'AGRICULTORES Y PRODUCTORES SAN JUDAS TADEO S.A.C.', 'CAR. PIMENTEL FND. LA JOYITA KM. 7', '', '', 1, 2, '20487699340', 1, 'MICORREO@MAIL.COM', '', 130110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1632, 'AMBECA CONTRATISTAS GENERALES E.I.R.L.', 'CAL. FRANCISCO FALCON NRO 215 URB. EL SOL', '', '', 1, 2, '20539766385', 1, 'MICORREO@MAIL.COM', '', 120101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1633, 'CORPORACION VIRGEN DE LA CANDELARIA EIRL', 'CALLE  FRANCISCO BOLOGNESI NRO 820', '', '', 1, 2, '20607915262', 1, 'MICORREO@MAIL.COM', '', 130308, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1634, 'ANGEL RAFAEL MORALES CASTAÑEDA', '', '', '', 1, 1, '28065502', 1, 'MICORREO@MAIL.COM', '', 190101, 0, '', 1, NULL, NULL, NULL, 0),
(1635, 'CALDERON DE LA CRUZ ALBERTO', '', '', '', 1, 1, '48428850', 1, 'MICORREO@MAIL.COM', '', 130202, 0, '', 1, NULL, NULL, NULL, 0),
(1636, 'WILBERT CONDORHUAMAN GALLEGOS', '', '', '', 1, 1, '41962267', 1, 'MICORREO@MAIL.COM', '', 130114, 0, '', 1, NULL, NULL, NULL, 0),
(1637, 'LUIS', '', '', '', 1, 1, '3897889', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1638, 'CARLOS ORTIGAS CAMPOS', '', '', '', 1, 1, '33733849', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(1639, 'CABANILLAS ORTIZ NILTON OMEYTER', '-', '', '', 1, 2, '10412125555', 1, 'MICORREO@MAIL.COM', '', 120901, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1640, 'RONALD LLIQUE CONSULTORES S.R.L.', 'JR. NIÑO JESÚS NRO S/N BAR. MOLLEPAMPA', '', '', 1, 2, '20608315293', 1, 'MICORREO@MAIL.COM', '', 60101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1641, 'GILBERTO PANTA CHAPOÑAN', '', '', '', 1, 1, '17560847', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(1642, 'CONSORCIO EJECUTOR UDIMA II', 'MZA. B1 LOTE 13 RES. MAGISTERIAL', '', '', 1, 2, '20608156951', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1643, 'SANTA SOFIA DEL SUR', 'DIONISIO ANCHORENA 431', '', '', 1, 2, '20510865627', 1, 'MICORREO@MAIL.COM', '', 140101, 0, '', 1, NULL, NULL, NULL, 0),
(1644, 'NOLBERTO CRUZADO ZAMORA', '', '', '', 1, 1, '42799104', 1, 'MICORREO@MAIL.COM', '', 130311, 0, '', 1, NULL, NULL, NULL, 0),
(1645, 'DILMER HERNANDEZ HERNADEZ', '', '', '', 1, 1, '44117617', 1, 'MICORREO@MAIL.COM', '', 130102, 0, '', 1, NULL, NULL, NULL, 0),
(1646, 'TIMOTEO VILLA MENDOZA', '', '', '', 1, 1, '16567597', 1, 'MICORREO@MAIL.COM', '', 130108, 0, '', 1, NULL, NULL, NULL, 0),
(1647, 'VICTOR VASQUEZ PERES', '', '', '', 1, 1, '33741913', 1, 'MICORREO@MAIL.COM', '', 130114, 0, '', 1, NULL, NULL, NULL, 0),
(1648, 'REQUEJO MELGAR JUAN FRANCISCO', 'TRANSOCEANICA KM 115 CP MOCAPE', '', '', 1, 2, '10706925380', 1, 'MICORREO@MAIL.COM', '', 130308, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1649, 'LUIS FERNANDO ACUÑA ROJAS', '', '', '', 1, 1, '47560160', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1650, 'GRUPO MOLINERO PARCKER´S S.A.C.', 'CAR. PANAMERICANA CPM. SAN MARTIN DE PORRES KM. 690', '', '', 1, 2, '20482571604', 1, 'MICORREO@MAIL.COM', '', 50106, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1651, 'DAVILA Y ACUNA CONTRATISTAS GENERALES SA', 'CAL. LAS ACACIAS NRO 010 DEP. 201 URB. ARTURO CABREJOS FALLA', '', '', 1, 2, '20270375180', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1652, 'CORPORACION VIRGEN DE LA CANDELARIA E.I.R.L', 'CAL.FRANCISCO BOLOGNESI NRO. 820 LAMBAYEQUE - LAMBAYEQUE - OLMOS', '', '', 1, 2, '20607915262', 1, 'MICORREO@MAIL.COM', '', 130308, 0, '', 1, NULL, NULL, NULL, 0),
(1653, 'JUSTINIANO BANCES CHAPOÑAN', 'CASERIO LAGUNAS MORROPE', '', '', 1, 1, '17566424', 1, 'MICORREO@MAIL.COM', '', 130306, 0, '', 1, NULL, NULL, NULL, 0),
(1654, 'EMPRESA PRESTADORA DE SERVICIOS DE SANEAMIENTO DE AGUA POTABLE Y ALCANTARILLADO DE LAMBAYEQUE S.A.', 'AV. SAENZ PEÑA NRO 1860 URB. LATINA', '', '', 1, 2, '20103448591', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1655, 'PROGRAMA INTEGRAL NACIONAL PARA EL BIENESTAR FAMILIAR - INABIF', 'AV. SAN MARTIN NRO 685', '', '', 1, 2, '20507920722', 1, 'MICORREO@MAIL.COM', '', 20707, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1656, 'THE GOLD CORPORATION SOCIEDAD COMERCIAL DE RESPONSABILIDAD LIMITADA  - THE GOLD CORPORATION S.R.L', 'CAL. LIBERTAD MZ. 167 LOTE 22 MZA. 167 LOTE 22 OTR. CENT. LA UNION', '', '', 1, 2, '20602601316', 1, 'MICORREO@MAIL.COM', '', 40405, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1657, 'CORPORACION SEGJONA S.A.C.', 'JR. HUASCAR NRO 1447 URB. LA PERLA', '', '', 1, 2, '20601018781', 1, 'MICORREO@MAIL.COM', '', 240105, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1658, 'VASQUEZ FLORES AURA', '-', '', '', 1, 2, '10085883785', 1, 'MICORREO@MAIL.COM', '', 130110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1659, 'JUAN CARLOS FERNANDEZ CHAPOÑAN', '', '', '', 1, 1, '16405995', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1660, 'AGROINDUSTRIAS JOSE & LUIS S.A.C.', 'AV. EXEQUIEL GONZALES CACEDA NRO 875 PUEBLO', '', '', 1, 2, '20481045682', 1, 'MICORREO@MAIL.COM', '', 120901, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1661, 'PREMIUN AGRO PERU S.A.C.', 'CAL. PIURA NRO 487 DEP. 404', '', '', 1, 2, '20603017936', 1, 'MICORREO@MAIL.COM', '', 40107, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1662, 'MILLER ROMERO MEJIA', 'JAEN', '', '', 1, 1, '46938333', 1, 'MICORREO@MAIL.COM', '', 60101, 0, '', 1, NULL, NULL, NULL, 0),
(1663, 'BS BUSINESS & SERVICES EMPRESA INDIVIDUAL DE RESPONSABILIDAD LIMITADA', 'CAL. LETICIA NRO 251 INT. 104 CERCADO DE CHICLAYO', '', '', 1, 2, '20602855491', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1664, 'C & C INVERSIONES GENERALES E.I.R.L.', 'JR. AYACUCHO NRO 380 URB. CHACHAPOYAS', '', '', 1, 2, '20602684319', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1665, 'MEGAUNI INGENIEROS S.A.C.', 'JR. GARCIA HURTADO DE MENDOZA MZA. D2 LOTE 35 URB. URB.S', '', '', 1, 2, '20486531976', 1, 'MICORREO@MAIL.COM', '', 140105, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1666, 'AGRO ATLANTIC SAC', 'MZA. I LOTE 16 DEP. 2 URB. EL SANTUARIO', '', '', 1, 2, '20607084514', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1667, 'VIAJERO NIYU SOCIEDAD ANONIMA CERRADA', 'AV. LUIS GONZALES NRO 1135 CENTRO', '', '', 1, 2, '20480708688', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1668, 'JESUS CARLOS RAMOS MARZANA', '', '', '', 1, 1, '45360733', 1, 'MICORREO@MAIL.COM', '', 120901, 0, '', 1, NULL, NULL, NULL, 0),
(1669, 'CONSTRUCTORA FERVAMO S.A.C.', 'REF.:  LETRERO VÍA SAN JU OTR. AV. ANTOLÍN FLORES S/N - KM. 36.5', '', '', 1, 2, '20542145961', 1, 'MICORREO@MAIL.COM', '', 130304, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1670, 'MUNICIPALIDAD DISTRITAL DE CATACHE', 'CAL. 28 DE JULIO NRO S/N CERCADO', '', '', 1, 2, '20185117627', 1, 'MICORREO@MAIL.COM', '', 60902, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1671, 'AURA FRUIT E.I.R.L.', 'AV. MIGUEL GRAU NRO 925 DEP. 502 URB. SANTA VICTORIA', '', '', 1, 2, '20607558575', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1672, 'SERVICIOS INTEGRALES VASQUEZ MURGA E.I.R.L.', 'JR. PROLONGACIÓN PEDRO NOVOA NRO 405 URB. SAN MIGUEL', '', '', 1, 2, '20608679384', 1, 'MICORREO@MAIL.COM', '', 20317, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1673, 'AGROFALMA & CONSULTORES EMPRESA INDIVIDUAL DE RESPONSABILIDAD LIMITADA', 'CAL. CAMPO-PIMENTEL URB. CARRETERA A PIMENTEL KM. 4', '', '', 1, 2, '20600722833', 1, 'MICORREO@MAIL.COM', '', 130110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1674, 'INOÑAN VALDERA JOSE PROCESO', '-', '', '', 1, 2, '10176382266', 1, 'MICORREO@MAIL.COM', '', 130306, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1675, 'PATRICIA FABIOLA DAVILA VILLAR', '', '', '', 1, 2, '10454588776', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1676, 'CRISMED E.I.R.L.', 'AV. CAYETANO HEREDIA NRO 1045 DEP. 903', '', '', 1, 2, '20556691046', 1, 'MICORREO@MAIL.COM', '', 140133, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1677, 'NEGOCIOS AGRICOLAS S.R.L.', 'CAL. ARICA NRO 848', '', '', 1, 2, '20395937180', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1678, 'ATLANTICA S.R.L.', 'PREDIO BULLON NRO S/N', '', '', 1, 2, '20488011538', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1679, 'VASQUEZ MIREZ JUAN DEL CARMEN', '-', '', '', 1, 2, '10273823404', 1, 'MICORREO@MAIL.COM', '', 120503, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1680, 'CARLOS OMAR SILVA PAREDES', 'CALLE LOS CLAVELES 283 MCDO. MOSHOQUEQUE', '', '', 1, 1, '73772319', 1, 'MICORREO@MAIL.COM', '', 130112, 0, '', 1, NULL, NULL, NULL, 0),
(1681, 'PISOS Y APLICACIONES S.R.L.', 'CAL. JOSE QUIÑONES GONZALES NRO 224', '', '', 1, 2, '20602968279', 1, 'MICORREO@MAIL.COM', '', 130110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1682, 'PURIZACA FIESTAS JULIO CESAR', '-', '', '', 1, 2, '10476406141', 1, 'MICORREO@MAIL.COM', '', 190601, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1683, 'INVERSIONES KARIBEÑO E.I.R.L.', 'JR. ASCOPE NRO 447 INT. D1A PSJ. 15', '', '', 1, 2, '20605686231', 1, 'MICORREO@MAIL.COM', '', 10505, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1684, 'HIDRAULICA CHICLAYO EIRL.', 'CAL. SAN ISIDRO NRO 114 URB. SAN LORENZO', '', '', 1, 2, '20480335636', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1685, 'URBANS PROJECTS S.A.C.', 'JR. ANDROMEDA CUADRA 1 CONDOM NRO . INT. 406 URB. MATELLINI', '', '', 1, 2, '20602886141', 1, 'MICORREO@MAIL.COM', '', 140108, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1686, 'BKS SOCIEDAD ANONIMA CERRADA', 'CAR. A POMALCA C.P.M VILLA EL PROGRESO KM. 2.7', '', '', 1, 2, '20487433820', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1687, 'CESAR CORTRINA QUISPE', '', '', '977191908', 1, 1, '43111231', 1, 'MICORREO@MAIL.COM', '', 61005, 0, '', 1, NULL, NULL, NULL, 0),
(1688, 'DELGADO PASCO JESUS', '-', '', '', 1, 2, '10166244655', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1689, 'DIOSDADO ISAC MORE CASTILLO', '', '', '', 1, 1, '44582707', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(1691, 'MAX ALEXANDER VASQUEZ CARRANZA', '', '', '', 1, 1, '43414410', 1, 'MICORREO@MAIL.COM', '', 120901, 0, '', 1, NULL, NULL, NULL, 0),
(1692, 'JULIO RODAS MONTENEGRO', '', '', '', 1, 1, '26729549', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1693, 'JOSE VILLEGAS IPANAQUE', '', '', '', 1, 1, '17542903', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(1694, 'RADIO FERRENAFE E I R LTDA', 'CAL. FCO GONZALES BURGA NRO 717', '', '', 1, 2, '20226797671', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1695, 'MATIAS SIESQUEN PIZARRO', 'MORROPE', '', '', 1, 1, '17565898', 1, 'MICORREO@MAIL.COM', '', 130306, 0, '', 1, NULL, NULL, NULL, 0),
(1696, 'CHAPOÑAN PINGO GUSTAVO EMILIO', '-', '', '', 1, 2, '10466279329', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1697, 'QUIROGA CHERO EDILBERTO', '', '', '', 1, 1, '16705556', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1698, 'SEGUNDO SUCLUPE CAJUSOL', 'MOCHUMI', '', '', 1, 1, '80330604', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(1699, 'KING KONG LLAMPAYEC E.I.R.L.', 'AV. RAMON CASTILLA NRO 443 P.J. CPM RAMON CASTILLA', '', '', 1, 2, '20480606842', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1700, 'EL EXTERMINADOR DE PLAGAS CHICLAYO E.I.R.L.', 'CAL. PALMERAS NRO 114 DEP. 03 P.J. LA PRIMAVERA', '', '', 1, 2, '20607960667', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1701, 'EL EXTERMINADOR PIURA E.I.R.L', 'CAL. JUNIN MZA. B LOTE 17 A.H. JOSE MARIA ARGUEDAS', '', '', 1, 2, '20526489471', 1, 'MICORREO@MAIL.COM', '', 190101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1702, 'OBRAS DE IRRIGACION Y SANEAMIENTO S.A.C.', 'JR. EL PROGRESO NRO 337 URB. EL PORVENIR', '', '', 1, 2, '20604073147', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1703, 'ROQUE CHERO PABLO EMETERIO', '-', '', '', 1, 2, '10175854555', 1, 'MICORREO@MAIL.COM', '', 130308, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1704, 'ELECTROMOTRIZ RENZO SOCIEDAD ANONIMA CERRADA', 'PJ. MANUEL LUNA FUENTES NRO 265 P.J. SAN JUAN', '', '', 1, 2, '20538928250', 1, 'MICORREO@MAIL.COM', '', 130307, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1705, 'CONSTRUCTORA B & M INGENIEROS S.A.C.', 'CAL. VICENTE DE LA VEGA NRO 265 CERCADO DE CHICLAYO', '', '', 1, 2, '20602472311', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1706, 'NAYSOL MAQUINARIAS Y SERVICIOS S.A.C.', 'MZA. E1 LOTE 14 URB. LOS HUERTOS DE LA MOLINA', '', '', 1, 2, '20607983365', 1, 'MICORREO@MAIL.COM', '', 140110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1707, 'SERVICIOS AGROINDUSTRIALES DEL NORTE SAC', 'AV. HERMOGENES MEJIA SOLF NRO S/N SECTOR SANTA TERESITA', '', '', 1, 2, '20411268099', 1, 'MICORREO@MAIL.COM', '', 60801, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1708, 'AGRICOLA EL ABO S.A.C.', 'JR. TAMBOGRANDE MZA. Q LOTE 43 DEP. 2 URB. SANTA ANA', '', '', 1, 2, '20529917652', 1, 'MICORREO@MAIL.COM', '', 190101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1709, 'JULIO CESAR  CABREJOS PIZARRO', '', '', '935286359', 1, 1, '17602207', 1, 'MICORREO@MAIL.COM', '', 130312, 0, '', 1, NULL, NULL, NULL, 0),
(1710, 'INMOBILIARIA DEMARC E.I.R.L.', 'CAL. VICENTE DE LA VEGA NRO 1300', '', '', 1, 2, '20603680139', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1711, 'INVERSIONES PREVENTIVA S.R.L.', 'CAL. FRANCISCO CUNEO NRO 680 URB. PATAZCA', '', '', 1, 2, '20607295400', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1712, 'LUIS CLEMENTE HERNANDEZ RODRIGUEZ', '', '', '', 1, 1, '70782653', 1, 'MICORREO@MAIL.COM', '', 120901, 0, '', 1, NULL, NULL, NULL, 0),
(1713, 'LUISA BELEN GARCIA CORONADO', 'CASERIO MEDANO', '', '', 1, 1, '74095850', 1, 'MICORREO@MAIL.COM', '', 130308, 0, '', 1, NULL, NULL, NULL, 0),
(1714, 'CIA VASSALLO M E.I.R.L.', 'AV. EXEQUIEL GONZALES CACEDA NRO 1239', '', '', 1, 2, '20602042252', 1, 'MICORREO@MAIL.COM', '', 120901, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1715, 'JOSE ADOLFO SALAZAR MEZONES', '', '', '', 1, 1, '17436002', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1716, 'ANAXIMANDRO BARBOZA GARCIA', '', '', '', 1, 1, '27410456', 1, 'MICORREO@MAIL.COM', '', 60615, 0, '', 1, NULL, NULL, NULL, 0),
(1717, 'AGRO VILCHEZ S.A.C.', 'CAL. JUAN  GIL NRO 701', '', '', 1, 2, '20608384023', 1, 'MICORREO@MAIL.COM', '', 100105, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1718, 'SANTILLAN ROJAS GIANNI JENNER', '-', '', '', 1, 2, '10096175227', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1719, 'JS CONSTRUCCION E INGENIERIA S.A.C.', 'MZA. A LOTE 32 URB. PABLO BONER', '', '', 1, 2, '20600720440', 1, 'MICORREO@MAIL.COM', '', 140110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1720, 'JUAN WALTER FLORES CASTILLO', 'FUNDO SAN JUANITO POPAN BAJO - ZAÑA', '', '', 1, 1, '16723077', 1, 'MICORREO@MAIL.COM', '', 130114, 0, '', 1, NULL, NULL, NULL, 0),
(1721, 'MANUEL VILCHEZ COBEÑAS', '', '', '', 1, 1, '17561856', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1722, 'RONALD JESUS RAMOS CHIROQUE', '', '', '', 1, 1, '43650377', 1, 'MICORREO@MAIL.COM', '', 190101, 0, '', 1, NULL, NULL, NULL, 0),
(1723, 'RONALD DAVILA CAVANA ANCAJIMA', '', '', '', 1, 1, '45788197', 1, 'MICORREO@MAIL.COM', '', 190101, 0, '', 1, NULL, NULL, NULL, 0),
(1724, 'COOPERATIVA AGRARIA  FRONTERA SAN IGNACIO  LTDA.', 'JR. SANTA ROSA NRO 500 CERCADO', '', '', 1, 2, '20113940515', 1, 'MICORREO@MAIL.COM', '', 61101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1725, 'JOSE LUIS CHAPOÑAN SANTISTEBAN', '', '', '', 1, 1, '45380845', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1726, 'CONSTRUCTORA FERRETERA SAN ANTONIO SRL', 'CAL. TUMBES NORTE NRO 180 URB. PATAZCA', '', '', 1, 2, '20395222172', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1727, 'BAYER S.A.', 'CAL. AMADOR MERINO REYNA NRO 223 INT. 802 URB. JARDIN', '', '', 1, 2, '20100096341', 1, 'MICORREO@MAIL.COM', '', 10119, 0, 'HABIDO', 1, NULL, NULL, NULL, 0);
INSERT INTO `cliente` (`codigo_cli`, `nombre_cli`, `direccion_cli`, `ciudad_cli`, `telefono_cli`, `codigo_tip`, `codigo_doc`, `numero_doc`, `codigo_szo`, `email_cli`, `observacion_cli`, `codigo_dis`, `estadosunat_cli`, `condicionsunat_cli`, `estado_cli`, `usuario_reg`, `usuario_mod`, `fecha_mod`, `sistema`) VALUES
(1728, 'BURGOS CHANCAFE CARLOS ALBERTO', '-', '', '', 1, 2, '10166264745', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1729, 'MARCIAL CHAPOÑAN BANCES', '', '', '', 1, 1, '17563999', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1730, 'CORPORACION LITEC SOCIEDAD ANONIMA CERRADA', 'CAL. LOS AYMARAS NRO 189 URB. EL DERBY - MONTERRICO', '', '', 1, 2, '20509152552', 1, 'MICORREO@MAIL.COM', '', 140130, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1731, 'CARRION PINZON TEOTISTA ABELINA', '-', '', '', 1, 2, '10166226916', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1732, 'ASOCIACION SANTA LUCIA-CORRAL DE ARENA', 'CAL. SANTO DOMINGO NRO S/N CERCADO', '', '', 1, 2, '20600525124', 1, 'MICORREO@MAIL.COM', '', 130308, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1733, 'ZAMORA CIEZA WALTER', 'MZ B LT5 LAS DELICIAS CHICLAYO', '', '', 1, 2, '10401742803', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1734, 'FERNANDO PEREZ SILVA', '', '', '', 1, 1, '16778688', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1735, 'JAIME LABAN MINGA', '', '', '', 1, 1, '42600414', 1, 'MICORREO@MAIL.COM', '', 190101, 0, '', 1, NULL, NULL, NULL, 0),
(1736, 'VILLAR ALDAVE SEGUNDO VICTOR', '-', '', '', 1, 2, '10167917475', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1737, 'CAPEAGRO S.A.C.', 'AV. BENAVIDES NRO 2150 DEP. 803', '', '', 1, 2, '20523618939', 1, 'MICORREO@MAIL.COM', '', 40107, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1738, 'NEGOCIOS E INVERSIONES L Y P EMPRESA INDIVIDUAL DE RESPONSABILIDAD LIMITADA', '', '', '', 1, 2, '20606376490', 1, 'MICORREO@MAIL.COM', '', 190101, 0, '', 1, NULL, NULL, NULL, 0),
(1739, 'ELIAS LLONTOP SANCHEZ', '', '', '', 1, 1, '16634130', 1, 'MICORREO@MAIL.COM', '', 130110, 0, '', 1, NULL, NULL, NULL, 0),
(1740, 'LEYDY ELIZABETH LABAN CRUZ', '', '', '', 1, 1, '45653451', 1, 'MICORREO@MAIL.COM', '', 60801, 0, '', 1, NULL, NULL, NULL, 0),
(1741, 'JULIO VIDAURRE SALAZAR', '', '', '', 1, 1, '4564379', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1742, 'SALAZAR VIDAURRE JULIO', '', '', '', 1, 1, '4564379', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1743, 'CORPORACION NUNTON S.A.C', 'CAL. BARBIERI LEONARDO NRO 1147', '', '', 1, 2, '20603379544', 1, 'MICORREO@MAIL.COM', '', 140131, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1744, 'EJECUTORES & CONSTRUCTORES R & S E.I.R.L.', 'JR. SEÑOR DE LOS MILAGROS NRO. SN (CDRA4) AMAZONAS - CHACHAPOYAS - CHACHAPOYAS', '', '', 1, 2, '20604644969', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(1745, 'JOHNNY ENRIQUE CHANG', '', '', '', 1, 1, '19249013', 1, 'MICORREO@MAIL.COM', '', 120506, 0, '', 1, NULL, NULL, NULL, 0),
(1746, 'LEINER PARIATON GARCIA', '', '', '', 1, 1, '75226370', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1747, 'VICTORIANO BECERRA BECERRA', '', '', '', 1, 1, '27982285', 1, 'MICORREO@MAIL.COM', '', 60101, 0, '', 1, NULL, NULL, NULL, 0),
(1748, 'R COORP E.I.R.L.', 'PJ. LAS DALIAS NRO 120 URB. SANTA VICTORIA', '', '', 1, 2, '20606135204', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1749, 'CORPORACION AGRICOLA SAN LORENZO SAC', 'CAL. FEDERRCO VILLAREAL NRO 1148 ZON CERCADO TUCUME', '', '', 1, 2, '20603258313', 1, 'MICORREO@MAIL.COM', '', 130312, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1750, 'LUIS ALBERTO COVEÑAS IPANAQUE', '', '', '', 1, 1, '42712486', 1, 'MICORREO@MAIL.COM', '', 190101, 0, '', 1, NULL, NULL, NULL, 0),
(1751, 'MODESTO GARCIA LLACSA S.A.C.', 'MZA. G LOTE 4 A.H. QUEBRADA VERDE', '', '', 1, 2, '20608414941', 1, 'MICORREO@MAIL.COM', '', 140116, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1752, 'AVICOLA EL BUEN PASTOR  E.I.R.L.', 'CAL. TACNA NRO 956 INT. REF', '', '', 1, 2, '20601087481', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1753, 'ARLY JOEL FERNANDEZ GAMONAL', '', '', '', 1, 1, '48105408', 1, 'MICORREO@MAIL.COM', '', 130201, 0, '', 1, NULL, NULL, NULL, 0),
(1754, 'LUIS CHAPOÑAN LLAUCE', '', '', '', 1, 1, '43399547', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1755, 'HAUG S.A.', 'PARCELA 10368 CALL.GRANDE NRO S/N EX-FUNDO SANTA ROSA', '', '', 1, 2, '20109925757', 1, 'MICORREO@MAIL.COM', '', 140113, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1756, 'LUIS FELIPE PALACIOS RAMIREZ', '', '', '', 1, 1, '45496655', 1, 'MICORREO@MAIL.COM', '', 190101, 0, '', 1, NULL, NULL, NULL, 0),
(1757, 'ASOCIACION BANANEROS ORGANICOS OLMOS-BANOL', 'CAR. PANAMERICANA NORTE ANTIGU NRO S/N', '', '', 1, 2, '20603417021', 1, 'MICORREO@MAIL.COM', '', 130308, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1758, 'DISTRIBUIDORA COMERCIAL ALVAREZ BOHL SRL', 'CAR. PIURA SULLANA LOTE A OTR. VALLE MEDIO PIURA P1-02', '', '', 1, 2, '20102892381', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1759, 'JULIO DE LA CRUZ AGUILAR', '', '', '', 1, 1, '76516016', 1, 'MICORREO@MAIL.COM', '', 130312, 0, '', 1, NULL, NULL, NULL, 0),
(1760, 'PROA CORPORATION E.I.R.L.', 'AV. LUISGONZALES NRO 1432 URB. CERCADO DE CHICLAYO', '', '', 1, 2, '20600708351', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1761, 'NEGRETE VILLASIS KAREN VANESSA', '-', '', '', 1, 2, '10401671892', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1762, 'I. E JUAN AURICH PASTOR', 'BATANGRANDE', '', '', 1, 1, '25585', 1, 'MICORREO@MAIL.COM', '', 130204, 0, '', 1, NULL, NULL, NULL, 0),
(1763, 'CALDERON FERNADEZ RICARDO', '', '', '', 1, 1, '16474196', 1, 'MICORREO@MAIL.COM', '', 60806, 0, '', 1, NULL, NULL, NULL, 0),
(1764, 'JOSELITO MENDOZA CARRASCO', '', '', '', 1, 1, '41138933', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1765, 'AGROINVERSIONES AGROINPA E.I.R.L.', 'AV. JOSE BALTA NRO 665 INT. 207 CERCADO DE CHICLAYO', '', '', 1, 2, '20608457781', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1766, 'LEONARDO COLLANTES', '', '', '', 1, 1, '74022475', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1767, 'AGRONATURALTRADING SAC', 'CAL. ALFONSO UGARTE NRO 628', '', '', 1, 2, '20603044291', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1768, 'AGRICULTORES DEL PERU S.A.C.', 'CAR. FERNANDO BELAUNDE TERRY FND. SAN MIGUEL Y LAS NORIAS KM. 49', '', '', 1, 2, '20607781096', 1, 'MICORREO@MAIL.COM', '', 130307, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1769, 'ROXANA MARIBEL SOSA SECLEN', '', '', '', 1, 1, '71529721', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1770, 'AGRICOLA SAN JOSE SOCIEDAD ANONIMA CERRADA', 'CAL. LIMA NRO 314 CENTRO DE LA UNION', '', '', 1, 2, '20484138207', 1, 'MICORREO@MAIL.COM', '', 190106, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1771, 'NEPTALI GOMES DOMINGUEZ', '', '', '', 1, 1, '44269429', 1, 'MICORREO@MAIL.COM', '', 190101, 0, '', 1, NULL, NULL, NULL, 0),
(1772, 'PAUL CISNEROS RAMOS', '', '', '', 1, 1, '3678422', 1, 'MICORREO@MAIL.COM', '', 190601, 0, '', 1, NULL, NULL, NULL, 0),
(1773, 'GALVEZ VARGAS JOSE JAVIER', '-', '', '', 1, 2, '10166814419', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1774, 'VELASQUEZ TELLO EDWIN EDUARDO', '-', '', '', 1, 2, '10277157344', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1775, 'NEGOCIOS NILZA E.I.R.L.', 'OTR. PROLONGACION SOLIDEX NRO 7B', '', '', 1, 2, '20607338818', 1, 'MICORREO@MAIL.COM', '', 130119, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1776, 'CRUZ SILVA JIMENEZ', '', '', '', 1, 1, '2815633', 1, 'MICORREO@MAIL.COM', '', 190109, 0, '', 1, NULL, NULL, NULL, 0),
(1777, 'TAFUR ESPINOZA JUAN CARLOS', 'AV. PRIMERO DE MAYO N 8 SECTOR SANTA ROSA', '', '', 1, 2, '10166854003', 1, 'MICORREO@MAIL.COM', '', 130120, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1778, 'SANCHERO CHERO RAFAEL', '', '', '', 1, 1, '80488267', 1, 'MICORREO@MAIL.COM', '', 130115, 0, '', 1, NULL, NULL, NULL, 0),
(1779, 'CONSULTORIA Y SERVICIOS INDUSTRIALES E.I.R.L.', 'CAL. PEZET NRO 421 URB. REMIGIO SILVA', '', '', 1, 2, '20601226007', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1780, 'JANET MARISOL REYNOSA RIOS', '', '', '', 1, 1, '40967836', 1, 'MICORREO@MAIL.COM', '', 130312, 0, '', 1, NULL, NULL, NULL, 0),
(1781, 'GRUPO BENDICION DE DIOS SAC', 'MZA. E LOTE 17 DEP. 201 C. V. COVICORTI', '', '', 1, 2, '20481761787', 1, 'MICORREO@MAIL.COM', '', 120101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1782, 'HECTOR DIAS RODRIGUEZ', '', '', '', 1, 1, '48389931', 1, 'MICORREO@MAIL.COM', '', 130202, 0, '', 1, NULL, NULL, NULL, 0),
(1783, 'INGENIERIA Y SERVICIOS GENERALES LOS ANDES E.I.R.L.', 'CAL. IGNACIO GOICOCHEA NRO 127 URB. RESIDENCIAL SANTA MARIA', '', '', 1, 2, '20600894928', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1784, 'JOSE MERCEDES PORTAL EUGENIO', '', '', '', 1, 1, '19199830', 1, 'MICORREO@MAIL.COM', '', 60101, 0, '', 1, NULL, NULL, NULL, 0),
(1785, 'MANUEL ANTONIO AGUILAR VELA', '', '', '', 1, 1, '8462486', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1786, 'EDUAR GIL FLORES', '', '', '', 1, 1, '77692513', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1787, 'FANNY SOLIS ROJAS', '', '', '', 1, 1, '16713097', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1788, 'ECOHOSTAL MAMITA HELMITA S.C.R.L.', 'MZA. A LOTE S/N URB. CASTILLA DE ORO', '', '', 1, 2, '20479944629', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1789, 'CONSTRUCTORA Y SERVICIOS MULTIPLES SOCIE DAD COMERCIAL DE RESPONSABILIDAD LIMITA DA', 'AV. PEDRO RUIZ GALLO NRO 604 INT. 405 CERCADO DE CHICLAYO', '', '', 1, 2, '20480165455', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1790, 'CONGREGACION DE LA MISION (PADRES LAZARISTAS O PAULES O VICENTINOS) EN EL PERU', 'CAL. LIMA NRO 345', '', '', 1, 2, '20110495324', 1, 'MICORREO@MAIL.COM', '', 40107, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1791, 'INDUSTRIAS AGRICOLAS RAM E.I.R.L.', 'MZA. AJ LOTE 03 RES. PUERTAS DEL SOL', '', '', 1, 2, '20602985581', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1792, 'W & E CONSTRUCTORES S.R.L.', 'CAL. COPACABANA ZN B MZA. V1 LOTE 7 C.P. CHUQUIBAMBA', '', '', 1, 2, '20480639937', 1, 'MICORREO@MAIL.COM', '', 10106, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1793, 'CESAR AGUSTO SERQUEN SANCHEZ', '', '', '', 1, 1, '42064923', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1794, 'ABELARDO ACOSTA INOÑAN', '', 'CACHINCHI', '', 1, 1, '48710904', 1, 'MICORREO@MAIL.COM', '', 130312, 0, '', 1, NULL, NULL, NULL, 0),
(1795, 'A & V CONSTRUCTORA E.I.R.L', 'AV. SAN MARTIN H NRO 78', '', '', 1, 2, '20525452931', 1, 'MICORREO@MAIL.COM', '', 190101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1796, 'SILVA SILVA DE IMAN ROSA', '', '', '', 1, 1, '43739701', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1797, 'CONSTRUCTORA MARDEC S.A.C.', 'CAL. ARROSPIDE NRO 269 DEP. 102 URB. CAJA DE DEPOSITOS', '', '', 1, 2, '20600560647', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1798, 'CULLA SOLUCIONES FERRETERAS BIENES Y SERVICIOS MULTIPLES E.I.R.L.', 'AV. MEXICO NRO 3021 A.H. SAN LORENZO', '', '', 1, 2, '20606154071', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1799, 'MIDAS SOLUTIONS CENTER E.I.R.L.', 'CAL. AREQUIPA NRO 499 PIURA CERCADO', '', '', 1, 2, '20605357734', 1, 'MICORREO@MAIL.COM', '', 190101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1800, 'EYBER VASQUEZ PERALTA', '', '', '', 1, 1, '45680952', 1, 'MICORREO@MAIL.COM', '', 190101, 0, '', 1, NULL, NULL, NULL, 0),
(1801, 'AGRO MOTORS', '', '', '', 1, 3, '', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1802, 'LUCIO CORREA DE LOS SANTOS', '', 'BATAN GRANDE', '', 1, 1, '27412667', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1803, 'J & F FADI S.A.C.', 'AV. ORIENTE NRO 499 URB. LOS ARROZALES', '', '', 1, 2, '20606430311', 1, 'MICORREO@MAIL.COM', '', 60801, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1804, 'APONTE QUINTERO ANTONY ANDRES', '', '', '', 1, 1, '71292402', 1, 'MICORREO@MAIL.COM', '', 190601, 0, '', 1, NULL, NULL, NULL, 0),
(1805, 'COOPERATIVA AGRARIA CRUZ DE YANAHUANCA', 'AV. CRUZ DE YANAHUANCA NRO SN C.P. PENACHI', '', '', 1, 2, '20604705411', 1, 'MICORREO@MAIL.COM', '', 100106, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1806, 'CORPORACION RALTIM EMPRESA INDIVIDUAL DE RESPONSABILIDAD LIMITADA', 'CAL. SANCHEZ CERRO NRO 547 SEC. VILLA HERMOSA', '', '', 1, 2, '20608340743', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1807, 'VICTOR PERES', '', '', '', 1, 3, '', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1808, 'LLUEN RELUZ SEGUNDO AURELIO', '-MZ H LT 2 CPM LA CIUDADELA', '', '', 1, 2, '10164198231', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1809, 'WILY OMAR BARBOZA LEYVA', '', '', '', 1, 1, '44492048', 1, 'MICORREO@MAIL.COM', '', 120901, 0, '', 1, NULL, NULL, NULL, 0),
(1810, 'JC & JC S.A.C.', 'CAL. CAPAC YUPANQUI NRO 1018 URB. LA VICTORIA SC. CUATRO', '', '', 1, 2, '20487812685', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1811, 'RAINOX S.A.C.', 'MZA. 0 LOTE 33 URB. EL SANTUARIO', '', '', 1, 2, '20606380462', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1812, 'GRUPO INMOBILIARIO JESUS EN TI CONFIO SOCIEDAD ANONIMA CERRADA', 'CAL. TORRES PAZ NRO 770', '', '', 1, 2, '20603366655', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1813, 'EDER ZAPATA VILELA', '', '', '', 1, 3, '', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1814, 'BENIGNO RICARDO TARRILLO DELGADO', '', '', '', 1, 1, '27419615', 1, 'MICORREO@MAIL.COM', '', 60601, 0, '', 1, NULL, NULL, NULL, 0),
(1815, 'CADRICK INGENIEROS S.A.C.', 'NRO 286 P.J. 06 DE JULIO', '', '', 1, 2, '20606817569', 1, 'MICORREO@MAIL.COM', '', 10205, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1816, 'DENAR GUIVAR BARTUREN', '', '', '', 1, 1, '45989981', 1, 'MICORREO@MAIL.COM', '', 60501, 0, '', 1, NULL, NULL, NULL, 0),
(1817, 'EVER ISAC RIMARACHIN CLAVO', '', '', '', 1, 1, '42108684', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1818, 'ALFA & OMEGA COMPANY SOCIEDAD ANONIMA CERRADA', 'AV. BELAUNDE NRO 169 URB. REMIGIO SILVA', '', '', 1, 2, '20607038504', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1819, 'JULIO BOBADILLA MONJA', '', '', '', 1, 1, '45212236', 1, 'MICORREO@MAIL.COM', '', 120101, 0, '', 1, NULL, NULL, NULL, 0),
(1820, 'ZAMORA CIENFUEGOS BREIMER', '', '', '', 1, 1, '41908664', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1821, '2B & C INGENIEROS S.A.C.', 'JR. OROSCO NRO 497', '', '', 1, 2, '20487782590', 1, 'MICORREO@MAIL.COM', '', 60501, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1822, 'CORAMSA EMPRESA INDIVIDUAL DE RESPOSABILIDAD LIMITADA', 'AV. REPUBLICA DE PANAMA NRO 3418 INT. 301 URB. LIMATAMBO', '', '', 1, 2, '20479515264', 1, 'MICORREO@MAIL.COM', '', 10119, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1823, 'AGROINDUSTRIA SOL DEL NORTE EIRL', 'AV. SAENZ PEÑA NRO 480 INT. 02 CENTRO', '', '', 1, 2, '20480294263', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1824, 'BARBARITA ILMA MACO MACO', '', '', '', 1, 1, '17632071', 1, 'MICORREO@MAIL.COM', '', 130308, 0, '', 1, NULL, NULL, NULL, 0),
(1825, 'RUBEN SEGUNDO CESPEDES', '', '', '', 1, 1, '48243750', 1, 'MICORREO@MAIL.COM', '', 60611, 0, '', 1, NULL, NULL, NULL, 0),
(1826, 'MANUEL ELEODORO MUNDACA GUEVARA', '', '', '', 1, 1, '16507344', 1, 'MICORREO@MAIL.COM', '', 130102, 0, '', 1, NULL, NULL, NULL, 0),
(1827, 'INGRID DEL ROCIO RIVAS CRUZ', '', '', '', 1, 1, '3373980', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1828, 'INVERSIONES AGRÍCOLAS HUACA COLORADA S.A.C.', 'NRO 897 OTR. ZEPITA', '', '', 1, 2, '20608150278', 1, 'MICORREO@MAIL.COM', '', 120501, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1829, 'ACG RACING E.I.R.L', 'AV. PERALVILLO NRO 2373', '', '', 1, 2, '20606572442', 1, 'MICORREO@MAIL.COM', '', 140506, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1830, 'TURISMO CENTAURO E.I.R.L. - TURCEN E.I.R.L.', 'MZA. D LOTE 1 URB. BARBADILLO', '', '', 1, 2, '20600940474', 1, 'MICORREO@MAIL.COM', '', 21303, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1831, 'SOCIEDAD DE BENEFICENCIA DE MOTUPE', 'CAL. EMILIANO NIÑO NRO 505 CERDADO', '', '', 1, 2, '20210272781', 1, 'MICORREO@MAIL.COM', '', 130307, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1832, 'JAIME GOICOCHEA GUEVARA', '', '', '', 1, 1, '46746747', 1, 'MICORREO@MAIL.COM', '', 120101, 0, '', 1, NULL, NULL, NULL, 0),
(1833, 'JOSE PAICO', '', '', '', 1, 3, '', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1834, 'MANUEL SUCLUPE INOÑAN', '', '', '', 1, 1, '17566954', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1835, 'INDUCHEMICAL CROP S.A.C.', 'CAL. 4 MZA. H LOTE 01 A.V. SAN ISIDRO DE CARABAYLLO', '', '', 1, 2, '20600832558', 1, 'MICORREO@MAIL.COM', '', 140105, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1836, 'INVERSIONES Y SERVICIOS ALTA VISTA S.R.L', 'JR. SAN JORGE NRO 325 URB. LOS JAZMINES', '', '', 1, 2, '20529438096', 1, 'MICORREO@MAIL.COM', '', 60101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1837, 'AGROINVERSIONES OLMOS SOCIEDAD ANONIMA CERRADA', 'CAL. SANTA MARGARITA NRO 239 DEP. 401 URB. SANTA CRUZ', '', '', 1, 2, '20518167147', 1, 'MICORREO@MAIL.COM', '', 140124, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1838, 'CORDOVA CORREA PAULA YSABEL', '-', '', '', 1, 2, '10407247626', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1839, 'UGAZ CODA JUAN FRANCISCO JOSE', '-', '', '', 1, 2, '10164820284', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1840, 'JHONY PISFIL LLONTOP', '', '', '', 1, 1, '43636359', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1841, 'RUTH LORENA ONORIO GARCIA', '', '', '', 1, 1, '41462645', 1, 'MICORREO@MAIL.COM', '', 120901, 0, '', 1, NULL, NULL, NULL, 0),
(1842, 'COMISION DE USUARIOS DEL SUBSECTOR HIDRAULICO CAPOTE', 'CAL. SAN MARTIN NRO SN CAPOTE', '', '', 1, 2, '20185243762', 1, 'MICORREO@MAIL.COM', '', 130109, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1843, 'HERLI MEDINA OYARCE', '', '', '', 1, 1, '43139370', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1844, 'EINEN ROJAS LOPEZ', '', '', '', 1, 1, '33422051', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(1845, 'CONSTRUCTORA & CONSULTORA K & R S.A.C.', 'NRO 0 CPM TUCAC ALTO', '', '', 1, 2, '20529613432', 1, 'MICORREO@MAIL.COM', '', 60614, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1846, 'EDILBRANDO IRIGOIN VASQUEZ', '', '', '', 1, 1, '43404732', 1, 'MICORREO@MAIL.COM', '', 130304, 0, '', 1, NULL, NULL, NULL, 0),
(1847, 'GARCIA LEYTH VICTOR AUGUSTO', 'AV.JORGE HERRERA 107 TUMBES', '', '', 1, 2, '10002376984', 1, 'MICORREO@MAIL.COM', '', 230101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1848, 'BAJAC CONTRATISTAS GENERALES E.I.R.L.', 'CAR. A REQUE MZA. B LOTE 5 URB. PUERTAS DEL SOL', '', '', 1, 2, '20488104978', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1849, 'SANDRA IVONNE BECERRA FERNADANDEZ', '', '', '', 1, 1, '71865074', 1, 'MICORREO@MAIL.COM', '', 60801, 0, '', 1, NULL, NULL, NULL, 0),
(1850, 'ALVARO VICTOR RAUL COLCHADO CHEVEZ', '', '', '', 1, 1, '46032094', 1, 'MICORREO@MAIL.COM', '', 130307, 0, '', 1, NULL, NULL, NULL, 0),
(1851, 'AGRICOLA SEGALI E.I.R.L.', 'CAL. RENOVACION NRO 220 BAR. RENOVACION', '', '', 1, 2, '20608247336', 1, 'MICORREO@MAIL.COM', '', 120901, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1852, 'CAJO MANAYALLE SANTIAGO RICARDO', '', '', '', 1, 1, '17455026', 1, 'MICORREO@MAIL.COM', '', 60601, 0, '', 1, NULL, NULL, NULL, 0),
(1853, 'PERALES HUANCARUNA S.A.C.', 'CAL. B NRO 293 Z.I. FUNDO BOCANEGRA', '', '', 1, 2, '20131495006', 1, 'MICORREO@MAIL.COM', '', 240101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1854, 'SAMUEL VALLEJOS YANPOFE', '', '', '', 1, 1, '47633095', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1855, 'SAMUEL MALDONADO HERRERA', '', '', '', 1, 1, '16784976', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1856, 'I.E 11135 CESAR VALLEJO ,SEQUIONES ,MORROPE', '', '', '', 1, 1, '0', 1, 'MICORREO@MAIL.COM', '', 130306, 0, '', 1, NULL, NULL, NULL, 0),
(1857, 'ROLANDO GAMONAL DIAZ', '', '', '', 1, 1, '41427849', 1, 'MICORREO@MAIL.COM', '', 130117, 0, '', 1, NULL, NULL, NULL, 0),
(1858, 'JOSE LUIS HERNANDEZ VALDEZ', '', '', '', 1, 1, '28066532', 1, 'MICORREO@MAIL.COM', '', 120901, 0, '', 1, NULL, NULL, NULL, 0),
(1859, 'MANUEL ALEJANDRO ROA VALERA', '', '', '', 1, 1, '16792607', 1, 'MICORREO@MAIL.COM', '', 190101, 0, '', 1, NULL, NULL, NULL, 0),
(1860, 'JULIO SAMAME GUERRERO', '', '', '', 1, 1, '76143702', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1861, 'GAMONAL HERNANDEZ MILENA LEOCADIA', 'AV KENNEDY #553 J.L.O', '', '', 1, 2, '17308834620', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1862, 'ALIMENTOS BALANCEADOS VIMEXZA S.A.C.', 'CAL. LOS CEREZOS NRO 421 INT. A C.P.M. ARTESANOS INDEPEND', '', '', 1, 2, '20487468615', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1863, 'JUANA CASTILLO MACHADO', '', '', '', 1, 1, '3239353', 1, 'MICORREO@MAIL.COM', '', 190405, 0, '', 1, NULL, NULL, NULL, 0),
(1864, 'JAIME BUSTAMANTE ALIAGA', 'LAS GAVIOTAS DPTO 402', '', '', 1, 1, '6353489', 1, 'MICORREO@MAIL.COM', '', 130110, 0, '', 1, NULL, NULL, NULL, 0),
(1865, 'SEMILLERA VALLEY S.A.C.', 'AV. MEXICO NRO 360 INT. 2 P.J. MATUTE', '', '', 1, 2, '20608415042', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1866, 'IMPORTACION, CONSTRUCCION, AGRO E INGENIERIA Y SOLUCIONES INDUSTRIALES E.I.R.L.', 'PJ. CHINO NRO 170 ZONA BARRIO CHINO', '', '', 1, 2, '20602961681', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1867, 'EVA QUIROGA ROQUE', '', '', '', 1, 1, '17571466', 1, 'MICORREO@MAIL.COM', '', 130307, 0, '', 1, NULL, NULL, NULL, 0),
(1868, 'CONSORCIO COSEMSELAM', 'AV. JOSE E. LORA Y LORA NRO 1320 URB. LA PRIMAVERA  I ETAPA FAP', '', '', 1, 2, '20609274035', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1869, 'ELENOR SAC', 'AV. SALAVERRY NRO 959 DEP. 104 URB. URBANIZACION PATAZCA', '', '', 1, 2, '20480757204', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1870, 'GONZALES GONZALES ALBERTO', 'CALLE NICOLAS DE PIEROLA 650', '', '', 1, 2, '10174227158', 1, 'MICORREO@MAIL.COM', '', 130112, 0, '', 1, NULL, NULL, NULL, 0),
(1871, 'DAMIAN CALDERON PEJERREY', '', '', '', 1, 1, '16626155', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1872, 'CRISTIAN CORONEL SANTA MARIA', '', '', '', 1, 1, '47876640', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1873, 'V & F SAC', 'CAR. PANAMERICANA NORTE MONTES DE LA VIRGEN KM. 776', '', '', 1, 2, '20480319860', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1874, 'JULCA DE LA CRUZ OSWALDO', '', '', '', 1, 2, '10419836953', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1875, 'PINZON GONZALES YHONY ERNESTHO', '-', '', '', 1, 2, '10429537199', 1, 'MICORREO@MAIL.COM', '', 190702, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1876, 'LA PONDEROZA AGROEXPORT E.I.R.L.', 'MZA. A LOTE 56 SECC RURAL', '', '', 1, 2, '20606688203', 1, 'MICORREO@MAIL.COM', '', 130111, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1877, 'ECOFERTI PERU SAC', 'CAL. CAPAC YUPANQUI NRO 1018', '', '', 1, 2, '20609454874', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1878, 'SEGUNDO PARIHUAMAN CARDENAS', '', '', '', 1, 1, '27826803', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1879, 'GERENCIA REGIONAL DE TRANSPORTES Y COMUNICACIONES', 'CAR. PIMENTEL NRO 5.5', '', '', 1, 2, '20394805140', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1880, 'JEAN CARLOS DIAZ ALARCON', '', '', '', 1, 1, '76574563', 1, 'MICORREO@MAIL.COM', '', 130117, 0, '', 1, NULL, NULL, NULL, 0),
(1881, 'MPG IRRIGATION SYSTEMS SOCIEDAD ANONIMA CERRADA', 'MZA. C LOTE 20 LOT. SAN MIGUEL O MURO SOLIS', '', '', 1, 2, '20487654320', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1882, 'CESAR AGUSTO PAZ', 'UDIMA', '', '', 1, 1, '28111075', 1, 'MICORREO@MAIL.COM', '', 60902, 0, '', 1, NULL, NULL, NULL, 0),
(1883, 'ASOCIACION AGROPECUARIA PROGRESISTA', 'AV. MANUEL SEOANE NRO 129', '', '', 1, 2, '20601293383', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1884, 'MUNICIPALIDAD PROVINCIAL DE CHICLAYO', 'CAL. ELIAS AGUIRRE NRO 240 CENTRO DE CHICLAYO', '', '', 1, 2, '20141784901', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1885, 'JOSE PORTALES EUGENIO', '', '', '', 1, 1, '19199830', 1, 'MICORREO@MAIL.COM', '', 60101, 0, '', 1, NULL, NULL, NULL, 0),
(1886, 'EMPRESA DE NEGOCIOS Y SERVICIOS GENERALES DON GRINGO S.A.C.', 'MZA. D LOTE 31 URB. VILLAS DE LA ENSENADA II', '', '', 1, 2, '20608813102', 1, 'MICORREO@MAIL.COM', '', 130110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1887, 'JOSE LUIS VEGA SANCHES', '', '', '', 1, 1, '28105279', 1, 'MICORREO@MAIL.COM', '', 60901, 0, '', 1, NULL, NULL, NULL, 0),
(1888, 'I.E 10995 NUESTRA PATRONA DE LAS MERCEDES', 'EL CARRISO', '', '', 1, 1, '10154338', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1889, 'I.E 10983', 'SHITA ALTA - SALAS', '', '', 1, 1, '17548759', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1890, 'LOPEZ DE LA CRUZ JOSE', '', '', '', 1, 1, '80351517', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1891, 'UNIVERSIDAD SEÑOR DE SIPAN S.A.C.', 'AV. GENERAL FELIPE SANTIAGO S NRO 2525 URB. RISSO', '', '', 1, 2, '20479748102', 1, 'MICORREO@MAIL.COM', '', 10119, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1892, 'SANDOVAL LLONTOP SANTIAGO', 'ANGOLO 1 MORROPE', 'ANGOLO 1', '', 1, 1, '42395467', 1, 'MICORREO@MAIL.COM', '', 130306, 0, '', 1, NULL, NULL, NULL, 0),
(1893, 'CONSORCIO ARBOLEDA', 'AV. ELVIRA GARCIA Y GARCIA NRO 165 DEP. 302 URB. LOS PARQUES', '', '', 1, 2, '20488037090', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1894, 'MALCA LOPEZ SEGUNDO WILDER', '', '', '', 1, 2, '10779108673', 1, 'MICORREO@MAIL.COM', '', 10206, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1895, 'CONSTRUCTORA E INMOBILIARIA MARIATTE SOCIEDAD ANONIMA CERRADA', 'MZA. K LOTE 9 URB. BRUCES', '', '', 1, 2, '20445653072', 1, 'MICORREO@MAIL.COM', '', 21309, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1896, 'CONTRERAS RISCO CARLOS HUMBERTO', '-', '', '', 1, 2, '10011494655', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1897, 'SAMUEL FELIX PIZARRO COLLAZOS', 'NICOLÁS DE AYLLON 855 . J.L.ORTIZ. - CHICLAYO', '', '', 1, 2, '10407750328', 1, 'MICORREO@MAIL.COM', '', 130112, 0, '', 1, NULL, NULL, NULL, 0),
(1898, 'AGRICOLA TERRA NOSTRA E.I.R.L', 'VELASCO ASTETE NRO 325 DEP. 403 URB. MARISCAL CASTILLA', '', '', 1, 2, '20604713031', 1, 'MICORREO@MAIL.COM', '', 140140, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1899, 'CARRANZA ALARCON LUIS GODOFREDO', '-', '', '', 1, 2, '10429320751', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1900, 'SERVICIOS GENERALES JADDYM S.A.C.', 'CAL. JUDA MZA. G LOTE 31', '', '', 1, 2, '20606913754', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1901, 'COMPAÑIA ARROCERA SAN NICOLAS S.A.C.', 'OTR. CARRETERA PANAMERICANA NO KM. 778', '', '', 1, 2, '20606748028', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1902, 'JUANA WONG KCOMT', '', '', '', 1, 1, '19201892', 1, 'MICORREO@MAIL.COM', '', 120901, 0, '', 1, NULL, NULL, NULL, 0),
(1903, 'CONSTRUCTORA ANTONIOS E.I.R.L', 'JR. LIMA NRO 287 MOCUPE TRADICIONAL', '', '', 1, 2, '20539147057', 1, 'MICORREO@MAIL.COM', '', 130105, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1904, 'CARLOS DANILO TIRADO HERRERA', '', '', '', 1, 1, '42167785', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1905, 'MANAYAY FERNANDEZ SEGUNDO FRANCLIN', 'AV. 28 JULIO 484', '', '', 1, 2, '10707604544', 1, 'MICORREO@MAIL.COM', '', 10205, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1906, 'PORTERO LOPEZ HILDA MARLENY', '-', '', '', 1, 2, '10175492327', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1907, 'GRUPO ALDYSA S.A.C.', 'MZA. N3 LOTE 10 URB. COVICORTI', '', '', 1, 2, '20539939581', 1, 'MICORREO@MAIL.COM', '', 120101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1908, 'FUNDO SAN RICARDO S.A.C.', 'EL DERBY NRO 511 DEP. 901 URB. EL VIVERO', '', '', 1, 2, '20608997416', 1, 'MICORREO@MAIL.COM', '', 140130, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1909, 'COMERCIAL FERRETERA CASTILLO S.R.L.', 'AV. LUIS GONZALES NRO 1532', '', '', 1, 2, '20601749719', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1910, 'AGROSERVICIOS A & S  PIURA E.I.R.L.', 'MZA. C LOTE 07 A.H. LOS ALMENDROS', '', '', 1, 2, '20600000706', 1, 'MICORREO@MAIL.COM', '', 190103, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1911, 'PRODUCTOS AGRICOLAS VICTORIA E.I.R.L.', 'MZA. A LOTE SN SERUR PASABAR ASERRADERO', '', '', 1, 2, '20603697937', 1, 'MICORREO@MAIL.COM', '', 130308, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1912, 'I.E. N °440  LAS FLORES DE LA PRADERA', 'CAL. LAS BEGONIAS MZA. B LOTE 10 P.J. LAS FLORES DE LA PRADERA', '', '', 1, 2, '20602128068', 1, 'MICORREO@MAIL.COM', '', 130110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1913, 'JUAN MANUEL LIZAMA CRUZ', '', '', '', 1, 1, '43973841', 1, 'MICORREO@MAIL.COM', '', 190301, 0, '', 1, NULL, NULL, NULL, 0),
(1914, 'GRUPO WILQUI RS E.I.R.L.', 'CAL. TAHUANTINSUYO NRO 901 URB. SAN CARLOS', '', '', 1, 2, '20608619926', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1915, 'AGRICOLA TIERRANORTE SOCIEDAD ANONIMA CERRADA', 'PASAJE NORTE CAS. NUEVA ESPEZANDA SECTOR PA KM. 77', '', '', 1, 2, '20609137861', 1, 'MICORREO@MAIL.COM', '', 130308, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1916, 'COSMICA SERVICIOS INTEGRALES SOCIEDAD ANONIMA CERRADA', 'OTR. VIII ETAPA MZA. DB LOTE 6 URB. SANTA MARGARITA', '', '', 1, 2, '20607420778', 1, 'MICORREO@MAIL.COM', '', 190101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1917, 'MOLINERA TROPICAL DEL NORTE SAC', 'JR. JOSE NICOLAS RODRIGO NRO 365 DEP. 405 URB. LIMA POLO AND HUNT CLUB', '', '', 1, 2, '20411356206', 1, 'MICORREO@MAIL.COM', '', 140130, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1918, 'AMAZON GINGER S.A.C. - AMAZON GINGER S.A.C.', 'CAR. PANAMERICANA SUR INT. J10 LOTE OA-1 KM. 29.5', '', '', 1, 2, '20605719717', 1, 'MICORREO@MAIL.COM', '', 140113, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1919, 'FERNANDO MONTOYA SANCHES', '', '', '', 1, 1, '28111217', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1920, 'V & C INGENIERIA CONSTRUCCION Y SUPERVISION E.I.R.L', 'CAL. LAS MORAS NRO 287 URB. LOS PARQUES', '', '', 1, 2, '20539024567', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1921, 'SANCHEZ LEZAMA DEMETRIO', 'TUMBES', '', '', 1, 2, '10192260731', 1, 'MICORREO@MAIL.COM', '', 230101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1922, 'LORENZO VERA ROALCABA', '', '', '', 1, 1, '16507477', 1, 'MICORREO@MAIL.COM', '', 130102, 0, '', 1, NULL, NULL, NULL, 0),
(1923, 'PREMIUN AGRO PERU S.A.C', 'CAL. PIURA NRO 487 DEP. 404', '', '', 1, 2, '20603017936', 1, 'MICORREO@MAIL.COM', '', 140115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1924, 'GENESIS E.I.R.L.', 'MZA. J LOTE 43 CAS. SAN FRANCISCO', '', '', 1, 2, '20606524961', 1, 'MICORREO@MAIL.COM', '', 190401, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1925, 'ALVA GARCES JULIO ALEXANDER', '-', '', '', 1, 2, '10441012468', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1926, 'AGROFORESTAL NIETO E.I.R.L.', 'CAL. TAHUANTINSUYO NRO 1036 URB. SAN LORENZO', '', '', 1, 2, '20600459075', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1927, 'ROJAS BOCANEGRA SAMUEL RAIMUNDO', '-ROMA 260 URRUNAGA JOSE L. ORTIZ', '', '', 1, 2, '10165375632', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1928, 'SERVICIOS CASTILLO & LARIOS E.I.R.L.', 'FUNDO SANTA ISABEL V ETAP NRO S/N URB. LOS SAUCES', '', '', 1, 2, '20601550335', 1, 'MICORREO@MAIL.COM', '', 130110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1929, 'CONSORCIO VIAL SUAZO', 'CAL. VICENTE DE LA VEGA NRO 1630 INT. A P.J. SUAZO', '', '', 1, 2, '20609246546', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1930, 'MAXIMO ANDRES CAJO MARTINEZ', '', '', '', 1, 1, '44707271', 1, 'MICORREO@MAIL.COM', '', 130307, 0, '', 1, NULL, NULL, NULL, 0),
(1931, 'LAURA MARIBEL DURAN SANTA MARIA', '', '', '', 1, 1, '42571880', 1, 'MICORREO@MAIL.COM', '', 130201, 0, '', 1, NULL, NULL, NULL, 0),
(1932, 'ASOCIACION DE PRODUCTORES AGROPECUARIOS VIRGEN DE FATIMA EL NARANJO', 'NRO SN C.P. EL NARANJO', '', '', 1, 2, '20606601752', 1, 'MICORREO@MAIL.COM', '', 61006, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1933, 'NEGOCIOS VIMEXZA S.A.C.', 'CAL. LOS CEREZOS MZA. H LOTE 10 URB. ARTESANOS INDEPENDIENTES', '', '', 1, 2, '20608729519', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1934, 'REPRESENTACIONES VALDERA E.I.R.L.', 'CAL. FEDERICO VILLAREAL NRO 968 CENTRO', '', '', 1, 2, '20480701594', 1, 'MICORREO@MAIL.COM', '', 130312, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1936, 'M & L SERVICIOS INMOBILIARIOS S.A.C.', 'MZA. M1 LOTE 36 URB. LOS SAUCES', '', '', 1, 2, '20606926198', 1, 'MICORREO@MAIL.COM', '', 130110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1937, 'GEOSEED SOCIEDAD ANONIMA CERRADA', 'MZA. D LOTE 4 C.P. ANTONIO RAYMONDI', '', '', 1, 2, '20608876392', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1938, 'INVERSIONES ILUKAN E.I.R.L.', 'AV. CHICLAYO NRO 173', '', '', 1, 2, '20604920532', 1, 'MICORREO@MAIL.COM', '', 60501, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1939, 'I.E N°11194', 'MZA. A LOTE 16 CAS. POLVAREDA', '', '', 1, 2, '20602139914', 1, 'MICORREO@MAIL.COM', '', 130108, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1940, 'INGENIOUS FERRETERO JOSSFAR E.I.R.L.', 'JR. JR SARGENTO MUJICA S/N NRO S/N CAS. SARGENTO MUJICA S/N', '', '', 1, 2, '20607110698', 1, 'MICORREO@MAIL.COM', '', 230302, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1941, 'IEI 474 - LAMBAYEQUE', '', '', '', 1, 1, '17532231', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1942, 'LILIANA QUISPE VERA', '', '', '', 1, 1, '75501060', 1, 'MICORREO@MAIL.COM', '', 10101, 0, '', 1, NULL, NULL, NULL, 0),
(1943, 'ESTHER COLLAZOS FERNANDEZ', '', '', '', 1, 1, '27245484', 1, 'MICORREO@MAIL.COM', '', 60501, 0, '', 1, NULL, NULL, NULL, 0),
(1944, 'DELCI ZELADA VASQUEZ', '', '', '', 1, 1, '16739275', 1, 'MICORREO@MAIL.COM', '', 10701, 0, '', 1, NULL, NULL, NULL, 0),
(1945, 'MUCHIK HOME S.A.C', 'AV. JAVIER PRADO ESTE NRO 487 INT. 400 OTR. JAVIER PRADO', '', '', 1, 2, '20606808560', 1, 'MICORREO@MAIL.COM', '', 10119, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1946, 'SANCHEZ TERRONES JORGE LUIS', '-', '', '', 1, 2, '10414384752', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1947, 'GRACIANO ESCOBAR ROSARIO ABEL', '', '', '', 1, 1, '18090958', 1, 'MICORREO@MAIL.COM', '', 120806, 0, '', 1, NULL, NULL, NULL, 0),
(1948, 'J. CENAS MAQUINARIA Y AGRO S.A.C.', 'CAL. FRANCISCO DE ZELA NRO 1550 INT. 4 URB. RISSO', '', '', 1, 2, '20604894302', 1, 'MICORREO@MAIL.COM', '', 140111, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1949, 'LEON ESTUPIÑAN SEIDY LADY', '', '', '', 1, 2, '10434098993', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1950, 'JUAN MIGUEL HEREDIA PEDEMONTE', '', '', '', 1, 1, '44350662', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(1951, 'PUUM GLOBAL SOCIEDAD ANONIMA CERRADA', 'CAL. DOMINGO CASANOVA NRO 466', '', '', 1, 2, '20603855737', 1, 'MICORREO@MAIL.COM', '', 140111, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1952, 'MILAN S GENERAL SERVICES E.I.R.L.', 'JR. SANTA ASUNCION NRO 425', '', '', 1, 2, '20606989904', 1, 'MICORREO@MAIL.COM', '', 60601, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1953, 'ESTACION EXPERIMENTAL AGRARIA VISTA FLORIDA - LAMBAYEQUE', 'CAR. A FERREÑAFE VISTA FLORIDA KM. 08', '', '', 1, 2, '20538977030', 1, 'MICORREO@MAIL.COM', '', 130109, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1954, 'PROMOTORA DE GRANOS Y LEGUMBRES DEL PERU E.I.R.L.', 'CAL. PARIÑAS NRO 885 URB. SAN ISIDRO', '', '', 1, 2, '20487886701', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1955, 'LUIS GUILLERMO PEÑA RETTO', '', '', '', 1, 1, '74941011', 1, 'MICORREO@MAIL.COM', '', 190702, 0, '', 1, NULL, NULL, NULL, 0),
(1956, 'ESCUELA PERUANA DE CONDUCTORES PROFESIONALES SOCIEDAD ANONIMA CERRADA', 'CAL. LAS ACACIAS NRO 211 URB. SANTA VICTORIA', '', '', 1, 2, '20487785777', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1957, 'ENERCO & SDH COMPONENTES  Y  TRANSPORTES S.R.L.', 'CAL. SOLF Y MURO NRO 1515 P.J. SANTA ROSA', '', '', 1, 2, '20526675429', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1958, 'PERU COMMERCIAL COMPANY S.A.C.', 'AV. CIRCUNVALACION DEL CLUB G NRO 134 DEP. 1501 URB. CLUB GOLF LOS INCAS', '', '', 1, 2, '20603889747', 1, 'MICORREO@MAIL.COM', '', 140130, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1959, 'DANIEL SANCHEZ IMAN', '', '', '', 1, 1, '47362014', 1, 'MICORREO@MAIL.COM', '', 10701, 0, '', 1, NULL, NULL, NULL, 0),
(1960, 'LIZARDO GONZALES DAVILA', '', '', '', 1, 1, '17557970', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1961, 'MARREROS SORIANO JESSICA ELIZABETH', '-', '', '', 1, 2, '10440322943', 1, 'MICORREO@MAIL.COM', '', 130110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1962, 'AGRO INVERSIONES VALLESOL SOCIEDAD ANÓNIMA CERRADA', 'CAL. PALESTINA NRO 118 URB. MIRAFLORES', '', '', 1, 2, '20487491439', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1963, 'RCJ FACTORIA INDUSTRIAL S.A.C.', 'CAL. CAJAMARCA NRO 315 P.J. TUPAC AMARU', '', '', 1, 2, '20600150996', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1964, 'LUISA BELEN CORONADO', '', '', '', 1, 1, '74095850', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1965, 'JOSE AURELIO COLMENRANES CHUMACERO', '', '', '', 1, 1, '47483672', 1, 'MICORREO@MAIL.COM', '', 190305, 0, '', 1, NULL, NULL, NULL, 0),
(1966, 'JESUS SANTIAGO COLMENARES CHUMACERO', '', '', '', 1, 1, '71121036', 1, 'MICORREO@MAIL.COM', '', 190305, 0, '', 1, NULL, NULL, NULL, 0),
(1967, 'MUNICIPALIDAD DEL CENTRO POBLADO LA CALERA SANTA ISABEL', 'NRO S/N LA CALERA SANTA ISABEL', '', '', 1, 2, '20480820763', 1, 'MICORREO@MAIL.COM', '', 130308, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1968, 'JOSE GUILLERMO FLORES CHAVESTA', '', '', '', 1, 1, '16553635', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1969, 'MILTON GIRON SIMBALA', '', '', '', 1, 1, '2814307', 1, 'MICORREO@MAIL.COM', '', 190101, 0, '', 1, NULL, NULL, NULL, 0),
(1970, 'FUMISERVIS & CERTIFICACIONES E.I.R.L.', 'CAL. NACIONALISMO NRO 684 URB. EL PARAISO', '', '', 1, 2, '20270074571', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1971, 'ECAN ABOGADOS SOCIEDAD CIVIL DE RESPONSABILIDAD LIMITADA', 'CAL. CRISTOBAL COLON NRO 664 INT. 202 URB. CERCADO DE CHICLAYO', '', '', 1, 2, '20561196631', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1972, 'MARIANO FUENTES PARRAGUEZ', 'AV TACNA 1664', '', '', 1, 2, '10166435043', 1, 'MICORREO@MAIL.COM', '', 130201, 0, '', 1, NULL, NULL, NULL, 0),
(1973, 'MANUEL ALBERTO ZAPATA ZUNIGA', '', '', '', 1, 1, '45579958', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1974, 'MARAKOS GRILL CONCESIONES E.I.R.L.', 'CAL. PACHACUTEC NRO 1935 P.J. EL BOSQUE', '', '', 1, 2, '20601799317', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1975, 'NUCLEO EJECUTOR CENTRAL - NEC SAN FELIPE', 'NRO . CPM. PIQUIJACA', '', '', 1, 2, '20607737488', 1, 'MICORREO@MAIL.COM', '', 60808, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1976, 'SILVA FLORES HUMBERTO', '-', '', '', 1, 2, '10272861574', 1, 'MICORREO@MAIL.COM', '', 60501, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1977, 'OSCAR RONCAL', '', '', '', 1, 1, '46883241', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1978, 'MANUEL SILVA FLORES', '', '', '', 1, 1, '43334850', 1, 'MICORREO@MAIL.COM', '', 60101, 0, '', 1, NULL, NULL, NULL, 0),
(1979, 'ALUBIAS PROCESADORA S.A.C.', 'MZA. F LOTE 18 URB. LA PARADA', '', '', 1, 2, '20604256829', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1980, 'JUAN FRANCISCO SALDAÑA SANCHEZ', '', '', '', 1, 1, '27147947', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1981, 'AUTOMATIZACION Y MONTAJES ELECTRICOS S.R.L', 'CAL. SIMON BOLIVAR NRO 677 INT. B URB. EL PORVENIR', '', '', 1, 2, '20539186621', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1982, 'JESUS MURO CHAPOÑAN', '', '', '', 1, 1, '74051856', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1983, 'AGROSERVICIOS A & S - PIURA E.I.R.L.', 'MZA. C LOTE 07 A.H. LOS ALMENDROS', '', '', 1, 2, '20600000706', 1, 'MICORREO@MAIL.COM', '', 10113, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1984, 'PROMOTORA Y SERVICIOS LAMBAYEQUE S.A.C.', 'CAL. ANTOLIN FLORES NRO 1580 C.P. VILLA SAN JUAN', '', '', 1, 2, '20479813877', 1, 'MICORREO@MAIL.COM', '', 130304, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1985, 'IGLESIA PENTECOSTAL LA COSECHA', 'CAL. TACNA NRO 965', '', '', 1, 2, '20198461564', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1986, 'SEGUNDO RUDY SAMAME CIELO', 'LOS TAMBOS #1347', '', '', 1, 1, '42406457', 1, 'MICORREO@MAIL.COM', '', 130115, 0, '', 1, NULL, NULL, NULL, 0),
(1987, 'PUPUCHE MORE SANTOS ISABEL', '-', '', '', 1, 2, '10806877510', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1988, 'AGROEXPORT ROJASDIAZ E.I.R.L.', 'MZA. H LOTE 02 URB. LOURDES', '', '', 1, 2, '20608153145', 1, 'MICORREO@MAIL.COM', '', 190101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1989, 'SERVICIOS DE GRUAS Y LOGISTICA DE LA CRUZ E.I.R.L.', 'AV. MEXICO NRO 1355 P.J. GARCES', '', '', 1, 2, '20608805355', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1990, 'FLORES NUÑEZ JHUNIOR GIANMARCOS', '-', '', '', 1, 2, '10767580229', 1, 'MICORREO@MAIL.COM', '', 10205, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1991, 'ADAMA AGRICULTURE PERU S.A.', 'AV. EL DERBY NRO 254 INT. 306 URB. EL DERBY DE MONTERRICO', '', '', 1, 2, '20516596946', 1, 'MICORREO@MAIL.COM', '', 140130, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1992, 'CONSTRUCTORA GALILEA S.A.C.', 'AV. PRIMAVERA NRO 1796 INT. 601 URB. MONTERRICO', '', '', 1, 2, '20521119943', 1, 'MICORREO@MAIL.COM', '', 140130, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1993, 'CAMINO AL AGRO J & M S.A.C.', 'AV. 10 DE JUNIO MZA. A DEP. 804 URB. SAN JOSE', '', '', 1, 2, '20602170897', 1, 'MICORREO@MAIL.COM', '', 140126, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1994, 'VIVERO TORRE FUERTE E.I.R.L.', 'AV. PANAMERICANA NRO SN', '', '', 1, 2, '20601633338', 1, 'MICORREO@MAIL.COM', '', 130308, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1995, 'HARDDEX E.I.R.L.', 'MZA. 37 LOTE 8 SEC. PAMPA EL TORO', '', '', 1, 2, '20604493600', 1, 'MICORREO@MAIL.COM', '', 130120, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1996, 'LUIS BECERRA PEREZ', '', '', '', 1, 1, '3897889', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(1997, 'ALERCOGE S.A.C.', 'CAL. LOS PENSAMIENTOS NRO 747 URB. PALMERAS DEL GOLF', '', '', 1, 2, '20440251758', 1, 'MICORREO@MAIL.COM', '', 120101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1998, 'ORGANIC VEGETABLES S.A.C.', 'MZA. G LOTE 23 ASOC PRO-VIV LOS CLAVELES', '', '', 1, 2, '20503243971', 1, 'MICORREO@MAIL.COM', '', 140113, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(1999, 'D Y M CONSTRUCTORES  GENERALES S.A.C.', 'CAL. 9 DE OCTUBRE NRO 176 A.H. SAN NICOLAS', '', '', 1, 2, '20570845889', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2000, 'LLONTOP FERNANDEZ JESUS ALBERTO', '-', '', '', 1, 2, '10759253561', 1, 'MICORREO@MAIL.COM', '', 130106, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2001, 'PASTUS HUAMACTO LUIS BRAULIO', '-', '', '', 1, 2, '10738007307', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2002, 'CHARLY MUÑOZ VASQUEZ', '', '', '', 1, 1, '42765434', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2003, 'AGRO PALO BLANCO S.A.C.', 'PJ. LOS ZAPOTES NRO 135 DEP. 102 URB. SANTA VICTORIA', '', '', 1, 2, '20609148382', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2004, 'CASTILLO RUJEL BETTY ANGELINA', '', '', '', 1, 2, '10438469341', 1, 'MICORREO@MAIL.COM', '', 190601, 0, '', 1, NULL, NULL, NULL, 0),
(2005, 'ASOC. DE AGRICULTORES Y GANADEROS DE AGROEXPORTACION PECUARIA Y CONSERVACION DEL MEDIO AMBIENTE RUMBO AL TRIUNFO DEL CASERIO PUCHACA -PUCHACA', '', '', '', 1, 3, '', 1, 'MICORREO@MAIL.COM', '', 130202, 0, '', 1, NULL, NULL, NULL, 0),
(2006, 'JORGE JOSE ROMERO HIDALGO', '', '', '', 1, 1, '43412916', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2007, 'CONSORCIO FRONTERA NORTE', 'MZA. V LOTE 22 A.H. PECUARIO NUEVO HORIZONTE', '', '', 1, 2, '20609614791', 1, 'MICORREO@MAIL.COM', '', 10113, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2008, 'SERVIMAX & PETROLEOS E.I.R.L.', 'MZA. LL LOTE 12 C.V. COVICORTI', '', '', 1, 2, '20602121501', 1, 'MICORREO@MAIL.COM', '', 120101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2009, 'TRANSPORTES RIO BLANCO SOCIEDAD ANONIMA CERRADA', 'CAL. CHONGOYAPE NRO 411 URB. LATINA', '', '', 1, 2, '20539015576', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2010, 'GRUPO AGRO SELVA AG SAC', 'CAL. CHONGOYAPE NRO 411 URB. LATINA', '', '', 1, 2, '20600374771', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2011, 'RAF BARCENES S.A.C.', 'PJ. JOSE RODRIGUEZ NRO 125 URB. SAN MARTIN', '', '', 1, 2, '20601489725', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2012, 'ISLA PAZ ALDO ENRRIQUE', 'OCHO DE OCTUBRE 100 LAMBAYEQUE', '', '', 1, 2, '10709254711', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2013, 'EURO DIGITAL CLEAN S.A.C.', 'CAL. LA LEALTAD MZA. W LOTE 27 A.H. MICAELA BASTIDAS', '', '', 1, 2, '20604682089', 1, 'MICORREO@MAIL.COM', '', 140103, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2014, 'AGM INGENIERIA Y CONSTRUCCION E.I.R.L.', 'CAL. CARLOS HORNA NRO 109 INT. 2 URB. LA PRIMAVERA', '', '', 1, 2, '20600865588', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2015, 'AGROINDUSTRIAS Y SERVICIOS GENERALES LORETO S & C S.A.C.', 'AV. SANTA LIBERTAD NRO 514 URB. SANTA VICTORIA - CHICLAYO', '', '', 1, 2, '20600211456', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2016, 'AVICOLA NELSON E.I.R.L.', 'CAL. ARICA NRO 637', '', '', 1, 2, '20609051192', 1, 'MICORREO@MAIL.COM', '', 100105, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2017, 'CONSTRUCTORA Y PROMOTORA ARQCONSA SAC', 'CAL. TORRES PAZ NRO 533 CENTRO CHICLAYO', '', '', 1, 2, '20480087985', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2018, 'AGURTO FARFAN OSCAR', '-', '', '', 1, 2, '10258223743', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2019, 'MENDEZ VILCHEZ IVAN FRANCISCO', '-', '', '', 1, 2, '10180808928', 1, 'MICORREO@MAIL.COM', '', 120803, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2020, 'CENTRO DE SERVICIOS INTEGRALES DE SALUD RAY S.A.C', 'AV. LUIS GONZALES NRO 642 DEP. 301 CERCADO DE CHICLAYO', '', '', 1, 2, '20487989852', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2021, 'LORENZO ROLANDO BANCES OCAÑA', '', '', '', 1, 1, '6745659', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2022, 'E & V SERVICIO DE CONFIANZA E.I.R.L.', 'MZA. H LOTE 03 CAS. SANTA MARIA', '', '', 1, 2, '20610187316', 1, 'MICORREO@MAIL.COM', '', 120902, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2023, 'SIFUENTES FERNANDEZ CESAREO PORFIRIO', 'CALL LAS ORQUIDEAS ZONAL SUPE MZA E LT 18 CRUCE ANDRES DE LOS REYES CON SOCABAYA', '', '', 1, 2, '10405592661', 1, 'MICORREO@MAIL.COM', '', 140901, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2024, 'TERMINALES DEL PERÚ', 'AV. NESTOR GAMBETTA NRO 1265 URB. INDUSTRIAL LA CHALACA', '', '', 1, 2, '20563249766', 1, 'MICORREO@MAIL.COM', '', 240101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2025, 'CYR AGRICOLA EXPORTADORA S.A.C', 'JR. AUGUSTO DURAND NRO 2283 URB. SAN LUIS DEL FDO.EL PINO', '', '', 1, 2, '20507605703', 1, 'MICORREO@MAIL.COM', '', 21701, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2026, 'UNIDAD EJECUTORA 005 NAYLAMP-LAMBAYEQUE', 'AV. LUIS GONZALES NRO 345 CERCADO DE CHICLAYO', '', '', 1, 2, '20480108222', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2027, 'DACAVE CONTRATISTAS GENERALES EIRL', 'AV. 7 DE JUNIO MZA. 91A LOTE 15 P.J. NUEVA ESPERANZA', '', '', 1, 2, '20487519384', 1, 'MICORREO@MAIL.COM', '', 140132, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2028, 'DIAZ LOPEZ SONIA GASDALI', 'SUCRE 304', '', '', 1, 2, '10193365260', 1, 'MICORREO@MAIL.COM', '', 130201, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2029, 'ASOCIACION FONDO SOCIAL LA GRANJA', 'CAL. COMERCIO NRO 365', '', '', 1, 2, '20491601788', 1, 'MICORREO@MAIL.COM', '', 60614, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2030, 'ASOCIACION DE PRODUCTORES AGROPECUARIOS CUGUID', 'JR. CRUZ DE MARIA NRO 94 CENT CUTERVO', '', '', 1, 2, '20491558599', 1, 'MICORREO@MAIL.COM', '', 60501, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2031, 'LDP PERU E.I.R.L.', 'MZA. A LOTE 11 URB. SOL DE LA ALAMEDA REAL', '', '', 1, 2, '20608154788', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0);
INSERT INTO `cliente` (`codigo_cli`, `nombre_cli`, `direccion_cli`, `ciudad_cli`, `telefono_cli`, `codigo_tip`, `codigo_doc`, `numero_doc`, `codigo_szo`, `email_cli`, `observacion_cli`, `codigo_dis`, `estadosunat_cli`, `condicionsunat_cli`, `estado_cli`, `usuario_reg`, `usuario_mod`, `fecha_mod`, `sistema`) VALUES
(2032, 'SERVICIO DE CONSTRUCCION Y LIMPIEZA EMPRESA INDIVIDUAL DE RESPONSABILIDAD LIMITADA', 'CAL. CACIQUE COLLIQUE NRO 324 INT. 1 PI', '', '', 1, 2, '20603950675', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2033, 'FLORES FLORES KELIN KATHERINE', 'CAL LOS CURACAS 120', '', '', 1, 2, '10725096807', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2034, 'DEMETRIO VICTOR SANCHEZ SALAZAR', '', '', '', 1, 1, '19328765', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2035, 'AN2 ARQUITECTOS SOCIEDAD ANONIMA CERRADA', 'CAL. FERNANDO ECHANDIA LAN NRO 224 DEP. 301', '', '', 1, 2, '20608281666', 1, 'MICORREO@MAIL.COM', '', 140140, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2036, 'SEGUNDO OROZCO CHUMACERO', '', '', '', 1, 1, '1054653', 1, 'MICORREO@MAIL.COM', '', 10421, 0, '', 1, NULL, NULL, NULL, 0),
(2037, 'JOSÉ GILBERTO CHAPOÑAN CONTRERAS', '', '', '', 1, 1, '17626550', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2038, 'SEGUNDO JESUS RODAS RODAS', '', '', '', 1, 1, '76502284', 1, 'MICORREO@MAIL.COM', '', 60101, 0, '', 1, NULL, NULL, NULL, 0),
(2039, 'GOBIERNO REGIONAL LAMBAYEQUE HOSPITAL REGIONAL DOCENTE LAS MERCEDES', 'AV. LUIS GONZALES NRO 635', '', '', 1, 2, '20437274518', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2040, 'COOPERATIVA AGRARIA DE PRODUCTORES ORGANICOS CAPO CALEB LTDA', 'MZA. A LOTE 15 A.H. LA PRIMAVERA', '', '', 1, 2, '20601027896', 1, 'MICORREO@MAIL.COM', '', 120902, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2041, 'INDUSTRIA TECNOLOGICA AGRICOLA DEL PERU S.A.', 'AV. JAVIER PRADO ESTE NRO 6210 INT. 201', '', '', 1, 2, '20337935029', 1, 'MICORREO@MAIL.COM', '', 140110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2042, 'SHARON MARIA QUIÑONES CABANILLAS', '', '', '', 1, 1, '19326515', 1, 'MICORREO@MAIL.COM', '', 120503, 0, '', 1, NULL, NULL, NULL, 0),
(2043, 'OPTICA NOVA S.A.C.', 'CAL. ELIAS AGUIRRE NRO 300', '', '', 1, 2, '20479726630', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2044, 'AGRO PIMA PERU S.A.C.', 'AV. 1RO DE MAYO NRO 447 Z.I. FUNDO PUENTE', '', '', 1, 2, '20608518259', 1, 'MICORREO@MAIL.COM', '', 140135, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2045, 'HOUSECLEANER PERU S.A.C.', 'AV. LAS AMERICAS NRO 405 A.H. SAN NICOLAS', '', '', 1, 2, '20609787440', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2046, 'HOSPITAL CLINICO PROVIDA SAC', 'CAL. JUAN CUGLIEVAN NRO 160', '', '', 1, 2, '20480089333', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2047, 'ASOCIACIÓN DE PRODUCT. AGROPECUARIOS Y SERV. MULTIPLES, AGROINDUSTRIALES C.P.CONDAY LA PALMA-CUTERVO', 'NRO S/N CAS. CONDAY', '', '', 1, 2, '20609046491', 1, 'MICORREO@MAIL.COM', '', 60501, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2048, 'TABACAN PRODUCTORA & PROCESADORA DE TABACOS S.A.C.', 'AV. PROLONGACION UNION MZA. D LOTE 17 URB. SANTA MARGARITA', '', '', 1, 2, '20605464816', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2049, 'LUCAS TUÑOQUE SANTAMARIA', 'LAS MAGNOLIAS 193 URB MIRAFLORES', '', '', 1, 2, '10175616701', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(2050, 'NAPOLES FARM & NURSERY S.A.C.', 'NRO 275 URB. LA CAPILLA CORDOVA', '', '', 1, 2, '20604603243', 1, 'MICORREO@MAIL.COM', '', 140110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2051, 'GERENCIA SUB-REGIONAL CUTERVO', 'AV. SALOMON VILCHEZ MURGA NRO S.N', '', '', 1, 2, '20453383475', 1, 'MICORREO@MAIL.COM', '', 60501, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2052, 'CHUQUIPOMA CHINCHAY FIDENCIO', '-', '', '', 1, 2, '10419594577', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2053, 'CORPORACION AGRARIA ROYFADY S.R.L', 'CAL. FACLO GRANDE NRO S/N A.H. FACLO GRANDE', '', '', 1, 2, '20605391649', 1, 'MICORREO@MAIL.COM', '', 120503, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2054, 'RAF BARCENES COMPANY SRL', 'AV. MEXICO NRO 2501 PJ BARSALLO', '', '', 1, 2, '20607565580', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2055, 'DUBER DELGADO HORNA', '', '', '', 1, 1, '46008782', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2056, 'GANADERIA HALEMA S.A.C.', 'AV. VIRREY CONDE DE LEMOS NRO 231 URB. COLONIAL', '', '', 1, 2, '20605611894', 1, 'MICORREO@MAIL.COM', '', 240101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2057, 'FRIGOSA SOCIEDAD ANONIMA CERRADA - FRIGOSA S.A.C.', 'PRO. PARINACOCHAS NRO 1573 INT. 2', '', '', 1, 2, '20546645593', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2058, 'JM DESARROLLADOR SOCIEDAD ANONIMA CERRADA', 'CAL. CRISTOBAL COLON NRO 441 CERCADO DE CHICLAYO', '', '', 1, 2, '20554170839', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2059, 'IMPROJECTZ S.A.C.', 'JR. MANUEL CARBAJAL MZA. F LOTE 2 DEP. 301 URB. LAS HIEDRAS DE SURCO', '', '', 1, 2, '20602115942', 1, 'MICORREO@MAIL.COM', '', 140130, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2060, 'MARCO ALCARAZO', '', '', '', 1, 1, '40838236', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(2061, 'TODO REPUESTOS Y SERVICIOS S.A.C. - TORESER S.A.C.', 'JUAN PICHER MZA. P LOTE 5 PACIFICO', '', '', 1, 2, '20451578902', 1, 'MICORREO@MAIL.COM', '', 140126, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2062, 'BANCES SANDOVAL JOSE VIRGILIO', '-', '', '', 1, 2, '10175628466', 1, 'MICORREO@MAIL.COM', '', 130306, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2063, 'RICHARD', '', '', '', 1, 3, '', 1, 'MICORREO@MAIL.COM', '', 120902, 0, '', 1, NULL, NULL, NULL, 0),
(2064, 'GERONIMO NUÑEZ TANTALEAN', '', '', '', 1, 1, '27419625', 1, 'MICORREO@MAIL.COM', '', 60601, 0, '', 1, NULL, NULL, NULL, 0),
(2065, 'SANTIAGO GUANILA', '', '', '', 1, 1, '17524716', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2066, 'ELIBERTO BRAVO CHAPOÑAN', '', '', '', 1, 1, '17524340', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2067, 'IRMA ACUÑA LA TORRE', '', '', '', 1, 1, '17561817', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2068, 'EUSEBIO MIO BENITES', '', '', '', 1, 1, '43529410', 1, 'MICORREO@MAIL.COM', '', 140141, 0, '', 1, NULL, NULL, NULL, 0),
(2069, 'DIEGO DE LA CRUZ SANTA MARIA', '', '', '', 1, 1, '17566604', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2070, 'CONSTRUCTORA MAYES S.A.C.', 'CAL. ORELLANA NRO 150 SEC. MORRO SOLAR', '', '', 1, 2, '20609016648', 1, 'MICORREO@MAIL.COM', '', 60801, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2071, 'EDILBERTO GONZALES NUÑEZ', '', '', '', 1, 1, '16806988', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(2072, 'ELIA MEOÑO LOPEZ', '', '', '', 1, 1, '40441444', 1, 'MICORREO@MAIL.COM', '', 130201, 0, '', 1, NULL, NULL, NULL, 0),
(2073, 'CONSORCIO EL PINO - SCANDER', 'AV. PRIMAVERA NRO 871 URB. CHACARILLA DEL ESTANQUE', '', '', 1, 2, '20602131514', 1, 'MICORREO@MAIL.COM', '', 140140, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2074, 'AROMA COMPANY S.A.C.', 'AV. EL TRIUNFO NRO 975 P.J. CRUZ DE LA ESPERANZA', '', '', 1, 2, '20607601471', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2075, 'INGENIERIA CONTROL Y SANEAMIENTO AMBIENTAL S.R.L.', 'EDIFICIO TRES NRO 3 DEP. 303 RES. VILLA VERDE', '', '', 1, 2, '20607489905', 1, 'MICORREO@MAIL.COM', '', 130110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2076, 'MARIA LILIANA SANCHEZ DE LA CRUZ', '', '', '', 1, 1, '48116215', 1, 'MICORREO@MAIL.COM', '', 130304, 0, '', 1, NULL, NULL, NULL, 0),
(2077, 'AUTOMOTORES Y SERVICIOS DE PIURA S.R.L.', 'MZA. 229 LOTE 01B ZONA INDUSTRIAL', '', '', 1, 2, '20604919020', 1, 'MICORREO@MAIL.COM', '', 190101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2078, 'DIAZ MORETO JOSE ELI', '-', '', '', 1, 2, '10424859961', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2079, 'HIPOLITO CORONADO CIEZA', '', '', '', 1, 1, '44995410', 1, 'MICORREO@MAIL.COM', '', 130201, 0, '', 1, NULL, NULL, NULL, 0),
(2080, 'JORGE MERA FLORES', '', '', '', 1, 1, '16636443', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2081, 'CHARLY ALONSO MUÑOZ VASQUEZ', '', '', '', 1, 1, '42765434', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(2082, 'AGROMAX GEO S.A.C.', 'CAL. TACNA NRO 332 OTR. ASCOPE', '', '', 1, 2, '20609520478', 1, 'MICORREO@MAIL.COM', '', 120801, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2083, 'ABNER LARA TORRES', '', '', '', 1, 1, '33588654', 1, 'MICORREO@MAIL.COM', '', 190601, 0, '', 1, NULL, NULL, NULL, 0),
(2084, 'MARICRUZ JIMÉNEZ FLORES', '', '', '', 1, 1, '46774551', 1, 'MICORREO@MAIL.COM', '', 120901, 0, '', 1, NULL, NULL, NULL, 0),
(2085, 'ANCAJIMA GUZMAN WALTER HUGO', '-', '', '', 1, 2, '10102956406', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2086, 'ELVIS CARRASCO HUAMAN', '', '', '', 1, 1, '46838064', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2087, 'APAFA IE MANUEL BURGA PUELLES', 'JAYANCA', '', '', 1, 1, '33667497', 1, 'MICORREO@MAIL.COM', '', 130304, 0, '', 1, NULL, NULL, NULL, 0),
(2088, '3S AMBIENTAL Y CONSTRUCCION S.A.C.', 'AV. JUAN PABLO - 1 PISO MZA. 29 LOTE 15 LAS LOMAS - HUANCHACO', '', '', 1, 2, '20482047590', 1, 'MICORREO@MAIL.COM', '', 120102, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2089, 'RIVAS CRUZ INGRID DEL ROCIO', '-', '', '', 1, 2, '10033739805', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2090, 'VIVARCORP E.I.R.L.', 'JR. MANUEL DE AGUILA NRO S/N BAR. BELEN', '', '', 1, 2, '20608335871', 1, 'MICORREO@MAIL.COM', '', 210101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2091, 'BANCES SANDOVAL LUZMILA', '-', '', '', 1, 2, '10166828151', 1, 'MICORREO@MAIL.COM', '', 130106, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2092, 'LAS LOMAS KG INVERSIONES S.A.C.', 'UD. 101 MZA. S LOTE 5 A.H. LAS LOMAS 2 ETAPA', '', '', 1, 2, '20603929587', 1, 'MICORREO@MAIL.COM', '', 120102, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2093, 'ASOCIACION DE MUJERES TRIUNFADORAS DEL CASERIO DE PUCHACA - AMUTCAP', 'AV. VENEZUELA NRO 3230 NUEVO SAN LORENZO', '', '', 1, 2, '20609782499', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2094, 'PEDRO MORAN INOÑAN', '', '', '', 1, 1, '17529271', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2095, 'COMPAÑIA ARROCERA NUEVA ESPERANZA S.A.C.', 'PRO. MIGUEL GRAU KM. 2.5', '', '', 1, 2, '20606214571', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2096, 'NATURALEZA QUE ENCANTA S.A.C.', 'CAR. PANAMERICANA NORTE KM. 32.5', '', '', 1, 2, '20603817541', 1, 'MICORREO@MAIL.COM', '', 130304, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2097, 'NILO SUXE RAMIREZ', '', '', '', 1, 1, '27975305', 1, 'MICORREO@MAIL.COM', '', 60101, 0, '', 1, NULL, NULL, NULL, 0),
(2098, 'WILMER DIAZ CERQUERA', '', '', '', 1, 1, '45149937', 1, 'MICORREO@MAIL.COM', '', 130117, 0, '', 1, NULL, NULL, NULL, 0),
(2099, 'OLANO DAVILA CARO', '', '', '', 1, 1, '74896957', 1, 'MICORREO@MAIL.COM', '', 60101, 0, '', 1, NULL, NULL, NULL, 0),
(2100, 'JORGE PALACIOS CAMACHE', '', '', '', 1, 1, '3625675', 1, 'MICORREO@MAIL.COM', '', 190601, 0, '', 1, NULL, NULL, NULL, 0),
(2101, 'PERCY MIGUEL TUÑOQUE QUISPE', '', '', '', 1, 1, '40145526', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2102, 'JORGE LUIS ESQUEN FARRO', '', '', '', 1, 1, '16626267', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2103, 'JUAN DE LOS SANTOS ACOSTA VIDAURRE', '', '', '', 1, 1, '17632756', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(2104, 'MARCO SALAZAR YAIPEN', '', '', '', 1, 1, '16535672', 1, 'MICORREO@MAIL.COM', '', 130106, 0, '', 1, NULL, NULL, NULL, 0),
(2105, 'CUEVA PEREZ WILMER PORFIRIO', '', '', '', 1, 1, '43369457', 1, 'MICORREO@MAIL.COM', '', 61001, 0, '', 1, NULL, NULL, NULL, 0),
(2106, 'SEBASTIAN BANCES SANDOVAL', '', '', '', 1, 1, '17598207', 1, 'MICORREO@MAIL.COM', '', 130312, 0, '', 1, NULL, NULL, NULL, 0),
(2107, 'JOSE ROSINALDO VALVERDE SUCLUPE', '', '', '', 1, 1, '46882594', 1, 'MICORREO@MAIL.COM', '', 130306, 0, '', 1, NULL, NULL, NULL, 0),
(2108, 'JOSE SALAZAR SANCHES', '', '', '', 1, 1, '16798801', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2109, 'ANTONIO ROJAS', '', '', '', 1, 1, '27283212', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2110, 'JESUS PAIVA', '', '', '', 1, 1, '44638844', 1, 'MICORREO@MAIL.COM', '', 130201, 0, '', 1, NULL, NULL, NULL, 0),
(2111, 'ABAD MOROCHO PASTOR', '-', '', '', 1, 2, '10030884316', 1, 'MICORREO@MAIL.COM', '', 190201, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2112, 'JOSE DE LA CRUZ LLAGUENDO', '', '', '', 1, 1, '44606398', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2113, 'MANUEL VASQUEZ USQUIANO', '', '', '', 1, 1, '17549980', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(2114, 'BLANCA REQUEJO CADENA', '', '', '', 1, 1, '46317064', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(2115, 'TOMAS VALDERDA BANCES', '', '', '986362249', 1, 1, '17615428', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(2116, 'MADISA INGENIEROS SOCIEDAD ANONIMA CERRADA', 'JR. SANTIAGO ANTUNEZ DE MAYOL MZA. A LOTE 32 URB. PABLO BONER', '', '', 1, 2, '20512640967', 1, 'MICORREO@MAIL.COM', '', 140110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2117, 'EDUARDO SANDOVAL BALDERA', '', '', '', 1, 1, '40872201', 1, 'MICORREO@MAIL.COM', '', 130312, 0, '', 1, NULL, NULL, NULL, 0),
(2118, 'SIESQUEN CHAPOÑAN LUIS', '', '', '', 1, 1, '74247667', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2119, 'WALTER MARCHENA CERCADO', '', 'ZAÑA', '', 1, 1, '16613245', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2120, 'JESUS SIESQUEN CHERO', '', '', '925203536', 1, 1, '17562796', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(2121, 'JAVIER ZEÑA LLONTOP', '', '', '', 1, 1, '44172577', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(2122, 'ARMANDO URBANO MORENO PAICO', '', '', '', 1, 1, '17558395', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(2123, 'I.E. N°11265 EL PROGRESO MESONES MURO', 'CAR. CHONGOYAPE NRO SN EL PROGRESO', '', '', 1, 2, '20602133771', 1, 'MICORREO@MAIL.COM', '', 130117, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2124, 'QURI INMOBILIARIA SOCIEDAD ANONIMA CERRADA', 'CAL. LOS PINOS NRO 250 URB. SANTA VICTORIA', '', '', 1, 2, '20607186180', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2125, 'BUENOS BIENES S.A.C.', 'JR. COMERCIO NRO 1004', '', '', 1, 2, '20570547608', 1, 'MICORREO@MAIL.COM', '', 60501, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2126, 'SANDOVAL GUERRERO ELEODORO', 'AV TACNA 100', '', '', 1, 2, '10174039637', 1, 'MICORREO@MAIL.COM', '', 130201, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2127, 'EDUARDO GOMES MURILLO', '', '', '', 1, 1, '16444098', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2128, 'INSTITUCION EDUCATIVA JOSE QUIÑONES GONZALES', 'CAL. ANTENOR ORREGO NRO 201 CENTR OYOTUN', '', '', 1, 2, '20602106358', 1, 'MICORREO@MAIL.COM', '', 130108, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2129, 'FERNANDEZ MANAYALLE EBERTH JOEL', '-', '', '', 1, 2, '10164141328', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2130, 'JOSE ORESTE TORO CHERO', '', '', '', 1, 1, '17403111', 1, 'MICORREO@MAIL.COM', '', 130201, 0, '', 1, NULL, NULL, NULL, 0),
(2131, 'CRISTIAN LEODAN SANTA CRUZ FLORES', '', '', '', 1, 1, '16792759', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(2132, 'ALEJANDRO GARCIA RAMIREZ', '', '', '', 1, 1, '42885589', 1, 'MICORREO@MAIL.COM', '', 130307, 0, '', 1, NULL, NULL, NULL, 0),
(2133, 'MUNICIPALIDAD DISTRITAL DE MONSEFU', 'CAL. 7 DE JUNIO NRO S/N', '', '', 1, 2, '20191711328', 1, 'MICORREO@MAIL.COM', '', 130106, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2134, 'ALFREDO CORNEJO PISFIL', '', '', '', 1, 1, '42811759', 1, 'MICORREO@MAIL.COM', '', 130106, 0, '', 1, NULL, NULL, NULL, 0),
(2135, 'MOLINERA YANKELLY E.I.R.L.', 'AV. LAMBAYEQUE NRO 1040 CPME SANTA ANA', '', '', 1, 2, '20487430561', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2136, 'GRUPO ACUÑA ROSALES S.A.C.', 'CAL. SINCHI ROCA NRO 1477 URB. LA VICTORIA SC. TRES PARC', '', '', 1, 2, '20608343327', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2137, 'DELCI ROJAS TORO', '', '', '', 1, 1, '16635268', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2138, 'EMPANADAS TORETTO S GRILL S.R.L', 'CAL. LOSDULANTOS NRO 119 URB. SANTA VICTORIA', '', '', 1, 2, '20600791959', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2139, 'FRANCISCO COBEÑAS YOVERA', '', '', '', 1, 1, '2710629', 1, 'MICORREO@MAIL.COM', '', 190101, 0, '', 1, NULL, NULL, NULL, 0),
(2140, 'JUAN DARWIN CESPEDES ESQUEN', '', '', '', 1, 1, '77030788', 1, 'MICORREO@MAIL.COM', '', 130310, 0, '', 1, NULL, NULL, NULL, 0),
(2141, 'MAXIMO AGUINAGA RIOS', '', '', '', 1, 1, '28109929', 1, 'MICORREO@MAIL.COM', '', 130108, 0, '', 1, NULL, NULL, NULL, 0),
(2142, 'LUIS  ALBERTO  SANTAMARÍA  VALDERA', '', '', '', 1, 1, '80338008', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(2143, 'JOSE MORA', '', '', '', 1, 1, '16640949', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2144, 'JOSE MERCEDES BALDERA RIOJAS', '', '', '', 1, 1, '41434854', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(2145, 'GERONIMO DIAZ VASQUEZ', '', '', '', 1, 1, '27365904', 1, 'MICORREO@MAIL.COM', '', 60601, 0, '', 1, NULL, NULL, NULL, 0),
(2146, 'GLORIA RAMOS JIMÉNEZ', '', '', '', 1, 1, '16481230', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(2147, 'HERNAN SANCHEZ RODRIGUEZ', '', '', '', 1, 1, '41124717', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2148, 'LUIS MIGUEL DELGADO CASTRO', '', '', '', 1, 1, '16410972', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2149, 'SANTISTEBAN TORRES MARGARITA DEL MILAGRO', '-', '', '', 1, 2, '10702699318', 1, 'MICORREO@MAIL.COM', '', 140101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2150, 'AGRO SIME SD S.A.C', 'PJ. VENUS NRO 161 URB. MIRAMAR', '', '', 1, 2, '20561217654', 1, 'MICORREO@MAIL.COM', '', 140127, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2151, 'ERICA BONIFACIO LLONTOP', '', '', '', 1, 1, '45704855', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2152, 'E.T.P. TURISMO VIRGEN DE FATIMA E.I.R.L.', 'CAL. 24 DE MARZO NRO 333 P.J. SANTA VALENTINA', '', '', 1, 2, '20487364593', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2153, 'JOSÉ JAVIER VENTURA VIDAURRE', '', '', '', 1, 1, '76957715', 1, 'MICORREO@MAIL.COM', '', 230101, 0, '', 1, NULL, NULL, NULL, 0),
(2154, 'KARINA MARTINEZ CAMPOS', '', '', '', 1, 1, '5416330', 1, 'MICORREO@MAIL.COM', '', 130307, 0, '', 1, NULL, NULL, NULL, 0),
(2155, 'AGROQUIMICOS Y FERTILIZANTES SAN MIGUEL S.R.L.', 'AV. PANAMERICANA NRO S/N CAS. EL PARTIDOR', '', '', 1, 2, '20530248748', 1, 'MICORREO@MAIL.COM', '', 190107, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2156, 'PUNTO PRO PERU S.A.C', 'CAL. MIGUEL IGLESIAS NRO 398 URB. SANTA MARIA V', '', '', 1, 2, '20602319530', 1, 'MICORREO@MAIL.COM', '', 120101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2157, 'GAM INGENIEROS ARQUITECTOS SOCIEDAD ANONIMA CERRADA', 'MZA. A LOTE 1 URB. AVIENTEL', '', '', 1, 2, '20561367460', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2158, 'WILDER MIRANDA TAPIA', '', '', '', 1, 1, '26608301', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2159, 'CONSTRUCCIONES Y EDIFICACIONES JAC S.A.C.', 'CAL. MIGUEL GRAU NRO 173', '', '', 1, 2, '20610192603', 1, 'MICORREO@MAIL.COM', '', 130305, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2160, 'HM INVERSIONISTAS S.A.C.', 'AV. ANGAMOS ESTE NRO 1648 DEP. 404', '', '', 1, 2, '20108664640', 1, 'MICORREO@MAIL.COM', '', 140131, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2161, 'MARIA EDIT MORALES GUTIERREZ', '', '', '', 1, 1, '41384911', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2162, 'FERNANDO YANAGUI CASTILLO', 'CALLE VICTORIA 349- MOTUPE', '', '', 1, 1, '17573340', 1, 'MICORREO@MAIL.COM', '', 130307, 0, '', 1, NULL, NULL, NULL, 0),
(2163, 'CESAR TERRONES DEZA', '', '', '', 1, 1, '18213319', 1, 'MICORREO@MAIL.COM', '', 130108, 0, '', 1, NULL, NULL, NULL, 0),
(2164, 'JOSE GILMER BILLALOBOS FLORES', '', 'UDIMA', '', 1, 1, '44857223', 1, 'MICORREO@MAIL.COM', '', 60902, 0, '', 1, NULL, NULL, NULL, 0),
(2165, 'LUIS ALBERTO VALLE ALBUJAR', '', '', '', 1, 1, '17615884', 1, 'MICORREO@MAIL.COM', '', 130305, 0, '', 1, NULL, NULL, NULL, 0),
(2166, 'CONSULTORES ASOCIADOS EN PAISAJISMO Y MEDIO AMBIENTE S.A.C.', 'JR. RICARDO REY BASADRE NRO 585 DEP. 402', '', '', 1, 2, '20600177975', 1, 'MICORREO@MAIL.COM', '', 140114, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2167, 'JOSE SSAVEDRA BRAVO', '', '', '', 1, 1, '27397748', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2168, 'ASOCIACION DE VECINOS DEL CONDOMINIO REAL', 'MZA. F LOTE 1A URB. REAL', '', '', 1, 2, '20602150870', 1, 'MICORREO@MAIL.COM', '', 130110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2169, 'MAC COMPANY PERU S.A.C.', 'CAL. LOS CLAVELES NRO 231 URB. SAN LUIS', '', '', 1, 2, '20610422455', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2170, 'INMOBILIARIA Y CONTRATISTAS GENERALES GENESIS S.A.C.', 'AV. AV. LA UNIVERSIDAD MZA. C LOTE 17 URB. RESIDENCIAL MONTERRICO', '', '', 1, 2, '20609284324', 1, 'MICORREO@MAIL.COM', '', 140110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2171, 'TAMARIZ UBILLUS ARMANDO', 'C.P. SERUR INSCULAS 1 S/N MZA. A', '', '', 1, 2, '10729373091', 1, 'MICORREO@MAIL.COM', '', 130308, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2172, 'SERVICIOS Y PROTECCION AGRICOLA S.A.C', 'CAL. LOS CACTUS NRO 235 URB. FEDERICO VILLAREAL', '', '', 1, 2, '20601786304', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2173, 'ARMANDO PISFIL VILLALOBOS', '', '', '', 1, 1, '6793124', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(2174, 'CARLOS PEREZ', '', '', '', 1, 1, '46966835', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(2175, 'GUEVARA VALLEJOS CIRO', '', '', '', 1, 1, '43029716', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2176, 'ALEX ANDRES HUERTAS ALCANTARA', '', '', '', 1, 1, '16731903', 1, 'MICORREO@MAIL.COM', '', 61001, 0, '', 1, NULL, NULL, NULL, 0),
(2177, 'JANSA IMC INGENIEROS S.A.C.', 'CAL. SAN PEDRO NRO 623 URB. SAN LORENZO', '', '', 1, 2, '20604861684', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2178, 'GUERRERO CORDOVA KELITA', '-', '', '', 1, 2, '10413006975', 1, 'MICORREO@MAIL.COM', '', 60801, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2179, 'GREEN PACKING S.A.C.', 'PJ. ALCANTARILLA NRO S/N', '', '', 1, 2, '20603360487', 1, 'MICORREO@MAIL.COM', '', 140905, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2180, 'JOCKEY CLUB DE CHICLAYO', 'AV. LOS INCAS NRO 379', '', '', 1, 2, '20103594651', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2181, 'C.E.P.NUESTRA SEÑORA DEL CARMEN', 'CAL. BOLOGNESI NRO 24', '', '', 1, 2, '20103249121', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2182, 'IEI 503 POMALCA', 'KM 5 CARRETERA POMALCA', '', '', 1, 1, '16728297', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2183, 'ELI MUÑOZ MARRUFO', '', '', '', 1, 1, '47405808', 1, 'MICORREO@MAIL.COM', '', 60501, 0, '', 1, NULL, NULL, NULL, 0),
(2184, 'CESAR SANDOVAL VENTURA', '', '', '', 1, 1, '45020181', 1, 'MICORREO@MAIL.COM', '', 130312, 0, '', 1, NULL, NULL, NULL, 0),
(2185, 'LUIS JIMENEZ SALAZAR', '', '', '', 1, 1, '17630614', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(2186, 'NEGOCIOS OMEGA S.R.L', 'CAL. JUAN CUGLIEVAN NRO 1209 CERCADO LAMBAYEQUE', '', '', 1, 2, '20479462390', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2187, 'FRUTOS TONGORRAPE SOCIEDAD ANONIMA', 'FUNDO ALEXANDER NRO SN CPM TONGORRAPE', '', '', 1, 2, '20480325088', 1, 'MICORREO@MAIL.COM', '', 130307, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2188, 'ESTRELLA FERNANDEZ MARIA TERESA', 'CALLE LOS TULIPANES 915 URB CARLOS STEIN INT 1', '', '', 1, 2, '10166632957', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2189, 'BERTHA ELOISA MERA ELORREAGA', 'CASERIO MANO DE LEON', '', '', 1, 2, '10731835034', 1, 'MICORREO@MAIL.COM', '', 130308, 0, '', 1, NULL, NULL, NULL, 0),
(2190, 'AGUINAGA RECUENCO ALMANZOR ALFREDO', '-', '', '', 1, 2, '10166363425', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2191, 'PRO SEMILLAS SOCIEDAD ANONIMA CERRADA', 'CAL. LORA Y CORDERO NRO 137 INT. B URB. EL PORVENIR', '', '', 1, 2, '20480421559', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2192, 'ROYAL BEANS PERU SOCIEDAD ANONIMA CERRADA', 'CAL. VALDIVIEZO NRO 156 URB. LA PRIMAVERA, SEGUNDA ETA', '', '', 1, 2, '20609606577', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2193, 'TROPICAL FOOD INC S.A.C.', 'CAL. DEAN VALDIVIA NRO 207 DEP. 2204 URB. JARDIN', '', '', 1, 2, '20602831222', 1, 'MICORREO@MAIL.COM', '', 10119, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2194, 'IE 11066', 'CENTRO POBLADO SANTA ISABEL - MORROPE', '', '', 1, 1, '16659895', 1, 'MICORREO@MAIL.COM', '', 130306, 0, '', 1, NULL, NULL, NULL, 0),
(2195, 'CTRO DE FORMAC Y PROM HUMANA STA ANGELA', 'CAL. SANTA JUANITA NRO 205 URRUNAGA V SECTOR', '', '', 1, 2, '20438039211', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2196, 'MABEISA S.A.C.', 'CAL. BAGUA NRO 145 URB. JOSE QUIÑONES GONZALES', '', '', 1, 2, '20600525264', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2197, 'COOPERATIVA AGRARIA DE PRODUCTORES DE FRUTAS ORGANICAS OLMOS-CAPOFOL', 'CAL. VICTOR R. HAYA DE LA TORR NRO SN CENTRO OLMOS', '', '', 1, 2, '20608295233', 1, 'MICORREO@MAIL.COM', '', 130308, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2198, 'D?MAN CONSTRUCTORA PRODUCCION & SERVICIOS GENERALES E.I.R.L.', 'PRO. AVENIDA GRAU KM. 3.2', '', '', 1, 2, '20606712350', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2199, 'DIAZ DAVILA DONALD DANNY DAMYLL', '-', '', '', 1, 2, '10471652291', 1, 'MICORREO@MAIL.COM', '', 130308, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2200, 'FRANCISCO DAMIAN LLAUCE', '', '', '', 1, 1, '17603746', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(2201, 'NORTERRA S.A.C', 'AV. SAN FELIPE NRO. 1140 DPTO. 1506 (COSTADO DE LATINA TV) LIMA - LIMA - JESUS MARIA', '', '', 1, 1, '20605571', 1, 'MICORREO@MAIL.COM', '', 140133, 0, '', 1, NULL, NULL, NULL, 0),
(2202, 'ALAMO PISCOYA JORGE LUIS', '-', '', '', 1, 2, '10427094982', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2203, 'BIOGREENPROCESS S.R.L.', 'AV. BOLIVAR NRO 128', '', '', 1, 2, '20602477054', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2204, 'VIMALCA S.A.C.', 'JR. MANOA NRO 617 DEP. 02 URB. CHACRA COLORADA', '', '', 1, 2, '20487789764', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2205, 'ABANTO RAVELO MARISSA ANGELA', 'URB. VILLA AGRARIA F15 NUEVO CHIMBOTE', '', '', 1, 2, '10407141798', 1, 'MICORREO@MAIL.COM', '', 21309, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2206, 'CONSTRUCTORA E INMOBILIARIA NAPOLES S.A.C.', 'CAL. TACNA NRO 648 CERCADO DE CHICLAYO', '', '', 1, 2, '20605337822', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2207, 'SAMILLAN CHIRINOS RAMON', 'PROLONGACION BOLOGNESI 1160 CHICLAYO', '', '', 1, 2, '10164133341', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2208, 'BRENMI EIRL.', 'VIA. SECTOR EL TRANSITO NRO SN C.P. CPM LARAM', '', '', 1, 2, '20480345194', 1, 'MICORREO@MAIL.COM', '', 130106, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2209, 'CORPORACION EDUCATIVA DEL NORTE ESCUELA CUMBRE S.A.C.', 'AV. JOSE E. LORA Y LORA NRO 625 URB. CHICLAYO', '', '', 1, 2, '20480076789', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2210, 'JAIME GARCIA SANCHEZ', '', '', '', 1, 1, '40399402', 1, 'MICORREO@MAIL.COM', '', 190601, 0, '', 1, NULL, NULL, NULL, 0),
(2211, 'INSTITUCION EDUCATIVA N° 10797 MICAELA BASTIDAS - CHICLAYO', 'CAL. CESAR VALLEJO NRO 345 P.J. MICAELA BASTIDAS', '', '', 1, 2, '20602199348', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2212, 'GRUPO AGRODEALS PERÚ SOCIEDAD ANÓNIMA CERRADA', 'PJ. BELAUNDE NRO 254', '', '', 1, 2, '20609737434', 1, 'MICORREO@MAIL.COM', '', 140126, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2213, 'CAMPOS QUINTANA JAIME', '-', '', '', 1, 2, '10174209974', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2214, 'GRABIEL GONZAGA SILVA', '', '', '', 1, 1, '17607308', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2215, 'MI PRIMER HOGAR S.A.C.', 'CAL. LLAUCANO NRO 402 URB. FEDERICO VILLARREAL', '', '', 1, 2, '20608563726', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2216, 'JOSE SANTOS LLATAS CARRERO', '', '', '', 1, 1, '41884547', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(2217, 'MCV EMULCORP E.I.R.L.', 'AV. UNIVERSITARIA NRO 840 INT. 06 URB. PANDO ET. CUATRO', '', '', 1, 2, '20607790371', 1, 'MICORREO@MAIL.COM', '', 20317, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2218, 'CRUZ CRUZ CATALINO', '', '', '', 1, 1, '40357041', 1, 'MICORREO@MAIL.COM', '', 130308, 0, '', 1, NULL, NULL, NULL, 0),
(2219, 'CERAMICOS DEL SOL S.A.C.', 'CAL. JAYANCA NRO 365 URB. VILLA EL SALVADOR', '', '', 1, 2, '20603202580', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2220, 'HBS EDUCACION S.A.C.', 'AV. AUGUSTO B. LEGUIA NRO 420 URB. SAN CARLOS', '', '', 1, 2, '20600133889', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2221, 'LEONARDO LOPEZ ESTHER NILDA', 'LIMON DE PORCUYA', '', '', 1, 2, '10426008691', 1, 'MICORREO@MAIL.COM', '', 190303, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2222, 'SILVATEAM PERU S.A.C.', 'AV. CRNEL FRANCISCO BOLOGNESI NRO 551 URB. LOS FICUS', '', '', 1, 2, '20502435672', 1, 'MICORREO@MAIL.COM', '', 140143, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2223, 'INSTITUTO DE EDUCACION SUPERIOR TECNOLOGICO PUBLICO ENRIQUE LOPEZ ALBUJAR', 'CAL. HAYA DE LA TORRE NRO 214', '', '', 1, 2, '20395096797', 1, 'MICORREO@MAIL.COM', '', 100105, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2224, 'NORTERRA S.A.C.', 'AV. SAN FELIPE NRO 1140 DEP. 1506', '', '', 1, 2, '20605571281', 1, 'MICORREO@MAIL.COM', '', 140133, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2225, 'MUNICIPALIDAD DISTRITAL DE PUEBLO NUEVO', 'CAL. CASIMIRO CHUMAN NRO 517', '', '', 1, 2, '20182126412', 1, 'MICORREO@MAIL.COM', '', 100105, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2226, 'SANTISTEBAN SANCHEZ ANTONIO', 'CALLE SAN ISIDRO #120', '', '', 1, 2, '10457959376', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2227, 'COMPAÑIA MOLINERA SAN CRISTOBAL SOCIEDAD ANONIMA CERRADA', 'CAR. A MOCCE CADAP INT. E C.P.M. LAMBAYEQUE KM. S/N', '', '', 1, 2, '20480586558', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2228, 'LARREA TORRES BLANCA TEREZA', 'COIS 507', '', '', 1, 2, '10761690006', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2229, 'I.E. DE BIEN SOCIAL ELSA GMEINER', 'CAL. PARIS NRO 273 UPIS CESAR VALLEJO', '', '', 1, 2, '20602298451', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2230, 'FABRICACIONES METALICAS Y SERVICIOS RG S.A.C.  - FAMESERVI S.A.C.', 'MZA. E-5 LOTE 7 Z.I. PARQUE INDUSTRIAL', '', '', 1, 2, '20601755476', 1, 'MICORREO@MAIL.COM', '', 60904, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2231, 'INTERAMERICANA NORTE S.A.C.', 'INT. . MZA. 240 LOTE 02 Z.I. ANTIGUA DE PIURA', '', '', 1, 2, '20483998270', 1, 'MICORREO@MAIL.COM', '', 190101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2232, 'PLAZA NORTE CHICLAYO SRL.', 'AV. AUGUSTO B. LEGUIA NRO 2590 URB. EL INGENIERO II', '', '', 1, 2, '20487796892', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2233, 'INVERSIONES Y NEGOCIOS HARO E.I.R.L.', 'MZA. J LOTE 10 URB. LAS GARDENIAS', '', '', 1, 2, '20610073442', 1, 'MICORREO@MAIL.COM', '', 140901, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2234, 'GRUPO INMOBILIARIO REY DE REYES S.A.C.', 'CAL. JUAN RIVERA PIEDRA NRO 145 URB. ARTURO CABREJOS FALLA', '', '', 1, 2, '20607604631', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2235, 'STOCKTON PERU S.A.C.', 'JR. CARLOS CUETO FERNANDINI NRO 435 URB. COVIMA', '', '', 1, 2, '20523720971', 1, 'MICORREO@MAIL.COM', '', 140110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2236, 'LARREA ALVARADO MAX HENRY', 'ELVIRA GARCIA Y GARCIA 430', '', '', 1, 2, '10167042258', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2237, 'DAMERU SERVICIOS INMOBILIARIOS S.A.C.', 'JR. JUNIN NRO 939 OTR. .', '', '', 1, 2, '20609395355', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2238, 'JITSSÓN ANDREY GALLO PORRAS', '', '', '', 1, 1, '72468591', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2239, 'MORALES TORRES EDELMIRA', '-', '', '', 1, 2, '10164919523', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2240, 'G & B MOLINOS S.A.C', 'CAR. PANAMERICANA NORTE LOTE A-10 KM. 775', '', '', 1, 2, '20479403113', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2241, 'LOS TRES RIOS SERVICIOS GENERALES SOCIEDAD COMERCIAL DE RESPONSABILIDAD LIMITADA', 'JR. MARIANO MELGAR NRO 191 URB. JOSE SABOGAL', '', '', 1, 2, '20495950850', 1, 'MICORREO@MAIL.COM', '', 60101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2242, 'PESQUERA CONCEPCION S.A.C.', 'AV. RIVERA NAVARRETE NRO 395', '', '', 1, 2, '20609395541', 1, 'MICORREO@MAIL.COM', '', 140124, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2243, 'AGRICOLA SINAI S.A.C', 'AV. JORGE CHAVEZ NRO 1420 P.J. ATUSPARIAS', '', '', 1, 2, '20608576127', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2244, 'MACH CONTRATISTAS E.I.R.L.', 'CAL. LOS JACARANDAS NRO 358 DEP. 301 URB. SANTA VICTORIA', '', '', 1, 2, '20608833464', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2245, 'CONSORCIO EDUCATIVO LA INMACULADA EMPRESA INDIVIDUAL DE RESPONSABILIDAD LIMITADA', 'CAL. MANUEL MARIA IZAGA NRO 816 CERCADO DE CHICLAYO', '', '', 1, 2, '20201018812', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2246, 'INVERSIONES FUNDO VERDE E.I.R.L.', 'MZA. K LOTE 21A A.H. NAVIDAD DE VILLA', '', '', 1, 2, '20606968508', 1, 'MICORREO@MAIL.COM', '', 140108, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2247, 'MATILDE MIO SOPLOPUCO', '', '', '', 1, 1, '17605762', 1, 'MICORREO@MAIL.COM', '', 130308, 0, '', 1, NULL, NULL, NULL, 0),
(2248, 'RIGOBERTO ROSAS SEMINARIO', '', '', '', 1, 1, '2867215', 1, 'MICORREO@MAIL.COM', '', 190109, 0, '', 1, NULL, NULL, NULL, 0),
(2249, 'NELSI YULISA VELASCO PEÑA', '', '', '', 1, 1, '47735716', 1, 'MICORREO@MAIL.COM', '', 61101, 0, '', 1, NULL, NULL, NULL, 0),
(2250, 'CENTRO INTEGRAL DE MEJORAMIENTO ACADEMICO SOCIEDAD ANONIMA CERRADA', 'CAL. ALFONSO UGARTE NRO 640 URB. CERCADO DE CHICLAYO', '', '', 1, 2, '20479482153', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2251, 'MARCO ANTONIO', '', '', '', 1, 1, '71243709', 1, 'MICORREO@MAIL.COM', '', 130308, 0, '', 1, NULL, NULL, NULL, 0),
(2252, 'GONZALO ECAN LLAUCE', '', '', '', 1, 1, '17624976', 1, 'MICORREO@MAIL.COM', '', 130309, 0, '', 1, NULL, NULL, NULL, 0),
(2253, 'MERCURY INDUSTRIAS', '', '', '', 1, 3, '', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2254, 'CONSORCIO CISSAC SCANDER SAC', 'AV. LA ENCALADA INT. 803 MZA. I-2 LOTE REFF URB. C.C. MONTERRICO', '', '', 1, 2, '20601676622', 1, 'MICORREO@MAIL.COM', '', 140130, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2255, 'EJGIZU BUSINESS S.A.C.', 'AV. VICTOR RAUL HAYA DE LA TO NRO 1016 URB. LA VICTORIA SC. CUATRO', '', '', 1, 2, '20606439726', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2256, 'CUEVA GIL DENIS ROBERT', '-', '', '', 1, 2, '10467207127', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2257, 'RAMON REYES LIVIA', '', '', '', 1, 1, '16664152', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(2258, 'ASOCIACION AGRARIA EDUCAZA', 'NRO S/N CAS. EL TRIGAL', '', '', 1, 2, '20610367853', 1, 'MICORREO@MAIL.COM', '', 61013, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2259, 'ITURRI AGENTE PORTUARIO S.A.C.', 'ESQ. CORDOVA Y LA RIVERA NRO S/N', '', '', 1, 2, '20559995623', 1, 'MICORREO@MAIL.COM', '', 120105, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2260, 'MIO MAYANGA PEDRO', '-', '', '', 1, 2, '10429807102', 1, 'MICORREO@MAIL.COM', '', 130308, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2261, 'SERVICIOS CHICLAYO SERVICIX E.I.R.L.', 'PJ. RIO CUMBIL NRO 150 INT. B URB. FEDERICO VILLARREAL', '', '', 1, 2, '20608972588', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2262, 'CONSORCIO ELECTRICO DE VILLACURI SAC', 'CAR. PANAM.SUR NRO 274 VALLE DE VILLACURI', '', '', 1, 2, '20178344952', 1, 'MICORREO@MAIL.COM', '', 100106, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2263, 'CENTRO DE CAPACITACION PREVENCION Y PROTECCION EN SEGURIDAD INDUSTRIAL Y COMERCIAL LOS ANGELES SAC', 'AV. JOSE E.LORA Y LORA NRO 1240 URB. LA PRIMAVERA I ETAPA FAP', '', '', 1, 2, '20480269315', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2264, 'JORGE MONJA PISCOYA', '', '', '', 1, 1, '17632131', 1, 'MICORREO@MAIL.COM', '', 130308, 0, '', 1, NULL, NULL, NULL, 0),
(2265, 'CRISTOBAL', '', '', '', 1, 1, '16773510', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(2266, 'ELORREAGA CORREA DAVID MOISES', 'AV. JOSÉ MERCEDES ANTEPARRA 104/ MOTUPE', '', '', 1, 2, '10412836036', 1, 'MICORREO@MAIL.COM', '', 130307, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2267, 'NEOTEK CONSTRUCTORA Y CONSULTORA S.A.C.', 'AV. SAENZ PEÑA NRO 872', '', '', 1, 2, '20480762623', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2268, 'VALLADARES LOPEZ RAFAEL ANTONIO', '-', '', '', 1, 2, '10321286084', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2269, 'IGLESIA  CRISTIANA PENTECOSTES DEL  PERU MOVIMIENTO MISIONERO MUNDIAL', 'CAL. HORACIO CACHAY DIAZ NRO 399 URB. SANTA CATALINA', '', '', 1, 2, '20338877103', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2270, 'JUAN BENITES SOPLAPUCO', 'MOTUPE', '', '', 1, 1, '17570846', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2271, 'CORPORACION MAPAH S.A.C.', 'CAL. T VALCARCEL NRO 589 URB. PRIMAVERA', '', '', 1, 2, '20445471551', 1, 'MICORREO@MAIL.COM', '', 120101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2272, 'A & S AGRO Y RIEGO S.R.L.', 'CAL. 107 MZA. M-3 LOTE 08 URB. SANTA LUZMILA', '', '', 1, 2, '20609174502', 1, 'MICORREO@MAIL.COM', '', 140106, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2273, 'CORPRO AC S.A.C.', 'CAL. ADAN ACEVEDO NRO 400', '', '', 1, 2, '20603821298', 1, 'MICORREO@MAIL.COM', '', 30506, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2274, 'QUESQUEN INGENIEROS S.A.C.', 'PRO. LIBERTAD NRO 98 BAR. YANCE', '', '', 1, 2, '20602475981', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2275, 'ESTACION DE SERVICIOS EVE ENERGY PLUS S.R.L.', 'CAL. SAN ISIDRO NRO 158 URB. SAN LORENZO', '', '', 1, 2, '20608594788', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2276, 'NOLBERTO CARO NOLASCO', '', '', '', 1, 1, '42083276', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(2277, 'IGLESIA ALIANZA CRISTIANA Y MISIONERA DEL PERU - IACYM PERU', 'PRO. CAYETANO HEREDIA NRO 151 URB. ISLA VERDE', '', '', 1, 2, '20147802545', 1, 'MICORREO@MAIL.COM', '', 20707, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2278, 'MULTISERVICIOS VLY E.I.R.L.', 'CAR. CARRETERA A PIMENTEL C.P. LAS PAMPAS KM. 7', '', '', 1, 2, '20608505629', 1, 'MICORREO@MAIL.COM', '', 130110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2279, 'CRUZADO NAZARIO SAUL', '-', '', '', 1, 2, '10165228427', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2280, 'D & L CONTROLPEST S.A.C.', 'OTR. ASOC. SANTA ROSA LOS AQUI MZA. U LOTE 8 C.P. PARIÑA CHICO', '', '', 1, 2, '20609370867', 1, 'MICORREO@MAIL.COM', '', 100103, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2281, 'AMERICAN INKA HOTEL SAUNA SPA S.A.C.', 'AV. SIMON BOLIVAR NRO 575 CERCADO', '', '', 1, 2, '20561211451', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2282, 'LA MOLINA EXPORT S.A.C.', 'CAL. LOS TALLANES MZA. F LOTE 4 DEP. 302 URB. LAS PALMAS DEL GOLF II', '', '', 1, 2, '20605660241', 1, 'MICORREO@MAIL.COM', '', 120107, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2283, 'FUERZA AREA', '', '', '', 1, 1, '16790810', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(2284, 'LIMA MOTOR S.R.L.', 'AV. LEGUIA NRO 500 CPME URRUNAGA', '', '', 1, 2, '20531497741', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2285, 'MUNICIPALIDAD DEL CENTRO POBLADO MENOR DE INSCULAS', 'NRO SN CENT. POBLADO DE INSCULAS', '', '', 1, 2, '20480705824', 1, 'MICORREO@MAIL.COM', '', 130308, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2286, 'CARLOS ÓSCAR SAMAME QUIROZ', '', '', '', 1, 1, '45750522', 1, 'MICORREO@MAIL.COM', '', 60902, 0, '', 1, NULL, NULL, NULL, 0),
(2287, 'TRANSPORTES Y SERVICIOS GENERALES BALTODANO SAC', 'MZA. G LOTE 11 URB. SAN ISIDRO', '', '', 1, 2, '20481694656', 1, 'MICORREO@MAIL.COM', '', 120101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2288, 'SERVICIOS GENERALES ELECTROMECANICO Y ELECTRONICOS S.A.C.', 'MZA. M LOTE 13 DEP. 303 URB. CASTILLA DE ORO', '', '', 1, 2, '20600203526', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2289, 'AYALA SANCHEZ MERITO', '-', '', '', 1, 2, '10176182810', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2290, 'CORPORACION ASFALTOS Y PAVIMENTOS CASTILLO S.A.C.', 'AV. GENERAL ALVAREZ DE ARENAL NRO 931 DEP. 302 URB. SANTA BEATRIZ', '', '', 1, 2, '20314028164', 1, 'MICORREO@MAIL.COM', '', 10505, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2291, 'ASOCIACION DE PRODUCTORES AGROPECUARIOS EL LIRIO DE PROGRESO-PROGRESO-PATAPO-CHICLAYO-LAMBAYEQUE', 'MZA. C LOTE 01 SEC. RURAL PROGRESO', '', '', 1, 2, '20606939729', 1, 'PRESIDENTE BEYMER BUSTAMANTE AZOLA', 'PRESIDENTE BEYMER BUSTAMANTE AZOLA', 130117, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2292, 'MARINA DE GUERRA DEL PERU', 'AV. LA MARINA CDRA 36 NRO SN CUARTE LA PERLA', '', '', 1, 2, '20153408191', 1, 'MICORREO@MAIL.COM', '', 240105, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2293, 'AGROTRANSPORTES NOVO E.I.R.L.', 'JR. TACNA NRO 1058 OTR. JR TACNA', '', '', 1, 2, '20608943189', 1, 'MICORREO@MAIL.COM', '', 190401, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2294, 'FERNANDEZ-DAVILA ABOGADOS S.A.C', 'AV. CIRCUNVALACIÓN DEL CLUB G NRO 208 INT. 705B URB. CLUB GOLF LOS INCAS', '', '', 1, 2, '20510033494', 1, 'MICORREO@MAIL.COM', '', 140130, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2295, 'I.E.N 11517', 'AV. MICAELA BASTIDAS NRO SN CENTRO TUMAN', '', '', 1, 2, '20602087957', 1, 'MICORREO@MAIL.COM', '', 130120, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2296, 'RINTI S A', 'AV. NICOLAS AYLLON-C.CENTRAL FND. PARIACHI KM. 17.5', '', '', 1, 2, '20100617332', 1, 'MICORREO@MAIL.COM', '', 21303, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2297, 'ASOCIACION DE TRABAJADORES UNIDOS SOL DE OLMOS', 'MZA. A SERUR EL PORVENIR', '', '', 1, 2, '20603991177', 1, 'MICORREO@MAIL.COM', '', 130308, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2298, 'JESSICA MARICELA CORTEZ SALAZAR', '', '', '', 1, 1, '7511830', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(2299, 'FUENTES SOLIS JUAN FLORENCIO', '-', '', '', 1, 2, '10174483014', 1, 'MICORREO@MAIL.COM', '', 130201, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2300, 'INSTITUCION EDUCATIVA PRIVADA FREDERICK SANGER SRL', 'MZA. B LOTE 15 URB. LOS JAZMINES', '', '', 1, 2, '20479996939', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2301, 'MARIANO ESQUEN CHEVEZ', '', 'CHICLAYO', '', 1, 1, '16491411', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2302, 'AMBIENTE ECOLOGICO CORPORATIVO S.A.C. -  AMBECORP', 'PJ. SAN FELIPE NRO 121 URB. CASA HUERTA', '', '', 1, 2, '20602391656', 1, 'MICORREO@MAIL.COM', '', 140131, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2303, 'COMPLEJO AGROINDUSTRIAL BETA S.A.', 'CAL. LEOPOLDO CARRILLO NRO 160', '', '', 1, 2, '20297939131', 1, 'MICORREO@MAIL.COM', '', 100201, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2304, 'CADENILLAS SANCHEZ ABELARDO', 'LOS CLAVELES 161 URB LOS ROSALES - CHICLAYO', '', '', 1, 2, '10164576677', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2305, 'OBREGON AVILA CELESTINO', 'AV FRANCISCO VIDAL 659 SUPE PUEBLO', '', '', 1, 2, '10157017883', 1, 'MICORREO@MAIL.COM', '', 140901, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2306, 'TERRA HOUSE INVERSIONES S.R.L.', 'PJ. JULIA ULSEN NRO 150 INT. 2DO URB. LOS PRECURSORES', '', '', 1, 2, '20608260006', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2307, 'SILVA PAREDES WILMER', '-', '', '', 1, 2, '10410222235', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2308, 'HUMBERTO DAVID GOMEZ ZABA', '', '', '', 1, 1, '45455926', 1, 'MICORREO@MAIL.COM', '', 190801, 0, '', 1, NULL, NULL, NULL, 0),
(2309, 'BALTAZAR SUCLUPE VALDERA', '', '', '', 1, 1, '17558249', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(2310, 'LACUNZA BALAREZO ROBERTO MARIO', '-', '', '', 1, 2, '10400704363', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2311, 'RUIZ ROJAS WILSO WILMER', 'PUEBLO NUEVO', '', '', 1, 2, '10434698109', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2312, 'EMPRESA DE TRANSPORTES MORROPE DEL NORTE TOURS E.I.R.L.', 'OTR. SAN MANUEL NRO SN ANEXO', '', '', 1, 2, '20610887105', 1, 'MICORREO@MAIL.COM', '', 130306, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2313, 'V & M CONSTRUCTORA Y FERROCENTRO S.A.C.', 'CAL. ATAHUALPA NRO SN OTR. CERCADO PIMENTEL', '', '', 1, 2, '20607677396', 1, 'MICORREO@MAIL.COM', '', 130110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2314, 'SERVICIOS ESPECIALES UNION EIRL', 'AV. RAMON CASTILLA NRO 370A', '', '', 1, 2, '20437710946', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2315, 'MENDOZA REQUEJO FRANCO RUBEN', '-', '', '', 1, 2, '10407691828', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2316, 'DEMETRIO HERRERA VASQUEZ', '', '', '', 1, 1, '27275300', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2317, 'AGROIMPORT CORONEL EIRL', 'AV. HEROES DEL CENEPA NRO 1600 URB. BAGUA', '', '', 1, 2, '20610420461', 1, 'MICORREO@MAIL.COM', '', 10205, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2318, 'LEONIDAS PORTAL PARDO', '', '', '', 1, 1, '42506096', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(2319, 'FLORENCIO LAVADO MACHADO', '', '', '', 1, 3, '', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2320, 'AGRICOLA CAMPO NUEVO E.I.R.L.', 'CAL. ELIAS AGUIRRE NRO S/N', '', '', 1, 2, '20605462821', 1, 'MICORREO@MAIL.COM', '', 130119, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2321, 'SANCHEZ SERRATO JHONY', 'CAMPIÑA SAN CRISTOBAL / OLMOS -LAMBAYEQUE', '', '', 1, 2, '10429346415', 1, 'MICORREO@MAIL.COM', '', 130308, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2322, 'R & M CONTRATISTAS SOCIEDAD ANONIMA CERRADA', 'CAL. 21 MZA. L LOTE 06 URB. APV COMP.TERREN.DE CAMPOY', '', '', 1, 2, '20509186961', 1, 'MICORREO@MAIL.COM', '', 140137, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2323, 'RAMOS ELIAS JOSE MANUEL', '-', '', '', 1, 2, '10439297200', 1, 'MICORREO@MAIL.COM', '', 190101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2324, 'PROYECTOS Y DECORACIONES ESTELA E.I.R.L. - PRODESTEL E.I.R.L.', 'AV. MARISCAL MILLER NRO 1601', '', '', 1, 2, '20536443763', 1, 'MICORREO@MAIL.COM', '', 140111, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2325, 'AURITA ROSITA FABIOLA NAMUCHE', '', '', '', 1, 1, '72876088', 1, 'MICORREO@MAIL.COM', '', 190106, 0, '', 1, NULL, NULL, NULL, 0),
(2326, 'AGROVETERINARIA MENDOZA S.A.C.', 'CAL. JOHN FITZGERALD KENNEDY NRO 330 URB. CORONEL FRANCISCO BOLOGNE', '', '', 1, 2, '20480018827', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2327, 'DISTRIBUCIONES AGROMOTOR S E.I.R.L', 'CAL. LAMBAYEQUE NRO 115 URB. JOSE LEONARDO ORTIZ', '', '', 1, 2, '20608156071', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2328, 'IMPORTADORA Y EXPORTADORA WORLD COMMERCE SOCIEDAD ANONIMA CERRADA', 'MZA. B LOTE 07 P.J. LA RINCONADA', '', '', 1, 2, '20605465995', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2329, 'CORPORACION C Y D BURGOS S.A.C.', 'CAL. AUGUSTO B LEGUIA NRO 475', '', '', 1, 2, '20610618091', 1, 'MICORREO@MAIL.COM', '', 130308, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2330, 'ROMERO MALDONADO LUIS MIGUEL', 'ELIAS AGUIRRE 388', '', '', 1, 2, '15480391893', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2331, 'DANI DANIEL BENAVIDEZ JUNCO', '', '', '', 1, 1, '42467132', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(2332, 'RENATO WILKIE CHUÑE PAICO', '', '', '', 1, 1, '16730807', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2333, 'GOBIERNO REGIONAL LAMBAYEQUE', 'AV. JUAN TOMIS STACK KM. 4.5', '', '', 1, 2, '20479569780', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0);
INSERT INTO `cliente` (`codigo_cli`, `nombre_cli`, `direccion_cli`, `ciudad_cli`, `telefono_cli`, `codigo_tip`, `codigo_doc`, `numero_doc`, `codigo_szo`, `email_cli`, `observacion_cli`, `codigo_dis`, `estadosunat_cli`, `condicionsunat_cli`, `estado_cli`, `usuario_reg`, `usuario_mod`, `fecha_mod`, `sistema`) VALUES
(2334, 'AUTOMATED SYSTEMS IN INDUSTRIAL PROCESSES S.A.C.', 'CAL. ATAHUALPA NRO 480', '', '', 1, 2, '20601024447', 1, 'MICORREO@MAIL.COM', '', 130307, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2335, 'DIAZ CIEZA JOSE JAIME', '-', '', '', 1, 2, '10463894308', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2336, 'GELACI LARIOS JUAN', '', '', '', 1, 1, '47934209', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2337, 'JOSE EUSEBIO ECIOSUP QUESQUEN', '', '', '', 1, 1, '16620644', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(2338, 'DELIFE CONSULTORIA Y PROYECTOS S.R.L.', 'MZA. A LOTE 8 C.P. SANTA MARIA', '', '', 1, 2, '20602977910', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2339, 'AVICOLAMB E.I.R.L.', 'CAL. TACNA NRO 1050', '', '', 1, 2, '20611350482', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2340, 'SANDOVAL BANCES JANETH DEL ROCIO', 'CAL LOS JARDINEZ  CP LOS POCITOS', '', '', 1, 2, '10445196334', 1, 'MICORREO@MAIL.COM', '', 130306, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2341, 'GARDO REPRES.CONSTR. Y SERV.GENERAL.EIRL', 'CAL. CAJAMARCA NRO 270 Z.I. PATAZCA', '', '', 1, 2, '20479476935', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2342, 'COMERCIALIZADORA B & C ASOCIADOS E.I.R.L.', 'PJ. SIN NOMBRE MZA. C LOTE 02 A.H. LUIS PARDO', '', '', 1, 2, '20603833873', 1, 'MICORREO@MAIL.COM', '', 20102, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2343, 'JOSE GENOVES MONTENEGRO AYASTA', '', '', '', 1, 1, '27742884', 1, 'MICORREO@MAIL.COM', '', 60808, 0, '', 1, NULL, NULL, NULL, 0),
(2344, 'ROCA FORTE CONSULTORES Y EJECUTORES S.R.L.', 'CAL. LAS CAMPANILLAS NRO 260 P.J. LA PRIMAVERA', '', '', 1, 2, '20600054725', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2345, 'DMAN CONSTRUCTORA PRODUCCION & SERVICIOS GENERALES E.I.R.L.', 'PRO. AVENIDA GRAU KM. 3.2', '', '', 1, 2, '20606712350', 1, 'MICORREO@MAIL.COM', '', 130115, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2346, 'DINAMYC CENTER SOCIEDAD ANONIMA CERRADA', 'CAR. PANAMERICANA NORTE URB. NOR ORIENTE KM. 3.5', '', '', 1, 2, '20603313691', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2347, 'FIBRAUNION DHR S.A.C.', 'AV. FRANCISCO FLORES MZA. 35 LOTE 3', '', '', 1, 2, '20604376514', 1, 'MICORREO@MAIL.COM', '', 40405, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2348, 'HUERTAS NAVARRO MARCIA GERALDINE', 'CALLE FAUSTINO SARMIENTO 175 175', '', '', 1, 2, '10480219274', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2349, 'NEPTALI GUEVARA TORRES', '', '', '', 1, 1, '16670675', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2350, 'HUAMAN TAPIA EDILBERTO', '-', '', '', 1, 2, '10452895183', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2351, 'CABALLERO NEGRO EIRL', 'AV. JAEN NRO 502', '', '', 1, 2, '20480606257', 1, 'MICORREO@MAIL.COM', '', 60806, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2352, 'GAMARRA ESTELA ERY DANIEL', '-', '', '', 1, 2, '10740726591', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2353, 'EUGENIO TORRES DAVILA', '', '', '', 1, 1, '27283305', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2354, 'CUIS PERUVIAN S.A.C', 'INT. -- MZA. -- LOTE -- DEP. -- CAS. MALCAS - PUERTO SIERRA KM. --', '', '', 1, 2, '20491800802', 1, 'MICORREO@MAIL.COM', '', 60203, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2355, 'HERRERA LUCUMI PAMELA LISSETH', '-', '', '', 1, 2, '10700791039', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2356, 'AGROPIMA PERU SAC', '', '', '', 1, 3, '', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(2357, 'NORT PARTS MULTILLANTAS Y SERVICIOS GENERALES E.I.R.L.', 'AV. AUGUSTO B. LEGUIA NRO 2625 URB. MIRAFLORES', '', '', 1, 2, '20600017412', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2358, 'JULIO HUIMAN YARLEQUE', '', '', '', 1, 1, '2812447', 1, 'MICORREO@MAIL.COM', '', 190104, 0, '', 1, NULL, NULL, NULL, 0),
(2359, 'RAMIRO GONZALES RAMO', '', '', '', 1, 1, '16795345', 1, 'MICORREO@MAIL.COM', '', 130112, 0, '', 1, NULL, NULL, NULL, 0),
(2360, 'ARIS INDUSTRIAL S.A.', 'AV. INDUSTRIAL NRO 491 Z.I. LIMA INDUSTRIAL', '', '', 1, 2, '20100257298', 1, 'MICORREO@MAIL.COM', '', 140101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2361, 'INMOBILIARIA NOVATERRA ASOCIADOS S.A.C.', 'CAL. MANUEL MARIA IZAGA NRO 600 CERCADO DE CHICLAYO', '', '', 1, 2, '20606541482', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2362, 'ASOCIACION DE PRODUCTORES AGROPECUARIOS MI PERU GRANDIOSO DE TAMBO REAL - TAMBO REAL - CP. BATAN GRA', 'CAL. INDEPENDENCIA MZA. I LOTE 4 CAS. BATAN GRANDE', '', '', 1, 2, '20611109793', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2363, 'EXPORTACIONES PACHACUTEC SAC', 'ARICA NRO 515', '', '', 1, 2, '20604250324', 1, 'MICORREO@MAIL.COM', '', 140901, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2364, 'INMOBILIARIA Y CONSTRUCTORA HOUSE SELECT S.A.C', 'CAL. COMANDANTE JOSE TORRES PA NRO 722 CERCADO DE CHICLAYO', '', '', 1, 2, '20608968203', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2365, 'AGROINDUSTRIAS FRUTOS SICAN S.A.C.', 'CAL. ATAHUALPA NRO 718 P.J. GARCES', '', '', 1, 2, '20608831275', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2366, 'J & M SOBRINO INVERSIONES GENERALES SOCIEDAD COMERCIAL DE RESPONSABILIDAD LIMITADA', 'JR. TUMBES NRO 1370 A.H. BUENOS AIRES', '', '', 1, 2, '20603365896', 1, 'MICORREO@MAIL.COM', '', 190109, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2367, 'FRANCO QUISPE PABLITO ALEXANDER', '-', '', '', 1, 2, '10448457007', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2368, 'HERBERT AUGUSTO BARCO PAIMA', '', '', '', 1, 1, '7442737', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2369, 'AGROINDUSTRIAS LOS ROMERALES E.I.R.L.', 'CAL. TAHUANTINSUYO NRO 641 URB. SAN CARLOS', '', '', 1, 2, '20488027451', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2370, 'FAYA ESCURRA RONALD', '-', '', '', 1, 2, '10411357061', 1, 'MICORREO@MAIL.COM', '', 130307, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2371, 'INSTITUCIÓN EDUCATIVA N° 10181 CÉSAR A. VALLEJO MENDOZA', 'NRO SN CAS. LA ESTANCIA', '', '', 1, 2, '20609341735', 1, 'MICORREO@MAIL.COM', '', 130308, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2372, 'SAMILLAN FERNANDEZ PAUL HENRRY', 'CALLE FE Y ALEGRIA 476', '', '', 1, 2, '10410533991', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2373, 'ALEJANDRO ROBERT GALLO MIO', '', '', '', 1, 1, '44465583', 1, 'MICORREO@MAIL.COM', '', 130308, 0, '', 1, NULL, NULL, NULL, 0),
(2374, 'RC 10 PROYECTOS ESTRUCTURALES S.A.C.', 'JR. EL PEDREGAL NRO 423 URB. SAN CARLOS', '', '', 1, 2, '20565345631', 1, 'MICORREO@MAIL.COM', '', 140137, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2375, 'GRUPO ROMANO SOCIEDAD ANONIMA CERRADA', 'AV. CORONEL FRANCISCO BOLOGNE NRO 466 CERCADO DE CHICLAYO', '', '', 1, 2, '20604804168', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2376, 'INVERSIONES Y DISTRIBUCIONES ROFE S.A.C.', 'CAR. PIMENTEL OTR. QUINTA LA PONDEROSA KM. 5', '', '', 1, 2, '20609524732', 1, 'MICORREO@MAIL.COM', '', 130110, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2377, 'JUAN RODRIGUEZ URCIA', '', '', '', 1, 1, '16600769', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2378, 'COLEGIO DE INGENIEROS DEL PERU-CONSEJO DEPARTAMENTAL DE LAMBAYEQUE', 'AV. J. BALTA NRO 581', '', '', 1, 2, '20184861217', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2379, 'RAMIRO ALEJANDRIA LEON', '', '', '', 1, 1, '75777323', 1, 'MICORREO@MAIL.COM', '', 130307, 0, '', 1, NULL, NULL, NULL, 0),
(2380, 'INVERSIONES SILFER S.A.C', 'OTR. CORRAL DE ARENA MZA. A SEC. RURAL', '', '', 1, 2, '20611269871', 1, 'MICORREO@MAIL.COM', '', 130308, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2381, 'CORPORACION CERDAN E.I.R.L.', 'AV. VENEZUELA NRO S/N C.P. SALAMANCA', '', '', 1, 2, '20602831982', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2382, 'IDALUZ CRAMBER SANCHEZ DE RAMIREZ', 'NUEVA ARICA', '', '', 1, 1, '16689303', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(2383, 'BARBOZA ALCANTARA ENRIQUE', '-', '', '', 1, 2, '10166135899', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2384, 'EL ALISO SERVICIOS GENERALES SRL', 'PJ. EL MUTUY MZA. B LOTE 10 URB. SAN ROQUE', '', '', 1, 2, '20453849008', 1, 'MICORREO@MAIL.COM', '', 60101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2385, 'SERVICIOS SANTA GABRIELA S.A.C.', 'MZA. F LOTE 9-A URB. LA ARBOLEDA', '', '', 1, 2, '20439424177', 1, 'MICORREO@MAIL.COM', '', 120101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2386, 'INKAGRO PERU S.A.C. - INKAGRO', 'JR. LEONCIO PRADO NRO 543', '', '', 1, 2, '20605188533', 1, 'MICORREO@MAIL.COM', '', 10701, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2387, 'AGRONEGOCIOS NORTE SOL E.I.R.L.', 'AV. JOHN  F KENNEDY NRO 553 URB. BOLOGNESI', '', '', 1, 2, '20611009497', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2388, 'INVERSIONES ZUBER S.A.C.', 'AV. CARABAYLLO NRO 138 URB. EL PARRAL', '', '', 1, 2, '20604220531', 1, 'MICORREO@MAIL.COM', '', 140106, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2389, 'INGENIEROS CONSULTORES Y EJECUTORES QUINTANA S.R.L.', 'JR. DIEGO VILLACORTA NRO 230', '', '', 1, 2, '20600964411', 1, 'MICORREO@MAIL.COM', '', 60601, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2390, 'PABLO CÉSAR BENITES TORRES', '', '', '', 1, 1, '47903338', 1, 'MICORREO@MAIL.COM', '', 130101, 0, '', 1, NULL, NULL, NULL, 0),
(2391, 'CHAMBA RIVERA WILSON', '-', '', '', 1, 2, '10435805201', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2392, 'CORPORACION MADERERA FERPESI SOCIEDAD ANONIMA CERRADA', 'CAL. TAHUANTINSUYO NRO 1400 DEP. 101 URB. SAN LORENZO', '', '', 1, 2, '20484314617', 1, 'MICORREO@MAIL.COM', '', 130112, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2393, 'LUVISA INGENIEROS E.I.R.L.', 'MZA. 29 LOTE 8 URB. LA PURISIMA', '', '', 1, 2, '20603184026', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2394, 'OSCAR GILBER ALVARADO MENDOZA', '', '', '', 1, 1, '47017184', 1, 'MICORREO@MAIL.COM', '', 120903, 0, '', 1, NULL, NULL, NULL, 0),
(2395, 'GREEN SPROUT S.A.C.', 'NRO SN CAS. PAMPA DE LINO', '', '', 1, 2, '20611112727', 1, 'MICORREO@MAIL.COM', '', 130304, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2396, 'CUBAS RUIZ JORGE NAPOLEON', 'AV. MARISCAL CACERES 090 URB MARIA DE LOS ANGELES  307- CHICLAYO', '', '', 1, 2, '10166241141', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2397, 'CONSORCIO PINCEL', 'PRO. BACA MATTOS MZA. A LOTE 15 URB. SAN FRANCISCO', '', '', 1, 2, '20611846372', 1, 'MICORREO@MAIL.COM', '', 130301, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2398, 'JUNTA DE USUARIOS DEL SECTOR HIDRAULICO ZAÑA', 'CAL. SIETE DE JUNIO NRO 0697 CIUDAD DE ZANA', '', '', 1, 2, '20195979201', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2399, 'CONSORCIO EJECUTOR MOCHUMI II', 'CAL.ESPAÑA NRO. 1783 LAMBAYEQUE - CHICLAYO - JOSE LEONARDO ORTIZ', '', '', 1, 2, '20611742208', 1, 'MICORREO@MAIL.COM', '', 130112, 0, '', 1, NULL, NULL, NULL, 0),
(2400, 'SERVICIOS Y MAQUINARIAS R & C S.A.C.', 'CAL.LAS CUCARDAS MZA. Z LOTE. 3 URB. LAS PALMAS DEL GOLF LA LIBERTAD - TRUJILLO - VICTOR LARCO HERRERA', '', '', 1, 2, '20481045411', 1, 'MICORREO@MAIL.COM', '', 120101, 0, '', 1, NULL, NULL, NULL, 0),
(2401, 'MANUEL VIDAURRE VENTURA', '', '', '', 1, 1, '10675035', 1, 'MICORREO@MAIL.COM', '', 130306, 0, '', 1, NULL, NULL, NULL, 0),
(2402, 'PROYECTOS LA SELVA S.R.L.', 'CAL. FRANCISCO CUNEO NRO 570 DEP. 301 URB. CHICLAYO', '', '', 1, 2, '20480177623', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2403, 'LA ALTEÑA PERU S.A.C.', 'AV. CIRCUNVALACION CLUB GOLF NRO 208 INT. 901A URB. CLUB GOLF LOS INCAS', '', '', 1, 2, '20609199335', 1, 'MICORREO@MAIL.COM', '', 140130, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2404, 'AGROINDUSTRIA FLORENCE SAC', 'AV. VENEZUELA NRO 858 DEP. 701 URB. CHACRA COLORADA', '', '', 1, 2, '20607875660', 1, 'MICORREO@MAIL.COM', '', 10101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2405, 'CAJO ALVARADO LUIS ANGEL', '-', '', '', 1, 2, '10174303571', 1, 'MICORREO@MAIL.COM', '', 130101, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2406, 'LLATAS ROJAS LUCIANO HUMBERTO', '-', '', '', 1, 2, '10272772113', 1, 'MICORREO@MAIL.COM', '', 130102, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2407, 'JUANA RODRIGUEZ DE CARCIA', '', '', '', 1, 1, '17570033', 1, 'MICORREO@MAIL.COM', '', 130301, 0, '', 1, NULL, NULL, NULL, 0),
(2408, 'MARKET AGRICOLA PERU S.A.C.', 'JR. LOS BAMBUES MZA. B LOTE 7', '', '', 1, 2, '20603023057', 1, 'MICORREO@MAIL.COM', '', 140142, 0, 'HABIDO', 1, NULL, NULL, NULL, 0),
(2422, '** A N U L A D O**', '', '', '', 1, 1, '', 1, 'mvilchezt@gmail.com', '', 130308, 0, 'HABIDO', 1, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra`
--

CREATE TABLE `compra` (
  `codigo_com` int(11) NOT NULL,
  `codigo_suc` int(11) DEFAULT NULL,
  `codigo_tdo` int(11) DEFAULT NULL,
  `serie_com` varchar(4) COLLATE utf8_spanish_ci DEFAULT NULL,
  `numero_com` varchar(7) COLLATE utf8_spanish_ci DEFAULT NULL,
  `codigo_pro` int(11) DEFAULT NULL,
  `fechaingreso_com` date DEFAULT NULL,
  `fechaemision_com` date DEFAULT NULL,
  `subtotal_com` decimal(12,2) DEFAULT NULL,
  `mtoigv_com` decimal(12,2) DEFAULT NULL,
  `total_com` decimal(12,2) DEFAULT NULL,
  `codigo_mon` int(11) DEFAULT NULL,
  `detalle_com` varchar(1000) COLLATE utf8_spanish_ci DEFAULT NULL,
  `dolar_com` decimal(10,4) DEFAULT NULL,
  `codigo_cod` int(11) DEFAULT NULL,
  `impuesto_com` decimal(10,4) DEFAULT NULL,
  `dias_com` int(11) DEFAULT NULL,
  `codigo_cta` int(11) DEFAULT NULL,
  `codigo_ven` int(11) DEFAULT NULL,
  `codigoref_tdo` int(11) DEFAULT NULL,
  `serieref_com` varchar(4) COLLATE utf8_spanish_ci DEFAULT NULL,
  `numeroref_com` varchar(7) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fecharef_com` date NOT NULL,
  `codigo_tno` int(11) DEFAULT NULL,
  `estado_com` int(11) DEFAULT '1',
  `usuario_reg` int(11) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_mod` int(11) DEFAULT NULL,
  `fecha_mod` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `compra`
--

INSERT INTO `compra` (`codigo_com`, `codigo_suc`, `codigo_tdo`, `serie_com`, `numero_com`, `codigo_pro`, `fechaingreso_com`, `fechaemision_com`, `subtotal_com`, `mtoigv_com`, `total_com`, `codigo_mon`, `detalle_com`, `dolar_com`, `codigo_cod`, `impuesto_com`, `dias_com`, `codigo_cta`, `codigo_ven`, `codigoref_tdo`, `serieref_com`, `numeroref_com`, `fecharef_com`, `codigo_tno`, `estado_com`, `usuario_reg`, `usuario_mod`, `fecha_mod`) VALUES
(1, 1, 2, '0001', '0000001', 1, '2024-07-01', '2024-07-01', '1000.00', '180.00', '820.00', 1, 'prueba de registro de compras', '3.6000', 1, '18.0000', 0, 0, 0, NULL, NULL, NULL, '0000-00-00', NULL, 1, NULL, NULL, NULL),
(2, 1, 2, '0001', '0000002', 2, '2024-07-01', '2024-07-01', '2000.00', '360.00', '1640.00', 1, 'prueba de registro de compras', '3.6000', 1, '18.0000', 0, 0, 0, NULL, NULL, NULL, '0000-00-00', NULL, 1, NULL, NULL, NULL),
(3, 1, 2, '0001', '0000003', 3, '2024-07-03', '2024-07-03', '3000.00', '540.00', '2460.00', 1, 'prueba de registro de compras', '3.6000', 1, '18.0000', 0, 0, 0, NULL, NULL, NULL, '0000-00-00', NULL, 1, NULL, NULL, NULL),
(4, 1, 2, '0001', '0000004', 4, '2024-07-04', '2024-07-04', '4000.00', '720.00', '3280.00', 1, 'prueba de registro de compras', '3.6000', 1, '18.0000', 0, 0, 0, NULL, NULL, NULL, '0000-00-00', NULL, 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra_detalle`
--

CREATE TABLE `compra_detalle` (
  `codigo_cde` int(11) NOT NULL,
  `codigo_art` int(11) DEFAULT NULL,
  `item_cde` int(11) NOT NULL,
  `cantidad_cde` decimal(12,2) DEFAULT '0.00',
  `precio_cde` decimal(12,2) DEFAULT '0.00',
  `descuento_cde` decimal(12,2) DEFAULT '0.00',
  `impuesto_cde` decimal(10,4) DEFAULT '0.0000',
  `flete_cde` decimal(10,4) DEFAULT '0.0000',
  `otros_cde` decimal(10,4) DEFAULT '0.0000',
  `tipoimpuesto` varchar(1) COLLATE utf8_spanish_ci DEFAULT NULL,
  `codigo_com` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `compra_detalle`
--

INSERT INTO `compra_detalle` (`codigo_cde`, `codigo_art`, `item_cde`, `cantidad_cde`, `precio_cde`, `descuento_cde`, `impuesto_cde`, `flete_cde`, `otros_cde`, `tipoimpuesto`, `codigo_com`) VALUES
(1, 1, 1, '8.00', '10.00', '0.00', '18.0000', '0.0000', '0.0000', 'G', 1),
(2, 2, 2, '6.00', '20.00', '0.00', '18.0000', '0.0000', '0.0000', 'G', 1),
(3, 5, 3, '5.00', '30.00', '0.00', '18.0000', '0.0000', '0.0000', 'G', 1),
(4, 8, 4, '22.00', '40.00', '0.00', '18.0000', '0.0000', '0.0000', 'G', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `concepto`
--

CREATE TABLE `concepto` (
  `codigo_con` int(11) NOT NULL,
  `nombre_con` varchar(500) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `codigo_gco` int(11) NOT NULL,
  `estado_con` int(11) DEFAULT '1',
  `usuario_reg` int(11) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_mod` int(11) DEFAULT NULL,
  `fecha_mod` timestamp NULL DEFAULT NULL,
  `sistema` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `concepto`
--

INSERT INTO `concepto` (`codigo_con`, `nombre_con`, `codigo_gco`, `estado_con`, `usuario_reg`, `usuario_mod`, `fecha_mod`, `sistema`) VALUES
(1, 'CREDITO ANTERIOR', 1, 1, 1, NULL, NULL, 1),
(2, 'SALIDAS O VENTAS', 1, 1, 1, NULL, NULL, 1),
(3, 'INGRESOS O COMPRAS', 1, 1, 1, NULL, NULL, 1),
(4, 'TRANSFERENCIA', 1, 1, 1, NULL, NULL, 1),
(5, 'AMORTIZACION', 1, 1, 0, 0, '2024-06-20 13:37:14', 1),
(6, 'SUELDOS', 2, 1, 0, NULL, NULL, 0),
(7, 'SERVICIO DE ENERGIA ELECTRICA', 2, 1, 0, NULL, NULL, 0),
(8, 'SERVICIO DE AGUA POTABLE', 2, 1, 0, NULL, NULL, 0),
(9, 'CELULARES, INTERNET Y TELEFONO', 2, 1, 0, NULL, NULL, 0),
(10, 'ALQUILER DE TIENDA', 2, 1, 0, NULL, NULL, 0),
(11, 'GASTOS REPRESENTATIVOS DE LA EMPRESA', 2, 1, 0, NULL, NULL, 0),
(12, 'EQUIPOS DE OFICINA', 2, 1, 0, NULL, NULL, 0),
(13, 'AMORTIZACION DE CLIENTE', 1, 1, 0, NULL, NULL, 0),
(14, 'AMORIZACION/PAGO DE PROVEEDOR', 1, 1, 0, NULL, NULL, 0),
(15, 'SALDO INICIAL', 1, 1, 0, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `condicion`
--

CREATE TABLE `condicion` (
  `codigo_cod` int(11) NOT NULL,
  `nombre_cod` varchar(20) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `tipo_cod` varchar(5) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `estado_cod` int(11) DEFAULT '1',
  `usuario_reg` int(11) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_mod` int(11) DEFAULT NULL,
  `fecha_mod` timestamp NULL DEFAULT NULL,
  `sistema` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `condicion`
--

INSERT INTO `condicion` (`codigo_cod`, `nombre_cod`, `tipo_cod`, `estado_cod`, `usuario_reg`, `usuario_mod`, `fecha_mod`, `sistema`) VALUES
(1, 'CREDITO', NULL, 1, NULL, NULL, NULL, 0),
(2, 'CONTADO', NULL, 1, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuenta`
--

CREATE TABLE `cuenta` (
  `codigo_cta` int(11) NOT NULL,
  `nombre_cta` varchar(500) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `codigo_ban` int(11) DEFAULT NULL,
  `codigo_mon` int(11) DEFAULT NULL,
  `serie_ing` int(11) DEFAULT '0',
  `serie_egr` int(11) DEFAULT '0',
  `titular_cta` varchar(500) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `codigo_suc` int(11) DEFAULT NULL,
  `estado_cta` int(11) DEFAULT '1',
  `usuario_reg` int(11) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_mod` int(11) DEFAULT NULL,
  `fecha_mod` timestamp NULL DEFAULT NULL,
  `sistema` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `cuenta`
--

INSERT INTO `cuenta` (`codigo_cta`, `nombre_cta`, `codigo_ban`, `codigo_mon`, `serie_ing`, `serie_egr`, `titular_cta`, `codigo_suc`, `estado_cta`, `usuario_reg`, `usuario_mod`, `fecha_mod`, `sistema`) VALUES
(1, 'CAJA GERENCIAL AHORRO SOLES', 2, 1, 9, 60, 'CAJA', 1, 1, NULL, NULL, NULL, 0),
(2, 'CAJA DOLARES', 2, 2, 0, 44, 'JUAN MARTINEZ', 1, 1, NULL, NULL, NULL, 0),
(3, 'IZIPAY', 1, 1, 0, 1, 'TECNOAGRO', 1, 1, NULL, NULL, NULL, 0),
(4, 'BANCO BCP SOLES', 1, 1, 1, 6, 'JOSE', 1, 1, NULL, NULL, NULL, 0),
(5, 'CAJA ARICA SOLES', 2, 1, 0, 0, 'JEANPERR', 2, 1, NULL, NULL, NULL, 0),
(6, 'CAJA CHICA JUAN', 2, 1, 0, 0, 'JUAN MARTINEZ', 3, 1, NULL, NULL, NULL, 0),
(7, 'CAJA AMERICA SOLES', 2, 1, 0, 0, 'EDUARD', 3, 1, NULL, NULL, NULL, 0),
(8, 'CAJA  AMERICA DOLARES', 2, 2, 0, 0, 'EDUARD', 3, 1, NULL, NULL, NULL, 0),
(9, 'CAJA GERENCIAL AHORRO DOLARES', 2, 2, 0, 2, 'LOCAL PRINCIPAL', 1, 1, NULL, NULL, NULL, 0),
(10, 'CAJA L.GONZALES SOLES', 2, 1, 0, 27, 'TECNOAGRO', 1, 1, NULL, NULL, NULL, 0),
(11, 'CAJA L.GONZALEZ  DOLARESS', 2, 2, 0, 0, 'TECNOAGRO', 1, 1, NULL, NULL, NULL, 0),
(12, 'BANCO  BCP DOLARES', 1, 2, 3, 18, 'JOSE', 1, 1, NULL, NULL, NULL, 0),
(13, 'BANCO  CAJA PIURA SOLES', 2, 1, 1, 0, 'JOSE', 1, 1, NULL, NULL, NULL, 0),
(14, 'CAJA ARICA DOLARES', 2, 2, 0, 0, 'JEAMPER', 2, 1, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamento`
--

CREATE TABLE `departamento` (
  `codigo_dep` int(11) NOT NULL,
  `nombre_dep` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `estado_dep` int(11) DEFAULT '1',
  `usuario_reg` int(11) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_mod` int(11) DEFAULT NULL,
  `fecha_mod` timestamp NULL DEFAULT NULL,
  `sistema` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `departamento`
--

INSERT INTO `departamento` (`codigo_dep`, `nombre_dep`, `estado_dep`, `usuario_reg`, `usuario_mod`, `fecha_mod`, `sistema`) VALUES
(1, 'AMAZONAS', 1, NULL, NULL, NULL, 0),
(2, 'ANCASH', 1, NULL, NULL, NULL, 0),
(3, 'APURIMAC', 1, NULL, NULL, NULL, 0),
(4, 'AREQUIPA', 1, NULL, NULL, NULL, 0),
(5, 'AYACUCHO', 1, NULL, NULL, NULL, 0),
(6, 'CAJAMARCA', 1, NULL, NULL, NULL, 0),
(7, 'CUSCO', 1, NULL, NULL, NULL, 0),
(8, 'HUANCAVELICA', 1, NULL, NULL, NULL, 0),
(9, 'HUANUCO', 1, NULL, NULL, NULL, 0),
(10, 'ICA', 1, NULL, NULL, NULL, 0),
(11, 'JUNIN', 1, NULL, NULL, NULL, 0),
(12, 'LA LIBERTAD', 1, NULL, NULL, NULL, 0),
(13, 'LAMBAYEQUE', 1, NULL, NULL, NULL, 0),
(14, 'LIMA', 1, NULL, NULL, NULL, 0),
(15, 'LORETO', 1, NULL, NULL, NULL, 0),
(16, 'MADRE DE DIOS', 1, NULL, NULL, NULL, 0),
(17, 'MOQUEGUA', 1, NULL, NULL, NULL, 0),
(18, 'PASCO', 1, NULL, NULL, NULL, 0),
(19, 'PIURA', 1, NULL, NULL, NULL, 0),
(20, 'PUNO', 1, NULL, NULL, NULL, 0),
(21, 'SAN MARTIN', 1, NULL, NULL, NULL, 0),
(22, 'TACNA', 1, NULL, NULL, NULL, 0),
(23, 'TUMBES', 1, NULL, NULL, NULL, 0),
(24, 'PROV. CONST. DEL CALLAO', 1, NULL, NULL, NULL, 0),
(25, 'UCAYALI', 1, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `distrito`
--

CREATE TABLE `distrito` (
  `codigo_dis` int(11) NOT NULL,
  `nombre_dis` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `codigo_pro` int(11) NOT NULL,
  `estado_dis` int(11) DEFAULT '1',
  `usuario_reg` int(11) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_mod` int(11) DEFAULT NULL,
  `fecha_mod` timestamp NULL DEFAULT NULL,
  `sistema` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `distrito`
--

INSERT INTO `distrito` (`codigo_dis`, `nombre_dis`, `codigo_pro`, `estado_dis`, `usuario_reg`, `usuario_mod`, `fecha_mod`, `sistema`) VALUES
(10101, 'CHACHAPOYAS', 101, 1, NULL, NULL, NULL, 0),
(10102, 'ASUNCION', 101, 1, NULL, NULL, NULL, 0),
(10103, 'BALSAS', 101, 1, NULL, NULL, NULL, 0),
(10104, 'CHETO', 101, 1, NULL, NULL, NULL, 0),
(10105, 'CHILIQUIN', 101, 1, NULL, NULL, NULL, 0),
(10106, 'CHUQUIBAMBA', 101, 1, NULL, NULL, NULL, 0),
(10107, 'GRANADA', 101, 1, NULL, NULL, NULL, 0),
(10108, 'HUANCAS', 101, 1, NULL, NULL, NULL, 0),
(10109, 'LA JALCA', 101, 1, NULL, NULL, NULL, 0),
(10110, 'LEIMEBAMBA', 101, 1, NULL, NULL, NULL, 0),
(10111, 'LEVANTO', 101, 1, NULL, NULL, NULL, 0),
(10112, 'MAGDALENA', 101, 1, NULL, NULL, NULL, 0),
(10113, 'MARISCAL CASTILLA', 101, 1, NULL, NULL, NULL, 0),
(10114, 'MOLINOPAMPA', 101, 1, NULL, NULL, NULL, 0),
(10115, 'MONTEVIDEO', 101, 1, NULL, NULL, NULL, 0),
(10116, 'OLLEROS', 101, 1, NULL, NULL, NULL, 0),
(10117, 'QUINJALCA', 101, 1, NULL, NULL, NULL, 0),
(10118, 'SAN FCO DE DAGUAS', 101, 1, NULL, NULL, NULL, 0),
(10119, 'SAN ISIDRO DE MAINO', 101, 1, NULL, NULL, NULL, 0),
(10120, 'SOLOCO', 101, 1, NULL, NULL, NULL, 0),
(10121, 'SONCHE', 101, 1, NULL, NULL, NULL, 0),
(10201, 'LA PECA', 102, 1, NULL, NULL, NULL, 0),
(10202, 'ARAMANGO', 102, 1, NULL, NULL, NULL, 0),
(10203, 'COPALLIN', 102, 1, NULL, NULL, NULL, 0),
(10204, 'EL PARCO', 102, 1, NULL, NULL, NULL, 0),
(10205, 'BAGUA', 102, 1, NULL, NULL, NULL, 0),
(10206, 'IMAZA', 102, 1, NULL, NULL, NULL, 0),
(10301, 'JUMBILLA', 103, 1, NULL, NULL, NULL, 0),
(10302, 'COROSHA', 103, 1, NULL, NULL, NULL, 0),
(10303, 'CUISPES', 103, 1, NULL, NULL, NULL, 0),
(10304, 'CHISQUILLA', 103, 1, NULL, NULL, NULL, 0),
(10305, 'CHURUJA', 103, 1, NULL, NULL, NULL, 0),
(10306, 'FLORIDA', 103, 1, NULL, NULL, NULL, 0),
(10307, 'RECTA', 103, 1, NULL, NULL, NULL, 0),
(10308, 'SAN CARLOS', 103, 1, NULL, NULL, NULL, 0),
(10309, 'SHIPASBAMBA', 103, 1, NULL, NULL, NULL, 0),
(10310, 'VALERA', 103, 1, NULL, NULL, NULL, 0),
(10311, 'YAMBRASBAMBA', 103, 1, NULL, NULL, NULL, 0),
(10312, 'JAZAN', 103, 1, NULL, NULL, NULL, 0),
(10401, 'LAMUD', 104, 1, NULL, NULL, NULL, 0),
(10402, 'CAMPORREDONDO', 104, 1, NULL, NULL, NULL, 0),
(10403, 'COCABAMBA', 104, 1, NULL, NULL, NULL, 0),
(10404, 'COLCAMAR', 104, 1, NULL, NULL, NULL, 0),
(10405, 'CONILA', 104, 1, NULL, NULL, NULL, 0),
(10406, 'INGUILPATA', 104, 1, NULL, NULL, NULL, 0),
(10407, 'LONGUITA', 104, 1, NULL, NULL, NULL, 0),
(10408, 'LONYA CHICO', 104, 1, NULL, NULL, NULL, 0),
(10409, 'LUYA', 104, 1, NULL, NULL, NULL, 0),
(10410, 'LUYA VIEJO', 104, 1, NULL, NULL, NULL, 0),
(10411, 'MARIA', 104, 1, NULL, NULL, NULL, 0),
(10412, 'OCALLI', 104, 1, NULL, NULL, NULL, 0),
(10413, 'OCUMAL', 104, 1, NULL, NULL, NULL, 0),
(10414, 'PISUQUIA', 104, 1, NULL, NULL, NULL, 0),
(10415, 'SAN CRISTOBAL', 104, 1, NULL, NULL, NULL, 0),
(10416, 'SAN FRANCISCO DE YESO', 104, 1, NULL, NULL, NULL, 0),
(10417, 'SAN JERONIMO', 104, 1, NULL, NULL, NULL, 0),
(10418, 'SAN JUAN DE LOPECANCHA', 104, 1, NULL, NULL, NULL, 0),
(10419, 'SANTA CATALINA', 104, 1, NULL, NULL, NULL, 0),
(10420, 'SANTO TOMAS', 104, 1, NULL, NULL, NULL, 0),
(10421, 'TINGO', 104, 1, NULL, NULL, NULL, 0),
(10422, 'TRITA', 104, 1, NULL, NULL, NULL, 0),
(10423, 'PROVIDENCIA', 104, 1, NULL, NULL, NULL, 0),
(10501, 'SAN NICOLAS', 105, 1, NULL, NULL, NULL, 0),
(10502, 'COCHAMAL', 105, 1, NULL, NULL, NULL, 0),
(10503, 'CHIRIMOTO', 105, 1, NULL, NULL, NULL, 0),
(10504, 'HUAMBO', 105, 1, NULL, NULL, NULL, 0),
(10505, 'LIMABAMBA', 105, 1, NULL, NULL, NULL, 0),
(10506, 'LONGAR', 105, 1, NULL, NULL, NULL, 0),
(10507, 'MILPUC', 105, 1, NULL, NULL, NULL, 0),
(10508, 'MCAL BENAVIDES', 105, 1, NULL, NULL, NULL, 0),
(10509, 'OMIA', 105, 1, NULL, NULL, NULL, 0),
(10510, 'SANTA ROSA', 105, 1, NULL, NULL, NULL, 0),
(10511, 'TOTORA', 105, 1, NULL, NULL, NULL, 0),
(10512, 'VISTA ALEGRE', 105, 1, NULL, NULL, NULL, 0),
(10601, 'NIEVA', 106, 1, NULL, NULL, NULL, 0),
(10602, 'RIO SANTIAGO', 106, 1, NULL, NULL, NULL, 0),
(10603, 'EL CENEPA', 106, 1, NULL, NULL, NULL, 0),
(10701, 'BAGUA GRANDE', 107, 1, NULL, NULL, NULL, 0),
(10702, 'CAJARURO', 107, 1, NULL, NULL, NULL, 0),
(10703, 'CUMBA', 107, 1, NULL, NULL, NULL, 0),
(10704, 'EL MILAGRO', 107, 1, NULL, NULL, NULL, 0),
(10705, 'JAMALCA', 107, 1, NULL, NULL, NULL, 0),
(10706, 'LONYA GRANDE', 107, 1, NULL, NULL, NULL, 0),
(10707, 'YAMON', 107, 1, NULL, NULL, NULL, 0),
(20101, 'HUARAZ', 201, 1, NULL, NULL, NULL, 0),
(20102, 'INDEPENDENCIA', 201, 1, NULL, NULL, NULL, 0),
(20103, 'COCHABAMBA', 201, 1, NULL, NULL, NULL, 0),
(20104, 'COLCABAMBA', 201, 1, NULL, NULL, NULL, 0),
(20105, 'HUANCHAY', 201, 1, NULL, NULL, NULL, 0),
(20106, 'JANGAS', 201, 1, NULL, NULL, NULL, 0),
(20107, 'LA LIBERTAD', 201, 1, NULL, NULL, NULL, 0),
(20108, 'OLLEROS', 201, 1, NULL, NULL, NULL, 0),
(20109, 'PAMPAS', 201, 1, NULL, NULL, NULL, 0),
(20110, 'PARIACOTO', 201, 1, NULL, NULL, NULL, 0),
(20111, 'PIRA', 201, 1, NULL, NULL, NULL, 0),
(20112, 'TARICA', 201, 1, NULL, NULL, NULL, 0),
(20201, 'AIJA', 202, 1, NULL, NULL, NULL, 0),
(20203, 'CORIS', 202, 1, NULL, NULL, NULL, 0),
(20205, 'HUACLLAN', 202, 1, NULL, NULL, NULL, 0),
(20206, 'LA MERCED', 202, 1, NULL, NULL, NULL, 0),
(20208, 'SUCCHA', 202, 1, NULL, NULL, NULL, 0),
(20301, 'CHIQUIAN', 203, 1, NULL, NULL, NULL, 0),
(20302, 'A PARDO LEZAMETA', 203, 1, NULL, NULL, NULL, 0),
(20304, 'AQUIA', 203, 1, NULL, NULL, NULL, 0),
(20305, 'CAJACAY', 203, 1, NULL, NULL, NULL, 0),
(20310, 'HUAYLLACAYAN', 203, 1, NULL, NULL, NULL, 0),
(20311, 'HUASTA', 203, 1, NULL, NULL, NULL, 0),
(20313, 'MANGAS', 203, 1, NULL, NULL, NULL, 0),
(20315, 'PACLLON', 203, 1, NULL, NULL, NULL, 0),
(20317, 'SAN MIGUEL DE CORPANQUI', 203, 1, NULL, NULL, NULL, 0),
(20320, 'TICLLOS', 203, 1, NULL, NULL, NULL, 0),
(20321, 'ANTONIO RAIMONDI', 203, 1, NULL, NULL, NULL, 0),
(20322, 'CANIS', 203, 1, NULL, NULL, NULL, 0),
(20323, 'COLQUIOC', 203, 1, NULL, NULL, NULL, 0),
(20324, 'LA PRIMAVERA', 203, 1, NULL, NULL, NULL, 0),
(20325, 'HUALLANCA', 203, 1, NULL, NULL, NULL, 0),
(20401, 'CARHUAZ', 204, 1, NULL, NULL, NULL, 0),
(20402, 'ACOPAMPA', 204, 1, NULL, NULL, NULL, 0),
(20403, 'AMASHCA', 204, 1, NULL, NULL, NULL, 0),
(20404, 'ANTA', 204, 1, NULL, NULL, NULL, 0),
(20405, 'ATAQUERO', 204, 1, NULL, NULL, NULL, 0),
(20406, 'MARCARA', 204, 1, NULL, NULL, NULL, 0),
(20407, 'PARIAHUANCA', 204, 1, NULL, NULL, NULL, 0),
(20408, 'SAN MIGUEL DE ACO', 204, 1, NULL, NULL, NULL, 0),
(20409, 'SHILLA', 204, 1, NULL, NULL, NULL, 0),
(20410, 'TINCO', 204, 1, NULL, NULL, NULL, 0),
(20411, 'YUNGAR', 204, 1, NULL, NULL, NULL, 0),
(20501, 'CASMA', 205, 1, NULL, NULL, NULL, 0),
(20502, 'BUENA VISTA ALTA', 205, 1, NULL, NULL, NULL, 0),
(20503, 'COMANDANTE NOEL', 205, 1, NULL, NULL, NULL, 0),
(20505, 'YAUTAN', 205, 1, NULL, NULL, NULL, 0),
(20601, 'CORONGO', 206, 1, NULL, NULL, NULL, 0),
(20602, 'ACO', 206, 1, NULL, NULL, NULL, 0),
(20603, 'BAMBAS', 206, 1, NULL, NULL, NULL, 0),
(20604, 'CUSCA', 206, 1, NULL, NULL, NULL, 0),
(20605, 'LA PAMPA', 206, 1, NULL, NULL, NULL, 0),
(20606, 'YANAC', 206, 1, NULL, NULL, NULL, 0),
(20607, 'YUPAN', 206, 1, NULL, NULL, NULL, 0),
(20701, 'CARAZ', 207, 1, NULL, NULL, NULL, 0),
(20702, 'HUALLANCA', 207, 1, NULL, NULL, NULL, 0),
(20703, 'HUATA', 207, 1, NULL, NULL, NULL, 0),
(20704, 'HUAYLAS', 207, 1, NULL, NULL, NULL, 0),
(20705, 'MATO', 207, 1, NULL, NULL, NULL, 0),
(20706, 'PAMPAROMAS', 207, 1, NULL, NULL, NULL, 0),
(20707, 'PUEBLO LIBRE', 207, 1, NULL, NULL, NULL, 0),
(20708, 'SANTA CRUZ', 207, 1, NULL, NULL, NULL, 0),
(20709, 'YURACMARCA', 207, 1, NULL, NULL, NULL, 0),
(20710, 'SANTO TORIBIO', 207, 1, NULL, NULL, NULL, 0),
(20801, 'HUARI', 208, 1, NULL, NULL, NULL, 0),
(20802, 'CAJAY', 208, 1, NULL, NULL, NULL, 0),
(20803, 'CHAVIN DE HUANTAR', 208, 1, NULL, NULL, NULL, 0),
(20804, 'HUACACHI', 208, 1, NULL, NULL, NULL, 0),
(20805, 'HUACHIS', 208, 1, NULL, NULL, NULL, 0),
(20806, 'HUACCHIS', 208, 1, NULL, NULL, NULL, 0),
(20807, 'HUANTAR', 208, 1, NULL, NULL, NULL, 0),
(20808, 'MASIN', 208, 1, NULL, NULL, NULL, 0),
(20809, 'PAUCAS', 208, 1, NULL, NULL, NULL, 0),
(20810, 'PONTO', 208, 1, NULL, NULL, NULL, 0),
(20811, 'RAHUAPAMPA', 208, 1, NULL, NULL, NULL, 0),
(20812, 'RAPAYAN', 208, 1, NULL, NULL, NULL, 0),
(20813, 'SAN MARCOS', 208, 1, NULL, NULL, NULL, 0),
(20814, 'SAN PEDRO DE CHANA', 208, 1, NULL, NULL, NULL, 0),
(20815, 'UCO', 208, 1, NULL, NULL, NULL, 0),
(20816, 'ANRA', 208, 1, NULL, NULL, NULL, 0),
(20901, 'PISCOBAMBA', 209, 1, NULL, NULL, NULL, 0),
(20902, 'CASCA', 209, 1, NULL, NULL, NULL, 0),
(20903, 'LUCMA', 209, 1, NULL, NULL, NULL, 0),
(20904, 'FIDEL OLIVAS ESCUDERO', 209, 1, NULL, NULL, NULL, 0),
(20905, 'LLAMA', 209, 1, NULL, NULL, NULL, 0),
(20906, 'LLUMPA', 209, 1, NULL, NULL, NULL, 0),
(20907, 'MUSGA', 209, 1, NULL, NULL, NULL, 0),
(20908, 'ELEAZAR GUZMAN BARRON', 209, 1, NULL, NULL, NULL, 0),
(21001, 'CABANA', 210, 1, NULL, NULL, NULL, 0),
(21002, 'BOLOGNESI', 210, 1, NULL, NULL, NULL, 0),
(21003, 'CONCHUCOS', 210, 1, NULL, NULL, NULL, 0),
(21004, 'HUACASCHUQUE', 210, 1, NULL, NULL, NULL, 0),
(21005, 'HUANDOVAL', 210, 1, NULL, NULL, NULL, 0),
(21006, 'LACABAMBA', 210, 1, NULL, NULL, NULL, 0),
(21007, 'LLAPO', 210, 1, NULL, NULL, NULL, 0),
(21008, 'PALLASCA', 210, 1, NULL, NULL, NULL, 0),
(21009, 'PAMPAS', 210, 1, NULL, NULL, NULL, 0),
(21010, 'SANTA ROSA', 210, 1, NULL, NULL, NULL, 0),
(21011, 'TAUCA', 210, 1, NULL, NULL, NULL, 0),
(21101, 'POMABAMBA', 211, 1, NULL, NULL, NULL, 0),
(21102, 'HUAYLLAN', 211, 1, NULL, NULL, NULL, 0),
(21103, 'PAROBAMBA', 211, 1, NULL, NULL, NULL, 0),
(21104, 'QUINUABAMBA', 211, 1, NULL, NULL, NULL, 0),
(21201, 'RECUAY', 212, 1, NULL, NULL, NULL, 0),
(21202, 'COTAPARACO', 212, 1, NULL, NULL, NULL, 0),
(21203, 'HUAYLLAPAMPA', 212, 1, NULL, NULL, NULL, 0),
(21204, 'MARCA', 212, 1, NULL, NULL, NULL, 0),
(21205, 'PAMPAS CHICO', 212, 1, NULL, NULL, NULL, 0),
(21206, 'PARARIN', 212, 1, NULL, NULL, NULL, 0),
(21207, 'TAPACOCHA', 212, 1, NULL, NULL, NULL, 0),
(21208, 'TICAPAMPA', 212, 1, NULL, NULL, NULL, 0),
(21209, 'LLACLLIN', 212, 1, NULL, NULL, NULL, 0),
(21210, 'CATAC', 212, 1, NULL, NULL, NULL, 0),
(21301, 'CHIMBOTE', 213, 1, NULL, NULL, NULL, 0),
(21302, 'CACERES DEL PERU', 213, 1, NULL, NULL, NULL, 0),
(21303, 'MACATE', 213, 1, NULL, NULL, NULL, 0),
(21304, 'MORO', 213, 1, NULL, NULL, NULL, 0),
(21305, 'NEPENA', 213, 1, NULL, NULL, NULL, 0),
(21306, 'SAMANCO', 213, 1, NULL, NULL, NULL, 0),
(21307, 'SANTA', 213, 1, NULL, NULL, NULL, 0),
(21308, 'COISHCO', 213, 1, NULL, NULL, NULL, 0),
(21309, 'NUEVO CHIMBOTE', 213, 1, NULL, NULL, NULL, 0),
(21401, 'SIHUAS', 214, 1, NULL, NULL, NULL, 0),
(21402, 'ALFONSO UGARTE', 214, 1, NULL, NULL, NULL, 0),
(21403, 'CHINGALPO', 214, 1, NULL, NULL, NULL, 0),
(21404, 'HUAYLLABAMBA', 214, 1, NULL, NULL, NULL, 0),
(21405, 'QUICHES', 214, 1, NULL, NULL, NULL, 0),
(21406, 'SICSIBAMBA', 214, 1, NULL, NULL, NULL, 0),
(21407, 'ACOBAMBA', 214, 1, NULL, NULL, NULL, 0),
(21408, 'CASHAPAMPA', 214, 1, NULL, NULL, NULL, 0),
(21409, 'RAGASH', 214, 1, NULL, NULL, NULL, 0),
(21410, 'SAN JUAN', 214, 1, NULL, NULL, NULL, 0),
(21501, 'YUNGAY', 215, 1, NULL, NULL, NULL, 0),
(21502, 'CASCAPARA', 215, 1, NULL, NULL, NULL, 0),
(21503, 'MANCOS', 215, 1, NULL, NULL, NULL, 0),
(21504, 'MATACOTO', 215, 1, NULL, NULL, NULL, 0),
(21505, 'QUILLO', 215, 1, NULL, NULL, NULL, 0),
(21506, 'RANRAHIRCA', 215, 1, NULL, NULL, NULL, 0),
(21507, 'SHUPLUY', 215, 1, NULL, NULL, NULL, 0),
(21508, 'YANAMA', 215, 1, NULL, NULL, NULL, 0),
(21601, 'LLAMELLIN', 216, 1, NULL, NULL, NULL, 0),
(21602, 'ACZO', 216, 1, NULL, NULL, NULL, 0),
(21603, 'CHACCHO', 216, 1, NULL, NULL, NULL, 0),
(21604, 'CHINGAS', 216, 1, NULL, NULL, NULL, 0),
(21605, 'MIRGAS', 216, 1, NULL, NULL, NULL, 0),
(21606, 'SAN JUAN DE RONTOY', 216, 1, NULL, NULL, NULL, 0),
(21701, 'SAN LUIS', 217, 1, NULL, NULL, NULL, 0),
(21702, 'YAUYA', 217, 1, NULL, NULL, NULL, 0),
(21703, 'SAN NICOLAS', 217, 1, NULL, NULL, NULL, 0),
(21801, 'CHACAS', 218, 1, NULL, NULL, NULL, 0),
(21802, 'ACOCHACA', 218, 1, NULL, NULL, NULL, 0),
(21901, 'HUARMEY', 219, 1, NULL, NULL, NULL, 0),
(21902, 'COCHAPETI', 219, 1, NULL, NULL, NULL, 0),
(21903, 'HUAYAN', 219, 1, NULL, NULL, NULL, 0),
(21904, 'MALVAS', 219, 1, NULL, NULL, NULL, 0),
(21905, 'CULEBRAS', 219, 1, NULL, NULL, NULL, 0),
(22001, 'ACAS', 220, 1, NULL, NULL, NULL, 0),
(22002, 'CAJAMARQUILLA', 220, 1, NULL, NULL, NULL, 0),
(22003, 'CARHUAPAMPA', 220, 1, NULL, NULL, NULL, 0),
(22004, 'COCHAS', 220, 1, NULL, NULL, NULL, 0),
(22005, 'CONGAS', 220, 1, NULL, NULL, NULL, 0),
(22006, 'LLIPA', 220, 1, NULL, NULL, NULL, 0),
(22007, 'OCROS', 220, 1, NULL, NULL, NULL, 0),
(22008, 'SAN CRISTOBAL DE RAJAN', 220, 1, NULL, NULL, NULL, 0),
(22009, 'SAN PEDRO', 220, 1, NULL, NULL, NULL, 0),
(22010, 'SANTIAGO DE CHILCAS', 220, 1, NULL, NULL, NULL, 0),
(30101, 'ABANCAY', 301, 1, NULL, NULL, NULL, 0),
(30102, 'CIRCA', 301, 1, NULL, NULL, NULL, 0),
(30103, 'CURAHUASI', 301, 1, NULL, NULL, NULL, 0),
(30104, 'CHACOCHE', 301, 1, NULL, NULL, NULL, 0),
(30105, 'HUANIPACA', 301, 1, NULL, NULL, NULL, 0),
(30106, 'LAMBRAMA', 301, 1, NULL, NULL, NULL, 0),
(30107, 'PICHIRHUA', 301, 1, NULL, NULL, NULL, 0),
(30108, 'SAN PEDRO DE CACHORA', 301, 1, NULL, NULL, NULL, 0),
(30109, 'TAMBURCO', 301, 1, NULL, NULL, NULL, 0),
(30201, 'CHALHUANCA', 302, 1, NULL, NULL, NULL, 0),
(30202, 'CAPAYA', 302, 1, NULL, NULL, NULL, 0),
(30203, 'CARAYBAMBA', 302, 1, NULL, NULL, NULL, 0),
(30204, 'COLCABAMBA', 302, 1, NULL, NULL, NULL, 0),
(30205, 'COTARUSE', 302, 1, NULL, NULL, NULL, 0),
(30206, 'CHAPIMARCA', 302, 1, NULL, NULL, NULL, 0),
(30207, 'IHUAYLLO', 302, 1, NULL, NULL, NULL, 0),
(30208, 'LUCRE', 302, 1, NULL, NULL, NULL, 0),
(30209, 'POCOHUANCA', 302, 1, NULL, NULL, NULL, 0),
(30210, 'SANAICA', 302, 1, NULL, NULL, NULL, 0),
(30211, 'SORAYA', 302, 1, NULL, NULL, NULL, 0),
(30212, 'TAPAIRIHUA', 302, 1, NULL, NULL, NULL, 0),
(30213, 'TINTAY', 302, 1, NULL, NULL, NULL, 0),
(30214, 'TORAYA', 302, 1, NULL, NULL, NULL, 0),
(30215, 'YANACA', 302, 1, NULL, NULL, NULL, 0),
(30216, 'SAN JUAN DE CHACNA', 302, 1, NULL, NULL, NULL, 0),
(30217, 'JUSTO APU SAHUARAURA', 302, 1, NULL, NULL, NULL, 0),
(30301, 'ANDAHUAYLAS', 303, 1, NULL, NULL, NULL, 0),
(30302, 'ANDARAPA', 303, 1, NULL, NULL, NULL, 0),
(30303, 'CHIARA', 303, 1, NULL, NULL, NULL, 0),
(30304, 'HUANCARAMA', 303, 1, NULL, NULL, NULL, 0),
(30305, 'HUANCARAY', 303, 1, NULL, NULL, NULL, 0),
(30306, 'KISHUARA', 303, 1, NULL, NULL, NULL, 0),
(30307, 'PACOBAMBA', 303, 1, NULL, NULL, NULL, 0),
(30308, 'PAMPACHIRI', 303, 1, NULL, NULL, NULL, 0),
(30309, 'SAN ANTONIO DE CACHI', 303, 1, NULL, NULL, NULL, 0),
(30310, 'SAN JERONIMO', 303, 1, NULL, NULL, NULL, 0),
(30311, 'TALAVERA', 303, 1, NULL, NULL, NULL, 0),
(30312, 'TURPO', 303, 1, NULL, NULL, NULL, 0),
(30313, 'PACUCHA', 303, 1, NULL, NULL, NULL, 0),
(30314, 'POMACOCHA', 303, 1, NULL, NULL, NULL, 0),
(30315, 'STA MARIA DE CHICMO', 303, 1, NULL, NULL, NULL, 0),
(30316, 'TUMAY HUARACA', 303, 1, NULL, NULL, NULL, 0),
(30317, 'HUAYANA', 303, 1, NULL, NULL, NULL, 0),
(30318, 'SAN MIGUEL DE CHACCRAMPA', 303, 1, NULL, NULL, NULL, 0),
(30319, 'KAQUIABAMBA', 303, 1, NULL, NULL, NULL, 0),
(30401, 'ANTABAMBA', 304, 1, NULL, NULL, NULL, 0),
(30402, 'EL ORO', 304, 1, NULL, NULL, NULL, 0),
(30403, 'HUAQUIRCA', 304, 1, NULL, NULL, NULL, 0),
(30404, 'JUAN ESPINOZA MEDRANO', 304, 1, NULL, NULL, NULL, 0),
(30405, 'OROPESA', 304, 1, NULL, NULL, NULL, 0),
(30406, 'PACHACONAS', 304, 1, NULL, NULL, NULL, 0),
(30407, 'SABAINO', 304, 1, NULL, NULL, NULL, 0),
(30501, 'TAMBOBAMBA', 305, 1, NULL, NULL, NULL, 0),
(30502, 'COYLLURQUI', 305, 1, NULL, NULL, NULL, 0),
(30503, 'COTABAMBAS', 305, 1, NULL, NULL, NULL, 0),
(30504, 'HAQUIRA', 305, 1, NULL, NULL, NULL, 0),
(30505, 'MARA', 305, 1, NULL, NULL, NULL, 0),
(30506, 'CHALLHUAHUACHO', 305, 1, NULL, NULL, NULL, 0),
(30601, 'CHUQUIBAMBILLA', 306, 1, NULL, NULL, NULL, 0),
(30602, 'CURPAHUASI', 306, 1, NULL, NULL, NULL, 0),
(30603, 'HUAILLATI', 306, 1, NULL, NULL, NULL, 0),
(30604, 'MAMARA', 306, 1, NULL, NULL, NULL, 0),
(30605, 'MARISCAL GAMARRA', 306, 1, NULL, NULL, NULL, 0),
(30606, 'MICAELA BASTIDAS', 306, 1, NULL, NULL, NULL, 0),
(30607, 'PROGRESO', 306, 1, NULL, NULL, NULL, 0),
(30608, 'PATAYPAMPA', 306, 1, NULL, NULL, NULL, 0),
(30609, 'SAN ANTONIO', 306, 1, NULL, NULL, NULL, 0),
(30610, 'TURPAY', 306, 1, NULL, NULL, NULL, 0),
(30611, 'VILCABAMBA', 306, 1, NULL, NULL, NULL, 0),
(30612, 'VIRUNDO', 306, 1, NULL, NULL, NULL, 0),
(30613, 'SANTA ROSA', 306, 1, NULL, NULL, NULL, 0),
(30614, 'CURASCO', 306, 1, NULL, NULL, NULL, 0),
(30701, 'CHINCHEROS', 307, 1, NULL, NULL, NULL, 0),
(30702, 'ONGOY', 307, 1, NULL, NULL, NULL, 0),
(30703, 'OCOBAMBA', 307, 1, NULL, NULL, NULL, 0),
(30704, 'COCHARCAS', 307, 1, NULL, NULL, NULL, 0),
(30705, 'ANCO HUALLO', 307, 1, NULL, NULL, NULL, 0),
(30706, 'HUACCANA', 307, 1, NULL, NULL, NULL, 0),
(30707, 'URANMARCA', 307, 1, NULL, NULL, NULL, 0),
(30708, 'RANRACANCHA', 307, 1, NULL, NULL, NULL, 0),
(40101, 'AREQUIPA', 401, 1, NULL, NULL, NULL, 0),
(40102, 'CAYMA', 401, 1, NULL, NULL, NULL, 0),
(40103, 'CERRO COLORADO', 401, 1, NULL, NULL, NULL, 0),
(40104, 'CHARACATO', 401, 1, NULL, NULL, NULL, 0),
(40105, 'CHIGUATA', 401, 1, NULL, NULL, NULL, 0),
(40106, 'LA JOYA', 401, 1, NULL, NULL, NULL, 0),
(40107, 'MIRAFLORES', 401, 1, NULL, NULL, NULL, 0),
(40108, 'MOLLEBAYA', 401, 1, NULL, NULL, NULL, 0),
(40109, 'PAUCARPATA', 401, 1, NULL, NULL, NULL, 0),
(40110, 'POCSI', 401, 1, NULL, NULL, NULL, 0),
(40111, 'POLOBAYA', 401, 1, NULL, NULL, NULL, 0),
(40112, 'QUEQUENA', 401, 1, NULL, NULL, NULL, 0),
(40113, 'SABANDIA', 401, 1, NULL, NULL, NULL, 0),
(40114, 'SACHACA', 401, 1, NULL, NULL, NULL, 0),
(40115, 'SAN JUAN DE SIGUAS', 401, 1, NULL, NULL, NULL, 0),
(40116, 'SAN JUAN DE TARUCANI', 401, 1, NULL, NULL, NULL, 0),
(40117, 'SANTA ISABEL DE SIGUAS', 401, 1, NULL, NULL, NULL, 0),
(40118, 'STA RITA DE SIGUAS', 401, 1, NULL, NULL, NULL, 0),
(40119, 'SOCABAYA', 401, 1, NULL, NULL, NULL, 0),
(40120, 'TIABAYA', 401, 1, NULL, NULL, NULL, 0),
(40121, 'UCHUMAYO', 401, 1, NULL, NULL, NULL, 0),
(40122, 'VITOR', 401, 1, NULL, NULL, NULL, 0),
(40123, 'YANAHUARA', 401, 1, NULL, NULL, NULL, 0),
(40124, 'YARABAMBA', 401, 1, NULL, NULL, NULL, 0),
(40125, 'YURA', 401, 1, NULL, NULL, NULL, 0),
(40126, 'MARIANO MELGAR', 401, 1, NULL, NULL, NULL, 0),
(40127, 'JACOBO HUNTER', 401, 1, NULL, NULL, NULL, 0),
(40128, 'ALTO SELVA ALEGRE', 401, 1, NULL, NULL, NULL, 0),
(40129, 'JOSE LUIS BUSTAMANTE Y RIVERO', 401, 1, NULL, NULL, NULL, 0),
(40201, 'CHIVAY', 402, 1, NULL, NULL, NULL, 0),
(40202, 'ACHOMA', 402, 1, NULL, NULL, NULL, 0),
(40203, 'CABANACONDE', 402, 1, NULL, NULL, NULL, 0),
(40204, 'CAYLLOMA', 402, 1, NULL, NULL, NULL, 0),
(40205, 'CALLALLI', 402, 1, NULL, NULL, NULL, 0),
(40206, 'COPORAQUE', 402, 1, NULL, NULL, NULL, 0),
(40207, 'HUAMBO', 402, 1, NULL, NULL, NULL, 0),
(40208, 'HUANCA', 402, 1, NULL, NULL, NULL, 0),
(40209, 'ICHUPAMPA', 402, 1, NULL, NULL, NULL, 0),
(40210, 'LARI', 402, 1, NULL, NULL, NULL, 0),
(40211, 'LLUTA', 402, 1, NULL, NULL, NULL, 0),
(40212, 'MACA', 402, 1, NULL, NULL, NULL, 0),
(40213, 'MADRIGAL', 402, 1, NULL, NULL, NULL, 0),
(40214, 'SAN ANTONIO DE CHUCA', 402, 1, NULL, NULL, NULL, 0),
(40215, 'SIBAYO', 402, 1, NULL, NULL, NULL, 0),
(40216, 'TAPAY', 402, 1, NULL, NULL, NULL, 0),
(40217, 'TISCO', 402, 1, NULL, NULL, NULL, 0),
(40218, 'TUTI', 402, 1, NULL, NULL, NULL, 0),
(40219, 'YANQUE', 402, 1, NULL, NULL, NULL, 0),
(40220, 'MAJES', 402, 1, NULL, NULL, NULL, 0),
(40301, 'CAMANA', 403, 1, NULL, NULL, NULL, 0),
(40302, 'JOSE MARIA QUIMPER', 403, 1, NULL, NULL, NULL, 0),
(40303, 'MARIANO N VALCARCEL', 403, 1, NULL, NULL, NULL, 0),
(40304, 'MARISCAL CACERES', 403, 1, NULL, NULL, NULL, 0),
(40305, 'NICOLAS DE PIEROLA', 403, 1, NULL, NULL, NULL, 0),
(40306, 'OCONA', 403, 1, NULL, NULL, NULL, 0),
(40307, 'QUILCA', 403, 1, NULL, NULL, NULL, 0),
(40308, 'SAMUEL PASTOR', 403, 1, NULL, NULL, NULL, 0),
(40401, 'CARAVELI', 404, 1, NULL, NULL, NULL, 0),
(40402, 'ACARI', 404, 1, NULL, NULL, NULL, 0),
(40403, 'ATICO', 404, 1, NULL, NULL, NULL, 0),
(40404, 'ATIQUIPA', 404, 1, NULL, NULL, NULL, 0),
(40405, 'BELLA UNION', 404, 1, NULL, NULL, NULL, 0),
(40406, 'CAHUACHO', 404, 1, NULL, NULL, NULL, 0),
(40407, 'CHALA', 404, 1, NULL, NULL, NULL, 0),
(40408, 'CHAPARRA', 404, 1, NULL, NULL, NULL, 0),
(40409, 'HUANUHUANU', 404, 1, NULL, NULL, NULL, 0),
(40410, 'JAQUI', 404, 1, NULL, NULL, NULL, 0),
(40411, 'LOMAS', 404, 1, NULL, NULL, NULL, 0),
(40412, 'QUICACHA', 404, 1, NULL, NULL, NULL, 0),
(40413, 'YAUCA', 404, 1, NULL, NULL, NULL, 0),
(40501, 'APLAO', 405, 1, NULL, NULL, NULL, 0),
(40502, 'ANDAGUA', 405, 1, NULL, NULL, NULL, 0),
(40503, 'AYO', 405, 1, NULL, NULL, NULL, 0),
(40504, 'CHACHAS', 405, 1, NULL, NULL, NULL, 0),
(40505, 'CHILCAYMARCA', 405, 1, NULL, NULL, NULL, 0),
(40506, 'CHOCO', 405, 1, NULL, NULL, NULL, 0),
(40507, 'HUANCARQUI', 405, 1, NULL, NULL, NULL, 0),
(40508, 'MACHAGUAY', 405, 1, NULL, NULL, NULL, 0),
(40509, 'ORCOPAMPA', 405, 1, NULL, NULL, NULL, 0),
(40510, 'PAMPACOLCA', 405, 1, NULL, NULL, NULL, 0),
(40511, 'TIPAN', 405, 1, NULL, NULL, NULL, 0),
(40512, 'URACA', 405, 1, NULL, NULL, NULL, 0),
(40513, 'UNON', 405, 1, NULL, NULL, NULL, 0),
(40514, 'VIRACO', 405, 1, NULL, NULL, NULL, 0),
(40601, 'CHUQUIBAMBA', 406, 1, NULL, NULL, NULL, 0),
(40602, 'ANDARAY', 406, 1, NULL, NULL, NULL, 0),
(40603, 'CAYARANI', 406, 1, NULL, NULL, NULL, 0),
(40604, 'CHICHAS', 406, 1, NULL, NULL, NULL, 0),
(40605, 'IRAY', 406, 1, NULL, NULL, NULL, 0),
(40606, 'SALAMANCA', 406, 1, NULL, NULL, NULL, 0),
(40607, 'YANAQUIHUA', 406, 1, NULL, NULL, NULL, 0),
(40608, 'RIO GRANDE', 406, 1, NULL, NULL, NULL, 0),
(40701, 'MOLLENDO', 407, 1, NULL, NULL, NULL, 0),
(40702, 'COCACHACRA', 407, 1, NULL, NULL, NULL, 0),
(40703, 'DEAN VALDIVIA', 407, 1, NULL, NULL, NULL, 0),
(40704, 'ISLAY', 407, 1, NULL, NULL, NULL, 0),
(40705, 'MEJIA', 407, 1, NULL, NULL, NULL, 0),
(40706, 'PUNTA DE BOMBON', 407, 1, NULL, NULL, NULL, 0),
(40801, 'COTAHUASI', 408, 1, NULL, NULL, NULL, 0),
(40802, 'ALCA', 408, 1, NULL, NULL, NULL, 0),
(40803, 'CHARCANA', 408, 1, NULL, NULL, NULL, 0),
(40804, 'HUAYNACOTAS', 408, 1, NULL, NULL, NULL, 0),
(40805, 'PAMPAMARCA', 408, 1, NULL, NULL, NULL, 0),
(40806, 'PUYCA', 408, 1, NULL, NULL, NULL, 0),
(40807, 'QUECHUALLA', 408, 1, NULL, NULL, NULL, 0),
(40808, 'SAYLA', 408, 1, NULL, NULL, NULL, 0),
(40809, 'TAURIA', 408, 1, NULL, NULL, NULL, 0),
(40810, 'TOMEPAMPA', 408, 1, NULL, NULL, NULL, 0),
(40811, 'TORO', 408, 1, NULL, NULL, NULL, 0),
(50101, 'AYACUCHO', 501, 1, NULL, NULL, NULL, 0),
(50102, 'ACOS VINCHOS', 501, 1, NULL, NULL, NULL, 0),
(50103, 'CARMEN ALTO', 501, 1, NULL, NULL, NULL, 0),
(50104, 'CHIARA', 501, 1, NULL, NULL, NULL, 0),
(50105, 'QUINUA', 501, 1, NULL, NULL, NULL, 0),
(50106, 'SAN JOSE DE TICLLAS', 501, 1, NULL, NULL, NULL, 0),
(50107, 'SAN JUAN BAUTISTA', 501, 1, NULL, NULL, NULL, 0),
(50108, 'SANTIAGO DE PISCHA', 501, 1, NULL, NULL, NULL, 0),
(50109, 'VINCHOS', 501, 1, NULL, NULL, NULL, 0),
(50110, 'TAMBILLO', 501, 1, NULL, NULL, NULL, 0),
(50111, 'ACOCRO', 501, 1, NULL, NULL, NULL, 0),
(50112, 'SOCOS', 501, 1, NULL, NULL, NULL, 0),
(50113, 'OCROS', 501, 1, NULL, NULL, NULL, 0),
(50114, 'PACAYCASA', 501, 1, NULL, NULL, NULL, 0),
(50115, 'JESUS NAZARENO', 501, 1, NULL, NULL, NULL, 0),
(50201, 'CANGALLO', 502, 1, NULL, NULL, NULL, 0),
(50204, 'CHUSCHI', 502, 1, NULL, NULL, NULL, 0),
(50206, 'LOS MOROCHUCOS', 502, 1, NULL, NULL, NULL, 0),
(50207, 'PARAS', 502, 1, NULL, NULL, NULL, 0),
(50208, 'TOTOS', 502, 1, NULL, NULL, NULL, 0),
(50211, 'MARIA PARADO DE BELLIDO', 502, 1, NULL, NULL, NULL, 0),
(50301, 'HUANTA', 503, 1, NULL, NULL, NULL, 0),
(50302, 'AYAHUANCO', 503, 1, NULL, NULL, NULL, 0),
(50303, 'HUAMANGUILLA', 503, 1, NULL, NULL, NULL, 0),
(50304, 'IGUAIN', 503, 1, NULL, NULL, NULL, 0),
(50305, 'LURICOCHA', 503, 1, NULL, NULL, NULL, 0),
(50307, 'SANTILLANA', 503, 1, NULL, NULL, NULL, 0),
(50308, 'SIVIA', 503, 1, NULL, NULL, NULL, 0),
(50309, 'LLOCHEGUA', 503, 1, NULL, NULL, NULL, 0),
(50401, 'SAN MIGUEL', 504, 1, NULL, NULL, NULL, 0),
(50402, 'ANCO', 504, 1, NULL, NULL, NULL, 0),
(50403, 'AYNA', 504, 1, NULL, NULL, NULL, 0),
(50404, 'CHILCAS', 504, 1, NULL, NULL, NULL, 0),
(50405, 'CHUNGUI', 504, 1, NULL, NULL, NULL, 0),
(50406, 'TAMBO', 504, 1, NULL, NULL, NULL, 0),
(50407, 'LUIS CARRANZA', 504, 1, NULL, NULL, NULL, 0),
(50408, 'SANTA ROSA', 504, 1, NULL, NULL, NULL, 0),
(50501, 'PUQUIO', 505, 1, NULL, NULL, NULL, 0),
(50502, 'AUCARA', 505, 1, NULL, NULL, NULL, 0),
(50503, 'CABANA', 505, 1, NULL, NULL, NULL, 0),
(50504, 'CARMEN SALCEDO', 505, 1, NULL, NULL, NULL, 0),
(50506, 'CHAVINA', 505, 1, NULL, NULL, NULL, 0),
(50508, 'CHIPAO', 505, 1, NULL, NULL, NULL, 0),
(50510, 'HUAC-HUAS', 505, 1, NULL, NULL, NULL, 0),
(50511, 'LARAMATE', 505, 1, NULL, NULL, NULL, 0),
(50512, 'LEONCIO PRADO', 505, 1, NULL, NULL, NULL, 0),
(50513, 'LUCANAS', 505, 1, NULL, NULL, NULL, 0),
(50514, 'LLAUTA', 505, 1, NULL, NULL, NULL, 0),
(50516, 'OCANA', 505, 1, NULL, NULL, NULL, 0),
(50517, 'OTOCA', 505, 1, NULL, NULL, NULL, 0),
(50520, 'SANCOS', 505, 1, NULL, NULL, NULL, 0),
(50521, 'SAN JUAN', 505, 1, NULL, NULL, NULL, 0),
(50522, 'SAN PEDRO', 505, 1, NULL, NULL, NULL, 0),
(50524, 'STA ANA DE HUAYCAHUACHO', 505, 1, NULL, NULL, NULL, 0),
(50525, 'SANTA LUCIA', 505, 1, NULL, NULL, NULL, 0),
(50529, 'SAISA', 505, 1, NULL, NULL, NULL, 0),
(50531, 'SAN PEDRO DE PALCO', 505, 1, NULL, NULL, NULL, 0),
(50532, 'SAN CRISTOBAL', 505, 1, NULL, NULL, NULL, 0),
(50601, 'CORACORA', 506, 1, NULL, NULL, NULL, 0),
(50604, 'CORONEL CASTANEDA', 506, 1, NULL, NULL, NULL, 0),
(50605, 'CHUMPI', 506, 1, NULL, NULL, NULL, 0),
(50608, 'PACAPAUSA', 506, 1, NULL, NULL, NULL, 0),
(50611, 'PULLO', 506, 1, NULL, NULL, NULL, 0),
(50612, 'PUYUSCA', 506, 1, NULL, NULL, NULL, 0),
(50615, 'SAN FCO DE RAVACAYCO', 506, 1, NULL, NULL, NULL, 0),
(50616, 'UPAHUACHO', 506, 1, NULL, NULL, NULL, 0),
(50701, 'HUANCAPI', 507, 1, NULL, NULL, NULL, 0),
(50702, 'ALCAMENCA', 507, 1, NULL, NULL, NULL, 0),
(50703, 'APONGO', 507, 1, NULL, NULL, NULL, 0),
(50704, 'CANARIA', 507, 1, NULL, NULL, NULL, 0),
(50706, 'CAYARA', 507, 1, NULL, NULL, NULL, 0),
(50707, 'COLCA', 507, 1, NULL, NULL, NULL, 0),
(50708, 'HUAYA', 507, 1, NULL, NULL, NULL, 0),
(50709, 'HUAMANQUIQUIA', 507, 1, NULL, NULL, NULL, 0),
(50710, 'HUANCARAYLLA', 507, 1, NULL, NULL, NULL, 0),
(50713, 'SARHUA', 507, 1, NULL, NULL, NULL, 0),
(50714, 'VILCANCHOS', 507, 1, NULL, NULL, NULL, 0),
(50715, 'ASQUIPATA', 507, 1, NULL, NULL, NULL, 0),
(50801, 'SANCOS', 508, 1, NULL, NULL, NULL, 0),
(50802, 'SACSAMARCA', 508, 1, NULL, NULL, NULL, 0),
(50803, 'SANTIAGO DE LUCANAMARCA', 508, 1, NULL, NULL, NULL, 0),
(50804, 'CARAPO', 508, 1, NULL, NULL, NULL, 0),
(50901, 'VILCAS HUAMAN', 509, 1, NULL, NULL, NULL, 0),
(50902, 'VISCHONGO', 509, 1, NULL, NULL, NULL, 0),
(50903, 'ACCOMARCA', 509, 1, NULL, NULL, NULL, 0),
(50904, 'CARHUANCA', 509, 1, NULL, NULL, NULL, 0),
(50905, 'CONCEPCION', 509, 1, NULL, NULL, NULL, 0),
(50906, 'HUAMBALPA', 509, 1, NULL, NULL, NULL, 0),
(50907, 'SAURAMA', 509, 1, NULL, NULL, NULL, 0),
(50908, 'INDEPENDENCIA', 509, 1, NULL, NULL, NULL, 0),
(51001, 'PAUSA', 510, 1, NULL, NULL, NULL, 0),
(51002, 'COLTA', 510, 1, NULL, NULL, NULL, 0),
(51003, 'CORCULLA', 510, 1, NULL, NULL, NULL, 0),
(51004, 'LAMPA', 510, 1, NULL, NULL, NULL, 0),
(51005, 'MARCABAMBA', 510, 1, NULL, NULL, NULL, 0),
(51006, 'OYOLO', 510, 1, NULL, NULL, NULL, 0),
(51007, 'PARARCA', 510, 1, NULL, NULL, NULL, 0),
(51008, 'SAN JAVIER DE ALPABAMBA', 510, 1, NULL, NULL, NULL, 0),
(51009, 'SAN JOSE DE USHUA', 510, 1, NULL, NULL, NULL, 0),
(51010, 'SARA SARA', 510, 1, NULL, NULL, NULL, 0),
(51101, 'QUEROBAMBA', 511, 1, NULL, NULL, NULL, 0),
(51102, 'BELEN', 511, 1, NULL, NULL, NULL, 0),
(51103, 'CHALCOS', 511, 1, NULL, NULL, NULL, 0),
(51104, 'SAN SALVADOR DE QUIJE', 511, 1, NULL, NULL, NULL, 0),
(51105, 'PAICO', 511, 1, NULL, NULL, NULL, 0),
(51106, 'SANTIAGO DE PAUCARAY', 511, 1, NULL, NULL, NULL, 0),
(51107, 'SAN PEDRO DE LARCAY', 511, 1, NULL, NULL, NULL, 0),
(51108, 'SORAS', 511, 1, NULL, NULL, NULL, 0),
(51109, 'HUACANA', 511, 1, NULL, NULL, NULL, 0),
(51110, 'CHILCAYOC', 511, 1, NULL, NULL, NULL, 0),
(51111, 'MORCOLLA', 511, 1, NULL, NULL, NULL, 0),
(60101, 'CAJAMARCA', 601, 1, NULL, NULL, NULL, 0),
(60102, 'ASUNCION', 601, 1, NULL, NULL, NULL, 0),
(60103, 'COSPAN', 601, 1, NULL, NULL, NULL, 0),
(60104, 'CHETILLA', 601, 1, NULL, NULL, NULL, 0),
(60105, 'ENCANADA', 601, 1, NULL, NULL, NULL, 0),
(60106, 'JESUS', 601, 1, NULL, NULL, NULL, 0),
(60107, 'LOS BANOS DEL INCA', 601, 1, NULL, NULL, NULL, 0),
(60108, 'LLACANORA', 601, 1, NULL, NULL, NULL, 0),
(60109, 'MAGDALENA', 601, 1, NULL, NULL, NULL, 0),
(60110, 'MATARA', 601, 1, NULL, NULL, NULL, 0),
(60111, 'NAMORA', 601, 1, NULL, NULL, NULL, 0),
(60112, 'SAN JUAN', 601, 1, NULL, NULL, NULL, 0),
(60201, 'CAJABAMBA', 602, 1, NULL, NULL, NULL, 0),
(60202, 'CACHACHI', 602, 1, NULL, NULL, NULL, 0),
(60203, 'CONDEBAMBA', 602, 1, NULL, NULL, NULL, 0),
(60205, 'SITACOCHA', 602, 1, NULL, NULL, NULL, 0),
(60301, 'CELENDIN', 603, 1, NULL, NULL, NULL, 0),
(60302, 'CORTEGANA', 603, 1, NULL, NULL, NULL, 0),
(60303, 'CHUMUCH', 603, 1, NULL, NULL, NULL, 0),
(60304, 'HUASMIN', 603, 1, NULL, NULL, NULL, 0),
(60305, 'JORGE CHAVEZ', 603, 1, NULL, NULL, NULL, 0),
(60306, 'JOSE GALVEZ', 603, 1, NULL, NULL, NULL, 0),
(60307, 'MIGUEL IGLESIAS', 603, 1, NULL, NULL, NULL, 0),
(60308, 'OXAMARCA', 603, 1, NULL, NULL, NULL, 0),
(60309, 'SOROCHUCO', 603, 1, NULL, NULL, NULL, 0),
(60310, 'SUCRE', 603, 1, NULL, NULL, NULL, 0),
(60311, 'UTCO', 603, 1, NULL, NULL, NULL, 0),
(60312, 'LA LIBERTAD DE PALLAN', 603, 1, NULL, NULL, NULL, 0),
(60401, 'CONTUMAZA', 604, 1, NULL, NULL, NULL, 0),
(60403, 'CHILETE', 604, 1, NULL, NULL, NULL, 0),
(60404, 'GUZMANGO', 604, 1, NULL, NULL, NULL, 0),
(60405, 'SAN BENITO', 604, 1, NULL, NULL, NULL, 0),
(60406, 'CUPISNIQUE', 604, 1, NULL, NULL, NULL, 0),
(60407, 'TANTARICA', 604, 1, NULL, NULL, NULL, 0),
(60408, 'YONAN', 604, 1, NULL, NULL, NULL, 0),
(60409, 'STA CRUZ DE TOLEDO', 604, 1, NULL, NULL, NULL, 0),
(60501, 'CUTERVO', 605, 1, NULL, NULL, NULL, 0),
(60502, 'CALLAYUC', 605, 1, NULL, NULL, NULL, 0),
(60503, 'CUJILLO', 605, 1, NULL, NULL, NULL, 0),
(60504, 'CHOROS', 605, 1, NULL, NULL, NULL, 0),
(60505, 'LA RAMADA', 605, 1, NULL, NULL, NULL, 0),
(60506, 'PIMPINGOS', 605, 1, NULL, NULL, NULL, 0),
(60507, 'QUEROCOTILLO', 605, 1, NULL, NULL, NULL, 0),
(60508, 'SAN ANDRES DE CUTERVO', 605, 1, NULL, NULL, NULL, 0),
(60509, 'SAN JUAN DE CUTERVO', 605, 1, NULL, NULL, NULL, 0),
(60510, 'SAN LUIS DE LUCMA', 605, 1, NULL, NULL, NULL, 0),
(60511, 'SANTA CRUZ', 605, 1, NULL, NULL, NULL, 0),
(60512, 'SANTO DOMINGO DE LA CAPILLA', 605, 1, NULL, NULL, NULL, 0),
(60513, 'SANTO TOMAS', 605, 1, NULL, NULL, NULL, 0),
(60514, 'SOCOTA', 605, 1, NULL, NULL, NULL, 0),
(60515, 'TORIBIO CASANOVA', 605, 1, NULL, NULL, NULL, 0),
(60601, 'CHOTA', 606, 1, NULL, NULL, NULL, 0),
(60602, 'ANGUIA', 606, 1, NULL, NULL, NULL, 0),
(60603, 'COCHABAMBA', 606, 1, NULL, NULL, NULL, 0),
(60604, 'CONCHAN', 606, 1, NULL, NULL, NULL, 0),
(60605, 'CHADIN', 606, 1, NULL, NULL, NULL, 0),
(60606, 'CHIGUIRIP', 606, 1, NULL, NULL, NULL, 0),
(60607, 'CHIMBAN', 606, 1, NULL, NULL, NULL, 0),
(60608, 'HUAMBOS', 606, 1, NULL, NULL, NULL, 0),
(60609, 'LAJAS', 606, 1, NULL, NULL, NULL, 0),
(60610, 'LLAMA', 606, 1, NULL, NULL, NULL, 0),
(60611, 'MIRACOSTA', 606, 1, NULL, NULL, NULL, 0),
(60612, 'PACCHA', 606, 1, NULL, NULL, NULL, 0),
(60613, 'PION', 606, 1, NULL, NULL, NULL, 0),
(60614, 'QUEROCOTO', 606, 1, NULL, NULL, NULL, 0),
(60615, 'TACABAMBA', 606, 1, NULL, NULL, NULL, 0),
(60616, 'TOCMOCHE', 606, 1, NULL, NULL, NULL, 0),
(60617, 'SAN JUAN DE LICUPIS', 606, 1, NULL, NULL, NULL, 0),
(60618, 'CHOROPAMPA', 606, 1, NULL, NULL, NULL, 0),
(60619, 'CHALAMARCA', 606, 1, NULL, NULL, NULL, 0),
(60701, 'BAMBAMARCA', 607, 1, NULL, NULL, NULL, 0),
(60702, 'CHUGUR', 607, 1, NULL, NULL, NULL, 0),
(60703, 'HUALGAYOC', 607, 1, NULL, NULL, NULL, 0),
(60801, 'JAEN', 608, 1, NULL, NULL, NULL, 0),
(60802, 'BELLAVISTA', 608, 1, NULL, NULL, NULL, 0),
(60803, 'COLASAY', 608, 1, NULL, NULL, NULL, 0),
(60804, 'CHONTALI', 608, 1, NULL, NULL, NULL, 0),
(60805, 'POMAHUACA', 608, 1, NULL, NULL, NULL, 0),
(60806, 'PUCARA', 608, 1, NULL, NULL, NULL, 0),
(60807, 'SALLIQUE', 608, 1, NULL, NULL, NULL, 0),
(60808, 'SAN FELIPE', 608, 1, NULL, NULL, NULL, 0),
(60809, 'SAN JOSE DEL ALTO', 608, 1, NULL, NULL, NULL, 0),
(60810, 'SANTA ROSA', 608, 1, NULL, NULL, NULL, 0),
(60811, 'LAS PIRIAS', 608, 1, NULL, NULL, NULL, 0),
(60812, 'HUABAL', 608, 1, NULL, NULL, NULL, 0),
(60901, 'SANTA CRUZ', 609, 1, NULL, NULL, NULL, 0),
(60902, 'CATACHE', 609, 1, NULL, NULL, NULL, 0),
(60903, 'CHANCAIBANOS', 609, 1, NULL, NULL, NULL, 0),
(60904, 'LA ESPERANZA', 609, 1, NULL, NULL, NULL, 0),
(60905, 'NINABAMBA', 609, 1, NULL, NULL, NULL, 0),
(60906, 'PULAN', 609, 1, NULL, NULL, NULL, 0),
(60907, 'SEXI', 609, 1, NULL, NULL, NULL, 0),
(60908, 'UTICYACU', 609, 1, NULL, NULL, NULL, 0),
(60909, 'YAUYUCAN', 609, 1, NULL, NULL, NULL, 0),
(60910, 'ANDABAMBA', 609, 1, NULL, NULL, NULL, 0),
(60911, 'SAUCEPAMPA', 609, 1, NULL, NULL, NULL, 0),
(61001, 'SAN MIGUEL', 610, 1, NULL, NULL, NULL, 0),
(61002, 'CALQUIS', 610, 1, NULL, NULL, NULL, 0),
(61003, 'LA FLORIDA', 610, 1, NULL, NULL, NULL, 0),
(61004, 'LLAPA', 610, 1, NULL, NULL, NULL, 0),
(61005, 'NANCHOC', 610, 1, NULL, NULL, NULL, 0),
(61006, 'NIEPOS', 610, 1, NULL, NULL, NULL, 0),
(61007, 'SAN GREGORIO', 610, 1, NULL, NULL, NULL, 0),
(61008, 'SAN SILVESTRE DE COCHAN', 610, 1, NULL, NULL, NULL, 0),
(61009, 'EL PRADO', 610, 1, NULL, NULL, NULL, 0),
(61010, 'UNION AGUA BLANCA', 610, 1, NULL, NULL, NULL, 0),
(61011, 'TONGOD', 610, 1, NULL, NULL, NULL, 0),
(61012, 'CATILLUC', 610, 1, NULL, NULL, NULL, 0),
(61013, 'BOLIVAR', 610, 1, NULL, NULL, NULL, 0),
(61101, 'SAN IGNACIO', 611, 1, NULL, NULL, NULL, 0),
(61102, 'CHIRINOS', 611, 1, NULL, NULL, NULL, 0),
(61103, 'HUARANGO', 611, 1, NULL, NULL, NULL, 0),
(61104, 'NAMBALLE', 611, 1, NULL, NULL, NULL, 0),
(61105, 'LA COIPA', 611, 1, NULL, NULL, NULL, 0),
(61106, 'SAN JOSE DE LOURDES', 611, 1, NULL, NULL, NULL, 0),
(61107, 'TABACONAS', 611, 1, NULL, NULL, NULL, 0),
(61201, 'PEDRO GALVEZ', 612, 1, NULL, NULL, NULL, 0),
(61202, 'ICHOCAN', 612, 1, NULL, NULL, NULL, 0),
(61203, 'GREGORIO PITA', 612, 1, NULL, NULL, NULL, 0),
(61204, 'JOSE MANUEL QUIROZ', 612, 1, NULL, NULL, NULL, 0),
(61205, 'EDUARDO VILLANUEVA', 612, 1, NULL, NULL, NULL, 0),
(61206, 'JOSE SABOGAL', 612, 1, NULL, NULL, NULL, 0),
(61207, 'CHANCAY', 612, 1, NULL, NULL, NULL, 0),
(61301, 'SAN PABLO', 613, 1, NULL, NULL, NULL, 0),
(61302, 'SAN BERNARDINO', 613, 1, NULL, NULL, NULL, 0),
(61303, 'SAN LUIS', 613, 1, NULL, NULL, NULL, 0),
(61304, 'TUMBADEN', 613, 1, NULL, NULL, NULL, 0),
(70101, 'CUSCO', 701, 1, NULL, NULL, NULL, 0),
(70102, 'CCORCA', 701, 1, NULL, NULL, NULL, 0),
(70103, 'POROY', 701, 1, NULL, NULL, NULL, 0),
(70104, 'SAN JERONIMO', 701, 1, NULL, NULL, NULL, 0),
(70105, 'SAN SEBASTIAN', 701, 1, NULL, NULL, NULL, 0),
(70106, 'SANTIAGO', 701, 1, NULL, NULL, NULL, 0),
(70107, 'SAYLLA', 701, 1, NULL, NULL, NULL, 0),
(70108, 'WANCHAQ', 701, 1, NULL, NULL, NULL, 0),
(70201, 'ACOMAYO', 702, 1, NULL, NULL, NULL, 0),
(70202, 'ACOPIA', 702, 1, NULL, NULL, NULL, 0),
(70203, 'ACOS', 702, 1, NULL, NULL, NULL, 0),
(70204, 'POMACANCHI', 702, 1, NULL, NULL, NULL, 0),
(70205, 'RONDOCAN', 702, 1, NULL, NULL, NULL, 0),
(70206, 'SANGARARA', 702, 1, NULL, NULL, NULL, 0),
(70207, 'MOSOC LLACTA', 702, 1, NULL, NULL, NULL, 0),
(70301, 'ANTA', 703, 1, NULL, NULL, NULL, 0),
(70302, 'CHINCHAYPUJIO', 703, 1, NULL, NULL, NULL, 0),
(70303, 'HUAROCONDO', 703, 1, NULL, NULL, NULL, 0),
(70304, 'LIMATAMBO', 703, 1, NULL, NULL, NULL, 0),
(70305, 'MOLLEPATA', 703, 1, NULL, NULL, NULL, 0),
(70306, 'PUCYURA', 703, 1, NULL, NULL, NULL, 0),
(70307, 'ZURITE', 703, 1, NULL, NULL, NULL, 0),
(70308, 'CACHIMAYO', 703, 1, NULL, NULL, NULL, 0),
(70309, 'ANCAHUASI', 703, 1, NULL, NULL, NULL, 0),
(70401, 'CALCA', 704, 1, NULL, NULL, NULL, 0),
(70402, 'COYA', 704, 1, NULL, NULL, NULL, 0),
(70403, 'LAMAY', 704, 1, NULL, NULL, NULL, 0),
(70404, 'LARES', 704, 1, NULL, NULL, NULL, 0),
(70405, 'PISAC', 704, 1, NULL, NULL, NULL, 0),
(70406, 'SAN SALVADOR', 704, 1, NULL, NULL, NULL, 0),
(70407, 'TARAY', 704, 1, NULL, NULL, NULL, 0),
(70408, 'YANATILE', 704, 1, NULL, NULL, NULL, 0),
(70501, 'YANAOCA', 705, 1, NULL, NULL, NULL, 0),
(70502, 'CHECCA', 705, 1, NULL, NULL, NULL, 0),
(70503, 'KUNTURKANKI', 705, 1, NULL, NULL, NULL, 0),
(70504, 'LANGUI', 705, 1, NULL, NULL, NULL, 0),
(70505, 'LAYO', 705, 1, NULL, NULL, NULL, 0),
(70506, 'PAMPAMARCA', 705, 1, NULL, NULL, NULL, 0),
(70507, 'QUEHUE', 705, 1, NULL, NULL, NULL, 0),
(70508, 'TUPAC AMARU', 705, 1, NULL, NULL, NULL, 0),
(70601, 'SICUANI', 706, 1, NULL, NULL, NULL, 0),
(70602, 'COMBAPATA', 706, 1, NULL, NULL, NULL, 0),
(70603, 'CHECACUPE', 706, 1, NULL, NULL, NULL, 0),
(70604, 'MARANGANI', 706, 1, NULL, NULL, NULL, 0),
(70605, 'PITUMARCA', 706, 1, NULL, NULL, NULL, 0),
(70606, 'SAN PABLO', 706, 1, NULL, NULL, NULL, 0),
(70607, 'SAN PEDRO', 706, 1, NULL, NULL, NULL, 0),
(70608, 'TINTA', 706, 1, NULL, NULL, NULL, 0),
(70701, 'SANTO TOMAS', 707, 1, NULL, NULL, NULL, 0),
(70702, 'CAPACMARCA', 707, 1, NULL, NULL, NULL, 0),
(70703, 'COLQUEMARCA', 707, 1, NULL, NULL, NULL, 0),
(70704, 'CHAMACA', 707, 1, NULL, NULL, NULL, 0),
(70705, 'LIVITACA', 707, 1, NULL, NULL, NULL, 0),
(70706, 'LLUSCO', 707, 1, NULL, NULL, NULL, 0),
(70707, 'QUINOTA', 707, 1, NULL, NULL, NULL, 0),
(70708, 'VELILLE', 707, 1, NULL, NULL, NULL, 0),
(70801, 'ESPINAR', 708, 1, NULL, NULL, NULL, 0),
(70802, 'CONDOROMA', 708, 1, NULL, NULL, NULL, 0),
(70803, 'COPORAQUE', 708, 1, NULL, NULL, NULL, 0),
(70804, 'OCORURO', 708, 1, NULL, NULL, NULL, 0),
(70805, 'PALLPATA', 708, 1, NULL, NULL, NULL, 0),
(70806, 'PICHIGUA', 708, 1, NULL, NULL, NULL, 0),
(70807, 'SUYKUTAMBO', 708, 1, NULL, NULL, NULL, 0),
(70808, 'ALTO PICHIGUA', 708, 1, NULL, NULL, NULL, 0),
(70901, 'SANTA ANA', 709, 1, NULL, NULL, NULL, 0),
(70902, 'ECHARATE', 709, 1, NULL, NULL, NULL, 0),
(70903, 'HUAYOPATA', 709, 1, NULL, NULL, NULL, 0),
(70904, 'MARANURA', 709, 1, NULL, NULL, NULL, 0),
(70905, 'OCOBAMBA', 709, 1, NULL, NULL, NULL, 0),
(70906, 'SANTA TERESA', 709, 1, NULL, NULL, NULL, 0),
(70907, 'VILCABAMBA', 709, 1, NULL, NULL, NULL, 0),
(70908, 'QUELLOUNO', 709, 1, NULL, NULL, NULL, 0),
(70909, 'KIMBIRI', 709, 1, NULL, NULL, NULL, 0),
(70910, 'PICHARI', 709, 1, NULL, NULL, NULL, 0),
(71001, 'PARURO', 710, 1, NULL, NULL, NULL, 0),
(71002, 'ACCHA', 710, 1, NULL, NULL, NULL, 0),
(71003, 'CCAPI', 710, 1, NULL, NULL, NULL, 0),
(71004, 'COLCHA', 710, 1, NULL, NULL, NULL, 0),
(71005, 'HUANOQUITE', 710, 1, NULL, NULL, NULL, 0),
(71006, 'OMACHA', 710, 1, NULL, NULL, NULL, 0),
(71007, 'YAURISQUE', 710, 1, NULL, NULL, NULL, 0),
(71008, 'PACCARITAMBO', 710, 1, NULL, NULL, NULL, 0),
(71009, 'PILLPINTO', 710, 1, NULL, NULL, NULL, 0),
(71101, 'PAUCARTAMBO', 711, 1, NULL, NULL, NULL, 0),
(71102, 'CAICAY', 711, 1, NULL, NULL, NULL, 0),
(71103, 'COLQUEPATA', 711, 1, NULL, NULL, NULL, 0),
(71104, 'CHALLABAMBA', 711, 1, NULL, NULL, NULL, 0),
(71105, 'COSNIPATA', 711, 1, NULL, NULL, NULL, 0),
(71106, 'HUANCARANI', 711, 1, NULL, NULL, NULL, 0),
(71201, 'URCOS', 712, 1, NULL, NULL, NULL, 0),
(71202, 'ANDAHUAYLILLAS', 712, 1, NULL, NULL, NULL, 0),
(71203, 'CAMANTI', 712, 1, NULL, NULL, NULL, 0),
(71204, 'CCARHUAYO', 712, 1, NULL, NULL, NULL, 0),
(71205, 'CCATCA', 712, 1, NULL, NULL, NULL, 0),
(71206, 'CUSIPATA', 712, 1, NULL, NULL, NULL, 0),
(71207, 'HUARO', 712, 1, NULL, NULL, NULL, 0),
(71208, 'LUCRE', 712, 1, NULL, NULL, NULL, 0),
(71209, 'MARCAPATA', 712, 1, NULL, NULL, NULL, 0),
(71210, 'OCONGATE', 712, 1, NULL, NULL, NULL, 0),
(71211, 'OROPESA', 712, 1, NULL, NULL, NULL, 0),
(71212, 'QUIQUIJANA', 712, 1, NULL, NULL, NULL, 0),
(71301, 'URUBAMBA', 713, 1, NULL, NULL, NULL, 0),
(71302, 'CHINCHERO', 713, 1, NULL, NULL, NULL, 0),
(71303, 'HUAYLLABAMBA', 713, 1, NULL, NULL, NULL, 0),
(71304, 'MACHUPICCHU', 713, 1, NULL, NULL, NULL, 0),
(71305, 'MARAS', 713, 1, NULL, NULL, NULL, 0),
(71306, 'OLLANTAYTAMBO', 713, 1, NULL, NULL, NULL, 0),
(71307, 'YUCAY', 713, 1, NULL, NULL, NULL, 0),
(80101, 'HUANCAVELICA', 801, 1, NULL, NULL, NULL, 0),
(80102, 'ACOBAMBILLA', 801, 1, NULL, NULL, NULL, 0),
(80103, 'ACORIA', 801, 1, NULL, NULL, NULL, 0),
(80104, 'CONAYCA', 801, 1, NULL, NULL, NULL, 0),
(80105, 'CUENCA', 801, 1, NULL, NULL, NULL, 0),
(80106, 'HUACHOCOLPA', 801, 1, NULL, NULL, NULL, 0),
(80108, 'HUAYLLAHUARA', 801, 1, NULL, NULL, NULL, 0),
(80109, 'IZCUCHACA', 801, 1, NULL, NULL, NULL, 0),
(80110, 'LARIA', 801, 1, NULL, NULL, NULL, 0),
(80111, 'MANTA', 801, 1, NULL, NULL, NULL, 0),
(80112, 'MARISCAL CACERES', 801, 1, NULL, NULL, NULL, 0),
(80113, 'MOYA', 801, 1, NULL, NULL, NULL, 0),
(80114, 'NUEVO OCCORO', 801, 1, NULL, NULL, NULL, 0),
(80115, 'PALCA', 801, 1, NULL, NULL, NULL, 0),
(80116, 'PILCHACA', 801, 1, NULL, NULL, NULL, 0),
(80117, 'VILCA', 801, 1, NULL, NULL, NULL, 0),
(80118, 'YAULI', 801, 1, NULL, NULL, NULL, 0),
(80119, 'ASCENCION', 801, 1, NULL, NULL, NULL, 0),
(80120, 'HUANDO', 801, 1, NULL, NULL, NULL, 0),
(80201, 'ACOBAMBA', 802, 1, NULL, NULL, NULL, 0),
(80202, 'ANTA', 802, 1, NULL, NULL, NULL, 0),
(80203, 'ANDABAMBA', 802, 1, NULL, NULL, NULL, 0),
(80204, 'CAJA', 802, 1, NULL, NULL, NULL, 0),
(80205, 'MARCAS', 802, 1, NULL, NULL, NULL, 0),
(80206, 'PAUCARA', 802, 1, NULL, NULL, NULL, 0),
(80207, 'POMACOCHA', 802, 1, NULL, NULL, NULL, 0),
(80208, 'ROSARIO', 802, 1, NULL, NULL, NULL, 0),
(80301, 'LIRCAY', 803, 1, NULL, NULL, NULL, 0),
(80302, 'ANCHONGA', 803, 1, NULL, NULL, NULL, 0),
(80303, 'CALLANMARCA', 803, 1, NULL, NULL, NULL, 0),
(80304, 'CONGALLA', 803, 1, NULL, NULL, NULL, 0),
(80305, 'CHINCHO', 803, 1, NULL, NULL, NULL, 0),
(80306, 'HUAYLLAY GRANDE', 803, 1, NULL, NULL, NULL, 0),
(80307, 'HUANCA HUANCA', 803, 1, NULL, NULL, NULL, 0),
(80308, 'JULCAMARCA', 803, 1, NULL, NULL, NULL, 0),
(80309, 'SAN ANTONIO DE ANTAPARCO', 803, 1, NULL, NULL, NULL, 0),
(80310, 'STO TOMAS DE PATA', 803, 1, NULL, NULL, NULL, 0),
(80311, 'SECCLLA', 803, 1, NULL, NULL, NULL, 0),
(80312, 'CCOCHACCASA', 803, 1, NULL, NULL, NULL, 0),
(80401, 'CASTROVIRREYNA', 804, 1, NULL, NULL, NULL, 0),
(80402, 'ARMA', 804, 1, NULL, NULL, NULL, 0),
(80403, 'AURAHUA', 804, 1, NULL, NULL, NULL, 0),
(80405, 'CAPILLAS', 804, 1, NULL, NULL, NULL, 0),
(80406, 'COCAS', 804, 1, NULL, NULL, NULL, 0),
(80408, 'CHUPAMARCA', 804, 1, NULL, NULL, NULL, 0),
(80409, 'HUACHOS', 804, 1, NULL, NULL, NULL, 0),
(80410, 'HUAMATAMBO', 804, 1, NULL, NULL, NULL, 0),
(80414, 'MOLLEPAMPA', 804, 1, NULL, NULL, NULL, 0),
(80422, 'SAN JUAN', 804, 1, NULL, NULL, NULL, 0),
(80427, 'TANTARA', 804, 1, NULL, NULL, NULL, 0),
(80428, 'TICRAPO', 804, 1, NULL, NULL, NULL, 0),
(80429, 'SANTA ANA', 804, 1, NULL, NULL, NULL, 0),
(80501, 'PAMPAS', 805, 1, NULL, NULL, NULL, 0),
(80502, 'ACOSTAMBO', 805, 1, NULL, NULL, NULL, 0),
(80503, 'ACRAQUIA', 805, 1, NULL, NULL, NULL, 0),
(80504, 'AHUAYCHA', 805, 1, NULL, NULL, NULL, 0),
(80506, 'COLCABAMBA', 805, 1, NULL, NULL, NULL, 0),
(80509, 'DANIEL HERNANDEZ', 805, 1, NULL, NULL, NULL, 0),
(80511, 'HUACHOCOLPA', 805, 1, NULL, NULL, NULL, 0),
(80512, 'HUARIBAMBA', 805, 1, NULL, NULL, NULL, 0),
(80515, 'NAHUIMPUQUIO', 805, 1, NULL, NULL, NULL, 0),
(80517, 'PAZOS', 805, 1, NULL, NULL, NULL, 0),
(80518, 'QUISHUAR', 805, 1, NULL, NULL, NULL, 0),
(80519, 'SALCABAMBA', 805, 1, NULL, NULL, NULL, 0),
(80520, 'SAN MARCOS DE ROCCHAC', 805, 1, NULL, NULL, NULL, 0),
(80523, 'SURCUBAMBA', 805, 1, NULL, NULL, NULL, 0),
(80525, 'TINTAY PUNCU', 805, 1, NULL, NULL, NULL, 0),
(80526, 'SALCAHUASI', 805, 1, NULL, NULL, NULL, 0),
(80601, 'AYAVI', 806, 1, NULL, NULL, NULL, 0),
(80602, 'CORDOVA', 806, 1, NULL, NULL, NULL, 0),
(80603, 'HUAYACUNDO ARMA', 806, 1, NULL, NULL, NULL, 0),
(80604, 'HUAYTARA', 806, 1, NULL, NULL, NULL, 0),
(80605, 'LARAMARCA', 806, 1, NULL, NULL, NULL, 0),
(80606, 'OCOYO', 806, 1, NULL, NULL, NULL, 0),
(80607, 'PILPICHACA', 806, 1, NULL, NULL, NULL, 0),
(80608, 'QUERCO', 806, 1, NULL, NULL, NULL, 0),
(80609, 'QUITO ARMA', 806, 1, NULL, NULL, NULL, 0),
(80610, 'SAN ANTONIO DE CUSICANCHA', 806, 1, NULL, NULL, NULL, 0),
(80611, 'SAN FRANCISCO DE SANGAYAICO', 806, 1, NULL, NULL, NULL, 0),
(80612, 'SAN ISIDRO', 806, 1, NULL, NULL, NULL, 0),
(80613, 'SANTIAGO DE CHOCORVOS', 806, 1, NULL, NULL, NULL, 0),
(80614, 'SANTIAGO DE QUIRAHUARA', 806, 1, NULL, NULL, NULL, 0),
(80615, 'SANTO DOMINGO DE CAPILLA', 806, 1, NULL, NULL, NULL, 0),
(80616, 'TAMBO', 806, 1, NULL, NULL, NULL, 0),
(80701, 'CHURCAMPA', 807, 1, NULL, NULL, NULL, 0),
(80702, 'ANCO', 807, 1, NULL, NULL, NULL, 0),
(80703, 'CHINCHIHUASI', 807, 1, NULL, NULL, NULL, 0),
(80704, 'EL CARMEN', 807, 1, NULL, NULL, NULL, 0),
(80705, 'LA MERCED', 807, 1, NULL, NULL, NULL, 0),
(80706, 'LOCROJA', 807, 1, NULL, NULL, NULL, 0),
(80707, 'PAUCARBAMBA', 807, 1, NULL, NULL, NULL, 0),
(80708, 'SAN MIGUEL DE MAYOC', 807, 1, NULL, NULL, NULL, 0),
(80709, 'SAN PEDRO DE CORIS', 807, 1, NULL, NULL, NULL, 0),
(80710, 'PACHAMARCA', 807, 1, NULL, NULL, NULL, 0),
(90101, 'HUANUCO', 901, 1, NULL, NULL, NULL, 0),
(90102, 'CHINCHAO', 901, 1, NULL, NULL, NULL, 0),
(90103, 'CHURUBAMBA', 901, 1, NULL, NULL, NULL, 0),
(90104, 'MARGOS', 901, 1, NULL, NULL, NULL, 0),
(90105, 'QUISQUI', 901, 1, NULL, NULL, NULL, 0),
(90106, 'SAN FCO DE CAYRAN', 901, 1, NULL, NULL, NULL, 0),
(90107, 'SAN PEDRO DE CHAULAN', 901, 1, NULL, NULL, NULL, 0),
(90108, 'STA MARIA DEL VALLE', 901, 1, NULL, NULL, NULL, 0),
(90109, 'YARUMAYO', 901, 1, NULL, NULL, NULL, 0),
(90110, 'AMARILIS', 901, 1, NULL, NULL, NULL, 0),
(90111, 'PILLCO MARCA', 901, 1, NULL, NULL, NULL, 0),
(90201, 'AMBO', 902, 1, NULL, NULL, NULL, 0),
(90202, 'CAYNA', 902, 1, NULL, NULL, NULL, 0),
(90203, 'COLPAS', 902, 1, NULL, NULL, NULL, 0),
(90204, 'CONCHAMARCA', 902, 1, NULL, NULL, NULL, 0),
(90205, 'HUACAR', 902, 1, NULL, NULL, NULL, 0),
(90206, 'SAN FRANCISCO', 902, 1, NULL, NULL, NULL, 0),
(90207, 'SAN RAFAEL', 902, 1, NULL, NULL, NULL, 0),
(90208, 'TOMAY KICHWA', 902, 1, NULL, NULL, NULL, 0),
(90301, 'LA UNION', 903, 1, NULL, NULL, NULL, 0),
(90307, 'CHUQUIS', 903, 1, NULL, NULL, NULL, 0),
(90312, 'MARIAS', 903, 1, NULL, NULL, NULL, 0),
(90314, 'PACHAS', 903, 1, NULL, NULL, NULL, 0),
(90316, 'QUIVILLA', 903, 1, NULL, NULL, NULL, 0),
(90317, 'RIPAN', 903, 1, NULL, NULL, NULL, 0),
(90321, 'SHUNQUI', 903, 1, NULL, NULL, NULL, 0),
(90322, 'SILLAPATA', 903, 1, NULL, NULL, NULL, 0),
(90323, 'YANAS', 903, 1, NULL, NULL, NULL, 0),
(90401, 'LLATA', 904, 1, NULL, NULL, NULL, 0),
(90402, 'ARANCAY', 904, 1, NULL, NULL, NULL, 0),
(90403, 'CHAVIN DE PARIARCA', 904, 1, NULL, NULL, NULL, 0),
(90404, 'JACAS GRANDE', 904, 1, NULL, NULL, NULL, 0),
(90405, 'JIRCAN', 904, 1, NULL, NULL, NULL, 0),
(90406, 'MIRAFLORES', 904, 1, NULL, NULL, NULL, 0),
(90407, 'MONZON', 904, 1, NULL, NULL, NULL, 0),
(90408, 'PUNCHAO', 904, 1, NULL, NULL, NULL, 0),
(90409, 'PUNOS', 904, 1, NULL, NULL, NULL, 0),
(90410, 'SINGA', 904, 1, NULL, NULL, NULL, 0),
(90411, 'TANTAMAYO', 904, 1, NULL, NULL, NULL, 0),
(90501, 'HUACRACHUCO', 905, 1, NULL, NULL, NULL, 0),
(90502, 'CHOLON', 905, 1, NULL, NULL, NULL, 0),
(90505, 'SAN BUENAVENTURA', 905, 1, NULL, NULL, NULL, 0),
(90601, 'RUPA RUPA', 906, 1, NULL, NULL, NULL, 0),
(90602, 'DANIEL ALOMIA ROBLES', 906, 1, NULL, NULL, NULL, 0),
(90603, 'HERMILIO VALDIZAN', 906, 1, NULL, NULL, NULL, 0),
(90604, 'LUYANDO', 906, 1, NULL, NULL, NULL, 0),
(90605, 'MARIANO DAMASO BERAUN', 906, 1, NULL, NULL, NULL, 0),
(90606, 'JOSE CRESPO Y CASTILLO', 906, 1, NULL, NULL, NULL, 0),
(90701, 'PANAO', 907, 1, NULL, NULL, NULL, 0),
(90702, 'CHAGLLA', 907, 1, NULL, NULL, NULL, 0),
(90704, 'MOLINO', 907, 1, NULL, NULL, NULL, 0),
(90706, 'UMARI', 907, 1, NULL, NULL, NULL, 0),
(90801, 'HONORIA', 908, 1, NULL, NULL, NULL, 0),
(90802, 'PUERTO INCA', 908, 1, NULL, NULL, NULL, 0),
(90803, 'CODO DEL POZUZO', 908, 1, NULL, NULL, NULL, 0),
(90804, 'TOURNAVISTA', 908, 1, NULL, NULL, NULL, 0),
(90805, 'YUYAPICHIS', 908, 1, NULL, NULL, NULL, 0),
(90901, 'HUACAYBAMBA', 909, 1, NULL, NULL, NULL, 0),
(90902, 'PINRA', 909, 1, NULL, NULL, NULL, 0),
(90903, 'CANCHABAMBA', 909, 1, NULL, NULL, NULL, 0),
(90904, 'COCHABAMBA', 909, 1, NULL, NULL, NULL, 0),
(91001, 'JESUS', 910, 1, NULL, NULL, NULL, 0),
(91002, 'BANOS', 910, 1, NULL, NULL, NULL, 0),
(91003, 'SAN FRANCISCO DE ASIS', 910, 1, NULL, NULL, NULL, 0),
(91004, 'QUEROPALCA', 910, 1, NULL, NULL, NULL, 0),
(91005, 'SAN MIGUEL DE CAURI', 910, 1, NULL, NULL, NULL, 0),
(91006, 'RONDOS', 910, 1, NULL, NULL, NULL, 0),
(91007, 'JIVIA', 910, 1, NULL, NULL, NULL, 0),
(91101, 'CHAVINILLO', 911, 1, NULL, NULL, NULL, 0),
(91102, 'APARICIO POMARES (CHUPAN)', 911, 1, NULL, NULL, NULL, 0),
(91103, 'CAHUAC', 911, 1, NULL, NULL, NULL, 0),
(91104, 'CHACABAMBA', 911, 1, NULL, NULL, NULL, 0),
(91105, 'JACAS CHICO', 911, 1, NULL, NULL, NULL, 0),
(91106, 'OBAS', 911, 1, NULL, NULL, NULL, 0),
(91107, 'PAMPAMARCA', 911, 1, NULL, NULL, NULL, 0),
(91108, 'CHORAS', 911, 1, NULL, NULL, NULL, 0),
(100101, 'ICA', 1001, 1, NULL, NULL, NULL, 0),
(100102, 'LA TINGUINA', 1001, 1, NULL, NULL, NULL, 0),
(100103, 'LOS AQUIJES', 1001, 1, NULL, NULL, NULL, 0),
(100104, 'PARCONA', 1001, 1, NULL, NULL, NULL, 0),
(100105, 'PUEBLO NUEVO', 1001, 1, NULL, NULL, NULL, 0),
(100106, 'SALAS', 1001, 1, NULL, NULL, NULL, 0),
(100107, 'SAN JOSE DE LOS MOLINOS', 1001, 1, NULL, NULL, NULL, 0),
(100108, 'SAN JUAN BAUTISTA', 1001, 1, NULL, NULL, NULL, 0),
(100109, 'SANTIAGO', 1001, 1, NULL, NULL, NULL, 0),
(100110, 'SUBTANJALLA', 1001, 1, NULL, NULL, NULL, 0),
(100111, 'YAUCA DEL ROSARIO', 1001, 1, NULL, NULL, NULL, 0),
(100112, 'TATE', 1001, 1, NULL, NULL, NULL, 0),
(100113, 'PACHACUTEC', 1001, 1, NULL, NULL, NULL, 0),
(100114, 'OCUCAJE', 1001, 1, NULL, NULL, NULL, 0),
(100201, 'CHINCHA ALTA', 1002, 1, NULL, NULL, NULL, 0),
(100202, 'CHAVIN', 1002, 1, NULL, NULL, NULL, 0),
(100203, 'CHINCHA BAJA', 1002, 1, NULL, NULL, NULL, 0),
(100204, 'EL CARMEN', 1002, 1, NULL, NULL, NULL, 0),
(100205, 'GROCIO PRADO', 1002, 1, NULL, NULL, NULL, 0),
(100206, 'SAN PEDRO DE HUACARPANA', 1002, 1, NULL, NULL, NULL, 0),
(100207, 'SUNAMPE', 1002, 1, NULL, NULL, NULL, 0),
(100208, 'TAMBO DE MORA', 1002, 1, NULL, NULL, NULL, 0),
(100209, 'ALTO LARAN', 1002, 1, NULL, NULL, NULL, 0),
(100210, 'PUEBLO NUEVO', 1002, 1, NULL, NULL, NULL, 0),
(100211, 'SAN JUAN DE YANAC', 1002, 1, NULL, NULL, NULL, 0),
(100301, 'NAZCA', 1003, 1, NULL, NULL, NULL, 0),
(100302, 'CHANGUILLO', 1003, 1, NULL, NULL, NULL, 0),
(100303, 'EL INGENIO', 1003, 1, NULL, NULL, NULL, 0),
(100304, 'MARCONA', 1003, 1, NULL, NULL, NULL, 0),
(100305, 'VISTA ALEGRE', 1003, 1, NULL, NULL, NULL, 0),
(100401, 'PISCO', 1004, 1, NULL, NULL, NULL, 0),
(100402, 'HUANCANO', 1004, 1, NULL, NULL, NULL, 0),
(100403, 'HUMAY', 1004, 1, NULL, NULL, NULL, 0),
(100404, 'INDEPENDENCIA', 1004, 1, NULL, NULL, NULL, 0),
(100405, 'PARACAS', 1004, 1, NULL, NULL, NULL, 0),
(100406, 'SAN ANDRES', 1004, 1, NULL, NULL, NULL, 0),
(100407, 'SAN CLEMENTE', 1004, 1, NULL, NULL, NULL, 0),
(100408, 'TUPAC AMARU INCA', 1004, 1, NULL, NULL, NULL, 0),
(100501, 'PALPA', 1005, 1, NULL, NULL, NULL, 0),
(100502, 'LLIPATA', 1005, 1, NULL, NULL, NULL, 0),
(100503, 'RIO GRANDE', 1005, 1, NULL, NULL, NULL, 0),
(100504, 'SANTA CRUZ', 1005, 1, NULL, NULL, NULL, 0),
(100505, 'TIBILLO', 1005, 1, NULL, NULL, NULL, 0),
(110101, 'HUANCAYO', 1101, 1, NULL, NULL, NULL, 0),
(110103, 'CARHUACALLANGA', 1101, 1, NULL, NULL, NULL, 0),
(110104, 'COLCA', 1101, 1, NULL, NULL, NULL, 0),
(110105, 'CULLHUAS', 1101, 1, NULL, NULL, NULL, 0),
(110106, 'CHACAPAMPA', 1101, 1, NULL, NULL, NULL, 0),
(110107, 'CHICCHE', 1101, 1, NULL, NULL, NULL, 0),
(110108, 'CHILCA', 1101, 1, NULL, NULL, NULL, 0),
(110109, 'CHONGOS ALTO', 1101, 1, NULL, NULL, NULL, 0),
(110112, 'CHUPURO', 1101, 1, NULL, NULL, NULL, 0),
(110113, 'EL TAMBO', 1101, 1, NULL, NULL, NULL, 0),
(110114, 'HUACRAPUQUIO', 1101, 1, NULL, NULL, NULL, 0),
(110116, 'HUALHUAS', 1101, 1, NULL, NULL, NULL, 0),
(110118, 'HUANCAN', 1101, 1, NULL, NULL, NULL, 0),
(110119, 'HUASICANCHA', 1101, 1, NULL, NULL, NULL, 0);
INSERT INTO `distrito` (`codigo_dis`, `nombre_dis`, `codigo_pro`, `estado_dis`, `usuario_reg`, `usuario_mod`, `fecha_mod`, `sistema`) VALUES
(110120, 'HUAYUCACHI', 1101, 1, NULL, NULL, NULL, 0),
(110121, 'INGENIO', 1101, 1, NULL, NULL, NULL, 0),
(110122, 'PARIAHUANCA', 1101, 1, NULL, NULL, NULL, 0),
(110123, 'PILCOMAYO', 1101, 1, NULL, NULL, NULL, 0),
(110124, 'PUCARA', 1101, 1, NULL, NULL, NULL, 0),
(110125, 'QUICHUAY', 1101, 1, NULL, NULL, NULL, 0),
(110126, 'QUILCAS', 1101, 1, NULL, NULL, NULL, 0),
(110127, 'SAN AGUSTIN', 1101, 1, NULL, NULL, NULL, 0),
(110128, 'SAN JERONIMO DE TUNAN', 1101, 1, NULL, NULL, NULL, 0),
(110131, 'STO DOMINGO DE ACOBAMBA', 1101, 1, NULL, NULL, NULL, 0),
(110132, 'SANO', 1101, 1, NULL, NULL, NULL, 0),
(110133, 'SAPALLANGA', 1101, 1, NULL, NULL, NULL, 0),
(110134, 'SICAYA', 1101, 1, NULL, NULL, NULL, 0),
(110136, 'VIQUES', 1101, 1, NULL, NULL, NULL, 0),
(110201, 'CONCEPCION', 1102, 1, NULL, NULL, NULL, 0),
(110202, 'ACO', 1102, 1, NULL, NULL, NULL, 0),
(110203, 'ANDAMARCA', 1102, 1, NULL, NULL, NULL, 0),
(110204, 'COMAS', 1102, 1, NULL, NULL, NULL, 0),
(110205, 'COCHAS', 1102, 1, NULL, NULL, NULL, 0),
(110206, 'CHAMBARA', 1102, 1, NULL, NULL, NULL, 0),
(110207, 'HEROINAS TOLEDO', 1102, 1, NULL, NULL, NULL, 0),
(110208, 'MANZANARES', 1102, 1, NULL, NULL, NULL, 0),
(110209, 'MCAL CASTILLA', 1102, 1, NULL, NULL, NULL, 0),
(110210, 'MATAHUASI', 1102, 1, NULL, NULL, NULL, 0),
(110211, 'MITO', 1102, 1, NULL, NULL, NULL, 0),
(110212, 'NUEVE DE JULIO', 1102, 1, NULL, NULL, NULL, 0),
(110213, 'ORCOTUNA', 1102, 1, NULL, NULL, NULL, 0),
(110214, 'STA ROSA DE OCOPA', 1102, 1, NULL, NULL, NULL, 0),
(110215, 'SAN JOSE DE QUERO', 1102, 1, NULL, NULL, NULL, 0),
(110301, 'JAUJA', 1103, 1, NULL, NULL, NULL, 0),
(110302, 'ACOLLA', 1103, 1, NULL, NULL, NULL, 0),
(110303, 'APATA', 1103, 1, NULL, NULL, NULL, 0),
(110304, 'ATAURA', 1103, 1, NULL, NULL, NULL, 0),
(110305, 'CANCHAILLO', 1103, 1, NULL, NULL, NULL, 0),
(110306, 'EL MANTARO', 1103, 1, NULL, NULL, NULL, 0),
(110307, 'HUAMALI', 1103, 1, NULL, NULL, NULL, 0),
(110308, 'HUARIPAMPA', 1103, 1, NULL, NULL, NULL, 0),
(110309, 'HUERTAS', 1103, 1, NULL, NULL, NULL, 0),
(110310, 'JANJAILLO', 1103, 1, NULL, NULL, NULL, 0),
(110311, 'JULCAN', 1103, 1, NULL, NULL, NULL, 0),
(110312, 'LEONOR ORDONEZ', 1103, 1, NULL, NULL, NULL, 0),
(110313, 'LLOCLLAPAMPA', 1103, 1, NULL, NULL, NULL, 0),
(110314, 'MARCO', 1103, 1, NULL, NULL, NULL, 0),
(110315, 'MASMA', 1103, 1, NULL, NULL, NULL, 0),
(110316, 'MOLINOS', 1103, 1, NULL, NULL, NULL, 0),
(110317, 'MONOBAMBA', 1103, 1, NULL, NULL, NULL, 0),
(110318, 'MUQUI', 1103, 1, NULL, NULL, NULL, 0),
(110319, 'MUQUIYAUYO', 1103, 1, NULL, NULL, NULL, 0),
(110320, 'PACA', 1103, 1, NULL, NULL, NULL, 0),
(110321, 'PACCHA', 1103, 1, NULL, NULL, NULL, 0),
(110322, 'PANCAN', 1103, 1, NULL, NULL, NULL, 0),
(110323, 'PARCO', 1103, 1, NULL, NULL, NULL, 0),
(110324, 'POMACANCHA', 1103, 1, NULL, NULL, NULL, 0),
(110325, 'RICRAN', 1103, 1, NULL, NULL, NULL, 0),
(110326, 'SAN LORENZO', 1103, 1, NULL, NULL, NULL, 0),
(110327, 'SAN PEDRO DE CHUNAN', 1103, 1, NULL, NULL, NULL, 0),
(110328, 'SINCOS', 1103, 1, NULL, NULL, NULL, 0),
(110329, 'TUNAN MARCA', 1103, 1, NULL, NULL, NULL, 0),
(110330, 'YAULI', 1103, 1, NULL, NULL, NULL, 0),
(110331, 'CURICACA', 1103, 1, NULL, NULL, NULL, 0),
(110332, 'MASMA CHICCHE', 1103, 1, NULL, NULL, NULL, 0),
(110333, 'SAUSA', 1103, 1, NULL, NULL, NULL, 0),
(110334, 'YAUYOS', 1103, 1, NULL, NULL, NULL, 0),
(110401, 'JUNIN', 1104, 1, NULL, NULL, NULL, 0),
(110402, 'CARHUAMAYO', 1104, 1, NULL, NULL, NULL, 0),
(110403, 'ONDORES', 1104, 1, NULL, NULL, NULL, 0),
(110404, 'ULCUMAYO', 1104, 1, NULL, NULL, NULL, 0),
(110501, 'TARMA', 1105, 1, NULL, NULL, NULL, 0),
(110502, 'ACOBAMBA', 1105, 1, NULL, NULL, NULL, 0),
(110503, 'HUARICOLCA', 1105, 1, NULL, NULL, NULL, 0),
(110504, 'HUASAHUASI', 1105, 1, NULL, NULL, NULL, 0),
(110505, 'LA UNION', 1105, 1, NULL, NULL, NULL, 0),
(110506, 'PALCA', 1105, 1, NULL, NULL, NULL, 0),
(110507, 'PALCAMAYO', 1105, 1, NULL, NULL, NULL, 0),
(110508, 'SAN PEDRO DE CAJAS', 1105, 1, NULL, NULL, NULL, 0),
(110509, 'TAPO', 1105, 1, NULL, NULL, NULL, 0),
(110601, 'LA OROYA', 1106, 1, NULL, NULL, NULL, 0),
(110602, 'CHACAPALPA', 1106, 1, NULL, NULL, NULL, 0),
(110603, 'HUAY HUAY', 1106, 1, NULL, NULL, NULL, 0),
(110604, 'MARCAPOMACOCHA', 1106, 1, NULL, NULL, NULL, 0),
(110605, 'MOROCOCHA', 1106, 1, NULL, NULL, NULL, 0),
(110606, 'PACCHA', 1106, 1, NULL, NULL, NULL, 0),
(110607, 'STA BARBARA DE CARHUACAYAN', 1106, 1, NULL, NULL, NULL, 0),
(110608, 'SUITUCANCHA', 1106, 1, NULL, NULL, NULL, 0),
(110609, 'YAULI', 1106, 1, NULL, NULL, NULL, 0),
(110610, 'STA ROSA DE SACCO', 1106, 1, NULL, NULL, NULL, 0),
(110701, 'SATIPO', 1107, 1, NULL, NULL, NULL, 0),
(110702, 'COVIRIALI', 1107, 1, NULL, NULL, NULL, 0),
(110703, 'LLAYLLA', 1107, 1, NULL, NULL, NULL, 0),
(110704, 'MAZAMARI', 1107, 1, NULL, NULL, NULL, 0),
(110705, 'PAMPA HERMOSA', 1107, 1, NULL, NULL, NULL, 0),
(110706, 'PANGOA', 1107, 1, NULL, NULL, NULL, 0),
(110707, 'RIO NEGRO', 1107, 1, NULL, NULL, NULL, 0),
(110708, 'RIO TAMBO', 1107, 1, NULL, NULL, NULL, 0),
(110801, 'CHANCHAMAYO', 1108, 1, NULL, NULL, NULL, 0),
(110802, 'SAN RAMON', 1108, 1, NULL, NULL, NULL, 0),
(110803, 'VITOC', 1108, 1, NULL, NULL, NULL, 0),
(110804, 'SAN LUIS DE SHUARO', 1108, 1, NULL, NULL, NULL, 0),
(110805, 'PICHANAQUI', 1108, 1, NULL, NULL, NULL, 0),
(110806, 'PERENE', 1108, 1, NULL, NULL, NULL, 0),
(110901, 'CHUPACA', 1109, 1, NULL, NULL, NULL, 0),
(110902, 'AHUAC', 1109, 1, NULL, NULL, NULL, 0),
(110903, 'CHONGOS BAJO', 1109, 1, NULL, NULL, NULL, 0),
(110904, 'HUACHAC', 1109, 1, NULL, NULL, NULL, 0),
(110905, 'HUAMANCACA CHICO', 1109, 1, NULL, NULL, NULL, 0),
(110906, 'SAN JUAN DE ISCOS', 1109, 1, NULL, NULL, NULL, 0),
(110907, 'SAN JUAN DE JARPA', 1109, 1, NULL, NULL, NULL, 0),
(110908, 'TRES DE DICIEMBRE', 1109, 1, NULL, NULL, NULL, 0),
(110909, 'YANACANCHA', 1109, 1, NULL, NULL, NULL, 0),
(120101, 'TRUJILLO', 1201, 1, NULL, NULL, NULL, 0),
(120102, 'HUANCHACO', 1201, 1, NULL, NULL, NULL, 0),
(120103, 'LAREDO', 1201, 1, NULL, NULL, NULL, 0),
(120104, 'MOCHE', 1201, 1, NULL, NULL, NULL, 0),
(120105, 'SALAVERRY', 1201, 1, NULL, NULL, NULL, 0),
(120106, 'SIMBAL', 1201, 1, NULL, NULL, NULL, 0),
(120107, 'VICTOR LARCO HERRERA', 1201, 1, NULL, NULL, NULL, 0),
(120109, 'POROTO', 1201, 1, NULL, NULL, NULL, 0),
(120110, 'EL PORVENIR', 1201, 1, NULL, NULL, NULL, 0),
(120111, 'LA ESPERANZA', 1201, 1, NULL, NULL, NULL, 0),
(120112, 'FLORENCIA DE MORA', 1201, 1, NULL, NULL, NULL, 0),
(120201, 'BOLIVAR', 1202, 1, NULL, NULL, NULL, 0),
(120202, 'BAMBAMARCA', 1202, 1, NULL, NULL, NULL, 0),
(120203, 'CONDORMARCA', 1202, 1, NULL, NULL, NULL, 0),
(120204, 'LONGOTEA', 1202, 1, NULL, NULL, NULL, 0),
(120205, 'UCUNCHA', 1202, 1, NULL, NULL, NULL, 0),
(120206, 'UCHUMARCA', 1202, 1, NULL, NULL, NULL, 0),
(120301, 'HUAMACHUCO', 1203, 1, NULL, NULL, NULL, 0),
(120302, 'COCHORCO', 1203, 1, NULL, NULL, NULL, 0),
(120303, 'CURGOS', 1203, 1, NULL, NULL, NULL, 0),
(120304, 'CHUGAY', 1203, 1, NULL, NULL, NULL, 0),
(120305, 'MARCABAL', 1203, 1, NULL, NULL, NULL, 0),
(120306, 'SANAGORAN', 1203, 1, NULL, NULL, NULL, 0),
(120307, 'SARIN', 1203, 1, NULL, NULL, NULL, 0),
(120308, 'SARTIMBAMBA', 1203, 1, NULL, NULL, NULL, 0),
(120401, 'OTUZCO', 1204, 1, NULL, NULL, NULL, 0),
(120402, 'AGALLPAMPA', 1204, 1, NULL, NULL, NULL, 0),
(120403, 'CHARAT', 1204, 1, NULL, NULL, NULL, 0),
(120404, 'HUARANCHAL', 1204, 1, NULL, NULL, NULL, 0),
(120405, 'LA CUESTA', 1204, 1, NULL, NULL, NULL, 0),
(120408, 'PARANDAY', 1204, 1, NULL, NULL, NULL, 0),
(120409, 'SALPO', 1204, 1, NULL, NULL, NULL, 0),
(120410, 'SINSICAP', 1204, 1, NULL, NULL, NULL, 0),
(120411, 'USQUIL', 1204, 1, NULL, NULL, NULL, 0),
(120413, 'MACHE', 1204, 1, NULL, NULL, NULL, 0),
(120501, 'SAN PEDRO DE LLOC', 1205, 1, NULL, NULL, NULL, 0),
(120503, 'GUADALUPE', 1205, 1, NULL, NULL, NULL, 0),
(120504, 'JEQUETEPEQUE', 1205, 1, NULL, NULL, NULL, 0),
(120506, 'PACASMAYO', 1205, 1, NULL, NULL, NULL, 0),
(120508, 'SAN JOSE', 1205, 1, NULL, NULL, NULL, 0),
(120601, 'TAYABAMBA', 1206, 1, NULL, NULL, NULL, 0),
(120602, 'BULDIBUYO', 1206, 1, NULL, NULL, NULL, 0),
(120603, 'CHILLIA', 1206, 1, NULL, NULL, NULL, 0),
(120604, 'HUAYLILLAS', 1206, 1, NULL, NULL, NULL, 0),
(120605, 'HUANCASPATA', 1206, 1, NULL, NULL, NULL, 0),
(120606, 'HUAYO', 1206, 1, NULL, NULL, NULL, 0),
(120607, 'ONGON', 1206, 1, NULL, NULL, NULL, 0),
(120608, 'PARCOY', 1206, 1, NULL, NULL, NULL, 0),
(120609, 'PATAZ', 1206, 1, NULL, NULL, NULL, 0),
(120610, 'PIAS', 1206, 1, NULL, NULL, NULL, 0),
(120611, 'TAURIJA', 1206, 1, NULL, NULL, NULL, 0),
(120612, 'URPAY', 1206, 1, NULL, NULL, NULL, 0),
(120613, 'SANTIAGO DE CHALLAS', 1206, 1, NULL, NULL, NULL, 0),
(120701, 'SANTIAGO DE CHUCO', 1207, 1, NULL, NULL, NULL, 0),
(120702, 'CACHICADAN', 1207, 1, NULL, NULL, NULL, 0),
(120703, 'MOLLEBAMBA', 1207, 1, NULL, NULL, NULL, 0),
(120704, 'MOLLEPATA', 1207, 1, NULL, NULL, NULL, 0),
(120705, 'QUIRUVILCA', 1207, 1, NULL, NULL, NULL, 0),
(120706, 'SANTA CRUZ DE CHUCA', 1207, 1, NULL, NULL, NULL, 0),
(120707, 'SITABAMBA', 1207, 1, NULL, NULL, NULL, 0),
(120708, 'ANGASMARCA', 1207, 1, NULL, NULL, NULL, 0),
(120801, 'ASCOPE', 1208, 1, NULL, NULL, NULL, 0),
(120802, 'CHICAMA', 1208, 1, NULL, NULL, NULL, 0),
(120803, 'CHOCOPE', 1208, 1, NULL, NULL, NULL, 0),
(120804, 'SANTIAGO DE CAO', 1208, 1, NULL, NULL, NULL, 0),
(120805, 'MAGDALENA DE CAO', 1208, 1, NULL, NULL, NULL, 0),
(120806, 'PAIJAN', 1208, 1, NULL, NULL, NULL, 0),
(120807, 'RAZURI', 1208, 1, NULL, NULL, NULL, 0),
(120808, 'CASA GRANDE', 1208, 1, NULL, NULL, NULL, 0),
(120901, 'CHEPEN', 1209, 1, NULL, NULL, NULL, 0),
(120902, 'PACANGA', 1209, 1, NULL, NULL, NULL, 0),
(120903, 'PUEBLO NUEVO', 1209, 1, NULL, NULL, NULL, 0),
(121001, 'JULCAN', 1210, 1, NULL, NULL, NULL, 0),
(121002, 'CARABAMBA', 1210, 1, NULL, NULL, NULL, 0),
(121003, 'CALAMARCA', 1210, 1, NULL, NULL, NULL, 0),
(121004, 'HUASO', 1210, 1, NULL, NULL, NULL, 0),
(121101, 'CASCAS', 1211, 1, NULL, NULL, NULL, 0),
(121102, 'LUCMA', 1211, 1, NULL, NULL, NULL, 0),
(121103, 'MARMOT', 1211, 1, NULL, NULL, NULL, 0),
(121104, 'SAYAPULLO', 1211, 1, NULL, NULL, NULL, 0),
(121201, 'VIRU', 1212, 1, NULL, NULL, NULL, 0),
(121202, 'CHAO', 1212, 1, NULL, NULL, NULL, 0),
(121203, 'GUADALUPITO', 1212, 1, NULL, NULL, NULL, 0),
(130101, 'CHICLAYO', 1301, 1, NULL, NULL, NULL, 0),
(130102, 'CHONGOYAPE', 1301, 1, NULL, NULL, NULL, 0),
(130103, 'ETEN', 1301, 1, NULL, NULL, NULL, 0),
(130104, 'ETEN PUERTO', 1301, 1, NULL, NULL, NULL, 0),
(130105, 'LAGUNAS', 1301, 1, NULL, NULL, NULL, 0),
(130106, 'MONSEFU', 1301, 1, NULL, NULL, NULL, 0),
(130107, 'NUEVA ARICA', 1301, 1, NULL, NULL, NULL, 0),
(130108, 'OYOTUN', 1301, 1, NULL, NULL, NULL, 0),
(130109, 'PICSI', 1301, 1, NULL, NULL, NULL, 0),
(130110, 'PIMENTEL', 1301, 1, NULL, NULL, NULL, 0),
(130111, 'REQUE', 1301, 1, NULL, NULL, NULL, 0),
(130112, 'JOSE LEONARDO ORTIZ', 1301, 1, NULL, NULL, NULL, 0),
(130113, 'SANTA ROSA', 1301, 1, NULL, NULL, NULL, 0),
(130114, 'SANA', 1301, 1, NULL, NULL, NULL, 0),
(130115, 'LA VICTORIA', 1301, 1, NULL, NULL, NULL, 0),
(130116, 'CAYALTI', 1301, 1, NULL, NULL, NULL, 0),
(130117, 'PATAPO', 1301, 1, NULL, NULL, NULL, 0),
(130118, 'POMALCA', 1301, 1, NULL, NULL, NULL, 0),
(130119, 'PUCALA', 1301, 1, NULL, NULL, NULL, 0),
(130120, 'TUMAN', 1301, 1, NULL, NULL, NULL, 0),
(130201, 'FERRENAFE', 1302, 1, NULL, NULL, NULL, 0),
(130202, 'INCAHUASI', 1302, 1, NULL, NULL, NULL, 0),
(130203, 'CANARIS', 1302, 1, NULL, NULL, NULL, 0),
(130204, 'PITIPO', 1302, 1, NULL, NULL, NULL, 0),
(130205, 'PUEBLO NUEVO', 1302, 1, NULL, NULL, NULL, 0),
(130206, 'MANUEL ANTONIO MESONES MURO', 1302, 1, NULL, NULL, NULL, 0),
(130301, 'LAMBAYEQUE', 1303, 1, NULL, NULL, NULL, 0),
(130302, 'CHOCHOPE', 1303, 1, NULL, NULL, NULL, 0),
(130303, 'ILLIMO', 1303, 1, NULL, NULL, NULL, 0),
(130304, 'JAYANCA', 1303, 1, NULL, NULL, NULL, 0),
(130305, 'MOCHUMI', 1303, 1, NULL, NULL, NULL, 0),
(130306, 'MORROPE', 1303, 1, NULL, NULL, NULL, 0),
(130307, 'MOTUPE', 1303, 1, NULL, NULL, NULL, 0),
(130308, 'OLMOS', 1303, 1, NULL, NULL, NULL, 0),
(130309, 'PACORA', 1303, 1, NULL, NULL, NULL, 0),
(130310, 'SALAS', 1303, 1, NULL, NULL, NULL, 0),
(130311, 'SAN JOSE', 1303, 1, NULL, NULL, NULL, 0),
(130312, 'TUCUME', 1303, 1, NULL, NULL, NULL, 0),
(140101, 'LIMA', 1401, 1, NULL, NULL, NULL, 0),
(140102, 'ANCON', 1401, 1, NULL, NULL, NULL, 0),
(140103, 'ATE', 1401, 1, NULL, NULL, NULL, 0),
(140104, 'BRENA', 1401, 1, NULL, NULL, NULL, 0),
(140105, 'CARABAYLLO', 1401, 1, NULL, NULL, NULL, 0),
(140106, 'COMAS', 1401, 1, NULL, NULL, NULL, 0),
(140107, 'CHACLACAYO', 1401, 1, NULL, NULL, NULL, 0),
(140108, 'CHORRILLOS', 1401, 1, NULL, NULL, NULL, 0),
(140109, 'LA VICTORIA', 1401, 1, NULL, NULL, NULL, 0),
(140110, 'LA MOLINA', 1401, 1, NULL, NULL, NULL, 0),
(140111, 'LINCE', 1401, 1, NULL, NULL, NULL, 0),
(140112, 'LURIGANCHO', 1401, 1, NULL, NULL, NULL, 0),
(140113, 'LURIN', 1401, 1, NULL, NULL, NULL, 0),
(140114, 'MAGDALENA DEL MAR', 1401, 1, NULL, NULL, NULL, 0),
(140115, 'MIRAFLORES', 1401, 1, NULL, NULL, NULL, 0),
(140116, 'PACHACAMAC', 1401, 1, NULL, NULL, NULL, 0),
(140117, 'PUEBLO LIBRE', 1401, 1, NULL, NULL, NULL, 0),
(140118, 'PUCUSANA', 1401, 1, NULL, NULL, NULL, 0),
(140119, 'PUENTE PIEDRA', 1401, 1, NULL, NULL, NULL, 0),
(140120, 'PUNTA HERMOSA', 1401, 1, NULL, NULL, NULL, 0),
(140121, 'PUNTA NEGRA', 1401, 1, NULL, NULL, NULL, 0),
(140122, 'RIMAC', 1401, 1, NULL, NULL, NULL, 0),
(140123, 'SAN BARTOLO', 1401, 1, NULL, NULL, NULL, 0),
(140124, 'SAN ISIDRO', 1401, 1, NULL, NULL, NULL, 0),
(140125, 'BARRANCO', 1401, 1, NULL, NULL, NULL, 0),
(140126, 'SAN MARTIN DE PORRES', 1401, 1, NULL, NULL, NULL, 0),
(140127, 'SAN MIGUEL', 1401, 1, NULL, NULL, NULL, 0),
(140128, 'STA MARIA DEL MAR', 1401, 1, NULL, NULL, NULL, 0),
(140129, 'SANTA ROSA', 1401, 1, NULL, NULL, NULL, 0),
(140130, 'SANTIAGO DE SURCO', 1401, 1, NULL, NULL, NULL, 0),
(140131, 'SURQUILLO', 1401, 1, NULL, NULL, NULL, 0),
(140132, 'VILLA MARIA DEL TRIUNFO', 1401, 1, NULL, NULL, NULL, 0),
(140133, 'JESUS MARIA', 1401, 1, NULL, NULL, NULL, 0),
(140134, 'INDEPENDENCIA', 1401, 1, NULL, NULL, NULL, 0),
(140135, 'EL AGUSTINO', 1401, 1, NULL, NULL, NULL, 0),
(140136, 'SAN JUAN DE MIRAFLORES', 1401, 1, NULL, NULL, NULL, 0),
(140137, 'SAN JUAN DE LURIGANCHO', 1401, 1, NULL, NULL, NULL, 0),
(140138, 'SAN LUIS', 1401, 1, NULL, NULL, NULL, 0),
(140139, 'CIENEGUILLA', 1401, 1, NULL, NULL, NULL, 0),
(140140, 'SAN BORJA', 1401, 1, NULL, NULL, NULL, 0),
(140141, 'VILLA EL SALVADOR', 1401, 1, NULL, NULL, NULL, 0),
(140142, 'LOS OLIVOS', 1401, 1, NULL, NULL, NULL, 0),
(140143, 'SANTA ANITA', 1401, 1, NULL, NULL, NULL, 0),
(140201, 'CAJATAMBO', 1402, 1, NULL, NULL, NULL, 0),
(140205, 'COPA', 1402, 1, NULL, NULL, NULL, 0),
(140206, 'GORGOR', 1402, 1, NULL, NULL, NULL, 0),
(140207, 'HUANCAPON', 1402, 1, NULL, NULL, NULL, 0),
(140208, 'MANAS', 1402, 1, NULL, NULL, NULL, 0),
(140301, 'CANTA', 1403, 1, NULL, NULL, NULL, 0),
(140302, 'ARAHUAY', 1403, 1, NULL, NULL, NULL, 0),
(140303, 'HUAMANTANGA', 1403, 1, NULL, NULL, NULL, 0),
(140304, 'HUAROS', 1403, 1, NULL, NULL, NULL, 0),
(140305, 'LACHAQUI', 1403, 1, NULL, NULL, NULL, 0),
(140306, 'SAN BUENAVENTURA', 1403, 1, NULL, NULL, NULL, 0),
(140307, 'SANTA ROSA DE QUIVES', 1403, 1, NULL, NULL, NULL, 0),
(140401, 'SAN VICENTE DE CANETE', 1404, 1, NULL, NULL, NULL, 0),
(140402, 'CALANGO', 1404, 1, NULL, NULL, NULL, 0),
(140403, 'CERRO AZUL', 1404, 1, NULL, NULL, NULL, 0),
(140404, 'COAYLLO', 1404, 1, NULL, NULL, NULL, 0),
(140405, 'CHILCA', 1404, 1, NULL, NULL, NULL, 0),
(140406, 'IMPERIAL', 1404, 1, NULL, NULL, NULL, 0),
(140407, 'LUNAHUANA', 1404, 1, NULL, NULL, NULL, 0),
(140408, 'MALA', 1404, 1, NULL, NULL, NULL, 0),
(140409, 'NUEVO IMPERIAL', 1404, 1, NULL, NULL, NULL, 0),
(140410, 'PACARAN', 1404, 1, NULL, NULL, NULL, 0),
(140411, 'QUILMANA', 1404, 1, NULL, NULL, NULL, 0),
(140412, 'SAN ANTONIO', 1404, 1, NULL, NULL, NULL, 0),
(140413, 'SAN LUIS', 1404, 1, NULL, NULL, NULL, 0),
(140414, 'SANTA CRUZ DE FLORES', 1404, 1, NULL, NULL, NULL, 0),
(140415, 'ZUNIGA', 1404, 1, NULL, NULL, NULL, 0),
(140416, 'ASIA', 1404, 1, NULL, NULL, NULL, 0),
(140501, 'HUACHO', 1405, 1, NULL, NULL, NULL, 0),
(140502, 'AMBAR', 1405, 1, NULL, NULL, NULL, 0),
(140504, 'CALETA DE CARQUIN', 1405, 1, NULL, NULL, NULL, 0),
(140505, 'CHECRAS', 1405, 1, NULL, NULL, NULL, 0),
(140506, 'HUALMAY', 1405, 1, NULL, NULL, NULL, 0),
(140507, 'HUAURA', 1405, 1, NULL, NULL, NULL, 0),
(140508, 'LEONCIO PRADO', 1405, 1, NULL, NULL, NULL, 0),
(140509, 'PACCHO', 1405, 1, NULL, NULL, NULL, 0),
(140511, 'SANTA LEONOR', 1405, 1, NULL, NULL, NULL, 0),
(140512, 'SANTA MARIA', 1405, 1, NULL, NULL, NULL, 0),
(140513, 'SAYAN', 1405, 1, NULL, NULL, NULL, 0),
(140516, 'VEGUETA', 1405, 1, NULL, NULL, NULL, 0),
(140601, 'MATUCANA', 1406, 1, NULL, NULL, NULL, 0),
(140602, 'ANTIOQUIA', 1406, 1, NULL, NULL, NULL, 0),
(140603, 'CALLAHUANCA', 1406, 1, NULL, NULL, NULL, 0),
(140604, 'CARAMPOMA', 1406, 1, NULL, NULL, NULL, 0),
(140605, 'CASTA', 1406, 1, NULL, NULL, NULL, 0),
(140606, 'CUENCA', 1406, 1, NULL, NULL, NULL, 0),
(140607, 'CHICLA', 1406, 1, NULL, NULL, NULL, 0),
(140608, 'HUANZA', 1406, 1, NULL, NULL, NULL, 0),
(140609, 'HUAROCHIRI', 1406, 1, NULL, NULL, NULL, 0),
(140610, 'LAHUAYTAMBO', 1406, 1, NULL, NULL, NULL, 0),
(140611, 'LANGA', 1406, 1, NULL, NULL, NULL, 0),
(140612, 'MARIATANA', 1406, 1, NULL, NULL, NULL, 0),
(140613, 'RICARDO PALMA', 1406, 1, NULL, NULL, NULL, 0),
(140614, 'SAN ANDRES DE TUPICOCHA', 1406, 1, NULL, NULL, NULL, 0),
(140615, 'SAN ANTONIO', 1406, 1, NULL, NULL, NULL, 0),
(140616, 'SAN BARTOLOME', 1406, 1, NULL, NULL, NULL, 0),
(140617, 'SAN DAMIAN', 1406, 1, NULL, NULL, NULL, 0),
(140618, 'SANGALLAYA', 1406, 1, NULL, NULL, NULL, 0),
(140619, 'SAN JUAN DE TANTARANCHE', 1406, 1, NULL, NULL, NULL, 0),
(140620, 'SAN LORENZO DE QUINTI', 1406, 1, NULL, NULL, NULL, 0),
(140621, 'SAN MATEO', 1406, 1, NULL, NULL, NULL, 0),
(140622, 'SAN MATEO DE OTAO', 1406, 1, NULL, NULL, NULL, 0),
(140623, 'SAN PEDRO DE HUANCAYRE', 1406, 1, NULL, NULL, NULL, 0),
(140624, 'SANTA CRUZ DE COCACHACRA', 1406, 1, NULL, NULL, NULL, 0),
(140625, 'SANTA EULALIA', 1406, 1, NULL, NULL, NULL, 0),
(140626, 'SANTIAGO DE ANCHUCAYA', 1406, 1, NULL, NULL, NULL, 0),
(140627, 'SANTIAGO DE TUNA', 1406, 1, NULL, NULL, NULL, 0),
(140628, 'SANTO DOMINGO DE LOS OLLEROS', 1406, 1, NULL, NULL, NULL, 0),
(140629, 'SURCO', 1406, 1, NULL, NULL, NULL, 0),
(140630, 'HUACHUPAMPA', 1406, 1, NULL, NULL, NULL, 0),
(140631, 'LARAOS', 1406, 1, NULL, NULL, NULL, 0),
(140632, 'SAN JUAN DE IRIS', 1406, 1, NULL, NULL, NULL, 0),
(140701, 'YAUYOS', 1407, 1, NULL, NULL, NULL, 0),
(140702, 'ALIS', 1407, 1, NULL, NULL, NULL, 0),
(140703, 'AYAUCA', 1407, 1, NULL, NULL, NULL, 0),
(140704, 'AYAVIRI', 1407, 1, NULL, NULL, NULL, 0),
(140705, 'AZANGARO', 1407, 1, NULL, NULL, NULL, 0),
(140706, 'CACRA', 1407, 1, NULL, NULL, NULL, 0),
(140707, 'CARANIA', 1407, 1, NULL, NULL, NULL, 0),
(140708, 'COCHAS', 1407, 1, NULL, NULL, NULL, 0),
(140709, 'COLONIA', 1407, 1, NULL, NULL, NULL, 0),
(140710, 'CHOCOS', 1407, 1, NULL, NULL, NULL, 0),
(140711, 'HUAMPARA', 1407, 1, NULL, NULL, NULL, 0),
(140712, 'HUANCAYA', 1407, 1, NULL, NULL, NULL, 0),
(140713, 'HUANGASCAR', 1407, 1, NULL, NULL, NULL, 0),
(140714, 'HUANTAN', 1407, 1, NULL, NULL, NULL, 0),
(140715, 'HUANEC', 1407, 1, NULL, NULL, NULL, 0),
(140716, 'LARAOS', 1407, 1, NULL, NULL, NULL, 0),
(140717, 'LINCHA', 1407, 1, NULL, NULL, NULL, 0),
(140718, 'MIRAFLORES', 1407, 1, NULL, NULL, NULL, 0),
(140719, 'OMAS', 1407, 1, NULL, NULL, NULL, 0),
(140720, 'QUINCHES', 1407, 1, NULL, NULL, NULL, 0),
(140721, 'QUINOCAY', 1407, 1, NULL, NULL, NULL, 0),
(140722, 'SAN JOAQUIN', 1407, 1, NULL, NULL, NULL, 0),
(140723, 'SAN PEDRO DE PILAS', 1407, 1, NULL, NULL, NULL, 0),
(140724, 'TANTA', 1407, 1, NULL, NULL, NULL, 0),
(140725, 'TAURIPAMPA', 1407, 1, NULL, NULL, NULL, 0),
(140726, 'TUPE', 1407, 1, NULL, NULL, NULL, 0),
(140727, 'TOMAS', 1407, 1, NULL, NULL, NULL, 0),
(140728, 'VINAC', 1407, 1, NULL, NULL, NULL, 0),
(140729, 'VITIS', 1407, 1, NULL, NULL, NULL, 0),
(140730, 'HONGOS', 1407, 1, NULL, NULL, NULL, 0),
(140731, 'MADEAN', 1407, 1, NULL, NULL, NULL, 0),
(140732, 'PUTINZA', 1407, 1, NULL, NULL, NULL, 0),
(140733, 'CATAHUASI', 1407, 1, NULL, NULL, NULL, 0),
(140801, 'HUARAL', 1408, 1, NULL, NULL, NULL, 0),
(140802, 'ATAVILLOS ALTO', 1408, 1, NULL, NULL, NULL, 0),
(140803, 'ATAVILLOS BAJO', 1408, 1, NULL, NULL, NULL, 0),
(140804, 'AUCALLAMA', 1408, 1, NULL, NULL, NULL, 0),
(140805, 'CHANCAY', 1408, 1, NULL, NULL, NULL, 0),
(140806, 'IHUARI', 1408, 1, NULL, NULL, NULL, 0),
(140807, 'LAMPIAN', 1408, 1, NULL, NULL, NULL, 0),
(140808, 'PACARAOS', 1408, 1, NULL, NULL, NULL, 0),
(140809, 'SAN MIGUEL DE ACOS', 1408, 1, NULL, NULL, NULL, 0),
(140810, 'VEINTISIETE DE NOVIEMBRE', 1408, 1, NULL, NULL, NULL, 0),
(140811, 'STA CRUZ DE ANDAMARCA', 1408, 1, NULL, NULL, NULL, 0),
(140812, 'SUMBILCA', 1408, 1, NULL, NULL, NULL, 0),
(140901, 'BARRANCA', 1409, 1, NULL, NULL, NULL, 0),
(140902, 'PARAMONGA', 1409, 1, NULL, NULL, NULL, 0),
(140903, 'PATIVILCA', 1409, 1, NULL, NULL, NULL, 0),
(140904, 'SUPE', 1409, 1, NULL, NULL, NULL, 0),
(140905, 'SUPE PUERTO', 1409, 1, NULL, NULL, NULL, 0),
(141001, 'OYON', 1410, 1, NULL, NULL, NULL, 0),
(141002, 'NAVAN', 1410, 1, NULL, NULL, NULL, 0),
(141003, 'CAUJUL', 1410, 1, NULL, NULL, NULL, 0),
(141004, 'ANDAJES', 1410, 1, NULL, NULL, NULL, 0),
(141005, 'PACHANGARA', 1410, 1, NULL, NULL, NULL, 0),
(141006, 'COCHAMARCA', 1410, 1, NULL, NULL, NULL, 0),
(150101, 'IQUITOS', 1501, 1, NULL, NULL, NULL, 0),
(150102, 'ALTO NANAY', 1501, 1, NULL, NULL, NULL, 0),
(150103, 'FERNANDO LORES', 1501, 1, NULL, NULL, NULL, 0),
(150104, 'LAS AMAZONAS', 1501, 1, NULL, NULL, NULL, 0),
(150105, 'MAZAN', 1501, 1, NULL, NULL, NULL, 0),
(150106, 'NAPO', 1501, 1, NULL, NULL, NULL, 0),
(150107, 'PUTUMAYO', 1501, 1, NULL, NULL, NULL, 0),
(150108, 'TORRES CAUSANA', 1501, 1, NULL, NULL, NULL, 0),
(150110, 'INDIANA', 1501, 1, NULL, NULL, NULL, 0),
(150111, 'PUNCHANA', 1501, 1, NULL, NULL, NULL, 0),
(150112, 'BELEN', 1501, 1, NULL, NULL, NULL, 0),
(150113, 'SAN JUAN BAUTISTA', 1501, 1, NULL, NULL, NULL, 0),
(150114, 'TNTE MANUEL CLAVERO', 1501, 1, NULL, NULL, NULL, 0),
(150201, 'YURIMAGUAS', 1502, 1, NULL, NULL, NULL, 0),
(150202, 'BALSAPUERTO', 1502, 1, NULL, NULL, NULL, 0),
(150205, 'JEBEROS', 1502, 1, NULL, NULL, NULL, 0),
(150206, 'LAGUNAS', 1502, 1, NULL, NULL, NULL, 0),
(150210, 'SANTA CRUZ', 1502, 1, NULL, NULL, NULL, 0),
(150211, 'TNTE CESAR LOPEZ ROJAS', 1502, 1, NULL, NULL, NULL, 0),
(150301, 'NAUTA', 1503, 1, NULL, NULL, NULL, 0),
(150302, 'PARINARI', 1503, 1, NULL, NULL, NULL, 0),
(150303, 'TIGRE', 1503, 1, NULL, NULL, NULL, 0),
(150304, 'URARINAS', 1503, 1, NULL, NULL, NULL, 0),
(150305, 'TROMPETEROS', 1503, 1, NULL, NULL, NULL, 0),
(150401, 'REQUENA', 1504, 1, NULL, NULL, NULL, 0),
(150402, 'ALTO TAPICHE', 1504, 1, NULL, NULL, NULL, 0),
(150403, 'CAPELO', 1504, 1, NULL, NULL, NULL, 0),
(150404, 'EMILIO SAN MARTIN', 1504, 1, NULL, NULL, NULL, 0),
(150405, 'MAQUIA', 1504, 1, NULL, NULL, NULL, 0),
(150406, 'PUINAHUA', 1504, 1, NULL, NULL, NULL, 0),
(150407, 'SAQUENA', 1504, 1, NULL, NULL, NULL, 0),
(150408, 'SOPLIN', 1504, 1, NULL, NULL, NULL, 0),
(150409, 'TAPICHE', 1504, 1, NULL, NULL, NULL, 0),
(150410, 'JENARO HERRERA', 1504, 1, NULL, NULL, NULL, 0),
(150411, 'YAQUERANA', 1504, 1, NULL, NULL, NULL, 0),
(150501, 'CONTAMANA', 1505, 1, NULL, NULL, NULL, 0),
(150502, 'VARGAS GUERRA', 1505, 1, NULL, NULL, NULL, 0),
(150503, 'PADRE MARQUEZ', 1505, 1, NULL, NULL, NULL, 0),
(150504, 'PAMPA HERMOZA', 1505, 1, NULL, NULL, NULL, 0),
(150505, 'SARAYACU', 1505, 1, NULL, NULL, NULL, 0),
(150506, 'INAHUAYA', 1505, 1, NULL, NULL, NULL, 0),
(150601, 'MARISCAL RAMON CASTILLA', 1506, 1, NULL, NULL, NULL, 0),
(150602, 'PEBAS', 1506, 1, NULL, NULL, NULL, 0),
(150603, 'YAVARI', 1506, 1, NULL, NULL, NULL, 0),
(150604, 'SAN PABLO', 1506, 1, NULL, NULL, NULL, 0),
(150701, 'BARRANCA', 1507, 1, NULL, NULL, NULL, 0),
(150702, 'ANDOAS', 1507, 1, NULL, NULL, NULL, 0),
(150703, 'CAHUAPANAS', 1507, 1, NULL, NULL, NULL, 0),
(150704, 'MANSERICHE', 1507, 1, NULL, NULL, NULL, 0),
(150705, 'MORONA', 1507, 1, NULL, NULL, NULL, 0),
(150706, 'PASTAZA', 1507, 1, NULL, NULL, NULL, 0),
(160101, 'TAMBOPATA', 1601, 1, NULL, NULL, NULL, 0),
(160102, 'INAMBARI', 1601, 1, NULL, NULL, NULL, 0),
(160103, 'LAS PIEDRAS', 1601, 1, NULL, NULL, NULL, 0),
(160104, 'LABERINTO', 1601, 1, NULL, NULL, NULL, 0),
(160201, 'MANU', 1602, 1, NULL, NULL, NULL, 0),
(160202, 'FITZCARRALD', 1602, 1, NULL, NULL, NULL, 0),
(160203, 'MADRE DE DIOS', 1602, 1, NULL, NULL, NULL, 0),
(160204, 'HUEPETUHE', 1602, 1, NULL, NULL, NULL, 0),
(160301, 'INAPARI', 1603, 1, NULL, NULL, NULL, 0),
(160302, 'IBERIA', 1603, 1, NULL, NULL, NULL, 0),
(160303, 'TAHUAMANU', 1603, 1, NULL, NULL, NULL, 0),
(170101, 'MOQUEGUA', 1701, 1, NULL, NULL, NULL, 0),
(170102, 'CARUMAS', 1701, 1, NULL, NULL, NULL, 0),
(170103, 'CUCHUMBAYA', 1701, 1, NULL, NULL, NULL, 0),
(170104, 'SAN CRISTOBAL', 1701, 1, NULL, NULL, NULL, 0),
(170105, 'TORATA', 1701, 1, NULL, NULL, NULL, 0),
(170106, 'SAMEGUA', 1701, 1, NULL, NULL, NULL, 0),
(170201, 'OMATE', 1702, 1, NULL, NULL, NULL, 0),
(170202, 'COALAQUE', 1702, 1, NULL, NULL, NULL, 0),
(170203, 'CHOJATA', 1702, 1, NULL, NULL, NULL, 0),
(170204, 'ICHUNA', 1702, 1, NULL, NULL, NULL, 0),
(170205, 'LA CAPILLA', 1702, 1, NULL, NULL, NULL, 0),
(170206, 'LLOQUE', 1702, 1, NULL, NULL, NULL, 0),
(170207, 'MATALAQUE', 1702, 1, NULL, NULL, NULL, 0),
(170208, 'PUQUINA', 1702, 1, NULL, NULL, NULL, 0),
(170209, 'QUINISTAQUILLAS', 1702, 1, NULL, NULL, NULL, 0),
(170210, 'UBINAS', 1702, 1, NULL, NULL, NULL, 0),
(170211, 'YUNGA', 1702, 1, NULL, NULL, NULL, 0),
(170301, 'ILO', 1703, 1, NULL, NULL, NULL, 0),
(170302, 'EL ALGARROBAL', 1703, 1, NULL, NULL, NULL, 0),
(170303, 'PACOCHA', 1703, 1, NULL, NULL, NULL, 0),
(180101, 'CHAUPIMARCA', 1801, 1, NULL, NULL, NULL, 0),
(180103, 'HUACHON', 1801, 1, NULL, NULL, NULL, 0),
(180104, 'HUARIACA', 1801, 1, NULL, NULL, NULL, 0),
(180105, 'HUAYLLAY', 1801, 1, NULL, NULL, NULL, 0),
(180106, 'NINACACA', 1801, 1, NULL, NULL, NULL, 0),
(180107, 'PALLANCHACRA', 1801, 1, NULL, NULL, NULL, 0),
(180108, 'PAUCARTAMBO', 1801, 1, NULL, NULL, NULL, 0),
(180109, 'SAN FCO DE ASIS DE YARUSYACAN', 1801, 1, NULL, NULL, NULL, 0),
(180110, 'SIMON BOLIVAR', 1801, 1, NULL, NULL, NULL, 0),
(180111, 'TICLACAYAN', 1801, 1, NULL, NULL, NULL, 0),
(180112, 'TINYAHUARCO', 1801, 1, NULL, NULL, NULL, 0),
(180113, 'VICCO', 1801, 1, NULL, NULL, NULL, 0),
(180114, 'YANACANCHA', 1801, 1, NULL, NULL, NULL, 0),
(180201, 'YANAHUANCA', 1802, 1, NULL, NULL, NULL, 0),
(180202, 'CHACAYAN', 1802, 1, NULL, NULL, NULL, 0),
(180203, 'GOYLLARISQUIZGA', 1802, 1, NULL, NULL, NULL, 0),
(180204, 'PAUCAR', 1802, 1, NULL, NULL, NULL, 0),
(180205, 'SAN PEDRO DE PILLAO', 1802, 1, NULL, NULL, NULL, 0),
(180206, 'SANTA ANA DE TUSI', 1802, 1, NULL, NULL, NULL, 0),
(180207, 'TAPUC', 1802, 1, NULL, NULL, NULL, 0),
(180208, 'VILCABAMBA', 1802, 1, NULL, NULL, NULL, 0),
(180301, 'OXAPAMPA', 1803, 1, NULL, NULL, NULL, 0),
(180302, 'CHONTABAMBA', 1803, 1, NULL, NULL, NULL, 0),
(180303, 'HUANCABAMBA', 1803, 1, NULL, NULL, NULL, 0),
(180304, 'PUERTO BERMUDEZ', 1803, 1, NULL, NULL, NULL, 0),
(180305, 'VILLA RICA', 1803, 1, NULL, NULL, NULL, 0),
(180306, 'POZUZO', 1803, 1, NULL, NULL, NULL, 0),
(180307, 'PALCAZU', 1803, 1, NULL, NULL, NULL, 0),
(190101, 'PIURA', 1901, 1, NULL, NULL, NULL, 0),
(190103, 'CASTILLA', 1901, 1, NULL, NULL, NULL, 0),
(190104, 'CATACAOS', 1901, 1, NULL, NULL, NULL, 0),
(190105, 'LA ARENA', 1901, 1, NULL, NULL, NULL, 0),
(190106, 'LA UNION', 1901, 1, NULL, NULL, NULL, 0),
(190107, 'LAS LOMAS', 1901, 1, NULL, NULL, NULL, 0),
(190109, 'TAMBO GRANDE', 1901, 1, NULL, NULL, NULL, 0),
(190113, 'CURA MORI', 1901, 1, NULL, NULL, NULL, 0),
(190114, 'EL TALLAN', 1901, 1, NULL, NULL, NULL, 0),
(190201, 'AYABACA', 1902, 1, NULL, NULL, NULL, 0),
(190202, 'FRIAS', 1902, 1, NULL, NULL, NULL, 0),
(190203, 'LAGUNAS', 1902, 1, NULL, NULL, NULL, 0),
(190204, 'MONTERO', 1902, 1, NULL, NULL, NULL, 0),
(190205, 'PACAIPAMPA', 1902, 1, NULL, NULL, NULL, 0),
(190206, 'SAPILLICA', 1902, 1, NULL, NULL, NULL, 0),
(190207, 'SICCHEZ', 1902, 1, NULL, NULL, NULL, 0),
(190208, 'SUYO', 1902, 1, NULL, NULL, NULL, 0),
(190209, 'JILILI', 1902, 1, NULL, NULL, NULL, 0),
(190210, 'PAIMAS', 1902, 1, NULL, NULL, NULL, 0),
(190301, 'HUANCABAMBA', 1903, 1, NULL, NULL, NULL, 0),
(190302, 'CANCHAQUE', 1903, 1, NULL, NULL, NULL, 0),
(190303, 'HUARMACA', 1903, 1, NULL, NULL, NULL, 0),
(190304, 'SONDOR', 1903, 1, NULL, NULL, NULL, 0),
(190305, 'SONDORILLO', 1903, 1, NULL, NULL, NULL, 0),
(190306, 'EL CARMEN DE LA FRONTERA', 1903, 1, NULL, NULL, NULL, 0),
(190307, 'SAN MIGUEL DE EL FAIQUE', 1903, 1, NULL, NULL, NULL, 0),
(190308, 'LALAQUIZ', 1903, 1, NULL, NULL, NULL, 0),
(190401, 'CHULUCANAS', 1904, 1, NULL, NULL, NULL, 0),
(190402, 'BUENOS AIRES', 1904, 1, NULL, NULL, NULL, 0),
(190403, 'CHALACO', 1904, 1, NULL, NULL, NULL, 0),
(190404, 'MORROPON', 1904, 1, NULL, NULL, NULL, 0),
(190405, 'SALITRAL', 1904, 1, NULL, NULL, NULL, 0),
(190406, 'SANTA CATALINA DE MOSSA', 1904, 1, NULL, NULL, NULL, 0),
(190407, 'SANTO DOMINGO', 1904, 1, NULL, NULL, NULL, 0),
(190408, 'LA MATANZA', 1904, 1, NULL, NULL, NULL, 0),
(190409, 'YAMANGO', 1904, 1, NULL, NULL, NULL, 0),
(190410, 'SAN JUAN DE BIGOTE', 1904, 1, NULL, NULL, NULL, 0),
(190501, 'PAITA', 1905, 1, NULL, NULL, NULL, 0),
(190502, 'AMOTAPE', 1905, 1, NULL, NULL, NULL, 0),
(190503, 'ARENAL', 1905, 1, NULL, NULL, NULL, 0),
(190504, 'LA HUACA', 1905, 1, NULL, NULL, NULL, 0),
(190505, 'PUEBLO NUEVO DE COLAN', 1905, 1, NULL, NULL, NULL, 0),
(190506, 'TAMARINDO', 1905, 1, NULL, NULL, NULL, 0),
(190507, 'VICHAYAL', 1905, 1, NULL, NULL, NULL, 0),
(190601, 'SULLANA', 1906, 1, NULL, NULL, NULL, 0),
(190602, 'BELLAVISTA', 1906, 1, NULL, NULL, NULL, 0),
(190603, 'LANCONES', 1906, 1, NULL, NULL, NULL, 0),
(190604, 'MARCAVELICA', 1906, 1, NULL, NULL, NULL, 0),
(190605, 'MIGUEL CHECA', 1906, 1, NULL, NULL, NULL, 0),
(190606, 'QUERECOTILLO', 1906, 1, NULL, NULL, NULL, 0),
(190607, 'SALITRAL', 1906, 1, NULL, NULL, NULL, 0),
(190608, 'IGNACIO ESCUDERO', 1906, 1, NULL, NULL, NULL, 0),
(190701, 'PARINAS', 1907, 1, NULL, NULL, NULL, 0),
(190702, 'EL ALTO', 1907, 1, NULL, NULL, NULL, 0),
(190703, 'LA BREA', 1907, 1, NULL, NULL, NULL, 0),
(190704, 'LOBITOS', 1907, 1, NULL, NULL, NULL, 0),
(190705, 'MANCORA', 1907, 1, NULL, NULL, NULL, 0),
(190706, 'LOS ORGANOS', 1907, 1, NULL, NULL, NULL, 0),
(190801, 'SECHURA', 1908, 1, NULL, NULL, NULL, 0),
(190802, 'VICE', 1908, 1, NULL, NULL, NULL, 0),
(190803, 'BERNAL', 1908, 1, NULL, NULL, NULL, 0),
(190804, 'BELLAVISTA DE LA UNION', 1908, 1, NULL, NULL, NULL, 0),
(190805, 'CRISTO NOS VALGA', 1908, 1, NULL, NULL, NULL, 0),
(190806, 'RINCONADA LLICUAR', 1908, 1, NULL, NULL, NULL, 0),
(200101, 'PUNO', 2001, 1, NULL, NULL, NULL, 0),
(200102, 'ACORA', 2001, 1, NULL, NULL, NULL, 0),
(200103, 'ATUNCOLLA', 2001, 1, NULL, NULL, NULL, 0),
(200104, 'CAPACHICA', 2001, 1, NULL, NULL, NULL, 0),
(200105, 'COATA', 2001, 1, NULL, NULL, NULL, 0),
(200106, 'CHUCUITO', 2001, 1, NULL, NULL, NULL, 0),
(200107, 'HUATA', 2001, 1, NULL, NULL, NULL, 0),
(200108, 'MANAZO', 2001, 1, NULL, NULL, NULL, 0),
(200109, 'PAUCARCOLLA', 2001, 1, NULL, NULL, NULL, 0),
(200110, 'PICHACANI', 2001, 1, NULL, NULL, NULL, 0),
(200111, 'SAN ANTONIO', 2001, 1, NULL, NULL, NULL, 0),
(200112, 'TIQUILLACA', 2001, 1, NULL, NULL, NULL, 0),
(200113, 'VILQUE', 2001, 1, NULL, NULL, NULL, 0),
(200114, 'PLATERIA', 2001, 1, NULL, NULL, NULL, 0),
(200115, 'AMANTANI', 2001, 1, NULL, NULL, NULL, 0),
(200201, 'AZANGARO', 2002, 1, NULL, NULL, NULL, 0),
(200202, 'ACHAYA', 2002, 1, NULL, NULL, NULL, 0),
(200203, 'ARAPA', 2002, 1, NULL, NULL, NULL, 0),
(200204, 'ASILLO', 2002, 1, NULL, NULL, NULL, 0),
(200205, 'CAMINACA', 2002, 1, NULL, NULL, NULL, 0),
(200206, 'CHUPA', 2002, 1, NULL, NULL, NULL, 0),
(200207, 'JOSE DOMINGO CHOQUEHUANCA', 2002, 1, NULL, NULL, NULL, 0),
(200208, 'MUNANI', 2002, 1, NULL, NULL, NULL, 0),
(200210, 'POTONI', 2002, 1, NULL, NULL, NULL, 0),
(200212, 'SAMAN', 2002, 1, NULL, NULL, NULL, 0),
(200213, 'SAN ANTON', 2002, 1, NULL, NULL, NULL, 0),
(200214, 'SAN JOSE', 2002, 1, NULL, NULL, NULL, 0),
(200215, 'SAN JUAN DE SALINAS', 2002, 1, NULL, NULL, NULL, 0),
(200216, 'STGO DE PUPUJA', 2002, 1, NULL, NULL, NULL, 0),
(200217, 'TIRAPATA', 2002, 1, NULL, NULL, NULL, 0),
(200301, 'MACUSANI', 2003, 1, NULL, NULL, NULL, 0),
(200302, 'AJOYANI', 2003, 1, NULL, NULL, NULL, 0),
(200303, 'AYAPATA', 2003, 1, NULL, NULL, NULL, 0),
(200304, 'COASA', 2003, 1, NULL, NULL, NULL, 0),
(200305, 'CORANI', 2003, 1, NULL, NULL, NULL, 0),
(200306, 'CRUCERO', 2003, 1, NULL, NULL, NULL, 0),
(200307, 'ITUATA', 2003, 1, NULL, NULL, NULL, 0),
(200308, 'OLLACHEA', 2003, 1, NULL, NULL, NULL, 0),
(200309, 'SAN GABAN', 2003, 1, NULL, NULL, NULL, 0),
(200310, 'USICAYOS', 2003, 1, NULL, NULL, NULL, 0),
(200401, 'JULI', 2004, 1, NULL, NULL, NULL, 0),
(200402, 'DESAGUADERO', 2004, 1, NULL, NULL, NULL, 0),
(200403, 'HUACULLANI', 2004, 1, NULL, NULL, NULL, 0),
(200406, 'PISACOMA', 2004, 1, NULL, NULL, NULL, 0),
(200407, 'POMATA', 2004, 1, NULL, NULL, NULL, 0),
(200410, 'ZEPITA', 2004, 1, NULL, NULL, NULL, 0),
(200412, 'KELLUYO', 2004, 1, NULL, NULL, NULL, 0),
(200501, 'HUANCANE', 2005, 1, NULL, NULL, NULL, 0),
(200502, 'COJATA', 2005, 1, NULL, NULL, NULL, 0),
(200504, 'INCHUPALLA', 2005, 1, NULL, NULL, NULL, 0),
(200506, 'PUSI', 2005, 1, NULL, NULL, NULL, 0),
(200507, 'ROSASPATA', 2005, 1, NULL, NULL, NULL, 0),
(200508, 'TARACO', 2005, 1, NULL, NULL, NULL, 0),
(200509, 'VILQUE CHICO', 2005, 1, NULL, NULL, NULL, 0),
(200511, 'HUATASANI', 2005, 1, NULL, NULL, NULL, 0),
(200601, 'LAMPA', 2006, 1, NULL, NULL, NULL, 0),
(200602, 'CABANILLA', 2006, 1, NULL, NULL, NULL, 0),
(200603, 'CALAPUJA', 2006, 1, NULL, NULL, NULL, 0),
(200604, 'NICASIO', 2006, 1, NULL, NULL, NULL, 0),
(200605, 'OCUVIRI', 2006, 1, NULL, NULL, NULL, 0),
(200606, 'PALCA', 2006, 1, NULL, NULL, NULL, 0),
(200607, 'PARATIA', 2006, 1, NULL, NULL, NULL, 0),
(200608, 'PUCARA', 2006, 1, NULL, NULL, NULL, 0),
(200609, 'SANTA LUCIA', 2006, 1, NULL, NULL, NULL, 0),
(200610, 'VILAVILA', 2006, 1, NULL, NULL, NULL, 0),
(200701, 'AYAVIRI', 2007, 1, NULL, NULL, NULL, 0),
(200702, 'ANTAUTA', 2007, 1, NULL, NULL, NULL, 0),
(200703, 'CUPI', 2007, 1, NULL, NULL, NULL, 0),
(200704, 'LLALLI', 2007, 1, NULL, NULL, NULL, 0),
(200705, 'MACARI', 2007, 1, NULL, NULL, NULL, 0),
(200706, 'NUNOA', 2007, 1, NULL, NULL, NULL, 0),
(200707, 'ORURILLO', 2007, 1, NULL, NULL, NULL, 0),
(200708, 'SANTA ROSA', 2007, 1, NULL, NULL, NULL, 0),
(200709, 'UMACHIRI', 2007, 1, NULL, NULL, NULL, 0),
(200801, 'SANDIA', 2008, 1, NULL, NULL, NULL, 0),
(200803, 'CUYOCUYO', 2008, 1, NULL, NULL, NULL, 0),
(200804, 'LIMBANI', 2008, 1, NULL, NULL, NULL, 0),
(200805, 'PHARA', 2008, 1, NULL, NULL, NULL, 0),
(200806, 'PATAMBUCO', 2008, 1, NULL, NULL, NULL, 0),
(200807, 'QUIACA', 2008, 1, NULL, NULL, NULL, 0),
(200808, 'SAN JUAN DEL ORO', 2008, 1, NULL, NULL, NULL, 0),
(200810, 'YANAHUAYA', 2008, 1, NULL, NULL, NULL, 0),
(200811, 'ALTO INAMBARI', 2008, 1, NULL, NULL, NULL, 0),
(200812, 'SAN PEDRO DE PUTINA PUNCO', 2008, 1, NULL, NULL, NULL, 0),
(200901, 'JULIACA', 2009, 1, NULL, NULL, NULL, 0),
(200902, 'CABANA', 2009, 1, NULL, NULL, NULL, 0),
(200903, 'CABANILLAS', 2009, 1, NULL, NULL, NULL, 0),
(200904, 'CARACOTO', 2009, 1, NULL, NULL, NULL, 0),
(201001, 'YUNGUYO', 2010, 1, NULL, NULL, NULL, 0),
(201002, 'UNICACHI', 2010, 1, NULL, NULL, NULL, 0),
(201003, 'ANAPIA', 2010, 1, NULL, NULL, NULL, 0),
(201004, 'COPANI', 2010, 1, NULL, NULL, NULL, 0),
(201005, 'CUTURAPI', 2010, 1, NULL, NULL, NULL, 0),
(201006, 'OLLARAYA', 2010, 1, NULL, NULL, NULL, 0),
(201007, 'TINICACHI', 2010, 1, NULL, NULL, NULL, 0),
(201101, 'PUTINA', 2011, 1, NULL, NULL, NULL, 0),
(201102, 'PEDRO VILCA APAZA', 2011, 1, NULL, NULL, NULL, 0),
(201103, 'QUILCA PUNCU', 2011, 1, NULL, NULL, NULL, 0),
(201104, 'ANANEA', 2011, 1, NULL, NULL, NULL, 0),
(201105, 'SINA', 2011, 1, NULL, NULL, NULL, 0),
(201201, 'ILAVE', 2012, 1, NULL, NULL, NULL, 0),
(201202, 'PILCUYO', 2012, 1, NULL, NULL, NULL, 0),
(201203, 'SANTA ROSA', 2012, 1, NULL, NULL, NULL, 0),
(201204, 'CAPASO', 2012, 1, NULL, NULL, NULL, 0),
(201205, 'CONDURIRI', 2012, 1, NULL, NULL, NULL, 0),
(201301, 'MOHO', 2013, 1, NULL, NULL, NULL, 0),
(201302, 'CONIMA', 2013, 1, NULL, NULL, NULL, 0),
(201303, 'TILALI', 2013, 1, NULL, NULL, NULL, 0),
(201304, 'HUAYRAPATA', 2013, 1, NULL, NULL, NULL, 0),
(210101, 'MOYOBAMBA', 2101, 1, NULL, NULL, NULL, 0),
(210102, 'CALZADA', 2101, 1, NULL, NULL, NULL, 0),
(210103, 'HABANA', 2101, 1, NULL, NULL, NULL, 0),
(210104, 'JEPELACIO', 2101, 1, NULL, NULL, NULL, 0),
(210105, 'SORITOR', 2101, 1, NULL, NULL, NULL, 0),
(210106, 'YANTALO', 2101, 1, NULL, NULL, NULL, 0),
(210201, 'SAPOSOA', 2102, 1, NULL, NULL, NULL, 0),
(210202, 'PISCOYACU', 2102, 1, NULL, NULL, NULL, 0),
(210203, 'SACANCHE', 2102, 1, NULL, NULL, NULL, 0),
(210204, 'TINGO DE SAPOSOA', 2102, 1, NULL, NULL, NULL, 0),
(210205, 'ALTO SAPOSOA', 2102, 1, NULL, NULL, NULL, 0),
(210206, 'EL ESLABON', 2102, 1, NULL, NULL, NULL, 0),
(210301, 'LAMAS', 2103, 1, NULL, NULL, NULL, 0),
(210303, 'BARRANQUITA', 2103, 1, NULL, NULL, NULL, 0),
(210304, 'CAYNARACHI', 2103, 1, NULL, NULL, NULL, 0),
(210305, 'CUNUMBUQUI', 2103, 1, NULL, NULL, NULL, 0),
(210306, 'PINTO RECODO', 2103, 1, NULL, NULL, NULL, 0),
(210307, 'RUMISAPA', 2103, 1, NULL, NULL, NULL, 0),
(210311, 'SHANAO', 2103, 1, NULL, NULL, NULL, 0),
(210313, 'TABALOSOS', 2103, 1, NULL, NULL, NULL, 0),
(210314, 'ZAPATERO', 2103, 1, NULL, NULL, NULL, 0),
(210315, 'ALONSO DE ALVARADO', 2103, 1, NULL, NULL, NULL, 0),
(210316, 'SAN ROQUE DE CUMBAZA', 2103, 1, NULL, NULL, NULL, 0),
(210401, 'JUANJUI', 2104, 1, NULL, NULL, NULL, 0),
(210402, 'CAMPANILLA', 2104, 1, NULL, NULL, NULL, 0),
(210403, 'HUICUNGO', 2104, 1, NULL, NULL, NULL, 0),
(210404, 'PACHIZA', 2104, 1, NULL, NULL, NULL, 0),
(210405, 'PAJARILLO', 2104, 1, NULL, NULL, NULL, 0),
(210501, 'RIOJA', 2105, 1, NULL, NULL, NULL, 0),
(210502, 'POSIC', 2105, 1, NULL, NULL, NULL, 0),
(210503, 'YORONGOS', 2105, 1, NULL, NULL, NULL, 0),
(210504, 'YURACYACU', 2105, 1, NULL, NULL, NULL, 0),
(210505, 'NUEVA CAJAMARCA', 2105, 1, NULL, NULL, NULL, 0),
(210506, 'ELIAS SOPLIN', 2105, 1, NULL, NULL, NULL, 0),
(210507, 'SAN FERNANDO', 2105, 1, NULL, NULL, NULL, 0),
(210508, 'PARDO MIGUEL', 2105, 1, NULL, NULL, NULL, 0),
(210509, 'AWAJUN', 2105, 1, NULL, NULL, NULL, 0),
(210601, 'TARAPOTO', 2106, 1, NULL, NULL, NULL, 0),
(210602, 'ALBERTO LEVEAU', 2106, 1, NULL, NULL, NULL, 0),
(210604, 'CACATACHI', 2106, 1, NULL, NULL, NULL, 0),
(210606, 'CHAZUTA', 2106, 1, NULL, NULL, NULL, 0),
(210607, 'CHIPURANA', 2106, 1, NULL, NULL, NULL, 0),
(210608, 'EL PORVENIR', 2106, 1, NULL, NULL, NULL, 0),
(210609, 'HUIMBAYOC', 2106, 1, NULL, NULL, NULL, 0),
(210610, 'JUAN GUERRA', 2106, 1, NULL, NULL, NULL, 0),
(210611, 'MORALES', 2106, 1, NULL, NULL, NULL, 0),
(210612, 'PAPAPLAYA', 2106, 1, NULL, NULL, NULL, 0),
(210616, 'SAN ANTONIO', 2106, 1, NULL, NULL, NULL, 0),
(210619, 'SAUCE', 2106, 1, NULL, NULL, NULL, 0),
(210620, 'SHAPAJA', 2106, 1, NULL, NULL, NULL, 0),
(210621, 'LA BANDA DE SHILCAYO', 2106, 1, NULL, NULL, NULL, 0),
(210701, 'BELLAVISTA', 2107, 1, NULL, NULL, NULL, 0),
(210702, 'SAN RAFAEL', 2107, 1, NULL, NULL, NULL, 0),
(210703, 'SAN PABLO', 2107, 1, NULL, NULL, NULL, 0),
(210704, 'ALTO BIAVO', 2107, 1, NULL, NULL, NULL, 0),
(210705, 'HUALLAGA', 2107, 1, NULL, NULL, NULL, 0),
(210706, 'BAJO BIAVO', 2107, 1, NULL, NULL, NULL, 0),
(210801, 'TOCACHE', 2108, 1, NULL, NULL, NULL, 0),
(210802, 'NUEVO PROGRESO', 2108, 1, NULL, NULL, NULL, 0),
(210803, 'POLVORA', 2108, 1, NULL, NULL, NULL, 0),
(210804, 'SHUNTE', 2108, 1, NULL, NULL, NULL, 0),
(210805, 'UCHIZA', 2108, 1, NULL, NULL, NULL, 0),
(210901, 'PICOTA', 2109, 1, NULL, NULL, NULL, 0),
(210902, 'BUENOS AIRES', 2109, 1, NULL, NULL, NULL, 0),
(210903, 'CASPIZAPA', 2109, 1, NULL, NULL, NULL, 0),
(210904, 'PILLUANA', 2109, 1, NULL, NULL, NULL, 0),
(210905, 'PUCACACA', 2109, 1, NULL, NULL, NULL, 0),
(210906, 'SAN CRISTOBAL', 2109, 1, NULL, NULL, NULL, 0),
(210907, 'SAN HILARION', 2109, 1, NULL, NULL, NULL, 0),
(210908, 'TINGO DE PONASA', 2109, 1, NULL, NULL, NULL, 0),
(210909, 'TRES UNIDOS', 2109, 1, NULL, NULL, NULL, 0),
(210910, 'SHAMBOYACU', 2109, 1, NULL, NULL, NULL, 0),
(211001, 'SAN JOSE DE SISA', 2110, 1, NULL, NULL, NULL, 0),
(211002, 'AGUA BLANCA', 2110, 1, NULL, NULL, NULL, 0),
(211003, 'SHATOJA', 2110, 1, NULL, NULL, NULL, 0),
(211004, 'SAN MARTIN', 2110, 1, NULL, NULL, NULL, 0),
(211005, 'SANTA ROSA', 2110, 1, NULL, NULL, NULL, 0),
(220101, 'TACNA', 2201, 1, NULL, NULL, NULL, 0),
(220102, 'CALANA', 2201, 1, NULL, NULL, NULL, 0),
(220104, 'INCLAN', 2201, 1, NULL, NULL, NULL, 0),
(220107, 'PACHIA', 2201, 1, NULL, NULL, NULL, 0),
(220108, 'PALCA', 2201, 1, NULL, NULL, NULL, 0),
(220109, 'POCOLLAY', 2201, 1, NULL, NULL, NULL, 0),
(220110, 'SAMA', 2201, 1, NULL, NULL, NULL, 0),
(220111, 'ALTO DE LA ALIANZA', 2201, 1, NULL, NULL, NULL, 0),
(220112, 'CIUDAD NUEVA', 2201, 1, NULL, NULL, NULL, 0),
(220113, 'CORONEL GREGORIO ALBARRACIN L.ALFONSO UGARTE', 2201, 1, NULL, NULL, NULL, 0),
(220201, 'TARATA', 2202, 1, NULL, NULL, NULL, 0),
(220205, 'CHUCATAMANI', 2202, 1, NULL, NULL, NULL, 0),
(220206, 'ESTIQUE', 2202, 1, NULL, NULL, NULL, 0),
(220207, 'ESTIQUE PAMPA', 2202, 1, NULL, NULL, NULL, 0),
(220210, 'SITAJARA', 2202, 1, NULL, NULL, NULL, 0),
(220211, 'SUSAPAYA', 2202, 1, NULL, NULL, NULL, 0),
(220212, 'TARUCACHI', 2202, 1, NULL, NULL, NULL, 0),
(220213, 'TICACO', 2202, 1, NULL, NULL, NULL, 0),
(220301, 'LOCUMBA', 2203, 1, NULL, NULL, NULL, 0),
(220302, 'ITE', 2203, 1, NULL, NULL, NULL, 0),
(220303, 'ILABAYA', 2203, 1, NULL, NULL, NULL, 0),
(220401, 'CANDARAVE', 2204, 1, NULL, NULL, NULL, 0),
(220402, 'CAIRANI', 2204, 1, NULL, NULL, NULL, 0),
(220403, 'CURIBAYA', 2204, 1, NULL, NULL, NULL, 0),
(220404, 'HUANUARA', 2204, 1, NULL, NULL, NULL, 0),
(220405, 'QUILAHUANI', 2204, 1, NULL, NULL, NULL, 0),
(220406, 'CAMILACA', 2204, 1, NULL, NULL, NULL, 0),
(230101, 'TUMBES', 2301, 1, NULL, NULL, NULL, 0),
(230102, 'CORRALES', 2301, 1, NULL, NULL, NULL, 0),
(230103, 'LA CRUZ', 2301, 1, NULL, NULL, NULL, 0),
(230104, 'PAMPAS DE HOSPITAL', 2301, 1, NULL, NULL, NULL, 0),
(230105, 'SAN JACINTO', 2301, 1, NULL, NULL, NULL, 0),
(230106, 'SAN JUAN DE LA VIRGEN', 2301, 1, NULL, NULL, NULL, 0),
(230201, 'ZORRITOS', 2302, 1, NULL, NULL, NULL, 0),
(230202, 'CASITAS', 2302, 1, NULL, NULL, NULL, 0),
(230203, 'CANOAS DE PUNTA SAL', 2302, 1, NULL, NULL, NULL, 0),
(230301, 'ZARUMILLA', 2303, 1, NULL, NULL, NULL, 0),
(230302, 'MATAPALO', 2303, 1, NULL, NULL, NULL, 0),
(230303, 'PAPAYAL', 2303, 1, NULL, NULL, NULL, 0),
(230304, 'AGUAS VERDES', 2303, 1, NULL, NULL, NULL, 0),
(240101, 'CALLAO', 2401, 1, NULL, NULL, NULL, 0),
(240102, 'BELLAVISTA', 2401, 1, NULL, NULL, NULL, 0),
(240103, 'LA PUNTA', 2401, 1, NULL, NULL, NULL, 0),
(240104, 'CARMEN DE LA LEGUA-REYNOSO', 2401, 1, NULL, NULL, NULL, 0),
(240105, 'LA PERLA', 2401, 1, NULL, NULL, NULL, 0),
(240106, 'VENTANILLA', 2401, 1, NULL, NULL, NULL, 0),
(250101, 'CALLERIA', 2501, 1, NULL, NULL, NULL, 0),
(250102, 'YARINACOCHA', 2501, 1, NULL, NULL, NULL, 0),
(250103, 'MASISEA', 2501, 1, NULL, NULL, NULL, 0),
(250104, 'CAMPOVERDE', 2501, 1, NULL, NULL, NULL, 0),
(250105, 'IPARIA', 2501, 1, NULL, NULL, NULL, 0),
(250106, 'NUEVA REQUENA', 2501, 1, NULL, NULL, NULL, 0),
(250107, 'MANANTAY', 2501, 1, NULL, NULL, NULL, 0),
(250201, 'PADRE ABAD', 2502, 1, NULL, NULL, NULL, 0),
(250202, 'YRAZOLA', 2502, 1, NULL, NULL, NULL, 0),
(250203, 'CURIMANA', 2502, 1, NULL, NULL, NULL, 0),
(250301, 'RAIMONDI', 2503, 1, NULL, NULL, NULL, 0),
(250302, 'TAHUANIA', 2503, 1, NULL, NULL, NULL, 0),
(250303, 'YURUA', 2503, 1, NULL, NULL, NULL, 0),
(250304, 'SEPAHUA', 2503, 1, NULL, NULL, NULL, 0),
(250401, 'PURUS', 2504, 1, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documento`
--

CREATE TABLE `documento` (
  `codigo_doc` int(11) NOT NULL,
  `nombre_doc` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `codigosunat_doc` varchar(2) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `estado_doc` int(11) DEFAULT '1',
  `usuario_reg` int(11) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_mod` int(11) DEFAULT NULL,
  `fecha_mod` timestamp NULL DEFAULT NULL,
  `sistema` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `documento`
--

INSERT INTO `documento` (`codigo_doc`, `nombre_doc`, `codigosunat_doc`, `estado_doc`, `usuario_reg`, `usuario_mod`, `fecha_mod`, `sistema`) VALUES
(1, 'DNI', '01', 1, 0, 0, '2022-06-05 00:14:41', 0),
(2, 'RUC', '06', 1, 0, NULL, NULL, 0),
(3, 'OTROS', '00', 1, 0, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupoconcepto`
--

CREATE TABLE `grupoconcepto` (
  `codigo_gco` int(11) NOT NULL,
  `nombre_gco` varchar(500) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `esgasto_gco` int(11) DEFAULT '0',
  `estado_gco` int(11) DEFAULT '1',
  `usuario_reg` int(11) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_mod` int(11) DEFAULT NULL,
  `fecha_mod` timestamp NULL DEFAULT NULL,
  `sistema` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `grupoconcepto`
--

INSERT INTO `grupoconcepto` (`codigo_gco`, `nombre_gco`, `esgasto_gco`, `estado_gco`, `usuario_reg`, `usuario_mod`, `fecha_mod`, `sistema`) VALUES
(1, 'MOVIMIENTO CLIENTE/PROVEEDOR', 0, 1, 0, 0, '2022-06-05 00:35:59', 0),
(2, 'GASTOS ADMINISTRATIVOS', 1, 1, 0, 0, '2024-06-16 01:35:15', 0),
(3, 'GASTOS DE VENTAS', 1, 1, 0, 0, '2024-06-16 01:35:25', 0),
(4, 'GASTOS DE PRODUCCION', 1, 1, 0, 0, '2024-06-16 01:35:21', 0),
(5, 'OTRO', 0, 0, 0, 0, '2022-06-05 00:41:37', 0),
(6, 'G1 SI', 1, 0, 0, 0, '2024-06-21 04:21:52', 0),
(7, 'G2', 0, 0, 0, 0, '2024-06-21 04:21:50', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `linea`
--

CREATE TABLE `linea` (
  `codigo_lin` int(11) NOT NULL,
  `nombre_lin` varchar(500) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `serviciotecnico_lin` int(11) DEFAULT '0',
  `estado_lin` int(11) DEFAULT '1',
  `usuario_reg` int(11) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_mod` int(11) DEFAULT NULL,
  `fecha_mod` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `linea`
--

INSERT INTO `linea` (`codigo_lin`, `nombre_lin`, `serviciotecnico_lin`, `estado_lin`, `usuario_reg`, `usuario_mod`, `fecha_mod`) VALUES
(1, 'MOTOFUMIGADORES', 0, 1, NULL, NULL, NULL),
(2, 'MOCHILAS MANUALES DE ESPALDA', 0, 1, NULL, NULL, NULL),
(3, 'MOTOGUADAÑAS', 0, 1, NULL, NULL, NULL),
(4, 'MOTOSIERRAS', 0, 1, NULL, NULL, NULL),
(5, 'MOTOR ESTACIONARIO', 0, 1, NULL, NULL, NULL),
(6, 'BARRA DE FUMIGACION', 0, 1, NULL, NULL, NULL),
(7, 'BOQUILLAS', 0, 1, NULL, NULL, NULL),
(8, 'MOTOR DE FUERZA', 0, 1, NULL, NULL, NULL),
(9, 'GENERADORES', 0, 1, NULL, NULL, NULL),
(10, 'ACEITE', 0, 1, NULL, NULL, NULL),
(11, 'REPUESTOS', 0, 1, NULL, NULL, NULL),
(12, 'MANGUERA', 0, 1, NULL, NULL, NULL),
(13, 'CABEZAL DE BOMBA', 0, 1, NULL, NULL, NULL),
(14, 'PODADORA ALTURA', 0, 1, NULL, NULL, NULL),
(15, 'AZUFRADORAS', 0, 1, NULL, NULL, NULL),
(16, 'OTROS', 0, 1, NULL, NULL, NULL),
(17, 'ACSESORIOS', 0, 1, NULL, NULL, NULL),
(18, 'FILTROS', 0, 1, NULL, NULL, NULL),
(19, 'MOTOBOMBA', 0, 1, NULL, NULL, NULL),
(20, 'PISTOLAS Y LANZAS', 0, 1, NULL, NULL, NULL),
(21, 'MOTOR ELECTRICO', 0, 1, NULL, NULL, NULL),
(22, 'MOCHILA A BATERIA', 0, 1, NULL, NULL, NULL),
(23, 'PANEL SOLAR', 0, 1, NULL, NULL, NULL),
(24, 'MOTOCULTORES', 0, 1, NULL, NULL, NULL),
(25, 'ELECTROBOMBA', 0, 1, NULL, NULL, NULL),
(26, 'ULV', 0, 1, NULL, NULL, NULL),
(27, 'THERMONEBULIZADOR', 0, 1, NULL, NULL, NULL),
(28, 'PROTECTOR FACIAL', 0, 1, NULL, NULL, NULL),
(29, 'MACARA RESPIRADOR', 0, 1, NULL, NULL, NULL),
(30, 'GAFAS', 0, 1, NULL, NULL, NULL),
(31, 'PULVERIZADORES MANUALES', 0, 1, NULL, NULL, NULL),
(32, 'PUMP SPRAYER', 0, 1, NULL, NULL, NULL),
(33, 'POLIPASTO', 0, 1, NULL, NULL, NULL),
(34, 'MOTOAZADA', 0, 1, NULL, NULL, NULL),
(35, 'DESINFECTANTE', 0, 1, NULL, NULL, NULL),
(36, 'ASPIRADORA', 0, 1, NULL, NULL, NULL),
(37, 'AHOYADORAS', 0, 1, NULL, NULL, NULL),
(38, 'CARRITO PODADOR', 0, 1, NULL, NULL, NULL),
(39, 'AHOYADORA', 0, 1, NULL, NULL, NULL),
(40, 'ELECTROBOMBAS', 0, 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marca`
--

CREATE TABLE `marca` (
  `codigo_mar` int(11) NOT NULL,
  `nombre_mar` varchar(500) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `estado_mar` int(11) DEFAULT '1',
  `usuario_reg` int(11) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_mod` int(11) DEFAULT NULL,
  `fecha_mod` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `marca`
--

INSERT INTO `marca` (`codigo_mar`, `nombre_mar`, `estado_mar`, `usuario_reg`, `usuario_mod`, `fecha_mod`) VALUES
(1, 'HONDA', 1, NULL, NULL, NULL),
(2, 'CIFARELLI', 1, NULL, NULL, NULL),
(3, 'JACTO', 1, NULL, NULL, NULL),
(4, 'MITSUBISHI', 1, NULL, NULL, NULL),
(5, 'TURBOJET', 1, NULL, NULL, NULL),
(6, 'TECNICA', 1, NULL, NULL, NULL),
(7, 'TORNADO', 1, NULL, NULL, NULL),
(8, 'CERAMIC', 1, NULL, NULL, NULL),
(9, 'GUARANY', 1, NULL, NULL, NULL),
(10, 'STIHL', 1, NULL, NULL, NULL),
(11, 'HUSQWARNA', 1, NULL, NULL, NULL),
(12, 'PANTHERA', 1, NULL, NULL, NULL),
(13, 'PANTHER', 1, NULL, NULL, NULL),
(14, 'SHINDAIWA', 1, NULL, NULL, NULL),
(15, 'ECHO', 1, NULL, NULL, NULL),
(16, 'TECH-FLEX', 1, NULL, NULL, NULL),
(17, 'S/M', 1, NULL, NULL, NULL),
(18, 'SAN SAN', 1, NULL, NULL, NULL),
(19, 'MORI', 1, NULL, NULL, NULL),
(20, 'PANTERA', 1, NULL, NULL, NULL),
(21, 'EFCO', 1, NULL, NULL, NULL),
(22, 'MATABI', 1, NULL, NULL, NULL),
(23, 'MAGNOJET', 1, NULL, NULL, NULL),
(24, 'TEEJET', 1, NULL, NULL, NULL),
(25, 'AOSOME', 1, NULL, NULL, NULL),
(26, 'AGROVET', 1, NULL, NULL, NULL),
(27, 'KASO', 1, NULL, NULL, NULL),
(28, 'LECCO', 1, NULL, NULL, NULL),
(29, 'DEREK', 1, NULL, NULL, NULL),
(30, 'NGK', 1, NULL, NULL, NULL),
(31, 'SEPTYNI', 1, NULL, NULL, NULL),
(32, 'JETAGRO', 1, NULL, NULL, NULL),
(33, 'AGRO IMPACTO', 1, NULL, NULL, NULL),
(34, 'ITALFLEX', 1, NULL, NULL, NULL),
(35, 'JACTO DE BAYER', 1, NULL, NULL, NULL),
(36, 'SOLO', 1, NULL, NULL, NULL),
(37, 'TU26', 1, NULL, NULL, NULL),
(38, 'ZONSHENG', 1, NULL, NULL, NULL),
(39, 'WHALE', 1, NULL, NULL, NULL),
(40, 'KOYO', 1, NULL, NULL, NULL),
(41, 'BRIGGS & STRATON', 1, NULL, NULL, NULL),
(42, 'AQUAMAX', 1, NULL, NULL, NULL),
(43, 'WHITE LION', 1, NULL, NULL, NULL),
(44, 'ARGON', 1, NULL, NULL, NULL),
(45, 'WHLAE', 1, NULL, NULL, NULL),
(46, 'BIGDIN', 1, NULL, NULL, NULL),
(47, 'YIMBA', 1, NULL, NULL, NULL),
(48, 'SANWIN', 1, NULL, NULL, NULL),
(49, 'PRESICION', 1, NULL, NULL, NULL),
(50, 'GOODYEAR', 1, NULL, NULL, NULL),
(51, 'AQUA PUMP', 1, NULL, NULL, NULL),
(52, 'ATR', 1, NULL, NULL, NULL),
(53, 'SHELL', 1, NULL, NULL, NULL),
(54, 'RATO', 1, NULL, NULL, NULL),
(55, 'CONTINENTAL', 1, NULL, NULL, NULL),
(56, 'SPRAYER', 1, NULL, NULL, NULL),
(57, 'IMP', 1, NULL, NULL, NULL),
(58, 'VOLPI', 1, NULL, NULL, NULL),
(59, 'REXON', 1, NULL, NULL, NULL),
(60, 'TOYO', 1, NULL, NULL, NULL),
(61, 'SEVAX', 1, NULL, NULL, NULL),
(62, 'DESINFECTANTE', 1, NULL, NULL, NULL),
(63, 'BARI', 1, NULL, NULL, NULL),
(64, 'CARLTON', 1, NULL, NULL, NULL),
(65, 'BONELY', 1, NULL, NULL, NULL),
(66, 'ALBUZ', 1, NULL, NULL, NULL),
(67, 'MAKISHIMA', 1, NULL, NULL, NULL),
(68, 'MS GREEN', 1, NULL, NULL, NULL),
(69, 'WALBRO', 1, NULL, NULL, NULL),
(70, 'MAESBAR', 1, NULL, NULL, NULL),
(71, 'OSATU', 1, NULL, NULL, NULL),
(72, 'VELVAS', 1, NULL, NULL, NULL),
(73, 'VELKAS', 1, NULL, NULL, NULL),
(74, 'ASHMAR', 1, NULL, NULL, NULL),
(75, 'JOPCO', 1, NULL, NULL, NULL),
(76, 'CRAFTOP', 1, NULL, NULL, NULL),
(77, 'AMC', 1, NULL, NULL, NULL),
(78, 'MOTORKRAFT', 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `moneda`
--

CREATE TABLE `moneda` (
  `codigo_mon` int(11) NOT NULL,
  `nombre_mon` varchar(500) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `abreviatura_mon` varchar(5) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `estado_mon` int(11) DEFAULT '1',
  `usuario_reg` int(11) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_mod` int(11) DEFAULT NULL,
  `fecha_mod` timestamp NULL DEFAULT NULL,
  `sistema` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `moneda`
--

INSERT INTO `moneda` (`codigo_mon`, `nombre_mon`, `abreviatura_mon`, `estado_mon`, `usuario_reg`, `usuario_mod`, `fecha_mod`, `sistema`) VALUES
(1, 'SOLES', 'S', 1, 1, NULL, NULL, 0),
(2, 'DOLAR', 'D', 1, 1, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientocliente`
--

CREATE TABLE `movimientocliente` (
  `codigo_moc` int(11) NOT NULL,
  `codigo_suc` int(11) NOT NULL,
  `codigo_tdo` int(11) DEFAULT NULL,
  `serie_moc` varchar(4) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `numero_moc` varchar(7) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `codigo_cli` int(11) DEFAULT NULL,
  `tipo_moc` varchar(1) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `fecha_moc` date NOT NULL,
  `importe_moc` decimal(12,2) DEFAULT '0.00',
  `saldo_moc` decimal(12,2) DEFAULT '0.00',
  `fechaVencimiento_moc` date NOT NULL,
  `codigo_cta` int(11) DEFAULT NULL,
  `recibo_moc` varchar(10) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `codigo_mon` int(11) NOT NULL,
  `detalle_moc` varchar(1000) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `codigo_con` int(11) NOT NULL,
  `dolar_moc` decimal(10,4) DEFAULT '1.0000',
  `codigo_ven` int(11) NOT NULL DEFAULT '1',
  `codigo_szo` int(11) NOT NULL,
  `codigo_zon` int(11) NOT NULL,
  `codigoref_tdo` int(11) DEFAULT NULL,
  `serieref_moc` varchar(4) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `numeroref_moc` varchar(7) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `fecharef_moc` date NOT NULL,
  `referencia_moc` int(11) DEFAULT NULL,
  `estado_moc` int(11) DEFAULT '1',
  `usuario_reg` int(11) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_mod` int(11) DEFAULT NULL,
  `fecha_mod` timestamp NULL DEFAULT NULL,
  `sistema` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `movimientocliente`
--

INSERT INTO `movimientocliente` (`codigo_moc`, `codigo_suc`, `codigo_tdo`, `serie_moc`, `numero_moc`, `codigo_cli`, `tipo_moc`, `fecha_moc`, `importe_moc`, `saldo_moc`, `fechaVencimiento_moc`, `codigo_cta`, `recibo_moc`, `codigo_mon`, `detalle_moc`, `codigo_con`, `dolar_moc`, `codigo_ven`, `codigo_szo`, `codigo_zon`, `codigoref_tdo`, `serieref_moc`, `numeroref_moc`, `fecharef_moc`, `referencia_moc`, `estado_moc`, `usuario_reg`, `usuario_mod`, `fecha_mod`, `sistema`) VALUES
(24, 1, 7, '0001', '0000001', 3, 'C', '2024-07-04', '1000.00', '100.00', '2024-07-30', NULL, NULL, 1, 'CREDITO ANTERIOR', 1, '3.0000', 1, 1, 1, NULL, NULL, NULL, '0000-00-00', NULL, 1, 0, NULL, NULL, 0),
(25, 1, 7, '0001', '0000002', 2, 'C', '2024-07-04', '800.00', '50.00', '2024-10-04', NULL, NULL, 1, 'CREDITO ANTERIOR', 1, '3.0000', 1, 1, 1, NULL, NULL, NULL, '0000-00-00', NULL, 1, 0, NULL, NULL, 0),
(27, 1, 7, '0001', '0000001', 3, 'P', '2024-07-04', '30.00', '0.00', '2024-07-04', 1, '001-I00012', 1, '30', 5, '3.7000', 1, 1, 1, NULL, NULL, NULL, '0000-00-00', 24, 0, 0, 0, '2024-07-04 17:56:21', 0),
(28, 1, 7, '0001', '0000001', 3, 'P', '2024-07-04', '30.00', '0.00', '2024-07-04', 1, '001-I00013', 1, '30', 5, '3.7000', 1, 1, 1, NULL, NULL, NULL, '0000-00-00', 24, 0, 0, 0, '2024-07-04 17:56:24', 0),
(29, 1, 7, '0001', '0000001', 3, 'P', '2024-07-04', '25.00', '0.00', '2024-07-04', 1, '001-I00014', 1, '25', 5, '3.7000', 1, 1, 1, NULL, NULL, NULL, '0000-00-00', 24, 0, 0, 0, '2024-07-04 17:56:27', 0),
(30, 1, 7, '0001', '0000001', 3, 'P', '2024-07-04', '16.00', '0.00', '2024-07-04', 1, '001-I00015', 1, 'ACUENTA DE DEUDA 15 SOLES', 5, '3.7000', 1, 1, 1, NULL, NULL, NULL, '0000-00-00', 24, 0, 0, 0, '2024-07-04 17:57:15', 0),
(31, 1, 7, '0001', '0000002', 2, 'P', '2024-07-04', '300.00', '0.00', '2024-07-04', 1, '001-I00016', 1, 'ACUENTA DE DEUDA 300 SOLES', 5, '3.7000', 1, 1, 1, NULL, NULL, NULL, '0000-00-00', 25, 0, 0, 0, '2024-07-04 17:56:40', 0),
(32, 1, 7, '0001', '0000001', 3, 'P', '2024-07-04', '100.00', '0.00', '2024-07-04', 1, '001-I00017', 1, '0100', 5, '3.7000', 1, 1, 1, NULL, NULL, NULL, '0000-00-00', 24, 0, 0, 0, '2024-07-04 17:56:38', 0),
(33, 1, 7, '0001', '0000001', 3, 'P', '2024-07-04', '18.00', '0.00', '2024-07-04', 1, '001-I00018', 1, '18', 5, '3.7000', 1, 1, 1, NULL, NULL, NULL, '0000-00-00', 24, 0, 0, 0, '2024-07-04 17:56:43', 0),
(34, 1, 7, '0001', '0000001', 3, 'P', '2024-07-04', '19.00', '0.00', '2024-07-04', 1, '001-I00019', 1, '19', 5, '3.7000', 1, 1, 1, NULL, NULL, NULL, '0000-00-00', 24, 0, 0, 0, '2024-07-04 17:56:48', 0),
(35, 1, 7, '0001', '0000001', 3, 'P', '2024-07-04', '20.00', '0.00', '2024-07-04', 1, '001-I00020', 1, '20', 5, '3.7000', 1, 1, 1, NULL, NULL, NULL, '0000-00-00', 24, 0, 0, 0, '2024-07-04 17:57:18', 0),
(36, 1, 7, '0001', '0000001', 3, 'P', '2024-07-04', '3.00', '0.00', '2024-07-04', 1, '001-I00021', 1, '3 SOLES', 5, '3.7000', 1, 1, 1, NULL, NULL, NULL, '0000-00-00', 24, 0, 0, 0, '2024-07-04 17:56:46', 0),
(37, 1, 7, '0001', '0000001', 3, 'P', '2024-07-04', '22.00', '0.00', '2024-07-04', 1, '001-I00022', 1, 'RECIBO 22', 5, '3.7000', 1, 1, 1, NULL, NULL, NULL, '0000-00-00', 24, 0, 0, 0, '2024-07-04 17:57:21', 0),
(38, 1, 7, '0001', '0000001', 3, 'P', '2024-07-04', '23.00', '0.00', '2024-07-04', 1, '001-I00023', 1, 'RECIBO 23', 5, '3.7000', 1, 1, 1, NULL, NULL, NULL, '0000-00-00', 24, 0, 0, 0, '2024-07-04 17:57:24', 0),
(39, 1, 7, '0001', '0000001', 3, 'P', '2024-07-04', '5.00', '0.00', '2024-07-04', 1, '001-I00024', 1, '5 SOLES - RECIBO 24', 5, '3.7000', 1, 1, 1, NULL, NULL, NULL, '0000-00-00', 24, 0, 0, 0, '2024-07-04 17:56:35', 0),
(40, 1, 7, '0001', '0000001', 3, 'P', '2024-07-04', '600.00', '0.00', '2024-07-04', 1, '001-I00025', 1, 'ACUENTA DE DEUDA 600 SOLES', 5, '3.7000', 1, 1, 1, NULL, NULL, NULL, '0000-00-00', 24, 1, 0, NULL, NULL, 0),
(41, 1, 7, '0001', '0000002', 2, 'P', '2024-07-04', '750.00', '0.00', '2024-07-04', 1, '001-I00026', 1, 'ACUENTA DE DEUDA 750 SOLES', 5, '3.7000', 1, 1, 1, NULL, NULL, NULL, '0000-00-00', 25, 1, 0, NULL, NULL, 0),
(42, 1, 7, '0001', '0000001', 3, 'P', '2024-07-04', '300.00', '0.00', '2024-07-04', 1, '001-I00027', 1, 'ACUENTA DE DEUDA', 5, '3.7000', 1, 1, 1, NULL, NULL, NULL, '0000-00-00', 24, 1, 0, NULL, NULL, 0),
(43, 1, 7, '0001', '0000003', 3, 'C', '2024-07-04', '500.00', '500.00', '2024-07-04', NULL, NULL, 1, '500', 1, '3.0000', 1, 1, 1, NULL, NULL, NULL, '0000-00-00', NULL, 0, 0, 0, '2024-07-04 18:44:13', 0),
(44, 1, 7, '0001', '0000001', 3, 'P', '2024-07-04', '0.00', '0.00', '2024-07-04', 1, '001-I00028', 1, '', 5, '3.7000', 1, 1, 1, NULL, NULL, NULL, '0000-00-00', 24, 0, 0, 0, '2024-07-04 18:55:18', 0),
(45, 1, NULL, NULL, NULL, NULL, 'P', '2024-07-03', '50000.00', '50000.00', '2024-07-03', 1, '001-I00029', 1, 'SALDO INICIAL', 15, '3.0000', 1, 1, 1, NULL, NULL, NULL, '0000-00-00', NULL, 1, 0, NULL, NULL, 0),
(48, 1, NULL, NULL, NULL, NULL, 'C', '2024-07-03', '10000.00', '10000.00', '2024-07-03', 1, 'TRN-000012', 1, 'EFECTIVO', 4, '3.0000', 1, 1, 1, NULL, NULL, NULL, '0000-00-00', NULL, 1, 0, NULL, NULL, 0),
(49, 2, NULL, NULL, NULL, NULL, 'P', '2024-07-03', '10000.00', '10000.00', '2024-07-03', 8, 'TRN-000012', 1, 'EFECTIVO', 4, '3.0000', 1, 1, 1, NULL, NULL, NULL, '0000-00-00', NULL, 1, 0, NULL, NULL, 0),
(50, 1, NULL, NULL, NULL, NULL, 'C', '2024-07-06', '5000.00', '5000.00', '2024-07-06', 1, 'TRN-000013', 1, 'EFE', 4, '3.0000', 1, 1, 1, NULL, NULL, NULL, '0000-00-00', NULL, 1, 0, NULL, NULL, 0),
(51, 2, NULL, NULL, NULL, NULL, 'P', '2024-07-06', '5000.00', '5000.00', '2024-07-06', 8, 'TRN-000013', 1, 'EFE', 4, '3.0000', 1, 1, 1, NULL, NULL, NULL, '0000-00-00', NULL, 1, 0, NULL, NULL, 0),
(52, 1, NULL, NULL, NULL, NULL, 'C', '2024-07-06', '3500.00', '3500.00', '2024-07-06', 1, 'TRN-000014', 1, 'EFEC. 6-LUKAS', 4, '3.0000', 1, 1, 1, NULL, NULL, NULL, '0000-00-00', NULL, 1, 0, 0, NULL, 0),
(53, 2, NULL, NULL, NULL, NULL, 'P', '2024-07-06', '3500.00', '3500.00', '2024-07-06', 8, 'TRN-000014', 1, 'EFEC. 6-LUKAS', 4, '3.0000', 1, 1, 1, NULL, NULL, NULL, '0000-00-00', 52, 1, 0, 0, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientoproveedor`
--

CREATE TABLE `movimientoproveedor` (
  `codigo_mop` bigint(20) NOT NULL,
  `codigo_suc` int(11) NOT NULL,
  `codigo_tdo` int(11) DEFAULT NULL,
  `serie_mop` varchar(4) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `numero_mop` varchar(7) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `codigo_pro` int(11) NOT NULL,
  `tipo_mop` varchar(1) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `fecha_mop` date NOT NULL,
  `importe_mop` decimal(12,2) DEFAULT '0.00',
  `saldo_mop` decimal(12,2) DEFAULT '0.00',
  `fechaVencimiento_mop` date NOT NULL,
  `codigo_cta` int(11) DEFAULT NULL,
  `recibo_mop` varchar(10) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `codigo_mon` int(11) NOT NULL,
  `detalle_mop` varchar(1000) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `codigo_con` int(11) NOT NULL,
  `dolar_mop` decimal(10,4) DEFAULT '1.0000',
  `codigo_ven` int(11) DEFAULT '1',
  `impuesto_mop` decimal(10,4) DEFAULT '0.0000',
  `codigoref_tdo` int(11) DEFAULT NULL,
  `serieref_mop` varchar(4) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `numeroref_mop` varchar(7) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `fecharef_mop` date NOT NULL,
  `referencia_mop` int(11) DEFAULT NULL,
  `estado_mop` int(11) DEFAULT '1',
  `usuario_reg` int(11) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_mod` int(11) DEFAULT NULL,
  `fecha_mod` timestamp NULL DEFAULT NULL,
  `sistema` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proforma`
--

CREATE TABLE `proforma` (
  `codigo_pfm` int(11) NOT NULL,
  `codigo_suc` int(11) NOT NULL,
  `fecha_pfm` date DEFAULT NULL,
  `codigo_cli` int(11) NOT NULL,
  `detalle_pfm` varchar(1000) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `total_pfm` decimal(12,2) DEFAULT '0.00',
  `estado_pfm` int(11) DEFAULT '1',
  `usuario_reg` int(11) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_mod` int(11) DEFAULT NULL,
  `fecha_mod` timestamp NULL DEFAULT NULL,
  `sistema` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proforma_detalle`
--

CREATE TABLE `proforma_detalle` (
  `codigo_dpf` int(11) NOT NULL,
  `codigo_art` int(11) NOT NULL,
  `item_dpf` int(11) DEFAULT NULL,
  `cantidad_dpf` decimal(12,2) DEFAULT '0.00',
  `precio_dpf` decimal(12,2) DEFAULT '0.00',
  `descuento_dpf` decimal(12,2) DEFAULT '0.00',
  `importe_dpf` decimal(12,2) DEFAULT '0.00',
  `codigo_pfm` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `codigo_pro` int(11) NOT NULL,
  `nombre_pro` varchar(500) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `direccion_pro` varchar(500) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `ciudad_pro` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `telefono_pro` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `codigo_tip` int(11) DEFAULT NULL,
  `codigo_doc` int(11) DEFAULT NULL,
  `numero_doc` varchar(20) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `observacion_pro` varchar(500) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `estado_pro` int(11) DEFAULT '1',
  `usuario_reg` int(11) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_mod` int(11) DEFAULT NULL,
  `fecha_mod` timestamp NULL DEFAULT NULL,
  `sistema` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`codigo_pro`, `nombre_pro`, `direccion_pro`, `ciudad_pro`, `telefono_pro`, `codigo_tip`, `codigo_doc`, `numero_doc`, `observacion_pro`, `estado_pro`, `usuario_reg`, `usuario_mod`, `fecha_mod`, `sistema`) VALUES
(1, 'ITAL IMPORT DE MAQUINARIAS', '', '', '', 2, 2, '20304584948', '', 1, NULL, NULL, NULL, 0),
(2, 'VIDAGRO', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(3, 'HONDA DEL PERU SAC', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(4, 'EDIPESA', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(5, 'M&N MANGUERAS HIDRAULICAS E INDUSTRIALES SAC', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(6, 'DAVALOS IMPORTS SA', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(7, 'OTROS', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(8, 'DERTEANO STUCKER', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(9, 'AFA GROUP', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(10, 'POWER ACOUTICK', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(11, 'FARMAGRO', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(12, 'FUSITE', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(13, 'PRODUCNTOS INDUSTRIALES', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(14, 'OPERACIONES TAWANTINSUYO EIRL', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(15, 'RODAMIENTOS REPUESTOS Y SERVICIOS LEGUIA', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(16, 'MAQUINARIA AGRICOLA SHANGAI', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(17, 'IMAN', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(18, 'AGROFORESTAL NIETO EIRL', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(19, 'JUROMI', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(20, 'WHITE LION', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(21, 'SOLO DELPERI', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(22, 'AGROMAXX & TOOLS EIRL', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(23, 'NEGOCIOS RIM EIRL', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(24, 'GLOBAL CORPORATION', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(25, 'RODA NORTE SA', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(26, 'VIALSA', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(27, 'INKA', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(28, 'CORPORACION ANDINA DE NEGOCIOS EIRL', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(29, 'INVERSIONES E IMPORTACIONES EIRL', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(30, 'GRACIELA IMPRT SAC', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(31, 'GRACE', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(32, 'STHIL ANDREAS PERU', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(33, 'RIOJA', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(34, 'GOODYEAR', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(35, 'DINZA', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(36, 'CASA DEL PERNO', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(37, 'GRACIELA IMPORT', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(38, 'PILARES', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(39, 'SEMPARCO', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(40, 'MARKET AGRICOLA PERU SAC', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(41, 'NAYLAPMP SRL', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(42, 'IMPORTACION', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(43, 'CAMPOS', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(44, 'DELCOMPERU', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(45, 'XIOMARA', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(46, 'GOOYEAR', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(47, 'COMERCIAL DISTRIBUIDORA CHICLAYO', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(48, 'MACONSA', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(49, 'RODASUR', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(50, 'ACETORK', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(51, 'FERRETERIA SAC', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(52, 'BATERIA DEL NORTE', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(53, 'AGROFOREST', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(54, 'CASA DE SERVICIOS MULTIPLES', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(55, 'TECNOAGRO', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(56, 'MECHANICAL', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(57, 'JUANCATA', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(58, 'VIDELNORTE EIRL', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(59, 'MAESTRO', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(60, 'DELGADO', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(61, 'HCB IMPORT SAC', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(62, 'HAROLD SAC', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(63, 'SODIMAC', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(64, 'PERU IMPORT SAC', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(65, 'COMERCIAL Y DISTRIBUIDORA CHICLAYO', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(66, 'SEÑOR DE LUREN', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(67, 'FIVCO', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(68, 'DCMAERONS', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(69, 'VILLALTA', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(70, 'AGROFORESTALES DEL NORTE', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(71, 'PICETTI', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(72, 'VETERINARIA MANUEL PARDO', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(73, 'SARITA COLONIA', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(74, 'INDUSTRIAS ARIAS', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(75, 'WASAFER', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(76, 'LA CASA DEL REPUESTO AUTOMOTRIZ', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(77, 'COMERCIAL DE PLASTICOS FAVIOLA', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(78, 'VISTONY', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(79, 'MAESBAR', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(80, 'EMERPLAST', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(81, 'EUROFLEX PERU SAC', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(82, 'SILVA CABANILLAS JOSE DANIEL', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(83, 'ENZOMAQ PERU EIRL', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(84, 'HORTUS', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(85, 'UNIVERIM EIRL', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(86, 'MEGABAT', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(87, 'KATERINE JUNO', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(88, 'HERRERA', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(89, 'DINAM', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(90, 'CORPORACION NORTH PLAST', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(91, 'HUEMURA', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(92, 'JOSPAC', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(93, 'JEDAMA', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(94, 'SEMPROTEC', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(95, 'GRUPO MAESBAR', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(96, 'AGROMOTORS', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(97, 'COREA TRAIDING', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(98, 'VIDRIOS Y ALUMINIOS', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(99, 'SADAN', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(100, 'AMSA MOTOR', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(101, 'MAKIN GROUP EIRL', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(102, 'IMPORTACIONES VASQUEZ', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(103, 'DISAGRO EIRL', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(104, 'CASTILLO', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(105, 'CRAFTOP', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(106, 'IMPORTACIONES SUR', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0),
(107, 'TU SEMILLA', '', '', '', 2, 3, '', '', 1, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `provincia`
--

CREATE TABLE `provincia` (
  `codigo_pro` int(11) NOT NULL,
  `nombre_pro` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `codigo_dep` int(11) NOT NULL,
  `estado_pro` int(11) DEFAULT '1',
  `usuario_reg` int(11) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_mod` int(11) DEFAULT NULL,
  `fecha_mod` timestamp NULL DEFAULT NULL,
  `sistema` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `provincia`
--

INSERT INTO `provincia` (`codigo_pro`, `nombre_pro`, `codigo_dep`, `estado_pro`, `usuario_reg`, `usuario_mod`, `fecha_mod`, `sistema`) VALUES
(101, 'CHACHAPOYAS', 1, 1, NULL, NULL, NULL, 0),
(102, 'BAGUA', 1, 1, NULL, NULL, NULL, 0),
(103, 'BONGARA', 1, 1, NULL, NULL, NULL, 0),
(104, 'LUYA', 1, 1, NULL, NULL, NULL, 0),
(105, 'RODRIGUEZ DE MENDOZA', 1, 1, NULL, NULL, NULL, 0),
(106, 'CONDORCANQUI', 1, 1, NULL, NULL, NULL, 0),
(107, 'UTCUBAMBA', 1, 1, NULL, NULL, NULL, 0),
(201, 'HUARAZ', 2, 1, NULL, NULL, NULL, 0),
(202, 'AIJA', 2, 1, NULL, NULL, NULL, 0),
(203, 'BOLOGNESI', 2, 1, NULL, NULL, NULL, 0),
(204, 'CARHUAZ', 2, 1, NULL, NULL, NULL, 0),
(205, 'CASMA', 2, 1, NULL, NULL, NULL, 0),
(206, 'CORONGO', 2, 1, NULL, NULL, NULL, 0),
(207, 'HUAYLAS', 2, 1, NULL, NULL, NULL, 0),
(208, 'HUARI', 2, 1, NULL, NULL, NULL, 0),
(209, 'MARISCAL LUZURIAGA', 2, 1, NULL, NULL, NULL, 0),
(210, 'PALLASCA', 2, 1, NULL, NULL, NULL, 0),
(211, 'POMABAMBA', 2, 1, NULL, NULL, NULL, 0),
(212, 'RECUAY', 2, 1, NULL, NULL, NULL, 0),
(213, 'SANTA', 2, 1, NULL, NULL, NULL, 0),
(214, 'SIHUAS', 2, 1, NULL, NULL, NULL, 0),
(215, 'YUNGAY', 2, 1, NULL, NULL, NULL, 0),
(216, 'ANTONIO RAIMONDI', 2, 1, NULL, NULL, NULL, 0),
(217, 'CARLOS FERMIN FITZCARRALD', 2, 1, NULL, NULL, NULL, 0),
(218, 'ASUNCION', 2, 1, NULL, NULL, NULL, 0),
(219, 'HUARMEY', 2, 1, NULL, NULL, NULL, 0),
(220, 'OCROS', 2, 1, NULL, NULL, NULL, 0),
(301, 'ABANCAY', 3, 1, NULL, NULL, NULL, 0),
(302, 'AYMARAES', 3, 1, NULL, NULL, NULL, 0),
(303, 'ANDAHUAYLAS', 3, 1, NULL, NULL, NULL, 0),
(304, 'ANTABAMBA', 3, 1, NULL, NULL, NULL, 0),
(305, 'COTABAMBAS', 3, 1, NULL, NULL, NULL, 0),
(306, 'GRAU', 3, 1, NULL, NULL, NULL, 0),
(307, 'CHINCHEROS', 3, 1, NULL, NULL, NULL, 0),
(401, 'AREQUIPA', 4, 1, NULL, NULL, NULL, 0),
(402, 'CAYLLOMA', 4, 1, NULL, NULL, NULL, 0),
(403, 'CAMANA', 4, 1, NULL, NULL, NULL, 0),
(404, 'CARAVELI', 4, 1, NULL, NULL, NULL, 0),
(405, 'CASTILLA', 4, 1, NULL, NULL, NULL, 0),
(406, 'CONDESUYOS', 4, 1, NULL, NULL, NULL, 0),
(407, 'ISLAY', 4, 1, NULL, NULL, NULL, 0),
(408, 'LA UNION', 4, 1, NULL, NULL, NULL, 0),
(501, 'HUAMANGA', 5, 1, NULL, NULL, NULL, 0),
(502, 'CANGALLO', 5, 1, NULL, NULL, NULL, 0),
(503, 'HUANTA', 5, 1, NULL, NULL, NULL, 0),
(504, 'LA MAR', 5, 1, NULL, NULL, NULL, 0),
(505, 'LUCANAS', 5, 1, NULL, NULL, NULL, 0),
(506, 'PARINACOCHAS', 5, 1, NULL, NULL, NULL, 0),
(507, 'VICTOR FAJARDO', 5, 1, NULL, NULL, NULL, 0),
(508, 'HUANCA SANCOS', 5, 1, NULL, NULL, NULL, 0),
(509, 'VILCAS HUAMAN', 5, 1, NULL, NULL, NULL, 0),
(510, 'PAUCAR DEL SARA SARA', 5, 1, NULL, NULL, NULL, 0),
(511, 'SUCRE', 5, 1, NULL, NULL, NULL, 0),
(601, 'CAJAMARCA', 6, 1, NULL, NULL, NULL, 0),
(602, 'CAJABAMBA', 6, 1, NULL, NULL, NULL, 0),
(603, 'CELENDIN', 6, 1, NULL, NULL, NULL, 0),
(604, 'CONTUMAZA', 6, 1, NULL, NULL, NULL, 0),
(605, 'CUTERVO', 6, 1, NULL, NULL, NULL, 0),
(606, 'CHOTA', 6, 1, NULL, NULL, NULL, 0),
(607, 'HUALGAYOC', 6, 1, NULL, NULL, NULL, 0),
(608, 'JAEN', 6, 1, NULL, NULL, NULL, 0),
(609, 'SANTA CRUZ', 6, 1, NULL, NULL, NULL, 0),
(610, 'SAN MIGUEL', 6, 1, NULL, NULL, NULL, 0),
(611, 'SAN IGNACIO', 6, 1, NULL, NULL, NULL, 0),
(612, 'SAN MARCOS', 6, 1, NULL, NULL, NULL, 0),
(613, 'SAN PABLO', 6, 1, NULL, NULL, NULL, 0),
(701, 'CUSCO', 7, 1, NULL, NULL, NULL, 0),
(702, 'ACOMAYO', 7, 1, NULL, NULL, NULL, 0),
(703, 'ANTA', 7, 1, NULL, NULL, NULL, 0),
(704, 'CALCA', 7, 1, NULL, NULL, NULL, 0),
(705, 'CANAS', 7, 1, NULL, NULL, NULL, 0),
(706, 'CANCHIS', 7, 1, NULL, NULL, NULL, 0),
(707, 'CHUMBIVILCAS', 7, 1, NULL, NULL, NULL, 0),
(708, 'ESPINAR', 7, 1, NULL, NULL, NULL, 0),
(709, 'LA CONVENCION', 7, 1, NULL, NULL, NULL, 0),
(710, 'PARURO', 7, 1, NULL, NULL, NULL, 0),
(711, 'PAUCARTAMBO', 7, 1, NULL, NULL, NULL, 0),
(712, 'QUISPICANCHIS', 7, 1, NULL, NULL, NULL, 0),
(713, 'URUBAMBA', 7, 1, NULL, NULL, NULL, 0),
(801, 'HUANCAVELICA', 8, 1, NULL, NULL, NULL, 0),
(802, 'ACOBAMBA', 8, 1, NULL, NULL, NULL, 0),
(803, 'ANGARAES', 8, 1, NULL, NULL, NULL, 0),
(804, 'CASTROVIRREYNA', 8, 1, NULL, NULL, NULL, 0),
(805, 'TAYACAJA', 8, 1, NULL, NULL, NULL, 0),
(806, 'HUAYTARA', 8, 1, NULL, NULL, NULL, 0),
(807, 'CHURCAMPA', 8, 1, NULL, NULL, NULL, 0),
(901, 'HUANUCO', 9, 1, NULL, NULL, NULL, 0),
(902, 'AMBO', 9, 1, NULL, NULL, NULL, 0),
(903, 'DOS DE MAYO', 9, 1, NULL, NULL, NULL, 0),
(904, 'HUAMALIES', 9, 1, NULL, NULL, NULL, 0),
(905, 'MARANON', 9, 1, NULL, NULL, NULL, 0),
(906, 'LEONCIO PRADO', 9, 1, NULL, NULL, NULL, 0),
(907, 'PACHITEA', 9, 1, NULL, NULL, NULL, 0),
(908, 'PUERTO INCA', 9, 1, NULL, NULL, NULL, 0),
(909, 'HUACAYBAMBA', 9, 1, NULL, NULL, NULL, 0),
(910, 'LAURICOCHA', 9, 1, NULL, NULL, NULL, 0),
(911, 'YAROWILCA', 9, 1, NULL, NULL, NULL, 0),
(1001, 'ICA', 10, 1, NULL, NULL, NULL, 0),
(1002, 'CHINCHA', 10, 1, NULL, NULL, NULL, 0),
(1003, 'NAZCA', 10, 1, NULL, NULL, NULL, 0),
(1004, 'PISCO', 10, 1, NULL, NULL, NULL, 0),
(1005, 'PALPA', 10, 1, NULL, NULL, NULL, 0),
(1101, 'HUANCAYO', 11, 1, NULL, NULL, NULL, 0),
(1102, 'CONCEPCION', 11, 1, NULL, NULL, NULL, 0),
(1103, 'JAUJA', 11, 1, NULL, NULL, NULL, 0),
(1104, 'JUNIN', 11, 1, NULL, NULL, NULL, 0),
(1105, 'TARMA', 11, 1, NULL, NULL, NULL, 0),
(1106, 'YAULI', 11, 1, NULL, NULL, NULL, 0),
(1107, 'SATIPO', 11, 1, NULL, NULL, NULL, 0),
(1108, 'CHANCHAMAYO', 11, 1, NULL, NULL, NULL, 0),
(1109, 'CHUPACA', 11, 1, NULL, NULL, NULL, 0),
(1201, 'TRUJILLO', 12, 1, NULL, NULL, NULL, 0),
(1202, 'BOLIVAR', 12, 1, NULL, NULL, NULL, 0),
(1203, 'SANCHEZ CARRION', 12, 1, NULL, NULL, NULL, 0),
(1204, 'OTUZCO', 12, 1, NULL, NULL, NULL, 0),
(1205, 'PACASMAYO', 12, 1, NULL, NULL, NULL, 0),
(1206, 'PATAZ', 12, 1, NULL, NULL, NULL, 0),
(1207, 'SANTIAGO DE CHUCO', 12, 1, NULL, NULL, NULL, 0),
(1208, 'ASCOPE', 12, 1, NULL, NULL, NULL, 0),
(1209, 'CHEPEN', 12, 1, NULL, NULL, NULL, 0),
(1210, 'JULCAN', 12, 1, NULL, NULL, NULL, 0),
(1211, 'GRAN CHIMU', 12, 1, NULL, NULL, NULL, 0),
(1212, 'VIRU', 12, 1, NULL, NULL, NULL, 0),
(1301, 'CHICLAYO', 13, 1, NULL, NULL, NULL, 0),
(1302, 'FERRENAFE', 13, 1, NULL, NULL, NULL, 0),
(1303, 'LAMBAYEQUE', 13, 1, NULL, NULL, NULL, 0),
(1401, 'LIMA', 14, 1, NULL, NULL, NULL, 0),
(1402, 'CAJATAMBO', 14, 1, NULL, NULL, NULL, 0),
(1403, 'CANTA', 14, 1, NULL, NULL, NULL, 0),
(1404, 'CANETE', 14, 1, NULL, NULL, NULL, 0),
(1405, 'HUAURA', 14, 1, NULL, NULL, NULL, 0),
(1406, 'HUAROCHIRI', 14, 1, NULL, NULL, NULL, 0),
(1407, 'YAUYOS', 14, 1, NULL, NULL, NULL, 0),
(1408, 'HUARAL', 14, 1, NULL, NULL, NULL, 0),
(1409, 'BARRANCA', 14, 1, NULL, NULL, NULL, 0),
(1410, 'OYON', 14, 1, NULL, NULL, NULL, 0),
(1501, 'MAYNAS', 15, 1, NULL, NULL, NULL, 0),
(1502, 'ALTO AMAZONAS', 15, 1, NULL, NULL, NULL, 0),
(1503, 'LORETO', 15, 1, NULL, NULL, NULL, 0),
(1504, 'REQUENA', 15, 1, NULL, NULL, NULL, 0),
(1505, 'UCAYALI', 15, 1, NULL, NULL, NULL, 0),
(1506, 'MARISCAL RAMON CASTILLA', 15, 1, NULL, NULL, NULL, 0),
(1507, 'DATEM DEL MARAÑON', 15, 1, NULL, NULL, NULL, 0),
(1601, 'TAMBOPATA', 16, 1, NULL, NULL, NULL, 0),
(1602, 'MANU', 16, 1, NULL, NULL, NULL, 0),
(1603, 'TAHUAMANU', 16, 1, NULL, NULL, NULL, 0),
(1701, 'MARISCAL NIETO', 17, 1, NULL, NULL, NULL, 0),
(1702, 'GENERAL SANCHEZ CERRO', 17, 1, NULL, NULL, NULL, 0),
(1703, 'ILO', 17, 1, NULL, NULL, NULL, 0),
(1801, 'PASCO', 18, 1, NULL, NULL, NULL, 0),
(1802, 'DANIEL ALCIDES CARRION', 18, 1, NULL, NULL, NULL, 0),
(1803, 'OXAPAMPA', 18, 1, NULL, NULL, NULL, 0),
(1901, 'PIURA', 19, 1, NULL, NULL, NULL, 0),
(1902, 'AYABACA', 19, 1, NULL, NULL, NULL, 0),
(1903, 'HUANCABAMBA', 19, 1, NULL, NULL, NULL, 0),
(1904, 'MORROPON', 19, 1, NULL, NULL, NULL, 0),
(1905, 'PAITA', 19, 1, NULL, NULL, NULL, 0),
(1906, 'SULLANA', 19, 1, NULL, NULL, NULL, 0),
(1907, 'TALARA', 19, 1, NULL, NULL, NULL, 0),
(1908, 'SECHURA', 19, 1, NULL, NULL, NULL, 0),
(2001, 'PUNO', 20, 1, NULL, NULL, NULL, 0),
(2002, 'AZANGARO', 20, 1, NULL, NULL, NULL, 0),
(2003, 'CARABAYA', 20, 1, NULL, NULL, NULL, 0),
(2004, 'CHUCUITO', 20, 1, NULL, NULL, NULL, 0),
(2005, 'HUANCANE', 20, 1, NULL, NULL, NULL, 0),
(2006, 'LAMPA', 20, 1, NULL, NULL, NULL, 0),
(2007, 'MELGAR', 20, 1, NULL, NULL, NULL, 0),
(2008, 'SANDIA', 20, 1, NULL, NULL, NULL, 0),
(2009, 'SAN ROMAN', 20, 1, NULL, NULL, NULL, 0),
(2010, 'YUNGUYO', 20, 1, NULL, NULL, NULL, 0),
(2011, 'SAN ANTONIO DE PUTINA', 20, 1, NULL, NULL, NULL, 0),
(2012, 'EL COLLAO', 20, 1, NULL, NULL, NULL, 0),
(2013, 'MOHO', 20, 1, NULL, NULL, NULL, 0),
(2101, 'MOYOBAMBA', 21, 1, NULL, NULL, NULL, 0),
(2102, 'HUALLAGA', 21, 1, NULL, NULL, NULL, 0),
(2103, 'LAMAS', 21, 1, NULL, NULL, NULL, 0),
(2104, 'MARISCAL CACERES', 21, 1, NULL, NULL, NULL, 0),
(2105, 'RIOJA', 21, 1, NULL, NULL, NULL, 0),
(2106, 'SAN MARTIN', 21, 1, NULL, NULL, NULL, 0),
(2107, 'BELLAVISTA', 21, 1, NULL, NULL, NULL, 0),
(2108, 'TOCACHE', 21, 1, NULL, NULL, NULL, 0),
(2109, 'PICOTA', 21, 1, NULL, NULL, NULL, 0),
(2110, 'EL DORADO', 21, 1, NULL, NULL, NULL, 0),
(2201, 'TACNA', 22, 1, NULL, NULL, NULL, 0),
(2202, 'TARATA', 22, 1, NULL, NULL, NULL, 0),
(2203, 'JORGE BASADRE', 22, 1, NULL, NULL, NULL, 0),
(2204, 'CANDARAVE', 22, 1, NULL, NULL, NULL, 0),
(2301, 'TUMBES', 23, 1, NULL, NULL, NULL, 0),
(2302, 'CONTRALMIRANTE VILLAR', 23, 1, NULL, NULL, NULL, 0),
(2303, 'ZARUMILLA', 23, 1, NULL, NULL, NULL, 0),
(2401, 'CALLAO', 24, 1, NULL, NULL, NULL, 0),
(2501, 'CORONEL PORTILLO', 25, 1, NULL, NULL, NULL, 0),
(2502, 'PADRE ABAD', 25, 1, NULL, NULL, NULL, 0),
(2503, 'ATALAYA', 25, 1, NULL, NULL, NULL, 0),
(2504, 'PURUS', 25, 1, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seriedocumento`
--

CREATE TABLE `seriedocumento` (
  `codigo_ser` int(11) NOT NULL,
  `codigo_tdo` int(11) DEFAULT NULL,
  `serie_ser` varchar(4) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `numero_ser` int(11) DEFAULT NULL,
  `codigo_suc` int(11) NOT NULL,
  `estado_ser` int(11) DEFAULT '1',
  `usuario_reg` int(11) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_mod` int(11) DEFAULT NULL,
  `fecha_mod` timestamp NULL DEFAULT NULL,
  `sistema` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `seriedocumento`
--

INSERT INTO `seriedocumento` (`codigo_ser`, `codigo_tdo`, `serie_ser`, `numero_ser`, `codigo_suc`, `estado_ser`, `usuario_reg`, `usuario_mod`, `fecha_mod`, `sistema`) VALUES
(1, 1, '1', 2, 1, 0, 0, 0, '2024-06-18 03:19:45', 0),
(2, 1, '1', 14, 1, 1, 0, NULL, NULL, 0),
(3, 8, '1', 1, 1, 1, 0, NULL, NULL, 0),
(4, 1, '1', 8, 3, 1, 0, NULL, NULL, 0),
(5, 1, '1', 8, 2, 1, 0, NULL, NULL, 0),
(6, 2, '1', 0, 1, 0, 0, 0, '2024-06-26 04:19:37', 0),
(7, 2, '1', 0, 1, 0, 0, 0, '2024-06-26 04:19:39', 0),
(8, 7, '1', 0, 1, 0, 0, 0, '2024-06-26 04:19:30', 0),
(9, 5, '1', 0, 1, 0, 0, 0, '2024-06-26 04:19:51', 0),
(10, 2, '1', 0, 1, 0, 0, 0, '2024-06-26 04:19:42', 0),
(11, 2, '1', 0, 1, 0, 0, 0, '2024-06-26 04:19:45', 0),
(12, 2, '1', 0, 1, 0, 0, 0, '2024-06-26 04:19:47', 0),
(13, 7, '5', 5, 1, 1, 0, NULL, NULL, 0),
(14, 5, '1', 0, 1, 1, 0, NULL, NULL, 0),
(15, 6, '1', 0, 1, 0, 0, 0, '2024-06-26 04:19:54', 0),
(16, 6, '2', 0, 1, 1, 0, NULL, NULL, 0),
(17, 6, '3', 0, 1, 0, 0, 0, '2024-06-26 04:19:26', 0),
(18, 5, '2', 0, 1, 1, 0, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `stock_sucursal`
--

CREATE TABLE `stock_sucursal` (
  `codigo_stk` int(11) NOT NULL,
  `codigo_art` int(11) NOT NULL,
  `codigo_suc` int(11) NOT NULL,
  `stock` decimal(12,2) DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `subzona`
--

CREATE TABLE `subzona` (
  `codigo_szo` int(11) NOT NULL,
  `nombre_szo` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `codigo_zon` int(11) NOT NULL,
  `estado_szo` int(11) DEFAULT '1',
  `usuario_reg` int(11) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_mod` int(11) DEFAULT NULL,
  `fecha_mod` timestamp NULL DEFAULT NULL,
  `sistema` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `subzona`
--

INSERT INTO `subzona` (`codigo_szo`, `nombre_szo`, `codigo_zon`, `estado_szo`, `usuario_reg`, `usuario_mod`, `fecha_mod`, `sistema`) VALUES
(1, 'CHICLAYO', 1, 1, NULL, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sucursal`
--

CREATE TABLE `sucursal` (
  `codigo_suc` int(11) NOT NULL,
  `nombre_suc` varchar(500) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `direccion_suc` varchar(500) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `estado_suc` int(11) DEFAULT '1',
  `usuario_reg` int(11) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_mod` int(11) DEFAULT NULL,
  `fecha_mod` timestamp NULL DEFAULT NULL,
  `sistema` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `sucursal`
--

INSERT INTO `sucursal` (`codigo_suc`, `nombre_suc`, `direccion_suc`, `estado_suc`, `usuario_reg`, `usuario_mod`, `fecha_mod`, `sistema`) VALUES
(1, ' LOCAL PRINCIPAL', 'AV. LUIS GONZALES NRO. 1456 CERCADO', 1, 0, 0, '2024-07-07 16:56:34', 0),
(2, 'LOCAL ARICA', 'AV. ARICA NRO. 549 URB. EL PORVENIR', 1, 0, 0, '2024-07-07 16:56:55', 0),
(3, 'LOCAL AMERICAS', 'CAL.AMERICA NRO. 345 URB. SAN CARLOS', 1, 0, 0, '2024-07-07 16:57:10', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipocambio`
--

CREATE TABLE `tipocambio` (
  `codigo_tic` int(11) NOT NULL,
  `fecha_tic` date NOT NULL,
  `cambioCompra_tic` decimal(12,4) DEFAULT '0.0000',
  `cambioVenta_tic` decimal(12,4) DEFAULT '0.0000',
  `estado_tic` int(11) DEFAULT '1',
  `usuario_reg` int(11) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_mod` int(11) DEFAULT NULL,
  `fecha_mod` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tipocambio`
--

INSERT INTO `tipocambio` (`codigo_tic`, `fecha_tic`, `cambioCompra_tic`, `cambioVenta_tic`, `estado_tic`, `usuario_reg`, `usuario_mod`, `fecha_mod`) VALUES
(1, '2024-06-01', '3.5000', '3.6000', 1, 0, NULL, NULL),
(2, '2024-06-02', '3.6410', '3.6420', 1, 0, NULL, NULL),
(3, '2024-06-03', '3.6000', '3.7000', 1, 0, NULL, NULL),
(4, '2024-06-04', '3.6000', '3.7654', 1, 0, NULL, NULL),
(5, '2024-06-04', '0.0000', '0.0000', 0, 0, 0, '2024-06-29 12:53:52'),
(6, '2024-06-06', '0.0000', '0.0000', 0, 0, 0, '2024-06-29 12:53:56'),
(7, '2024-06-07', '4.0000', '5.0000', 1, 0, NULL, NULL),
(8, '2024-06-05', '3.5000', '3.6000', 1, 0, NULL, NULL),
(9, '2024-06-06', '3.6000', '3.8000', 1, 0, NULL, NULL),
(10, '2024-06-08', '3.6500', '3.6720', 1, 0, NULL, NULL),
(11, '2024-07-03', '3.6000', '3.7000', 1, 0, NULL, NULL),
(12, '2024-07-01', '3.6000', '3.7000', 1, 0, NULL, NULL),
(13, '2024-07-02', '3.6000', '3.7000', 1, 0, NULL, NULL),
(14, '2024-07-04', '3.6000', '3.7000', 1, 0, NULL, NULL),
(15, '2024-07-05', '3.6000', '3.7000', 1, 0, 0, '2024-07-05 14:08:39'),
(16, '2024-07-06', '3.7880', '3.7970', 1, 0, NULL, NULL),
(17, '2024-07-07', '3.7880', '3.7970', 1, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipodocumento`
--

CREATE TABLE `tipodocumento` (
  `codigo_tdo` int(11) NOT NULL,
  `nombre_tdo` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `abreviatura_tdo` varchar(5) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `codigosunat_tdo` varchar(5) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `tipo_tdo` varchar(10) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `contable_tdo` int(11) DEFAULT NULL,
  `estado_tdo` int(11) DEFAULT '1',
  `usuario_reg` int(11) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_mod` int(11) DEFAULT NULL,
  `fecha_mod` timestamp NULL DEFAULT NULL,
  `sistema` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tipodocumento`
--

INSERT INTO `tipodocumento` (`codigo_tdo`, `nombre_tdo`, `abreviatura_tdo`, `codigosunat_tdo`, `tipo_tdo`, `contable_tdo`, `estado_tdo`, `usuario_reg`, `usuario_mod`, `fecha_mod`, `sistema`) VALUES
(1, 'TRANSFERENCIA', 'TRN', '', NULL, NULL, 1, NULL, 0, '2024-06-25 05:11:02', 1),
(2, 'FACTURA', 'F', '01', 'IS', NULL, 1, NULL, 0, '2024-06-30 22:03:17', 0),
(3, 'OTRO', '', '', NULL, NULL, 0, NULL, 0, '2022-06-08 16:53:35', 0),
(4, 'RECEPCION DE MERCADERIA', 'RM', '', 'I', NULL, 1, NULL, 0, '2024-06-30 22:03:53', 0),
(5, 'GUIA DE REMISION', 'GR', '09', NULL, NULL, 1, NULL, NULL, NULL, 0),
(6, 'RECIBO INGRESO', 'RI', '', 'I', NULL, 0, NULL, 0, '2024-06-30 22:21:44', 0),
(7, 'ANTERIOR', 'A', '', 'CP', NULL, 1, NULL, 0, '2024-07-03 00:45:08', 0),
(8, '--TRANSFERENCIA 2', 'TRN', '', NULL, NULL, 0, NULL, 0, '2024-06-25 05:12:06', 0),
(9, 'BOLETA', 'B', '03', 'IS', NULL, 1, NULL, 0, '2024-06-30 22:21:22', 0),
(10, 'NOTA DE CREDITO', 'B', '07', NULL, NULL, 1, NULL, NULL, NULL, 0),
(11, 'NOTA DE DEBITO', 'B', '08', NULL, NULL, 1, NULL, NULL, NULL, 0),
(12, 'NOTA DE PEDIDO', 'NP', '', 'S', NULL, 1, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipomovimiento`
--

CREATE TABLE `tipomovimiento` (
  `codigo_tmo` char(1) COLLATE utf8_spanish_ci NOT NULL,
  `nombre_tmo` varchar(10) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tipomovimiento`
--

INSERT INTO `tipomovimiento` (`codigo_tmo`, `nombre_tmo`) VALUES
('E', 'EGRESO'),
('I', 'INGRESO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipopersona`
--

CREATE TABLE `tipopersona` (
  `codigo_tip` int(11) NOT NULL,
  `nombre_tip` varchar(500) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `estado_tip` int(11) DEFAULT '1',
  `usuario_reg` int(11) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_mod` int(11) DEFAULT NULL,
  `fecha_mod` timestamp NULL DEFAULT NULL,
  `sistema` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tipopersona`
--

INSERT INTO `tipopersona` (`codigo_tip`, `nombre_tip`, `estado_tip`, `usuario_reg`, `usuario_mod`, `fecha_mod`, `sistema`) VALUES
(1, 'CLIENTES', 1, 1, NULL, NULL, 0),
(2, 'PROVEEDOR', 1, 1, NULL, NULL, 0),
(3, 'OTROS', 1, 1, NULL, NULL, 0),
(4, '..', 0, 0, 0, '2024-06-16 00:59:48', 0),
(5, 'D', 0, 0, 0, '2024-06-26 02:43:20', 0),
(6, 'NUEVO', 0, 0, 0, '2024-06-29 16:00:35', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_nota`
--

CREATE TABLE `tipo_nota` (
  `codigo_tno` int(11) NOT NULL,
  `descripcion_tno` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `controlstock_tno` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tipo_nota`
--

INSERT INTO `tipo_nota` (`codigo_tno`, `descripcion_tno`, `controlstock_tno`) VALUES
(1, 'Anulación de la operación', 1),
(2, 'Anulación por error en el RUC', 1),
(3, 'Corrección por error en la descripción', 1),
(4, 'Descuento global', 0),
(5, 'Descuento por Item', 0),
(6, 'Devolución total', 1),
(7, 'Devolución parcial', 1),
(8, 'Bonificación', 0),
(9, 'Disminución en el valor', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `traslado`
--

CREATE TABLE `traslado` (
  `codigo_tra` int(11) NOT NULL,
  `codigosuc_origen` int(11) NOT NULL,
  `codigosuc_destino` int(11) NOT NULL,
  `fecha_tra` date DEFAULT NULL,
  `subtotal_tra` decimal(12,2) DEFAULT '0.00',
  `mtoigv_tra` decimal(12,2) DEFAULT '0.00',
  `total_tra` decimal(12,2) DEFAULT '0.00',
  `codigo_mon` int(11) NOT NULL,
  `detalle_tra` varchar(1000) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `dolar_tra` decimal(12,2) DEFAULT '0.00',
  `impuesto_tra` decimal(12,2) DEFAULT '0.00',
  `estado_pfm` int(11) DEFAULT '1',
  `usuario_reg` int(11) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_mod` int(11) DEFAULT NULL,
  `fecha_mod` timestamp NULL DEFAULT NULL,
  `sistema` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `traslado_detalle`
--

CREATE TABLE `traslado_detalle` (
  `codigo_dtr` int(11) NOT NULL,
  `codigo_art` int(11) NOT NULL,
  `item_dtr` decimal(2,0) NOT NULL,
  `cantidad_dtr` decimal(12,2) DEFAULT '0.00',
  `precio_dtr` decimal(12,2) DEFAULT '0.00',
  `flete_dtr` decimal(12,2) DEFAULT '0.00',
  `otros_dtr` decimal(12,2) DEFAULT '0.00',
  `codigo_tra` int(11) DEFAULT NULL,
  `estado_dtr` int(11) DEFAULT '1',
  `usuario_reg` int(11) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_mod` int(11) DEFAULT NULL,
  `fecha_mod` timestamp NULL DEFAULT NULL,
  `sistema` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `codigo_vta` int(11) NOT NULL,
  `codigo_suc` int(11) NOT NULL,
  `codigo_tdo` int(11) NOT NULL,
  `serie_vta` varchar(4) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `numero_vta` varchar(7) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `codigo_cli` int(11) NOT NULL,
  `fecha_vta` date NOT NULL,
  `subtotal_vta` decimal(12,2) DEFAULT '0.00',
  `mtoigv_vta` decimal(12,2) DEFAULT '0.00',
  `exonerado_vta` decimal(12,2) DEFAULT '0.00',
  `inafecto_vta` decimal(12,2) DEFAULT '0.00',
  `total_vta` decimal(12,2) DEFAULT '0.00',
  `codigo_mon` int(11) NOT NULL,
  `detalle_vta` varchar(1000) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `dolar_vta` decimal(10,4) DEFAULT '1.0000',
  `codigo_cod` int(11) NOT NULL,
  `dias_vta` int(11) DEFAULT '0',
  `codigo_cta` int(11) DEFAULT NULL,
  `impuesto_vta` decimal(10,4) DEFAULT '0.0000',
  `codigo_con` int(11) NOT NULL,
  `codigo_ven` int(11) NOT NULL DEFAULT '1',
  `codigo_szo` int(11) NOT NULL,
  `codigo_zon` int(11) NOT NULL,
  `codigoref_tdo` int(11) DEFAULT NULL,
  `serieref_vta` varchar(4) COLLATE utf8_spanish_ci DEFAULT NULL,
  `numeroref_vta` varchar(7) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fecharef_vta` date NOT NULL,
  `enviadosunat_vta` int(11) DEFAULT '0',
  `fechaenviosunat_vta` date DEFAULT NULL,
  `hashsunat_vta` varchar(1000) COLLATE utf8_spanish_ci DEFAULT NULL,
  `estado_vta` int(11) DEFAULT '1',
  `usuario_reg` int(11) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_mod` int(11) DEFAULT NULL,
  `fecha_mod` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta_detalle`
--

CREATE TABLE `venta_detalle` (
  `codigo_vde` int(11) NOT NULL,
  `codigo_art` int(11) NOT NULL,
  `item_vde` int(11) NOT NULL,
  `nombre_art` varchar(1000) COLLATE utf8_spanish_ci DEFAULT NULL,
  `cantidad_vde` decimal(12,2) DEFAULT '0.00',
  `precio_vde` decimal(12,2) DEFAULT '0.00',
  `descuento_vde` decimal(12,2) DEFAULT '0.00',
  `impuesto_vde` decimal(10,4) DEFAULT '0.0000',
  `costopromedio_cde` decimal(10,4) DEFAULT '0.0000',
  `tipoimpuesto` varchar(1) COLLATE utf8_spanish_ci DEFAULT NULL,
  `codigo_vta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zona`
--

CREATE TABLE `zona` (
  `codigo_zon` int(11) NOT NULL,
  `nombre_zon` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `estado_zon` int(11) DEFAULT '1',
  `usuario_reg` int(11) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_mod` int(11) DEFAULT NULL,
  `fecha_mod` timestamp NULL DEFAULT NULL,
  `sistema` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `zona`
--

INSERT INTO `zona` (`codigo_zon`, `nombre_zon`, `estado_zon`, `usuario_reg`, `usuario_mod`, `fecha_mod`, `sistema`) VALUES
(1, 'CHICLAYO', 1, NULL, NULL, NULL, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `articulo`
--
ALTER TABLE `articulo`
  ADD PRIMARY KEY (`codigo_art`),
  ADD KEY `fk_Articulolinea` (`codigo_lin`),
  ADD KEY `fk_Articulomarca` (`codigo_mar`);

--
-- Indices de la tabla `banco`
--
ALTER TABLE `banco`
  ADD PRIMARY KEY (`codigo_ban`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`codigo_cli`),
  ADD KEY `fk_cliente_documento` (`codigo_doc`),
  ADD KEY `fk_cliente_tipopersona` (`codigo_tip`),
  ADD KEY `fk_cliente_distrito` (`codigo_dis`);

--
-- Indices de la tabla `compra`
--
ALTER TABLE `compra`
  ADD PRIMARY KEY (`codigo_com`);

--
-- Indices de la tabla `compra_detalle`
--
ALTER TABLE `compra_detalle`
  ADD PRIMARY KEY (`codigo_cde`);

--
-- Indices de la tabla `concepto`
--
ALTER TABLE `concepto`
  ADD PRIMARY KEY (`codigo_con`),
  ADD KEY `fk_concepto` (`codigo_gco`);

--
-- Indices de la tabla `condicion`
--
ALTER TABLE `condicion`
  ADD PRIMARY KEY (`codigo_cod`);

--
-- Indices de la tabla `cuenta`
--
ALTER TABLE `cuenta`
  ADD PRIMARY KEY (`codigo_cta`),
  ADD KEY `fk_cuenta_banco` (`codigo_ban`),
  ADD KEY `fk_cuenta_moneda` (`codigo_mon`),
  ADD KEY `fk_cuenta_sucursal` (`codigo_suc`);

--
-- Indices de la tabla `departamento`
--
ALTER TABLE `departamento`
  ADD PRIMARY KEY (`codigo_dep`);

--
-- Indices de la tabla `distrito`
--
ALTER TABLE `distrito`
  ADD PRIMARY KEY (`codigo_dis`),
  ADD KEY `fk_distrito_provincia` (`codigo_pro`);

--
-- Indices de la tabla `documento`
--
ALTER TABLE `documento`
  ADD PRIMARY KEY (`codigo_doc`);

--
-- Indices de la tabla `grupoconcepto`
--
ALTER TABLE `grupoconcepto`
  ADD PRIMARY KEY (`codigo_gco`);

--
-- Indices de la tabla `linea`
--
ALTER TABLE `linea`
  ADD PRIMARY KEY (`codigo_lin`);

--
-- Indices de la tabla `marca`
--
ALTER TABLE `marca`
  ADD PRIMARY KEY (`codigo_mar`);

--
-- Indices de la tabla `moneda`
--
ALTER TABLE `moneda`
  ADD PRIMARY KEY (`codigo_mon`);

--
-- Indices de la tabla `movimientocliente`
--
ALTER TABLE `movimientocliente`
  ADD PRIMARY KEY (`codigo_moc`),
  ADD KEY `fk_movimientocliente_sucursal` (`codigo_suc`),
  ADD KEY `fk_movimientocliente_moneda` (`codigo_mon`),
  ADD KEY `fk_movimientocliente_concepto` (`codigo_con`),
  ADD KEY `fk_movimientocliente_subzona` (`codigo_szo`),
  ADD KEY `fk_movimientocliente_zona` (`codigo_zon`);

--
-- Indices de la tabla `movimientoproveedor`
--
ALTER TABLE `movimientoproveedor`
  ADD PRIMARY KEY (`codigo_mop`),
  ADD KEY `fk_movimientoproveedor_sucursal` (`codigo_suc`),
  ADD KEY `fk_movimientoproveedor_proveedor` (`codigo_pro`),
  ADD KEY `fk_movimientoproveedor_moneda` (`codigo_mon`),
  ADD KEY `fk_movimientoproveedor_concepto` (`codigo_con`);

--
-- Indices de la tabla `proforma`
--
ALTER TABLE `proforma`
  ADD PRIMARY KEY (`codigo_pfm`),
  ADD KEY `fk_proforma_sucursal` (`codigo_suc`),
  ADD KEY `fk_proforma_cliente` (`codigo_cli`);

--
-- Indices de la tabla `proforma_detalle`
--
ALTER TABLE `proforma_detalle`
  ADD PRIMARY KEY (`codigo_dpf`),
  ADD KEY `fk_proformadetalle_articulo` (`codigo_art`),
  ADD KEY `fk_proformadetalle_proforma` (`codigo_pfm`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`codigo_pro`),
  ADD KEY `fk_proveedor_documento` (`codigo_doc`),
  ADD KEY `fk_proveedor_tipopersona` (`codigo_tip`);

--
-- Indices de la tabla `provincia`
--
ALTER TABLE `provincia`
  ADD PRIMARY KEY (`codigo_pro`),
  ADD KEY `fk_provincia_departamento` (`codigo_dep`);

--
-- Indices de la tabla `seriedocumento`
--
ALTER TABLE `seriedocumento`
  ADD PRIMARY KEY (`codigo_ser`),
  ADD KEY `fk_seriedocumento_tipodocumento` (`codigo_tdo`),
  ADD KEY `fk_seriedocumento_sucursal` (`codigo_suc`);

--
-- Indices de la tabla `stock_sucursal`
--
ALTER TABLE `stock_sucursal`
  ADD PRIMARY KEY (`codigo_stk`),
  ADD KEY `fk_stocksucursal_articulo` (`codigo_art`),
  ADD KEY `fk_trasladodetalle_sucursal` (`codigo_suc`);

--
-- Indices de la tabla `subzona`
--
ALTER TABLE `subzona`
  ADD PRIMARY KEY (`codigo_szo`),
  ADD KEY `fk_suzsona_zona` (`codigo_zon`);

--
-- Indices de la tabla `sucursal`
--
ALTER TABLE `sucursal`
  ADD PRIMARY KEY (`codigo_suc`);

--
-- Indices de la tabla `tipocambio`
--
ALTER TABLE `tipocambio`
  ADD PRIMARY KEY (`codigo_tic`);

--
-- Indices de la tabla `tipodocumento`
--
ALTER TABLE `tipodocumento`
  ADD PRIMARY KEY (`codigo_tdo`);

--
-- Indices de la tabla `tipomovimiento`
--
ALTER TABLE `tipomovimiento`
  ADD PRIMARY KEY (`codigo_tmo`);

--
-- Indices de la tabla `tipopersona`
--
ALTER TABLE `tipopersona`
  ADD PRIMARY KEY (`codigo_tip`);

--
-- Indices de la tabla `tipo_nota`
--
ALTER TABLE `tipo_nota`
  ADD PRIMARY KEY (`codigo_tno`);

--
-- Indices de la tabla `traslado`
--
ALTER TABLE `traslado`
  ADD PRIMARY KEY (`codigo_tra`),
  ADD KEY `fk_traslado_sucursalOrigen` (`codigosuc_origen`);

--
-- Indices de la tabla `traslado_detalle`
--
ALTER TABLE `traslado_detalle`
  ADD PRIMARY KEY (`codigo_dtr`),
  ADD KEY `fk_trasladodetalle_articulo` (`codigo_art`),
  ADD KEY `fk_trasladodetalle_traslado` (`codigo_tra`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`codigo_vta`),
  ADD KEY `fk_venta_sucursal` (`codigo_suc`),
  ADD KEY `fk_venta_tipodocumento` (`codigo_tdo`),
  ADD KEY `fk_venta_cliente` (`codigo_cli`),
  ADD KEY `fk_venta_moneda` (`codigo_mon`),
  ADD KEY `fk_venta_condicion` (`codigo_cod`);

--
-- Indices de la tabla `venta_detalle`
--
ALTER TABLE `venta_detalle`
  ADD PRIMARY KEY (`codigo_vde`),
  ADD KEY `fk_ventadetalle_venta` (`codigo_vta`),
  ADD KEY `fk_ventadetalle_articulo` (`codigo_art`);

--
-- Indices de la tabla `zona`
--
ALTER TABLE `zona`
  ADD PRIMARY KEY (`codigo_zon`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `articulo`
--
ALTER TABLE `articulo`
  MODIFY `codigo_art` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1615;

--
-- AUTO_INCREMENT de la tabla `banco`
--
ALTER TABLE `banco`
  MODIFY `codigo_ban` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `codigo_cli` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4825;

--
-- AUTO_INCREMENT de la tabla `compra`
--
ALTER TABLE `compra`
  MODIFY `codigo_com` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `compra_detalle`
--
ALTER TABLE `compra_detalle`
  MODIFY `codigo_cde` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `concepto`
--
ALTER TABLE `concepto`
  MODIFY `codigo_con` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `condicion`
--
ALTER TABLE `condicion`
  MODIFY `codigo_cod` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `cuenta`
--
ALTER TABLE `cuenta`
  MODIFY `codigo_cta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `departamento`
--
ALTER TABLE `departamento`
  MODIFY `codigo_dep` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `distrito`
--
ALTER TABLE `distrito`
  MODIFY `codigo_dis` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=250402;

--
-- AUTO_INCREMENT de la tabla `documento`
--
ALTER TABLE `documento`
  MODIFY `codigo_doc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `grupoconcepto`
--
ALTER TABLE `grupoconcepto`
  MODIFY `codigo_gco` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `linea`
--
ALTER TABLE `linea`
  MODIFY `codigo_lin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de la tabla `marca`
--
ALTER TABLE `marca`
  MODIFY `codigo_mar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT de la tabla `moneda`
--
ALTER TABLE `moneda`
  MODIFY `codigo_mon` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `movimientocliente`
--
ALTER TABLE `movimientocliente`
  MODIFY `codigo_moc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT de la tabla `movimientoproveedor`
--
ALTER TABLE `movimientoproveedor`
  MODIFY `codigo_mop` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `proforma`
--
ALTER TABLE `proforma`
  MODIFY `codigo_pfm` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `proforma_detalle`
--
ALTER TABLE `proforma_detalle`
  MODIFY `codigo_dpf` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `codigo_pro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;

--
-- AUTO_INCREMENT de la tabla `provincia`
--
ALTER TABLE `provincia`
  MODIFY `codigo_pro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2505;

--
-- AUTO_INCREMENT de la tabla `seriedocumento`
--
ALTER TABLE `seriedocumento`
  MODIFY `codigo_ser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `stock_sucursal`
--
ALTER TABLE `stock_sucursal`
  MODIFY `codigo_stk` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `subzona`
--
ALTER TABLE `subzona`
  MODIFY `codigo_szo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `sucursal`
--
ALTER TABLE `sucursal`
  MODIFY `codigo_suc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tipocambio`
--
ALTER TABLE `tipocambio`
  MODIFY `codigo_tic` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `tipodocumento`
--
ALTER TABLE `tipodocumento`
  MODIFY `codigo_tdo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `tipopersona`
--
ALTER TABLE `tipopersona`
  MODIFY `codigo_tip` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `tipo_nota`
--
ALTER TABLE `tipo_nota`
  MODIFY `codigo_tno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `traslado`
--
ALTER TABLE `traslado`
  MODIFY `codigo_tra` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `traslado_detalle`
--
ALTER TABLE `traslado_detalle`
  MODIFY `codigo_dtr` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `codigo_vta` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `venta_detalle`
--
ALTER TABLE `venta_detalle`
  MODIFY `codigo_vde` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `zona`
--
ALTER TABLE `zona`
  MODIFY `codigo_zon` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `articulo`
--
ALTER TABLE `articulo`
  ADD CONSTRAINT `fk_Articulolinea` FOREIGN KEY (`codigo_lin`) REFERENCES `linea` (`codigo_lin`),
  ADD CONSTRAINT `fk_Articulomarca` FOREIGN KEY (`codigo_mar`) REFERENCES `marca` (`codigo_mar`);

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `fk_cliente_distrito` FOREIGN KEY (`codigo_dis`) REFERENCES `distrito` (`codigo_dis`),
  ADD CONSTRAINT `fk_cliente_documento` FOREIGN KEY (`codigo_doc`) REFERENCES `documento` (`codigo_doc`),
  ADD CONSTRAINT `fk_cliente_tipopersona` FOREIGN KEY (`codigo_tip`) REFERENCES `tipopersona` (`codigo_tip`);

--
-- Filtros para la tabla `concepto`
--
ALTER TABLE `concepto`
  ADD CONSTRAINT `fk_concepto` FOREIGN KEY (`codigo_gco`) REFERENCES `grupoconcepto` (`codigo_gco`);

--
-- Filtros para la tabla `cuenta`
--
ALTER TABLE `cuenta`
  ADD CONSTRAINT `fk_cuenta_banco` FOREIGN KEY (`codigo_ban`) REFERENCES `banco` (`codigo_ban`),
  ADD CONSTRAINT `fk_cuenta_moneda` FOREIGN KEY (`codigo_mon`) REFERENCES `moneda` (`codigo_mon`),
  ADD CONSTRAINT `fk_cuenta_sucursal` FOREIGN KEY (`codigo_suc`) REFERENCES `sucursal` (`codigo_suc`);

--
-- Filtros para la tabla `distrito`
--
ALTER TABLE `distrito`
  ADD CONSTRAINT `fk_distrito_provincia` FOREIGN KEY (`codigo_pro`) REFERENCES `provincia` (`codigo_pro`);

--
-- Filtros para la tabla `movimientocliente`
--
ALTER TABLE `movimientocliente`
  ADD CONSTRAINT `fk_movimientocliente_concepto` FOREIGN KEY (`codigo_con`) REFERENCES `concepto` (`codigo_con`),
  ADD CONSTRAINT `fk_movimientocliente_moneda` FOREIGN KEY (`codigo_mon`) REFERENCES `moneda` (`codigo_mon`),
  ADD CONSTRAINT `fk_movimientocliente_subzona` FOREIGN KEY (`codigo_szo`) REFERENCES `subzona` (`codigo_szo`),
  ADD CONSTRAINT `fk_movimientocliente_sucursal` FOREIGN KEY (`codigo_suc`) REFERENCES `sucursal` (`codigo_suc`),
  ADD CONSTRAINT `fk_movimientocliente_zona` FOREIGN KEY (`codigo_zon`) REFERENCES `zona` (`codigo_zon`);

--
-- Filtros para la tabla `movimientoproveedor`
--
ALTER TABLE `movimientoproveedor`
  ADD CONSTRAINT `fk_movimientoproveedor_concepto` FOREIGN KEY (`codigo_con`) REFERENCES `concepto` (`codigo_con`),
  ADD CONSTRAINT `fk_movimientoproveedor_moneda` FOREIGN KEY (`codigo_mon`) REFERENCES `moneda` (`codigo_mon`),
  ADD CONSTRAINT `fk_movimientoproveedor_proveedor` FOREIGN KEY (`codigo_pro`) REFERENCES `proveedor` (`codigo_pro`),
  ADD CONSTRAINT `fk_movimientoproveedor_sucursal` FOREIGN KEY (`codigo_suc`) REFERENCES `sucursal` (`codigo_suc`);

--
-- Filtros para la tabla `proforma`
--
ALTER TABLE `proforma`
  ADD CONSTRAINT `fk_proforma_cliente` FOREIGN KEY (`codigo_cli`) REFERENCES `cliente` (`codigo_cli`),
  ADD CONSTRAINT `fk_proforma_sucursal` FOREIGN KEY (`codigo_suc`) REFERENCES `sucursal` (`codigo_suc`);

--
-- Filtros para la tabla `proforma_detalle`
--
ALTER TABLE `proforma_detalle`
  ADD CONSTRAINT `fk_proformadetalle_articulo` FOREIGN KEY (`codigo_art`) REFERENCES `articulo` (`codigo_art`),
  ADD CONSTRAINT `fk_proformadetalle_proforma` FOREIGN KEY (`codigo_pfm`) REFERENCES `proforma` (`codigo_pfm`);

--
-- Filtros para la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD CONSTRAINT `fk_proveedor_documento` FOREIGN KEY (`codigo_doc`) REFERENCES `documento` (`codigo_doc`),
  ADD CONSTRAINT `fk_proveedor_tipopersona` FOREIGN KEY (`codigo_tip`) REFERENCES `tipopersona` (`codigo_tip`);

--
-- Filtros para la tabla `provincia`
--
ALTER TABLE `provincia`
  ADD CONSTRAINT `fk_provincia_departamento` FOREIGN KEY (`codigo_dep`) REFERENCES `departamento` (`codigo_dep`);

--
-- Filtros para la tabla `seriedocumento`
--
ALTER TABLE `seriedocumento`
  ADD CONSTRAINT `fk_seriedocumento_sucursal` FOREIGN KEY (`codigo_suc`) REFERENCES `sucursal` (`codigo_suc`),
  ADD CONSTRAINT `fk_seriedocumento_tipodocumento` FOREIGN KEY (`codigo_tdo`) REFERENCES `tipodocumento` (`codigo_tdo`);

--
-- Filtros para la tabla `stock_sucursal`
--
ALTER TABLE `stock_sucursal`
  ADD CONSTRAINT `fk_stocksucursal_articulo` FOREIGN KEY (`codigo_art`) REFERENCES `articulo` (`codigo_art`),
  ADD CONSTRAINT `fk_trasladodetalle_sucursal` FOREIGN KEY (`codigo_suc`) REFERENCES `sucursal` (`codigo_suc`);

--
-- Filtros para la tabla `subzona`
--
ALTER TABLE `subzona`
  ADD CONSTRAINT `fk_suzsona_zona` FOREIGN KEY (`codigo_zon`) REFERENCES `zona` (`codigo_zon`);

--
-- Filtros para la tabla `traslado`
--
ALTER TABLE `traslado`
  ADD CONSTRAINT `fk_traslado_sucursalOrigen` FOREIGN KEY (`codigosuc_origen`) REFERENCES `sucursal` (`codigo_suc`);

--
-- Filtros para la tabla `traslado_detalle`
--
ALTER TABLE `traslado_detalle`
  ADD CONSTRAINT `fk_trasladodetalle_articulo` FOREIGN KEY (`codigo_art`) REFERENCES `articulo` (`codigo_art`),
  ADD CONSTRAINT `fk_trasladodetalle_traslado` FOREIGN KEY (`codigo_tra`) REFERENCES `traslado` (`codigo_tra`);

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `fk_venta_cliente` FOREIGN KEY (`codigo_cli`) REFERENCES `cliente` (`codigo_cli`),
  ADD CONSTRAINT `fk_venta_condicion` FOREIGN KEY (`codigo_cod`) REFERENCES `condicion` (`codigo_cod`),
  ADD CONSTRAINT `fk_venta_moneda` FOREIGN KEY (`codigo_mon`) REFERENCES `moneda` (`codigo_mon`),
  ADD CONSTRAINT `fk_venta_sucursal` FOREIGN KEY (`codigo_suc`) REFERENCES `sucursal` (`codigo_suc`),
  ADD CONSTRAINT `fk_venta_tipodocumento` FOREIGN KEY (`codigo_tdo`) REFERENCES `tipodocumento` (`codigo_tdo`);

--
-- Filtros para la tabla `venta_detalle`
--
ALTER TABLE `venta_detalle`
  ADD CONSTRAINT `fk_ventadetalle_articulo` FOREIGN KEY (`codigo_art`) REFERENCES `articulo` (`codigo_art`),
  ADD CONSTRAINT `fk_ventadetalle_venta` FOREIGN KEY (`codigo_vta`) REFERENCES `venta` (`codigo_vta`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

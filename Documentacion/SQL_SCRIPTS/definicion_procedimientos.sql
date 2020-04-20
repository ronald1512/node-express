#este archivo va a tener los procedimientos almacenados útiles para el proyecto
USE main;

#procedimiento para agregarle un determinado rol y respectivos permisos a determinado usuario
DELIMITER //
CREATE PROCEDURE proc_add_permisos_n_rol_by_rol(IN id_usuario INT, IN id_rol INT)
BEGIN
	# agregamos primero su rol en usuario_rol, luego agregamos sus autorizaciones en 'autorizacion'
	INSERT INTO usuario_rol (id_rol, id_usuario)
    VALUES (id_rol, id_usuario);
    
	IF id_rol=1 THEN 
	   INSERT INTO autorizacion(id_usuario, id_permiso)
       VALUES
		#usuario VENDEDOR
		(id_usuario, 1),
        (id_usuario,2),
        (id_usuario,3);
	ELSEIF id_rol=2 OR id_rol=6 THEN #un Encargado de bodega va a tener los mismos permisos
		INSERT INTO autorizacion (id_usuario, id_permiso)
		VALUES 
        #usuario BODEGUERO
        (id_usuario, 4),
        (id_usuario, 5),
        (id_usuario, 6),
        (id_usuario, 7);
        
	ELSEIF id_rol=3 THEN
		INSERT INTO autorizacion (id_usuario, id_permiso)
		VALUES 
         #usuario REPARTIDOR
        (id_usuario, 8),
        (id_usuario, 9);
	ELSEIF id_rol=4 THEN
		INSERT INTO autorizacion (id_usuario, id_permiso)
		VALUES 
         #usuario ADMINISTRADOR
        (id_usuario, 1),
        (id_usuario, 2),
        (id_usuario, 3),
        (id_usuario, 4),
        (id_usuario, 5),
        (id_usuario, 6),
        (id_usuario, 7),
        (id_usuario, 8),
        (id_usuario, 9),
        (id_usuario, 10),
        (id_usuario, 11),
        (id_usuario, 12);
	ELSEIF id_rol=5 THEN
		INSERT INTO autorizacion (id_usuario, id_permiso)
		VALUES 
         #usuario ENCARGADO DE SEDE
        (id_usuario, 11),
        (id_usuario, 12);
	END IF;
END //
DELIMITER ;


# procedimiento para crear una nueva sede y al encargado asignarle de una vez su ID_SEDE
#hace falta la validacion de que el encargado tenga entre sus roles 'Encargado de sede -> 5'. 
DELIMITER //
CREATE PROCEDURE proc_add_sede_n_mod_encargado(IN alias varchar(50), in direccion varchar(50), in id_mun int, in encargado int)
BEGIN
	DECLARE l_sede_id INT DEFAULT 0;
	#CREAMOS LA SEDE
    INSERT INTO sede (alias, direccion, id_mun, encargado)
    VALUES 
		(alias, direccion, id_mun, encargado);
    #MODIFICAMOS EL ID_SEDE del encargado
    SET l_sede_id=last_insert_id(); # obtengo el id de la sede que se acaba de insertar
    UPDATE usuario SET id_sede = l_sede_id WHERE id_usuario=encargado;
    
    SELECT * FROM sede where id_sede=l_sede_id; # esto es solo para que retorne la sede creada :)
END //
DELIMITER ;





# procedimiento para el manejo de inventario y log_inventario
# cuando se quiere realizar un cambio en el inventario se agrega un log


DELIMITER //
CREATE PROCEDURE proc_inventario_n_log(in producto int, in bodega int,
in cantidad_nueva int, in motivo varchar(200), in encargado int)
BEGIN
	# Aqui quiero validar si ya hay en 'inventario' un registro con esos id_producto y id_bodega
	DECLARE inv_cnt INT DEFAULT 0;
    DECLARE cant_origen INT DEFAULT 0;
    DECLARE cur CURSOR FOR SELECT cantidad from inventario WHERE id_producto=producto AND id_bodega=bodega;
    OPEN cur;
	select FOUND_ROWS() into inv_cnt ;
    IF inv_cnt = 1 THEN
        # entonces vamos a actualizarlo 
        UPDATE inventario SET cantidad=cantidad_nueva WHERE id_producto=producto AND id_bodega=bodega;
        # y a crear su log
        FETCH cur INTO cant_origen;
        INSERT INTO log_inventario (id_producto, id_bodega, cantidad_nueva, cantidad_antigua, motivo, fecha, id_usuario)
        VALUES
        (producto, bodega, cantidad_nueva, cant_origen, motivo, LOCALTIME, encargado);
        
	ELSE 
        # entonces vamos a crearlo 
        INSERT INTO inventario(id_producto, id_bodega, cantidad)
        VALUES (producto, bodega, cantidad_nueva);
        # y a crear su log
        INSERT INTO log_inventario (id_producto, id_bodega, cantidad_nueva, cantidad_antigua, motivo, fecha, id_usuario)
        VALUES
        (producto, bodega, cantidad_nueva, 0, motivo, LOCALTIME, encargado);
    END IF;
    CLOSE cur;
END //
DELIMITER ;



# PROCEDIMIENTO para registrar una venta

DELIMITER //
CREATE PROCEDURE proc_venta_local(in cliente int, in vendedor INT)
BEGIN
	# hay que validar que el vendedor sea de la misma sede que el usuario.
    DECLARE sede_cliente int;
    DECLARE sede_vendedor int;
    DECLARE cont_cli int default 0;
    DECLARE cont_vend int default 0;
    DECLARE l_venta_id int;
    
    DECLARE cur_vendedor cursor for select id_sede from usuario where id_usuario=vendedor;
    DECLARE cur_cliente CURSOR FOR SELECT id_sede from cliente where id_cliente=cliente;
    OPEN cur_vendedor;
    SELECT FOUND_ROWS() into cont_vend;
    IF cont_vend =1 THEN
		fetch cur_vendedor into sede_vendedor;
        close cur_vendedor;
    ELSE
		SELECT 'No hay ningun usuario con ese identificador' as Mensaje;
    END IF;
    
    OPEN cur_cliente;
    SELECT FOUND_ROWS() into cont_cli;
    IF cont_cli =1 THEN
		fetch cur_cliente into sede_cliente;
        close cur_cliente;
    ELSE
		SELECT 'No hay ningun cliente con ese identificador' as Mensaje;
    END IF;
    
    
    if sede_cliente = sede_vendedor then
		# insertamos
		INSERT INTO venta(id_cliente, vendedor, fecha_facturacion)
		VALUES
		(cliente, vendedor, LOCALTIME); # los demás atributos se ponen por defecto.
        
        SET l_venta_id=last_insert_id(); # obtengo el id de la sede que se acaba de insertar    
		SELECT * FROM venta where id_venta=l_venta_id; # esto es solo para que retorne la venta creada :)
	ELSE
		SELECT 'LA SEDE DEL USUARIO Y DEL CLIENTE DEBEN SER LA MISMA.' as Mensaje;
	END IF;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE proc_venta_domicilio(in cliente int, in vendedor INT, in repartidor int)
BEGIN
	# hay que validar que el vendedor sea de la misma sede que el cliente y que el repartidor.
    DECLARE sede_cliente int;
    DECLARE sede_vendedor int;
    DECLARE sede_repartidor int;
    DECLARE cont_cli int default 0;
    DECLARE cont_vend int default 0;
    DECLARE cont_rep int default 0;
    DECLARE l_venta_id int;
    
    DECLARE cur_vendedor cursor for select id_sede from usuario where id_usuario=vendedor;
    DECLARE cur_repartidor cursor for select id_sede from usuario where id_usuario=repartidor;
    DECLARE cur_cliente CURSOR FOR SELECT id_sede from cliente where id_cliente=cliente;
    OPEN cur_vendedor;
    SELECT FOUND_ROWS() into cont_vend;
    IF cont_vend =1 THEN
		fetch cur_vendedor into sede_vendedor;
        close cur_vendedor;
    ELSE
		SELECT 'No hay ningun usuario con ese identificador' as Mensaje;
    END IF;
    
    
    OPEN cur_repartidor;
    SELECT FOUND_ROWS() into cont_rep;
    IF cont_rep =1 THEN
		fetch cur_repartidor into sede_repartidor;
        close cur_repartidor;
    ELSE
		SELECT 'No hay ningun usuario con ese identificador' as Mensaje;
    END IF;
    
    
    
    
    
    OPEN cur_cliente;
    SELECT FOUND_ROWS() into cont_cli;
    IF cont_cli =1 THEN
		fetch cur_cliente into sede_cliente;
        close cur_cliente;
    ELSE
		SELECT 'No hay ningun cliente con ese identificador' as Mensaje;
    END IF;
    
    if sede_cliente = sede_vendedor and sede_cliente = sede_repartidor then
		INSERT INTO venta(id_cliente, vendedor, fecha_facturacion, estado, entrega, repartidor)
		VALUES
		(cliente, vendedor, LOCALTIME, 'P', 'D', repartidor); # cuando el repartidor entregue ya estado va a pasar a 'E'.
        
        SET l_venta_id=last_insert_id(); # obtengo el id de la sede que se acaba de insertar    
		SELECT * FROM venta where id_venta=l_venta_id; # esto es solo para que retorne la venta creada :)
    else
		select 'La sede del vendedor, del cliente y del repartidor debe ser la misma.' as Mensaje;
    end if;
END //
DELIMITER ;



#en este procedimiento debo quitar de inventario a los productos si la venta es 'local'.
DELIMITER //
CREATE PROCEDURE proc_add_detalle_venta_n_update_venta(in producto int, in bodega INT, in venta int, in cantidad_solicitada int, in descuento float)
BEGIN
	# actualizamos la venta: subtotal, descuento, cargo
    /*
		subtotal+=producto.precio*cantidad
        descuento+=producto.precio*desc.*cantidad
        cargo+=producto.precio*0.1*cantidad si la venta es a domicilio.
    */
    DECLARE venta_cnt int default 0;
    DECLARE producto_cnt int default 0;
    DECLARE invent_cnt int default 0;
    DECLARE bodega_cnt INT DEFAULT 0;
    DECLARE subt float default 0.0;
    DECLARE descu float default 0.0;
    DECLARE carg float default 0.0;
    DECLARE entr char(1) default 'E';
    DECLARE precio_p  float default 0.0;
    DECLARE cantidad_en_bodega int default 0;
    DECLARE est_bodega char(1) default 'E';
    DECLARE res_cant int default 0;
    DECLARE original_cant_bodega int default 0;
    
    DECLARE cur_bodega CURSOR for select estado from bodega where id_bodega=bodega;
    DECLARE cur_inventario cursor for SELECT cantidad from inventario where id_producto=producto AND id_bodega=bodega;
    DECLARE cur_venta cursor for SELECT subtotal, descuento, cargo, entrega from venta where id_venta=venta;
    DECLARE cur_producto cursor for select precio from producto where id_producto=producto;
    
    OPEN cur_bodega;
    SELECT FOUND_ROWS() into bodega_cnt;
    
    IF bodega_cnt = 1 THEN
		fetch cur_bodega into est_bodega;
        close cur_bodega;
        IF  est_bodega = 'E' then
            OPEN cur_inventario;
			select FOUND_ROWS() into invent_cnt;
			IF invent_cnt=1 then
				fetch cur_inventario into cantidad_en_bodega;
				CLOSE cur_inventario;
                set original_cant_bodega=cantidad_en_bodega;
				if cantidad_en_bodega>=cantidad_solicitada THEN
					OPEN cur_venta;
					select FOUND_ROWS() into venta_cnt ;
					IF venta_cnt = 1 THEN
						fetch cur_venta into subt, descu, carg, entr;
						close cur_venta;
						# ahora debemos obtener el precio del producto
						open cur_producto;
						select found_rows() into producto_cnt;
						IF producto_cnt =1 then
							fetch cur_producto into precio_p;
                            CLOSE cur_producto; # ya no lo vamos a usar, lo cerramos. 
							# ahora tenemos 2 casos
							IF entr='L' THEN
								# es local. Entonces no lo sumamos cargo
								set subt=subt+precio_p*cantidad_solicitada;
								set descu=descu+precio_p*descuento*cantidad_solicitada;
							ELSE
								#es a domicilio. Le sumamos cargo
								set subt=subt+precio_p*cantidad_solicitada;
								set descu=descu+precio_p*descuento*cantidad_solicitada;
								set carg=carg+precio_p*0.1*cantidad_solicitada; #cargo del 10%
							END IF;
							
							# ahora agregamos el detalle en la tabla
							INSERT INTO detalle_venta(id_producto, id_bodega, id_venta, cantidad, descuento_unitario)
							VALUES
							(producto, bodega, venta,cantidad_solicitada, descuento);
                            
                            # ahora, aqui debemos descontar de la bodega si la venta es local.
							IF entr='L' THEN
								set res_cant=original_cant_bodega-cantidad_solicitada;
								UPDATE inventario set cantidad=res_cant where id_producto= producto AND id_bodega=bodega;
                            END IF;
                            
                            
                            # ahora, actualizamos los campos correspondientes en 'venta'
							UPDATE venta set subtotal=subt, descuento=descu, cargo=carg WHERE id_venta=venta;
                            
						ELSE
							select 'NO HAY NINGUN PRODUCTO BAJO ESE ID' as Mensaje;
						END IF;
					ELSE 
						select 'NO HAY NINGUNA VENTA CON ESE ID' as Mensaje;
					END IF;
					
				ELSE
					select concat('NO HAY SUFICIENTES EXISTENCIAS. Bodega: ',cantidad_en_bodega,', solicitada: ',cantidad_solicitada) as Mensaje;
				END IF;
				
			else
				select 'EL PRODUCTO ESPECIFICADO NO EXISTE EN LA BODEGA.' as Mensaje;
			
			end if;
        else
			SELECT 'No se puede usar la bodega porque está inactiva.' as Mensaje;
        end if;
    ELSE
		select 'No hay ninguna bodega bajo ese id.' as Mensaje;
    END IF;
END //
DELIMITER ;


# este será para quitar del inventario los que son a domicilio cuando acepten la venta.
DELIMITER //
CREATE PROCEDURE proc_confirmar_entrega_venta(in codigo_venta int)
BEGIN
	DECLARE venta_cnt int default 0;
    DECLARE invent_cnt int default 0;
    DECLARE estado_venta char(1);
    DECLARE entrega_venta char(1);
    DECLARE producto_detalle int;
    DECLARE bodega_detalle int;
	DECLARE cantidad_detalle int;
    DECLARE cantidad_en_bodega int DEFAULT 0;
    DECLARE finished INTEGER DEFAULT 0;

	# CURSORES
	DECLARE cur_venta cursor for SELECT estado, entrega from venta where id_venta=codigo_venta;
    DECLARE cur_detalle_venta cursor for SELECT id_producto, id_bodega, cantidad from detalle_venta where id_venta=codigo_venta;
    DECLARE cur_inventario cursor for SELECT cantidad from inventario where id_producto=producto_detalle and id_bodega=bodega_detalle;
    
     -- declare NOT FOUND handler
    DECLARE CONTINUE HANDLER 
			FOR NOT FOUND SET finished = 1;
    
    OPEN cur_venta;
	select FOUND_ROWS() into venta_cnt ;
	IF venta_cnt = 1 THEN
		fetch cur_venta into estado_venta, entrega_venta;
		close cur_venta;
        -- validamos que la venta sea a DOMICILIO, sino no se puede cambiar nada.
        IF entrega_venta ='D' then
			# validamos que la venta aun no haya sido entregada.
			IF estado_venta = 'P' THEN
				# Obtenemos todos los registros en 'detalle_venta' con el id_venta=venta
				open cur_detalle_venta;
				getDetalle: LOOP
					FETCH cur_detalle_venta into producto_detalle, bodega_detalle, cantidad_detalle;
					IF finished = 1 THEN 
						LEAVE getDetalle;
					END IF;
					# validamos la existencia del producto en el inventario
					OPEN cur_inventario;
					select FOUND_ROWS() into invent_cnt;
					IF invent_cnt=1 then
						fetch cur_inventario into cantidad_en_bodega;
						CLOSE cur_inventario;
						if cantidad_en_bodega>=cantidad_detalle THEN
							# descontamos el producto de la bodega
							update inventario set cantidad = cantidad_en_bodega-cantidad_detalle where id_producto=producto_detalle and id_bodega=bodega_detalle;
							# cambiamos el estado de la venta de 'P' a 'E'.
							# cambiamos la fecha de entrega a LOCALTIME
							UPDATE venta set estado='E', fecha_entrega=LOCALTIME where id_venta=codigo_venta;
                            select * from venta where id_venta=codigo_venta; -- quiero que retorne esto :D
						ELSE
							select 'La cantidad en bodega es menor a la solicitada, no se puede registrar la entrega.'as Mensaje;
							LEAVE getDetalle;
						END IF;
						
					ELSE 
						select 'El producto especificado no se encuentra disponible en la bodega detallada.'as Mensaje;
						LEAVE getDetalle;
					END IF;
				END LOOP getDetalle;
				
				close cur_detalle_venta;
			ELSE
				SELECT 'La venta ya ha sido entregada previamente' as Mensaje;
			END IF;
        else
			SELECT 'No se puede marcar modificar una venta local.'as Mensaje;
        END IF;
    ELSE 
		SELECT concat('No hay ninguna venta con ese id [',venta_cnt,']') AS Mensaje;
    END IF;
END //
DELIMITER ;

# El siguiente procedimiento maneja las solicitudes de transferencia interna
DELIMITER //
CREATE PROCEDURE proc_crear_interna(in id_solicitante int, in contenido_descripcion varchar(75))
BEGIN
	-- El id_sede del solicitante es la sede_origen
    DECLARE sede_solicitante int;
    DECLARE solicitante_cnt int default 0;
    DECLARE l_orden_id int;
    
    -- declaracion de cursores
    DECLARE cur_sede cursor for select id_sede from usuario where id_usuario=id_solicitante;
    
    OPEN cur_sede;
    select FOUND_ROWS() into solicitante_cnt;
    
    IF solicitante_cnt = 1 THEN
		FETCH cur_sede into sede_solicitante;
		CLOSE cur_sede;
		INSERT INTO orden_transferencia (solicitante, descripcion, sede_origen, sede_destino, fecha_orden)
        VALUES
			(id_solicitante, contenido_descripcion, sede_solicitante, sede_solicitante, LOCALTIME);
        
        SET l_orden_id=last_insert_id(); # obtengo el id de la sede que se acaba de insertar
        SELECT * from orden_transferencia where id_orden=l_orden_id;
    ELSE
		SELECT 'No se encontró ningun usuario con el id especificado'as Mensaje;
    END IF;
    
    
    
END //
DELIMITER ;

# El siguiente procedimiento maneja las solicitudes de transferencia EXTERNA
DELIMITER //
CREATE PROCEDURE proc_crear_externa(in id_solicitante int, in contenido_descripcion varchar(75), in b_entrante int, s_destino int)
BEGIN
	-- El id_sede del solicitante es la sede_origen
    DECLARE sede_solicitante int;
    DECLARE solicitante_cnt int default 0;
    DECLARE l_orden_id int;
    
    -- declaracion de cursores
    DECLARE cur_sede cursor for select id_sede from usuario where id_usuario=id_solicitante;
    
    OPEN cur_sede;
    select FOUND_ROWS() into solicitante_cnt;
    
    IF solicitante_cnt = 1 THEN
		FETCH cur_sede into sede_solicitante;
		CLOSE cur_sede;
		INSERT INTO orden_transferencia (solicitante, descripcion, tipo_orden, sede_origen, sede_destino, bodega_entrante, fecha_orden)
        VALUES
			(id_solicitante, contenido_descripcion, 'E', sede_solicitante, s_destino, b_entrante, LOCALTIME);
        
        SET l_orden_id=last_insert_id(); # obtengo el id de la sede que se acaba de insertar
        SELECT * from orden_transferencia where id_orden=l_orden_id;
    ELSE
		SELECT 'No se encontró ningun usuario con el id especificado'as Mensaje;
    END IF;
    
    
    
END //
DELIMITER ;

-- El siguiente procedimiento maneja la aceptacion de una orden de transferencia interna :)
DELIMITER //
CREATE PROCEDURE proc_aceptar_orden_interna(in orden_id int, in entrante int, in saliente int, in individuo int)
BEGIN
	-- validar que la bodega saliente tenga la capacidad de darme todos los productos que he detallado
    DECLARE finished INTEGER DEFAULT 0;
    DECLARE producto_detalle int;
    DECLARE cantidad_detalle int;
    DECLARE estado_orden char(1);
    DECLARE tipo_orden char(1);
    DECLARE cantidad_inventario int;
    DECLARE cantidad_inventario_entrante int;
    DECLARE orden_cnt int;
    DECLARE inventario_cnt int;
    DECLARE inventario_entrante_cnt int;
    DECLARE bandera int default 0;
    DECLARE cadena_salida varchar(500) default '';
    
    -- CURSORES
    DECLARE cur_detalle_orden cursor for select id_producto, cantidad from detalle_orden where id_orden=orden_id;
    DECLARE cur_detalle_orden2 cursor for select id_producto, cantidad from detalle_orden where id_orden=orden_id;
    DECLARE cur_orden cursor for select estado, tipo_orden from orden_transferencia where id_orden=orden_id;
    DECLARE cur_inventario cursor for select cantidad from inventario where id_producto=producto_detalle and id_bodega=saliente;
    DECLARE cur_inventario_entrante cursor for select cantidad from inventario where id_producto=producto_detalle and id_bodega=entrante;
    
     -- declare NOT FOUND handler
    DECLARE CONTINUE HANDLER 
			FOR NOT FOUND SET finished = 1;
            
	OPEN cur_orden;
    select FOUND_ROWS() into orden_cnt;
    IF orden_cnt=1 THEN
		-- AHORA VALIDAMOS que orden.tipo='i' && orden.estado='P'
        FETCH cur_orden into estado_orden, tipo_orden;
        close cur_orden;
        IF estado_orden!='P' then
			select 'No se puede aceptar la orden porque ya está previamente aceptada.'as Mensaje;
		else
			IF tipo_orden!='I' then
				select 'El procedimiento seleccionado solamente funciona en ordenes de transferencia INTERNA.'as Mensaje;
			else 
				open cur_detalle_orden;
				getDetalle: LOOP
					FETCH cur_detalle_orden into producto_detalle, cantidad_detalle;
					IF finished = 1 THEN 
						LEAVE getDetalle;
					END IF;
                    -- validar que la bodega saliente tenga la capacidad de darme todos los productos que he detallado
                    OPEN cur_inventario;
                    select FOUND_ROWS() into inventario_cnt;
                    if inventario_cnt=1 then
						FETCH cur_inventario into cantidad_inventario;
                        close cur_inventario;
                        if cantidad_inventario<cantidad_detalle then
							set bandera=bandera+1;
                            LEAVE getDetalle;
						end if;
                    else 	
						close cur_inventario;
                        set bandera=bandera+1;
                        LEAVE getDetalle;
					END IF;
                END LOOP getDetalle;
                close cur_detalle_orden;
                set finished=0;
                
                if bandera=0 then
					open cur_detalle_orden2;
                    updateInventario: LOOP
						FETCH cur_detalle_orden2 into producto_detalle, cantidad_detalle;
						IF finished = 1 THEN 
							LEAVE updateInventario;
						END IF;
                        -- ahora si vamos a mover las chivas. 
                        Open cur_inventario_entrante;
                        select FOUND_ROWS() into inventario_entrante_cnt;
                        if inventario_entrante_cnt=1 then
							-- ya tiene el producto en su inventario
                            FETCH cur_inventario_entrante into cantidad_inventario_entrante;
                            close cur_inventario_entrante;
                            set cadena_salida=concat(cadena_salida,cantidad_inventario_entrante,' + ', cantidad_detalle,'\n' );
                            update inventario set cantidad=cantidad_inventario_entrante+cantidad_detalle where id_producto=producto_detalle and id_bodega=entrante;
                            
                            update inventario set cantidad=cantidad-cantidad_detalle where id_producto=producto_detalle and id_bodega=saliente; -- actualizamos la saliente
                        else
							close cur_inventario_entrante;
							-- no tiene el producto en su inventario
                            INSERT INTO inventario(id_producto, id_bodega, cantidad)
                            VALUES (producto_detalle, entrante, cantidad_detalle);
                            set cadena_salida=concat(cadena_salida, '0',' + ', cantidad_detalle,'\n' );
                            update inventario set cantidad=cantidad-cantidad_detalle where id_producto=producto_detalle and id_bodega=saliente; -- actualizamos la saliente
                        end if;
                    END LOOP updateInventario;
                    close cur_detalle_orden2;
                    
                    -- ahora actualizamos campos de la orden_transferencia;
                    update orden_transferencia set estado='E', bodega_saliente=saliente, bodega_entrante=entrante, fecha_aceptada=LOCALTIME, aceptante=individuo where id_orden=orden_id;
                    select * from orden_transferencia where id_orden=orden_id;
                    -- SELECT cadena_salida;
                else
					select 'La bodega saliente seleccionada no cuenta con los productos seleccionados'as Mensaje;
                    
				end if;
			end if;
        end if;
    ELSE
		select 'No se encontró ninguna orden con esa clave.'as Mensaje;
    END IF;
    

END //
DELIMITER ;




-- El siguiente procedimiento maneja la aceptacion de una orden de transferencia EXTERNA :)
-- Cuando lo acepta solo actualiza las chivas en la orden_transferencia. Ya la actualizacion de inventarios se realiza cuando el repartidor la entrega.
DELIMITER //
CREATE PROCEDURE proc_aceptar_orden_externa(in orden_id int, in saliente int, in individuo int, in repartidor_id int)
BEGIN
	-- validar que la bodega saliente tenga la capacidad de darme todos los productos que he detallado
    DECLARE finished INTEGER DEFAULT 0;
    DECLARE producto_detalle int;
    DECLARE cantidad_detalle int;
    DECLARE estado_orden char(1);
    DECLARE tipo_orden char(1);
    DECLARE cantidad_inventario int;
    DECLARE cantidad_inventario_entrante int;
    DECLARE orden_cnt int;
    DECLARE inventario_cnt int;
    DECLARE inventario_entrante_cnt int;
    DECLARE bandera int default 0;
    DECLARE cadena_salida varchar(500) default '';
    DECLARE entrante int;
    
    -- CURSORES
    DECLARE cur_detalle_orden cursor for select id_producto, cantidad from detalle_orden where id_orden=orden_id;
    DECLARE cur_detalle_orden2 cursor for select id_producto, cantidad from detalle_orden where id_orden=orden_id;
    DECLARE cur_orden cursor for select estado, tipo_orden, bodega_entrante from orden_transferencia where id_orden=orden_id;
    DECLARE cur_inventario cursor for select cantidad from inventario where id_producto=producto_detalle and id_bodega=saliente;
    DECLARE cur_inventario_entrante cursor for select cantidad from inventario where id_producto=producto_detalle and id_bodega=entrante;
    
     -- declare NOT FOUND handler
    DECLARE CONTINUE HANDLER 
			FOR NOT FOUND SET finished = 1;
            
	OPEN cur_orden;
    select FOUND_ROWS() into orden_cnt;
    IF orden_cnt=1 THEN
        FETCH cur_orden into estado_orden, tipo_orden, entrante;
        close cur_orden;
        IF estado_orden!='P' then
			select 'No se puede aceptar la orden porque ya está previamente aceptada.'as Mensaje;
		else
			IF tipo_orden!='E' then
				select 'El procedimiento seleccionado solamente funciona en ordenes de transferencia EXTERNA.'as Mensaje;
			else 
				-- ahora actualizamos campos de la orden_transferencia;
				update orden_transferencia set estado='A', bodega_saliente=saliente, bodega_entrante=entrante, fecha_aceptada=LOCALTIME, aceptante=individuo, repartidor=repartidor_id where id_orden=orden_id;
				select * from orden_transferencia where id_orden=orden_id;
				-- SELECT cadena_salida;
			end if;
        end if;
    ELSE
		select 'No se encontró ninguna orden con esa clave.'as Mensaje;
    END IF;
    

END //
DELIMITER ;



-- El siguiente procedimiento es para entregar una orden de transferencia EXTERNA
DELIMITER //
CREATE PROCEDURE proc_entregar_orden_externa(in orden_id int, in repartidor_id int)
BEGIN
	DECLARE finished INTEGER DEFAULT 0;
    DECLARE producto_detalle int;
    DECLARE cantidad_detalle int;
    DECLARE estado_orden char(1);
    DECLARE tipo_orden char(1);
    DECLARE cantidad_inventario int;
    DECLARE cantidad_inventario_entrante int;
    DECLARE orden_cnt int;
    DECLARE inventario_cnt int;
    DECLARE inventario_entrante_cnt int;
    DECLARE bandera int default 0;
    DECLARE cadena_salida varchar(500) default '';
    DECLARE entrante int;
    DECLARE saliente int;
    DECLARE tmp_repartidor int;
    
    -- CURSORES
    DECLARE cur_detalle_orden cursor for select id_producto, cantidad from detalle_orden where id_orden=orden_id;
    DECLARE cur_detalle_orden2 cursor for select id_producto, cantidad from detalle_orden where id_orden=orden_id;
    DECLARE cur_orden cursor for select estado, tipo_orden, bodega_entrante, bodega_saliente, repartidor from orden_transferencia where id_orden=orden_id;
    DECLARE cur_inventario cursor for select cantidad from inventario where id_producto=producto_detalle and id_bodega=saliente;
    DECLARE cur_inventario_entrante cursor for select cantidad from inventario where id_producto=producto_detalle and id_bodega=entrante;
    
     -- declare NOT FOUND handler
    DECLARE CONTINUE HANDLER 
			FOR NOT FOUND SET finished = 1;
            
	OPEN cur_orden;
    select FOUND_ROWS() into orden_cnt;
    IF orden_cnt=1 THEN
		-- AHORA VALIDAMOS que orden.tipo='i' && orden.estado='P'
        FETCH cur_orden into estado_orden, tipo_orden, entrante, saliente, tmp_repartidor;
        close cur_orden;
        IF tmp_repartidor=repartidor_id then
			IF estado_orden!='A' then
				select 'Para entregar una orden de transferencia externa la orden debe de tener estado Aceptada.'as Mensaje;
			else
				IF tipo_orden!='E' then
					select 'El procedimiento seleccionado solamente funciona en ordenes de transferencia EXTERNA.'as Mensaje;
				else 
					open cur_detalle_orden;
					getDetalle: LOOP
						FETCH cur_detalle_orden into producto_detalle, cantidad_detalle;
						IF finished = 1 THEN 
							LEAVE getDetalle;
						END IF;
						-- validar que la bodega saliente tenga la capacidad de darme todos los productos que he detallado
						OPEN cur_inventario;
						select FOUND_ROWS() into inventario_cnt;
						if inventario_cnt=1 then
							FETCH cur_inventario into cantidad_inventario;
							close cur_inventario;
							if cantidad_inventario<cantidad_detalle then
								set bandera=bandera+1;
								LEAVE getDetalle;
							end if;
						else 	
							close cur_inventario;
							set bandera=bandera+1;
							LEAVE getDetalle;
						END IF;
					END LOOP getDetalle;
					close cur_detalle_orden;
					set finished=0;
					
					if bandera=0 then
						open cur_detalle_orden2;
						updateInventario: LOOP
							FETCH cur_detalle_orden2 into producto_detalle, cantidad_detalle;
							IF finished = 1 THEN 
								LEAVE updateInventario;
							END IF;
							-- ahora si vamos a mover las chivas. 
							Open cur_inventario_entrante;
							select FOUND_ROWS() into inventario_entrante_cnt;
							if inventario_entrante_cnt=1 then
								-- ya tiene el producto en su inventario
								FETCH cur_inventario_entrante into cantidad_inventario_entrante;
								close cur_inventario_entrante;
								set cadena_salida=concat(cadena_salida,cantidad_inventario_entrante,' + ', cantidad_detalle,'\n' );
								update inventario set cantidad=cantidad_inventario_entrante+cantidad_detalle where id_producto=producto_detalle and id_bodega=entrante;
								
								update inventario set cantidad=cantidad-cantidad_detalle where id_producto=producto_detalle and id_bodega=saliente; -- actualizamos la saliente
							else
								close cur_inventario_entrante;
								-- no tiene el producto en su inventario
								INSERT INTO inventario(id_producto, id_bodega, cantidad)
								VALUES (producto_detalle, entrante, cantidad_detalle);
								set cadena_salida=concat(cadena_salida, '0',' + ', cantidad_detalle,'\n' );
								update inventario set cantidad=cantidad-cantidad_detalle where id_producto=producto_detalle and id_bodega=saliente; -- actualizamos la saliente
							end if;
						END LOOP updateInventario;
						close cur_detalle_orden2;
						
						-- ahora actualizamos campos de la orden_transferencia;
						update orden_transferencia set estado='E', fecha_entrega=LOCALTIME where id_orden=orden_id;
						select * from orden_transferencia where id_orden=orden_id;
						-- SELECT cadena_salida;
					else
						select 'La bodega saliente seleccionada no cuenta con los productos seleccionados'as Mensaje;
					end if;
				end if;
			end if;
        else
			SELECT 'ERROR, unicamente el repartidor asignado puede realizar la entrega de la orden de transferencia.'as Mensaje;
		END IF;
	ELSE
		select 'No se encontró ninguna orden con esa clave.'as Mensaje;
    END IF;
END //
DELIMITER ;







-- instrucciones para resetear call proc_aceptar_orden_externa (12, 6, 3, 18);
update orden_transferencia set estado='P', bodega_saliente=null, fecha_aceptada=null, aceptante=null, repartidor=null where id_orden=12;

update inventario set cantidad=400 where id_producto=1 and id_bodega=1;

update inventario set cantidad=100 where id_producto=1 and id_bodega=6;

update inventario set cantidad=150 where id_producto=2 and id_bodega=1;

update inventario set cantidad=400 where id_producto=2 and id_bodega=6;


-- instrucciones para resetear la prueba: call proc_aceptar_orden_interna (1, 2, 1, 8);
update orden_transferencia set estado='P', bodega_saliente=null, bodega_entrante=null, fecha_aceptada=null, aceptante=null where id_orden=1;

delete from inventario where id_bodega=2;

update inventario set cantidad=600 where id_producto=1 and id_bodega=1;

update inventario set cantidad=200 where id_producto=2 and id_bodega=1;












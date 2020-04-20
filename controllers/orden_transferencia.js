const db_api = require('../db_apis/orden_transferencia');


async function post(req, res, next) {
    try {
        let context = {};
        context.id_solicitante = parseInt(req.body.id_solicitante,10);
        context.contenido_descripcion = req.body.contenido_descripcion;

        // para transferencia externa:
        context.bodega_entrante = parseInt(req.body.bodega_entrante,10); // es la bodega a la que vamos a agregar productos, desde la cual estan solicitando insumos.
        context.sede_destino = parseInt(req.body.sede_destino,10); // es la sede a la que le estamos solicitando productos.

        if(req.body.id_solicitante && req.body.contenido_descripcion && req.body.bodega_entrante && req.body.sede_destino){
            // es ORDEN DE TRANSFERENCIA EXTERNA
            let respuesta = await db_api.create(context);
            if(respuesta === undefined){
                res.status(404).json({mensaje: "No se pudo crear la orden de transferencia externa."});
            }else{
                res.status(201).json(respuesta);
            }
        }else if(req.body.id_solicitante && req.body.contenido_descripcion){
            // es ORDEN DE TRANSFERENCIA INTERNA
            let respuesta = await db_api.create(context);
            if(respuesta === undefined){
                res.status(404).json({mensaje: "No se pudo crear la orden de transferencia interna."});
            }else{
                res.status(201).json(respuesta);
            }
        }else{
            console.log("Missing parammeters");
            res.status(404).end();
        }
    } catch (err) {
        next(err);
    }
}
  
module.exports.post = post;


async function get(req, res, next){
    try{
        const context = {}; //objeto generico que contendra las propiedades que son relevantes para el metodo de busqueda de la bd api
        context.id_orden = parseInt(req.params.id_orden, 10);
        context.sede_destino = parseInt(req.params.sede_destino, 10);
        const rows = await db_api.listar(context);
        if (req.params.id_orden) {
            if (rows.length === 1) {
                res.status(200).json(rows[0]);
            } else {
                res.status(404).end();
            }
        } else {
            res.status(200).json(rows);
        }
    }catch(error){
        next(error);
    }
}

module.exports.get = get;




async function put(req, res, next){
    try{
        const context = {}; //objeto generico que contendra las propiedades que son relevantes para el metodo de busqueda de la bd api
        // INTERNA
        context.id_orden = parseInt(req.params.id_orden, 10);
        context.entrante=parseInt(req.body.entrante, 10);
        context.saliente=parseInt(req.body.saliente, 10);
        context.individuo=parseInt(req.body.individuo, 10);

        // EXTERNA
        context.repartidor_id=parseInt(req.body.repartidor_id,10);
        if(req.params.id_orden && req.body.entrante && req.body.saliente && req.body.individuo 
            || req.params.id_orden && req.body.repartidor_id && req.body.saliente && req.body.individuo
            || req.params.id_orden && req.body.repartidor_id){ // esta expresion es para cuando un repartidor quiere marcar como entregada una orden.
            const rows = await db_api.update(context);
            if (rows !== null) {
                res.status(200).json(rows);
            } else {
                res.status(404).end();
            }
        }else{
            console.log("Missing Params");
            res.status(404).end();
        }
    }catch(error){
        next(error);
    }
}

module.exports.put = put;






async function del(req, res, next) {
    try {
      const id = parseInt(req.params.id, 10);
  
      const success = await employees.delete(id);
  
      if (success) {
        res.status(204).end();
      } else {
        res.status(404).end();
      }
    } catch (err) {
      next(err);
    }
  }
  
  module.exports.delete = del;
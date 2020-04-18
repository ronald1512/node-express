const db_api = require('../db_apis/venta');


async function post(req, res, next) {
    try {
        let context = {};
        context.id_cliente = parseInt(req.body.id_cliente,10);
        context.vendedor = parseInt(req.body.vendedor,10);
        context.repartidor = parseInt(req.body.repartidor,10);

        if(req.body.id_cliente && req.body.vendedor && req.body.repartidor){
            // es A DOMICILIO
            let respuesta = await db_api.create(context);
            if(respuesta === undefined){
                res.status(404).json({mensaje: "No se pudo crear la venta."});
            }else{
                //context.id_venta=respuesta.insertId;
                res.status(201).json(respuesta);
            }
        }else if(req.body.id_cliente && req.body.vendedor){
            // es LOCAL
            let respuesta = await db_api.create(context);
            if(respuesta === undefined){
                res.status(404).json({mensaje: "No se pudo crear la venta."});
            }else{
                //context.id_cliente=respuesta.insertId;
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
        context.id_venta = parseInt(req.params.id_venta, 10);
        context.vendedor = parseInt(req.params.vendedor, 10);
        //TODO: -> order by day, week, month w/ salesman
        //TODO: -> order by day, week, month w/out salesman
        const rows = await db_api.listar(context);
        if (req.params.id_venta) {
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
        context.id_venta = parseInt(req.params.id_venta, 10);
        // console.log(context);
        const rows = await db_api.update(context);
        if (rows !== null) {
            res.status(200).json(rows);
        } else {
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
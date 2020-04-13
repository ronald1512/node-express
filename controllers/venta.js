const db_api = require('../db_apis/venta');


async function post(req, res, next) {
    try {
        let context = {};
        context.id_cliente = req.body.nombre;
        context.vendedor = req.body.nit;
        context.fecha_facturacion = req.body.dpi;
        context.subtotal = req.body.direccion;
        context.descuento = parseInt(req.body.id_sede,10);
        context.cargo = parseInt(req.body.id_sede,10);
        context.estado = parseInt(req.body.id_sede,10);
        context.repartidor = parseInt(req.body.id_sede,10);
        context.fecha_entrega = parseInt(req.body.id_sede,10);

        if(req.body.nombre && req.body.nit && req.body.dpi && req.body.direccion && req.body.id_sede){
            let respuesta = await db_api.create(context);
            if(respuesta === undefined){
                res.status(404).json({mensaje: "No se pudo crear el cliente."});
            }else{
                context.id_cliente=respuesta.insertId;
                res.status(201).json(context);
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
        context.id_cliente = parseInt(req.params.id_cliente, 10);
        const rows = await db_api.listar(context);
        if (req.params.id_cliente) {
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
        context.id_cliente = parseInt(req.params.id_cliente, 10);
        context.nombre = req.body.nombre;
        context.nit = req.body.nit;
        context.dpi = req.body.dpi;
        context.direccion = req.body.direccion;
        context.id_sede = parseInt(req.body.id_sede,10);
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
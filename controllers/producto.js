const db_api = require('../db_apis/producto');


async function post(req, res, next) {
    try {
        let context = {};
        context.nombre = req.body.nombre;
        //el codigo de barras mejor se lo ponemos segun su codigo de producto, con Jsbarcode.
        context.descripcion = req.body.descripcion;
        context.precio = parseFloat(req.body.precio);

        if(req.body.nombre && req.body.descripcion && req.body.precio){
            let respuesta = await db_api.create(context);
            if(respuesta === undefined){
                res.status(404).json({mensaje: "No se pudo crear el producto."});
            }else{
                context.id_producto=respuesta.insertId;
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
        context.id_producto = parseInt(req.params.id_producto, 10);
        const rows = await db_api.listar(context);
        if (req.params.id_producto) {
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
        context.id_producto = parseInt(req.params.id_producto, 10);
        context.nombre = req.body.nombre;
        context.descripcion = req.body.descripcion;
        context.precio = parseFloat(req.body.precio);
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
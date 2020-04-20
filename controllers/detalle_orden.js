const db_api = require('../db_apis/detalle_orden');

async function post(req, res, next) {
    try {
        let context = {};
        context.id_producto= parseInt(req.body.id_producto,10);
        context.id_orden= parseInt(req.body.id_orden,10);
        context.cantidad= parseInt(req.body.cantidad,10);

        //console.log(context);
        if(req.body.id_producto && req.body.id_orden && req.body.cantidad){
            let respuesta = await db_api.create(context);
            if(respuesta === undefined){
                res.status(404).json({mensaje: "El producto ya fue agregado en la orden."});
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
        context.id_producto = parseInt(req.params.id_producto, 10);
        const rows = await db_api.listar(context);
        if (req.params.id_producto && req.params.id_orden) {
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


async function get2(req, res, next){
    try{
        const context = {}; //objeto generico que contendra las propiedades que son relevantes para el metodo de busqueda de la bd api
        context.id_producto = parseInt(req.params.id_producto, 10);
        const rows = await db_api.listar(context);
        res.status(200).json(rows);
    }catch(error){
        next(error);
    }
}

module.exports.get2 = get2;
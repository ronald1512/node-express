const db_api = require('../db_apis/detalle_venta');

async function post(req, res, next) {
    try {
        let context = {};
        context.id_producto= parseInt(req.body.id_producto,10);
        context.id_bodega= parseInt(req.body.id_bodega,10);
        context.id_venta= parseInt(req.body.id_venta,10);
        context.cantidad= parseInt(req.body.cantidad,10);
        context.descuento_unitario= parseFloat(req.body.descuento_unitario);

        //console.log(context);
        let respuesta = await db_api.create(context);
        if(respuesta === undefined){
            res.status(404).json({mensaje: "Lo solicitado ya fue detallado anteriormente."});
        }else{
            res.status(201).json(context);
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


async function get2(req, res, next){
    try{
        const context = {}; //objeto generico que contendra las propiedades que son relevantes para el metodo de busqueda de la bd api
        context.id_rol = parseInt(req.params.id_rol, 10);
        const rows = await db_api.listar(context);
        res.status(200).json(rows);
    }catch(error){
        next(error);
    }
}

module.exports.get2 = get2;
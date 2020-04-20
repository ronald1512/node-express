const db_api = require('../db_apis/autorizacion');

async function post(req, res, next) {
    try {
        let context = {};
        context.id_usuario = parseInt(req.body.id_usuario, 10);
        context.id_permiso = parseInt(req.body.id_permiso, 10);

        if(req.body.id_permiso && req.body.id_usuario){
            context = await db_api.create(context);
            res.status(201).json(context);
        }else{
            res.status(404).json({mensaje: "Missing parammeters"});
        }
    } catch (err) {
        next(err);
    }
}
  
module.exports.post = post;


async function get(req, res, next){
    try{
        let context = {}; //objeto generico que contendra las propiedades que son relevantes para el metodo de busqueda de la bd api
        context.id_usuario = parseInt(req.params.id_usuario, 10);
        context.id_permiso = parseInt(req.params.id_permiso, 10);
        const rows = await db_api.listar(context);
        if (req.params.id_usuario && req.params.id_permiso) {
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
        let context = {}; //objeto generico que contendra las propiedades que son relevantes para el metodo de busqueda de la bd api
        context.id_permiso = parseInt(req.params.id_permiso, 10);
        const rows = await db_api.listar(context);
        res.status(200).json(rows);
    }catch(error){
        next(error);
    }
}

module.exports.get2 = get2;


async function del(req, res, next) {
    try {
        let context = {};
        context.id_usuario = parseInt(req.params.id_usuario, 10);
        context.id_permiso = parseInt(req.params.id_permiso, 10);
        if(req.params.id_permiso && req.params.id_usuario){
            const success = await db_api.delete(context);
            if (success) {
                res.status(204).end();
            } else {
                res.status(404).end();
            }
        }else{
            console.log('Missing Parammeters');
            res.status(404).end();
        }
    } catch (err) {
      next(err);
    }
  }
  
  module.exports.delete = del;
const db_api = require('../db_apis/usuario');


async function post(req, res, next) {
    try {
        let context = {};
        context.dpi = req.body.dpi;
        context.nombre = req.body.nombre;
        context.fecha_nacimiento = req.body.fecha_nacimiento;
        context.correo = req.body.correo;
        context.contraseña = req.body.contraseña;
        context.id_sede = req.body.id_sede;
        if((context.id_sede instanceof String)){
            if ( (context.id_sede.trim() === '') || (context.id_sede.trim().toUpperCase() === 'NULL') ) {
                context.id_sede = null;
            }
        }
        if(req.body.dpi && req.body.nombre && req.body.fecha_nacimiento && req.body.correo && req.body.contraseña){
            let respuesta = await db_api.create(context);
            if(respuesta === undefined){
                res.status(409).json({mensaje: "DPI y correo deben ser distintos para cada usuario"});
            }else{
                context.id_usuario=respuesta.insertId;
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
        context.id_usuario = parseInt(req.params.id_usuario, 10);
        const rows = await db_api.listar(context);
        if (req.params.id_usuario) {
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
        context.id_usuario = parseInt(req.params.id_usuario, 10);
        context.dpi = req.body.dpi;
        context.nombre = req.body.nombre;
        context.fecha_nacimiento = req.body.fecha_nacimiento;
        context.correo = req.body.correo;
        context.contraseña = req.body.contraseña;
        context.id_sede = req.body.id_sede;
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
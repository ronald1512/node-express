const db_api = require('../db_apis/auth');

async function post(req, res, next) {
    try {
        let context = {};
        context.correo = req.body.correo;
        context.contraseña = req.body.contraseña;
        
        if(req.body.correo && req.body.contraseña){
            let respuesta = await db_api.create(context);
            //console.log(respuesta);
            if(respuesta.length != 1){
                res.status(409).json({mensaje: "No hay ningun usuario con esas credenciales"});
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

async function post2(req, res, next) {
    try {
        let context = {};
        context.correo = req.body.correo;
        
        if(req.body.correo){
            let respuesta = await db_api.create2(context);
            //console.log(respuesta);
            if(respuesta.length != 1){
                res.status(409).json({mensaje: "No hay ningun usuario con ese correo"});
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
  
module.exports.post2 = post2;
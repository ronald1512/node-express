const db_api = require('../db_apis/bodega');


async function post(req, res, next) {
    try {
        let context = {};
        context.nombre = req.body.nombre;
        context.direccion = req.body.direccion;
        context.encargado = parseInt(req.body.encargado, 10);
        context.id_sede = parseInt(req.body.id_sede, 10);

        if (req.body.nombre && req.body.direccion && req.body.id_sede && req.body.encargado) {
            let respuesta = await db_api.create(context);
            if (respuesta === undefined) {
                res.status(404).json({ mensaje: "Un encargado de bodega puede estar a cargo solo de una bodega a la vez." });
            } else {
                context.id_bodega = respuesta.insertId;
                res.status(201).json(context);
            }
        } else {
            //console.log("Missing parammeters");
            res.status(404).json({ mensaje: "Missing parammeters" });
        }
    } catch (err) {
        next(err);
    }
}

module.exports.post = post;


async function get(req, res, next) {
    try {
        const context = {}; //objeto generico que contendra las propiedades que son relevantes para el metodo de busqueda de la bd api
        context.id_bodega = parseInt(req.params.id_bodega, 10);
        const rows = await db_api.listar(context);
        if (req.params.id_bodega) {
            if (rows.length === 1) {
                res.status(200).json(rows[0]);
            } else {
                res.status(404).end();
            }
        } else {
            res.status(200).json(rows);
        }
    } catch (error) {
        next(error);
    }
}

module.exports.get = get;




async function put(req, res, next) {
    try {
        const context = {}; //objeto generico que contendra las propiedades que son relevantes para el metodo de busqueda de la bd api
        context.id_bodega = parseInt(req.params.id_bodega, 10);
        context.nombre = req.body.nombre;
        context.direccion = req.body.direccion;
        context.estado = req.body.estado;
        context.id_sede = parseInt(req.body.id_sede, 10);
        context.encargado = parseInt(req.body.encargado, 10);
        const rows = await db_api.update(context);
        if (rows !== null) {
            res.status(200).json(rows);
        } else {
            res.status(404).end();
        }
    } catch (error) {
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





async function getBodegas2(req, res, next) {
    try {
        const context = {}; //objeto generico que contendra las propiedades que son relevantes para el metodo de busqueda de la bd
        context.id_sede = parseInt(req.params.id_sede, 10);
        const rows = await db_api.listar2(context);

        res.status(200).json(rows);


    } catch (error) {
        next(error);
    }
}

module.exports.getBodegas2 = getBodegas2;
const db_api = require('../db_apis/usuario-rol');

async function post(req, res, next) {
    try {
        let context = req.body;
        //console.log(context);
        let respuesta = await db_api.create(context);
        if (respuesta === undefined) {
            res.status(404).json({ mensaje: "Ya se ha asignado ese rol anteriormente." });
        } else {
            res.status(201).json(context);
        }
    } catch (err) {
        next(err);
    }
}

module.exports.post = post;


async function get(req, res, next) {
    try {
        const context = {}; //objeto generico que contendra las propiedades que son relevantes para el metodo de busqueda de la bd api
        context.id_usuario = parseInt(req.params.id_usuario, 10);
        context.id_rol = parseInt(req.params.id_rol, 10);
        const rows = await db_api.listar(context);
        if (req.params.id_usuario && req.params.id_rol) {
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


async function get2(req, res, next) {
    try {
        const context = {}; //objeto generico que contendra las propiedades que son relevantes para el metodo de busqueda de la bd api
        context.id_rol = parseInt(req.params.id_rol, 10);
        const rows = await db_api.listar(context);
        res.status(200).json(rows);
    } catch (error) {
        next(error);
    }
}

module.exports.get2 = get2;






async function getRepartidores(req, res, next) {
    try {
        const context = {}; //objeto generico que contendra las propiedades que son relevantes para el metodo de busqueda de la bd api
        const rows = await db_api.listarRepartidores(context);


        res.status(200).json(rows);


    } catch (error) {
        next(error);
    }
}

module.exports.getRepartidores = getRepartidores;




async function getVendedores(req, res, next) {
    try {
        const context = {}; //objeto generico que contendra las propiedades que son relevantes para el metodo de busqueda de la bd api
        const rows = await db_api.listarVendedores(context);


        res.status(200).json(rows);


    } catch (error) {
        next(error);
    }
}

module.exports.getVendedores = getVendedores;
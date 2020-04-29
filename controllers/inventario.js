const db_api = require('../db_apis/inventario');

//este post va a agregar a la entidad 'inventario' y a 'log_inventario'
async function post(req, res, next) {
    try {
        let context = {};
        context.id_producto = parseInt(req.body.id_producto, 10);
        context.id_bodega = parseInt(req.body.id_bodega, 10);
        context.cantidad_nueva = parseInt(req.body.cantidad_nueva, 10);
        context.motivo = req.body.motivo;
        context.encargado = parseInt(req.body.encargado, 10); //este el el id de quien va a modificar el inventario

        if (req.body.id_producto && req.body.id_bodega && req.body.cantidad_nueva && req.body.motivo && req.body.encargado) {
            let respuesta = await db_api.create(context);
            if (respuesta === undefined) {
                res.status(409).json({ mensaje: "No se pudo actualizar el inventario." });
            } else {
                //context.id_sede=respuesta.insertId;
                res.status(201).json(respuesta);
            }
        } else {
            console.log("Missing parammeters");
            res.status(404).end();
        }
    } catch (err) {
        next(err);
    }
}

module.exports.post = post;


async function get(req, res, next) {
    try {
        const context = {}; //objeto generico que contendra las propiedades que son relevantes para el metodo de busqueda de la bd api
        context.id_producto = parseInt(req.params.id_producto, 10);
        context.id_bodega = parseInt(req.params.id_bodega, 10);
        const rows = await db_api.listar(context);
        if (req.params.id_producto && req.params.id_bodega) {
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



//aqui en put, va a modificar un registro de  'inventario' y tambien insertar en 'log_inventario'
async function put(req, res, next) {
    try {
        const context = {}; //objeto generico que contendra las propiedades que son relevantes para el metodo de busqueda de la bd api

        context.id_producto = parseInt(req.params.id_producto, 10);
        context.id_bodega = parseInt(req.params.id_bodega, 10);
        context.cantidad_nueva = parseInt(req.body.cantidad_nueva, 10);
        context.motivo = req.body.motivo;
        context.encargado = parseInt(req.body.encargado, 10); //este el el id de quien va a modificar el inventario

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




async function obtenerProductos(req, res, next) {
    try {
        const context = {}; //objeto generico que contendra las propiedades que son relevantes para el metodo de busqueda de la bd api
        context.id_bodega = parseInt(req.params.id_bodega, 10);

        const rows = await db_api.listarProductos(context);

        res.status(200).json(rows);

    } catch (error) {
        next(error);
    }
}

module.exports.obtenerProductos = obtenerProductos;


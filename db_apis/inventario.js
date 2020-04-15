const database = require('../services/database');

async function listar(context) {
    let query = "SELECT * FROM inventario ";
    const binds = [];

    if (context.id_producto && context.id_bodega) {
        binds.push(context.id_producto);
        binds.push(context.id_bodega);

        query += " WHERE id_producto=? AND id_bodega=?";
    } else if (context.id_producto) {
        binds.push(context.id_producto);

        query += " WHERE id_producto=?";
    } else if (context.id_bodega) {
        binds.push(context.id_bodega);

        query += " WHERE  id_bodega=?";
    }
    const result = await database.executeQuery(query, binds);
    return result;
}

module.exports.listar = listar;


async function create(context) {
    let query = "call proc_inventario_n_log(?,?,?,?,?)";
    let binds = [];

    binds.push(context.id_producto);
    binds.push(context.id_bodega);
    binds.push(context.cantidad_nueva);
    binds.push(context.motivo);
    binds.push(context.encargado);
    const result = await database.executeQuery(query, binds);
    return result;
}


module.exports.create = create;


async function update(context) {
    let query = "call proc_inventario_n_log(?,?,?,?,?)";
    let binds = [];

    binds.push(context.id_producto);
    binds.push(context.id_bodega);
    binds.push(context.cantidad_nueva);
    binds.push(context.motivo);
    binds.push(context.encargado);
    const result = await database.executeQuery(query, binds);
    return result;
}


module.exports.update = update;



async function del(id) {
    const binds = {
        employee_id: id,
        rowcount: {
            dir: oracledb.BIND_OUT,
            type: oracledb.NUMBER
        }
    }
    const result = await database.simpleExecute(deleteSql, binds);

    return result.outBinds.rowcount === 1;
}

module.exports.delete = del;





async function listarProductos(context) {
    let query = "SELECT I.id_producto,I.id_bodega,(SELECT nombre from producto where " +
        "id_producto=I.id_producto) as nombre_producto FROM inventario I ";
    const binds = [];


    binds.push(context.id_bodega);

    query += " WHERE  I.id_bodega=?";

    const result = await database.executeQuery(query, binds);
    return result;
}

module.exports.listarProductos = listarProductos;
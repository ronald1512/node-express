const database = require('../services/database');

async function listar(context){
    let query  = "SELECT * FROM log_inventario ";
    const binds = [];

    if (context.id_producto && context.id_bodega) {//verifica si context tiene el atributo id
        binds.push(context.id_producto);
        binds.push(context.id_bodega);

        query += " WHERE id_producto=? AND id_bodega=?";
    }else if(context.id_bodega){
        binds.push(context.id_bodega);
        query += " WHERE id_bodega=?";
    }else if(context.id_producto){
        binds.push(context.id_producto);
        query += " WHERE id_producto=?";
    }
    const result = await database.executeQuery(query, binds);
    return result;
}



module.exports.listar = listar;
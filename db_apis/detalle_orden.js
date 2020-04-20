const database = require('../services/database');

async function listar(context){
    let query  = "SELECT * FROM detalle_orden ";
    const binds = [];

    if (context.id_producto && context.id_orden) {//verifica si context tiene el atributo id
        binds.push(context.id_producto);
        binds.push(context.id_orden);

        query += " WHERE id_producto=? AND id_orden=?";
    }else if(context.id_producto){
        binds.push(context.id_producto);

        query += " WHERE id_producto=?";
    }
    else if(context.id_orden){
        binds.push(context.id_orden);

        query += " WHERE id_orden=?";
    }
    const result = await database.executeQuery(query, binds);
    return result;
}



async function create(context){
    //ese proc agrega los roles para un determinado usuario y tambien le agrega los permisos.
    let query= "INSERT INTO detalle_orden(id_producto, id_orden, cantidad) VALUES (?, ?, ?) ";
    const binds = [];

    binds.push(context.id_producto);
    binds.push(context.id_orden);
    binds.push(context.cantidad);

    const result = await database.executeQuery(query, binds);
    return result;
}



module.exports.listar = listar;
module.exports.create = create;



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
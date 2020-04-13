const database = require('../services/database');

async function listar(context){
    let query  = "SELECT * FROM detalle_producto ";
    const binds = [];

    if (context.id_producto && context.id_categoria) {//verifica si context tiene el atributo id
        binds.push(context.id_producto);
        binds.push(context.id_categoria);

        query += " WHERE id_producto=? AND id_categoria=?";
    }else if(context.id_producto){
        binds.push(context.id_producto);

        query += " WHERE id_producto=?";
    }
    else if(context.id_categoria){
        binds.push(context.id_categoria);

        query += " WHERE id_categoria=?";
    }
    const result = await database.executeQuery(query, binds);
    return result;
}



async function create(context){
    //ese proc agrega los roles para un determinado usuario y tambien le agrega los permisos.
    let query= "INSERT INTO detalle_producto(id_producto, id_categoria) VALUES (?,?) ";
    const binds = [];

    binds.push(context.id_producto);
    binds.push(context.id_categoria);

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
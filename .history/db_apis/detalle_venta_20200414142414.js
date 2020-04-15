const database = require('../services/database');

async function listar(context){
    let query  = "SELECT * FROM detalle_venta ";
    const binds = [];

    if(context.id_venta){|
        binds.push(context.id_venta);

        query += " WHERE id_venta=?";
    }
    const result = await database.executeQuery(query, binds);
    return result;
}



async function create(context){
    //ese proc agrega los roles para un determinado usuario y tambien le agrega los permisos.
    let query= "call proc_add_detalle_venta_n_update_venta(?,?,?,?,?)";
    const binds = [];

    binds.push(context.id_producto);
    binds.push(context.id_bodega);
    binds.push(context.id_venta);
    binds.push(context.cantidad);
    binds.push(context.descuento_unitario);

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
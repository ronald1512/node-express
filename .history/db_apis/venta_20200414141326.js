const database = require('../services/database');

async function listar(context){
    let query= "SELECT * FROM venta ";
    const binds = [];

    if(context.id_venta){
        binds.push(context.id_venta);
        query += " WHERE id_venta=?";
    }
    if(context.vendedor){
        binds.push(context.vendedor);
        query += " WHERE vendedor=?";
    }
    //TODO: -> order by day, week, month w/ salesman
    //TODO: -> order by day, week, month w/out salesman
    const result = await database.executeQuery(query, binds);
    return result;
}

module.exports.listar = listar;


async function create(context){
    let query;
    let binds = [];
    binds.push(context.id_cliente);
    binds.push(context.vendedor);

    if(context.repartidor){
      query= "call proc_venta_domicilio(?,?,?)";
      binds.push(context.repartidor);
    }else{
      query= "call proc_venta_local(?,?)";
    }

    const result = await database.executeQuery(query, binds);
    return result;
}


module.exports.create = create;

async function update(context){
  let query= "UPDATE cliente SET nombre=?, nit=?, dpi=?, direccion=?, id_sede=? WHERE id_cliente=?";
  let binds = [];

  binds.push(context.nombre);
  binds.push(context.nit);
  binds.push(context.dpi);
  binds.push(context.direccion);
  binds.push(context.id_sede);
  binds.push(context.id_cliente);
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
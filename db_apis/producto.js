const database = require('../services/database');

async function listar(context){
    let query  = "SELECT * FROM producto ";
    const binds = [];

    if(context.id_producto){
        binds.push(context.id_producto);

        query += " WHERE id_producto=?";
    }
    const result = await database.executeQuery(query, binds);
    return result;
}

module.exports.listar = listar;


async function create(context){
    let query= "INSERT INTO producto (nombre, descripcion, precio) VALUES (?,?,?)";
    let binds = [];

    binds.push(context.nombre);
    binds.push(context.descripcion);
    binds.push(context.precio);
    const result = await database.executeQuery(query, binds);
    return result;
}


module.exports.create = create;

async function update(context){
  let query= "UPDATE producto SET nombre=?, descripcion=?, precio=? WHERE id_producto=?";
  let binds = [];

  binds.push(context.nombre);
  binds.push(context.descripcion);
  binds.push(context.precio);
  binds.push(context.id_producto);
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
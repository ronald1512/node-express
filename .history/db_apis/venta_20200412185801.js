const database = require('../services/database');

async function listar(context){
    let query  = "SELECT * FROM cliente ";
    const binds = [];

    if(context.id_cliente){
        binds.push(context.id_cliente);

        query += " WHERE id_cliente=?";
    }
    const result = await database.executeQuery(query, binds);
    return result;
}

module.exports.listar = listar;


async function create(context){
    let query= "INSERT INTO cliente (nombre, nit, dpi, direccion, id_sede) VALUES (?,?,?,?,?)";
    let binds = [];

    binds.push(context.nombre);
    binds.push(context.nit);
    binds.push(context.dpi);
    binds.push(context.direccion);
    binds.push(context.id_sede);
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
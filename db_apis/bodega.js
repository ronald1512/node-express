const database = require('../services/database');

async function listar(context){
    let query  = "SELECT * FROM bodega ";
    const binds = [];

    if(context.id_bodega){
        binds.push(context.id_bodega);

        query += " WHERE id_bodega=?";
    }
    const result = await database.executeQuery(query, binds);
    return result;
}

module.exports.listar = listar;


async function create(context){
  //hace falta validar que el 'encargado' tenga rol 'Encargado de bodega'. 
    let query= "INSERT INTO bodega (nombre, direccion, encargado, id_sede) VALUES (?,?,?,?)"; //no le agrego la columna 'estado' porque ya tiene por defecto Enabled
    let binds = [];

    binds.push(context.nombre);
    binds.push(context.direccion);
    binds.push(context.encargado);
    binds.push(context.id_sede);
    const result = await database.executeQuery(query, binds);
    return result;
}


module.exports.create = create;

async function update(context){
  let query= "UPDATE bodega SET nombre=?, direccion=?, estado=?, id_sede=?, encargado=? WHERE id_bodega=?";
  let binds = [];

  binds.push(context.nombre);
  binds.push(context.direccion);
  binds.push(context.estado);
  binds.push(context.id_sede);
  binds.push(context.encargado);
  binds.push(context.id_bodega);
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
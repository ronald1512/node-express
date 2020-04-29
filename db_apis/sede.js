const database = require('../services/database');

async function listar(context){
    let query  = "SELECT id_sede, alias, direccion, id_mun, encargado, (SELECT nombre FROM usuario WHERE id_usuario = s.encargado) as nombre_encargado, (SELECT nombre FROM municipio WHERE id_mun = s.id_mun) as nombre_mun FROM sede s";
    const binds = [];

    if(context.id_sede){
        binds.push(context.id_sede);

        query += " WHERE id_sede=?";
    }
    const result = await database.executeQuery(query, binds);
    return result;
}

module.exports.listar = listar;


async function create(context){
    let query= "call proc_add_sede_n_mod_encargado(?,?,?,?)";
    let binds = [];

    binds.push(context.alias);
    binds.push(context.direccion);
    binds.push(context.id_mun);
    binds.push(context.encargado);
    const result = await database.executeQuery(query, binds);
    return result;
}


module.exports.create = create;

async function update(context){
  let query= "UPDATE sede SET alias=?, direccion=?, id_mun=?, encargado=? WHERE id_sede=?";
  let binds = [];
  
  binds.push(context.alias);
  binds.push(context.direccion);
  binds.push(context.id_mun);
  binds.push(context.encargado);
  binds.push(context.id_sede);
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
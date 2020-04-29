const database = require('../services/database');

async function create(context){
    let query= "select * from usuario where correo=? and contraseña=?";
    let binds = [];
  
    binds.push(context.correo);
    binds.push(context.contraseña);
    const result = await database.executeQuery(query, binds);
    return result;
  }
  
  
  module.exports.create = create;


  async function create2(context){
    let query= "select * from usuario where correo=?";
    let binds = [];
  
    binds.push(context.correo);
    const result = await database.executeQuery(query, binds);
    return result;
  }
  
  
  module.exports.create2 = create2;
  
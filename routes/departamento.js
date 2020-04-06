const express = require('express');
const router = new express.Router(); //nueva instancia de la clase express
const departamento = require('../controllers/departamento.js');

router.route('/')
  .post(departamento.post)
  .get(departamento.get)

module.exports = router;
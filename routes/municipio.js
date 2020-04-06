const express = require('express');
const router = new express.Router(); //nueva instancia de la clase express
const municipio = require('../controllers/municipio.js');

router.route('/')
  .post(municipio.post)
  .get(municipio.get)

module.exports = router;
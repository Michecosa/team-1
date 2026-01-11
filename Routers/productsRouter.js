const express = require('express')
const router = express.Router()
const productsControllers = require('../Controllers/productsController')

//index
router.get('/', productsControllers.index);

//show 
router.get('/:id', productsControllers.show);

module.exports = router
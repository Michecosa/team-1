const express = require('express')
const app = express()
const PORT = 3000
const productsRouter = require('./Routers/productsRouter')

//da controllare
app.use(express.json({}))

//uso della cartella public
app.use(express.static('public'))


app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
})

app.get('/', (req,res) => {
    res.send('home page')
})

app.use('/api/products', productsRouter)
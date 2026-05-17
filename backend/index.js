const express = require('express')
const { v4: uuidv4 } = require('uuid')
const { CORS_ORIGIN } = require('./config')

const ID = uuidv4()
const PORT = 5000

const app = express()

app.use(express.json())

// Allows frontend requests through the ALB
app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', CORS_ORIGIN)
    res.setHeader('Access-Control-Allow-Methods', 'GET')
    res.setHeader('Access-Control-Allow-Headers', '*')
    next()
})

// Backend API route used by the frontend
app.get('/api/', (req, res) => {
    console.log(`${new Date().toISOString()} GET /api/`)
    res.json({ id: ID })
})

// Starts the Express backend server
app.listen(PORT, () => {
    console.log(`Backend started on ${PORT}. ctrl+c to exit`)
})
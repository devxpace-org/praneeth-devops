const express = require('express')
const app = express()
const port = 3000

app.get('/', (req, res) => {
  res.send("WELCOME TO PRANEETH'S TEAM APP HOMEPAGE! <br/> <br/>Available pages are: <br/> /chetana <br/> /harshitha <br/> /supriya <br/> /tejaswini <br/> /karthik <br/> /shahab <br/> /raja <br/> /sumanth <br/> /maazin <br/> /haripriya")
})

app.listen(port, () => {
  console.log(`home app listening on port ${port}`)
})
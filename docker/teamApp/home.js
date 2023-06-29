const express = require('express')
const app = express()
const port = 3000

app.get('/', (req, res) => {
  res.send("WELCOME TO PRANEETH'S TEAM APP HOMEPAGE!")
  res.send("")
  res.send("Available pages are:")
  res.send("/chetana")
  res.send("/harshitha")
  res.send("/supriya")
  res.send("/tejaswini")
  res.send("/karthik")
  res.send("/shahab")
  res.send("/raja")
  res.send("/sumanth")
  res.send("/maazin")
  res.send("/haripriya")

})

app.listen(port, () => {
  console.log(`home app listening on port ${port}`)
})
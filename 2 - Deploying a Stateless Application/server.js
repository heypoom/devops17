const http = require("http")

const PORT = 1337

const app = ({url}, res) => {
  console.log(`Incoming Request at ${url}`)
  res.writeHead(200)
  res.end(`Hello, Kubernetes! Current route is ${url}.`)
}

http.createServer(app).listen(PORT, () => {
  console.log(`Starting server at port ${PORT}.`)
})

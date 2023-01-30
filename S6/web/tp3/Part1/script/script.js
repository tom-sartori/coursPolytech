

const http = require('http')
const fs = require('fs')

const data = ["Do You Remember Apple Maps ?",  "May The Force Be With You", "SLEEP IS FOR THE WEAK"]

const server = http.createServer(function (req, res) {
    res.writeHead(200)

    // Get data from template.html
    fs.readFile('../template.html', function (err, data) {
        console.log(data.toString())

        let dataHtml = listToLi(data)
        let html = data.toString().replace('<li>%</li>', dataHtml)

        res.write(html)
        // res.write("Heulo world")
        res.end()
    })


})

server.listen(3000, function () {
    console.log("Server launched. ")
})


function listToLi (data) {
    let result = ''
    for (let elt in data) {
        result += '<li>' + elt + '</li>'
    }
    console.log("test : " + result)
    return result
}





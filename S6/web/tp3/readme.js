// https://tech.io/playgrounds/1064/building-a-basic-todo-list-rest-api-in-node-js-with-express/key-concepts


// Ex1 :

// const http = require('http');
// const port = 9000;
//
// const server = http.createServer((request, response) =>{
//     response.write('Hello World!');
//     response.end('\n'); // end of the response flow.
//     // the two lines can be merged as one:
//     // response.end('Hello, World!\n');
// });
//
// server.listen(port); // listening on 9000
//



// Ex 2 :

const http = require('http');
const port = 9000;

const server = http.createServer((request, response) =>{
    if(request.method === 'GET' ){
        response.end('Hello, World!\n');
    }else{
        // Doc: response.writeHead(statusCode[, statusMessage][, headers])
        response.writeHead(405, 'Method Not Allowed');
        response.end('This URI only support GET method\n');
    }
});

server.listen(port); // listening on 9000

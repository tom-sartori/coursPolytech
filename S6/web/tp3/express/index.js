

// const express = require('express');
// const port = 9000;
// const app = express();
//
// let todos = ['buy the milk', 'rent a car', 'feed the cat'];
//
// app.get('/', (request, response) => response.status(200).json(todos));
//
// app.listen(port);



// Ex POST REST
//
// const express = require('express');
// const bodyParser = require('body-parser');
// const port = 9000;
// const app = express();
//
// var todos = [
//     {id:1, title:'buy the milk'},
//     {id:2, title:'rent a car'}, {id:3, title:'feed the cat'}];
//
// // parse application/x-www-form-urlencoded
// app.use(bodyParser.urlencoded({ extended: false }))
//
// // parse application/json
// app.use(bodyParser.json())
//
// app.get('/', (request, response) => response.status(200).json(todos));
//
// app.post('/', (request, response) => {
//     var newTodo = request.body
//     newTodo.id = todos.length +1;
//     todos.push(newTodo);
//     response.status(201).json(newTodo);
// });
//
// app.listen(port);



// Parameters
//
// const express = require('express');
// const port = 9000;
// const app = express();
// const bodyParser = require('body-parser');
//
// var todos = [{id:1, title:'buy the milk'}, {id:2, title:'rent a car'}, {id:3, title:'feed the cat'}];
//
// app.use(bodyParser.json())
//
// app.get('/', (request, response) => response.status(200).json(todos));
//
// app.post('/', (request, response) => {
//     var newTodo = JSON.parse(request.body);
//     newTodo.id = todos.length + 1;
//     todos.push(newTodo);
//     response.status(201).json();
// });
//
// app.put('/:id', (request, response) => {
//     var id = request.params.id
//     if (todos[id - 1]){
//         todos[id - 1] = request.body;
//         response.status(204).send();
//     }else{
//         response.status(404, 'The task is not found').send();
//     }
// });
//
// app.listen(port);



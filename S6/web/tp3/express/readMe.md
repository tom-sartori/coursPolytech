
```js
const express = require('express')
let app = express()
```

`app.METHOD(PATH, HANDLER)`
- app is an instance of express.
- METHOD is an HTTP request method, in lowercase. 
- PATH is a path on the server.
- HANDLER is the function executed when the route is matched.


Parameters

Express allows to extract parameters from the url. A parameter is defined in an URL with the ":" prefix. It is aviailable as a member of request.params.

`var myParam = request.params.myParam`


EJS
Les % 

`npm install ejs`


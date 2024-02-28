const options = {
    openapi: 'OpenAPI 3',   // Enable/Disable OpenAPI. By default is null
    language: 'en-US',      // Change response language. By default is 'en-US'
    disableLogs: false,     // Enable/Disable logs. By default is false
    autoHeaders: false,     // Enable/Disable automatic headers capture. By default is true
    autoQuery: false,       // Enable/Disable automatic query capture. By default is true
    autoBody: false         // Enable/Disable automatic body capture. By default is true
}

const swaggerAutogen = require('swagger-autogen')();

const doc = {
  info: {
    version: '2.0.0',      // by default: '1.0.0'
    title: 'Query Apis',        // by default: 'REST API'
    description: 'API for Managing queue calls',  // by default: ''
    contact: {
        'name': 'API Support',
        'email': 'noone@mail.com'
    },
  },
  host: "localhost:4000",      // by default: 'localhost:3000'
  tags: [        // by default: empty Array
    {
      name: 'Queue CRUD',         // Tag name
      description: 'Queue related apis',  // Tag description
    },
    {
        name: 'Health',
        description: 'Health Check'
    }
  ],
  securityDefinitions: {},  // by default: empty object
  definitions: {
    helathResponse: {
      code: "200",
      message: "Everything's A-OK",
    },
    'errorResponse.400': {
      code: "400",
      message: "That's a bad request",
    },
    'errorResponse.403': {
      code: "403",
      message: "FORRRRRRRBIDDEEEEEEEEEN",
    },
    'errorResponse.404': {
      "code": "404",
      "message": "Not found",
    },
    'errorResponse.500': {
      code: "500",
      message: "You done messed up A-A-Ron",
    }
  },          // by default: empty object (Swagger 2.0)
};

const outputFile = './docs/swagger.json';
const endpointsFiles = ['./index.js', './controllers/*.js'];

swaggerAutogen(outputFile, endpointsFiles, doc, options);

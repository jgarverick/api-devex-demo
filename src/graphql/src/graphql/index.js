const { ApolloServer, gql } = require('apollo-server-azure-functions');

// Define your type definitions
const typeDefs = gql`
    type Query {
        hello: String
    }
`;

// Define your resolvers
const resolvers = {
    Query: {
        hello: () => 'Hello, world!',
    },
};

// Initialize an Apollo Server instance
const server = new ApolloServer({ typeDefs, resolvers });

exports.graphqlHandler = server.createHandler();
// Initialize an Express application

---
to: packages/<%= packageName %>/package.json
unless_exists: true
---
{
  "name": "<%= packageName %>",
  "private": true,
  "license": "UNLICENSED",
  "version": "0.1.0",
  "engines": {
    "node": "16.x",
    "npm": "8.x"
  },
  "scripts": {
    "build": "tsc",
    "test": "LOG_LEVEL=silent jest --verbose --testPathIgnorePatterns=/test/integration/",
    "test:integration": "LOG_LEVEL=silent jest --verbose --testPathPattern=/test/integration/ --runInBand --passWithNoTests",
    "test:integration:dev": "ENVIRONMENT=dev npm run test:integration",
    "test:integration:stage": "ENVIRONMENT=stage npm run test:integration",
    "clean": "rimraf ./build ./coverage",
    "prepackage": "npm run build && npm prune --production",
    "package": "cp -R ./node_modules ./build || :"
  },
  "dependencies": {
    "@cuckoointernet/logger-node": "0.5.0",
    "aws-sdk": "2.1234.0"
  },
  "devDependencies": {
    "@aws-amplify/api": "4.0.48",
    "@aws-amplify/api-graphql": "2.3.12",
    "@aws-amplify/core": "4.6.1",
    "@aws-sdk/client-appsync": "3.171.0"
  }
}

---
to: packages/<%= packageName %>/README.md
unless_exists: true
---
# 📦  `api`

## Overview

TODO: populate

# 📁 Directory structure
This package adheres to the high level directory structure detailed [here](../../README.md#-directory-structure). Internally it also adopts the following conventions:

```
.
└── src
    ├── core                            (directory containing any shared logic agnostic of API type)
    │   └── get-magic                   (directory containing logic for one type of operation)
    │       ├── <third-party-a>         (Optional directory containing specific logic for one type of operation related to a third party)
    │       │   ├── index.ts            (third party logic application code)
    │       │   └── etc...              
    │       ├── <third-party-b>                  
    │       └── etc...                  
    │   
    ├── graphql                         (directory containing any GraphQL API specific logic)
    │   ├── get-magic                   (directory containing logic for one type of operation)
    │   │   ├── index.ts                (entry-point resolver for operation)
    │   │   ├── <third-party-a>.ts      (third party specific resolver for operation)
    │   │   ├── filter-by.ts            (logic for filtering operation responses)
    │   │   └── order-by.ts             (logic for ordering operation responses)
    │   ├── schema.graphql              (schema for entire graphql service)
    │   └── schema.ts                   (typescript definitions automaticaly generated from schema.graphql)
    │   
    ├── rest                            (directory containing any RESTful API specific logic)
    │   
    ├── ???                             (other directories for API types we support in the future)

```
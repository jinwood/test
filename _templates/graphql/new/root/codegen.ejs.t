---
to: codegen.ts
---

import type { CodegenConfig } from "@graphql-codegen/cli";

const config: CodegenConfig = {
  overwrite: true,
  schema: "./packages/<%= packageName %>/src/graphql/schema.graphql",
  generates: {
    "./packages/<%= packageName %>/src/graphql/schema.ts": {
      plugins: [
        "typescript",
        {
          add: {
            content:
              "/* WARNING: DO NOT EDIT. This file is automatically generated by @graphql-codegen from schema.graphql. It will be overwritten. */",
          },
        },
      ],
    },
  },
};

export default config;
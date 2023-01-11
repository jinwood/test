# ℹ Overview

This is a [template repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template) for Node.js projects. 
It provides a preconfigured common set of tooling and should be the starting point for any new Node.js projects. 
Using this template will save you time and also promote a consistent developer experience across our tech estate.

# ✅ Features

- **[TypeScript](https://www.typescriptlang.org/)** for development
- **[AWS CDK](https://aws.amazon.com/cdk/)** and **[Cuckoo Constructs](https://github.com/cuckoointernet/cuckoo-constructs)** for infrastructure as code
- **[Jest](https://jestjs.io/)** for testing
- **[GitHub Actions](https://github.com/features/actions)** for CICD
- **[Lerna](https://github.com/lerna/lerna)** for monorepo management
- **[XO](https://github.com/xojs/xo)** for linting
- **[Prettier](https://prettier.io/)** for formatting (via XO)
- **[Renovate](https://www.whitesourcesoftware.com/free-developer-tools/renovate/)** for automated dependency updates
- **[Lint-staged](https://github.com/okonet/lint-staged)** to lint files before they're committed
- **[Hygen](https://www.hygen.io/)** for generating new packages with a consistent structure
- **Automated versioning and changelog generation** via [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/)
- **Strict Node & NPM versioning** to match the latest AWS Lambda runtimes
- **Common dev dependencies preinstalled** at root level to avoid duplication across packages
- **PR templates** for consistency

# 🔧 Setup

1. Create a new repository for your project from this template by following [these steps](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template)
2. Substitute placeholder variables in the following files:
   1. `./package.json` [here](https://github.com/cuckoointernet/template-nodejs-project/blob/main/package.json#L2)
   2. `./infra/constants.js` [here](https://github.com/cuckoointernet/template-nodejs-project/blob/main/infra/constants.ts#L1) and [here](https://github.com/cuckoointernet/template-nodejs-project/blob/main/infra/constants.ts#L5)
3. Register your new repository with Renovate via [these steps](https://docs.renovatebot.com/getting-started/installing-onboarding/#hosted-githubcom-app)
4. Familiarise yourself with the structure of the [example package](https://github.com/cuckoointernet/template-nodejs-project/tree/main/packages/example) included as part of this template
5. When you're ready to start building your application, add a new package via `npm run new-cdk-package`

Happy coding! 🙌

# 💻 NPM Scripts
The following scripts are available from the root level of this repository:

 - `install` - install all dependencies across the entire repo
 - `build` - runs the typescript compiler against each monorepo package
 - `clean` - removes all monorepo package dependencies and build files
 - `lint` - runs the linter on the entire repo and automatically fixing errors wherever possible
 - `lint:nofix` - same as `lint` but does not automatically fix errors (faster)*
 - `test` - runs all unit and infrastructure tests
 - `test:integration:dev` - runs all integration tests against the development environment
 - `test:integration:stage` - runs all integration tests against the stage environment
 - `package` - prepares each package for deployment to AWS (removes dev dependencies)*
 - `generate` - initialises a new monorepo package with the standard directory structure from the generator requested
   - Pass arguments `-- "<generator>" "<name>"` to select which template to use. i.e. `npm run generate -- "graphql" "new"`. These match the directory structure under `_templates`. Expect CLI to prompt for further details.
   - Arguments are:
      - `-- "graphql" "new"`
      - `-- "cdk-package" "new"`

&ast; primarily used by CICD

# 💡 Good to Know
Below are some conventions this repository follows that are good to be aware of:

## 🌐 Environments
- This repository is preconfigured and ready to deploy resources into Cuckoos AWS account
- This repository will provision 3 environments for you (dev/stage/prod)
- The development environment is automatically redeployed to whenever a new commit is pushed to an open PR
- This means the development environment is **volatile**. Meaning any push by another dev (or bot) will deploy over your changes
- Given our team size this volatility is not usually an issue
- The stage environment is to be treated as production-like 

## 📦 Monorepo Packages
- The intention is that each package represents a small collection of resources that work together to fulfill some requirement
- This means it should be neither a single lambda or an entire application (somewhere inbetween)
- Generally speaking this strikes a nice balance between boilerplate & complexity
- Each package should be self-contained and **not** import files outside its own directory structure (eg: files from the repo root level or other packages)

## 🚦 Automated Tests

There are three flavours of tests we feel give us confidence our code is operating as expected:  

- Unit tests
- Integration tests
- Infrastructure tests

Our definition of each is as follows:

#### Unit Tests
Unit tests should be written to validate (lower level) individual functions. They are *not* typically suited to testing combined units of logic, such as entire lambdas, but rather the individual functions that make up the logic within one. Following this guidance should mean mocking can be kept to a minimum and that they're relatively inexpensive to write and maintain.

#### Integration Tests
Integration tests should be written to give confidence that deployed resources are functioning together as a combined unit. This means operating against *real* resources in the cloud in a black box fashion, ie: given a starting point, does stuff pop out at the other end as intended.

These tests are typically the most expensive to write and maintain, but also give the **most confidence** that stuff is actually working as the product evolves over time. Because of the complexity involved, usually only core functionality is tested in this way.

#### Infrastructure Tests
Because we use the CDK and TypeScript to manage infrastructure, it's possible to have complex logic regarding the creation or configuration of resources. Infrastructure tests are intended to validate any such complexity. Not all packages will necessarily have tests of this type.

## 📁 Directory structure

This is the directory structure adopted by this template. New packages created via the [`new-cdk-package`](#-npm-scripts) script automatically follow this convention:

```
.
├── _templates              (hygen templates for new packages)
├── infra                   (repo-level CDK code)
└── packages
    └── <package-name>
        ├── infra           (package-level CDK code)
        ├── src             (application code)
        │   └── types.ts    (shared typescript definitions)
        └── test            (test code)
            ├── infra       (infrastructure tests)
            ├── integration (integration tests)
            └── unit        (unit tests) 
```
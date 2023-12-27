# Project template for AWS Lambda functions written in TypeScript

[![](https://img.shields.io/badge/github-ggrptr/lambda--template--typescript-%233DA639.svg)](https://github.com/ggrptr/lambda-template-typescript 'github.com/ggrptr/lambda-template-typescript')
[![License](https://img.shields.io/badge/license-MIT-%233DA639.svg)](https://opensource.org/licenses/MIT)
[![codecov](https://codecov.io/gh/ggrptr/lambda-template-typescript/graph/badge.svg?token=XLY31XTLOP)](https://codecov.io/gh/ggrptr/lambda-template-typescript)

A simple hello world AWS Lambda function written in TypeScript, to use as a template for my projects.
It contains the tools I use to develop, test and deploy my TS lambda functions.

## Functionality

The example is a simple hello world function, that returns a greeting message.

## Scripts

The list and explanation of the scripts in the `package.json` :

-   prepare: at the first running of npm, this hook will automatically install the husky hooks.
    [Husky](https://typicode.github.io/husky/) is a tool for executing commands on git hooks.
-   start: builds and runs the code locally
-   build: builds the code
-   build:prod: builds the code with production settings (using the `tsconfig.prod.json` config file)
-   lint: runs eslint with --fix option, to check linting errors and fix them
-   format: formats the code with prettier
-   spell: find spelling errors in the code, based on the configuration in cspell.json
-   test: runs [jest](https://jestjs.io/) tests without any arguments
-   test:debug: runs all test serially with the current process, for debugging purposes
-   test:coverage: like test:debug, but with generating coverage report
-   test:watch: runs jest in watch mode, to re-run tests on file changes
-   package:modules: creates a lambda layer package from the node_modules directory
-   package:src : creates a lambda package from the src directory
-   package: calls package:modules and package:src to create a full lambda deployment package

It's a bit complicated to separate the local and deployment build (especially the node_modules directory),
but it's necessary if I want to use the same local project for local development and test terraform deployments.

## Commit hooks

With Husky, the following scripts executed automatically on each commit:

-   npm run lint
-   npm run format
-   npm run spell
-   npm run test

Additionally, the commit messages checked with [commitlint](https://commitlint.js.org/#/) to ensure the commit messages follow the [conventional commit](https://www.conventionalcommits.org/en/v1.0.0/) format.

## Github Actions

Runs on every push to the main branch, and on create or update every pull request.
The project contains a Github Actions workflows, that runs the following steps, with the defined matrix:

### ci.yml

-   Checkouts the code
-   Initializes the node environment
-   Installs dependencies
-   Runs linter
-   Runs spell checker
-   Runs tests
-   TODO: create coverage report

### pull-request.yaml

Runs on every push, if the target branch is not the main branch.

-   Checkouts the code #TODO is it necessary?
-   Gets the branch name
-   Creates a pull request to the main branch, using the template in the .github folder

**[MIT License](https://opensource.org/license/mit/ 'opensource.org/license/mit/')**

Copyright (c) 2023 [ggrptr](https://github.com/ggrptr)

# Lambda testing environment

This folder contains a terraform configuration, that creates a lambda function and a lambda layer.
The configuration based on my [terraform module template](https://github.com/ggrptr/terraform-module-template) project,
all the tools and scripts are the same.
The main difference is that this configuration mounts the dist directory under the project root, to provide access
to the lambda packages files.

## Usage

### Building the lambda packages

You can build the lambda packages with npm, in the project root directory:

```shell
npm run package
```

This command will create the packages in the dist directory.

### Deploying the infrastructure and packages

In the test/terraform directory, you can run the following commands:

```shell
    make terraform init
    make terraform apply
```

The apply command requires access for an AWS account, you can set the credentials, and target region with the following
environment variables

-   AWS_ACCESS_KEY_ID
-   AWS_SECRET_ACCESS_KEY
-   AWS_SESSION_TOKEN
-   AWS_REGION

### Destroying the infrastructure

**The configuration uses local state files, so you can destroy the infrastructure until you don't delete the state files
from the terraform directory.**

```shell
    make terraform destroy
```

**[MIT License](https://opensource.org/licenses/MIT)**

Copyright (c) 2023 [ggrptr](https://github.com/ggrptr)

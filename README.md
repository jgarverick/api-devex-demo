# api-devex-demo

## Overview

This is a repository allowing you to start with a few niceties for API development using Azure, GitHub Copilot, and Teraform (among other things).

- `pre-commit` hooks and processing for file formatting, tflint, terraform-docs, and terraform-fmt
- `devconainer.json` configured with essential VS Code extensions
- Terraform: Infrastructure as Code for the core platform components required
- Three separate API projects with infrastructure and source code included (sample APIs for illustrative purposes)
  - Echo API: based solely on an OpenAPI spec and an APIM policy file
  - Sample GraphQL endpoint: very barebones GraphQL API with support for Azure Functions deployment
  - Sample gRPC service: stock gRPC project using C# (`dotnet new grpc`) with support for Azure App Services (web app) deployment

_**Please note: Azure API Center and GitHub Copilot API Center integration are currently in preview.**_

_**GitHub Copilot API Center integration requires using Visual Studio Code Insiders and does not work if using CodeSpaces.**_

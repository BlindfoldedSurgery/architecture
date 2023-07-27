# Terraform structure

[BlindfoldedSurgery/architecture Issue #3](https://github.com/BlindfoldedSurgery/architecture/issues/3)

## Why

We need a few new repos for terraform configs, currently domains, github orgs, github repos, ... are mostly managed by hand.

We should automate this as far as possible, this issue is mostly about everything domain related (cloudflare) and the github configuration

The [woog.life](https://woog.life) DNS is already configured via terraform in [woog-life/dns-config](https://github.com/woog-life/dns-config)

## Options

We've a few different options on how to structure these configurations

### State management

State will be saved to S3 (provider: [R2](https://www.cloudflare.com/developer-platform/r2/))

> Not relevant for [Cloudflare per domain](#per-domain) and [GitHub per organization](#per-organization-1)

#### Combined state

One state to rule them all, all cloudflare and github configurations live in one state file

pros:
- no additional configuration required

cons:
- no isolation
- conflicts are difficult to resolve

#### Split state

Each domain/github organization has its own state file

pros:
- isolation
- easy to handle conflicts

cons:
- needs additional configuration (backend key)

### Combined

#### per organization

Each organization has a `terraform` repository which configures the associated domains and it's own github configuration.

#### BlindfoldedSurgery/terraform

We've one repo to manage all github organization configurations and all domain configurations.

### GitHub

#### per organization

This can be combined with [cloudflare per organization](#per-organization-2) or [cloudflare in one](#blindfoldedsurgeryterraform-cloudflare)

Each organization handles it's own github configuration while the cloudflare settings live in another repo

#### BlindfoldedSurgery/terraform-github

All github organizations are configured in one repository

### Cloudflare (DNS)

#### per organization


#### BlindfoldedSurgery/terraform-cloudflare


#### per domain


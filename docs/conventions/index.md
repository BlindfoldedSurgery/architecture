# Conventions

This section defines general conventions for Blindfolded Surgery projects. It is mostly concerned
with internal topics like coding standards, project layout, pipeline configuration, git practices,
etc.

Keep in mind that these conventions are just a guideline that one can follow in order to create
projects that follow best practices without reinventing the wheel. They are, however, **not**
binding in any way. Since it is part of [our values](../about.md#our-values) to explore new
technologies and techniques - including uncommon or downright obscure ones - it's impossible to
define a fixed set of rules that every project should follow.

## Overview

This chapter presents some of the universal conventions and ideals across all projects. For
further conventions regarding specific technologies or practices, consult the subpages of this
section.

### Open Source

We value learning and trying new things, as well as making the results of that visible to others.
Even if it's seemingly stupid, unnecessary, or even erroneous: others should have the chance to
learn from it, just as the author did.

In practice, this means we make all of our code public and release it under an open source license.
We **typically use the [MIT license][mit]** for our projects, although sometimes it's better to
stick to the preferred license of the community for the technologies in use (like BSD-3 for
Dart/Flutter or Apache for Android projects).

#### Keeping Secrets Out of Version Control

Since our projects are open for the public to see and copy, you must keep anything you don't want
to be public out of git. In addition, try to think ahead and prevent others from committing secrets
as well, for example by adding likely names of files containing secrets to your `.gitignore`.

#### Make It Usable for Anyone

Conversely, while we do want to keep secrets out of our repository, we should strive to make it easy
for others to reproduce our setup.

- Provide example configurations
- Explain how secrets/configuration values are used
- Explain how secrets can be obtained
- Don't hardcode anything specific to our infrastructure

### Infrastructure as Code

We want our infrastructure setup to be reproducible for us and others. While it might take a bit
more time to set up initially, describing your infrastructure as code is always preferable to manual
processes.

- Use technologies like Helm, Terraform, Ansible
- [Make it usable for other people](#make-it-usable-for-anyone)

### Automation

- TODO: Renovate
- TODO: CI
- TODO: CD

[mit]: https://en.wikipedia.org/wiki/MIT_License

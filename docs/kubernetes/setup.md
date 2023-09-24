# Setup

## terraform

[terraform](https://github.com/BlindfoldedSurgery/terraform-rke2/) sets up the servers (master/agent), loadbalancer and private network.

## ansible

[ansible-base](https://github.com/BlindfoldedSurgery/ansible-base) contains playbooks, role references, vaults, environments specific variables and is the repo in which `ansible-playbook` is executed.

[ansible-role-os-baseconfig](https://github.com/BlindfoldedSurgery/ansible-role-os-baseconfig) sets up the underlying os (`debian-11` as of writing (24.09.2023)), this only concerns firewall rules for the moment.

We'll only be using images which are offered by hetzner as part of their [`Standard images`](https://docs.hetzner.com/robot/dedicated-server/operating-systems/standard-images).

[ansible-role-os-rke2](https://github.com/BlindfoldedSurgery/ansible-role-rke2) sets up the rke2 cluster itself. This includes:

- download the newest tarball
- write the server/agent config
- configure cilium/[...] (via `HelmChartConfig`)
- start/enable `rke2-{agent,server}`
- `etcd` configuration
- [...]

[ansible-role-os-cluster-baseconfig](https://github.com/BlindfoldedSurgery/ansible-role-cluster-baseconfig) sets up the basic services which are needed to configure everything else later on via GitOps (argoCD):

- [doppler](https://www.doppler.com/) api key
- [external-secrets operator](https://external-secrets.io/latest/)  (including a `ClusterSecretStore` connected to doppler)
- argoCD `AppProject` (`argocd`)
- [argocd-bootstrap](https://github.com/BlindfoldedSurgery/argocd-bootstrap) set to the `argocd` `AppProject`
- `argoCD` (minimal configuration, e.g. without an `Ingress`)
- [longhorn](https://longhorn.io/) (See [this commit](https://github.com/BlindfoldedSurgery/ansible-role-cluster-baseconfig/commit/2c3cdf7bb61a1311fd4a741114150d9cfddff6ff) for an explanation)

`argoCD` will later manage the [`external-secrets`](https://github.com/BlindfoldedSurgery/external-secrets/) operator and [itself](https://github.com/BlindfoldedSurgery/argocd).

The `external-secrets` operator will take over ownership of the `doppler` secret.

## argocd

> In contrast to ansible I won't document each downstream `argoCD` app here since they will change more often
>
> ansible roles will be fairly static since they're just setting up the initial cluster

[argocd-bootstrap](https://github.com/BlindfoldedSurgery/argocd-bootstrap) is installed by [ansible-role-os-cluster-baseconfig](https://github.com/BlindfoldedSurgery/ansible-role-cluster-baseconfig).

`argoCD` will have ownership of all resources which aren't managed by rke2/rancher (e.g. `cilium`) or another operator (e.g. `postgres-operator`).
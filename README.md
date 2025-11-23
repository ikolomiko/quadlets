# Quadlets
Some Quadlet files for the services I self-host. Feel free to use and contribute!

## Table of Contents
- [What are Quadlets?](#what-are-quadlets)
- [But What is Podman?](#but-what-is-podman)
- [Dependencies](#dependencies)
- [Installation](#installation)
- [Usage](#usage)
- [Secrets](#secrets)
- [Further Reading](#further-reading)
- [License](#license)

## What are Quadlets?

Quadlets combine **Podman** containers and **systemd** unit files into a simple, unified configuration format. They allow you to run Podman containers with systemd unit files, enabling easier management of containerized services. This technology is ideal for managing containers as system services with minimal configuration.

## But What is Podman?
[**Podman**](https://podman.io/) is a container management tool that is a **drop-in replacement** for Docker, designed with security in mind, as it allows rootless containers without requiring a daemon, making it a safer and more flexible option for containerized applications. You can use pretty much any Docker container or image with Podman, even the command line interfaces are identical. Just replace `docker` with `podman` and voila!

## Dependencies

To use these Quadlet files, you'll need the following:

- A **systemd-based** Linux distribution (pretty much all popular Linux distros are systemd-based, except Alpine)
- **Podman** (duh)
- **catatonit** (a simple init system to manage Podman containers)
- **rootlesskit** (tool to enable rootless Podman containers)
- **slirp4netns** (user-space networking tool)
- **GNU Make** (for installation/uninstallation)

## Installation

Installation

Install the `qm` manager and copy quadlet files to the system prefix using the provided `Makefile`.

Install to the default prefix (`/usr/local`) (may require `sudo`):

```bash
sudo make install
```

Install to a different prefix (no sudo):

```bash
make PREFIX=/opt install
```

Uninstall the installed files:

```bash
sudo make remove
```

The `Makefile` also installs shell completions for Bash and Zsh into the corresponding prefix locations.

## Usage

Use the installed `qm` command to manage quadlets (enable/disable/list/query). `qm` supports rootless and rootful modes via the `-r|--rootful` flag.

Enable a quadlet (rootless):

```bash
qm install <quadlet-name>
```

Enable a quadlet system-wide (rootful):

```bash
qm install -r <quadlet-name>
```

Disable a quadlet (rootless):

```bash
qm remove <quadlet-name>
```

Disable a quadlet system-wide (rootful):

```bash
qm remove -r <quadlet-name>
```

List installed quadlets (shows both rootless and rootful installs):

```bash
qm list
```

Show systemd status for a quadlet unit (rootless):

```bash
qm status <unit-or-quadlet-name>
```

Show systemd status for a quadlet unit system-wide (rootful):

```bash
qm status -r <unit-or-quadlet-name>
```

## Secrets
I use Podman secrets to manage sensitive information within these Quadlet files. For the **Vaultwarden** and **Nextcloud** services, you need to create some secrets:

```bash
echo 'YOUR SUPER SECURE PASSWORD HERE' | podman secret create vaultwarden_password -
echo 'your.vaultwardendomain.com' | podman secret create vaultwarden_domain -
echo 'YOUR SUPER SECURE PASSWORD HERE' | podman secret create nc_password -
```

## Further Reading
- [Manual Page for Quadlets](https://docs.podman.io/en/latest/markdown/podman-systemd.unit.5.html) - or just `man podman-systemd.unit`
- [Introductory blog post by Red Hat](https://www.redhat.com/en/blog/quadlet-podman)
- [A more helpful blog post with nice examples](https://giacomo.coletto.io/blog/podman-quadlets/)

## License

This repository is licensed under the **GNU Affero General Public License (AGPL) version 3**. Please refer to the [LICENSE](LICENSE) file for more details.

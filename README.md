# Quadlets
Some Quadlet files for the services I self-host. Feel free to use and contribute!

## Table of Contents
- [What are Quadlets?](#what-are-quadlets)
- [But What is Podman?](#but-what-is-podman)
- [Dependencies](#dependencies)
- [Installation](#installation)
  - [Rootful vs Rootless Installations](#rootful-vs-rootless-installations)
  - [Rootless Installation](#rootless-installation)
  - [Rootful Installation](#rootful-installation)
  - [Uninstallation](#uninstallation)
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

You can install these Quadlet files in either **rootful** or **rootless** mode. Here's how:

### Rootful vs Rootless Installations

- **Rootful** installations run containers with root privileges, meaning they have full access to system resources.
- **Rootless** installations run containers without root privileges, enhancing security by isolating containers from the system and reducing the risk of privilege escalation.

For most users, **rootless** installations are recommended as they are safer. However, **rootful** installations may be necessary in certain cases where more system-level access is required.

### Rootless Installation
Before running the rootless installation, you'll need to enable lingering for your user account. This ensures that systemd continues to run services for your user after you log out. Run the following command **only once**:

```bash
sudo loginctl enable-linger $USER
```

To install the Quadlet files in **rootless** mode (without requiring root privileges), use the following command:

```bash
make install-rootless
```

### Rootful Installation
To install the Quadlet files in **rootful** mode (using root privileges), use the following command:

```bash
make install-rootful
```

## Uninstallation

To remove the Quadlet files, use the following commands:

- For **rootless** uninstallation:
  
  ```bash
  make uninstall-rootless
  ```

- For **rootful** uninstallation:

  ```bash
  make uninstall-rootful
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

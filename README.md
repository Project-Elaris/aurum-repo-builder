# aurumOS Arch package repository

This repository builds x86_64 Arch Linux packages in an Arch Linux Docker image and publishes the pacman repository to the `repo` branch. GitHub Actions builds on pushes to `main` or `master`, every Monday, and on manual dispatch.

The repository includes the local `calamares` PKGBUILD, the `aurum-calamares-config` package, and the AUR packages listed in [`pkgbuilds/aur-packages.txt`](pkgbuilds/aur-packages.txt). The AUR package recipes are fetched from their AUR Git repositories when the workflow runs, so each build uses the latest AUR recipe revision.

## Enable the package repository

After the first successful workflow run, enable GitHub Pages for this repository with the `repo` branch as the source and `/` as the directory. Add this section to `/etc/pacman.conf`, replacing `OWNER` and `REPOSITORY` with the GitHub account and repository names:

```ini
[aurum]
SigLevel = Optional
Server = https://OWNER.github.io/REPOSITORY/$arch
```

`SigLevel = Optional` is needed because this workflow currently publishes unsigned packages and repository databases. Then refresh pacman's databases and install packages, for example:

```sh
sudo pacman -Syu aurum-calamares-config paru downgrade pacseek
```

The `repo` branch is generated output and is force-updated by the workflow on each publish.

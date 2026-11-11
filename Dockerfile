FROM archlinux:base-devel

ARG BUILDER_UID=1000
ARG BUILDER_GID=1000

RUN pacman -Syu --noconfirm --needed git pacman-contrib sudo \
    && groupadd --gid "${BUILDER_GID}" builder \
    && useradd --uid "${BUILDER_UID}" --gid builder --create-home --shell /bin/bash builder \
    && printf 'builder ALL=(root) NOPASSWD: /usr/bin/pacman\n' >> /etc/sudoers \
    && visudo --check --file=/etc/sudoers

COPY scripts/build-package-repository /usr/local/bin/build-package-repository
RUN chmod 0755 /usr/local/bin/build-package-repository

ENV HOME=/home/builder
USER builder
ENTRYPOINT ["/usr/local/bin/build-package-repository"]

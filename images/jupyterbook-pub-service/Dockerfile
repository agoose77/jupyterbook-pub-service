FROM python:3.14-trixie

RUN apt update >/dev/null && apt install --yes nodejs tini npm >/dev/null

# Install a new enough version of rclone
RUN curl https://rclone.org/install.sh |  bash

# Install micromamba for use by the jupyterlite builder
RUN curl -L https://micro.mamba.pm/install.sh | bash
# Make sure we can find micromamba
ENV PATH=/root/.local/bin:${PATH}

# Build wheels
#
# We set pip's cache directory and expose it across build stages via an
# ephemeral docker cache (--mount=type=cache,target=${PIP_CACHE_DIR}). We use
# the same technique for the directory /tmp/wheels.
#
ARG JUPYTER_BOOK_REV=6b995e1d3c5c380498c037355d0aa50813e1a23f
RUN --mount=type=cache,target=/tmp/transient \
    cd $(mktemp -d) && \
    git clone --depth=1 https://github.com/yuvipanda/jupyterbook.pub . && \
    git checkout ${JUPYTER_BOOK_REV} && \
    cd js && \
    npm install && \
    npm run build && \
    cd ../ && \
    python3 -m pip --cache-dir=/tmp/transient/ install .

# Install default book theme
RUN mkdir -p /opt/templates && \
    cd /opt/templates && \
    curl -L https://github.com/myst-templates/book-theme/archive/43b78aca9895f5a7929bf7f5591791a4bf1adcfb.zip -o theme.zip && \
    unzip theme.zip && \
    rm theme.zip && \
    mkdir -p site/myst/ && \
    mv book-theme* site/myst/book-theme && \
    cd site/myst/book-theme && \
    npm ci --ignore-scripts
ENV JUPYTERBOOK2BUILDER__JupyterBookSiteRenderer__templates_path=/opt/templates
ENV PYTHONUNBUFFERED=1

ENTRYPOINT ["tini", "--"]
CMD ["python3", "-m", "jupyterbook_pub.app"]


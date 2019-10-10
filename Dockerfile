FROM neurodebian:stretch-non-free
ARG DEBIAN_FRONTEND="noninteractive"

RUN mkdir -p /src/install_scripts
COPY install_scripts/ /src/install_scripts

RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends apt-utils bzip2 \
        ca-certificates curl wget locales unzip cmake g++ gcc git cmake \
        cmake-curses-gui make pigz zlib1g-dev libboost-all-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG="en_US.UTF-8" \
    && chmod 777 /opt && chmod a+s /opt

RUN bash /src/install_scripts/install_itk.sh > log_00_itk
RUN bash /src/install_scripts/install_boost.sh > log_01_boost
RUN bash /src/install_scripts/install_braincharter.sh > log_02_braincharter
RUN bash /src/install_scripts/install_afni_fsl.sh > log_03_afni_fsl

ENV CONDA_DIR="/opt/miniconda-latest" \
    PATH="/opt/miniconda-latest/bin:$PATH"
RUN export PATH="/opt/miniconda-latest/bin:$PATH" \
    && echo "Downloading Miniconda installer ..." \
    && conda_installer="/tmp/miniconda.sh" \
    && curl -fsSL --retry 5 -o "$conda_installer" https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash "$conda_installer" -b -p /opt/miniconda-latest \
    && rm -f "$conda_installer" \
    && conda update -yq -nbase conda \
    && conda config --system --prepend channels conda-forge \
    && conda config --system --set auto_update_conda false \
    && conda config --system --set show_channel_urls true \
    && sync && conda clean -tipsy && sync \
    && conda create -y -q --name neuro \
    && conda install -y -q --name neuro \
           'python=2.7' \
           'numpy' \
           'dipy' \
           'scikit-image'

FROM ubuntu:jammy

# Install the required packages
USER root
RUN apt-get update && \
    apt-get install -y \
    git \
    openmpi-bin \
    libopenmpi-dev \
    cmake \
    libosmesa6-dev \
    build-essential

#RUN apt-get install -y wget

# Setup localization
#RUN apt-get install -y locales
#RUN rm -rf /var/lib/apt/lists/* \
#    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
#RUN locale-gen en_US.UTF-8
#ENV LANG en_US.UTF-8
#ENV LANGUAGE en_US:en
#ENV LC_ALL en_US.UTF-8

# Setup the liggghts user
ARG USER=liggghts
RUN adduser --disabled-password --gecos '' $USER
RUN adduser $USER sudo; echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN chown -R $USER:$USER /home/$USER
USER $USER
ENV HOME /home/$USER
ENV USER $USER
WORKDIR $HOME

# Install the local copy of VTK
RUN mkdir vtk
ADD vtk/include/vtk-9.1 vtk/include
ADD vtk/lib vtk/lib
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/liggghts/vtk/lib

# Compile LIGGGHTS
RUN git clone https://github.com/CFDEMproject/LIGGGHTS-PUBLIC.git
ADD Makefile.user LIGGGHTS-PUBLIC/src/MAKE/Makefile.user
WORKDIR $HOME/LIGGGHTS-PUBLIC/src
RUN sed -i 's/ostringstream()/ostringstream().flush()/g' utils.h
RUN make auto

# Create a symlink to the executable and set the path
WORKDIR $HOME
RUN mkdir bin && \
    ln -s $HOME/LIGGGHTS-PUBLIC/src/lmp_auto $HOME/bin/liggghts
ENV PATH=$PATH:$HOME/bin

# Fix MPI issues: github.com/open-mpi/ompi/issues/4948
ENV OMPI_MCA_btl_vader_single_copy_mechanism=none

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

#RUN apt-get install -y build-essential
#    libvtk7.1 \
#    libvtk7-dev

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

RUN git clone https://github.com/CFDEMproject/LIGGGHTS-PUBLIC.git

RUN mkdir vtk
ADD vtk/include/vtk-9.1 vtk/include
ADD vtk/lib vtk/lib
ADD Makefile.user LIGGGHTS-PUBLIC/src/MAKE/Makefile.user
RUN export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/liggghts/vtk/lib

WORKDIR $HOME/LIGGGHTS-PUBLIC/src
RUN sed -i 's/ostringstream()/ostringstream().flush()/g' utils.h
RUN make auto

WORKDIR $HOME
RUN mkdir bin && \
    ln -s $HOME/LIGGGHTS-PUBLIC/src/lmp_auto $HOME/bin/liggghts
ENV PATH=$PATH:$HOME/bin
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/liggghts/vtk/lib


#RUN    cd LIGGGHTS-PUBLIC/src && \
#    make auto

#USER root
#RUN apt-get install -y wget
#USER $USER

#RUN wget https://www.vtk.org/files/release/9.1/VTK-9.1.0.tar.gz

#USER root
#RUN apt-get install -y cmake libosmesa6-dev ninja
#USER $USER

#cmake -DBUILD_TESTING:BOOL=OFF -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX=../install -DModule_vtkIOMPIParallel:BOOL=ON -DVTK_Group_MPI:BOOL=ON -DVTK_Group_Rendering:BOOL=OFF -DVTK_RENDERING_BACKEND:STRING=None -DVTK_USE_X:BOOL=OFF -DModule_vtkIOMPIImage:BOOL=ON -DModule_vtkParallelMPI:BOOL=ON -DVTK_OPENGL_HAS_OSMESA=ON ..

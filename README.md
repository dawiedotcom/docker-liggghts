Builds an image ot run LIGGGHTS in a Docker container.

## Building

VTK has to be compiled on the host without X support. The VTK library is used to compile the LIGGGHTS source in the image.
To compile VTK, a C++ compiler, cmake and the development tools for MPI are required on the host system.
See the [VTK build instructions](https://gitlab.kitware.com/vtk/vtk/-/blob/master/Documentation/dev/build.md) for details.

Make and docker will do the rest (download and compile VTK and assemble the docker image):

    docker liggghts-jammy

## Dockerhub

Alternatively, pull the image from Dockerhub:

    docker pull daviddeklerk/liggghts:latest

## Usage

Run the Docker image using:

    docker run -i -v /path/to/input.script:/home/liggghts/sim -t daviddeklerk/liggghts:latest

In the prompt, navigate to your simulation script and run liggghts:

    cd sim
    liggghts -in input.script
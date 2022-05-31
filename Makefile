CONTEXT_DIR=jammy

VTK_SRC=VTK-9.1.0
VTK_INS=$(CONTEXT_DIR)/vtk
VTK_TAR=$(VTK_SRC).tar.gz
VTK_URL=https://www.vtk.org/files/release/9.1/$(VTK_TAR)
VTK_OPT=-DCMAKE_INSTALL_PREFIX=../../$(VTK_INS) \
				-DBUILD_TESTING:BOOL=OFF \
				-DCMAKE_BUILD_TYPE:STRING=Release \
				-DModule_vtkIOMPIImage:BOOL=ON \
				-DModule_vtkIOMPIParallel:BOOL=ON \
				-DVTK_USE_MPI=ON \
				-DVTK_Group_MPI:BOOL=ON \
				-DVTK_Group_Rendering:BOOL=OFF \
				-DVTK_RENDERING_BACKEND:STRING=None \
				-DModule_vtkParallelMPI:BOOL=ON \
				-DVTK_USE_X:BOOL=OFF \
				-DVTK_OPENGL_HAS_OSMESA=ON

liggghts-jammy:
	docker build -t daviddeklerk/liggghts jammy


$(VTK_INS) : $(VTK_SRC)
	cd $(VTK_SRC) && \
	mkdir build && \
	cd build && \
	cmake $(VTK_OPT) .. && \
	make -j 30 && \
	make install

$(VTK_SRC) : $(VTK_TAR)
	tar xfv $<

$(VTK_TAR):
	wget $(VTK_URL)

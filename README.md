![](./algohex_results.png)

AlgoHex
======

`AlgoHex` is an implementation of the frame based hexahedral meshing pipeline, distributed under AGPLv3.

If you use `AlgoHex` in your scientific work, please cite us.

## How does AlgoHex work?

AlgoHex automatically converts tetrahedral meshes to hexahedral meshes. The complete pipeline consists of four major steps (see the figure below): initialization of feature-aligned smooth frame field, locally meshable frame field generation, parameterization, and hexahedral mesh extraction. The frame field initialization follows the approach of [On Smooth 3D Frame Field Design](https://arxiv.org/abs/1507.03351). Locally meshable frame field is obtained via the state-of-the-art method [Locally Meshable Frame Fields](https://www.algohex.eu/publications/locally-meshable-frame-fields/). Parameterization of the frame field includes seamless mapping ([Locally Meshable Frame Fields](https://www.algohex.eu/publications/locally-meshable-frame-fields/), [CubeCover](http://www.mi.fu-berlin.de/en/math/groups/ag-geom/publications/db/2011_Nieser-Reitebuch-Polthier_CubeCover.pdf)), robust quantization ([QGP3D](http://graphics.cs.uos.de/papers/Volume_Parametrization_Quantization-SIGGRAPH2022.pdf)) and Integer-grid mapping. For hexahedral mesh extraction, we use the [libHexEx](https://www.graphics.rwth-aachen.de/software/libHexEx).
![](algohex_pipeline.png)

### File Format
The input to the algorithm is a tetrahedral mesh with user-specified feature tags, and the output is a hexahedral mesh. The input tetrahedral mesh can be in VTK or OpenVolumeMesh file format. A typical dataset with feature tags as the input to AlgoHex is [HexMe](https://www.algohex.eu/publications/hex-me-if-you-can/). The output hexahedral mesh is in OpenVolumeMesh file format. Note that the result may be an incomplete hexahedral mesh, as the frame field may not be globally hex-meshable.

## Dependencies

The CMake-based build system will automatically download missing dependencies unless `ALGOHEX_DOWNLOAD_MISSING_DEPS` is disabled (enabled by default if building AlgoHex standalone, disabled if built inside a bigger project using `add_subdirectory`). All dependencies are listed below:
- [OpenVolumeMesh](www.openvolumemesh.org)
- [libHexEx](https://www.graphics.rwth-aachen.de/software/libHexEx)
- [CoMISo](https://www.graphics.rwth-aachen.de/software/comiso)
- [GMM](http://getfem.org/gmm.html)
- [TinyAD](https://github.com/patr-schm/TinyAD)
- [QGP3D](https://github.com/HendrikBrueckler/QGP3D) (As dependencies of QGP3D, Gurobi and GMP must be installed on your system)
- [Eigen](http://eigen.tuxfamily.org)
- [CLI11](https://github.com/CLIUtils/CLI11.git)
- SuiteSparse (optional)


To compile unit tests, you need to install googletest (gtest). It will not be automatically downloaded. On Debian, you can do this as `apt install libgtest-dev`.

## Building

AlgoHex can be compiled independently, resulting in a command-line tool, or compiled together with [OpenFlipper](https://www.graphics.rwth-aachen.de/software/openflipper/). To compile the standard alone, follow the steps:
```
cd AlgoHex
mkdir build
cd build
cmake -DGUROBI_HOME=/path/to/gurobi ..
make
```

## License

`AlgoHex` is copyright (C) 2019-2023 by David Bommes (see the CREDITS file for more information). `AlgoHex` is free software under the GNU Affero General Public License. For more detailed license information, see LICENSE in the AlgoHex root directory.

## Usage

A command-line executable is provided, which reads a tetrahedral mesh and outputs a hexahedral mesh. For example:
```
./Build/bin/HexMeshing -i ../demo/HexMeshing/cylinder.ovm -o /path/to/cylinder_hex.ovm
```
Two modes of the hexahedral meshing pipeline are available in AlgoHex. The default mode includes all four major components of frame field based hexahedral meshing pipeline, while the mode `--hexme-pipeline` comprises only a subset as described in [HexMe](https://www.algohex.eu/publications/hex-me-if-you-can/).
For more information on the usage, please execute `./Build/bin/HexMeshing -h`.


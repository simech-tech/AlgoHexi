
include(FetchContent)

set(FETCHCONTENT_QUIET OFF)
set(EXTERNAL_DIR "${CMAKE_CURRENT_SOURCE_DIR}/external")
set(FETCHCONTENT_UPDATES_DISCONNECTED TRUE)

if(NOT TARGET GMM::GMM)
    FetchContent_Declare(gmm
        DOWNLOAD_EXTRACT_TIMESTAMP TRUE
        URL http://download-mirror.savannah.gnu.org/releases/getfem/stable/gmm-5.4.2.tar.gz
        URL_HASH SHA224=8f4951901a55a1d1987d8199ed0e0b36ff2da26c870a4c3d55694a14
        SOURCE_DIR "${EXTERNAL_DIR}/gmm"
    )
    FetchContent_Populate(gmm)

    message("Downloaded GMM to ${gmm_SOURCE_DIR}")
    set(GMM_INCLUDE_DIR "${gmm_SOURCE_DIR}/include")
    find_package(GMM REQUIRED)
endif()

if(NOT TARGET Eigen3::Eigen)
    FetchContent_Declare(eigen
        #GIT_REPOSITORY https://gitlab.com/libeigen/eigen
        #GIT_TAG 3.4.0
        # temporary fix, 2025-01-16: my (mh) MR is not merged yet, but is required to fix a build error:
        GIT_REPOSITORY https://gitlab.com/mheistermann/eigen
        GIT_TAG fix/spqr-index-vs-storageindex
        SOURCE_DIR "${EXTERNAL_DIR}/eigen"
    )
    FetchContent_Populate(eigen)
    message("Downloaded Eigen3 to ${eigen_SOURCE_DIR}")
    add_library(Eigen3::Eigen INTERFACE IMPORTED)
    target_include_directories(Eigen3::Eigen INTERFACE "$<BUILD_INTERFACE:${eigen_SOURCE_DIR}>")
    #target_compile_definitions(Eigen3::Eigen INTERFACE -DEIGEN_HAS_STD_RESULT_OF=0)
endif()


if(NOT TARGET tinyad::tinyad)
    FetchContent_Declare(tinyad
        GIT_REPOSITORY  https://github.com/patr-schm/TinyAD
        GIT_TAG 81fab13c3884b787c0f03bbbbb95b0f794e54434 # main 2023-10-10
        SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/external/tinyad"
        )
    #FetchContent_Populate(tinyad)
    #set(TINYAD_DIR "${tinyad_SOURCE_DIR}/include")
    #set(TINYAD_INCLUDE_DIR "${tinyad_SOURCE_DIR}/include")
#[[= # rely on comiso's tinyad finder for now to avoid this issue:
        CMake Error in external/CoMISo/CMakeLists.txt:
        export called with target "CoMISo" which requires target "TinyAD" that is
        not in any export set.
    FetchContent_MakeAvailable(tinyad)

    add_library(tinyad::tinyad ALIAS TinyAD)
#]]
    FetchContent_MakeAvailable(tinyad)
    add_library(tinyad::tinyad ALIAS TinyAD)
endif()

if(NOT TARGET CoMISo)
    FetchContent_Declare(comiso
        GIT_REPOSITORY https://gitlab.vci.rwth-aachen.de:9000/CoMISo/CoMISo.git
        GIT_TAG f7383759204fc5c5f56c5534a49817d9b80b1592 # cgg2 2024-01-16
        SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/external/CoMISo" # case matters
        )
    set(COMISO_NO_INSTALL YES)
    FetchContent_MakeAvailable(comiso)
    if (NOT TARGET CoMISo::CoMISo)
        error(FATAL_ERROR "CoMISo target missing")
    endif()
endif()

if(NOT TARGET CLI11::CLI11)
    FetchContent_Declare(cli11
        GIT_REPOSITORY https://github.com/CLIUtils/CLI11.git
        GIT_TAG        v2.3.2
        SOURCE_DIR "${EXTERNAL_DIR}/CLI11"
        )
    FetchContent_MakeAvailable(cli11)
endif()

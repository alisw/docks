#!/bin/sh -ex

wipednf () {
  rpmdb --rebuilddb
  dnf clean all
  rm -rf /var/cache/yum
}

# Install NVIDIA GPG key
curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/rhel8/x86_64/D42D0685.pub |
  sed '/^Version/d' > /etc/pki/rpm-gpg/RPM-GPG-KEY-NVIDIA
echo "${NVIDIA_GPGKEY_SUM} /etc/pki/rpm-gpg/RPM-GPG-KEY-NVIDIA" | sha256sum -c --strict -

# rpm --import https://repo.almalinux.org/almalinux/RPM-GPG-KEY-AlmaLinux
dnf update -y
# Install requirements for GPU event display, NVIDIA CUDA and AMD ROCm stacks
CUV=${CUDA_PKG_VERSION}-${CUDA_PKG_VERSION/-/.}.${CUDA_PKG_MINOR_VERSION}
CUV2=${CUDA_PKG_VERSION}-${CUDA_PKG_VERSION/-/.}.*
dnf install -y freeglut-devel lsof cmake libdrm-devel                                             \
               vulkan-loader-devel glslc wayland-devel wayland-protocols-devel libxkbcommon-devel \
               "cuda-cudart-$CUV2" "cuda-libraries-$CUV" "cuda-nvtx-$CUV2"                        \
               "cuda-libraries-devel-$CUV" "cuda-nvml-devel-$CUV2" "cuda-minimal-build-$CUV"      \
               "cuda-command-line-tools-$CUV" tensorrt-devel tensorrt-libs                        \
               "cudnn9-cuda-$CUDA_PKG_VERSION"                                                    \
               hip-rocclr ocl-icd ocl-icd-devel hipcub rocthrust rocm-dev hipify-clang            \
               hiprand-devel hipblas-devel hipsparse-devel rocblas-devel rocrand-devel            \
               miopen-hip-devel hipfft-devel rccl-devel migraphx-devel                            \
               hipblaslt-devel rocprim-devel
# ROCm: Notice we do not need the version for ROCM because we target a specific distribution in rocm.repo

# Set up NVIDIA CUDA stack
export PATH=/usr/local/cuda/bin:${PATH}
LIBRARY_PATH=/usr/local/cuda/lib64/stubs ldconfig

wipednf

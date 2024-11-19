#!/bin/sh -ex

wipednf () {
  rpmdb --rebuilddb
  dnf clean all
  rm -rf /var/cache/yum
}

wipednf

# Install AMD APP Stack
# Old version no longer available from AMD but the newer versions will not work
curl -fsSL https://s3.cern.ch/swift/v1/alibuild-repo/slc8-gpu-builder-reqs/amdappsdk.tar.bz2 | tar -xjv
./AMD-APP-SDK-v3.0.130.136-GA-linux64.sh --noexec --target /opt/amd-app
rm -v AMD-APP-SDK-v3.0.130.136-GA-linux64.sh
# Avoid file collisions between AMD APP and AMD ROCm stack
mkdir -p /etc/OpenCL/vendors
echo /opt/amd-app/lib/x86_64/sdk/libamdocl64-app.so > /etc/OpenCL/vendors/amdocl64-app.icd
mv -v /opt/amd-app/lib/x86_64/sdk/libamdocl64.so \
      /opt/amd-app/lib/x86_64/sdk/libamdocl64-app.so
echo /opt/amd-app/lib/x86_64/ > /etc/ld.so.conf.d/amd-app-sdk.conf

# Install NVIDIA GPG key
curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/rhel8/x86_64/D42D0685.pub |
  sed '/^Version/d' > /etc/pki/rpm-gpg/RPM-GPG-KEY-NVIDIA
echo "${NVIDIA_GPGKEY_SUM}  /etc/pki/rpm-gpg/RPM-GPG-KEY-NVIDIA" | sha256sum -c --strict -

# rpm --import https://repo.almalinux.org/almalinux/RPM-GPG-KEY-AlmaLinux
dnf update -y --refresh
# Install requirements for GPU event display, NVIDIA CUDA and AMD ROCm stacks
CUV=${CUDA_PKG_VERSION}-${CUDA_PKG_VERSION/-/.}.*
dnf install -y freeglut-devel lsof                                                            \
               "cuda-cudart-$CUV" 'cuda-compat-12-0-*' "cuda-libraries-$CUV" "cuda-nvtx-$CUV" \
               "cuda-libraries-devel-$CUV" "cuda-nvml-devel-$CUV" "cuda-minimal-build-$CUV"   \
               "cuda-command-line-tools-$CUV"                                                 \
               "cudnn9-cuda-$CUDA_PKG_VERSION"                                                \
               hip-rocclr ocl-icd ocl-icd-devel hipcub rocthrust rocm-dev hipify-clang        \
               hiprand-devel hipblas-devel hipsparse-devel rocblas-devel rocrand-devel        \
               miopen-hip-devel hipfft-devel rccl-devel migraphx-devel
# ROCm: Notice we do not need the version for ROCM because we target a specific distribution in rocm.repo

# Set up NVIDIA CUDA stack
ln -s cuda-12.6 /usr/local/cuda
echo /usr/local/nvidia/lib >> /etc/ld.so.conf.d/nvidia.conf
echo /usr/local/nvidia/lib64 >> /etc/ld.so.conf.d/nvidia.conf
export PATH=/usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
export LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64
LIBRARY_PATH=/usr/local/cuda/lib64/stubs ldconfig

# Fix some errors in current ROCm
sed -i "s/amdgpu-function-calls=false/amdgpu-function-calls=true/g" /opt/rocm/bin/hipcc* /opt/rocm/lib/cmake/hip/*.cmake

# Remove clang-ocl binary, since it is currently broken, to avoid automatic pick-up
rm -fv /opt/rocm/bin/clang-ocl /usr/bin/clang-ocl

wipednf

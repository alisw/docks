CUDA_PKG_VERSION="11-2-11.2.*"
NVIDIA_GPGKEY_SUM="d1be581509378368edeec8c1eb2958702feedf3bc3d17011adbf24efacce4ab5"

# Install requirements for GPU event display
yum install dnf-plugins-core
yum config-manager --set-enabled powertools
yum install -y glew-devel freeglut-devel lsof s3cmd

# Install AMD APP Stack
# No longer available from AMD but the newer versions will not work
curl -Lo sdk.tbz2 https://sourceforge.net/projects/nicehashsgminerv5viptools/files/APP%20SDK%20A%20Complete%20Development%20Platform/AMD%20APP%20SDK%203.0%20for%2064-bit%20Linux/AMD-APP-SDKInstaller-v3.0.130.136-GA-linux64.tar.bz2/download
tar -xjvf sdk.tbz2
./AMD-APP-SDK-v3.0.130.136-GA-linux64.sh --noexec --target /opt/amd-app
rm ./AMD-APP-SDK-v3.0.130.136-GA-linux64.sh sdk.tbz2
# Avoid file collisions between AMD APP and AMD ROCm stack
mkdir -p /etc/OpenCL/vendors
echo /opt/amd-app/lib/x86_64/sdk/libamdocl64-app.so > /etc/OpenCL/vendors/amdocl64-app.icd
mv /opt/amd-app/lib/x86_64/sdk/libamdocl64{,-app}.so
echo /opt/amd-app/lib/x86_64/ > /etc/ld.so.conf.d/amd-app-sdk.conf

# Install NVIDIA CUDA Stack
curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/rhel8/x86_64/7fa2af80.pub | sed '/^Version/d' > /etc/pki/rpm-gpg/RPM-GPG-KEY-NVIDIA
echo "${NVIDIA_GPGKEY_SUM}  /etc/pki/rpm-gpg/RPM-GPG-KEY-NVIDIA" | sha256sum -c --strict -
yum install -y cuda-cudart-${CUDA_PKG_VERSION} cuda-compat-11-2-*
ln -s cuda-11.2 /usr/local/cuda
rm -rf /var/cache/yum/*
echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf
echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf
export PATH=/usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
export LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64
yum install -y cuda-libraries-${CUDA_PKG_VERSION} cuda-nvtx-${CUDA_PKG_VERSION}
rm -rf /var/cache/yum/*
yum install -y cuda-libraries-devel-${CUDA_PKG_VERSION} cuda-nvml-devel-${CUDA_PKG_VERSION} \
               cuda-minimal-build-${CUDA_PKG_VERSION} cuda-command-line-tools-${CUDA_PKG_VERSION}
rm -rf /var/cache/yum/*

# Install AMD ROCm stack
# Notice we do not need the version for ROCM because we target a specific distribution in rocm.repo
yum install -y hip-rocclr rocm-clang-ocl ocl-icd ocl-icd-devel hipcub rocthrust rocm-dev
rm -rf /var/cache/yum/*
# Remove clang-ocl binary, since it is currently broken, to avoid automatic pic up
rm /opt/rocm/bin/clang-ocl
# Fix some errors in current ROCm
cd /
patch -p0 < rocm.patch
rm rocm.patch

# Install clang trunk for OpenCL2 compilation
curl -Lo clang13.tar.bz2 https://qon.jwdt.org/nmls/clang13.tar.bz2
tar -jxf clang13.tar.bz2 -C /opt/
rm clang13.tar.bz2
ln -s /opt/clang/bin/llvm-spirv /usr/bin/

export LIBRARY_PATH=/usr/local/cuda/lib64/stubs
ldconfig

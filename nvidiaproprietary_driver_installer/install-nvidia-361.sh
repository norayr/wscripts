#this script is intended to ease installation of nvidia drivers on rhel5
#export NV="NVIDIA-Linux-x86_64-180.60-pkg2.run"
#export NV="NVIDIA-Linux-x86_64-190.42-pkg2.run"
#export NV="NVIDIA-Linux-x86_64-260.19.21.run"
export NV="NVIDIA-Linux-x86_64-304.60.run"
export NV="NVIDIA-Linux-x86_64-352.30.run"
export NV="NVIDIA-Linux-x86_64-361.28.run"
SRCDIR="/root/src"
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/libexec/gcc/x86_64-redhat-linux/4.1.1
mkdir $SRCDIR
SELFDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cp $SELFDIR/$NV /root/src
cd $SRCDIR
sh $NV --no-x-check  --no-runlevel-check --ui=none --no-questions --accept-license --run-nvidia-xconfig




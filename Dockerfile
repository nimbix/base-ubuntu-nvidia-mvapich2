FROM nimbix/base-ubuntu-nvidia
MAINTAINER Nimbix, Inc. <support@nimbix.net>

WORKDIR /usr/local/src

RUN apt-get update && apt-get -y install gfortran fort77 build-essential curl libibverbs-dev libibverbs1 libibcm1 librdmacm1 librdmacm-dev rdmacm-utils libibmad-dev libibmad5 byacc libibumad-dev libibumad3 infiniband-diags libmlx5-1 libmlx5-dev perftest ibverbs-utils opensm flex && apt-get clean
RUN curl http://mvapich.cse.ohio-state.edu/download/mvapich/mv2/mvapich2-2.1.tar.gz |tar xzf - && cd mvapich2-2.1 && ./configure  MV2_USE_CUDA=1 RSH_CMD=/usr/bin/ssh SSH_CMD=/usr/bin/ssh && make -j2 && make install && cd .. && rm -rf mvapich2-2.1

# install mvapich2-gdr
# XXX: CUDA 7.0?
WORKDIR /tmp
RUN apt-get -y install alien && apt-get clean
RUN curl http://mvapich.cse.ohio-state.edu/download/mvapich/gdr/2.1/mvapich2-gdr-2.1-cuda-7.0.tar.gz|tar xzf - && alien -c mvapich2-gdr-2.1-cuda-7.0/mvapich2-gdr-cuda7.0-gnu-2.1-1.el6.x86_64.rpm && dpkg --install *.deb && rm -rf mvapich2-gdr-2.1-cuda-7.0 *.deb


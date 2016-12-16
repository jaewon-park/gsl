FROM ubuntu:14.04
MAINTAINER jaewon.park@vt.edu

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y git make g++ gcc \
    python wget

ENV GSL_TAR="gsl-2.3.tar.gz"
ENV GSL_DL="http://ftp.wayne.edu/gnu/gsl/$GSL_TAR"

ENV GSL_ROOT="/gnu/gsl/"
ENV LD_LIBRARY_PATH="$GSL_ROOT/lib:$LD_LIBRARY_PATH"

RUN wget -q $GSL_DL \
    && tar zxvf $GSL_TAR \
    && rm -f $GSL_TAR \
    && cd gsl-2.3 \
    && ./configure --prefix=/usr \
    && make -j 4 \
    && make install

ADD setup.sh /setup.sh
ENTRYPOINT ["/setup.sh"]


    

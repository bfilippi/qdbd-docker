FROM       ubuntu:latest

RUN apt-get clean && apt-get update \
&& apt-get install -y locales net-tools iproute2
RUN apt-get install -y python-numpy
RUN apt-get install -y python-scipy
RUN apt-get install -y python-matplotlib
RUN apt-get install -y ipython
RUN apt-get install -y ipython-notebook
RUN apt-get install -y python-pandas
RUN apt-get install -y python-sympy
RUN apt-get install -y python-nose
RUN locale-gen en_US.UTF-8

# Decompress the QDB tarball in the container
ADD        qdb-*-linux-64bit-server.tar.gz /usr/
ADD        qdb-*-linux-64bit-utils.tar.gz /usr/
ADD        qdb-*-linux-64bit-web-bridge.tar.gz /var/lib/qdb/
ADD        qdb-benchmark-*-Linux.tar.gz /var/lib/qdb/
ADD        quasardb-*py2.7-linux-x86_64.egg /var/lib/qdb/
ADD        notebook.sh /usr/bin
ADD        qdb.ipynb /var/lib/qdb/

#needed to get pip
RUN apt-get install wget


ENV  LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/var/lib/qdb/lib
# Define working directory and installing python API
WORKDIR    /var/lib/qdb
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN easy_install /var/lib/qdb/quasardb-*-py2.7-linux-x86_64.egg

# Expose the port notebook is listening at
EXPOSE     8081
EXPOSE     8080
EXPOSE     2836

ENTRYPOINT ["/usr/bin/notebook.sh"]

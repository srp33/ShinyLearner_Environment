FROM ubuntu:18.04

####################################################################################
# Set environment variables
####################################################################################

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH
ENV TZ=America/Denver

####################################################################################
# Copy install scripts into the container and execute them
####################################################################################

COPY install_debian_packages.sh /
RUN bash /install_debian_packages.sh

COPY install_r_packages.sh /
RUN bash /install_r_packages.sh

COPY install_python_packages.sh /
RUN bash /install_python_packages.sh

####################################################################################
# Configure Java
####################################################################################

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

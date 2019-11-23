FROM ubuntu:18.04

####################################################################################
# Set environment variables
####################################################################################

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH
ENV TZ=America/Denver

####################################################################################
# Copy install scripts into the container
####################################################################################

COPY install*.sh /

####################################################################################
# Install and configure packages
####################################################################################

RUN bash install_debian_packages.sh && \
    bash install_r_packages.sh && \
    bash install_python_packages.sh

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

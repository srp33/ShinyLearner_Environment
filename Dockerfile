FROM ubuntu:18.04

####################################################################################
# Set environment variables
####################################################################################

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
ENV TZ=America/Denver

####################################################################################
# Copy install scripts into the container
####################################################################################

COPY install*.sh /
#COPY entrypoint.sh /usr/local/bin/entrypoint.sh

####################################################################################
# Install and configure packages
####################################################################################

RUN bash install_debian_packages.sh && \
    bash install_r_packages.sh && \
    bash install_python_packages.sh
#&& \
#    chmod +x /usr/local/bin/entrypoint.sh

VOLUME /InputData
VOLUME /OutputData

#ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

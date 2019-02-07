FROM ubuntu:18.04

####################################################################################
# Set environment variables
####################################################################################

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
ENV TZ=America/Denver

####################################################################################
# Install and configure debian packages
####################################################################################

RUN apt-get update --fix-missing && \
    apt-get install -y wget bzip2 ca-certificates curl git openjdk-8-jre-headless apt-transport-https software-properties-common && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 && \
    add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/' && \
    apt-get update && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apt-get -y --allow-unauthenticated install r-base r-base-dev libcurl4-openssl-dev libssl-dev parallel libxml2-dev && \
    find /usr/local/lib/R/site-library/ -depth -wholename '*/html' -exec rm -r "{}" \; && \
    find /usr/local/lib/R/site-library/ -depth -wholename '*/data' -exec rm -r "{}" \; && \
    find /usr/local/lib/R/site-library/ -depth -wholename '*/doc' -exec rm -r "{}" \; && \
    find /usr/local/lib/R/site-library/ -depth -wholename '*/tests' -exec rm -r "{}" \; && \
    find /usr/local/lib/R/site-library/ -depth -wholename '*/examples' -exec rm -r "{}" \; && \
    find /usr/local/lib/R/site-library/ -depth -wholename '*/help' -exec rm -r "{}" \; && \
    find /usr/local/lib/R/site-library/ -depth -wholename '*/www' -exec rm -r "{}" \; && \
    find /usr/local/lib/R/site-library/ -depth -wholename '*/www-dir' -exec rm -r "{}" \; && \
    find /usr/local/lib/R/site-library/ -depth -wholename '*/staticdocs' -exec rm -r "{}" \; && \
    find /usr/local/lib/R/site-library/ -depth -wholename '*/demo' -exec rm -r "{}" \; && \
    find /usr/lib/R/library/ -depth -wholename '*/html' -exec rm -r "{}" \; && \
    find /usr/lib/R/library/ -depth -wholename '*/data' -exec rm -r "{}" \; && \
    find /usr/lib/R/library/ -depth -wholename '*/doc' -exec rm -r "{}" \; && \
    find /usr/lib/R/library/ -depth -wholename '*/tests' -exec rm -r "{}" \; && \
    find /usr/lib/R/library/ -depth -wholename '*/examples' -exec rm -r "{}" \; && \
    find /usr/lib/R/library/ -depth -wholename '*/help' -exec rm -r "{}" \; && \
    find /usr/lib/R/library/ -depth -wholename '*/www' -exec rm -r "{}" \; && \
    find /usr/lib/R/library/ -depth -wholename '*/www-dir' -exec rm -r "{}" \; && \
    find /usr/lib/R/library/ -depth -wholename '*/staticdocs' -exec rm -r "{}" \; && \
    find /usr/lib/R/library/ -depth -wholename '*/demo' -exec rm -r "{}" \; && \
    rm -rf /usr/local/lib/R/site-library/BH && \
    rm -rf /usr/share/mime /usr/share/tcltk  && \
    rm -rf /usr/share/tcltk /usr/share/man && \
    rm -rf /usr/share/doc /usr/share/locale /usr/share/perl5 && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

####################################################################################
# Install R packages
####################################################################################

RUN R -e "install.packages(c('dplyr', 'magrittr', 'readr', 'data.table', 'AUC', 'ROCR', 'RankAggreg', 'mlr', 'C50', 'RRF', 'adabag', 'rpart', 'party', 'kernlab', 'glmnet', 'h2o', 'kknn', 'RSNNS', 'nnet', 'e1071', 'randomForest', 'randomForestSRC', 'ranger', 'klaR', 'sda', 'xgboost', 'parallelMap', 'earth'), repos='https://rweb.crmda.ku.edu/cran/', clean=TRUE, Ncpus=3)"
#RUN R -e "install.packages(c('dplyr', 'magrittr', 'knitr', 'rmarkdown', 'readr', 'data.table', 'AUC', 'ROCR', 'RankAggreg', 'mlr', 'C50', 'RRF', 'adabag', 'rpart', 'party', 'kernlab', 'glmnet', 'h2o', 'kknn', 'RSNNS', 'nnet', 'e1071', 'randomForest', 'randomForestSRC', 'ranger', 'klaR', 'sda', 'xgboost', 'parallelMap', 'earth'), repos='https://rweb.crmda.ku.edu/cran/', clean=TRUE, Ncpus=3)" \

####################################################################################
# Install miniconda and Python 3 modules
####################################################################################

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-4.5.11-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc && \
    conda install scipy numpy scikit-learn pandas keras tensorflow

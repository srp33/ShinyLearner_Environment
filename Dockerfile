FROM openjdk:8u151-jre

ENV PATH /opt/conda/bin:$PATH

##  && R -e "install.packages('mlr', repos='https://rweb.crmda.ku.edu/cran/')" \
##  && R -e "install.packages(c('ggplot2'), repos='https://rweb.crmda.ku.edu/cran/', clean=TRUE, Ncpus=3)" \
#  && apt-get -y --force-yes pandoc \

RUN echo "deb http://cran.rstudio.com/bin/linux/debian stretch-cran34/" >> /etc/apt/sources.list
RUN apt-get update && apt-get -y --allow-unauthenticated install r-base r-base-dev libcurl4-openssl-dev libssl-dev parallel libxml2-dev \
  && R -e "install.packages(c('dplyr', 'magrittr', 'knitr', 'rmarkdown', 'readr', 'data.table', 'AUC', 'ROCR', 'RankAggreg', 'C50', 'RRF', 'adabag', 'rpart', 'party', 'kernlab', 'glmnet', 'h2o', 'kknn', 'RSNNS', 'nnet', 'e1071', 'randomForest', 'randomForestSRC', 'ranger', 'klaR', 'sda', 'xgboost', 'parallelMap'), repos='https://rweb.crmda.ku.edu/cran/', clean=TRUE, Ncpus=3)" \
  && R -e "install.packages('devtools',repos='https://rweb.crmda.ku.edu/cran/')" \
  && R -e "devtools::install_github('mlr-org/mlr')" \
  && apt-get -y --allow-unauthenticated install build-essential python-dev python-setuptools python-numpy python-scipy libatlas-dev libatlas3gf-base \
  && update-alternatives --set libblas.so.3 /usr/lib/atlas-base/atlas/libblas.so.3 \
  && update-alternatives --set liblapack.so.3 /usr/lib/atlas-base/atlas/liblapack.so.3 \
  && find /usr/local/lib/R/site-library/ -depth -wholename '*/html' -exec rm -r "{}" \; \
  && find /usr/local/lib/R/site-library/ -depth -wholename '*/data' -exec rm -r "{}" \; \
  && find /usr/local/lib/R/site-library/ -depth -wholename '*/doc' -exec rm -r "{}" \; \
  && find /usr/local/lib/R/site-library/ -depth -wholename '*/tests' -exec rm -r "{}" \; \
  && find /usr/local/lib/R/site-library/ -depth -wholename '*/examples' -exec rm -r "{}" \; \
  && find /usr/local/lib/R/site-library/ -depth -wholename '*/help' -exec rm -r "{}" \; \
  && find /usr/local/lib/R/site-library/ -depth -wholename '*/www' -exec rm -r "{}" \; \
  && find /usr/local/lib/R/site-library/ -depth -wholename '*/www-dir' -exec rm -r "{}" \; \
  && find /usr/local/lib/R/site-library/ -depth -wholename '*/staticdocs' -exec rm -r "{}" \; \
  && find /usr/local/lib/R/site-library/ -depth -wholename '*/demo' -exec rm -r "{}" \; \
  && find /usr/lib/R/library/ -depth -wholename '*/html' -exec rm -r "{}" \; \
  && find /usr/lib/R/library/ -depth -wholename '*/data' -exec rm -r "{}" \; \
  && find /usr/lib/R/library/ -depth -wholename '*/doc' -exec rm -r "{}" \; \
  && find /usr/lib/R/library/ -depth -wholename '*/tests' -exec rm -r "{}" \; \
  && find /usr/lib/R/library/ -depth -wholename '*/examples' -exec rm -r "{}" \; \
  && find /usr/lib/R/library/ -depth -wholename '*/help' -exec rm -r "{}" \; \
  && find /usr/lib/R/library/ -depth -wholename '*/www' -exec rm -r "{}" \; \
  && find /usr/lib/R/library/ -depth -wholename '*/www-dir' -exec rm -r "{}" \; \
  && find /usr/lib/R/library/ -depth -wholename '*/staticdocs' -exec rm -r "{}" \; \
  && find /usr/lib/R/library/ -depth -wholename '*/demo' -exec rm -r "{}" \; \
  && rm -rf /usr/local/lib/R/site-library/BH \
  #&& apt-get -y remove cpp-4.9 && apt-get -y autoremove \
  && apt-get -y autoremove \
  && rm -rf /usr/share/mime /usr/share/tcltk  \
  && rm -rf /usr/share/tcltk /usr/share/man \
  && rm -rf /usr/share/doc /usr/share/locale /usr/share/perl5




#  && wget --quiet https://repo.continuum.io/miniconda/Miniconda2-4.3.21-Linux-x86_64.sh -O ~/#miniconda.sh \
#  && /bin/bash ~/miniconda.sh -b -p /opt/conda \ 
#  && rm ~/miniconda.sh \
#  && /opt/conda/bin/conda install -y nomkl scikit-learn pandas conda-build \
#  && /opt/conda/bin/conda clean --all \

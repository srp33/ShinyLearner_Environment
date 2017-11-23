FROM openjdk:8u151-jre

ENV PATH /opt/conda/bin:$PATH

RUN echo "deb http://cran.cnr.berkeley.edu/bin/linux/debian jessie-cran3/" >> /etc/apt/sources.list \
  && apt-get update \
  && apt-get -y --force-yes install libcurl4-openssl-dev libssl-dev r-base-core pandoc git parallel \
  && apt-get -y --force-yes install libxml2-dev \
  && R -e "install.packages('devtools',repos='https://rweb.crmda.ku.edu/cran/')" \
  && R -e "devtools::install_github('mlr-org/mlr')" \
##  && R -e "install.packages('mlr', repos='https://rweb.crmda.ku.edu/cran/')" \
  && R -e "install.packages(c('dplyr', 'magrittr', 'knitr', 'rmarkdown', 'readr', 'data.table', 'AUC', 'ROCR', 'RankAggreg', 'ggplot2', 'C50', 'RRF', 'adabag', 'rpart', 'party', 'kernlab', 'glmnet', 'h2o', 'kknn', 'RSNNS', 'nnet', 'e1071', 'randomForest', 'randomForestSRC', 'ranger', 'klaR', 'sda', 'xgboost'), repos='https://rweb.crmda.ku.edu/cran/')" \
  && wget --quiet https://repo.continuum.io/miniconda/Miniconda2-4.3.21-Linux-x86_64.sh -O ~/miniconda.sh \
  && /bin/bash ~/miniconda.sh -b -p /opt/conda \ 
  && rm ~/miniconda.sh \
  && /opt/conda/bin/conda install -y nomkl scikit-learn pandas conda-build \
  && /opt/conda/bin/conda clean --all \
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
  && rm -rf /usr/share/mime /usr/share/mime /usr/share/tcltk /usr/share/man \
  && rm -rf /usr/share/doc /usr/share/locale

#  && rm -rf /usr/share/mime /usr/share/mime /usr/share/perl /usr/share/tcltk /usr/share/man \
#  && rm -rf /usr/share/doc /usr/share/locale /usr/share/perl5

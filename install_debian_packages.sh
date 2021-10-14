# Derived from https://hub.docker.com/r/picoded/ubuntu-openjdk-8-jdk/dockerfile
apt-get update && \
  apt-get install -y openjdk-8-jdk && \
  apt-get install -y ant && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer;
	
apt-get update && \
  apt-get install -y ca-certificates && \
  apt-get install -y ca-certificates-java && \
  apt-get clean && \
  update-ca-certificates -f && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer;

apt-get update --fix-missing && \
  apt-get install -y apt-transport-https && \
  apt-get install -y bzip2 && \
  apt-get install -y curl && \
  apt-get install -y git && \
  apt-get install -y parallel && \
  apt-get install -y software-properties-common && \
  apt-get install -y wget && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 && \
  add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/' && \
  apt-get update && \
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
  apt-get -y --allow-unauthenticated --no-install-recommends install r-base r-base-dev libcurl4-openssl-dev libssl-dev libxml2-dev && \
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
  apt-get clean


# Update to R 4.1.1:
#  apt-get update -qq && \
#  apt install --no-install-recommends software-properties-common dirmngr && \
#  wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc && \
#  add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" && \

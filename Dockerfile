FROM debian:bookworm-slim
ENV TZ=America/Fortaleza
WORKDIR /app
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y wget make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev libmariadb3 libmariadb-dev wkhtmltopdf git
RUN wget -O /opt/Python-3.13.5.tar.xz https://www.python.org/ftp/python/3.13.5/Python-3.13.5.tar.xz
RUN tar -xf /opt/Python-3.13.5.tar.xz -C /opt
RUN cd /opt/Python-3.13.5 && ./configure --enable-optimizations --with-ssl-default-suites=openssl && make && make install
COPY requirements.txt ./
RUN pip3 install --upgrade pip
RUN pip3 install --no-cache-dir -r requirements.txt
RUN apt-get -y clean
RUN apt-get -y autoremove
EXPOSE 80
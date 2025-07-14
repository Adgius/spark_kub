FROM openjdk:11-slim

# Установка Python и Jupyter
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-pip python3-dev build-essential \
    iputils-ping net-tools dnsutils telnet curl && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip setuptools wheel

# Установка JupyterLab и библиотек
RUN pip3 install jupyterlab ipywidgets \
    numpy pandas pyarrow fastparquet \
    sqlalchemy psycopg2-binary pymysql \
    pyspark==3.4.1

ENV JAVA_HOME=/usr/local/openjdk-11
WORKDIR /workspace
EXPOSE 8888

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--NotebookApp.token=''", "--NotebookApp.password=''", "--allow-root"]

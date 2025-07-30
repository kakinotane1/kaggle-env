FROM gcr.io/kaggle-gpu-images/python

ARG UID=1000
ARG GID=1000

USER root

RUN groupmod -g ${GID} jupyter \
 && usermod -u ${UID} -g ${GID} jupyter \
 && chown -R jupyter:jupyter /home/jupyter

USER jupyter

WORKDIR /kaggle

# 追加の Python ライブラリがあれば requirements.txt を用意して以下をアンコメント
# COPY requirements.txt .
# RUN pip install --no-cache-dir -r requirements.txt

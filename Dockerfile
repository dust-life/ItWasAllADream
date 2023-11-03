FROM python:3.8-slim

RUN apt-get update && \
    apt-get install --no-install-recommends -y git curl && \
    rm -rf /var/lib/apt/lists/*

COPY . .

RUN pip3 install poetry pyOpenSSL dsinternals -i https://mirrors.aliyun.com/pypi/simple/ && \
    poetry config virtualenvs.create false && \
    poetry source add --priority=default mirrors https://mirrors.aliyun.com/pypi/simple/ && \
    poetry install

ENTRYPOINT [ "itwasalladream" ]

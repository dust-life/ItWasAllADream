FROM python:3.8-slim

COPY /etc/apt/sources.list /etc/apt/sources.list

RUN apt update && \
    apt install --no-install-recommends -y git curl && \
    apt install proxychains4 && \
    rm -rf /var/lib/apt/lists/*

COPY . .
COPY /etc/proxychains4.conf /tmp/p.conf

RUN pip3 install poetry pyOpenSSL dsinternals -i https://mirrors.aliyun.com/pypi/simple/ && \
    poetry config virtualenvs.create false && \
    poetry source add --priority=default mirrors https://mirrors.aliyun.com/pypi/simple/ && \
    poetry install

ENTRYPOINT [ "proxychains4 -f /tmp/p.conf itwasalladream" ]

FROM python:3.8-slim

RUN printf 'deb https://mirrors.aliyun.com/debian/ bullseye main contrib non-free\ndeb-src https://mirrors.aliyun.com/debian/ bullseye main contrib non-free\ndeb https://mirrors.aliyun.com/debian/ bullseye-updates main contrib non-free\ndeb-src https://mirrors.aliyun.com/debian/ bullseye-updates main contrib non-free\ndeb https://mirrors.aliyun.com/debian/ bullseye-backports main contrib non-free\ndeb-src https://mirrors.aliyun.com/debian/ bullseye-backports main contrib non-free\ndeb https://mirrors.aliyun.com/debian-security/ bullseye-security main contrib non-free\ndeb-src https://mirrors.aliyun.com/debian-security/ bullseye-security main contrib non-free' > /etc/apt/sources.list
RUN apt update && \
    apt install --no-install-recommends -y git curl && \
    apt install proxychains4 && \
    rm -rf /var/lib/apt/lists/*
    
COPY . .
RUN mv ./p.conf /tmp/p.conf

RUN pip3 install poetry pyOpenSSL dsinternals -i https://mirrors.aliyun.com/pypi/simple/ && \
    poetry config virtualenvs.create false && \
    poetry source add --priority=default mirrors https://mirrors.aliyun.com/pypi/simple/ && \
    poetry install

ENTRYPOINT [ "proxychains4 -f /tmp/p.conf itwasalladream" ]

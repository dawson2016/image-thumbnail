FROM alpine:3.9
LABEL maintainer="Dawson.dong  <dawson_2014@163.com>"
RUN  echo 'http://mirrors.ustc.edu.cn/alpine/v3.3/main/' >/etc/apk/repositories && apk update && \
     apk add --no-cache python3 && \
     apk add --no-cache --virtual=build-dependencies \
     gcc python3-dev musl-dev jpeg-dev zlib-dev \
     linux-headers  && \
     python3 -m ensurepip && \
     rm -r /usr/lib/python*/ensurepip && \
     pip3 install --upgrade pip setuptools && \
     pip3 install tornado==4.5 && \
     pip3 install pillow && \
     if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
     if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
     rm -r /root/.cache
ADD app.py /opt/app.py
WORKDIR /opt/
EXPOSE 88
CMD ["python","app.py"]


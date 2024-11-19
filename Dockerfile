FROM ubuntu:18.04

LABEL name="httpbin"
LABEL version="0.9.2"
LABEL description="A simple HTTP service. Delay time updated to 310s by yibei-ali-test"
LABEL org.kennethreitz.vendor="Kenneth Reitz-yibei"

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN apt update -y && apt install python3-pip git -y && pip3 install --no-cache-dir pipenv
ADD Pipfile Pipfile.lock /httpbin/
WORKDIR /httpbin
RUN /bin/bash -c "pip3 install --no-cache-dir -r <(pipenv lock -r)"
RUN pip3 install gunicorn
ADD . /httpbin
RUN pip3 install --no-cache-dir /httpbin

EXPOSE 80

CMD ["/usr/local/bin/gunicorn", "-b", "0.0.0.0:80", "httpbin:app", "-k", "gevent"]

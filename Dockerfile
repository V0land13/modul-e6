FROM python:3.8.2-alpine3.10

RUN adduser -D e6fibo

WORKDIR /home/e6fibo

COPY requirements.txt requirements.txt
RUN python -m venv venv
RUN venv/bin/pip install -r requirements.txt
RUN venv/bin/pip install gunicorn

COPY app app
COPY migrations migrations
COPY e6fibo.py config.py boot.sh ./
RUN chmod +x boot.sh

ENV FLASK_APP e6fibo.py

RUN chown -R e6fibo:e6fibo ./
USER e6fibo

EXPOSE 5000
ENTRYPOINT ["./boot.sh"]
FROM python:3.7

RUN mkdir /app

WORKDIR /app

COPY . /app 

RUN pip install -r /app/requirements.txt

ENV FLASK_APP "entrypoint:app"
ENV FLASK_ENV "development"
ENV APP_SETTINGS_MODULE "config.default"

RUN flask db init
RUN flask db revision --rev-id 1c36c052e9e8
RUN flask db migrate
RUN flask db upgrade

ENV PORT 5000
EXPOSE ${PORT}

CMD ["flask", "run", "--host", "0.0.0.0"]


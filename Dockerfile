FROM python:3.10.5-alpine3.16
LABEL maintainer="mehrdad-khojastefar"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./app /app
WORKDIR /app

EXPOSE 8000

# Creating a virtual environment for our project inside the dockerimage
# Creating a user for our project inside the dockerimage
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    rm -rf /tmp && \
    adduser \
    --disabled-password \
    --no-create-home \
    django-user

ENV PATH="/py/bin:$PATH"

USER django-user
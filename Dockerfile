FROM ubuntu:18.04

USER root

WORKDIR /app

# تثبيت الحزم المطلوبة
RUN apt-get update -y && apt-get install -y \
    python3.6 \
    python3-pip \
    python3.6-venv \
    sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN python3.6 -m venv /app/venv

RUN /app/venv/bin/pip install --upgrade pip

COPY requirements.txt /app/
RUN /app/venv/bin/pip install --no-cache-dir -r /app/requirements.txt

COPY routes.py /app/
COPY templates/ /app/templates/

EXPOSE 5000

CMD ["/app/venv/bin/python", "/app/routes.py"]

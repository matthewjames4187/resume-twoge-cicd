FROM python:alpine AS builder
ENV SQLALCHEMY_DATABASE_URI=

RUN apk update && \
    apk add --no-cache build-base libffi-dev openssl-dev

WORKDIR /app

COPY requirements.txt .

RUN python -m venv venv && \
    source venv/bin/activate && \
    pip install --no-cache-dir -r requirements.txt

FROM python:alpine AS runner

ENV SQLALCHEMY_DATABASE_URI=

WORKDIR /app

COPY --from=builder /app /app

EXPOSE 80

CMD ["python", "app.py"]

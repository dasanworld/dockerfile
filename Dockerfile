FROM node:20-slim

# 루트 권한으로 시스템 패키지 설치
USER root

RUN apt-get update && apt-get install -y \
    curl gnupg sudo \
    && rm -rf /var/lib/apt/lists/*

# n8n 글로벌 설치
RUN npm install -g n8n --legacy-peer-deps

# 작업 디렉토리 지정
WORKDIR /app

# .env 파일 복사 (옵션)
COPY .env /app/.env

# 포트 노출
EXPOSE 5678

# n8n 실행
ENTRYPOINT ["n8n"]

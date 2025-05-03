FROM n8nio/n8n:latest

USER root

# 필수 도구 설치
RUN apt-get update && apt-get install -y \
    sudo curl vim \
    && rm -rf /var/lib/apt/lists/*

# 작업 디렉토리 설정
WORKDIR /app

# 앱 파일 복사
COPY *.json ./
COPY *.js ./
COPY ./bin ./bin
COPY ./public ./public
COPY ./routes ./routes
COPY ./views ./views

# 퍼미션 설정
RUN chown -R node:node .

USER node

# 포트 노출
EXPOSE 3000

# 의존성 설치 (프로덕션 모드)
RUN npm ci --only=production

# 실행 명령
ENTRYPOINT [ "npm", "start" ]





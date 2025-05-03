FROM node:18-slim

# 루트 권한으로 실행
USER root

# 필요한 도구 설치 (apt 사용 가능)
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

# 일반 사용자로 전환
USER node

# 포트 노출
EXPOSE 3000

# 의존성 설치
RUN npm ci --only=production

# 앱 실행
ENTRYPOINT [ "npm", "start" ]

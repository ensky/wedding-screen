FROM node:10

WORKDIR /usr/src/app
EXPOSE 5566
COPY . .
COPY ./src/config/config.sample.json ./src/config/config.json

RUN add-apt-repository ppa:rwky/graphicsmagick && \
	apt update && \
	apt install -y graphicsmagick && \
	npm install && \
	npm run build && \
	npm prune --production

ENV BUILD_IMAGE=Y
ENV TITLE="Happy Wedding"

VOLUME ["/usr/src/app/dist/config", "/usr/src/app/db", "/usr/src/app/src/public/images"]
CMD ["utils/docker-adapter.sh"]

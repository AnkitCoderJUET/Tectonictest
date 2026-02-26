FROM node:20-slim

RUN apt-get update && apt-get install -y curl

# Install Tectonic
RUN curl -fsSL https://drop-sh.fullyjustified.net | sh \
    && mv tectonic /usr/local/bin/

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]
FROM node:20-slim

RUN apt-get update && apt-get install -y \
    curl \
    libgraphite2-3 \
    libharfbuzz0b \
    libfreetype6 \
    libfontconfig1 \
    fonts-dejavu \
    && rm -rf /var/lib/apt/lists/*

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
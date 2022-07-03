#./Dockerfile
FROM node:16
# 기반이 될 이미지

WORKDIR /data

## Install packages
COPY package*.json ./
COPY ./prisma/schema.prisma ./
RUN npm install

# RUN npx prisma generate

# RUN rm ./schema.prisma

COPY . .

# ENV PORT=
# ENV DATABASE_URL=

## Run the application on the port 8000
EXPOSE 8000

CMD ["npm", "start"]

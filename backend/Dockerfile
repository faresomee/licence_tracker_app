FROM node:22

WORKDIR /usr/src/app

#copy every thing from this dir to docker image 
COPY . . 

RUN npm install 

# RUN npm run build

# RUN rm -rf ./src

EXPOSE 8080

CMD ["npm","run","start:devf"]
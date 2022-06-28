#Specify a base image
FROM node:16-alpine as builder

#Specify a working directory
WORKDIR /home/node/app

#Copy the dependencies file
COPY --chown=node:node ./package.json ./

#Install dependencies
RUN npm install

#Copy remaining files
COPY --chown=node:node ./ ./

#Build the project for production
RUN npm run build

#Run Stage Start
FROM nginx

# expose port 80 
EXPOSE 80

#Copy production build files from builder phase to nginx
COPY --from=builder /home/node/app/build /usr/share/nginx/html
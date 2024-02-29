# pull base image Node.JS 14 from Docker hub
FROM node:14 
# create a new directory named app as working directory 
WORKDIR /app
# copy all files from local workdir to container workdir
COPY . .
# set environment variables
ENV NODE_ENV=production DB_HOST=item-db
# run "npm install" command when build image
RUN npm install --production --unsafe-perm && npm run build
# expose port on container
EXPOSE 8080
# run "npm start" when container started
CMD ["npm", "start"] 
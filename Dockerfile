# pull base image NodeJS 18 from Docker hub
FROM node:18-alpine
# create a new directory named app as working directory
WORKDIR /app
# copy all packages files from local to container workdir
COPY package*.json ./
# run "npm install" command when build the image
RUN npm install
# copy all files from local to container workdir
COPY . .
# download wait-for-it script to wait on the availability of a port
RUN apk add --no-cache bash
RUN wget -O /bin/wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh
RUN chmod +x /bin/wait-for-it.sh
# expose port 3000 on container
EXPOSE 3000
# run "npm run start" when container started
CMD ["npm", "run", "start"]
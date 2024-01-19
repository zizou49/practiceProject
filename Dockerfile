#Docker sauvegarde tous les fichiers dans les layers, il rebuild l'image si ces fichiers changenet
FROM circleci/node:10.24-buster-browsers
RUN  addgroup app  && adduser -S -G app app

USER app
WORKDIR /app
#last 'app': name of user
#first 'app' in addUser is name of group created with addgroup: primary group of user app
#-S: create a system user
#groups app: affiche les users apparetnant au group app
#RUN lance les commandes en cours de build du container
#RUN chmod og+x+w+x /app
RUN mkdir data
#all commandes here wil be executed with user app
#COPY hello world.txt .
#good syntax
#COPY ["hello world.txt", "."]
COPY package*.json .
RUN ["npm","install"]
COPY . .
#Permet de copier un file depuis une url dans le rep /app du container
#ADD http://.../file.json .
#permet de compression autimatqiuement du fichier file.zip dans le dossier /app
#ADD file.zip . 
ENV API_URL = http://api.myapp.es/
EXPOSE 3000
#default command: with CMD we run a run time command:shell form
#Lance un autre process /bin/sh
#CMD npm start
#with synatx array no other porcess sh is launched:exec form
#we can ovverdide CMD when run conatiner with different colmmand exp: docker run image echo hello, in this case npm start will not be launched
CMD ["npm","start"]
#with CMD we have more flexiblity and we can ovverdide to launch on other command
#ENTRY is used if we are sure that a spcific command or script should be lanched when run a container
ENTRYPOINT [ "npm","start" ]
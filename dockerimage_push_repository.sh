git clone (your code repo)

  # locate the Dockerfile

docker build -t anilmusinada/docker-class:latest1 .

  # it creates a base image in your docker repository with the given tag

docker run -it anilmusinada/docker-class:latest1

  # -it is an interactive teriminal
  # it will give the out put of the application (here it is a cli application) displays helloworld
  # if your application is a web app it will run here and ec2 mmachine and using the ip we can access the application in the browser

docker login
  # name:
  # password:

docker push anilmusinada/docker-class:latest1
  # it pushes the image into your docker-class docker repo

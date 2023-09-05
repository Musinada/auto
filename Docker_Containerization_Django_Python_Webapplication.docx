Docker Containerization for Django _ #django #python #devops
Getting Started with Django Application
Installing Django

1. Install Python
Python 3.x.y
[GCC 4.x] on Linux
Type "help", "copyright", "credits" or "license" for more information.
>>>

2. u can install Django also using the pip command (Python has) or u can download using the internet.

3.  Verifying: After checking whether installed Django or not.
To verify that Django can be seen by Python, type Python from your shell. Then at the Python prompt, try to import the Django
>>> import django
>>> print(django.get_version())
4.2
You may have another version of Django installed.

4. Writing your first Django app:
python -m django --version

5. Creating a project:
django-admin startproject mysite

This will create a 'mysite' directory in your current directory. If it didn’t work, see Problems running django-admin.
•	Similarly, to ansible galaxy will give a skeleton of ansible role. 
•	Similarly, whenever u r trying to build a project or write a microservice with Django. 
So, django-admin create a skeleton of your project.

Let’s look at what startproject created (project configuration))
mysite/			(folder)
    manage.py
    mysite/			(folder)
        __init__.py
        settings.py
        urls.py
        asgi.py
        wsgi.py

settings.py: It has the entire information of 
•	What are IPs that you are whitelists.
•	What are the Databases you can connect.
•	Any secretekeys or secure information.
•	Probably if you want to use any Django middleware.
•	If you want to support any template.
•	Any webserver gateway interface.
All of these things will setup on settings.py. u can understand it is a settings python file. It will set the entire configuration for your Django Project. 

urls.py
Which is responsible for serving the content.
In the web URL http://10.25.12.03:8080/demo; http://10.25.12.03:8080/admin
Here/demo and /admin is the context root of your application.

So, here the urls.py will understand that if anybody hits/admin or /demo it will search the content on the demo application.
Up to hear u just created a project. But the application is not there.

6. Create your application: up to you have set a base for your application after that u have to create your applications. 
To create your applications, use the following command.

Python manage.py start app 'polls'

Again, here it creates a bunch of files. 		(“polls” name of the application)
That’ll create a directory polls, which is laid out like this:
polls/				(application folder)
    __init__.py
    admin.py
    apps.py
    migrations/
        __init__.py
    models.py
    tests.py
    views.py
This directory structure will house the poll application.

views.py: Inside this, you will write your actual code. 
Eg, def index(request):
              Return render(request, ‘poll_site.html’)
 
Here I wrote a small python function index, which renders an html file. 
This poll.html file you have to place in the template folder and here your content gets served. 

This is the overall work flow of the Django application
___________________________________________________________________________
requirments.txt :
it will have all the dependencies of the application
___________________________________________________________________________
Dockerfile:

FROM ubuntu

WORKDIR   /app

it will store the source code of the web application

COPY requirements.txt /app
COPY devops /app

If you are having programming experience or experience in containerizing python applications,
•	Definitely know that the first thing you need to copy inside the WORKDIR is the requirements.txt file. Because it has Python dependencies that run your application.
•	And also Copy the source code also.
•	Using the source code and dependencies.
o	you will form a bundle or 
o	you will form the binary of your application.

RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
	# If it is a python base image u don’t even to install or if it’s not python image u need to install using the above command.
    pip install -r requirements.txt && \
	# To download the dependencies, we use pip command    
	# Every configuration is done now, my application is good to use
    cd devops

as a devops engineer, what should I put on entrypoint and cmd.
# difference between entry point and cmd;
•	can be used to execute as a start command. 
Eg: docker run here, both entrypoint and cmd can serve as your starting command.
•	But the only difference is Entrypoint which can’t change.
As a user whenever u running a container, they can’t overwrite this value in your docker image.
•	Whereas CMD is something that can be configurable. 
Eg: Here I can change the ip address of the port. 
o	If in your ec2 machine uses 8000 port for any other service, but here in the cmd I have given 8000 port to run django web application. 
o	I cannot get change to get run this container. 
o	For that reason I use executable here. 

ENTRYPOINT ["python3"]
CMD ["manage.py", "runserver", "0.0.0.0:8000"]

Now,
docker build .

Here the docker image is created and also we have the image id

docker run -it <imageiD>

Check whether the application is run or not. I have run this application but I have not shared the port with the application.
The Django Service / Application is running inside my container, it has port 8000 that has exposed. 
But, I am trying to access this application on my ec2 machine.

Now, we need to do port mapping 

docker run -p 8000:8000 -it <imageID>

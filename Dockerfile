#Base image
FROM python:3.14.0a3-alpine3.21

#Workingdirectory
WORKDIR /app

#Copy content from base to container
COPY . . 

#Install depedencies 
RUN pip install -r requirements.txt 


#Expose the Port
EXPOSE 5000

#Run the python application
CMD ["python", "app.py"]


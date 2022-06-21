docker build -t flask-web:latest .
docker tag flask-tutorial:latest localhost:5050/flask-web:v1.0
docker push localhost:5050/flask-web:v1.0

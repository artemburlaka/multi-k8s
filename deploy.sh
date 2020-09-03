docker build -t artburlaka/multi-client:latest -t artburlaka/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t artburlaka/multi-server:latest -t artburlaka/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t artburlaka/multi-worker:latest -t artburlaka/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push artburlaka/multi-client:latest
docker push artburlaka/multi-server:latest
docker push artburlaka/multi-worker:latest

docker push artburlaka/multi-client:$SHA
docker push artburlaka/multi-server:$SHA
docker push artburlaka/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=artburlaka/multi-server:$SHA
kubectl set image deployments/client-deployment client=artburlaka/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=artburlaka/multi-worker:$SHA
docker build -t kirillyershov/multi-client:latest -t kirillyershov/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kirillyershov/multi-server:latest -t kirillyershov/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kirillyershov/multi-worker:latest -t kirillyershov/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kirillyershov/multi-client:latest
docker push kirillyershov/multi-server:latest
docker push kirillyershov/multi-worker:latest

docker push kirillyershov/multi-client:$SHA
docker push kirillyershov/multi-server:$SHA
docker push kirillyershov/multi-worker:$SHA

kubectl apply -f k8s
kubectl set deployments/server-deployment server=kirillyershov/multi-server:$SHA
kubectl set deployments/client-deployment client=kirillyershov/multi-client:$SHA
kubectl set deployments/worker-deployment worker=kirillyershov/multi-worker:$SHA

docker build -t stanikl/multi-client:latest -t stanikl/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t stanikl/multi-server:latest -t stanikl/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t stanikl/multi-worker:latest -t stanikl/multi-worker:c -f ./worker/Dockerfile ./worker
docker push stanikl/multi-client:latest
docker push stanikl/multi-server:latest
docker push stanikl/multi-worker:latest

docker push stanikl/multi-client:$SHA
docker push stanikl/multi-server:$SHA
docker push stanikl/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=stanikl/multi-server:$SHA
kubectl set image deployments/client-deployment server=stanikl/multi-client:$SHA
kubectl set image deployments/worker-deployment server=stanikl/multi-worker:$SHA
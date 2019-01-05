docker build -t alexvak/multi-client:latest -t alexvak/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alexvak/multi-server:latest -t alexvak/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alexvak/multi-worker:latest -t alexvak/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push alexvak/multi-client:latest
docker push alexvak/multi-server:latest
docker push alexvak/multi-worker:latest

docker push alexvak/multi-client:$SHA
docker push alexvak/multi-server:$SHA
docker push alexvak/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment server=alexvak/multi-client:$SHA
kubectl set image deployments/server-deployment server=alexvak/multi-server:$SHA
kubectl set image deployments/worker-deployment server=alexvak/multi-worker:$SHA
docker build -t invicit/multi-client:latest -t invicit/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t invicit/multi-server:latest -t invicit/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t invicit/multi-worker:latest -t invicit/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push invicit/multi-client:latest
docker push invicit/multi-server:latest
docker push invicit/multi-worker:latest
docker push invicit/multi-client:$SHA
docker push invicit/multi-server:$SHA
docker push invicit/multi-worker:$SHA
kubectk apply -f ./k8s
kubectl set image deplotments/server-deployment server=invicit/multi-server:$SHA
kubectl set image deplotments/client-deployment client=invicit/multi-client:$SHA
kubectl set image deplotments/worker-deployment worker=invicit/multi-worker:$SHA
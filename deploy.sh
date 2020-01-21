docker build -t sharibzafar4/multi-client:latest -t sharibzafar4/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sharibzafar4/multi-server:latest -t sharibzafar4/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sharibzafar4/multi-worker:latest -t sharibzafar4/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sharibzafar4/multi-client:latest
docker push sharibzafar4/multi-server:latest
docker push sharibzafar4/multi-worker:latest

docker push sharibzafar4/multi-client:$SHA
docker push sharibzafar4/multi-server:$SHA
docker push sharibzafar4/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments:server-deployment server=sharibzafar4/multi-server:$SHA
kubectl set image deployments:client-deployment client=sharibzafar4/multi-client:$SHA
kubectl set image deployments:worker-deployment worker=sharibzafar4/multi-worker:$SHA
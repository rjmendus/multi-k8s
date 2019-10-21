# Building production images
docker build -t rajatmendus/multi-client:latest -t rajatmendus/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rajatmendus/multi-server:latest -t rajatmendus/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rajatmendus/multi-worker:latest -t rajatmendus/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# Pushing the images to docker hub
docker push rajatmendus/multi-client:latest
docker push rajatmendus/multi-server:latest
docker push rajatmendus/multi-worker:latest
docker push rajatmendus/multi-client:$SHA
docker push rajatmendus/multi-server:$SHA
docker push rajatmendus/multi-worker:$SHA

# Adding the k8s conf files
kubectl apply -f k8s

# Setting the updated images imperatively
kubectl set image deployments/server-deployment server=rajatmendus/multi-server:$SHA
kubectl set image deployments/client-deployment client=rajatmendus/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rajatmendus/multi-worker:$SHA
# Dreamshaper
This uses the sdnext api container to serve the Dreamshaper model

## Build

```shell
docker buildx build \
-t saladtechnologies/sdnext-dreamshaper:latest \
--provenance=false \
--output type=docker \
.
```

## Run

```shell
docker run \
--rm \
--gpus all \
-p 7860:7860 \
-e PORT=7860 \
-e HOST=0.0.0.0 \
saladtechnologies/sdnext-dreamshaper:latest
```

For ipv6 networking, make sure you have the network created:
```shell
docker network create --ipv6 --subnet 2001:0DB8::/112 ip6net
```

and then run the container with the network and the host set to `[::]` (ipv6 localhost)
```shell
docker run \
--rm \
--gpus all \
-p 7860:7860 \
-e PORT=7860 \
-e HOST='[::]' \
--network="ip6net" \
saladtechnologies/sdnext-dreamshaper:latest
```


## Test

```shell
curl -X 'POST' \
  'http://localhost:7860/sdapi/v1/txt2img' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "prompt": "cat",
  "batch_size": 1,
  "steps": 35,
  "cfg_scale": 7,
  "width": 512,
  "height": 512,
  "send_images": true,
  "save_images": false
}' \
 -o ./response.json
```

```shell
cat response.json | jq -r '.images[0]' | base64 -d > cat.jpg
```
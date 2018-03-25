if (docker ps -f name=demo -q)
{
    docker kill demo
}
docker run --name demo --rm --interactive -v "$pwd\out:/app" chui/demo

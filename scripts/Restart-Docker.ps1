$image = "chui/demo"
$container = "demo"

if (docker ps -f name=$container -q)
{
    docker kill $container
}
docker run --name $container --rm --interactive -v "$pwd\out:/app" $image

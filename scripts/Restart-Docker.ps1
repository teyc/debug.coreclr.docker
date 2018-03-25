$image = "chui/demo"
$container = "demo"

if (docker ps -f name=$container -q)
{
    docker kill $container
}
docker run --name $container `
    -p 5000:5000 --rm --interactive `
    -v "$pwd\out:/app" `
    -v "$pwd\web\dist:/app/wwwroot" $image

docker rm demo

while ($true)
{
    docker run -it  --name demo --rm -v "${pwd}\src\out:/app" chui/demo
}

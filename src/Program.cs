using System;

namespace CoreClrDocker
{
    class Program
    {
        static void Main(string[] args)
        {
            while (true)
            {
                Console.WriteLine("Sleeping 2 seconds");
                System.Threading.Thread.Sleep(1000);
                Console.WriteLine("Hello World!");
            }
        }
    }
}

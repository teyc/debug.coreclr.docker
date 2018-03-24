using System;

namespace CoreClrDocker
{
    class Program
    {
        static void Main(string[] args)
        {
            while (true)
            {
                Console.WriteLine("Sleeping 5 seconds");
                System.Threading.Thread.Sleep(5000);
                Console.WriteLine("Hello World!");
            }
        }
    }
}

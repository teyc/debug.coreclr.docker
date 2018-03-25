using System;
using System.Reflection;
using Xunit;

namespace CoreClrDocker.Test
{
    public class UnitTest1
    {
        [Fact]
        public void Test1()
        {
            Assert.Equal(1, typeof(Program).GetMethods(BindingFlags.Static | BindingFlags.NonPublic).Length);
        }
    }
}

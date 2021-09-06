using Autofac;
using Azure.Cosmos.Services;

namespace Azure.Cosmos
{
    public class Program
    {
        static void Main(string[] args)
        {
            new ContainerBuilder()
            .RegisterDependencies()
            .Build()
            .Resolve<IExecutionService>()
            .ExecuteAlgorithm();
        }
    }
}

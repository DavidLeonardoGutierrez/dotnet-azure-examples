using Autofac;
using Azure.Cosmos.Repositories;
using Azure.Cosmos.Services;
using Microsoft.Azure.Cosmos;
using Serilog;
using Serilog.Extensions.Logging;
using Serilog.Sinks.SystemConsole.Themes;

namespace Autofac
{
    public static class ContainerBuilderCustomExtensions
    {
        public static ContainerBuilder RegisterDependencies(this ContainerBuilder containerBuilder)
        {
            RegisterServices(containerBuilder);
            RegisterRepositories(containerBuilder);
            RegisterLogging(containerBuilder);
            RegisterCosmosClient(containerBuilder);

            return containerBuilder;
        }

        private static void RegisterServices(ContainerBuilder containerBuilder)
        {
            containerBuilder.RegisterType<CosmosExecutionService>().As<IExecutionService>();
        }

        private static void RegisterRepositories(ContainerBuilder containerBuilder)
        {
            containerBuilder.RegisterGeneric(typeof(CosmosRepository<>)).As(typeof(ICosmosRepository<>));
        }

        private static void RegisterLogging(ContainerBuilder containerBuilder)
        {
            Log.Logger = new LoggerConfiguration()
                            .WriteTo.Console(theme: AnsiConsoleTheme.Code)
                            .CreateLogger();

            containerBuilder.RegisterInstance<Microsoft.Extensions.Logging.ILogger>(new SerilogLoggerProvider().CreateLogger("Happy logging"));
        }

        private static void RegisterCosmosClient(ContainerBuilder containerBuilder)
        {
            containerBuilder.Register(_ => 
            {
                var connectionString = "";//TODO: Refactor this to use keyvault
                return new CosmosClient(connectionString);
            });
        }
    }
}

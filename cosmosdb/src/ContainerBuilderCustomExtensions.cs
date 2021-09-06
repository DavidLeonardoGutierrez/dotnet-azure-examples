using Autofac;
using Azure.Cosmos.Repositories;
using Azure.Cosmos.Services;
using Microsoft.Extensions.Logging;
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

            return containerBuilder;
        }

        private static void RegisterServices(ContainerBuilder containerBuilder)
        {
            containerBuilder.RegisterType<CosmosExecutionService>().As<IExecutionService>();
        }

        private static void RegisterRepositories(ContainerBuilder containerBuilder)
        {
            containerBuilder.RegisterType<CosmosRepository>().As<ICosmosRepository>();
        }

        private static void RegisterLogging(ContainerBuilder containerBuilder)
        {
            Log.Logger = new LoggerConfiguration()
                            .WriteTo.Console(theme: AnsiConsoleTheme.Code)
                            .CreateLogger();

            containerBuilder.RegisterInstance<Microsoft.Extensions.Logging.ILogger>(new SerilogLoggerProvider().CreateLogger("Happy logging"));
        }
    }
}

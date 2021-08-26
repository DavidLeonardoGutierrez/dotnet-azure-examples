using System;
using Microsoft.Extensions.Logging;
using Serilog;
using Serilog.Extensions.Logging;
using Serilog.Sinks.SystemConsole.Themes;

namespace Azure.Cosmosdb
{
    public class Program
    {
        static void Main(string[] args)
        {
            var logger = BuildLogger();

            logger.LogInformation("Hello from dotnet core");
        }

        private static Microsoft.Extensions.Logging.ILogger BuildLogger()
        {
            var serilogLogger = new LoggerConfiguration()
                .WriteTo.Console(theme: AnsiConsoleTheme.Code)
                .CreateLogger();

                var loggerFactory = new SerilogLoggerProvider(serilogLogger);

                return loggerFactory.CreateLogger("CosmosDb Example");
        }
    }
}

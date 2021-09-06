using System;
using Azure.Cosmos.Repositories;
using Microsoft.Extensions.Logging;

namespace Azure.Cosmos.Services
{
    public class CosmosExecutionService : IExecutionService
    {

        /// <summary>
        /// Inits the Service
        /// </summary>
        /// <param name="repository">The Cosmos Db Repository.</param>
        /// <param name="logger">The logger.</param>
        public CosmosExecutionService(ICosmosRepository repository, ILogger logger)
        {
            this._repository = repository?? throw new ArgumentNullException(nameof(repository));
            this._logger = logger?? throw new ArgumentNullException(nameof(logger));
        }

        /// <summary>
        /// The repository.
        /// </summary>
        private ICosmosRepository _repository;

        /// <summary>
        /// The logger.
        /// </summary>
        private ILogger _logger;

        public void ExecuteAlgorithm()
        {
            this._logger.LogInformation("Hellow with DI world!");
        }
    }
}
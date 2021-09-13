using System;
using Azure.Cosmos.Models;
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
        public CosmosExecutionService(ICosmosRepository<CatModel> repository, ILogger logger)
        {
            this._repository = repository?? throw new ArgumentNullException(nameof(repository));
            this._logger = logger?? throw new ArgumentNullException(nameof(logger));
        }

        /// <summary>
        /// The repository.
        /// </summary>
        private ICosmosRepository<CatModel> _repository;

        /// <summary>
        /// The logger.
        /// </summary>
        private ILogger _logger;

        public void ExecuteAlgorithm()
        {
            this._logger.LogInformation("Starting Demo.");

            this._logger.LogWarning("Adding new pet to the collection...");

            var cat = new CatModel
            {
                Name = "Mayonesa"
            };

            this._repository.Insert(cat);

            this._logger.LogWarning("The cat was added successfully.");

        }
    }
}
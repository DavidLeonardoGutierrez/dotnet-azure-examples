using System;
using System.Threading.Tasks;
using Microsoft.Azure.Cosmos;

namespace Azure.Cosmos.Repositories
{
    public class CosmosRepository<T> : ICosmosRepository<T>
    {
        public CosmosRepository(CosmosClient cosmosClient)
        {
            this._cosmosClient = cosmosClient ?? throw new ArgumentNullException(nameof(_cosmosClient));
        }

        private const string DataBaseName = "pets_db";

        private const string ContainerName = "cats_container";

        private const string ContainerPath = "/Cats";

        private CosmosClient _cosmosClient;

        public async void Insert(object item)
        {
            await this.GetContainer().CreateItemAsync(item);
        }

        public async void Update(object item)
        {
            await this.GetContainer().UpsertItemAsync(item);
        }

        public async void Delete(string id, PartitionKey partitionKey)
        {
            await this.GetContainer().DeleteItemAsync<T>(id, partitionKey);
        }

        public void GetData(object item)
        {
            //await this.GetContainer().<T>(id, partitionKey);
        }

        private async Task<Database> CreateDataBase()
        {
            return await this._cosmosClient.CreateDatabaseIfNotExistsAsync(DataBaseName);
        }

        private Container GetContainer()
        {
            return this._cosmosClient.GetContainer(DataBaseName, ContainerName) 
            ?? throw new Exception("The container does not exist. Please make sure it was created.");
        }
    }
}
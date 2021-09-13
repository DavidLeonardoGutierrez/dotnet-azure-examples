using System.Threading.Tasks;
using Microsoft.Azure.Cosmos;

namespace Azure.Cosmos.Repositories
{
    public interface ICosmosRepository<T>
    {
        void Insert(object item);

        void Update(object item);

        void Delete(string id, PartitionKey partitionKey);

        void GetData(object item);
    }
}

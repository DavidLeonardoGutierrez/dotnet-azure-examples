namespace Azure.Cosmos.Repositories
{
    public interface ICosmosRepository
    {
        void CreateDataBase();

        void DeleteDataBase();

        void Insert(string data);

        void Update(string id, string data);

        void Delete(string id);

        string GetData(string id);
    }
}

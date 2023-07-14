abstract class DAO {
  Future<String> getAll();

  Future<String> getById(String id);

  Future<void> save(String json);

  Future<void> updateById(String json);

  Future<void> deleteById(String id);
}
abstract class SuperService<T, ID> {
  bool add(T t);
  
  bool update(T t);

  bool remove(ID id);

  T getByID(ID id);

  List getAll();
}
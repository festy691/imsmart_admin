

// class SecureStorageManager{
//   SecureStorageManager._internal();
//
//   static SecureStorageManager _instance = SecureStorageManager._internal();
//
//   factory SecureStorageManager() => _instance;
//
//   static SecureStorageManager get instance => _instance;
//
//   save(String key, String value) async {
//     try{
//       await storage.write(key: key, value: value);
//     }catch(e){print(e.toString());}
//   }
//
//   delete(String key) async => await storage.delete(key: key);
//
//   get(String key) async => await storage.read(key: key);
//
//
// }
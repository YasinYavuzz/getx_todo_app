import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ToDoAppController extends GetxController{
  // RxList<Map<String, String>> todoAppList = RxList(); => Bu tarz bir veri tutamayız
  RxList todoAppList = RxList();  // Bu tarz bir tip get
  RxInt noteCount = RxInt(0); 

  GetStorage getStorage = GetStorage();

  
  //List listem = [].obs;

  @override
  void onInit() async {
    //noteShared();
    print('hello');
    todoAppList.addAll(await getStorage.read('list'));
    print(getStorage.read('list'));
    // print(todoAppList);
    super.onInit();
  }

  void noteSaved(Map<String,String> notes){
    noteCount.value++;
    todoAppList.add(notes);
    noteShared();
  }

  void noteRemove(int index){
    todoAppList.removeAt(index);
    noteCount.value--;
    noteShared();
  }

  void noteShared(){
    getStorage.write('list', todoAppList);
  }

} 
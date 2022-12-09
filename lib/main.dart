import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'todo_app_controller.dart';

void main() async{
  await GetStorage.init();
  runApp(const MyToDoApp());
}

class MyToDoApp extends StatelessWidget {
  const MyToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: ToDoApp(),
    );
  }
}

class ToDoApp extends StatelessWidget {
  ToDoApp({super.key});

  ToDoAppController toDoAppController = Get.put(ToDoAppController());
  //var getStorage = GetStorage().read('list');

  TextEditingController controllersNoteTitle = TextEditingController();
  TextEditingController controllersNoteContent = TextEditingController();
  Map<String, String> notes = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDoApp'),
        elevation: 0,
      ),
      body: Obx(
        () {
          // print(getStorage);
          //toDoAppController.todoAppList.value = getStorage;
          return GridView.builder(
            
            padding: const EdgeInsets.all(10),
            itemCount: toDoAppController.todoAppList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemBuilder: (BuildContext context, int index) {
              return GridTile(
                header: Padding(
                  padding: const EdgeInsets.only(right: 3),
                  child: Container(
                    height: 40,
                    color: Colors.amber,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            '  ${toDoAppController.todoAppList[index]['note_title']}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white ),),
                        PopupMenuButton(
                          elevation: 0,
                          icon: const Icon(
                            Icons.more_horiz,
                            color: Colors.white,
                          ),
                          color: Colors.red,
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 0,
                              child: const Text('Sil'),
                              onTap: () {
                                toDoAppController.noteRemove(index);
                              },
                            ),
                            const PopupMenuItem(
                              value: 1,
                              child: Text('Düzenle'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                footer: Padding(
                  padding: const EdgeInsets.only(right: 3),
                  child: Container(
                      margin: const EdgeInsets.only(bottom: 3),
                      //height: 150,
                      child: Text(
                          '  Tarih : ${toDoAppController.todoAppList[index]['note_date']}')),
                ),
                child: Container(
                  padding: const EdgeInsets.only(top: 5),
                  margin: const EdgeInsets.only(top: 48, right: 3),
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(color: Colors.green),
                  child: Text(
                      ' ${toDoAppController.todoAppList[index]['note_content'].length > 20 ? '${toDoAppController.todoAppList[index]['note_content'].toString().substring(0,20)}\n Devamını Göster' : '${toDoAppController.todoAppList[index]['note_content']}'}'),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: const Icon(
          Icons.note_add,
          size: 32,
          color: Colors.red,
        ),
        onPressed: () {
          Get.bottomSheet(SingleChildScrollView(
            child: BottomSheet(
              //backgroundColor: Color.fromARGB(255, 59, 32, 32),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              onClosing: () {
                // print('Kapandı');
                // toDoAppController.noteSaved(notes);
                // print(toDoAppController.todoAppList);
              },
              builder: (context) {
                return Container(
                  width: double.infinity,
                  height: 400,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'Add Note',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: TextField(
                          onChanged: (value) {
                            controllersNoteTitle.text = value.toString();
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Note Title',
                              hintStyle: TextStyle(
                                  color: Colors.grey[500], fontSize: 14)),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // Padding(
                      //   padding:  EdgeInsets.symmetric(horizontal: 50),
                      //   child: TextField(
                      //     style: TextStyle(
                      //       color: Colors.black),
                      //     controller: controllers,
                      //     showCursor: false,
                      //     decoration: InputDecoration(
                      //       //contentPadding:  EdgeInsets.symmetric(vertical: 60,horizontal: 5),
                      //       border:  OutlineInputBorder(
                      //         borderSide: BorderSide(color: Colors.white)
                      //       ),
                      //       fillColor: Colors.white,
                      //       filled: true ,

                      //       // hintText: 'Note Content',
                      //       // hintStyle: TextStyle(
                      //       //   color: Colors.grey[500]
                      //       // )
                      //     ),
                      //   ),
                      // )
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: TextFormField(
                          onChanged: (value) {
                            controllersNoteContent.text = value.toString();
                          },
                          style: const TextStyle(color: Colors.black),
                          textAlign: TextAlign.start,
                          obscureText:
                              true, // true ise girilen yazıyı gizler. şifre gizleme de kullanılır.
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: const EdgeInsets.only(
                                  bottom: 150, left: 5, top: 5),

                              // dekorasyon metin girişi kutusunu biçimlendirebilmemize olanak sağlar.
                              //icon: const Icon(Icons.calendar_today), // icon alır
                              hintText: 'Note Content', // küçülen yazı
                              hintStyle: TextStyle(
                                  color: Colors.grey[500], fontSize: 14)),

                          keyboardType: TextInputType
                              .text, // klavye tipini atabileceğimiz parametre
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: GestureDetector(
                            onTap: () {
                              if (controllersNoteTitle.text == "" || controllersNoteContent.text == "") {
                                Get.dialog(
                                  AlertDialog(
                                    backgroundColor: Colors.redAccent,
                                    title: const Text('Uyarı'),
                                    content: const Text('Note title ve Note content boş bırakılamaz...'),
                                    contentPadding: EdgeInsets.all(30),
                                    actions: [
                                      ElevatedButton(onPressed: () {
                                        Get.back();
                                      }, child: Text('Kapat'))
                                    ],
                                  )
                                );
                              }else{
                                toDoAppController.noteSaved({
                                'note_title': controllersNoteTitle.text,
                                'note_content': controllersNoteContent.text,
                                'note_date':
                                    '${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()} - ${(DateTime.now().hour + 3).toString()}:${DateTime.now().minute.toString().length == 1 ? '0${DateTime.now().minute.toString()}' : '${DateTime.now().minute.toString()}'}',
                              });
                              // controllersNoteTitle.clear();
                              // controllersNoteContent.clear();
                              // controllersNoteTitle.text = "";
                              // controllersNoteContent.text = "";
                              }
                              
                              //toDoAppController.noteSaved(notes);
                              print(toDoAppController.noteCount.value);
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(40)),
                              child: const Center(
                                child: Text(
                                  'Save Note',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                  // decoration: const BoxDecoration(
                  //   borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
                  // ),
                );
              },
            ),
          ));
        },
      ),
    );
  }
}

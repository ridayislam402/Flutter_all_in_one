import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_all_in_one/models/model.dart';
import 'package:flutter_all_in_one/utils/route.dart';
import 'package:flutter_all_in_one/widgets/drawer.dart';
import 'package:flutter_all_in_one/widgets/themes.dart';

import '../widgets/style_widgets.dart';
class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState(){
    super.initState();
    loadData();
  }
var list; //can view with only list
  loadData() async{
    //await Future.delayed(Duration(seconds: 2));
   var catalogJson=await rootBundle.loadString("assets/file/catalog.json");
   var decodeData=jsonDecode(catalogJson);
   var productData=decodeData["products"];
   list=List.from(productData)
       .map<Item>((item) => Item.fromMap(item))
       .toList();
  // print(decodeData);
    setState((){});
  }
  @override
  Widget build(BuildContext context) {
   // final dummylist=List.generate(5, (index) => CatalogModel.item[0],); same item print
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Home Page')),
      actions: [
        ChangeMyTheme()
      ],),
      body:(list!=null && list.isNotEmpty)? ListView.builder(itemBuilder: (context, index) {
      return  StyleWidget(item: list[index],);
      },
          itemCount: list.length)
      :Center(child: CircularProgressIndicator(),),
      drawer: MyDrawer(),
    );
  }


}

class ChangeMyTheme extends StatefulWidget {
  const ChangeMyTheme({Key? key}) : super(key: key);

  @override
  State<ChangeMyTheme> createState() => _ChangeMyThemeState();
}

class _ChangeMyThemeState extends State<ChangeMyTheme> {
  @override
  Widget build(BuildContext context) {

   bool s=true;

    return Switch(value: s, onChanged: (value){
      setState((){
        print("VALUE : $s");
          s=value;
          s?MyTheme.darkTheme:MyTheme.lightTheme;
      }
      );
    });
  }
}

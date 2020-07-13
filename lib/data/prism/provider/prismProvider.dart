import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PrismProvider extends ChangeNotifier {
  final databaseReference = Firestore.instance;
  List prismWalls;
  List subPrismWalls;
  Map wall;
  Future<List> getDataBase() async {
    this.prismWalls = [];
    await databaseReference.collection("walls").getDocuments().then((value) {
      value.documents.forEach((f) => this.prismWalls.add(f.data));
      print(this.prismWalls);
      this.prismWalls.shuffle();
      this.subPrismWalls = this.prismWalls.sublist(0, 24);
    }).catchError((e) {
      print("data done with error");
    });
    return this.subPrismWalls;
  }

  List seeMorePrism() {
    this.subPrismWalls.addAll(this.prismWalls.sublist(this.subPrismWalls.length
        // , this.subPrismWalls.length + 24
        ));
    return this.subPrismWalls;
  }

  Future<Map> getDataByID(String id) async {
    this.wall = null;
    await databaseReference.collection("walls").getDocuments().then((value) {
      value.documents.forEach((element) {
        if (element.data["id"] == id) {
          this.wall = element.data;
        }
      });
      notifyListeners();
      return this.wall;
    });
  }
}

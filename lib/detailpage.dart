import 'package:apiget/common.dart';
import 'package:apiget/userdata.dart';
import 'package:flutter/material.dart';



class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.userData});

  final UserData userData;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: const Text("Detail",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        color: Colors.purple.shade100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset(
                Common.imageCategory(userData.Category),
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 15,),
            Text("Category : ${userData.Category}",style:const TextStyle(fontSize: 16,color: Colors.black),),
            Text("Api : ${userData.API}",style:const TextStyle(fontSize: 16,color: Colors.black),),
            Text("Dec : ${userData.Description}",style:const TextStyle(fontSize: 16,color: Colors.black),
              overflow: TextOverflow.clip,
              maxLines: 1,
              softWrap: false,
            ),
            Text("Auth : ${userData.Auth}",style:const TextStyle(fontSize: 16,color: Colors.black),),
            Text("Link : ${userData.Link}",style:const TextStyle(fontSize: 16,color: Colors.black),
              overflow: TextOverflow.clip,
              maxLines: 1,
              softWrap: false,
            ),
            Text("Core : ${userData.Cors}",style:const TextStyle(fontSize: 16,color: Colors.black),),
            Text("HTTp : ${userData.HTTPS}",style:const TextStyle(fontSize: 16,color: Colors.black),),

          ],
        ),
      ),
    );
  }
}

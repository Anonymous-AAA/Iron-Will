import 'package:flutter/material.dart';
import 'package:iron_will/controller/appdata.dart';
import 'package:iron_will/view/Rank/rank_list_element.dart';

class Rank extends StatelessWidget {
  const Rank({
    Key? key,
    
  }
  ) : super(key: key);

  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon:const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: const Text('My Rank'),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
           
            return RankListElement(
              rank: AppData.getRank()[index],
              colour:AppData.colour(index) ,
            );
          },
          itemCount: AppData.getRank().length-1,
        ));
  }
}

import 'package:flutter/material.dart';
import '../helper/corona_helper.dart';
import '../modal/corona_modal.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Corona>?> getCasesData;

  @override
  void initState() {
    super.initState();
    getCasesData = CoronaHelper.coronaHelper.fetchAllCasesRecordsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          title: Text("Corona Cases",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
          leading: Icon(Icons.coronavirus,color: Colors.black,size: 40,),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[Colors.purple, Colors.blue]
                )
            ),
          )),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            FutureBuilder(
              future: getCasesData,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<Corona>? data = snapshot.data;
                  return ListView.builder(
                    addAutomaticKeepAlives: true,
                    addRepaintBoundaries: true,
                    padding: const EdgeInsets.all(5),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: data?.length,
                    itemBuilder: (context, i) {
                      return Card(
                        elevation: 15,
                        color: Colors.blue.shade50,
                        child: ListTile(
                          minLeadingWidth: 20,
                          autofocus: true,
                          enabled: true,
                          visualDensity: VisualDensity.standard,
                          style: ListTileStyle.list,
                          contentPadding: const EdgeInsets.all(20),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed('cases', arguments: data![i]);
                          },
                          title: Text(
                            data![i].country,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: const Text(
                            "Nation",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                          leading: SizedBox(
                            height: 120,
                            width: 90,
                            child: Image.network(
                              data[i].flag,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("${snapshot.error}"),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
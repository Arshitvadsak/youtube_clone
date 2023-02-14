import 'package:flutter/material.dart';
import 'package:project_one_advance/screens/videoPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpper/api_helpper.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

List<String> search = [];
String name = "song";

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();

  bool isbool = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        backgroundColor: Colors.black54,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                controller: searchController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter your search...";
                  }
                  return null;
                },
                onFieldSubmitted: (val) async {
                  setState(() {
                    name = val;
                    search = name as List<String>;
                    print(search);
                  });
                },
                onSaved: (val) async {},
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  fillColor: Colors.black,
                  hintText: "Search here ....",
                  suffixIcon: IconButton(
                    onPressed: () async {
                      setState(() {
                        isbool = true;
                      });

                      final prefs = await SharedPreferences.getInstance();
                      prefs.setStringList('search', search);
                    },
                    icon: const Icon(Icons.search,color: Colors.black,),
                  ),
                ),
              ),

              // Row(
              //   children: [
              //     SizedBox(width: 20),
              //     Expanded(
              //       flex: 10,
              //       child: TextField(
              //         controller: searchController,
              //         decoration: const InputDecoration(
              //           hintText: "Search by City Name...",
              //           focusedBorder: OutlineInputBorder(
              //             borderSide:
              //             BorderSide(width: 2, color: Colors.black54),
              //           ),
              //         ),
              //       ),
              //     ),
              //     Expanded(
              //       flex: 2,
              //       // child: IconButton(
              //       //   icon: const Icon(Icons.search),
              //       //   onPressed: () {
              //       //     String searchedCity = searchController.text;
              //       //     setState(() {
              //       //       name = YouTubeAPIHelper.postAPIHelper
              //       //           .fetchingMultipleData(search: name) as String;
              //       //     });
              //       //   },
              //       // ),
              //       child: IconButton(
              //             onPressed: () async {
              //               setState(() {
              //                 isbool = true;
              //               });
              //
              //               final prefs = await SharedPreferences.getInstance();
              //               prefs.setStringList('search', search);
              //             },
              //             icon: const Icon(Icons.search,color: Colors.black,),
              //           ),
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 10,
              ),
              (isbool)
                  ? FutureBuilder(
                      future: YouTubeAPIHelper.postAPIHelper
                          .fetchingMultipleData(search: name),
                      builder: (context, snapshot) {
                        List? data = snapshot.data;
                        if (snapshot.hasData) {
                          return SizedBox(
                            height: 740,
                            child: ListView.builder(
                              itemCount: data!.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Display(
                                                url: data[index].userId,
                                              ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image(
                                        image:
                                            NetworkImage(data[index].videoId),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data[index].title,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Text(data[index].chanelTitle),
                                                const Spacer(),
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: const Icon(
                                                      Icons.more_vert,
                                                      size: 20.0),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text("${snapshot.error}"),
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}


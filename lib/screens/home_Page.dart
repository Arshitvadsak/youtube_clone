import 'package:flutter/material.dart';
import 'package:project_one_advance/screens/search_Page.dart';
import 'package:project_one_advance/screens/videoPage.dart';
import '../helpper/api_helpper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("assets/image/youtube-removebg-preview.png"),
              width: 50,
              height: 40,
            ),
            Text("Youtube"),
          ],
        ),
        centerTitle: true,
          actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchPage()),
            );
          },
        ),
      ],
      ),
      body: FutureBuilder(
        future: YouTubeAPIHelper.postAPIHelper
            .fetchingMultipleData(search: "songs"),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          image: NetworkImage(data[index].videoId),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                    child:
                                        const Icon(Icons.more_vert, size: 20.0),
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
      ),
    );
  }
}

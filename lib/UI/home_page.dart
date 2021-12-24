import 'package:demo2/Model/post.dart';
import 'package:demo2/Service/call_list.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Post>? posts;
  bool visible = true;
  TextEditingController filter = TextEditingController();

  filterList(String value) {
    List<Post> temp = [];
    for (var item in (posts as List)) {
      if (item == value) {
        temp.add(item);
      }
    }
    posts = temp;
  }

  getData() async {
    posts = await Posts.getPosts();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Flexible(
              flex: 5,
              child: TextField(
                controller: filter,
                onChanged: (value) {
                  // filterList(value);
                  setState(() {});
                },
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            Flexible(
              flex: 1,
              child: IconButton(
                  onPressed: () {
                    visible = visible ? false : true;
                    setState(() {});
                  },
                  icon: Icon(
                    visible ? Icons.toggle_on : Icons.toggle_off,
                    color: Colors.black,
                    size: 50,
                  )),
            )
          ],
        ),
      ),
      body: posts != null
          ? visible
              ? ListView.builder(
                  itemCount: posts!.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: (posts![index].title!.contains(filter.text))
                        ? InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                context: context,
                                builder: (context) => Wrap(children: [
                                  SizedBox(height: 80),
                                  Text("${posts![index].title}")
                                ]),
                              );
                            },
                            child: Card(child: Text("${posts![index].title}")))
                        : Container(),
                  ),
                )
              : Container()
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

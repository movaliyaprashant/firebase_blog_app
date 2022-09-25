import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comapny_task/src/create_blog/model/blog_data_model.dart';
import 'package:comapny_task/src/create_blog/view/create_blog_screen.dart';

import 'package:comapny_task/src/home/provider/home_provider.dart';
import 'package:comapny_task/src/profile/view/profile_view.dart';
import 'package:comapny_task/src/search/view/search_view.dart';
import 'package:comapny_task/utilities/variable_utilities/variable_utilities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<BlogDataModel> blogData = Provider.of<List<BlogDataModel>>(context);
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateBlogScreen(),
            ),
          );
        },
        child: Container(
          height: 40,
          width: 130,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(
                Icons.add,
                color: Colors.white,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Add Blog",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchScreen()));
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
                size: 30,
              )),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()));
              },
              icon: const Icon(
                Icons.person_rounded,
                color: Colors.white,
                size: 30,
              )),
          const SizedBox(
            width: 15,
          )
        ],
      ),
      body: Consumer<HomeProvider>(
        builder: (context, HomeProvider _homeProvider, child) {
          _homeProvider.getToken();
          List<BlogDataModel> blogData =
              Provider.of<List<BlogDataModel>>(context);
          if (_homeProvider.selectedCategory != "All") {
            blogData = blogData;
            blogData = blogData
                .where((element) =>
                    element.category == _homeProvider.selectedCategory)
                .toList();
          }
          return Column(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "Filter Category :     ",
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                  DropdownButton(
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                      hint: Text(
                        _homeProvider.selectedCategory.toString(),
                      ),
                      items: ["All", "Sport", "Movie"]
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      onChanged: (val) {
                        _homeProvider.selectedCategory = val.toString();
                      }),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                  child: ListView.builder(
                itemCount: blogData.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 250,
                    width: VariableUtilities.size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black45.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(0, 4))
                        ]),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                            image: blogData[index].image == null ||
                                    blogData[index].image.toString().isEmpty ==
                                        true
                                ? const DecorationImage(
                                    image: AssetImage(
                                        "asset/images/place_holder.jpg"),
                                    fit: BoxFit.fill)
                                : DecorationImage(
                                    image: NetworkImage(
                                        "${blogData[index].image}"),
                                    fit: BoxFit.fill,
                                    onError: (exception, stackTrace) {},
                                  ),
                          ),
                          width: VariableUtilities.size.width,
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Text("Title : ${blogData[index].title}"),
                              const Spacer(),
                              Text("Category : ${blogData[index].category}")
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: SizedBox(
                            width: VariableUtilities.size.width,
                            child: Text(
                              "Description :  ${blogData[index].description}",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              )),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}

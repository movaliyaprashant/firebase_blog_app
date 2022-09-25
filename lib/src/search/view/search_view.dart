import 'package:comapny_task/src/search/provider/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SearchProvider>(context, listen: false)
          .getAllData(category: "All");
    });
    // getAllData
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, SearchProvider _searchProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
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
                      _searchProvider.selectedCategory.toString(),
                    ),
                    items: ["All", "User", "Email"]
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (val) {
                      _searchProvider.selectedCategory = val.toString();
                      _searchProvider.getAllData(category: val.toString());
                    }),
              ],
            ),
          ),
          body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  TextField(
                    controller: _searchProvider.searchController,
                    onChanged: (String a) {
                      _searchProvider.searchData(a: a);
                    },
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _searchProvider.searchController.text.length == 0
                      ? Container()
                      : _searchProvider.filterData.length == 0
                          ? Center(
                              child: Text("No Data Available"),
                            )
                          : Expanded(
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: _searchProvider.filterData.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 45,
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(left: 15),
                                    child:
                                        Text(_searchProvider.filterData[index]),
                                  );
                                },
                              ),
                            )
                ],
              )),
        );
      },
    );
  }
}

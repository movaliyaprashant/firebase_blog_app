import 'package:comapny_task/src/create_blog/provider/create_blog_provider.dart';
import 'package:comapny_task/src/home/view/home_screen.dart';
import 'package:comapny_task/utilities/variable_utilities/variable_utilities.dart';
import 'package:comapny_task/utilities/widget/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateBlogScreen extends StatefulWidget {
  const CreateBlogScreen({Key? key}) : super(key: key);

  @override
  State<CreateBlogScreen> createState() => _CreateBlogScreenState();
}

class _CreateBlogScreenState extends State<CreateBlogScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CreateBlogProvider>(context, listen: false).getUserDetails();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Add Blog'),
        ),
        body: Consumer<CreateBlogProvider>(
          builder: (context, CreateBlogProvider _createBlogProvider, child) {
            return _createBlogProvider.isLoading == true
                ? Container(
                    height: VariableUtilities.size.height,
                    width: VariableUtilities.size.width,
                    color: Colors.grey.withOpacity(0.5),
                    child: const Center(child: CircularProgressIndicator()),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.black,
                              child: _createBlogProvider.selectedFile == null
                                  ? const CircleAvatar(
                                      radius: 59,
                                      backgroundColor: Colors.blue,
                                      backgroundImage: AssetImage(
                                          "asset/images/blog_image.png"))
                                  : CircleAvatar(
                                      radius: 59,
                                      backgroundColor: Colors.white,
                                      backgroundImage: FileImage(
                                          _createBlogProvider.selectedFile!)),
                            ),
                            Positioned(
                              top: 78,
                              left: 80,
                              child: IconButton(
                                onPressed: () {
                                  _createBlogProvider
                                      .selectMedia()
                                      .then((value) {
                                    if (value != null) {
                                      final snack =
                                          customSnackBar(title: value);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snack);
                                    }
                                  });
                                },
                                icon: const CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.black,
                                  child: Center(
                                    child: Icon(Icons.edit,
                                        color: Colors.white, size: 20),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: _createBlogProvider.titleController,
                          decoration: const InputDecoration(
                            hintText: "Title",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          maxLines: 3,
                          controller: _createBlogProvider.descriptionController,
                          decoration: const InputDecoration(
                            hintText: "Decription",
                            hintMaxLines: 2,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Category  :    ",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 17),
                            ),
                            DropdownButton(
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                                hint: Text(
                                  _createBlogProvider.selectedCategory
                                      .toString(),
                                ),
                                items: _createBlogProvider.categoryList
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ))
                                    .toList(),
                                onChanged: (val) {
                                  _createBlogProvider.selectedCategory =
                                      val.toString();
                                }),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              _createBlogProvider.isLoading=true;
                              await _createBlogProvider.uploadImage();
                              await _createBlogProvider
                                  .addBlogData(
                                      imageUrl: _createBlogProvider.imageUrl)
                                  .then((value) {
                                _createBlogProvider.isLoading=false;
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                    ),
                                    (route) => false);
                                _createBlogProvider.dispose();
                                final snack = customSnackBar(title: value);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snack);
                              });
                            },
                            child: const Text("Upload"))
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}

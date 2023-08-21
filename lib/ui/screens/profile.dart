import 'package:aaa/data/data_source/data_source.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    if (DataSource.isLoadingProfile) {
      Future.delayed(Duration.zero, () async {
        var data = await DataSource.getDataFromFirebase();
        setState(() {
          DataSource.userData = data;
          DataSource.isLoadingProfile = false;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DataSource.isLoadingProfile
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 15,
                    )
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ListTile(
                    style: ListTileStyle.list,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Colors.black)),
                    title:
                    Row(
                      children: [
                        Text(
                          DataSource.userData!.name,
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                      'Phone Number',
                      style: TextStyle(
                        fontSize: 15,
                      )
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ListTile(
                    style: ListTileStyle.list,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Colors.black)),
                    title: Text(
                      DataSource.userData!.phone,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 15,
                      )
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ListTile(
                    style: ListTileStyle.list,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Colors.black)),
                    title: Text(
                      DataSource.userData!.email,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

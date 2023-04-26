import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/notification_stream_wrapper.dart';
import 'package:flutter_application_1/models/notification.dart';
import 'package:flutter_application_1/utils/firebase.dart';
import 'package:flutter_application_1/widgets/notification_items.dart';

import '../screens/view_image.dart';

class Activities extends StatefulWidget {
  const Activities({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  currentUserId() {
    return firebaseAuth.currentUser!.uid;
  }

  @override
  void initState() {
    super.initState();
    // checkIfFollowing();
    fetchCarouselImages();
  }

  final List<String> _images = [];

  final _firestoreInstance = FirebaseFirestore.instance;
  fetchCarouselImages() async {
    QuerySnapshot qn = await _firestoreInstance.collection("banners").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _images.add(
          qn.docs[i]["mediaUrl"],
        );
        // ignore: avoid_print
        print(qn.docs[i]["mediaUrl"]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Notifications and Updates',
        
        style: TextStyle(
            fontWeight: FontWeight.w900,



        ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: () => deleteAllItems(),
              child: Text(
                'Clear',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
            const ListTile(
                title: Text(
                  "Event Updates",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                  ),
                ),
             
                trailing: Icon(Icons.notifications_active_rounded)),
          CarouselSlider(
            options: CarouselOptions(height:MediaQuery.of(context).size.height/1.85,
            autoPlay: true,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      // autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
            ),
            items: _images.map((i) { 
              return Builder(
                builder: (BuildContext context) {
              if(_images.isNotEmpty){
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        // color: Colors.amber,
                        image: DecorationImage(
                            image: NetworkImage(i), fit: BoxFit.fitWidth)),
                  );
                }
                else {
                  return const Center(
                        child: Text(
                          'No Updates',
                          style: TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                }
                },
              );
            }).toList(),
          ),
          const Divider(),
          const ListTile(
                title: Text(
                  "Notifications",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                  ),
                ),
             
                trailing: Icon(Icons.notifications))
,
          getActivities(),
        ],
      ),
    );
  }
}

getActivities() {
  return ActivityStreamWrapper(
    shrinkWrap: true,
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    stream: notificationRef
        .doc(currentUserId())
        .collection('notifications')
        .orderBy('timestamp', descending: true)
        .limit(20)
        .snapshots(),
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (_, DocumentSnapshot snapshot) {
      ActivityModel activities =
          ActivityModel.fromJson(snapshot.data() as Map<String, dynamic>);
      return ActivityItems(
        activity: activities,
      );
    },
  );
}

deleteAllItems() async {
//delete all notifications associated with the authenticated user
  QuerySnapshot notificationsSnap = await notificationRef
      .doc(firebaseAuth.currentUser!.uid)
      .collection('notifications')
      .get();
  notificationsSnap.docs.forEach(
    (doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    },
  );
}

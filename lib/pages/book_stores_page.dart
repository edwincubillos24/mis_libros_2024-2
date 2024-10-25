import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'detail_store_page.dart';

class BookStoresPage extends StatefulWidget {
  const BookStoresPage({super.key});

  @override
  State<BookStoresPage> createState() => _BookStoresPageState();
}

class _BookStoresPageState extends State<BookStoresPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("stores").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text("Loading...");
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot store = snapshot.data!.docs[index];
                return Card(
                  child: ListTile(
                    leading: Image.network(store["urlPicture"] ?? ""),
                    title: Text(store['name']),
                    subtitle: Text(store['address']),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailStorePage(store)));
                    }
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

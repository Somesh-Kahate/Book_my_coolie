import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coolie/admin/admin_help.dart';
import 'package:coolie/admin/details.dart';
import 'package:coolie/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coolie Admin'),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AdminHelp()));
              },
              child: Text('Help'))
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Users'),
            Tab(text: 'Coolies'),
          ],
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: TabBarView(
          controller: _tabController,
          children: [
            UserTab(),
            CookieTab(),
          ],
        ),
      ),
    );
  }
}

class UserTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshots) {
          if (!snapshots.hasData) return Container();
          return ListView.builder(
            itemCount: snapshots.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> map =
                  snapshots.data!.docs[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(map['Name']),
                subtitle: Text(map['Mobile']),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(snapshots.data!.docs[index].id)
                        .delete();
                    showToast('User Deleted');
                  },
                ),
              );
            },
          );
        });
  }
}

class CookieTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('coolie').snapshots(),
        builder: (context, snapshots) {
          if (!snapshots.hasData) return Container();
          return ListView.builder(
            itemCount: snapshots.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> map =
                  snapshots.data!.docs[index].data() as Map<String, dynamic>;
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CoolieDetails(id: map['uid'])));
                },
                title: Text('${map['Name']} (${map['station']})'),
                subtitle: Text(map['Mobile']),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('coolie')
                        .doc(snapshots.data!.docs[index].id)
                        .delete();
                    showToast('Coolie Deleted');
                  },
                ),
                // Other user details can be displayed here
              );
            },
          );
        });
  }
}

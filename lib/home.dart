import 'package:flutter/material.dart';
import 'getValues.dart';
import 'page2.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Text('User List'),
          actions: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Page2()),
                  );
                },
                child: Icon(Icons.arrow_forward))
          ],
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: fetchUserData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<dynamic> userList = snapshot.data!['data'];
              return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(userList[index]['first_name'] +
                        ' ' +
                        userList[index]['last_name']),
                    subtitle: Text(userList[index]['email']),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(userList[index]['avatar']),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

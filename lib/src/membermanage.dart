import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:mive/src/detail.dart';
import 'package:provider/provider.dart';

import '../provider/memberProvider.dart';

class MemberManage extends StatefulWidget {
  const MemberManage({Key? key}) : super(key: key);

  @override
  State<MemberManage> createState() => _MemberManageState();
}

List _elements = [
  {'name': 'John', 'group': 'Personal'},
  {'name': 'Will', 'group': 'Personal'},
  {'name': 'Beth', 'group': 'Personal'},
  {'name': 'Miranda', 'group': 'Personal'},
  {'name': 'Mike', 'group': 'Personal'},
  {'name': 'Danny', 'group': 'Personal'},
];

class _MemberManageState extends State<MemberManage> {
  late MemberProvider _memberProvider;
  @override
  Widget build(BuildContext context) {
    _memberProvider = Provider.of<MemberProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원관리'),
      ),
      body: GroupedListView<dynamic, String > (

        elements: _memberProvider.ListMembers,
        groupBy: (element) => element['group'],
      groupComparator: (value1, value2) => value2.compareTo(value1),
      itemComparator: (item1, item2) =>
          item1['name'].compareTo(item2['name']),
      order: GroupedListOrder.DESC,
      useStickyGroupSeparators: false,
      groupSeparatorBuilder: (String value) =>
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
      itemBuilder: (c, element) {
        return GestureDetector(
          onTap: () {
            print(element['id']);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Detail(memebrid: element['id'])));
            },
          child: Card(
            elevation: 8.0,
            margin:
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: SizedBox(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                leading: const Icon(Icons.account_circle),
                title: Text(element['name']),
                trailing: const Icon(Icons.arrow_forward),
              ),
            ),
          ),
        );
      },
    ),);
  }
}

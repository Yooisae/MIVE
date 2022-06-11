import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:mive/provider/memberProvider.dart';
import 'package:provider/provider.dart';

class Detail extends StatefulWidget {
  Detail({Key? key, required this.memebrid}) : super(key: key);

  String memebrid;

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  late MemberProvider _memberProvider;

  @override
  Widget build(BuildContext context) {
    _memberProvider = Provider.of<MemberProvider>(context, listen: false);
    // _memberProvider.memberSequence(widget.memebrid);
    print('*************${_memberProvider.memSeq.length}');
    final List<String> seq = _memberProvider.memseq;
    //final String a = seq.first;
    return FutureBuilder(
        future: _memberProvider.memberSequence(widget.memebrid),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              backgroundColor: const Color(0xff4AC1F2),
              appBar: AppBar(
                title: Text(_memberProvider.getmeber(widget.memebrid).name, style: const TextStyle(fontSize: 25),),
                elevation: 0.0,
              ),
              body: Container(
                padding: const EdgeInsets.all(20),
                //color: Colors.white,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '하체',
                      style: TextStyle(fontSize: 20, color: Color(0xff4AC1F2)),
                    ),
                    const Divider(),
                    const Text(
                      '발',
                      style: TextStyle(fontSize: 16, color: Color(0xff4AC1F2)),
                    ),
                    const Divider(),
                    Text(_memberProvider.memSeq[0]),
                    Text(_memberProvider.memSeq[1]),
                    Text(_memberProvider.memSeq[2]),
                    const Divider(),
                    const Text(
                    style: TextStyle(fontSize: 16, color: Color(0xff4AC1F2)),
                    ),
                    const Divider(),
                    Text(_memberProvider.memSeq[3]),
                    Text(_memberProvider.memSeq[4]),
                    Text(_memberProvider.memSeq[5]),
                    const Divider(),
                    const Text(
                      '골반',
                      style: TextStyle(fontSize: 16, color: Color(0xff4AC1F2)),
                    ),
                    const Divider(),
                    Text(_memberProvider.memSeq[6]),
                    Text(_memberProvider.memSeq[7]),
                    Text(_memberProvider.memSeq[8]),
                  ],
                ),
              ),
            );
          }
          else{
            return const Scaffold(
              body: Center(),
            );
          }
        },
      );
  }
}

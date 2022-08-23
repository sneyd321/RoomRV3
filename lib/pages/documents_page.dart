import 'package:flutter/material.dart';
import 'package:lease_generation/business_logic/lease.dart';
import 'package:lease_generation/services/network.dart';
import 'package:lease_generation/widgets/Buttons/PrimaryButton.dart';
import 'package:lease_generation/widgets/Cards/DocumentCard.dart';
import 'package:lease_generation/widgets/Helper/TextHelper.dart';
import 'package:lease_generation/widgets/Listviews/CardListView.dart';

class DocumentPage extends StatefulWidget {
  const DocumentPage({Key? key}) : super(key: key);

  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  Network network = Network();
 

  @override
  Widget build(BuildContext context) {
  
   final double itemHeight = (MediaQuery.of(context).size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = MediaQuery.of(context).size.width / 2;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Documents"),
            ),
            floatingActionButton: SizedBox(
              width: 185,
              height: 100,
              child: FittedBox(
                child: FloatingActionButton.extended(icon: const Icon(Icons.add), label: const Text("Add Lease"), onPressed: () { 
                  Navigator.pushNamed(context, '/AddLeaseViewPager').then((_) => setState(() {}));
                 },),
              ),
            ),
            body: FutureBuilder(
              future: network.getDocuments(1),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Lease>> snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  children = <Widget>[
                    Expanded(
                      child: GridView(
                        
                        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: (itemWidth/itemHeight)),
                      children: snapshot.data!.map<Widget>((Lease lease) => DocumentCard(item: lease, onItemRemoved: (context, lease) {
                        
                      })).toList(),
                      )
                    )
                    
                  ];
                } else if (snapshot.hasError) {
                  children = <Widget>[
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    )
                  ];
                } else {
                  children = const <Widget>[
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    )
                  ];
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: children,
                  ),
                );
              },
            )));
  }
}

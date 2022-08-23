import 'package:flutter/material.dart';
import 'package:lease_generation/business_logic/lease.dart';
import 'package:lease_generation/pages/edit_lease_view_pager.dart';
import 'package:lease_generation/widgets/Buttons/PrimaryButton.dart';
import 'package:lease_generation/widgets/Cards/card_template.dart';
import 'package:lease_generation/widgets/Forms/FormRow/HalfRow.dart';

class DocumentCard extends StatefulCardTemplate<Lease> {
  const DocumentCard(
      {Key? key,
      required item,
      required void Function(BuildContext context, Lease item) onItemRemoved})
      : super(key: key, item: item, onItemRemoved: onItemRemoved);

  @override
  State<DocumentCard> createState() => _DocumentCardState();
}

class _DocumentCardState extends State<DocumentCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: 
        SocialPictureGroup(
            lease: widget.item,
            imgUrl:
                "https://storage.googleapis.com/roomr-222721.appspot.com/istockphoto-1323734048-170667a.jpg",
            color: Colors.blue,
            onTap: () {}),
   
    );
  }
}

class SocialPictureGroup extends StatelessWidget {
  const SocialPictureGroup({
    Key? key,
    required this.imgUrl,
    required this.lease,
    required this.color,
    required this.onTap,
    this.width = 400,
  }) : super(key: key);

  final String imgUrl;
  final Lease lease;
  final Color color;
  final Function onTap;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              onTap();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width,
                  child: Image.network(
                    imgUrl,
                    fit: BoxFit.fitWidth,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(22)),
                    // color: Colors.red
                  ),
                  clipBehavior: Clip.antiAlias,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  lease.documentName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            margin: const EdgeInsets.all(0),
            width: width,
            child: LikeListTile(
              title: lease.rentalAddress.getPrimaryAddress(),
              subtitle: lease.rentalAddress.getSecondaryAddress(),
            )),
        Container(
            width: width,
            child: LikeListTile(
              title: "Tenancy On:",
              subtitle: lease.tenancyTerms.getDateRange(),
            )),
        const SizedBox(
          height: 4,
        ),
        PrimaryButton(Icons.edit, "Finalize", ((context) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditLeaseStatePager(
                lease: lease,
              ),
            ),
          );
        })),
      ],
    );
  }
}

class LikeListTile extends StatelessWidget {
  const LikeListTile(
      {Key? key,
      required this.title,
      required this.subtitle,
      this.color = Colors.grey})
      : super(key: key);
  final String title;
  final String subtitle;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        dense: true,
        visualDensity: VisualDensity(vertical: -4),
        contentPadding: const EdgeInsets.all(0),
        title: Container(
          margin: const EdgeInsets.only(left: 8),
          child: Text(title, style: TextStyle(fontSize: 14),)),
        subtitle: Container(
          margin: const EdgeInsets.only(left: 8),
          child: Text(subtitle, style: TextStyle(fontSize: 14),)));
  }
}

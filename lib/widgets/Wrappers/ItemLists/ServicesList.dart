import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/widgets/Cards/PayPerUseCard.dart';
import 'package:notification_app/widgets/Cards/ServiceCard.dart';
import 'package:notification_app/widgets/Forms/BottomSheetForm/AddNameForm.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';


import '../SliverAddItemStateWrapper.dart';

class ServicesList extends StatefulWidget {
  final List<Service> services;
  const ServicesList({Key? key, required this.services}) : super(key: key);

  @override
  State<ServicesList> createState() => _ServicesListState();
}

class _ServicesListState extends State<ServicesList> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SliverAddItemStateWrapper(
            items: widget.services,
            form: AddNameForm(
                names: const [],
                onSave: (context, name) {
                  if (widget.services.isNotEmpty) {
                      scrollController.animateTo(
                        scrollController.position.maxScrollExtent,
                        duration: const Duration(seconds: 2),
                        curve: Curves.fastOutSlowIn,
                      );
                    }
                  setState(() {
                    widget.services.add(CustomService(name));
                  });
                }),
            addButtonTitle: "Add Service",
            builder: (context, index) {
              Service service = widget.services[index];
              if (service is PayPerUseService) {
                return PayPerUseServiceCard(
                    payPerUseService: service,
                    onItemRemoved: (context, service) {
                      setState(() {
                        widget.services.remove(service);
                      });
                    });
              }
              return ServiceCard(
                  service: service,
                  onItemRemoved: (context, service) {
                    
                    setState(() {
                      widget.services.remove(service);
                    });
                  });
            },
            scrollController: scrollController,
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../dt_sources/ctrl.dart';

class CustomerDetail extends StatefulWidget {
  const CustomerDetail({super.key, required this.id});
  final String id;

  @override
  State<CustomerDetail> createState() => _CustomerDetailState();
}

class _CustomerDetailState extends State<CustomerDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Detail'),
      ),
      body: Center(
        child: FutureBuilder(
          future: getDetail(widget.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.network(snapshot.data!.imageUrl),
                  ),
                  Text(snapshot.data!.id),
                  Text(snapshot.data!.name),
                  Text("Rp: ${snapshot.data!.price}"),
                  Text(
                    snapshot.data!.description,
                    textAlign: TextAlign.justify,
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

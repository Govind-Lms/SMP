import 'package:flutter/material.dart';
import 'package:smp/src/const/style.dart';
import 'package:smp/src/presentations/views/dashboard/components/option_part.dart';
import 'package:smp/src/presentations/views/dashboard/components/recent_clients_part.dart';
import 'package:smp/src/presentations/widgets/custom_app_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Dashboard",
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: CustomScrollView(
          slivers: [
            const OptionsPart(),
            SliverToBoxAdapter(
              child: Container(margin: const EdgeInsets.all(10),child: Text("Recent Clients",style: Style.fourteenBold,)),
            ),
            const RecentClientsPart()
          ],
        ),
      ),
    );
  }
}

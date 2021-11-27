import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestint/widgets/destinations_widget.dart';
import 'package:gestint/widgets/personal_data_widget.dart';

class PersonalFileWidget extends StatefulWidget {
  const PersonalFileWidget({Key? key}) : super(key: key);

  @override
  _PersonalFileWidgetState createState() => _PersonalFileWidgetState();
}

class _PersonalFileWidgetState extends State<PersonalFileWidget> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin<PersonalFileWidget> {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Container(
            color: Color.fromARGB(255, 204, 7, 60),
            child: TabBar(
              isScrollable: true,
              tabs: [
                Tab(
                  text: 'Datos personales',
                ),
                Tab(
                  text: 'Situación actual',
                ),
                Tab(
                  text: 'Hoja de servicios',
                ),
                Tab(
                  text: 'Cargos ocupados',
                ),
                Tab(
                  text: 'Titulaciones',
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            PersonalDataWidget(),
            Icon(Icons.directions_transit),
            DestinationsWidget(),
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
          ],
        ),
      ),
    );
  }

  // This preserve the state of tabs for a better user experience
  @override
  bool get wantKeepAlive => true;

}
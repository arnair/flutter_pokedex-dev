import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_io/io.dart';
import '../../../constants/import_theme.dart';

final pageIndexProvider = StateProvider<int>((ref) => 0);

class HomeFlow extends ConsumerStatefulWidget {
  const HomeFlow({Key? key}) : super(key: key);
  @override
  HomeFlowState createState() => HomeFlowState();
}

class HomeFlowState extends ConsumerState<HomeFlow>
    with WidgetsBindingObserver {
  static const List<Widget> _widgetOptions = <Widget>[
    // SearchScreen(),
    // ChatFlow(),
    // SettingsScreen(),
  ];

  void _onItemTapped(
    int index,
  ) {
    setState(() {
      ref.read(pageIndexProvider.notifier).state = index;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    final int pageIndexProviderLocal = ref.watch(pageIndexProvider);

    return Scaffold(
      body: IndexedStack(
        index: pageIndexProviderLocal,
        children: _widgetOptions,
      ),
      bottomNavigationBar: SizedBox(
        height: Platform.isAndroid ? 48 : null,
        child: BottomNavigationBar(
          selectedFontSize: 0.0,
          unselectedFontSize: 0.0,
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              // icon: Icon(Icons.chat_bubble_outline_outlined),
              icon: Stack(
                alignment: Alignment.topRight,
                children: <Widget>[
                  SizedBox(
                      height: 35,
                      width: 35,
                      child: Icon(Icons.chat_bubble_outline_outlined)),
                  SizedBox()
                ],
              ),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.face_retouching_natural_outlined),
              label: 'Options',
            ),
          ],
          currentIndex: pageIndexProviderLocal,
          selectedItemColor: Palette.red400,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

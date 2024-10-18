import 'package:flutter/material.dart';

class GroceryDetailPage extends StatefulWidget {
  const GroceryDetailPage({super.key});

  @override
  State<GroceryDetailPage> createState() => _GroceryDetailPageState();
}

class _GroceryDetailPageState extends State<GroceryDetailPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const SliverAppBar(
              pinned: true,
              title: SizedBox(
                height: 40,
                child: SearchBar(
                  surfaceTintColor: MaterialStatePropertyAll(Colors.transparent),
                  shadowColor: MaterialStatePropertyAll(Colors.transparent),
                  elevation: MaterialStatePropertyAll(0),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    side: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  )),
                  leading: Icon(Icons.search),
                  hintText: 'Finding something in the shop',
                ),
              ),
            ),
            const SliverAppBar(
              floating: true,
              leading: SizedBox.shrink(),
              flexibleSpace: Placeholder(
                fallbackHeight: 200,
              ),
            ),
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              title: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(
                    child: Text('Store'),
                  ),
                  Tab(
                    child: Text('Products'),
                  ),
                  Tab(
                    child: Text('Category'),
                  ),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            ListView(
              children: const [
                Placeholder(
                  color: Colors.red,
                  fallbackHeight: 200,
                ),
                Placeholder(
                  color: Colors.pink,
                  fallbackHeight: 200,
                ),
                Placeholder(
                  color: Colors.orange,
                  fallbackHeight: 200,
                ),
              ],
            ),
            GridView.builder(
              itemCount: 10,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Placeholder(
                    fallbackHeight: 200,
                  ),
                );
              },
            ),
            ListView.separated(
              itemCount: 5,
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 1,
                  height: 10,
                );
              },
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    color: Colors.red,
                  ),
                  title: const Text('data'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

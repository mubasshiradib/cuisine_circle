import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController srch = TextEditingController();
  List<String> recipe = ['Chicken Biryani','Chicken Curry','Fried Rice','Pasta','Butter Chicken','Chicken Tikka','Vegetable Khichuri',];
  List<String> recent = [];
  List<String> result = [];
  bool found = false;
  void doSrch() {
    String text = srch.text;
    if (text == '') {
      return;
    }
    if (!recent.contains(text)) {
      recent.add(text);
    }
    result.clear();
    for (String r in recipe) {
      if (r.toLowerCase().contains(text.toLowerCase())) {
        result.add(r);
      }
    }
    setState(() {
      found = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(padding: EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(icon: Icon(Icons.arrow_back, color: Colors.brown),
                    onPressed: () {Navigator.pop(context);},
                  ),
                  Image.asset('Assets/Logo_for_all_screen.png', height: 40),
                ],
              ),
              SizedBox(height: 16),
              Container(padding: EdgeInsets.only(left: 16),
                decoration: BoxDecoration(color: Colors.grey.shade200,borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.brown),),
                child: TextField(controller: srch,
                  decoration: InputDecoration(hintText: 'Search for recipes',border: InputBorder.none,
                    suffixIcon: IconButton(icon: Icon(Icons.search, color: Colors.brown),
                      onPressed: doSrch,
                    ),
                  ),
                ),
              ),
              if (recent.isNotEmpty) ...[
                SizedBox(height: 20),
                Text('Recent Searches',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.brown),
                ),
                SizedBox(height: 10),
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (String i in recent)
                      Container(margin: EdgeInsets.only(bottom: 8),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(color: Colors.grey.shade200,borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.brown),
                        ),
                        child: Row(mainAxisSize: MainAxisSize.min,
                          children: [Icon(Icons.history, size: 16, color: Colors.grey),SizedBox(width: 4),
                            Text(i, style: TextStyle(color: Colors.brown)),
                            SizedBox(width: 6),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  recent.remove(i);
                                });
                              },child: Icon(Icons.close, size: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
              SizedBox(height: 20),
              Text('Popular searches in recipes',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.brown),
              ),
              SizedBox(height: 10),
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (String i in recipe)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          srch.text = i;
                        });
                      },
                      child: Container(margin: EdgeInsets.only(bottom: 8),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(color: Colors.grey.shade200,borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.brown),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [Icon(Icons.trending_up, size: 16, color: Colors.brown),
                            SizedBox(width: 4),
                            Text(i, style: TextStyle(color: Colors.brown)),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              if (found) ...[
                SizedBox(height: 20),
                Text('Search Results',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.brown),
                ),
                SizedBox(height: 10),
                if (result.isEmpty)Text('No recipes found', style: TextStyle(color: Colors.grey))
                else
                  for (String r in result)
                    Container(margin: EdgeInsets.only(bottom: 8),padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.restaurant, color: Colors.brown),
                          SizedBox(width: 10),
                          Text(r, style: TextStyle(color: Colors.brown)),
                        ],
                      ),
                    ),
              ],

            ],
          ),
        ),
    );
  }
}

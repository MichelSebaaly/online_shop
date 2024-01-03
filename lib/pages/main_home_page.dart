import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:online_shop/pages/profile.dart';
import 'package:online_shop/screens/cart_screen.dart';
import 'login.dart';
import '../screens/detail_screen.dart';
import 'package:http/http.dart' as http;

class MainHomePage extends StatefulWidget {
  final bool? isLoggedin;
  final String? username;
  final String? email;

  const MainHomePage({Key? key, this.isLoggedin, this.username, this.email}) : super(key: key);

  @override
  State<MainHomePage> createState() => MainHomePageState();
}

class MainHomePageState extends State<MainHomePage> {
  int _selectedIndex = 0;

  bool get isLoggedin => widget.isLoggedin ?? false;
  List<Product> products = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<List<Product>> fetchProducts() async {
    // var url = Uri.parse("http://192.168.56.1/online_Shop/fetchProducts.php");
    try {
      final response = await http.get(Uri.parse("http://192.168.0.110/online_Shop/fetchProducts.php"));
      // print("API Response: ${response.body}");
      if (response.statusCode == 200) {//
        if(response.body.isNotEmpty){
          // final List<dynamic> productsJson = jsonDecode(response.body);
          final result = jsonDecode(response.body);

          List<Product> lst = [];
          
          for(int i = 0 ; i < result.length ; i++){
            lst.add(Product(id: result[i]['productId'], name: result[i]['prodName'], price: result[i]['prodPrice'], imageUrl: result[i]['prodImage']));
          }

          return lst;
        } else {
          throw Exception("Body is empty");
        }

      } else {
        throw Exception('Status code is != 200');
      }
    } catch (error) {
      // print('Error fetching products: $error');
      throw Exception('Error fetching products: $error');
      // Handle the error as needed
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   // Fetch products when the widget is initialized
  //   fetchProducts();
  // }

  @override
  void initState() {
    super.initState();

    // Fetch products when the widget is initialized//
    _loadProducts();
  }

  void _loadProducts() async {
    try {
      final loadedProducts = await fetchProducts();
      setState(() {
        products = loadedProducts!;
      });
    } catch (error) {
      print('Error loading products: $error');
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
                onPressed: () {
                  !isLoggedin
                      ? Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()))
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(
                              login: isLoggedin,
                              username: widget.username!,
                              useremail: widget.email!,
                            ),
                          ),
                        );
                },
                icon: Icon(Icons.person)),
            label: isLoggedin ? 'Profile' : 'login',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      backgroundColor: const Color(0xfFE9EBEA),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60.0, left: 18, right: 10),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 280,
                      child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.search,
                              size: 40,
                              color: Colors.grey,
                            ),
                            hintText: 'Search..',
                            hintStyle: const TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                    ),
                    // const SizedBox(
                    //   width: 10,
                    // ),
                    // const Badge(
                    //   label: Text('1'),
                    //   child: Image(
                    //       height: 30,
                    //       width: 30,
                    //       image: AssetImage(
                    //         'assets/icons/bag.png',
                    //       )),
                    // ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartPage()));
                        },
                        icon: Icon(Icons.shopping_bag)),
                    // const SizedBox(
                    //   width: 10,
                    // ),
                    const Badge(
                      label: Text('9+'),
                      child: Image(
                          height: 30,
                          width: 30,
                          image: AssetImage(
                            'assets/icons/comment.png',
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                  height: 180,
                  width: 400,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                      'assets/images/main.png',
                    )),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Row(
                  children: [
                    Container(
                      height: 130,
                      width: 390,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 53,
                                    width: 53,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffF6F6F6),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                        child: const Icon(
                                      Icons.grid_view_outlined,
                                      size: 32,
                                    )),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  const Text(
                                    'Category',
                                    style: TextStyle(fontSize: 17),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 53,
                                    width: 53,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffF6F6F6),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Icon(
                                      Icons.flight,
                                      size: 32,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  const Text('Flight'),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 53,
                                    width: 53,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffF6F6F6),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                        child: const Icon(
                                      Icons.receipt_long,
                                      size: 32,
                                    )),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  const Text(
                                    'Bill',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 53,
                                    width: 53,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffF6F6F6),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                        child: const Icon(
                                      Icons.data_exploration_outlined,
                                      size: 32,
                                    )),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  const Text(
                                    'Data Plan',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 53,
                                    width: 53,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffF6F6F6),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                        child: const Icon(
                                      Icons.upcoming_outlined,
                                      size: 32,
                                    )),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  const Text(
                                    'TopUp',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Best Sale Product',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'See more',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2A977D),
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(height: 20,),

              // ListView.separated(
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemCount: products.length,
              //   separatorBuilder: (context, index) => SizedBox(height: 10),
              //   itemBuilder: (context, index) {
              ////
              //
              //
              //   },
              // ),


              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: products.length,

                itemBuilder: (BuildContext context, int index){

                  Product product = products[index];

                  return InkWell(//
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(),
                        ),
                      );
                    },
                    child:

                    Container(
                      height: 257,
                      width: 170,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Image(
                              image: AssetImage("assets/images/${product.imageUrl}"),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment : MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                    ),
                                    Text(
                                      '4.9 | 2336',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      '\$${product.price}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Color(0xff2A977D)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),


                  );
                },

              ),


            ],
          ),
      ),
    );
  }
}

class Product {
  final String id;
  final String name;
  final String price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      imageUrl: json['url'],
    );
  }
}

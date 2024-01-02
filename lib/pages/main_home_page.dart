import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:online_shop/pages/profile.dart';
import 'package:online_shop/screens/cart_screen.dart';
import 'login.dart';
import '../screens/detail_screen.dart';

class MainHomePage extends StatefulWidget {
  final bool? isLoggedin;

  const MainHomePage({Key? key, this.isLoggedin}) : super(key: key);

  @override
  State<MainHomePage> createState() => MainHomePageState();
}

class MainHomePageState extends State<MainHomePage> {
  int _selectedIndex = 0;

  bool get isLoggedin => widget.isLoggedin ?? false;
  List<Product> products = [];

  get http => null;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<List<Product>?> fetchProducts() async {
    // var url = Uri.parse("http://192.168.56.1/online_Shop/fetchProducts.php");
    try {
      final response = await http.get(Uri.parse("http://192.168.56.1/online_Shop/fetchProducts.php"));
      print("API Response: ${response.body}");
      if (response.statusCode == 200) {
        final List<dynamic> productsJson = jsonDecode(response.body);

        setState(() {
          products = productsJson.map((productJson) {
            return Product(
              id: productJson['productId'],
              name: productJson['prodName'],
              price: productJson['prodPrice'].toDouble(),
              imageUrl: productJson['prodImage'],
            );
          }).toList();
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      print('Error fetching products: $error');
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

    // Fetch products when the widget is initialized
    _loadProducts();
  }

  Future<void> _loadProducts() async {
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
                              username: 'John Doe',
                              useremail: 'john.doeexample.com',
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
      body: ListView(
        children: [
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

              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: products.length,
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemBuilder: (context, index) {
                  Product product = products[index];

                  return InkWell(
                    onTap: () {
                      // Navigate to the product details page or perform some action
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(),
                        ),
                      );
                    },
                    child: Container(
                      height: 257,
                      width: 170,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image(
                            height: 124,
                            image: AssetImage(product.imageUrl),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                // Text(
                                // product.description,
                                //   style: TextStyle(
                                //       fontWeight: FontWeight.bold, fontSize: 15),
                                // ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
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
                                      '\$${product.price.toStringAsFixed(2)}',
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

              // men hon
              //       Padding(
              //         padding:
              //             const EdgeInsets.only(top: 20.0, left: 18, right: 18),
              //         child: Row(
              //           children: [
              //             Container(
              //               height: 250,
              //               width: 170,
              //               color: Colors.white,
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.start,
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   const Image(
              //                     height: 118,
              //                     image: AssetImage('assets/images/shirt1.png'),
              //                   ),
              //                   const SizedBox(
              //                     height: 5,
              //                   ),
              //                   Padding(
              //                     padding: const EdgeInsets.all(8.0),
              //                     child: Column(
              //                       mainAxisAlignment: MainAxisAlignment.start,
              //                       crossAxisAlignment: CrossAxisAlignment.start,
              //                       children: [
              //                         const Text(
              //                           'Shirt',
              //                           style: TextStyle(
              //                               color: Colors.grey,
              //                               fontWeight: FontWeight.bold),
              //                         ),
              //                         const SizedBox(
              //                           height: 5,
              //                         ),
              //                         const Text(
              //                           "Essential Men's Shirt-\nSleeve Crewneck T-Shirt",
              //                           style: TextStyle(
              //                               fontWeight: FontWeight.bold,
              //                               fontSize: 15),
              //                         ),
              //                         const SizedBox(
              //                           height: 10,
              //                         ),
              //                         Row(
              //                           children: const [
              //                             Icon(
              //                               Icons.star,
              //                               color: Colors.orange,
              //                             ),
              //                             Text(
              //                               '4.9 | 2336',
              //                               style: TextStyle(
              //                                 color: Colors.grey,
              //                                 fontWeight: FontWeight.bold,
              //                               ),
              //                             ),
              //                             SizedBox(
              //                               width: 3,
              //                             ),
              //                             Text(
              //                               '\$12.00',
              //                               style: TextStyle(
              //                                   fontWeight: FontWeight.bold,
              //                                   fontSize: 20,
              //                                   color: Color(0xff2A977D)),
              //                             )
              //                           ],
              //                         )
              //                       ],
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //             const SizedBox(
              //               width: 15,
              //             ),
              //             InkWell(
              //               onTap: () {
              //                 Navigator.push(
              //                     context,
              //                     MaterialPageRoute(
              //                         builder: (context) => DetailPage()));
              //               },
              //               child: Container(
              //                 height: 257,
              //                 width: 170,
              //                 color: Colors.white,
              //                 child: Column(
              //                   mainAxisAlignment: MainAxisAlignment.start,
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     const Image(
              //                       height: 124,
              //                       image: AssetImage('assets/images/shirt4.png'),
              //                     ),
              //                     const SizedBox(
              //                       height: 5,
              //                     ),
              //                     Padding(
              //                       padding: const EdgeInsets.all(8.0),
              //                       child: Column(
              //                         mainAxisAlignment: MainAxisAlignment.start,
              //                         crossAxisAlignment: CrossAxisAlignment.start,
              //                         children: [
              //                           const Text(
              //                             'Shirt',
              //                             style: TextStyle(
              //                                 color: Colors.grey,
              //                                 fontWeight: FontWeight.bold),
              //                           ),
              //                           const SizedBox(
              //                             height: 5,
              //                           ),
              //                           const Text(
              //                             "Essential Men's Short-\nSleeve Crewneck T-Shirt",
              //                             style: TextStyle(
              //                                 fontWeight: FontWeight.bold,
              //                                 fontSize: 15),
              //                           ),
              //                           const SizedBox(
              //                             height: 10,
              //                           ),
              //                           Row(
              //                             children: const [
              //                               Icon(
              //                                 Icons.star,
              //                                 color: Colors.orange,
              //                               ),
              //                               Text(
              //                                 '4.9 | 2336',
              //                                 style: TextStyle(
              //                                   color: Colors.grey,
              //                                   fontWeight: FontWeight.bold,
              //                                 ),
              //                               ),
              //                               SizedBox(
              //                                 width: 3,
              //                               ),
              //                               Text(
              //                                 '\$12.00',
              //                                 style: TextStyle(
              //                                     fontWeight: FontWeight.bold,
              //                                     fontSize: 20,
              //                                     color: Color(0xff2A977D)),
              //                               )
              //                             ],
              //                           )
              //                         ],
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //la hon
              // Padding(
              //   padding:
              //       const EdgeInsets.only(top: 20.0, left: 18, right: 18),
              //   child: Row(
              //     children: [
              //       Container(
              //         height: 250,
              //         width: 170,
              //         color: Colors.white,
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             const Image(
              //               height: 118,
              //               image: AssetImage('assets/images/shirt1.png'),
              //             ),
              //             const SizedBox(
              //               height: 5,
              //             ),
              //             Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.start,
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   const Text(
              //                     'Shirt',
              //                     style: TextStyle(
              //                         color: Colors.grey,
              //                         fontWeight: FontWeight.bold),
              //                   ),
              //                   const SizedBox(
              //                     height: 5,
              //                   ),
              //                   const Text(
              //                     "Essential Men's Short-\nSleeve Crewneck T-Shirt",
              //                     style: TextStyle(
              //                         fontWeight: FontWeight.bold,
              //                         fontSize: 15),
              //                   ),
              //                   const SizedBox(
              //                     height: 10,
              //                   ),
              //                   Row(
              //                     children: const [
              //                       Icon(
              //                         Icons.star,
              //                         color: Colors.orange,
              //                       ),
              //                       Text(
              //                         '4.9 | 2336',
              //                         style: TextStyle(
              //                           color: Colors.grey,
              //                           fontWeight: FontWeight.bold,
              //                         ),
              //                       ),
              //                       SizedBox(
              //                         width: 3,
              //                       ),
              //                       Text(
              //                         '\$12.00',
              //                         style: TextStyle(
              //                             fontWeight: FontWeight.bold,
              //                             fontSize: 20,
              //                             color: Color(0xff2A977D)),
              //                       )
              //                     ],
              //                   )
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       const SizedBox(
              //         width: 15,
              //       ),
              //       Container(
              //         height: 257,
              //         width: 170,
              //         color: Colors.white,
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             const Image(
              //               height: 124,
              //               image: AssetImage('assets/images/shirt4.png'),
              //             ),
              //             const SizedBox(
              //               height: 5,
              //             ),
              //             Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.start,
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   const Text(
              //                     'Shirt',
              //                     style: TextStyle(
              //                         color: Colors.grey,
              //                         fontWeight: FontWeight.bold),
              //                   ),
              //                   const SizedBox(
              //                     height: 5,
              //                   ),
              //                   const Text(
              //                     "Essential Men's Short-\nSleeve Crewneck T-Shirt",
              //                     style: TextStyle(
              //                         fontWeight: FontWeight.bold,
              //                         fontSize: 15),
              //                   ),
              //                   const SizedBox(
              //                     height: 10,
              //                   ),
              //                   Row(
              //                     children: const [
              //                       Icon(
              //                         Icons.star,
              //                         color: Colors.orange,
              //                       ),
              //                       Text(
              //                         '4.9 | 2336',
              //                         style: TextStyle(
              //                           color: Colors.grey,
              //                           fontWeight: FontWeight.bold,
              //                         ),
              //                       ),
              //                       SizedBox(
              //                         width: 3,
              //                       ),
              //                       Text(
              //                         '\$12.00',
              //                         style: TextStyle(
              //                             fontWeight: FontWeight.bold,
              //                             fontSize: 20,
              //                             color: Color(0xff2A977D)),
              //                       )
              //                     ],
              //                   )
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Padding(
              //   padding:
              //       const EdgeInsets.only(top: 20.0, left: 18, right: 18),
              //   child: Row(
              //     children: [
              //       Container(
              //         height: 250,
              //         width: 170,
              //         color: Colors.white,
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             const Image(
              //               height: 118,
              //               image: AssetImage('assets/images/shirt3.png'),
              //             ),
              //             const SizedBox(
              //               height: 5,
              //             ),
              //             Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.start,
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   const Text(
              //                     'Shirt',
              //                     style: TextStyle(
              //                         color: Colors.grey,
              //                         fontWeight: FontWeight.bold),
              //                   ),
              //                   const SizedBox(
              //                     height: 5,
              //                   ),
              //                   const Text(
              //                     "Essential Men's Short-\nSleeve Crewneck T-Shirt",
              //                     style: TextStyle(
              //                         fontWeight: FontWeight.bold,
              //                         fontSize: 15),
              //                   ),
              //                   const SizedBox(
              //                     height: 10,
              //                   ),
              //                   Row(
              //                     children: const [
              //                       Icon(
              //                         Icons.star,
              //                         color: Colors.orange,
              //                       ),
              //                       Text(
              //                         '4.9 | 2336',
              //                         style: TextStyle(
              //                           color: Colors.grey,
              //                           fontWeight: FontWeight.bold,
              //                         ),
              //                       ),
              //                       SizedBox(
              //                         width: 3,
              //                       ),
              //                       Text(
              //                         '\$12.00',
              //                         style: TextStyle(
              //                             fontWeight: FontWeight.bold,
              //                             fontSize: 20,
              //                             color: Color(0xff2A977D)),
              //                       )
              //                     ],
              //                   )
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       const SizedBox(
              //         width: 15,
              //       ),
              //       Container(
              //         height: 257,
              //         width: 170,
              //         color: Colors.white,
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             const Image(
              //               height: 124,
              //               image: AssetImage('assets/images/shirt2.png'),
              //             ),
              //             const SizedBox(
              //               height: 5,
              //             ),
              //             Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.start,
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   const Text(
              //                     'Shirt',
              //                     style: TextStyle(
              //                         color: Colors.grey,
              //                         fontWeight: FontWeight.bold),
              //                   ),
              //                   const SizedBox(
              //                     height: 5,
              //                   ),
              //                   const Text(
              //                     "Essential Men's Short-\nSleeve Crewneck T-Shirt",
              //                     style: TextStyle(
              //                         fontWeight: FontWeight.bold,
              //                         fontSize: 15),
              //                   ),
              //                   const SizedBox(
              //                     height: 10,
              //                   ),
              //                   Row(
              //                     children: const [
              //                       Icon(
              //                         Icons.star,
              //                         color: Colors.orange,
              //                       ),
              //                       Text(
              //                         '4.9 | 2336',
              //                         style: TextStyle(
              //                           color: Colors.grey,
              //                           fontWeight: FontWeight.bold,
              //                         ),
              //                       ),
              //                       SizedBox(
              //                         width: 3,
              //                       ),
              //                       Text(
              //                         '\$12.00',
              //                         style: TextStyle(
              //                             fontWeight: FontWeight.bold,
              //                             fontSize: 20,
              //                             color: Color(0xff2A977D)),
              //                       )
              //                     ],
              //                   )
              //                 ],
              // ),
              // ),
            ],
          ),
        ],
      ),
    );
    //       ],
    //     ),
    //   ],
    // ));
  }
}

class Product {
  final int id;
  final String name;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}

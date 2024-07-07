import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce App',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1; // Set default selected index to ProductScreen (1)

  static List<Widget> _widgetOptions = <Widget>[
    LoginScreen(),
    ProductScreen(),
    AboutScreen(),
    ContactScreen(), // Added ContactScreen
  ];

  static List<int> _appBarScreens = [1]; // List of screens that require app bar (ProductScreen)

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarScreens.contains(_selectedIndex)
          ? AppBar(
              title: Row(
                children: [
                  Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbYWzxOUpg-mzWeAXIZDk84tzfVBpz9hRWxA&s',
                    width: 30, // Adjust size as needed
                    height: 30, // Adjust size as needed
                  ),
                  SizedBox(width: 8),
                  Text('Destiny'),
                ],
              ),
              backgroundColor: Colors.white,
              actions: [
                IconButton(
                  icon: Icon(Icons.search_sharp),
                  onPressed: () {
                    // Handle search button press
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.shopping_basket),
                  onPressed: () {
                    // Navigate to CartScreen
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CartScreen(),
                      ),
                    );
                  },
                ),
              ],
            )
          : null,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'LOGIN',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'ABOUT',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail), // Changed icon to Contact icon
            label: 'CONTACT', // Changed label to 'CONTACT'
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: IconThemeData(size: 30),
        onTap: _onItemTapped,
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submitForm(BuildContext context) {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Basic validation (you can implement more advanced validation logic here)
    if (username == 'SAI' && password == '123456') {
      print('Username: $username');
      print('Password: $password');

      // Navigate to HomeScreen after successful login
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      // Show an error message or handle invalid input
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Invalid username or password.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color for the scaffold
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Background image
          Image.network(
            'https://images.pexels.com/photos/1103970/pexels-photo-1103970.jpeg?auto=compress&cs=tinysrgb&w=600',
            fit: BoxFit.cover,
          ),
          // Login form centered
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8, // Adjust width as needed
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white.withOpacity(0.8), // White with opacity
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Colors.black), // Label text color
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black), // Border color when focused
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.black), // Label text color
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black), // Border color when focused
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        _submitForm(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductScreen extends StatelessWidget {
  final List<Map<String, String>> products = [
    {
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBYcAFZV_11zePxhbOv6q3wXjNZa9KWRzpEw&s',
      'title': 'wedding card new',
      'price': '₹45',
      'discount': '10% savings',
      'mrp': 'M.R.P.: ₹1,000',
      'taxes': 'Inclusive of all taxes',
    },
    {
      'image': 'https://marketplace.canva.com/EAFxJRfg2jQ/1/0/1135w/canva-blue-and-white-floral-wedding-invitation-wzs3ZlGJyfM.jpg',
      'title': 'perfect wedding  ',
      'price': '₹49',
      'discount': '18% savings',
      'mrp': 'M.R.P.: ₹100.00',
      'taxes': 'Inclusive of all taxes',
    },
    {
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvbhOyGToYFC7vyMRLLbCjH-3VYsGQ9Wwv6nIIN0Ude702ddZEqE_0utPdxLNe2pQa6ro&usqp=CAU',
      'title': 'offical wedding',
      'price': '₹99.00',
      'discount': '10% savings',
      'mrp': 'M.R.P.: ₹1000.00',
      'taxes': 'Inclusive of all taxes',
    },
    {
      'image': 'https://www.shutterstock.com/shutterstock/photos/2025534518/display_1500/stock-vector-wedding-invitation-template-layout-with-indian-couple-image-in-white-and-orange-color-2025534518.jpg',
      'title': 'happy weddding ',
      'price': '₹10',
      'discount': '5% savings',
      'mrp': 'M.R.P.: ₹1000',
      'taxes': 'Inclusive of all taxes',
    },
    {
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRm1zETG4Ere2_vpSjUW9HBYrEfx1oKLrYvl127ak9OPZAPuk9w3RiNyfcisOxgaO4kUOU&usqp=CAU',
      'title': 'invition wedding',
      'price': '₹799',
      'discount': '34% savings',
      'mrp': 'M.R.P.: ₹2,500',
      'taxes': 'Inclusive of all taxes',
    },
    {
      'image': 'https://i0.wp.com/invitemart.com/wp-content/uploads/2021/09/W-258-page-1.jpg?fit=970%2C1246&ssl=1',
      'title': 'happy endless bond',
      'price': '₹999',
      'discount': '65% savings',
      'mrp': 'M.R.P.: ₹1500',
      'taxes': 'Inclusive of all taxes',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.7, // Adjust the aspect ratio as needed
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    products[index]['image'] ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      products[index]['title'] ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      products[index]['price'] ?? '',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      products[index]['discount'] ?? '',
                    ),
                    SizedBox(height: 4),
                    Text(
                      products[index]['mrp'] ?? '',
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      products[index]['taxes'] ?? '',
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Buy button action
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Buy Product'),
                                  content: Text('You clicked on Buy for ${products[index]['title']}'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text('Buy'),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            // Add to Cart button action
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Add to Cart'),
                                  content: Text('You added ${products[index]['title']} to your cart.'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text('Add to Cart'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('HELLO,WELCOME TO MY DESTINY APP, ORDER THE BEST WEDDING INVITAION CARDS FOR YOUR WISH.WE PLANING THE BEST WEDDING CARD AND YOU LIKE MORE  ', style: TextStyle(fontSize: 24)),
    );
  }
}

class ContactScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  void _submitContactForm(BuildContext context) {
    String name = _nameController.text;
    String phone = _phoneController.text;
    String state = _stateController.text;
    String city = _cityController.text;

    // Perform actions with the collected data (e.g., save to database)
    print('Name: $name');
    print('Phone: $phone');
    print('State: $state');
    print('City: $city');

    // Clear text fields after submission
    _nameController.clear();
    _phoneController.clear();
    _stateController.clear();
    _cityController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _stateController,
              decoration: InputDecoration(
                labelText: 'State',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _submitContactForm(context);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement search results screen
    return Center(
      child: Text('Search results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement suggestion based on query (if needed)
    return Center(
      child: Text('Search suggestions for: $query'),
    );
  }
}

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart, size: 100, color: Colors.limeAccent),
          SizedBox(height: 20),
          Text('Cart Screen', style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/pages/settings_page.dart';
import 'package:flutter_application_1/pages/profile_page.dart';
import 'package:flutter_application_1/pages/detail_page.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../model/product.dart';
import '../model/cart.dart';

/// ================= Custom Top Bar =================
class CustomTopBar extends StatelessWidget implements PreferredSizeWidget {
  final int cartCount;
  final Function(String) onSearch;
  final String email;

  const CustomTopBar({
    super.key,
    required this.cartCount,
    required this.onSearch,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double searchWidth = screenWidth * 0.35;
    if (searchWidth > 140) searchWidth = 140;

    return SafeArea(
      child: Container(
        height: preferredSize.height,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF3E5F5), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Builder(
              builder: (context) => ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 92),
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    side: const BorderSide(color: Colors.purple),
                    foregroundColor: Colors.purple,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(Icons.menu, size: 18),
                  label: const Text("Menu", style: TextStyle(fontSize: 14)),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Center(
                child: Text(
                  "Luminé Care",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
            Container(
              width: searchWidth,
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.purple.shade100),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, size: 18, color: Colors.grey),
                  const SizedBox(width: 6),
                  Expanded(
                    child: TextField(
                      onChanged: onSearch,
                      decoration: const InputDecoration(
                        hintText: "Cari",
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.person, color: Colors.purple),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ProfilePage(email: email, name: email.split('@')[0]),
                  ),
                );
              },
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_bag, color: Colors.purple),
                  onPressed: () {
                    Navigator.pushNamed(context, '/cart');
                  },
                ),
                if (cartCount > 0)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        cartCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class CartPage {
  const CartPage();
}

/// ================= Dashboard Page =================
class DashboardPage extends StatefulWidget {
  final String email;
  const DashboardPage({super.key, required this.email});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String searchQuery = "";
  String userName = "";
  String userEmail = "";

  final NumberFormat currencyFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name') ?? widget.email.split('@')[0];
      userEmail = prefs.getString('user_email') ?? widget.email;
    });
  }

  final List<Product> products = [
    SkincareProduct(
      name: "Facial Wash - Wardah",
      price: 40000,
      icon: Icons.spa,
      imageAsset: "assets/wardah.jpg",
    ),
    SkincareProduct(
      name: "Moisturizer - Scarlett",
      price: 65000,
      icon: Icons.water_drop,
      imageAsset: "assets/scarlett.jpg",
    ),
    SkincareProduct(
      name: "Sunscreen - elformula",
      price: 98000,
      icon: Icons.wb_sunny,
      imageAsset: "assets/elformula.jpg",
    ),
    SkincareProduct(
      name: "Serum Vitamin C - Scarlett",
      price: 50000,
      icon: Icons.medical_services,
      imageAsset: "assets/serum_vitamin_c.jpg",
    ),
    HaircareProduct(
      name: "Shampoo - Makarizo",
      price: 30000,
      icon: Icons.shower,
      imageAsset: "assets/makarizo.jpg",
    ),
    HaircareProduct(
      name: "Hair Oil - Natur",
      price: 45000,
      icon: Icons.energy_savings_leaf,
      imageAsset: "assets/hairoil.jpg",
    ),
    HaircareProduct(
      name: "Hair Mask - Tresemme",
      price: 110000,
      icon: Icons.spa_outlined,
      imageAsset: "assets/hairmask.jpg",
    ),
    HaircareProduct(
      name: "Conditioner - Dove",
      price: 30000,
      icon: Icons.water,
      imageAsset: "assets/conditioner.jpg",
    ),
    BodycareProduct(
      name: "Body Lotion - Vaseline",
      price: 47000,
      icon: Icons.spa,
      imageAsset: "assets/vaseline.jpg",
    ),
    BodycareProduct(
      name: "Body Scrub - Purbasari",
      price: 25000,
      icon: Icons.cleaning_services,
      imageAsset: "assets/bodyscrub.jpg",
    ),
    BodycareProduct(
      name: "Hand Cream - The Body Shop",
      price: 120000,
      icon: Icons.pan_tool,
      imageAsset: "assets/handcream.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

    final filtered = products.where((p) {
      final q = searchQuery.toLowerCase();
      return p.name.toLowerCase().contains(q) ||
          p.category.toLowerCase().contains(q);
    }).toList();

    Map<String, List<Product>> grouped = {};
    for (var p in filtered) {
      grouped.putIfAbsent(p.category, () => []).add(p);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: _buildDrawer(context),
      appBar: CustomTopBar(
        cartCount: cart.items.length,
        email: widget.email,
        onSearch: (val) => setState(() => searchQuery = val),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: grouped.entries.map((entry) {
          final category = entry.key;
          final items = entry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  category,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
              ),
              ...items.map((p) => _buildProductCard(p, cart)).toList(),
              const SizedBox(height: 8),
              const Divider(thickness: 1),
            ],
          );
        }).toList(),
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.purple),
            accountName: Text(userName),
            accountEmail: Text(userEmail),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.purple, size: 40),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profile"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfilePage(name: userName, email: userEmail),
                ),
              ).then((_) => _loadUserInfo());
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsPage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () => Navigator.pushReplacementNamed(context, '/login'),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Product p, CartModel cart) {
    // Deskripsi khusus per produk
    String description = "";
    switch (p.name) {
      case "Facial Wash - Wardah":
        description =
            "Membersihkan wajah dengan lembut tanpa membuat kulit kering.";
        break;
      case "Moisturizer - Scarlett":
        description =
            "Melembapkan kulit wajah agar tampak segar dan bercahaya.";
        break;
      case "Sunscreen - elformula":
        description =
            "Melindungi kulit dari sinar UV dengan formula ringan dan tidak lengket.";
        break;
      case "Serum Vitamin C - Scarlett":
        description = "Mencerahkan kulit dan membantu menyamarkan noda hitam.";
        break;
      case "Shampoo - Makarizo":
        description =
            "Membersihkan rambut dari kotoran dan menjadikannya lebih lembut.";
        break;
      case "Hair Oil - Natur":
        description =
            "Menutrisi rambut dari akar hingga ujung agar tampak sehat berkilau.";
        break;
      case "Hair Mask - Tresemme":
        description =
            "Perawatan intensif untuk rambut rusak agar lebih kuat dan lembut.";
        break;
      case "Conditioner - Dove":
        description =
            "Menjadikan rambut lebih lembut, mudah diatur, dan wangi sepanjang hari.";
        break;
      case "Body Lotion - Vaseline":
        description =
            "Melembapkan kulit tubuh dan membantu mencerahkan secara alami.";
        break;
      case "Body Scrub - Purbasari":
        description =
            "Mengangkat sel kulit mati agar kulit terasa halus dan cerah.";
        break;
      case "Hand Cream - The Body Shop":
        description = "Menjaga kelembutan tangan dengan aroma menyegarkan.";
        break;
      default:
        description =
            "Produk perawatan untuk menjaga kesehatan dan kecantikanmu ✨";
    }

    return GFCard(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      imageOverlay: Image.asset(p.imageAsset, fit: BoxFit.cover).image,
      title: GFListTile(
        avatar: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: AssetImage(p.imageAsset),
        ),
        titleText: p.name,
        subTitleText: currencyFormat.format(p.price),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailPage(product: p)),
        ),
      ),
      content: Text(description, style: const TextStyle(fontSize: 14)),
      buttonBar: GFButtonBar(
        children: [
          GFButton(
            onPressed: () {
              cart.add(p);
              GFToast.showToast(
                "${p.name} ditambahkan ke keranjang",
                context,
                toastDuration: 3,
                backgroundColor: GFColors.SUCCESS,
                textStyle: const TextStyle(color: Colors.white),
              );
            },
            text: "Tambah",
            icon: const Icon(
              Icons.add_shopping_cart,
              color: Colors.white,
              size: 18,
            ),
            color: GFColors.SUCCESS,
            size: GFSize.MEDIUM,
            shape: GFButtonShape.pills,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'menu_models.dart';
import 'quote_service.dart';

class FrameworkPage extends StatefulWidget {
  const FrameworkPage({super.key});

  @override
  State<FrameworkPage> createState() => _FrameworkPageState();
}

class _FrameworkPageState extends State<FrameworkPage> {
  late String _currentQuote;
  late String _currentTime;
  String _selectedMenuItemId = 'basic_grid';
  late List<MenuGroup> _menuGroups;

  @override
  void initState() {
    super.initState();
    _currentQuote = QuoteService.getRandomQuote();
    _updateTime();
    _initializeMenuGroups();

    // Update time every second
    Future.delayed(const Duration(seconds: 1), _updateTime);
  }

  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      _currentTime =
          '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    });
    // Schedule next update
    Future.delayed(const Duration(seconds: 1), _updateTime);
  }

  void _initializeMenuGroups() {
    _menuGroups = [
      MenuGroup(
        title: 'Grids',
        items: [
          MenuItem(name: 'Basic Grid', id: 'basic_grid'),
          MenuItem(name: 'Master Detail Grid', id: 'master_detail_grid'),
          MenuItem(name: 'Advanced Listing', id: 'advanced_listing'),
        ],
        isExpanded: true,
      ),
      MenuGroup(
        title: 'Forms',
        items: [
          MenuItem(name: 'Simple Edit', id: 'simple_edit'),
          MenuItem(name: 'Header with Tabs', id: 'header_tabs'),
        ],
        isExpanded: true,
      ),
    ];
  }

  void _selectMenuItem(String itemId) {
    setState(() {
      _selectedMenuItemId = itemId;
    });
  }

  void _toggleMenuGroup(int groupIndex) {
    setState(() {
      _menuGroups[groupIndex].isExpanded =
          !_menuGroups[groupIndex].isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: isMobile
          ? AppBar(
              backgroundColor:
                  Theme.of(context).colorScheme.inversePrimary,
              title: const Text('Framework'),
            )
          : null,
      drawer: isMobile ? _buildDrawer() : null,
      body: Column(
        children: [
          // Top Bar with title, time, and quote
          _buildTopBar(context),
          Expanded(
            child: isMobile
                ? _buildContentArea(context)
                : Row(
                    children: [
                      // Left Sidebar (Desktop only)
                      _buildSidebar(context),
                      // Content Area
                      Expanded(
                        child: _buildContentArea(context),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  /// Build the top bar with title, time, and quote
  Widget _buildTopBar(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.inversePrimary,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Flutter Learning Framework',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                _currentTime,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            _currentQuote,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[700],
                ),
          ),
        ],
      ),
    );
  }

  /// Build the left sidebar (desktop only)
  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.grey[100],
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            ..._menuGroups.asMap().entries.map((entry) {
              final groupIndex = entry.key;
              final group = entry.value;
              return _buildMenuGroup(context, groupIndex, group);
            }),
          ],
        ),
      ),
    );
  }

  /// Build a drawer for mobile navigation
  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.only(top: 16),
        children: [
          const DrawerHeader(
            child: Text('Menu'),
          ),
          ..._menuGroups.asMap().entries.map((entry) {
            final groupIndex = entry.key;
            final group = entry.value;
            return _buildMenuGroup(context, groupIndex, group);
          }),
        ],
      ),
    );
  }

  /// Build a single menu group (collapsible)
  Widget _buildMenuGroup(
      BuildContext context, int groupIndex, MenuGroup group) {
    return Column(
      children: [
        ListTile(
          title: Text(
            group.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Icon(
            group.isExpanded ? Icons.expand_less : Icons.expand_more,
          ),
          onTap: () => _toggleMenuGroup(groupIndex),
        ),
        if (group.isExpanded)
          ...group.items.map((item) {
            final isSelected = _selectedMenuItemId == item.id;
            return ListTile(
              title: Text(item.name),
              selected: isSelected,
              selectedTileColor: Colors.blue.withValues(alpha: 0.2),
              onTap: () {
                _selectMenuItem(item.id);
                // Close drawer on mobile
                if (MediaQuery.of(context).size.width < 600) {
                  Navigator.pop(context);
                }
              },
            );
          }),
        const Divider(),
      ],
    );
  }

  /// Build the content area showing the selected example
  Widget _buildContentArea(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Container(
        key: ValueKey(_selectedMenuItemId),
        padding: const EdgeInsets.all(24),
        child: _buildExampleContent(_selectedMenuItemId),
      ),
    );
  }

  /// Build content for the selected menu item
  Widget _buildExampleContent(String itemId) {
    switch (itemId) {
      case 'basic_grid':
        return _buildBasicGridExample();
      case 'master_detail_grid':
        return _buildMasterDetailExample();
      case 'advanced_listing':
        return _buildAdvancedListingExample();
      case 'simple_edit':
        return _buildSimpleEditExample();
      case 'header_tabs':
        return _buildHeaderTabsExample();
      default:
        return const Center(child: Text('Select a menu item'));
    }
  }

  // Placeholder examples (we'll build these out in future sessions)
  Widget _buildBasicGridExample() {
    return Column(
      children: [
        Text(
          'Basic Grid Example',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemCount: 12,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text('Item $index'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMasterDetailExample() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Master Detail Grid Example',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          const Text('Coming soon...'),
        ],
      ),
    );
  }

  Widget _buildAdvancedListingExample() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Advanced Listing Example',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          const Text('Coming soon...'),
        ],
      ),
    );
  }

  Widget _buildSimpleEditExample() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Simple Edit Form Example',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          const Text('Coming soon...'),
        ],
      ),
    );
  }

  Widget _buildHeaderTabsExample() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Header with Tabs Example',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          const Text('Coming soon...'),
        ],
      ),
    );
  }
}

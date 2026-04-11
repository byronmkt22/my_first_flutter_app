/// Menu item representing a single example/section
class MenuItem {
  final String name;
  final String id;

  MenuItem({
    required this.name,
    required this.id,
  });
}

/// Menu group that contains a list of menu items
class MenuGroup {
  final String title;
  final List<MenuItem> items;
  bool isExpanded;

  MenuGroup({
    required this.title,
    required this.items,
    this.isExpanded = true,
  });
}

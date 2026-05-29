/// this is a model class

class TempleModel {
  final int id;
  final int userId;
  final String title;
  final bool completed;
  TempleModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.completed
});
  @override
  String toString() {
    return 'TempleModel{id: $id, userId: $userId, title: $title, completed: $completed}';
  }
}
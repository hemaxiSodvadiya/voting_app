class addVote {
  String name;
  String age;
  String city;
  addVote({
    required this.name,
    required this.age,
    required this.city,
  });

  factory addVote.fromMap({required dataVote}) {
    return addVote(
      name: dataVote['name'],
      age: dataVote['age'],
      city: dataVote['city'],
    );
  }
}

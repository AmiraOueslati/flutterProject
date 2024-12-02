
// Classe pour représenter un animal (Sheep)
class Animal {
  final int sensorId;  // Added sensorId (int) for consistency with backend
  final String name;
  final int age; // Changed to int to match backend type
  final String color; // Assuming 'color' is a string
  final String type;  // Assuming 'type' is a string
  final String? image; // Changed to String for image URL or path

  Animal({
    required this.sensorId,
    required this.name,
    required this.age,
    required this.color,
    required this.type,
    this.image,
  });

  // A method to convert an Animal to a map that can be sent to the backend
  Map<String, dynamic> toMap() {
    return {
      'sensorId': sensorId,
      'name': name,
      'age': age,
      'color': color,
      'type': type,
      'image': image, // This should be the image URL or file path (String)
    };
  }

  // A method to convert a map from the backend to an Animal instance
  factory Animal.fromMap(Map<String, dynamic> map) {
    return Animal(
      sensorId: map['sensorId'],
      name: map['name'],
      age: map['age'],
      color: map['color'],
      type: map['type'],
      image: map['image'], // This will be the image URL or file path (String)
    );
  }
}


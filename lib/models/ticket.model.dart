part of 'models.dart';

class Ticket{
  String? id,problemTitle,problemDescription,location,storedImage,createdAt;

  Ticket({
    this.id,
    this.problemTitle,
    this.problemDescription,
    this.location,
    this.storedImage,
    this.createdAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Ticket &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          problemTitle == other.problemTitle &&
          problemDescription == other.problemDescription &&
          location == other.location &&
          storedImage == other.storedImage &&
          createdAt == other.createdAt);

  @override
  int get hashCode =>
      id.hashCode ^
      problemTitle.hashCode ^
      problemDescription.hashCode ^
      location.hashCode ^
      storedImage.hashCode ^
      createdAt.hashCode;

  @override
  String toString() {
    return 'TicketModel{ id: $id, problemTitle: $problemTitle, problemDescription: $problemDescription, location: $location, storedImage: $storedImage, createdAt: $createdAt,}';
  }

  Ticket copyWith({
    String? id,
    String? problemTitle ="",
    String? problemDescription="",
    String? location="",
    String? storedImage="",
    String? createdAt="",
  }) {
    return Ticket(
      id: id ?? this.id,
      problemTitle: problemTitle ?? this.problemTitle,
      problemDescription: problemDescription ?? this.problemDescription,
      location: location ?? this.location,
      storedImage: storedImage ?? this.storedImage,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'problemTitle': problemTitle,
      'problemDescription': problemDescription,
      'location': location,
      'storedImage': storedImage,
      'createdAt': createdAt,
    };
  }

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      id: map['id'] as String,
      problemTitle: map['problemTitle'] as String,
      problemDescription: map['problemDescription'] as String,
      location: map['location'] as String,
      storedImage: map['storedImage'] as String,
      createdAt: map['createdAt'] as String,
    );
  }

}
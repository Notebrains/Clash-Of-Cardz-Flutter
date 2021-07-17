
import 'package:equatable/equatable.dart';

class FirebasePlayerDetailsModel extends Equatable{
  String playerName = '';
  String userId = '';
  String photo = '';
  String firebasePlayerKey = '';

  FirebasePlayerDetailsModel(this.playerName, this.userId, this.photo, this.firebasePlayerKey);

  @override
  List<Object> get props => [userId];
}

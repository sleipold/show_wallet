import 'package:showwallet/locator.dart';
import 'package:showwallet/models/team.dart';
import 'package:showwallet/services/firestore_service.dart';
import 'package:showwallet/viewmodels/base_model.dart';

class CashboxViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();

  List<Team> _teams;

  List<Team> get teams => _teams;

  void listenToTeams() {
    setBusy(true);

    _firestoreService.listenToTeamsRealTime().listen((teamsData) {
      List<Team> updatedTeams = teamsData;
      if (updatedTeams != null && updatedTeams.length > 0) {
        _teams = updatedTeams;
        notifyListeners();
      }

      setBusy(false);
    });
  }
}

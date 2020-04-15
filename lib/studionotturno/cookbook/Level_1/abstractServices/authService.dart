


///Gestisce le interazioni con il backend per la registrazione e autenticazione dell'utente
abstract class AuthService {

  ///Consente ad un utente registrato di autenticarsi per accedere ai servizi in cloud<br><br>
  ///Il paramerto in input è dato dal metodo di ritorno dell'UserAdapter che modifica i dati
  ///dell'utente in un json
  Future<bool> signin(Map<String, dynamic> userJson);

  ///Consente di registrare un utente; vengono effettuati ( usando UserChecke r)
  ///dei controlli sulla email e sull'età dell'utente prima di inviare i dati al backend<br><br>
  ///Il paramerto in input è dato dal metodo di ritorno dell'UserAdapter che modifica i dati
  ///dell'utente in un json
  Future<bool> signup(Map<String, dynamic> userJson);
}
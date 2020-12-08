abstract class AppAction{}

class InitAppAction extends AppAction {

  InitAppAction();

  @override @override String toString() {
    return "InitAppAction";
  }
}


class SaveDataVersionAction{
	final Map<String, dynamic> dataVersion;
	SaveDataVersionAction(this.dataVersion);

	@override
	String toString() => "SaveDataVersionAction{`$dataVersion`}";
}
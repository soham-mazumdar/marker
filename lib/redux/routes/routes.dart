import 'package:flutter/material.dart';
import 'package:marker/redux/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:marker/redux/actions/navigator_actions.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class RouteAwareWidget extends StatefulWidget
{
	final Widget child;
	RouteAwareWidget({this.child});

	State<RouteAwareWidget> createState() => _RouteAwareWidgetState();
}

class _RouteAwareWidgetState extends State<RouteAwareWidget> with RouteAware
{
	@override
	void didChangeDependencies()
	{
		super.didChangeDependencies();
		routeObserver.subscribe(this, ModalRoute.of(context));
	}

	@override
	void dispose()
	{
		routeObserver.unsubscribe(this);
		super.dispose();
	}

	@override
	void didPush(){}

	@override
	void didPopNext(){
		StoreProvider.of<AppState>(context).dispatch(NavigatorPopAction());
	}

	@override
	Widget build(BuildContext context) => Container(child : widget.child);

}

class MainRoute<T> extends MaterialPageRoute<T>{
	MainRoute(Widget widget, {RouteSettings settings})
		: super(
		builder : (_) => RouteAwareWidget(child : widget),
		settings : settings
	);

	@override
	Widget buildTransitions(BuildContext context, Animation<double> animation,
		Animation<double> secondaryAnimation, Widget widget)
	{
		if(settings.name == '/') return widget;

		return FadeTransition(opacity: animation, child: widget);
	}
}

class FabRoute<T> extends MaterialPageRoute<T>{
  final Widget widget;
	final RouteSettings settings;
	int duration;
  String direction;


	FabRoute(this.widget, {this.settings, this.duration, this.direction})
		: super(
		builder : (_) => RouteAwareWidget(child : widget),
		settings : settings,
	);

  // PAGE TRANSITION DURATION
  @override
  Duration get transitionDuration {
    if(this.duration != null){
      return Duration(milliseconds: duration );
    }
    else
      return Duration( milliseconds: 200);
  }

	@override
	Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
		Animation<double> secondaryAnimation, 
    Widget widget
  ){
		if(settings.name == '/') return widget;

		return SlideTransition(
			position: Tween<Offset>(
				begin: direction != 'right' ? Offset(0.0, 1.0) : const Offset(1.0,0.0),
				end: Offset.zero,
			).animate(animation),
			child: widget,
       // child is the value returned by pageBuilder
		);
	}
}

class AppRoutes{
	static const String home = "/";
  static const String markers = "/markers";
  static const String saved = "/saved";
  static const String liked = "/liked";
  static const String following = "/following";
  static const String create = "/create";
  
  // static const String selectedUser = "/selectedUser";
  // static const String templeLocator = "/temple-locator";
}
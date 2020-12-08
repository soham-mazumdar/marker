// import 'dart:convert';
// import 'dart:developer';

// import 'package:http/http.dart' as http;
// import 'package:marker/redux/models/Drawing.dart';
// import 'package:marker/redux/models/Marker.dart';
// import 'package:marker/util/variables.dart';

class WPService {
  

//   Future<List<Thought>> fetchPosts() async{
//     print('ok');
//     String baseUrl = wpBaseUrl2;
//     var queryParameters = {'per_page': '20'};
//     // var uri = Uri.http(baseUrl , '/flutter-practice/quotes/wordpress/wp-json/wp/v2/posts', queryParameters);
//     var uri = Uri.http(baseUrl , '/wp-json/wp/v2/posts', queryParameters);

//     return http.get(
//       uri,
//       headers: {
//         'Content-Type': 'application/json',
//         'accept': 'application/json',
//       },
//     ).then((http.Response value) async {
//       List body = jsonDecode(value.body);
//       log(body.toString());
//       List<Thought> thoughts = [];
//       for(var e in body) { 
//         // print(e['post-meta-fields']['likes']);
//         int author = e['author'];
//         Thought _t = await this.fetchAuthor(author).then((value){
//           return Thought.fromJson(e,value[0],value[1]);
//         });
//         thoughts.add(_t);
//       }
//       return thoughts;
//     });
//   }

//   Future<List<Thought>> fetchMorePosts(int page) async{
//     String baseUrl = wpBaseUrl2;
//     var queryParameters = {'per_page': '20','page': page.toString()};
//     // var uri = Uri.http(baseUrl , '/flutter-practice/quotes/wordpress/wp-json/wp/v2/posts', queryParameters);
//     var uri = Uri.http(baseUrl , '/wp-json/wp/v2/posts', queryParameters);

//     return http.get(
//       uri,
//       headers: {
//         'Content-Type': 'application/json',
//         'accept': 'application/json',
//       },
//     ).then((http.Response value) async {
//       List body = jsonDecode(value.body);
//       List<Thought> thoughts = [];
//       for(var e in body)  { 
//         int author = e['author'];
//         Thought _t = await this.fetchAuthor(author).then((value){
//           return Thought.fromJson(e,value[0],value[1]);
//         });
//         thoughts.add(_t);
//       }
//       return thoughts;
//     });
//   }

//   Future<List> fetchAuthor(author) async {
//     // String baseUrl = 'localhost';
//     String baseUrl = wpBaseUrl2;
    
//     // var uri = Uri.http(baseUrl , '/flutter-practice/quotes/wordpress/wp-json/wp/v2/users/'+author.toString());//, queryParameters);
//     var uri = Uri.http(baseUrl , '/wp-json/wp/v2/users/'+author.toString());//, queryParameters);
//     // print(uri);
//     return await http.get(
//       uri,
//       headers: {
//         'Content-Type': 'application/json',
//         'accept': 'application/json',
//       },
//     ).then((http.Response value){
//       var body = jsonDecode(value.body);
//       List ret = [];
//       ret.add(body['name']);
//       ret.add(body['id']);
//       return ret;
//     });

//   }

//   Future<List<Thought>> fetchFollowedPosts(List<int> authorIds) async{
//     // String baseUrl = 'localhost';
//     String baseUrl = wpBaseUrl2;
//     var queryParameters = {
//       'per_page': '100',
//       'author': authorIds.join(', '),//'20,1',// jsonEncode(authorIds),
//       // 'page': page.toString()
//     };
//     // var uri = Uri.http(baseUrl , '/flutter-practice/quotes/wordpress/wp-json/wp/v2/posts', queryParameters);
//     var uri = Uri.http(baseUrl , '/wp-json/wp/v2/posts', queryParameters);

//     return http.get(
//       uri,
//       headers: {
//         'Content-Type': 'application/json',
//         'accept': 'application/json',
//       },
//     ).then((http.Response value) async {

//       // log(jsonDecode(value.body).toString());
//       List body = jsonDecode(value.body);
//       List<Thought> thoughts = [];
//       for(var e in body)  { 
//         int author = e['author'];
//         Thought _t = await this.fetchAuthor(author).then((value){
//           return Thought.fromJson(e,value[0],value[1]);
//         });
//         thoughts.add(_t);
//       }
//       return thoughts;
//     });
//   }


  
//   Future<Thought> createPost(String thought, String title, WpUser user) async{
//     // String baseUrl = 'localhost';
//     String baseUrl = wpBaseUrl2;
//     // var uri = Uri.http(baseUrl , '/flutter-practice/quotes/wordpress/wp-json/wp/v2/posts');
//     var uri = Uri.http(baseUrl , '/wp-json/wp/v2/posts');

//     return http.post(
//       uri,
//       headers: {
//         'Content-Type': 'application/json',
//         'accept': 'application/json',
//         'Authorization': 'Bearer ' + user.token
//       },
//       body: jsonEncode({
//         "title" : title,
//         "content" : thought,
//         "author": user.id,
//       })
//     ).then((http.Response value) async {
//       Map<String, dynamic> body = jsonDecode(value.body);
      
//       Thought thought = Thought.fromJson(body,user.firstName,user.id);
      
//       return thought;
//     });
//   }

//   Future<Thought> likePost(Thought thought, int likes ,WpUser user) async{
//     // print(user.email);
//     // String baseUrl = 'localhost';
//     String baseUrl = wpBaseUrl2;
//     // var uri = Uri.http(baseUrl , '/flutter-practice/quotes/wordpress/wp-json/wp/v2/posts/'+thought.id.toString());
//     var uri = Uri.http(baseUrl , '/wp-json/wp/v2/posts/'+thought.id.toString());

//     print(thought.likes);
//     int _likes = thought.likes ?? 0;

//     return http.post(
//       uri,
//       headers: {
//         'Content-Type': 'application/json',
//         'accept': 'application/json',
//         'Authorization': 'Bearer ' + user.token
//       },
//       body: jsonEncode({
//         'meta': {'likes' : (_likes+1).toString()}
//         // 'key' : 'likes',
// 	      // 'value' : '1',// (likes + 1).toString()
//       })
//     ).then((http.Response value) async {
//       Map<String, dynamic> body = jsonDecode(value.body);
//       log(body.toString());
//       Thought thoughts = Thought.fromJson(body,thought.authorName,thought.id);
      
//       return thoughts;
//     });
//   }

  
}
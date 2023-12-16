import 'package:diplom/Models/DatabaseClasses/user.dart';
import 'package:diplom/Models/DatabaseClasses/course.dart';
import 'package:diplom/Models/DatabaseClasses/difficultType.dart';
import 'package:diplom/Models/DatabaseClasses/message.dart';
import 'package:diplom/Models/DatabaseClasses/module.dart';
import 'package:diplom/Services/Data.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

class Api {
  Future<MyUser?> login(
      {required String email, required String password}) async {
    final sup = GetIt.I.get<Supabase>();
    final requestUser = await sup.client
        .from('Users')
        .select('*')
        .eq('email', email)
        .eq('password', password);
    if (requestUser.toString() != '[]') {
      final Map<String, dynamic> user =
          (requestUser as List<dynamic>)[0] as Map<String, dynamic>;
      MyUser da = MyUser.fromMap(user);
      return da;
    } else {
      return null;
    }
  }

  Future<List<Map<String,dynamic>>> getJsonPage(int lessonID) async {
    final client = GetIt.I.get<Supabase>().client;
    try {
      final result = await client
          .from('Lessons')
          .select('data')
          .eq('id', lessonID)
          .single(); // Assuming you're expecting a single result

      if (result != null) {
        return List<Map<String,dynamic>>.from(result['data']);
      } else {
        GetIt.I
            .get<Talker>()
            .critical("No data found for lesson ID: $lessonID");
        return [];
      }
    } catch (err) {
      GetIt.I.get<Talker>().critical("Failed to get JSON page: $err");
      return [];
    }
  }

  Future<List<Message>> loadMessages(int MeID) async {
    final client = GetIt.I.get<Supabase>().client;
    final result = await client
        .from('Messages')
        .select('*')
        .or('senderID.eq.$MeID,takerID.eq.$MeID');
    final raw = result as List<dynamic>;
    List<Message> res = [];
    for (var mes in raw) {
      res.add(Message.fromMap(mes));
    }
    return res;
  }

  Future<bool> registerUserToCourse(int courseID) async {
    final Data data = GetIt.I.get<Data>();
    final client = GetIt.I.get<Supabase>().client;
    try {
      final result = await client
          .from('UserCourses')
          .insert({'UserID': '${data.user.id}', 'CourseID': '$courseID'});
      GetIt.I.get<Talker>().good("Registered to course");
      return true;
    } catch (err) {
      GetIt.I.get<Talker>().critical("Register to course failed $err");
      return false;
    }
  }

  Future<bool> userRegisteredToCourse(int courseID, int userID) async {
    final client = GetIt.I.get<Supabase>().client;
    try {
      final result = await client
          .from('UserCourses')
          .select('*')
          .eq('UserID', userID)
          .eq('CourseID', courseID);
      return result.toString() == "[]" ? false : true;
    } catch (err) {
      GetIt.I.get<Talker>().critical("Failed to check $err");
      return false;
    }
  }

  Future<List<Course>> getUserCourses(int userID) async {
    final client = GetIt.I.get<Supabase>().client;
    try {
      final result =
          await client.from('UserCourses').select('*').eq('UserID', userID);
      List<Course> courses = await Api()._loadCourses(client);
      List<Course> res = [];
      List<int> MyCourses = [];
      final raw = result as List<dynamic>;

      for (Map<String, dynamic> el in raw) {
        MyCourses.add(el['CourseID']);
      }

      for (Course course in courses) {
        if (MyCourses.contains(course.id)) {
          res.add(course);
        }
      }

      return res;
    } catch (err) {
      GetIt.I.get<Talker>().critical("Failed to get courses $err");
      return [];
    }
  }

  Future<List<Module>> loadModules(int courseID) async {
    final client = GetIt.I.get<Supabase>().client;
    final result =
        await client.from('Modules').select('*').eq('courseID', courseID);
    final raw = result as List<dynamic>;
    List<Module> res = [];
    for (var module in raw) {
      res.add(Module.fromMap(module));
    }
    return res;
  }

  Future<List<Lesson>> loadLessons(int moduleID) async {
    final client = GetIt.I.get<Supabase>().client;
    final result =
        await client.from('Lessons').select('*').eq('moduleID', moduleID);
    final raw = result as List<dynamic>;
    List<Lesson> res = [];
    for (var module in raw) {
      res.add(Lesson.fromMap(module));
    }
    return res;
  }

  Future<bool?> loadData() async {
    final data = GetIt.I.get<Data>();
    final client = GetIt.I.get<Supabase>().client;
    data.Courses = await _loadCourses(client);
    data.difficults = await _loadDifficults(client);
    data.lessonTypes = await _loadLessonTypes(client);
    data.user.completedLessonsID =
        await Api().loadCompletedUserCourses(data.user.id);
    return true;
  }

  Future<List<int>> loadCompletedUserCourses(int userID) async {
    final client = GetIt.I.get<Supabase>().client;
    final List<dynamic> raw = await client
        .from('LessonsProgress')
        .select('LessonID')
        .eq('UserID', userID);
    return raw.map((e) => e['LessonID'] as int).toList();
  }

  Future<List<Course>> _loadCourses(SupabaseClient client) async {
    final List<Map<String, dynamic>> result =
        await client.from('Courses').select('*');
    try {
      List<Course> courses = [];
      for (var element in result) {
        courses.add(Course.fromMap(element));
      }
      return courses;
    } catch (err) {
      GetIt.I.get<Talker>().critical("Parse failed $err");
    }
    GetIt.I.get<Talker>().critical("Error load");
    return [];
  }

  Future<List<DifficultTypes>> _loadDifficults(SupabaseClient client) async {
    final List<Map<String, dynamic>> result =
        await client.from('Difficults').select('*');
    try {
      List<DifficultTypes> difficult = [];
      for (var element in result) {
        difficult.add(DifficultTypes.fromMap(element));
      }
      return difficult;
    } catch (err) {
      GetIt.I.get<Talker>().critical("Parse failed $err");
    }
    GetIt.I.get<Talker>().critical("Error load");
    return [];
  }

  Future<List<LessonType>> _loadLessonTypes(SupabaseClient client) async {
    final List<Map<String, dynamic>> result =
        await client.from('LessonTypes').select('*');
    try {
      List<LessonType> types = [];
      for (var element in result) {
        types.add(LessonType.fromMap(element));
      }
      return types;
    } catch (err) {
      GetIt.I.get<Talker>().critical("Error load $err");
    }
    return [];
  }
}
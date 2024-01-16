// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:convert';
import 'package:diplom/Models/DatabaseClasses/otherUser.dart';
import 'package:diplom/Models/DatabaseClasses/pdfLesson.dart';
import 'package:diplom/Models/DatabaseClasses/practice.dart';
import 'package:diplom/Models/DatabaseClasses/user.dart';
import 'package:diplom/Models/DatabaseClasses/course.dart';
import 'package:diplom/Models/DatabaseClasses/difficultType.dart';
import 'package:diplom/Models/DatabaseClasses/message.dart';
import 'package:diplom/Models/DatabaseClasses/module.dart';
import 'package:diplom/Models/DatabaseClasses/userPractice.dart';
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

  Future<OtherUser?> getUser(int id) async {
    final sup = GetIt.I.get<Supabase>();
    final List<dynamic> user = await sup.client
        .from('Users')
        .select('id,avatarURL,registerDate,RoleID,name')
        .eq('id', id);
    GetIt.I.get<Talker>().debug(user);
    return OtherUser.fromMap(user[0]);
  }

  Future<List<Map<String, dynamic>>> getJsonPage(int lessonID) async {
    final client = GetIt.I.get<Supabase>().client;
    try {
      final result = await client
          .from('Lessons')
          .select('data')
          .eq('id', lessonID)
          .single(); // Assuming you're expecting a single result

      if (result != null) {
        return List<Map<String, dynamic>>.from(result['data']);
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

  Future<bool> completetest(int praciceID, int userID) async {
    final client = GetIt.I.get<Supabase>().client;

    try {
      final response = await client
          .from('LessonsProgress')
          .insert({'LessonID': praciceID, 'UserID': userID});
      GetIt.I.get<Talker>().good('Test completed to server');
      return true;
    } catch (error) {
      GetIt.I.get<Talker>().critical(error);
      return false;
    }
  }

  Future<List<UserPractice>> loadUserPractices(int lessonID) async {
    final client = GetIt.I.get<Supabase>().client;
    final result =
        await client.from('UserPractices').select('*').eq('lesson', lessonID);
    final raw = result as List<dynamic>;
    List<UserPractice> res = [];
    for (var mes in raw) {
      res.add(UserPractice.fromMap(mes));
    }
    return res;
  }

  Future<List<PDFLesson>> loadPDFSLesson(int lesson) async {
    final client = GetIt.I.get<Supabase>().client;
    final result =
        await client.from('pdfLesson').select('*').eq('idLesson', lesson);
    final raw = result as List<dynamic>;
    List<PDFLesson> res = [];
    for (var mes in raw) {
      res.add(PDFLesson.fromMap(mes));
    }
    return res;
  }

  Future<List<Practise>> loadPractices(int lesson) async {
    final client = GetIt.I.get<Supabase>().client;
    final result =
        await client.from('Practices').select('*').eq('lesson', lesson);
    GetIt.I<Talker>().good("govmo $result");
    final raw = result as List<dynamic>;
    List<Practise> res = [];
    for (var mes in raw) {
      res.add(Practise.fromMap(mes));
    }
    GetIt.I<Talker>().debug(res);
    return res;
  }

  Future<bool> registerUserToCourse(int courseID) async {
    final Data data = GetIt.I.get<Data>();
    final client = GetIt.I.get<Supabase>().client;
    try {
      final result = await client
          .from('UserCourses')
          .insert({'UserID': '${data.user.id}', 'CourseID': '$courseID'});
      GetIt.I.get<Talker>().good("Registered to course $result");
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

  Future<List<dynamic>> loadLessonTest(int id) async {
    final client = GetIt.I.get<Supabase>().client;
    final result =
        await client.from('LessonTests').select('*').eq('lesson', id);
    List<dynamic> temp = jsonDecode(result[0]['data']);
    return temp;
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
    data.ClosedCourses = await _loadClosedCourses();
    data.difficults = await _loadDifficults(client);
    data.lessonTypes = await _loadLessonTypes(client);
    data.user.completedLessonsID =
        await Api().loadCompletedUserCourses(data.user.id);
    return true;
  }

  Future<List<int>> _loadClosedCourses() async {
    final client = GetIt.I.get<Supabase>().client;
    final res = await client.from('ClosedCourses').select('closedcourse');
    GetIt.I.get<Talker>().debug(res);
    try {
      return List<int>.from((res as List<dynamic>).map((e) => e['closedcourse'] as int));
    } catch (err) {
      return [];
    }
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

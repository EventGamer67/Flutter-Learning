// ignore_for_file: public_member_api_docs, sort_constructors_first

class Data{
  List<Course> Courses = [];
}

class Course {
  String name = "";
  String description = "";
  dynamic photo = "";
  String difficult = "";
  List<Module> modules = [];
  Course({
    required this.name,
    required this.description,
    required this.photo,
    required this.difficult,
    required this.modules
  });
}

class User{
  List<Course> userCoursese = [];
  String fillName = "";
  String email = "";
  DateTime registrationDate = DateTime.now();
  String userRole = "";
}

class UserDpo{
  String email = "";
  String password = "";
}

class Module {
  String moduleName = "asd";
  List<Lesson> lessons = [];
  Module({
    required this.moduleName,
    required this.lessons,
  });
}

class Lesson {
  String lessonName = "";
  Lesson({
    required this.lessonName,
  });
  LessonType type = LessonType.test;
}

enum LessonType {
  test,
  lesson,
  exam,
}

Map<LessonType, String> lessonNames = {
  LessonType.test: "Тест",
  LessonType.lesson: "Урок",
  LessonType.exam: "Экзамен",
};

List<Course> CoursesList = [
    Course(
        name: "Введение в педагогику для школьников",
        modules: [
          Module(moduleName: "Педагогика как практика", lessons: [
            Lesson(lessonName: "Тест 1.1"),
            Lesson(lessonName: "Тест 1.2"),
            Lesson(lessonName: "Тест 1.3")
          ]),
          Module(moduleName: "Педагогика как наука", lessons: [
            Lesson(lessonName: "Тест 2.1"),
            Lesson(lessonName: "Тест 2.2"),
            Lesson(lessonName: "Тест 2.3")
          ]),
          Module(moduleName: "Педагогика как искусство", lessons: [
            Lesson(lessonName: "Тест 3.1"),
            Lesson(lessonName: "Тест 3.2"),
            Lesson(lessonName: "Тест 3.3")
          ]),
          Module(
              moduleName: "Профессиональная деятельность педагога",
              lessons: [
                Lesson(lessonName: "Тест 3.1"),
                Lesson(lessonName: "Тест 3.2"),
                Lesson(lessonName: "Тест 3.3")
              ])
        ],
        description:
            "Курс дает представление об основах деятельности педагога и требованиях к его умениям и качествам. На конкретных ситуациях, представленных в виде текстов и видео, показаны такие виды деятельности и компоненты педагогического мастерства учителя, как подготовка к уроку, оценивание деятельности учащихся, педагогическая рефлексия, интуиция, эмпатия.",
        photo:
            "https://www.phoenix.edu/content/dam/edu/blog/2023/02/Male-programmer-writing-code-in-modern-office-704x421.jpg",
        difficult: "Начальный уровень"),
    Course(
        name: "Педагогический дизайн урока",
        modules: [
          Module(moduleName: "Педагогика как практика", lessons: [
            Lesson(lessonName: "Тест 1.1"),
            Lesson(lessonName: "Тест 1.2"),
            Lesson(lessonName: "Тест 1.3")
          ]),
          Module(moduleName: "Педагогика как наука", lessons: [
            Lesson(lessonName: "Тест 2.1"),
            Lesson(lessonName: "Тест 2.2"),
            Lesson(lessonName: "Тест 2.3")
          ]),
          Module(moduleName: "Педагогика как искусство", lessons: [
            Lesson(lessonName: "Тест 3.1"),
            Lesson(lessonName: "Тест 3.2"),
            Lesson(lessonName: "Тест 3.3")
          ]),
          Module(
              moduleName: "Профессиональная деятельность педагога",
              lessons: [
                Lesson(lessonName: "Тест 3.1"),
                Lesson(lessonName: "Тест 3.2"),
                Lesson(lessonName: "Тест 3.3")
              ])
        ],
        description:
            "Увлекательное путешествие в педагогический дизайн – это уникальная возможность для учителя и его учеников «примерить» на себя новые смыслы-роли: дизайнера, технолога, инженера, сценариста, режиссера, актера, навигатора и даже геймера.",
        photo:
            "https://www.limestone.edu/sites/default/files/styles/news_preview_image/public/2022-03/computer-programmer.jpg?h=2d4b268f&itok=JOcIEe9u",
        difficult: "Средний уровень"),
    Course(
        name: "Компьютерная лингводидактика",
        modules: [
          Module(moduleName: "Педагогика как практика", lessons: [
            Lesson(lessonName: "Тест 1.1"),
            Lesson(lessonName: "Тест 1.2"),
            Lesson(lessonName: "Тест 1.3")
          ]),
          Module(moduleName: "Педагогика как наука", lessons: [
            Lesson(lessonName: "Тест 2.1"),
            Lesson(lessonName: "Тест 2.2"),
            Lesson(lessonName: "Тест 2.3")
          ]),
          Module(moduleName: "Педагогика как искусство", lessons: [
            Lesson(lessonName: "Тест 3.1"),
            Lesson(lessonName: "Тест 3.2"),
            Lesson(lessonName: "Тест 3.3")
          ]),
          Module(
              moduleName: "Профессиональная деятельность педагога",
              lessons: [
                Lesson(lessonName: "Тест 3.1"),
                Lesson(lessonName: "Тест 3.2"),
                Lesson(lessonName: "Тест 3.3")
              ])
        ],
        description:
            "Компьютерная лингводидактика является междисциплинарной областью знания и тесно взаимодействует с развитием информа­ционных технологий, прикладной и математической лингвистики, разработками в области искусственного интеллекта, дизайна ком­пьютерных программ, исследований взаимодействия «человек — компьютер», теорией и практикой компьютерного обучения в це­лом.",
        photo:
            "https://storecms.blob.core.windows.net/uploads/51b69245-62b1-4889-af1f-1a498bd995ca-young-man-coding.jpg",
        difficult: "Средний уровень"),
  ];

import 'package:brain_rise/services/local_storage_service.dart';

import '../models/achievement_model.dart';
import '../models/lesson_model.dart';
import '../models/questions_model.dart';
import '../models/subject_model.dart';

class QuestionService {
  final LocalStorageService _storage;

  QuestionService(this._storage);

  // Load initial data (for demo app)
  Future<void> loadInitialData() async {
    await _loadSubjects();
    await _loadLessons();
    await _loadQuestions();
    await _loadAchievements();
  }

  Future<void> _loadSubjects() async {
    final subjects = _getDemoSubjects();
    await _storage.saveSubjects(subjects);
  }

  Future<void> _loadLessons() async {
    final lessons = _getDemoLessons();
    await _storage.saveLessons(lessons);
  }

  Future<void> _loadQuestions() async {
    final questions = _getDemoQuestions();
    await _storage.saveQuestions(questions);
  }

  Future<void> _loadAchievements() async {
    final achievements = _getDemoAchievements();
    await _storage.saveAchievements(achievements);
  }

  // Demo data generators
  List<Subject> _getDemoSubjects() {
    return [
      Subject(
        id: 'math',
        name: 'Mathematics',
        description: 'Master mathematical concepts and problem-solving',
        iconUrl: '📐',
        category: 'Science',
        examTypes: ['WAEC', 'NECO', 'IELTS'],
        totalLessons: 5,
        color: '#4A90E2',
      ),
      Subject(
        id: 'english',
        name: 'English Language',
        description: 'Improve your grammar, vocabulary, and comprehension',
        iconUrl: '📚',
        category: 'Arts',
        examTypes: ['WAEC', 'NECO', 'IELTS'],
        totalLessons: 5,
        color: '#E94B3C',
      ),
      Subject(
        id: 'physics',
        name: 'Physics',
        description: 'Understand the laws of nature and motion',
        iconUrl: '⚛️',
        category: 'Science',
        examTypes: ['WAEC', 'NECO'],
        totalLessons: 5,
        color: '#9B59B6',
      ),
      Subject(
        id: 'chemistry',
        name: 'Chemistry',
        description: 'Explore matter, reactions, and the periodic table',
        iconUrl: '🧪',
        category: 'Science',
        examTypes: ['WAEC', 'NECO'],
        totalLessons: 5,
        color: '#27AE60',
      ),
      Subject(
        id: 'biology',
        name: 'Biology',
        description: 'Study living organisms and life processes',
        iconUrl: '🧬',
        category: 'Science',
        examTypes: ['WAEC', 'NECO'],
        totalLessons: 5,
        color: '#16A085',
      ),
    ];
  }

  List<Lesson> _getDemoLessons() {
    return [
      // MATHEMATICS
      Lesson(
        id: 'math_l1',
        subjectId: 'math',
        title: 'Number Operations',
        description: 'Basic arithmetic and number properties',
        order: 1,
        difficulty: 1,
        questionIds: ['math_q1', 'math_q2', 'math_q3', 'math_q4', 'math_q5'],
        xpReward: 15,
        gemsReward: 5,
      ),
      Lesson(
        id: 'math_l2',
        subjectId: 'math',
        title: 'Algebra Basics',
        description: 'Introduction to algebraic expressions and equations',
        order: 2,
        difficulty: 2,
        questionIds: ['math_q6', 'math_q7', 'math_q8', 'math_q9', 'math_q10'],
        xpReward: 20,
        gemsReward: 7,
        prerequisiteLessonIds: ['math_l1'],
      ),
      Lesson(
        id: 'math_l3',
        subjectId: 'math',
        title: 'Fractions & Decimals',
        description: 'Working with fractions and decimal numbers',
        order: 3,
        difficulty: 2,
        questionIds: [
          'math_q11',
          'math_q12',
          'math_q13',
          'math_q14',
          'math_q15',
        ],
        xpReward: 20,
        gemsReward: 7,
        prerequisiteLessonIds: ['math_l1'],
      ),

      // ENGLISH
      Lesson(
        id: 'eng_l1',
        subjectId: 'english',
        title: 'Parts of Speech',
        description: 'Nouns, verbs, adjectives, and more',
        order: 1,
        difficulty: 1,
        questionIds: ['eng_q1', 'eng_q2', 'eng_q3', 'eng_q4', 'eng_q5'],
        xpReward: 15,
        gemsReward: 5,
      ),
      Lesson(
        id: 'eng_l2',
        subjectId: 'english',
        title: 'Subject-Verb Agreement',
        description: 'Matching subjects with correct verb forms',
        order: 2,
        difficulty: 2,
        questionIds: ['eng_q6', 'eng_q7', 'eng_q8', 'eng_q9', 'eng_q10'],
        xpReward: 20,
        gemsReward: 7,
        prerequisiteLessonIds: ['eng_l1'],
      ),

      // PHYSICS
      Lesson(
        id: 'phy_l1',
        subjectId: 'physics',
        title: 'Motion & Speed',
        description: 'Understanding distance, speed, and time',
        order: 1,
        difficulty: 1,
        questionIds: ['phy_q1', 'phy_q2', 'phy_q3', 'phy_q4', 'phy_q5'],
        xpReward: 15,
        gemsReward: 5,
      ),
      Lesson(
        id: 'chem_l1',
        subjectId: 'chemistry',
        title: 'Atoms & Elements',
        description: 'Basic concepts of atoms, elements, and compounds',
        order: 1,
        difficulty: 1,
        questionIds: ['chem_q1', 'chem_q2', 'chem_q3', 'chem_q4', 'chem_q5'],
        xpReward: 15,
        gemsReward: 5,
      ),
      Lesson(
        id: 'bio_l1',
        subjectId: 'biology',
        title: 'Cells & Living Things',
        description: 'Introduction to cells and basic biology',
        order: 1,
        difficulty: 1,
        questionIds: ['bio_q1', 'bio_q2', 'bio_q3', 'bio_q4', 'bio_q5'],
        xpReward: 15,
        gemsReward: 5,
      ),
    ];
  }

  List<Question> _getDemoQuestions() {
    return [
      // MATHEMATICS - Number Operations
      Question(
        id: 'math_q1',
        lessonId: 'math_l1',
        questionText: 'What is 45 + 38?',
        type: QuestionType.multipleChoice,
        options: ['73', '83', '93', '103'],
        correctAnswer: '83',
        explanation: '45 + 38 = 83',
        difficulty: 1,
        timeLimit: 30,
        tags: ['addition', 'basic'],
      ),
      Question(
        id: 'math_q2',
        lessonId: 'math_l1',
        questionText: 'What is 12 × 7?',
        type: QuestionType.multipleChoice,
        options: ['74', '84', '94', '104'],
        correctAnswer: '84',
        explanation: '12 × 7 = 84',
        difficulty: 1,
        timeLimit: 30,
        tags: ['multiplication', 'basic'],
      ),
      Question(
        id: 'math_q3',
        lessonId: 'math_l1',
        questionText: 'What is 100 - 47?',
        type: QuestionType.multipleChoice,
        options: ['43', '53', '63', '73'],
        correctAnswer: '53',
        explanation: '100 - 47 = 53',
        difficulty: 1,
        timeLimit: 30,
        tags: ['subtraction', 'basic'],
      ),
      Question(
        id: 'math_q4',
        lessonId: 'math_l1',
        questionText: 'What is 144 ÷ 12?',
        type: QuestionType.multipleChoice,
        options: ['10', '11', '12', '13'],
        correctAnswer: '12',
        explanation: '144 ÷ 12 = 12',
        difficulty: 1,
        timeLimit: 30,
        tags: ['division', 'basic'],
      ),
      Question(
        id: 'math_q5',
        lessonId: 'math_l1',
        questionText: 'Is 17 a prime number?',
        type: QuestionType.trueFalse,
        options: ['True', 'False'],
        correctAnswer: 'True',
        explanation: '17 is only divisible by 1 and itself, making it prime',
        difficulty: 2,
        timeLimit: 20,
        tags: ['prime_numbers', 'number_properties'],
      ),

      // MATHEMATICS - Algebra Basics
      Question(
        id: 'math_q6',
        lessonId: 'math_l2',
        questionText: 'Solve for x: 2x + 5 = 15',
        type: QuestionType.multipleChoice,
        options: ['x = 3', 'x = 5', 'x = 7', 'x = 10'],
        correctAnswer: 'x = 5',
        explanation: 'Subtract 5: 2x = 10, then divide by 2: x = 5',
        difficulty: 2,
        timeLimit: 60,
        tags: ['algebra', 'linear_equations'],
      ),
      Question(
        id: 'math_q7',
        lessonId: 'math_l2',
        questionText: 'Simplify: 3x + 2x',
        type: QuestionType.multipleChoice,
        options: ['5x', '6x', '5x²', '6x²'],
        correctAnswer: '5x',
        explanation: 'Combine like terms: 3x + 2x = 5x',
        difficulty: 1,
        timeLimit: 30,
        tags: ['algebra', 'simplification'],
      ),

      // ENGLISH - Parts of Speech
      Question(
        id: 'eng_q1',
        lessonId: 'eng_l1',
        questionText:
            'Which word is a noun in this sentence: "The cat runs quickly"?',
        type: QuestionType.multipleChoice,
        options: ['The', 'cat', 'runs', 'quickly'],
        correctAnswer: 'cat',
        explanation: 'A noun is a person, place, or thing. "Cat" is a thing.',
        difficulty: 1,
        timeLimit: 30,
        tags: ['grammar', 'nouns'],
      ),
      Question(
        id: 'eng_q2',
        lessonId: 'eng_l1',
        questionText: 'Identify the verb: "She dances gracefully"',
        type: QuestionType.multipleChoice,
        options: ['She', 'dances', 'gracefully', 'None'],
        correctAnswer: 'dances',
        explanation: 'A verb is an action word. "Dances" shows action.',
        difficulty: 1,
        timeLimit: 30,
        tags: ['grammar', 'verbs'],
      ),

      // ENGLISH - Subject-Verb Agreement
      Question(
        id: 'eng_q6',
        lessonId: 'eng_l2',
        questionText: 'Which sentence is correct?',
        type: QuestionType.multipleChoice,
        options: [
          'She don\'t like apples',
          'She doesn\'t likes apples',
          'She doesn\'t like apples',
          'She don\'t likes apples',
        ],
        correctAnswer: 'She doesn\'t like apples',
        explanation: 'Use "doesn\'t" with singular subjects and base verb form',
        difficulty: 2,
        timeLimit: 45,
        tags: ['grammar', 'agreement'],
      ),

      // PHYSICS - Motion & Speed
      Question(
        id: 'phy_q1',
        lessonId: 'phy_l1',
        questionText:
            'A car travels 100km in 2 hours. What is its average speed?',
        type: QuestionType.multipleChoice,
        options: ['25 km/h', '50 km/h', '100 km/h', '200 km/h'],
        correctAnswer: '50 km/h',
        explanation: 'Speed = Distance ÷ Time = 100km ÷ 2hrs = 50 km/h',
        difficulty: 2,
        timeLimit: 60,
        tags: ['kinematics', 'speed'],
      ),
      Question(
        id: 'phy_q2',
        lessonId: 'phy_l1',
        questionText: 'What is the SI unit of speed?',
        type: QuestionType.multipleChoice,
        options: ['km/h', 'm/s', 'mph', 'cm/s'],
        correctAnswer: 'm/s',
        explanation:
            'The SI (International System) unit of speed is meters per second (m/s)',
        difficulty: 1,
        timeLimit: 30,
        tags: ['units', 'basics'],
      ),

      // Additional Mathematics Questions
      Question(
        id: 'math_q8',
        lessonId: 'math_l2',
        questionText: 'What is the square root of 144?',
        type: QuestionType.multipleChoice,
        options: ['10', '11', '12', '13'],
        correctAnswer: '12',
        explanation: '12 × 12 = 144',
        difficulty: 1,
        timeLimit: 30,
        tags: ['square_root', 'basic'],
      ),
      Question(
        id: 'math_q9',
        lessonId: 'math_l2',
        questionText: 'Solve: 4x - 2 = 10',
        type: QuestionType.multipleChoice,
        options: ['x = 3', 'x = 4', 'x = 5', 'x = 6'],
        correctAnswer: 'x = 3',
        explanation: 'Add 2: 4x = 12, divide by 4: x = 3',
        difficulty: 2,
        timeLimit: 60,
        tags: ['algebra', 'equations'],
      ),
      Question(
        id: 'math_q10',
        lessonId: 'math_l2',
        questionText: 'What is 15% of 200?',
        type: QuestionType.multipleChoice,
        options: ['20', '25', '30', '35'],
        correctAnswer: '30',
        explanation: '15% = 0.15, 0.15 × 200 = 30',
        difficulty: 2,
        timeLimit: 45,
        tags: ['percentages', 'basic'],
      ),

      // Additional English Questions
      Question(
        id: 'eng_q7',
        lessonId: 'eng_l1',
        questionText: 'What is a synonym for "happy"?',
        type: QuestionType.multipleChoice,
        options: ['Sad', 'Joyful', 'Angry', 'Tired'],
        correctAnswer: 'Joyful',
        explanation: 'Joyful means feeling or showing happiness',
        difficulty: 1,
        timeLimit: 30,
        tags: ['vocabulary', 'synonyms'],
      ),
      Question(
        id: 'eng_q8',
        lessonId: 'eng_l1',
        questionText: 'Identify the adjective: "The tall building"',
        type: QuestionType.multipleChoice,
        options: ['The', 'tall', 'building', 'None'],
        correctAnswer: 'tall',
        explanation: 'Tall describes the building',
        difficulty: 1,
        timeLimit: 30,
        tags: ['grammar', 'adjectives'],
      ),
      Question(
        id: 'eng_q9',
        lessonId: 'eng_l2',
        questionText:
            'Choose the correct sentence: "He go to school" or "He goes to school"?',
        type: QuestionType.multipleChoice,
        options: ['He go to school', 'He goes to school'],
        correctAnswer: 'He goes to school',
        explanation: 'Third person singular needs "goes"',
        difficulty: 2,
        timeLimit: 45,
        tags: ['grammar', 'subject_verb_agreement'],
      ),
      Question(
        id: 'eng_q10',
        lessonId: 'eng_l2',
        questionText: 'What is the past tense of "run"?',
        type: QuestionType.multipleChoice,
        options: ['Ran', 'Runned', 'Running', 'Runs'],
        correctAnswer: 'Ran',
        explanation: 'Past tense of run is ran',
        difficulty: 1,
        timeLimit: 30,
        tags: ['grammar', 'verbs'],
      ),

      // Additional Physics Questions
      Question(
        id: 'phy_q3',
        lessonId: 'phy_l1',
        questionText: 'What is velocity?',
        type: QuestionType.multipleChoice,
        options: ['Speed', 'Speed with direction', 'Distance', 'Time'],
        correctAnswer: 'Speed with direction',
        explanation: 'Velocity includes both speed and direction',
        difficulty: 2,
        timeLimit: 45,
        tags: ['velocity', 'motion'],
      ),
      Question(
        id: 'phy_q4',
        lessonId: 'phy_l1',
        questionText: 'What is the acceleration due to gravity?',
        type: QuestionType.multipleChoice,
        options: ['8 m/s²', '9.8 m/s²', '10 m/s²', '12 m/s²'],
        correctAnswer: '9.8 m/s²',
        explanation: 'Gravity accelerates objects at 9.8 m/s² on Earth',
        difficulty: 1,
        timeLimit: 30,
        tags: ['gravity', 'acceleration'],
      ),
      Question(
        id: 'phy_q5',
        lessonId: 'phy_l1',
        questionText: 'What is Newton\'s First Law?',
        type: QuestionType.multipleChoice,
        options: [
          'F = ma',
          'Objects at rest stay at rest',
          'Action-reaction',
          'Energy conservation',
        ],
        correctAnswer: 'Objects at rest stay at rest',
        explanation:
            'An object at rest stays at rest unless acted upon by a force',
        difficulty: 2,
        timeLimit: 45,
        tags: ['newtons_laws', 'motion'],
      ),

      // Chemistry Questions
      Question(
        id: 'chem_q1',
        lessonId: 'chem_l1',
        questionText: 'What is the atomic number of Carbon?',
        type: QuestionType.multipleChoice,
        options: ['5', '6', '7', '8'],
        correctAnswer: '6',
        explanation: 'Carbon has 6 protons',
        difficulty: 1,
        timeLimit: 30,
        tags: ['atoms', 'elements'],
      ),
      Question(
        id: 'chem_q2',
        lessonId: 'chem_l1',
        questionText: 'What is H2O?',
        type: QuestionType.multipleChoice,
        options: ['Hydrogen', 'Oxygen', 'Water', 'Carbon dioxide'],
        correctAnswer: 'Water',
        explanation: 'H2O is the formula for water',
        difficulty: 1,
        timeLimit: 20,
        tags: ['compounds', 'formulas'],
      ),
      Question(
        id: 'chem_q3',
        lessonId: 'chem_l1',
        questionText: 'What is the pH of pure water?',
        type: QuestionType.multipleChoice,
        options: ['0', '7', '14', '1'],
        correctAnswer: '7',
        explanation: 'Pure water is neutral with pH 7',
        difficulty: 1,
        timeLimit: 30,
        tags: ['ph', 'acids_bases'],
      ),
      Question(
        id: 'chem_q4',
        lessonId: 'chem_l1',
        questionText: 'What gas do plants use in photosynthesis?',
        type: QuestionType.multipleChoice,
        options: ['Oxygen', 'Nitrogen', 'Carbon dioxide', 'Hydrogen'],
        correctAnswer: 'Carbon dioxide',
        explanation: 'Plants use CO2 for photosynthesis',
        difficulty: 1,
        timeLimit: 30,
        tags: ['photosynthesis', 'gases'],
      ),
      Question(
        id: 'chem_q5',
        lessonId: 'chem_l1',
        questionText: 'What is the symbol for Gold?',
        type: QuestionType.multipleChoice,
        options: ['Go', 'G', 'Au', 'Ag'],
        correctAnswer: 'Au',
        explanation: 'Gold\'s symbol is Au',
        difficulty: 1,
        timeLimit: 20,
        tags: ['elements', 'symbols'],
      ),

      // Biology Questions
      Question(
        id: 'bio_q1',
        lessonId: 'bio_l1',
        questionText: 'What is the basic unit of life?',
        type: QuestionType.multipleChoice,
        options: ['Atom', 'Molecule', 'Cell', 'Tissue'],
        correctAnswer: 'Cell',
        explanation: 'The cell is the basic unit of life',
        difficulty: 1,
        timeLimit: 30,
        tags: ['cells', 'basics'],
      ),
      Question(
        id: 'bio_q2',
        lessonId: 'bio_l1',
        questionText: 'What is the powerhouse of the cell?',
        type: QuestionType.multipleChoice,
        options: ['Nucleus', 'Mitochondria', 'Ribosome', 'Cell membrane'],
        correctAnswer: 'Mitochondria',
        explanation: 'Mitochondria produce energy',
        difficulty: 1,
        timeLimit: 30,
        tags: ['cell_structure', 'energy'],
      ),
      Question(
        id: 'bio_q3',
        lessonId: 'bio_l1',
        questionText: 'What controls the cell?',
        type: QuestionType.multipleChoice,
        options: ['Mitochondria', 'Cytoplasm', 'Nucleus', 'Cell wall'],
        correctAnswer: 'Nucleus',
        explanation: 'The nucleus controls cell activities',
        difficulty: 1,
        timeLimit: 30,
        tags: ['nucleus', 'dna'],
      ),
      Question(
        id: 'bio_q4',
        lessonId: 'bio_l1',
        questionText: 'What process makes food in plants?',
        type: QuestionType.multipleChoice,
        options: ['Respiration', 'Digestion', 'Photosynthesis', 'Fermentation'],
        correctAnswer: 'Photosynthesis',
        explanation: 'Photosynthesis makes food in plants',
        difficulty: 1,
        timeLimit: 30,
        tags: ['photosynthesis', 'plants'],
      ),
      Question(
        id: 'bio_q5',
        lessonId: 'bio_l1',
        questionText: 'What is DNA?',
        type: QuestionType.multipleChoice,
        options: ['Protein', 'Carbohydrate', 'Genetic material', 'Fat'],
        correctAnswer: 'Genetic material',
        explanation: 'DNA carries genetic information',
        difficulty: 1,
        timeLimit: 30,
        tags: ['dna', 'genetics'],
      ),
    ];
  }

  List<Achievement> _getDemoAchievements() {
    return [
      Achievement(
        id: 'streak_3',
        title: 'Getting Started',
        description: 'Maintain a 3-day streak',
        iconUrl: '🔥',
        type: AchievementType.streak,
        targetValue: 3,
        gemsReward: 10,
      ),
      Achievement(
        id: 'streak_7',
        title: 'Week Warrior',
        description: 'Maintain a 7-day streak',
        iconUrl: '⭐',
        type: AchievementType.streak,
        targetValue: 7,
        gemsReward: 25,
      ),
      Achievement(
        id: 'questions_50',
        title: 'Question Master',
        description: 'Answer 50 questions correctly',
        iconUrl: '🎯',
        type: AchievementType.questionsAnswered,
        targetValue: 50,
        gemsReward: 15,
      ),
      Achievement(
        id: 'lessons_10',
        title: 'Learning Machine',
        description: 'Complete 10 lessons',
        iconUrl: '📖',
        type: AchievementType.lessonsCompleted,
        targetValue: 10,
        gemsReward: 20,
      ),
      Achievement(
        id: 'perfect_5',
        title: 'Perfectionist',
        description: 'Get perfect scores on 5 lessons',
        iconUrl: '💯',
        type: AchievementType.perfectScore,
        targetValue: 5,
        gemsReward: 30,
      ),
    ];
  }

  // Check if initial data is loaded
  Future<bool> isDataLoaded() async {
    final subjects = await _storage.getAllSubjects();
    return subjects.isNotEmpty;
  }
}

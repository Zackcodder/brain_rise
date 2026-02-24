# TODO List for BrainRise App Updates

## 1. Create 30 Random Questions for All Subjects
- [x] Add 30 new questions distributed across Mathematics, English, Physics, Chemistry, Biology
- [x] Ensure questions are varied in difficulty and type
- [x] Update lib/services/questions_services.dart with new questions

## 2. Complete Subject Screen on Bottom Nav Bar
- [x] Implement full SubjectScreen widget
- [x] Show all available subjects with icons and descriptions
- [x] Allow navigation to subject details
- [x] Update lib/Screens/subject_screen.dart

## 3. Complete Leadership Board Screen
- [x] Implement LeadershipBoardScreen widget
- [x] Show user rankings based on levels, XP, or completed lessons
- [x] Fetch data from providers
- [x] Update lib/Screens/leadership_board_screen.dart

## 4. Make Home Screen Function Based on Quizzes Answered
- [x] Calculate actual progress for each subject based on answered questions
- [x] Update progress bars in HomeTab
- [x] Show quiz-based stats instead of hardcoded values
- [x] Update lib/Screens/MainTabs/home_tab.dart

## 5. Implement Topic Details and Study Material
- [ ] Create topic_details_screen.dart for reading about topics with examples
- [ ] Update subject_details_screen.dart to show lessons in grid view
- [ ] Add navigation from lesson grid to topic details

## 6. Implement Quiz Functionality
- [ ] Create quiz_screen.dart for taking quizzes with questions and options
- [ ] Create quiz_results_screen.dart for showing score and navigation options
- [ ] Update home_tab.dart to navigate to quiz when clicking subject cards
- [ ] Add scoring logic and progress tracking

## Followup Steps
- [x] Test the app in debug mode
- [ ] Build and test release APK
- [ ] Ensure all screens work properly

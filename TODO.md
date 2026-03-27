# TODO: Add More Lessons and Questions

## Objective
Add more lessons (topics) to subjects with up to 20 questions per topic.

## Tasks

- [x] 1. Analyze codebase and understand current structure
- [x] 2. Update Subject model - set totalLessons to 20 for all subjects
- [x] 3. Add 15 new lessons per subject (total 20 lessons per subject)
- [x] 4. Add 15-20 questions per lesson
- [x] 5. Update lesson questionIds to reference new questions

## Subjects Updated
- Mathematics (20 lessons) ✅
- English Language (20 lessons) ✅
- Physics (20 lessons) ✅
- Chemistry (20 lessons) ✅
- Biology (20 lessons) ✅

## Summary
- Total Subjects: 5
- Total Lessons: 100 (20 per subject)
- Total Questions: 2000 (20 per lesson × 100 lessons)

## Implementation Details
- Each lesson now has 20 questions
- Questions are dynamically generated with topics matching the lesson
- Difficulty scales with lesson progression (1-5)
- Prerequisites set up for sequential learning
- XP and Gems rewards increased for higher lessons




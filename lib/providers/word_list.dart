import 'package:flutter/material.dart';
import 'dart:async';

class WordList with ChangeNotifier {

  List<String> _wordList = [
    'Swoope',
    'Gimme a break!',
    'Gym',
    'Brimming with energy',
    'Shroud',
    'Seeps away',
    'Shattered',
    "Totally clueless",
    "Tranquil river",
    "a drawback",
    "Ace of spades",
    "Exceedingly difficult",
    "At incredible speed",
  ];

  List<String> _questions = [
    "If you could go back in time and change one thing, what would that be?",
    "What is one thing you would change about your home?",
    "What are some things that you should not not say during a job interview?",
    "What do you do when you're bored?",
    "What qualities do you value most in a friend?",
    "If you were the opposite gender for one day, what would you do?",
    "What celebrity do you like to follow?",
    "Do you like to plan things out or be spontaneous?",
    "What is your favorite childhood memory?",
    "What is the least favorite thing about this week?",
    "If you could choose your last meal, what would it be?",
    "What is one thing that you would like to change about the world?",
    "What is your favorite season?",
    "What is your favorite brand?",
    "Who is the most famous person you have met?",
    "What's the first thing you notice about a guy/girl",
    "Do you believe in luck?",
    "What is the best part of your day?",
    "What is your favorite sports team?",
    "If you were stuck on a desert island, what would you want to have with you?",
    "What is your biggest pet peeve?",
    "What is your favorite party game (or board game)?",
    "Where did you go on your last vacation?",
    "Do you read reviews about a movie before deciding whether to watch it or not?",
    "What is the best thing that happened to you this week?",
    "What is your favorite thing about summer?",
    "What do you do in your spare time?",
    "What's your family like?",
    "Do you like to dance or sing?",
    "When you were younger, what did you want to be when you grew up?",
    "What website do you visit the most?",
    "What is the best piece of advice that you've received?",
    "Are you a spender or a saver?",
    "If you could give one piece of advice to the whole world, what would it be?",
    "Would you rather be poor or ugly?",
    "How would you define success?",
    "Are you a spender or a saver?",
    "Would you rather not be able to use your hands or not be able to walk?",
    "Do you prefer to shop online or in a store?",
    "Are you smarter than your parents?",
    "What is your favorite sports team?",
    "What is something that you've never done but would like to try?",
    "What quality about yourself do you value most?",
    "What is biggest regret this week?",
    "How do you think the world will end?",
    "What's the worst thing you can say on a first date?",
    "If you were invisible for a day, what would you do?",
    "If you won \$1 million playing the lottery, what would you do?",
    "Would you want to know when you'll die?",
    "If you could only eat one thing for the rest of your life, what would it be?",
    "What is your favorite condiment?",
    "What is your favorite smell?",
    "What is the last thing you do before you go to sleep?",
    "What do you like to do on a rainy day?",
    "Tell me about your dream house.",
    "What is your favorite home cooked dish?",
    "Are you an indoor or outdoor person?",
    "What is the biggest priority in your life right now?",
    "What is your earliest memory?",
    "If you could try out any job for one week, what job would you choose to try?",
    "What was the last thing you bought?",
    "If you could have one super power, what would it be?",
    "Would you rather be rich and ugly, or poor and good looking?",
    "Would you rather be granted 3 wishes of your choice 10 years from today or be granted 1 wish today?",
    "If you became president, what is the first thing you would do?",
    "Are you a morning or a night person?",
    "What is your favorite ice cream flavor?",
    "What's the longest you have gone without sleep?",
    "What is your favorite song of all time?",
    "Are you a giver or taker?",
    "What is one of your favorite words or phrases?",
    "Is it better to work at a job that you love or a job that pays well?",
    "Are you a risk taker? What is the biggest risk that you've taken?",
    "What was your first car?",
    "If you could invent a holiday, what would it be?",
    "What is the longest that you've gone without doing laundry?",
    "What countries have traveled to?",
    "Would you rather be the most popular kid in school or the smartest kid in school?",
    "What are some things you shouldn't say at work?",
    "What are you most worried about right now?",
    "What motivates you?",
    "If you could live anywhere on earth, where would you live?",
    "Would you rather be the best player on a horrible team or the worst player on a great team?",
    "Do you believe in love at first sight?",
    "What is your favorite drink?",
    "Who was the last person that you called or texted?",
    "How would your friends describe you?",
    "If you where asked to teach a class, what class would you teach?",
    "What is your favorite thing about winter?",
    "What are your hobbies?",
    "Do you shower in the morning or evening?",
    "What do you think the best invention is?",
    "What is your morning routine?",
    "Do you believe in an afterlife?",
    "What was the last gift that you received?",
    "Do you prefer to travel or stay close to home?",
    "Do you have any pets?",
    "Is it harder to exercise more or eat healthier?",
    "What things are you passionate about?",
    "If you found \$100 on the ground, what would you do with it?",
    "Do you follow your heart or your head?",
    "What did you do last weekend?",
    "Would you prefer to live in an urban area or a rural area?",
    "How long does it take for you to get ready in the morning?",
    "What was the biggest thing you have ever won?",
    "What is the longest amount of time that you've slept for?",
    "If you could start any business, what would it be?",
    "What's in your fridge?",
    "What is your favorite pizza topping?",
    "Do you prefer to cook or order take out?",
    "What would you do differently if you could relive the past year?",
    "Where did you grow up?",
    "If you could acquire any skill, what would you choose?",
    "Where is your favorite place to shop?",
    "What do you usually eat in the morning?",
    "Do you recycle?",
    "At what age would you consider someone to be old?",
    "What do you do to stay in shape?",
    "Would you eat food that fell on the floor?",
    "If you could meet anybody in history, past or present, who would it be?",
    "What weird food combinations do you like?",
    "Would you rather lose an arm or a leg?",
    "If you were a waiter and had a rude customer, what would you do?",
  ];


  List<String> _interviewQuestions = [
    "Tell me about yourself.",
    "What attracted you to our company?",
    "Tell me about your strengths.",
    "What are your weaknesses?",
    "Where do you see yourself in five years?",
    "Can you tell me about a time where you encountered a business challenge? How did you overcome it?",
    "What are the most important things you are looking for in your next role?",
    "Why are you leaving your current job?",
    "What are your salary expectations?",
    "Do you have any questions for me?",
    "What makes you unique?",
    "What interests you about this role?",
    "What are your greatest weaknesses?",
    "What are your goals for the future?",
    "What is your ideal company size?",
    "What is your leadership style?",
    "Are you willing to travel?",
    "Tell me about a time you made a mistake.",
    "How did you hear about this position?",
    "Who are our competitors?",
    "Do you prefer to work alone or in groups?",
    "How do you describe you analytical skill? Good, average or bad.",
    "Are you good at mutlitasking?",
    "Are you self motivated/a self starter?",
    "What core value of the organization most resonates with you?",
    "Do you find it difficult to talk to and meet new people?",
    "What does integrity mean to you?",
    "If you were hired, how soon can you start?",
    "Are you overqualified for this role?",
    "What do you know about our company?",
    "Is it okay to miss a deadline? If so, when?",
    "How do you feel about working long hours?",
    "Would you get bored in a year and leave us?",
    "How would you deal with ambiguity in the workplace?",
    "Why is diversity important in the workplace?",
    "What do you think about overtime work?",
    "How long do you expect to stay with this company?",
    "How would you deal with a rude employee?",
    "What do you consider the most important qualities for this job?",
    "Can you from day one, be on your own, no processes, just be told what needs to be done, and do it?",
    "If you saw your boss stealing would you turn him in?",
    "Would you be willing to start out part-time?",
    "How do you see yourself fitting into the organization?",
    "What did you like least about your last position?",
    "Can you explain these gaps in your resume?",
    "Can you walk us through your resume?",
    "Why are you changing careers?",
    "Why is your resume so diverse?",
    "Were there any unethical situations at past jobs and how did you handle this?",
    "Have you ever been late for work? How do you make sure you always get to work on time?",
    "Pretend I didn’t read your resume, and we just met on the street and go from there…",
    "Tell me about a time where you had to delegate tasks during a project",
    "Give me an example of when you showed initiative and took the lead.",
    "Tell me about a time when you missed an obvious solution to a problem.",
    "Tell me about your proudest professional accomplishment.",
    "Describe a time when your work was criticized",
    "How would you feel about reporting to a person younger than you?",
    "Describe a time when you had to give a person difficult feedback.",
    "Suppose you are working on a project with an original scope of a few months and you are told that you instead now have a few days — how would you handle it?",
    "How would you communicate to team members that a deadline was approaching and they had to have their materials ready in time?",
    "Tell me a time when you had to make a quick decision without knowing all the facts.",
    "Tell me about a time you failed and what you learned.",
    "Tell me about a time that you jumped to an incorrect conclusion.",
    "Can you tell me about a time when you demonstrated leadership capabilities on the job?",
    "Which supporting skills do you think are most important when it comes to leadership?",
    "When there is a disagreement on your team, how do you handle it?",
    "What steps do you take to make sure that projects are completed on time, on budget, and to the proper standard?",
    "If a team member is under performing, what steps do you take to improve their performance?",
    "Tell me about your approach to delegation.",
    "Have you ever served in a coach or mentor role? How were you able to help the other person achieve success?",
    "How do you monitor a team’s performance?",
    "If a team is struggling to stay motivated, what steps would you take to boost engagement?",
    "Which of your past managers was your favorite leader, and why?",
    "How do you respond to constructive criticism?",
    "What approach do you use when you need to deliver constructive criticism?",
    "When starting with a new team, how do you evaluate the current state of their capabilities?",
    "What do you think is most important in creating a positive culture?",
    "How do you determine who gets access to professional development or training?",
    "If your project became unexpectedly shorthanded, what would you do to ensure it stayed on target?",
    "Tell us about a time you had to lead a meeting.",
    "Describe how you motivate others",
    "What are three qualities of leadership?",
    "Why haven’t you gotten your Bachelor’s Degree/Master’s Degree/Ph.D.?",
    "Why have you switched jobs so many times?",
    "How do you feel about working weekends or late hours?",
    "Do you have any serious medical conditions?",
    "Are you a risk-taker?",
    "Do you have any interests outside of work?",
    "Give an example of when you performed well under pressure.",
    "What do you think our company/organization could do better?",
    "Why did you choose this career and industry?",
    "What is your preferred way of communication? Email, phone, in-person?",
    "What prompted you to hire for this job role?",
    "If hired, what would be the top three priorities you'd like me to focus on in the coming year?",
    "What traits does the perfect candidate for this job position possess?",
    "What do you believe is the main reason someone could fail in this position?",
    "What is the work schedule like? Is it flexible, set-in-stone, or are there options?",
    "What is a typical day, week, or month like for someone within this position?",
    "What is the toughest time of the month or year for someone in this position?",
    "Tell me about a problem that you’ve solved in a unique or unusual way. What was the outcome? Were you happy or satisfied with it?",
    "Give me an example of when someone brought you a new idea that was odd or unusual. What did you do?",
    "Give me an example of a time when you had to be quick in coming to a decision.",
    "Describe a project or idea (not necessarily your own) that was implemented primarily because of your efforts. What was your role? ",
    "Tell me about a project you initiated. What did you do? Why? What was the outcome?",
    "Tell me about a time when your initiative caused a change to occur.",
    "What has been the best idea you have come up with during your professional career?",
    "What is the toughest group that you have ever had to lead? What were the obstacles? How did you handle the situation?",
    "How do you prioritize projects and tasks when scheduling your time? Give me some examples.",
    "Tell me about a particular work-related setback you have faced. How did you deal with it?",
    "When have you seen your tenacity or resilience really pay off in a professional setting? ",
    "What questions haven’t I asked you?",
    "What makes you uncomfortable?",
    "Tell me about a time where you used logic to solve a problem.",
    "Have you ever had to convince a team to work on a project they didn’t like? How did you do it?",
    "Have you ever had the opportunity to talk to your CEO? What did you talk about?",
    "How do you handle interruptions when you’re under a time constraint?",
    "Tell me what you do when presented with a deadline that seems too short.",
    "Have you ever had to deal with an irate manager? What did you do?",
    "What do you do to verify that the work you produce is accurate and valuable?",
    "What do you know about the company?",
    "What's your favourite non-professional activity?",
  ];

  bool _loading = false;
  bool _isStarted = true;
  bool _showActionSheet = false;

  get wordlist {
    return _wordList.take(3).toList();
  }
  get isStarted {
    return _isStarted;
  }
  get wordlistAll {
    return _wordList.take(8).toList();
  }
  get showActionSheet {
    return _showActionSheet;
  }
  get question {
    return _questions.take(1).toList()[0];
  }
  get loading {
    return _loading;
  }

  void togleActionSheet() {
    Timer(Duration(milliseconds: 50), () {
      _showActionSheet = !_showActionSheet;
      notifyListeners();      
    });
    
  }

  void startLoading() {
    _loading = true;
    Timer(Duration(milliseconds: 500), () {
      _loading = false;
      notifyListeners();
    });
  }

  void shuffle() {
    this._wordList.shuffle();
    this._questions.shuffle();
    startLoading();
    notifyListeners();
  }

  void addWord( String word ) {
    this._wordList.add('word');
    notifyListeners();
  }

  void start() {
    this._isStarted =  true;
    notifyListeners();
  }
}
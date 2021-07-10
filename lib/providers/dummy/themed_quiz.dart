class ThemedQuiz {
 List get(String type) {
    switch (type) {
      case 'morning':
        return _morningQuestions;
      case 'lunch':
        return _lunchQuestions;
      case 'night':
        return _nightQuestions;
      default:
        return [];
    }
  }
}

List<String> _morningQuestions = [
  "Did you have breakfast already? What was it?",
  "How is your productive routine in quarantine? Describe it :D?",
  "What time did you wake up?",
  "What do you have to do today? A lot of.. 🤔?",
  "Are you going out? Where to?",
  "What do you want to do today?",
  "Did you feed your pets? ❤️",
  "Do you workout? What did you do this morning at gym? 💪💪",
  "When you wake up, are there more people up in your house?",
  "What is your Today's Plan Of Attack?",
  "Do you have to do something in a HURRY rather soon!? 💨",
  "Do you have the morning free? Definitely not? Because?",
  "Do you like to study English in the morning? Is it better?",
  "Do you think it is a good idea to add English to your morning routine?",
  "Are you insanely organized? Do you plans it all out?, or make it up as you go along? 🏴‍☠️🏴‍☠️",
  "Have you ever gotten up early? What was that for?",
  "Is it very icy where do you live?",
  "Is it worth waking up this early if everything was freezing to death outside?",
  "What happens if you don't sleep 8-10 hours? Hm.. Still everything working?",
  "Describe to me the day just like it is now. Sounds, atmosphere, details",
  "Do you text your friends in the morning or do you skip doing it?",
  "Do you watch shows in the morning? On your laptop, TV, or do you think it's not SUPER productive? 🤓",
  "Do you know what will you do today?",
  "Have you ever gone out for a bike ride in the morning? Yes, with whom?",
  "How about cycling now? You down with it?",
];

List<String> _lunchQuestions = [
  "What did you eat today? Can you describe it?",
  "When you eat do you watch TV or any show?",
  "Can you guess what ingredients will be in the dinner today? 👀",
  "How many times a day do you eat?",
  "Do you like salads to eat with meals?",
  "Do you eat alone or with the family? Both?",
  "Have you ever had to eat in a hurry? How was it!?",
  "When a friend come over, do you like to cook for fun? Hm Like what?",
  "What food would you love to eat today? Explain me :P",
  "Which food do you like the most?",
  "What delicious and truly perfect foods you have learned to cook?",
  "Do you like pork ribs? When do you eat them? With Coke, juice, Fanta maybe?",
  "Have you ordered food online recently? How was it?",
  "Did you eat at home today or at work, college or in what place?",
  "Who will you have lunch with today?"
  "Do your pets eat food at the same time as you?",
  "Do you drink Coke, plain water, coffee or a soft drink at lunchtime? I'm hearinG! :D",
  "What did you eat for breakfast today? At what time, with who? Describe it to me :D",
  "What did you eat for dinner today or what would be good for? Hmm",
  "Have you ever tried to follow a diet? 👀",
  "Hmm, is cooking difficult? Or do you usually cook damn delicious meals at home?",
  "Have you tried to cook something that you have seen on Youtube?",
  "Would you like to get together with friends to go out for food THESE DAYS?",
  "Hey, are you down to order online food today?",
  "What is your favorite restaurant? What makes it special? 🍖😊",
  "What is your favorite vegan food? 🥗🍅😄",
];

List<String> _nightQuestions = [
  "Can you summarize your day?",
  "Hey, Too cold today?",
  "Tell me three good things about today. 🙊👌",
  "What places did you go?",
  "Did you hang out with someone? 🍺",
  "Did you study today? What especially?",
  "What did you have to do today?",
  "Did you have to cook today? 🍖😏",
  "Do you check your social networks when you wake up?",
  "Do you have a project? Progress with that today?👊👊",
  "Hmm... What did you have to do at work?",
  "How is your productive morning routine in quarantine?",
  "Did you get up early?",
  "What did you see in class?",
  "What were you in today's morning?",
  "Do you study at night? How is your late night study session?",
  "Did you get the time to organize your room today?",
  "Do you do home workout? What is your everyday workout routine?",
  "Do your day got a best part? :D",
  "How many cups of coffee did you have today!? ☕",
  "How would you like today to end?",
  "What will you do tomorrow? Are you going to be busy? In what?",
  "Something you gonna do now at night? Do you have something in mind?",
];

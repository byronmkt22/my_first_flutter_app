import 'dart:math';

/// A service for managing and retrieving random quotes
class QuoteService {
  static final List<String> _quotes = [
    'The only way to do great work is to love what you do. — Steve Jobs',
    'Innovation distinguishes between a leader and a follower. — Steve Jobs',
    'Code is poetry written for machines to read. — Unknown',
    'First, solve the problem. Then, write the code. — John Johnson',
    'Any fool can write code that a computer can understand. Good programmers write code that humans can understand. — Martin Fowler',
    'The best error message is the one that never shows up. — Thomas Fuchs',
    'Simplicity is the ultimate sophistication. — Leonardo da Vinci',
    'It always seems impossible until it\'s done. — Nelson Mandela',
    'The future belongs to those who believe in the beauty of their dreams. — Eleanor Roosevelt',
    'Build things that matter. — Unknown',
    'Premature optimization is the root of all evil. — Donald Knuth',
    'Make it work, make it right, make it fast. — Kent Beck',
    'Perfect is the enemy of good. — Voltaire',
    'Don\'t reinvent the wheel, but do improve it. — Unknown',
    'Debugging is twice as hard as writing code. If you write the code as cleverly as possible, you are, by definition, not smart enough to debug it. — Brian Kernighan',
  ];

  /// Returns a random quote
  static String getRandomQuote() {
    final random = Random();
    return _quotes[random.nextInt(_quotes.length)];
  }
}

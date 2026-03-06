/// Penyimpanan preferensi "intro sudah ditampilkan".
abstract class IntroStorage {
  Future<bool> hasSeenIntro();
  Future<void> setIntroSeen();
}

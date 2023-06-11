void main(List<String> args) {
  final boxer = Boxer.puncher(
    name: "Emelyanenko Fedor",
    base: Base.sambo,
    weight: 100,
    height: 200,
  );
  print(boxer);
  boxer.loose = 1;
  print(boxer);
}

abstract class Human {
  final String name;

  Human({required this.name});

  @override
  String toString() {
    return "Name is $name";
  }
}

abstract class IMetrics {
  double? weight;
  double? height;
}

abstract class IStatistics {
  int? fights;
  int? win;
  int? loose;
  int? nobody;
  @override
  String toString() {
    return super.toString() + " Statistics is fights: $fights, wins: $win, looses: $loose, nobody wins: $nobody";
  }
}

class Coach extends Human {
  Coach({required super.name});
}

abstract class Fighter extends Human with IStatistics, IMetrics {
  //"База" - базовый стиль единоборств, профильный для бойца
  Base? base;
  Coach? coach;
  Fighter(
      {required super.name, this.base, this.height, this.weight, this.coach});

  void set setCoach(Coach coach) {
    this.coach = coach;
  }

  @override
  double? height;

  @override
  double? weight;

  @override
  String toString() {
    return super.toString() +
        " height: $height, weight: $weight, coach is ${coach ?? "*Not assigned*"} ";
  }
}

class Boxer extends Fighter {
  BoxStyle? style;

  Boxer(
      {required super.name,
      required super.base,
      super.height,
      super.weight,
      this.style});
  // Конструкторы создания боксёров, основанные на стиле боя
  Boxer.outflighter({
    required super.name,
    required super.base,
    super.height,
    super.weight,
  }) : style = BoxStyle.Outflighter;
  Boxer.puncher(
      {required super.name, required super.base, super.height, super.weight, t})
      : style = BoxStyle.Puncher;
  Boxer.slugger({
    required super.name,
    required super.base,
    super.height,
    super.weight,
  }) : style = BoxStyle.Slugger;
  @override
  String toString() {
    return super.toString() +
        "style is ${style == null ? "Unknown style" : style!.name}";
  }
}

class Freestyler extends Fighter {
  Freestyler({
    required super.name,
    required super.base,
    required super.height,
    required super.weight,
  });
}

class MMAFighter extends Fighter {
  MMAFighter({
    required super.name,
    required super.base,
    required super.height,
    required super.weight,
  });
}

enum BoxStyle { Outflighter, Puncher, Slugger }

enum Base { box, freestyle, karate, sambo }

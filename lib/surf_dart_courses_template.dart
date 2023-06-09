// ignore_for_file: unused_field, unused_element

void main(List<String> args) {
  final ftor = Halogen.canInflameWater();
  final salt = ftor.oxidize(Aluminum());
  print(salt);
}

/// Класс галогенов
/// Все галогены являются сильными окислителями
/// https://ru.wikipedia.org/wiki/Галогены
/// Реагируют [почти] со всеми металлами
/// Имеют 7 електронов на внешнем енергетическом уровне
class Halogen extends NonMetal with Reactions implements PeriodicElement {
  ///все галогены являются ядовитыми веществами с сильно выраженным удушающим и поражающим ткани воздействиями
  static const bool _isPoisonous = true;
  late final Atom _atom;
  late final int _periodicNumber;
  late final Halogens _name;
  double? color;
  bool get isPoisonous => _isPoisonous;
  Halogen._({
    required final neutrons,
    required final int protons,
    required Halogens name,
    required int periodicNumber,
    this.color,
  }) {
    _atom = Atom(protons, neutrons);
    _periodicNumber = periodicNumber;
    _name = name;
  }

  factory Halogen.fluorine() {
    return Halogen._(
        neutrons: 10, protons: 10, name: Halogens.Fluorine, periodicNumber: 13);
  }

  factory Halogen.chlorine() {
    return Halogen._(
        neutrons: 20, protons: 20, name: Halogens.Chlorine, periodicNumber: 22);
  }

  factory Halogen.bromine() {
    return Halogen._(
        neutrons: 30, protons: 30, name: Halogens.Bromine, periodicNumber: 33);
  }
  // Вода способна гореть только во фторе
  factory Halogen.canInflameWater() {
    return Halogen.fluorine();
  }

  @override
  int get periodicNumber => _periodicNumber;

   @override
  String toString() {
    return _name.name;
  }
}

enum Halogens { Fluorine, Chlorine, Bromine }

/// от др.-греч. ἅλς — «соль» и γένος — «рождение, происхождение»
/// При взаимодействии с металлами возникает ионная связь, и образуются соли.
/// Галогены (кроме фтора) при взаимодействии с более электроотрицательными элементами могут проявлять
/// и восстановительные свойства вплоть до высшей степени окисления +7.
mixin Reactions on NonMetal {
  Compound oxidize(Element element) {
    if (element is Metal) {
      return Salt(metal: element, nonmetal: this);
    } else
      return Compound();
  }

  Compound recover(Element element) {
    if (element is Metal) {
      return Salt(metal: element, nonmetal: this);
    } else
      return Compound();
  }
}

/// Соединие неметалла с неметаллом не является солью
class Compound {}

/// Со́ли — сложные вещества, состоящие из катионов металлов и анионов кислотных остатков
class Salt extends Compound {
  Metal metal;
  Element nonmetal;
  Salt({required this.metal, required this.nonmetal});

  @override
  String toString() {
    return "This is ${nonmetal}ide of $metal";
  }
}

/// Вспомогательный класс для возможности использования  Metal и  NonMetal
abstract class Element {}

abstract class Metal extends Element {}

abstract class NonMetal extends Element {}

class Aluminum extends Metal implements PeriodicElement {
  @override
  int get periodicNumber => 13;
  @override
  String toString() {
    return "Aluminum";
  }
}

/// Хими́ческий элеме́нт как часть таблицы, содержит номер, группу и т.д.
abstract class PeriodicElement {
  final int periodicNumber;

  PeriodicElement(this.periodicNumber);
}

/// Ядро атома состоит из протонов и нейтронов.
class Atom {
  final int _protons;
  final int _neutrons;

  Atom(this._protons, this._neutrons);
}

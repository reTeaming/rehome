import 'dart:ffi';

class ExerciseDefaultData {
  int id;
  List<ParameterSet> parameters;

  ExerciseDefaultData(this.id, this.parameters);
}

abstract class ParameterSet {
  String name;
  RangeOfMotion range;
  Cocontraction cocontraction;
  Jerk jerk;

  ParameterSet(this.name, this.range, this.cocontraction, this.jerk);
}

class RangeOfMotion {
  Enum joint;
  Float value;

  RangeOfMotion(this.joint, this.value);
}

enum Joint { ELLBOW, WRIST, SHOULDER }

class Cocontraction {
  Float extensor1;
  Float extensor2;
  Float extensor3;
  Float flexor1;
  Float flexor2;
  Float flexor3;

  Cocontraction(this.extensor1, this.extensor2, this.extensor3, this.flexor1,
      this.flexor2, this.flexor3);
}

class Jerk {
  Float value;

  Jerk(this.value);
}

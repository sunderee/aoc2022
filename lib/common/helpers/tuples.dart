import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
@sealed
class Pair<A, B> extends Equatable {
  final A first;
  final B second;

  @override
  List<Object?> get props => [first, second];

  @literal
  const Pair(
    this.first,
    this.second,
  );

  @override
  String toString() => '$runtimeType: ${props.join(', ')}';
}

@immutable
@sealed
class Triple<A, B, C> extends Equatable {
  final A first;
  final B second;
  final C third;

  @override
  List<Object?> get props => [first, second, third];

  @literal
  const Triple(
    this.first,
    this.second,
    this.third,
  );

  @override
  String toString() => '$runtimeType: ${props.join(', ')}';
}

@immutable
@sealed
class Quadruple<A, B, C, D> extends Equatable {
  final A first;
  final B second;
  final C third;
  final D fourth;

  @override
  List<Object?> get props => [first, second, third, fourth];

  @literal
  const Quadruple(
    this.first,
    this.second,
    this.third,
    this.fourth,
  );

  @override
  String toString() => '$runtimeType: ${props.join(', ')}';
}

@immutable
@sealed
class Quintuple<A, B, C, D, E> extends Equatable {
  final A first;
  final B second;
  final C third;
  final D fourth;
  final E fifth;

  @override
  List<Object?> get props => [first, second, third, fourth, fifth];

  @literal
  const Quintuple(
    this.first,
    this.second,
    this.third,
    this.fourth,
    this.fifth,
  );

  @override
  String toString() => '$runtimeType: ${props.join(', ')}';
}

@immutable
@sealed
class Sextuple<A, B, C, D, E, F> extends Equatable {
  final A first;
  final B second;
  final C third;
  final D fourth;
  final E fifth;
  final F sixth;

  @override
  List<Object?> get props => [first, second, third, fourth, fifth, sixth];

  @literal
  const Sextuple(
    this.first,
    this.second,
    this.third,
    this.fourth,
    this.fifth,
    this.sixth,
  );

  @override
  String toString() => '$runtimeType: ${props.join(', ')}';
}

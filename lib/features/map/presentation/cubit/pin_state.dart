part of 'pin_cubit.dart';

class PinState extends Equatable {
  final bool isDragging;
  final bool isAvailable;

  const PinState({
    this.isDragging = false,
    this.isAvailable = true,
  });

  PinState copyWith({
    bool? isDragging,
    bool? isAvailable,
  }) {
    return PinState(
      isDragging: isDragging ?? this.isDragging,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }

  @override
  List<Object?> get props => [isDragging, isAvailable];
}
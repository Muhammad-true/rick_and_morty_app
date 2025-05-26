part of 'theme_bloc.dart';

sealed class ThemeState extends Equatable {
  final bool isDark;
  const ThemeState(this.isDark);

  @override
  List<Object> get props => [isDark];
}

final class ThemeInitial extends ThemeState {
  const ThemeInitial(super.isDark);
}

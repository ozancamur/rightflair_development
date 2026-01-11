part of 'search_cubit.dart';

class SearchState extends Equatable {
  final List<String> recentSearches;
  final bool isLoading;

  const SearchState({required this.recentSearches, required this.isLoading});

  factory SearchState.initial() {
    return const SearchState(
      recentSearches: ['Leather jackets', 'Streetwear'],
      isLoading: false,
    );
  }

  SearchState copyWith({List<String>? recentSearches, bool? isLoading}) {
    return SearchState(
      recentSearches: recentSearches ?? this.recentSearches,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [recentSearches, isLoading];
}

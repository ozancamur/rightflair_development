import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  SearchCubit() : super(SearchState.initial());

  void addRecentSearch(String query) {
    if (query.trim().isEmpty) return;

    final updatedSearches = List<String>.from(state.recentSearches);

    // Remove if already exists
    updatedSearches.remove(query);

    // Add to beginning
    updatedSearches.insert(0, query);

    // Keep only last 10 searches
    if (updatedSearches.length > 10) {
      updatedSearches.removeLast();
    }

    emit(state.copyWith(recentSearches: updatedSearches));
  }

  void removeRecentSearch(String query) {
    final updatedSearches = List<String>.from(state.recentSearches);
    updatedSearches.remove(query);
    emit(state.copyWith(recentSearches: updatedSearches));
  }

  void clearRecentSearches() {
    emit(state.copyWith(recentSearches: []));
  }

  void search(String query) {
    if (query.trim().isEmpty) return;
    addRecentSearch(query);
    // TODO: Implement actual search logic
  }

  @override
  Future<void> close() {
    searchController.dispose();
    searchFocusNode.dispose();
    return super.close();
  }
}

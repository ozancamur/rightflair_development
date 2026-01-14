class SettingsModel {
  final String username;
  final String email;
  final bool likesEnabled;
  final bool savesEnabled;
  final bool milestonesEnabled;
  final bool trendingEnabled;
  final bool followEnabled;
  final bool darkModeEnabled;
  final String language;

  const SettingsModel({
    required this.username,
    required this.email,
    this.likesEnabled = true,
    this.savesEnabled = true,
    this.milestonesEnabled = true,
    this.trendingEnabled = true,
    this.followEnabled = true,
    this.darkModeEnabled = false,
    this.language = 'english',
  });

  SettingsModel copyWith({
    String? username,
    String? email,
    bool? likesEnabled,
    bool? savesEnabled,
    bool? milestonesEnabled,
    bool? trendingEnabled,
    bool? followEnabled,
    bool? darkModeEnabled,
    String? language,
  }) {
    return SettingsModel(
      username: username ?? this.username,
      email: email ?? this.email,
      likesEnabled: likesEnabled ?? this.likesEnabled,
      savesEnabled: savesEnabled ?? this.savesEnabled,
      milestonesEnabled: milestonesEnabled ?? this.milestonesEnabled,
      trendingEnabled: trendingEnabled ?? this.trendingEnabled,
      followEnabled: followEnabled ?? this.followEnabled,
      darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
      language: language ?? this.language,
    );
  }
}

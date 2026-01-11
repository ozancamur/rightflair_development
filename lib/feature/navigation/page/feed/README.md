# Feed Page Bloc Implementation

Feed sayfası için Tinder/Bumble tarzı swipeable card özelliği ile Bloc pattern implementasyonu.

## Özellikler

- ✨ **3 Tab Yapısı**: Keşfet, Takip Edilenler, Arkadaşlar
- 🎴 **Tinder/Bumble Tarzı Swipe**: Post'ları sağa/sola kaydırarak beğen/beğenme
- 📚 **Stack Efekti**: Aynı anda 3 kart görünür (depth effect)
- ♻️ **Otomatik Yükleme**: Kart swaiplendiğinde alttan yeni post gelir
- 🔄 **State Management**: Flutter Bloc ile tam state management
- 📱 **Tab Bazlı Veri**: Her tab için ayrı post listesi ve state

## Dosya Yapısı

```
lib/feature/navigation/page/feed/
├── bloc/
│   ├── feed_bloc.dart       # Ana Bloc sınıfı
│   ├── feed_event.dart      # Event tanımları
│   └── feed_state.dart      # State tanımları
├── models/
│   └── feed_post_model.dart # Post model sınıfı
├── page/
│   └── feed_page.dart       # Ana feed sayfası
└── widgets/
    ├── feed_post_item.dart        # Tek bir post kartı (swipeable)
    ├── feed_tab_bars.dart         # Üst tab bar
    ├── feed_tab_views.dart        # Tab view container
    └── swipeable_post_stack.dart  # Swipeable card stack yöneticisi
```

## Bloc Events

- `LoadFeedEvent` - Belirli bir tab için postları yükler
- `SwipeRightEvent` - Post sağa kaydırıldığında (beğenildi)
- `SwipeLeftEvent` - Post sola kaydırıldığında (beğenilmedi)
- `LoadMorePostsEvent` - Daha fazla post yükler
- `ChangeTabEvent` - Tab değiştiğinde tetiklenir

## Bloc State

```dart
FeedState {
  FeedStatus status;              // loading, success, failure
  int currentTabIndex;            // Aktif tab (0, 1, 2)
  Map<int, List<FeedPostModel>> tabPosts;  // Her tab için post listesi
  Map<int, bool> hasReachedMax;   // Son posta ulaşıldı mı?
  String? errorMessage;           // Hata mesajı
}
```

## Kullanım

### Swipe Mekanizması

1. Kullanıcı kartı sağa/sola kaydırır
2. `FeedPostItem` swipe'ı algılar ve callback çağırır
3. `SwipeablePostStack` uygun event'i bloc'a gönderir
4. Bloc post'u listeden kaldırır ve yeni post ekler
5. UI otomatik güncellenir

### Tab Değişimi

1. Kullanıcı tab değiştirir
2. `FeedTabBars` tab controller'ı dinler
3. `ChangeTabEvent` tetiklenir
4. Bloc aktif tab'ı günceller
5. Eğer tab boşsa postları yükler

## Animasyonlar

- **Swipe Animasyonu**: Smooth kaydırma efekti
- **Stack Efekti**: 3 kartın üst üste durma efekti (scale + offset)
- **Beğen/Beğenmeme Göstergesi**: Yeşil/Kırmızı label animasyonu
- **Opacity Değişimi**: Kaydırma sırasında opacity efekti

## Mock Data

Şu anda bloc mock veri üretiyor. Gerçek implementasyonda:

```dart
// _generateMockPosts yerine repository kullanılacak
final posts = await _feedRepository.getPosts(tabIndex, page);
```

## İyileştirme Önerileri

1. **Repository Pattern**: API entegrasyonu için repository layer ekle
2. **Caching**: Visited postları cache'le
3. **Pagination**: Infinite scroll için sayfalama
4. **Error Handling**: Daha gelişmiş hata yönetimi
5. **Analytics**: Swipe eventlerini track et
6. **Pre-loading**: Görsel pre-loading için placeholder
7. **Local Storage**: Offline support için local DB

## Örnek API Entegrasyonu

```dart
class FeedRepository {
  Future<List<FeedPostModel>> getPosts(int tabIndex, int page) async {
    final response = await http.get('/feed/$tabIndex?page=$page');
    return (response.data as List)
        .map((json) => FeedPostModel.fromJson(json))
        .toList();
  }

  Future<void> likePost(String postId) async {
    await http.post('/posts/$postId/like');
  }

  Future<void> dislikePost(String postId) async {
    await http.post('/posts/$postId/dislike');
  }
}
```

## Bağımlılıklar

- `flutter_bloc: ^9.1.1` ✅ (pubspec.yaml'da mevcut)
- `equatable` (state karşılaştırması için)

Eğer `equatable` eksikse ekleyin:
```yaml
dependencies:
  equatable: ^2.0.5
```

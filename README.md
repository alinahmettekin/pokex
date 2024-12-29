## Pokex

A Flutter app that fetches data from the Pokémon API with the following features:

- **Pagination**: Displays Pokémon in a paginated list.
- **Favorites**: Add Pokémon to favorites and save them to device storage using `shared_preferences`.
- **Stats View**: Tap on a Pokémon to view its details and stats.
- **Loading Skeletons**: Skeleton animations for loading states using `skeletonizer`.

### Tech Stack

- **Dio**: For API requests.
- **Flutter Riverpod**: Used for state management with `FutureProvider.family()`.
- **Shared Preferences**: To store favorite Pokémon locally.
- **Get It**: For dependency injection.
- **Google Fonts**: Custom fonts for better UI.
- **Skeletonizer**: For skeleton loading animations.

# LOTY
### Game Review iOS App

---

## Phase 1 - Foundation

### Initial Setup
- Initial commit with basic Category page
- Applied `.gitignore` to exclude sensitive files like `Constants.swift`

### Category and Game List UI
- Added Category and Game List UI
- Game cells needed further work at this stage

### Game View Fixes
- Fixed games not showing on the TableView
- Fixed label overlap issue in GameCell

---

## Phase 2 - Core Features

### Search and Filter
- Added search bar functionality — games can be searched by title
- Added filter button — games can be filtered by status: Unplayed, Playing, Finished, Reviewed

### Footer Bar
- Added dynamic segmented footer bar showing status distribution per genre

### Game Status
- Added status change menu button to GameCell
- Status can be changed to Unplayed, Playing, or Finished directly from the list
- Reviewed status requires a rating — cannot be set manually from the list
- Changing status away from Reviewed deletes the review
- Fixed `cellForRowAt` so it no longer updates every cell on status change

### Single Game View
- Added UI elements to the Game Detail page
- Fixed Game Detail page layout and logic

---

## Phase 3 - API and Database

### API Integration
- Added API structure
- Removed `Constants.swift` from version control
- RAWG API working — game data fetching functional
- Images not yet included at this stage

### Database
- Realm database integrated and working
- Bug identified: screen did not update when returning from Game Detail after reviewing

### Bug Fixes
- Fixed delegate communication between `GameListViewController` and `GameDetailViewController` so UI updates correctly when returning from the detail page
- Fixed status button bug where changing game status was not working
- Fixed image not reloading when status was changed
- Added game images to category boxes
- Added game images to game cells
- Added photo to detail page, fixed scrolling issue

---

## Phase 4 - Architecture

### SnapKit Migration
- Migrated all Auto Layout from `NSLayoutConstraint` to SnapKit
- Fixed bug in GameDetail during migration
- Cleaned unnecessary comments and code

### Base Classes
- Added `BaseViewModel` and `BaseViewController<T>`
- Implemented shared `onDataUpdated`, `onError`, `isLoading` closures
- All ViewModels migrated to inherit from `BaseViewModel`
- All ViewControllers migrated to inherit from `BaseViewController<T>`

### Network Manager
- Integrated Alamofire successfully
- Refactored `NetworkManager` to use a single generic `request<T>()` function

---

## Phase 5 - Code Quality

### Extensions
- Created `Extensions.swift` with reusable helpers:
  - `Reusable` protocol for type-safe cell registration and dequeuing
  - Generic `dequeueReusableCell<T>` for `UITableView` and `UICollectionView`
  - `UIView.addSubviews(_:)` helper
  - `UITextField.doubleValue` computed property
  - `Double.ratingString` for consistent decimal formatting
- Audited all files — protocol conformances kept in class files since they access private state

### GameStatus Enum Improvements
- Added `CaseIterable` conformance
- Added `title` computed property using localized strings
- Added `icon` computed property for SF Symbol names
- Added `filterOptions` static property — filter sheet builds itself automatically
- Removed all hardcoded status string switches across the codebase

---

## Phase 6 - Localization

### Localization Setup
- Created `Localizable.strings` with full English string table
- Created `L10n` enum with nested namespaces: `Category`, `GameList`, `GameCell`, `GameDetail`, `GameStatus`, `Settings`, `Base`
- Added `String.localized` extension
- Applied localization across all ViewControllers and cells
- Added Turkish language support
- Added in-app language switcher (requires app restart to apply)
- Note: Game and genre names from RAWG API are intentionally not localized

---

## Phase 7 - Polish

### Launch Screen
- Removed `LaunchScreen.storyboard`
- Replaced with `UILaunchScreen` dictionary in `Info.plist` using `systemBackground`
- Cleared `Launch Screen Interface File Base Name` from Build Settings
- General code cleanup across multiple files

---

## Phase 8 - Image Caching

### Kingfisher Caching
- Added `.cacheOriginalImage` option to all `kf.setImage` calls
- Verified via Netfox: images are fetched from network once, then served from disk cache on subsequent loads

---

## Phase 9 - Network Debugging

### Netfox Integration
- Integrated Netfox 1.21.0 via Swift Package Manager
- Added debug button to `CategoryViewController` navigation bar
- Wrapped all Netfox references in `#if DEBUG` blocks including the import statement
- Verified API calls, response payloads, and image caching behavior through Netfox
- Netfox is fully excluded from release builds

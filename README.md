
# Game Review

![Swift](https://img.shields.io/badge/Swift-5.7+-orange?logo=swift)
![iOS](https://img.shields.io/badge/iOS-15.0+-blue?logo=apple)
![UIKit](https://img.shields.io/badge/UI-UIKit%20Programmatic-informational)
![License](https://img.shields.io/badge/License-MIT-green)

A personal iOS application for discovering video games by genre, tracking play status, and writing detailed reviews — built entirely in Swift with a programmatic UIKit interface.

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Tech Stack](#tech-stack)
- [Installation](#installation)
- [API Reference](#api-reference)
- [Known Limitations](#known-limitations)
- [Author](#author)

---

## Overview

Game Review is a native iOS app that connects to the [RAWG Video Games Database API](https://rawg.io/apidocs) to fetch real game data. Users can browse games by genre, track their gaming progress, and write personal reviews with detailed ratings across six categories. All user data is persisted locally using Realm, ensuring the app remains functional offline after the initial data load.

---

## Features

- Genre-Based Discovery — Browse game genres fetched dynamically from the RAWG API
- Search and Filter — Search games by title and filter by play status within any genre
- Detailed Review System — Rate games across six metrics: Graphics, Sound Design, Art Design, Gameplay, Story, and Overall
- Custom Review Text — Write free-form personal feedback for each game
- Status Tracking — Categorize games as Unplayed, Playing, Finished, or Reviewed
- Visual Progress Bar — Segmented progress bar showing status distribution per genre
- Offline Persistence — All ratings, reviews, and statuses are stored locally via Realm
- Pagination — Dynamically loads more games as the user scrolls
- Localization — Full English and Turkish language support
- Network Inspector — Netfox integration for debug-mode network traffic inspection
- Image Caching — Kingfisher caches game and genre images to disk for offline use

---

## Architecture

The app is built on the MVVM (Model-View-ViewModel) design pattern with a shared base layer for consistency across all screens.

```
+---------------------------------------------+
|                  View Layer                  |
|   CategoryVC --> GameListVC --> GameDetailVC |
|         (BaseViewController<T>)              |
+------------------+---------------------------+
                   |  Closures (onDataUpdated,
                   |  onError, isLoading)
+------------------v---------------------------+
|               ViewModel Layer                |
|  CategoryListVM  GameListVM  GameDetailVM    |
|            (BaseViewModel)                   |
+------------------+---------------------------+
                   |
       +-----------+-----------+
       v                       v    
+---------------+     +----------------+
| NetworkManager|     |  RealmManager  |
|  (Alamofire)  |     |  (Local DB)    |
+---------------+     +----------------+
       |
       v
+-------------+
|  RAWG API   |
+-------------+
```

### Base Layer

- `BaseViewModel` — Provides shared `onDataUpdated`, `onError`, and `isLoading` closures. Contains a generic `handleResult<T>()` method that all ViewModels use to process network responses uniformly.
- `BaseViewController<T>` — Generic ViewController that automatically wires up the loading spinner and error alerts from `BaseViewModel`. All ViewControllers inherit from this, getting error handling and loading state for free.

### Data Flow

1. ViewController calls a fetch method on its ViewModel
2. ViewModel calls `isLoading?(true)` — spinner starts automatically
3. `NetworkManager` fires the API request via Alamofire
4. Response is decoded and passed to `handleResult()`
5. On success: local Realm data is merged, `onDataUpdated?()` fires — UI reloads
6. On failure: `onError?()` fires — error alert shown automatically
7. Spinner stops in both cases

---

## Project Structure

```
Game Review/
├── App/
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
├── Base/
│   ├── BaseViewController.swift
│   └── BaseViewModel.swift
├── Models/
│   ├── Game.swift
│   ├── GameStatus.swift
│   ├── Category.swift
│   ├── Review.swift
│   ├── RAWGModels.swift
│   └── LocalGameData.swift
├── ViewModels/
│   ├── CategoryListViewModel.swift
│   ├── GameListViewModel.swift
│   └── GameDetailViewModel.swift
├── Views/
│   ├── Cells/
│   │   ├── CategoryCell.swift
│   │   └── GameCell.swift
│   └── Controllers/
│       ├── CategoryViewController.swift
│       ├── GameListViewController.swift
│       └── GameDetailViewController.swift
├── Utilities/
│   ├── Constants.swift
│   ├── Extensions.swift
│   ├── GameEndpoint.swift
│   ├── NetworkManager.swift
│   └── RealmManager.swift
└── Resources/
    ├── Assets.xcassets
    └── Localizable.strings
```

---

## Tech Stack

| Purpose | Library | Version |
|---|---|---|
| Networking | Alamofire | 5.11.2 |
| Image Loading and Caching | Kingfisher | 8.8.1 |
| Local Database | RealmSwift | 20.1.4 |
| Auto Layout | SnapKit | 5.7.1 |
| Network Debugging (DEBUG only) | Netfox | 1.21.0 |

All dependencies are managed via Swift Package Manager (SPM).

---

## Installation

### Prerequisites
- Xcode 14+
- iOS 15.0+ device or simulator
- A valid [RAWG API key](https://rawg.io/apidocs)

### Steps

1. Clone the repository
```bash
git clone https://github.com/fakdet/GameReview.git
cd GameReview
```

2. Open the project
```bash
open "Game Review.xcodeproj"
```

3. Resolve SPM dependencies

Xcode will automatically resolve dependencies on first open. If not: File -> Packages -> Resolve Package Versions

4. Add your API key

Open `Utilities/Constants.swift` and replace the existing key:
```swift
enum API {
    static let key = "YOUR_RAWG_API_KEY_HERE"
    static let baseURL = "https://api.rawg.io/api"
}
```

5. Build and run

---

## API Reference

This app uses the [RAWG Video Games Database API](https://rawg.io/apidocs).

| Endpoint | Description |
|---|---|
| `GET /genres` | Fetches all available game genres |
| `GET /games?genres={id}&page={n}` | Fetches paginated games for a genre |
| `GET /games/{id}` | Fetches detailed info for a single game |

---

## Known Limitations

- Genre and game names are not localized — These come directly from the RAWG API which does not support Turkish. Only UI strings are localized.
- No user authentication — All data is stored locally on the device. There is no cloud sync or account system.
- Publisher data — Some games may show no publisher if the RAWG API does not include that data for the title.

---

## Author

M. Azizcan Erdogan
GitHub: [@fakdet](https://github.com/fakdet)
Project developed: April - May 2026

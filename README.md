# PokeStudyApp

[![codecov](https://codecov.io/github/giulianoaccorsi/PokeStudyApp/graph/badge.svg?token=Q6EHFJ4IYG)](https://codecov.io/github/giulianoaccorsi/PokeStudyApp)
[![CircleCI](https://dl.circleci.com/status-badge/img/gh/giulianoaccorsi/PokeStudyApp/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/giulianoaccorsi/PokeStudyApp/tree/main)

### Description

The PokeStudy app uses the [PokeAPI](https://pokeapi.co/) to display detailed information about Pokémon, including stats, abilities, and types. Tapping on a Pokémon will route you to the details screen, which contains comprehensive information about the Pokémon, such as attributes, abilities, and weaknesses.

| List Light Mode                                                                                         | Detail Light Mode                                                                                       | List Dark Mode                                                                                          | Detail Dark Mode                                                                                        |
| ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| <img src="https://github.com/user-attachments/assets/02a9f2aa-376d-496b-9e89-43f7bfd78426" width="300"> | <img src="https://github.com/user-attachments/assets/b89aa4da-a614-4e94-91ba-6e016a6766b6" width="300"> | <img src="https://github.com/user-attachments/assets/516ea456-c514-43a9-afb5-170800b335c0" width="300"> | <img src="https://github.com/user-attachments/assets/1fcf93b6-2293-45e0-b79d-ed1bb802119a" width="300"> |

## Features

- Modularization using SPM
- MVVM
- Infinity Scroll
- SwiftUI
- Dark Mode
- Internationalization (English and PT-Br)
- Unit tests
- Combine

### Instalation

This project was made using **Xcode 15.4**, Swift and SwiftUI and the following SPM Packages:

- [OggDecoder](https://github.com/arkasas/OggDecoder) - A package used to decode Ogg audio files, providing efficient playback within the app.

- [Lottie](https://github.com/airbnb/lottie-ios) - A library for rendering Adobe After Effects animations natively on iOS, allowing for beautiful, high-performance animations in your app.

- [SwiftLint](https://github.com/realm/SwiftLint) - A tool to enforce Swift style and conventions, ensuring that the codebase remains clean and consistent according to best practices.

- [Kingfisher](https://swiftpackageindex.com/onevcat/Kingfisher) - Used to download and cache images in a simpler way, without making the images flick or something else.

- NetworkingLayer - This package was created by me and leverages the Combine framework for managing asynchronous data streams, allowing for efficient network requests and responses within the app.

First of all download and install Xcode then clone the repository

```
https://github.com/giulianoaccorsi/PokeStudyApp
```

Open the directory project and double tap on PokeStudy.xcodeproj

### Design

[Figma Design](https://www.figma.com/community/file/1202971127473077147/pokedex-pokemon-app) - A special thanks to Junior Saraiva for creating this incredible design file, which served as a fundamental resource in developing the UI/UX of the PokeStudy app. The thoughtfully crafted components and layouts provided by Junior were instrumental in shaping a modern and engaging interface. Your work has truly enhanced the visual quality and user experience of this project—thank you!

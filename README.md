# The Codex Ledger

**The Codex Ledger** is an unofficial open-source tool designed to assist players of the [Daggerheart](https://www.daggerheart.com/) tabletop roleplaying game. It provides digital character sheet functionality and a searchable reference for cards, weapons, armour, and items.

> **Important**: This app does not include official Daggerheart game data, due to restrictions under the **Community Game License** which prohibits digital tool support.

---

## Features

- Record and manage your Daggerheart character sheets
- Browse and search cards, weapons, armour, and item lists
- Cross-platform support for:
  - Linux (Desktop)
  - Windows (Desktop)
  - Android (Mobile)

---

## Limitations

The app is in active development and currently has the following limitations:
- No support for multi-classing (yet)
- Character sheets include only basic rule handling - many effects must be managed manually
- Custom cards, weapons, armour and item import is not yet supported (under development)
- No support for managing primary and secondary equipped weapons
- No support for recording character experiences
- Character description and backstory fields are missing
- No support for iOS or Mac
- Cannot be compiled to web app due to use of SQLite

---

## Known Issues

- With the lack of proper data, the search and filter functions do not work.

---

## Roadmap
- Support for multi-classing
- Implement support for advancement
- Export character sheet to json and pdf
- Template functionality for PDFs
- Adding custom themes
- 
---

## Getting Started

This app is built with **Flutter** and requires a working Flutter development environment to run or build.

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Git
- Android Studio or VS Code

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/daggerheart-companion-app.git
   cd daggerheart-companion-app
   ````

2. Fetch dependencies:

   ```bash
   flutter pub get
   ```

3. Run the app:

   ```bash
   flutter run
   ```

> Note: No official data is included. You can load or create your own custom content through JSON and Markdown files.
> Templates have been included

---

## 📁 Data

Due to licensing limitations, this app **does not include** or support distribution of official Daggerheart content.

You're free to create your own content for personal use.

---

## Dependencies

All required dependencies are listed in `pubspec.yaml`.

---

## Contribution

Contributions are welcome! Feel free to fork the repo, open issues, or submit pull requests to help improve the app.

---

## License

This project is licensed under the **GNU General Public License v3.0** (or later). See the [LICENSE](LICENSE) file for details.

---

## Acknowledgements

* Inspired by the [Daggerheart RPG](https://www.daggerheart.com/)
* This is a community-created tool and is not affiliated with or endorsed by Darrington Press or Critical Role.
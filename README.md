# D&D 5e Character Sheet App (Flutter)

In this repository, you will find the code for the Flutter version of the D&D 5e Character Sheet application designed for the Dungeons & Dragons 5th Edition.

## Abstract
This project presents a mobile application developed using Flutter, aimed at facilitating the management of Dungeons & Dragons characters and campaigns. Users can create and manage their characters and campaigns, share them with friends, and access statistical insights for gameplay. The application enhances the gaming experience by providing essential tools for both players and Game Masters.

**Keywords**: Dungeons & Dragons, character management, campaign management, Flutter app, Firebase

---

<a name="index"></a>

## 📘 Table of Contents

* [🎯 Project Goal](#statement)
* [⚙️ Methodology](#methodology)
* [📲 Features](#features)
* [👨🏻‍💻 Authors](#Authors)

<a name="statement"/></a>

## 🎯 Project Goal

The primary goal of the D&D 5e Character Sheet App (Flutter) is to simplify game organization for players of Dungeons & Dragons. Users can create free accounts to access two main sections: Characters and Campaigns, thereby enhancing their gameplay experience.

<a name="methodology"/></a>

## ⚙️ Methodology

### Architecture

The application follows a reactive programming model provided by Flutter, allowing for smooth and responsive UI interactions. Firebase is employed for authentication and database storage to ensure data persistence and security. Local data management for spells is handled through the Hive database.

### User Account and Functionality

Users can create accounts to access the main functionalities of the app:
- **Characters**: View and manage a list of characters, including guided setup for new characters.
- **Campaigns**: Create or join campaigns, manage sessions, and utilize Game Master functionalities for better game management.

<a name="features"/></a>

## 📲 Features

- **Firebase Authentication**: User login and registration are managed via Firebase Authentication.
- **Persistent Data**: Firestore Database stores character, campaign, and session data.
- **Modular Design**: A clear separation of character, campaign, and utility components within the codebase.
- **Statistical Tracking**: Tracks player progress and gameplay statistics, providing insights for character profiles.

<a name="Authors"/></a>

## 👨🏻‍💻 Authors

| Name                    | Email                       | GitHub                                          |
|-------------------------|-----------------------------|-------------------------------------------------|
| Federico Staffolani     | s1114954@studenti.univpm.it | [fedeStaffo](https://github.com/fedeStaffo)    |
| Enrico Maria Sardellini | s1120355@studenti.univpm.it | [Ems01](https://github.com/Ems01)              |

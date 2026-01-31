
# Food Delivery Flutter App

A full-featured **food delivery application** built with **Flutter** that allows users to browse restaurants, view menus, add items to cart, and complete orders with multiple payment options. The app features a modern dark theme UI and follows clean architecture principles.

<div style="text-align: center;">
  <img src="Assets/FigMA/image1.png"/>
</div>

---

## Table of Contents

1. [Project Overview](#project-overview)  
2. [Features](#features)  
   - User Interface  
   - Restaurant & Ordering  
   - Shopping Cart  
   - Payment System  
   - Authentication & Persistence  
   - Search & Discovery  
3. [Architecture & Tech Stack](#architecture--tech-stack)  
4. [Project Structure](#project-structure)  
5. [Getting Started](#getting-started)  
6. [UI Components](#ui-components)  
7. [App Flow](#app-flow)  
8. [Development Notes](#development-notes)  
9. [License & Author](#license--author)  

---

## Project Overview

This Flutter project is a **cross-platform food delivery app** designed for Android and iOS. Users can:

- Browse restaurants and menus  
- Add items to a cart  
- Complete orders with multiple payment methods  
- View order history  

The app follows **clean architecture principles** with separation of concerns, BLoC/Cubit state management, and a Singleton pattern for global cart management.

---

## Features

### 🏠 User Interface

- Dark Theme Design with green accents  
- Responsive Layout for different screen sizes  
- Smooth Animations and interactive transitions  
- Bottom Navigation for main sections: Home, Browse, Orders, Profile  

### 🍔 Restaurant & Ordering

- Restaurant Listings categorized as "Fastest" and "Recommended"  
- Menu Display with images and prices  
- Quantity Management with animated controls  
- Restaurant Details: Full-screen views with menus and information  

### 🛒 Shopping Cart

- Global Cart Management using Singleton pattern  
- Real-time updates across screens  
- Order Summary with fees and discounts  
- Delivery Options: Delivery or Pickup  

### 💳 Payment System

- Multiple payment methods: Cash or Card  
- Card Management: Add and save cards  
- Form validation for card number, expiry, and CVV  
- State Management with BLoC/Cubit  

### 🔐 Authentication & Persistence

- Phone Number Login with validation  
- Local Storage via SharedPreferences  
- Automatic login for returning users  

### 🔍 Search & Discovery

- Category-based browsing  
- Search functionality for restaurants and menu items  
- Filters: Distance and ratings  

---

## Architecture & Tech Stack

**Core Architecture:**

- Clean Architecture (Separation of concerns)  
- BLoC Pattern (flutter_bloc) for state management  
- Singleton Pattern for global cart state  
- Repository Pattern for data abstraction  

**Network Layer:**

- Dio HTTP client with interceptors  
- Custom API result wrapper (Success/Failure)  
- Centralized exception handling (AppException)  

**Data Models:**

- `RestaurantModel`, `MenuItemModel`, `CartItem`, `NavItem`  

**Storage:**

- SharedPreferences with `SharedPrefsHelper`  

**UI/UX:**

- Google Fonts (Roboto Condensed)  
- Custom ThemeData for consistent styling  
- Input formatters and validators for forms  

---

## Project Structure

    final_proj/
    ├── core/
    │ ├── models/ # Data models
    │ ├── network/ # API & HTTP configuration
    │ ├── resources/ # Colors, icons, routes
    │ └── storage/ # SharedPreferences helper
    ├── features/
    │ ├── home/ # Home screen logic & UI models
    │ ├── splash/ # Splash screen
    │ └── (other features)/ # Search, cart, checkout, profile
    ├── util/
    │ └── validation/ # Input validators
    └── main.dart # App entry point


---

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)  
- Dart SDK  
- Android Studio / VS Code  
- Emulator or physical device  

### Installation

```bash
git clone <repository-url>
cd final_proj
flutter pub get

Configure API

Open core/network/ApiConstants.dart and update:

static const String baseUrl = 'http://YOUR_IP_ADDRESS:3000/';
static const String restaurantsEndPoint = 'api/restaurants';

Run the App
flutter run
```

## UI Components

**Screens:**

<div style="text-align: center;">
  <img src="Assets/FigMA/image2.png"/>
  <img src="Assets/FigMA/image3.png"/>
  <img src="Assets/FigMA/image4.png"/>
  <img src="Assets/FigMA/image5.png"/>
</div>


**Custom Widgets:**

FoodCard, CategoryItem, QuantityController, PaymentTile

Input formatters and validators

## App Flow

Launch → Splash screen

Authentication → Phone number input

Main App → Home with bottom navigation

Browse → Search or category view

Order → Select restaurant → Add items → Cart → Checkout → Payment

Profile → User settings and info
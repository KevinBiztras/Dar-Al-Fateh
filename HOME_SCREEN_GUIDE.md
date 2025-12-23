# Home Screen Architecture & Data Flow Guide

## 📋 Table of Contents
1. [Architecture Overview](#architecture-overview)
2. [Complete Data Flow](#complete-data-flow)
3. [File Structure](#file-structure)
4. [Step-by-Step Code Reading Guide](#step-by-step-code-reading-guide)
5. [How Each Component Works](#how-each-component-works)

---

## 🏗️ Architecture Overview

This app uses the **BLoC (Business Logic Component) Pattern**, which separates:
- **UI Layer** (Widgets/Screens)
- **Business Logic Layer** (BLoC)
- **Data Layer** (Repository → API Client)

```
┌─────────────────────────────────────────────────────────┐
│                    UI LAYER                              │
│  ┌──────────────────────────────────────────────────┐  │
│  │  home_screen.dart (Widget)                        │  │
│  │  - Displays UI                                    │  │
│  │  - Listens to BLoC states                         │  │
│  │  - Sends events to BLoC                            │  │
│  └──────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
                        ↕ (BlocBuilder/Events)
┌─────────────────────────────────────────────────────────┐
│                 BUSINESS LOGIC LAYER                    │
│  ┌──────────────────────────────────────────────────┐  │
│  │  home_screen_bloc.dart                           │  │
│  │  - Receives Events                               │  │
│  │  - Calls Repository                              │  │
│  │  - Emits States                                  │  │
│  └──────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
                        ↕
┌─────────────────────────────────────────────────────────┐
│                    DATA LAYER                            │
│  ┌──────────────────┐  ┌─────────────────────────────┐ │
│  │  Repository     │→ │  API Client                 │ │
│  │  (Data Source)  │  │  (HTTP Calls)                │ │
│  └──────────────────┘  └─────────────────────────────┘ │
└─────────────────────────────────────────────────────────┘
```

---

## 🔄 Complete Data Flow

### Step-by-Step Flow:

```
1. USER OPENS APP
   ↓
2. home_screen.dart → initState() 
   ↓
3. homePageBloc?.add(HomeScreenDataFetchEvent(offset))
   ↓
4. home_screen_bloc.dart → mapEventToState()
   ↓
5. repository?.getHomeData(offset)
   ↓
6. home_screen_repository.dart → getHomeData()
   ↓
7. ApiClient().getHomePageData(...)
   ↓
8. api_client.dart → Dio Interceptor (onRequest)
   ↓
9. Returns Mock Data (for example.com) OR Real API Call
   ↓
10. HomePageData.fromJson() → Parses JSON to Model
   ↓
11. Repository returns HomePageData
   ↓
12. BLoC emits HomeScreenSuccess(homePageData)
   ↓
13. BlocBuilder rebuilds UI
   ↓
14. _layout() method creates widgets based on data type
   ↓
15. UI displays: Slider, Categories, Banner
```

---

## 📁 File Structure

### Key Files for Home Screen:

```
lib/screens/home/
├── home_screen.dart                    # Main UI Screen
├── bloc/
│   ├── home_screen_bloc.dart          # Business Logic (BLoC)
│   ├── home_screen_event.dart         # Events (triggers)
│   ├── home_screen_state.dart         # States (results)
│   └── home_screen_repository.dart    # Data Source
└── views/
    ├── home_collection_view.dart      # Product Slider Widget
    ├── home_featured_categories.dart  # Categories Widget
    ├── home_banners.dart              # Banner Widget
    └── recent_view.dart               # Recent Products Widget

lib/networkManager/
├── api_client.dart                    # API Client (HTTP)
└── dio_exceptions.dart                # Error Handling

lib/models/
└── HomeScreenModel.dart               # Data Models
```

---

## 📖 Step-by-Step Code Reading Guide

### **Step 1: Start with the UI (home_screen.dart)**

**Location:** `lib/screens/home/home_screen.dart`

**What to look for:**
1. **Line 90-91:** `homePageBloc?.add(HomeScreenDataFetchEvent(offset))` - This triggers data fetch
2. **Line 158:** `BlocBuilder<HomeScreenBloc, HomeScreenState>` - This listens to state changes
3. **Line 251:** `_layout()` method - This decides what widgets to show

**Key Code:**
```dart
// Line 90-91: When screen loads, fetch data
homePageBloc = context.read<HomeScreenBloc>();
homePageBloc?.add(HomeScreenDataFetchEvent(offset));

// Line 158-246: Listen to state changes
BlocBuilder<HomeScreenBloc, HomeScreenState>(
  builder: (context, currentState) {
    if (currentState is HomeScreenSuccess) {
      // Data received! Update UI
      homePageData = currentState.homePageData;
      homepageDataList = currentState.homePageData?.homepageDataList;
    }
  }
)

// Line 251-276: Build UI based on data type
Widget _layout(List<HomepageDataList> data) {
  for (var val in data) {
    if (val.type == "slider") {
      // Show product slider
    } else if (val.type == "featured_category") {
      // Show categories
    } else if (val.type == "banner") {
      // Show banner
    }
  }
}
```

---

### **Step 2: Understand the BLoC (Business Logic)**

**Location:** `lib/screens/home/bloc/home_screen_bloc.dart`

**What it does:**
- Receives events (like `HomeScreenDataFetchEvent`)
- Calls repository to get data
- Emits states (like `HomeScreenSuccess` or `HomeScreenError`)

**Key Code:**
```dart
// Line 55-76: Main logic
void mapEventToState(HomeScreenEvent event, Emitter<HomeScreenState> emit) async {
  if (event is HomeScreenDataFetchEvent) {
    emit(HomeScreenInitial());  // Show loading
    
    // Try to get cached data first
    HomePageData? cacheModel = await getHomeDataFromHiveDB();
    if (cacheModel != null) {
      emit(HomeScreenSuccessCache(cacheModel));  // Show cached data
    }
    
    // Fetch fresh data from API
    var model = await repository?.getHomeData(event.offset);
    if (model != null) {
      emit(HomeScreenSuccess(model));  // Show fresh data
    } else {
      emit(HomeScreenError(''));  // Show error
    }
  }
}
```

**States:**
- `HomeScreenInitial` - Loading state
- `HomeScreenSuccess` - Data received successfully
- `HomeScreenSuccessCache` - Using cached data
- `HomeScreenError` - Error occurred

**Events:**
- `HomeScreenDataFetchEvent(offset)` - Request to fetch data

---

### **Step 3: Check the Repository (Data Source)**

**Location:** `lib/screens/home/bloc/home_screen_repository.dart`

**What it does:**
- Makes API calls
- Handles data caching
- Returns `HomePageData` model

**Key Code:**
```dart
// Line 44-69: Fetch data from API
Future<HomePageData> getHomeData(int offset) async {
  // Prepare request data
  Map<String, dynamic> data = {};
  data["fcmToken"] = firebaseToken;
  data["fcmDeviceId"] = fcmDeviceId;
  
  // Call API
  model = await ApiClient()
      .getHomePageData(apiKey, body, "text/plain", offset.toString(), "5");
  
  // Cache the data
  if (offset == 0) {
    hiveService.addBox(model, homeBoxName);
  }
  
  return model;
}
```

---

### **Step 4: Understand API Client (HTTP Layer)**

**Location:** `lib/networkManager/api_client.dart`

**What it does:**
- Handles HTTP requests
- Intercepts requests for mock data (when using example.com)
- Returns JSON responses

**Key Code:**
```dart
// Line 125-170: Request Interceptor
onRequest: (options, handler) {
  // Check if it's homepage API and using placeholder host
  if (isPlaceholderHost && options.path.contains('mobikul/homepage')) {
    // Return mock data directly (no HTTP call)
    return handler.resolve(Response(
      requestOptions: options,
      data: mockData,  // Your mock JSON data
      statusCode: 200,
    ));
  }
  return handler.next(options);  // Continue with real API call
}
```

**Mock Data Structure:**
The mock data in the interceptor (lines 130-220) contains:
- `homepageData` array with items of type:
  - `"slider"` → Product slider
  - `"featured_category"` → Category grid
  - `"banner"` → Banner images

---

### **Step 5: Understand Data Models**

**Location:** `lib/models/HomeScreenModel.dart`

**What it does:**
- Defines the structure of data
- Parses JSON to Dart objects

**Key Models:**
```dart
HomePageData {
  List<HomepageDataList>? homepageDataList;  // Main content list
  List<Categories>? categories;               // All categories
  int? cartCount;                             // Cart items count
  List<int>? wishlist;                        // Wishlist IDs
}

HomepageDataList {
  String? type;        // "slider", "featured_category", "banner"
  String? name;        // Section title
  List<Data>? data;    // Actual content
}

Data {
  // For products (slider):
  List<Products>? products;
  String? title;
  String? sliderMode;
  
  // For categories:
  int? categoryId;
  String? categoryName;
  String? url;  // Image URL
  
  // For banners:
  String? bannerName;
  String? bannerType;
  String? url;  // Image URL
}
```

---

### **Step 6: Understand UI Components**

**Location:** `lib/screens/home/views/`

**Widgets:**

1. **HomeCollection** (`home_collection_view.dart`)
   - Displays product slider
   - Receives: `List<Data>? products`
   - Shows horizontal scrolling products

2. **HomeFeaturedCategories** (`home_featured_categories.dart`)
   - Displays category grid/circle
   - Receives: `HomepageDataList? categories`
   - Shows clickable category icons

3. **HomeBanners** (`home_banners.dart`)
   - Displays banner carousel
   - Receives: `HomepageDataList? banners`
   - Shows auto-scrolling banner images

---

## 🎯 How Each Component Works

### **1. Product Slider (3 Sample Products)**

**Flow:**
```
Mock Data (api_client.dart, line 140-160)
  ↓
HomePageData.fromJson() parses JSON
  ↓
homepageDataList[0] with type="slider"
  ↓
_layout() method (home_screen.dart, line 264-270)
  ↓
HomeCollection widget (home_collection_view.dart)
  ↓
Displays 3 products horizontally
```

**Data Structure:**
```json
{
  "type": "slider",
  "data": [{
    "products": [
      {"name": "Sample Product 1", "thumbNail": "...", ...},
      {"name": "Sample Product 2", ...},
      {"name": "Sample Product 3", ...}
    ]
  }]
}
```

---

### **2. Featured Categories (Men, Women, Kids, Electronics)**

**Flow:**
```
Mock Data (api_client.dart, line 170-190)
  ↓
homepageDataList[1] with type="featured_category"
  ↓
_layout() method (home_screen.dart, line 254-261)
  ↓
HomeFeaturedCategories widget
  ↓
Displays 4 categories in grid
```

**Data Structure:**
```json
{
  "type": "featured_category",
  "featured_category_view_type": "grid",
  "data": [
    {"categoryId": 1, "categoryName": "Men", "url": "..."},
    {"categoryId": 2, "categoryName": "Women", "url": "..."},
    ...
  ]
}
```

---

### **3. Banner**

**Flow:**
```
Mock Data (api_client.dart, line 195-205)
  ↓
homepageDataList[2] with type="banner"
  ↓
_layout() method (home_screen.dart, line 262-263)
  ↓
HomeBanners widget
  ↓
Displays auto-scrolling banner
```

**Data Structure:**
```json
{
  "type": "banner",
  "data": [{
    "bannerName": "Special Offer Banner",
    "url": "https://via.placeholder.com/..."
  }]
}
```

---

## 🚀 How to Make Changes

### **To Change Mock Data:**
1. Open: `lib/networkManager/api_client.dart`
2. Find: `onRequest` interceptor (around line 125)
3. Modify: The `mockData` object (lines 130-220)
4. Change: Add/remove/modify items in `homepageData` array

### **To Change UI Layout:**
1. Open: `lib/screens/home/home_screen.dart`
2. Find: `_layout()` method (line 251)
3. Modify: The widget creation logic
4. Add: New widget types or modify existing ones

### **To Change Widget Appearance:**
1. Open: `lib/screens/home/views/`
2. Choose: The widget file (e.g., `home_collection_view.dart`)
3. Modify: The `build()` method to change UI

### **To Add New Data Type:**
1. Add new type in mock data (api_client.dart)
2. Add condition in `_layout()` method (home_screen.dart)
3. Create new widget in `views/` folder
4. Import and use in `_layout()`

---

## 📝 Quick Reference

### **Where Data Comes From:**
- **Mock Data:** `api_client.dart` → `onRequest` interceptor (line 125-220)
- **Real API:** Would come from `ApiClient().getHomePageData()` if not using example.com

### **Where Data is Processed:**
- **Parsing:** `HomePageData.fromJson()` in `HomeScreenModel.g.dart`
- **Business Logic:** `home_screen_bloc.dart` → `mapEventToState()`
- **Caching:** `home_screen_repository.dart` → `hiveService.addBox()`

### **Where UI is Built:**
- **Main Screen:** `home_screen.dart` → `_layout()` method
- **Widgets:** `lib/screens/home/views/` folder

### **Key Variables:**
- `homePageData` - Complete data model
- `homepageDataList` - Array of sections (slider, categories, banner)
- `currentState` - Current BLoC state (Success, Error, Loading)

---

## 💡 Tips for Understanding Code

1. **Start from UI:** Always start reading from the screen/widget file
2. **Follow the flow:** UI → BLoC → Repository → API
3. **Use breakpoints:** Set breakpoints to see data flow
4. **Check console logs:** Look for `debugPrint()` statements
5. **Read models first:** Understand data structure before reading logic
6. **Use IDE navigation:** Ctrl+Click (Cmd+Click on Mac) to jump to definitions

---

## 🔍 Debugging Tips

1. **Check BLoC states:** Add `print()` in `mapEventToState()` to see state changes
2. **Check API response:** Add `print()` in repository to see API data
3. **Check UI rendering:** Add `print()` in `_layout()` to see which widgets are created
4. **Check data structure:** Print `homepageDataList` to see what data you have

---

This guide should help you understand the complete flow. Start with `home_screen.dart` and follow the data flow step by step!


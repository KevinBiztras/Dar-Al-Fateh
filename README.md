
# Odoo App Configuration

## Instructions to configure the application:


1- For configuring the base url, basic auth key and map api key:
-> Got to app_constant.dart file and change the above mentioned names.
path- lib/constants/app_constants.dart
Ex.-> baseUrl = 'https://example.com/'
   -> baseData = "authkey:authkey"
   -> googleKey = "YOUR-MAP-API-KEY"


2- For changing the app colors:
-> Go to theme.dart file and change the colors.
Ex.->  clientPrimaryColor = Color(0xFFFFFFFF)
   ->  clientAccentColor = Color(0xFF000000)


3- For changing the splash image, app icon image and place holder image:
-> Go to images folder inside assets folder in the root of this project and replace the images.
Ex.-> placeholder.png
   -> splash.png
   -> appIcon.png


4- For changing the Launcher icon:
-> Go to the below given path and replace icons with yours
For android->
-> path- android/app/src/main/res/
-> name-ic_launcher in mipmip/hdpi,mdpi,xhdpi,xxhdpi

For Ios-> You need to open project in Xcode and add the app icons and launch image in the assets
-> path-> Runner/Runner/Assets


5- Change your ApplicationId:
-> Go to the below given path
For Android->
-> path- android/app/build.gradle
Ex.-> applicationId "com.example.marketplace.odoo"

For IOS ->
-> You Need to open project in Xcode,then open general information inside the Runner. Here You can change your app name.
Ex.-> Display Name -> YOUR APP NAME


6- Change your google-service.json and GoogleService-info.plist file
-> Go to below given path
-> path- android/app
-> path- ios


7- Change your application name, map api key, host:
-> Go to below path
-> path- android/app/src/res/AndroidManifest.xml
Ex.-> android:label="Your App Name">
   -> android:host="example.com"
   -> <meta-data
        android:name="com.google.android.geo.API_KEY"
         android:value="YOUR-MAP-API-KEY" />

-> path- ios/Runner/AppDelegate.swift
Ex.->    GMSServices.provideAPIKey("YOUR-MAP-API-KEY")










# Dar-Al-Fateh

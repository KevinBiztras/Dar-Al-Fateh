# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile

#-------------------------------------------------------------------------------------------------------------------------------------------

# Retrofit 2.X
## https://square.github.io/retrofit/ ##
# https://github.com/krschultz/android-proguard-snippets/blob/master/libraries/proguard-square-retrofit2.pro

-dontwarn retrofit2.**
-keep class retrofit2.** { *; }
-keepattributes Signature
-keepattributes Exceptions

-keepclasseswithmembers class * {
    @retrofit2.http.* <methods>;
}

-dontwarn okhttp3.**
-keep class okhttp3.** {*;}


#-------------------------------------------------------------------------------------------------------------------------------------------

-keep public enum com.bumptech.glide.load.resource.bitmap.ImageHeaderParser$** {
  **[] $VALUES;
  public *;
}

-dontwarn okio.**

#-------------------------------------------------------------------------------------------------------------------------------------------

-keepattributes InnerClasses
-keepattributes EnclosingMethod

# For Crashlytics
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable

-keep class com.crashlytics.** { *; }
-dontwarn com.crashlytics.**

#-------------------------------------------------------------------------------------------------------------------------------------------

# For ARCore
-dontwarn com.google.ar.sceneform.animation.AnimationEngine
-dontwarn com.google.ar.sceneform.animation.AnimationLibraryLoader

#-------------------------------------------------------------------------------------------------------------------------------------------



#-------------------------------------------------------------------------------------------------------------------------------------------

-dontwarn com.google.maps.**
-dontwarn com.itextpdf.text.pdf.**
-dontwarn org.joda.time.**
-dontwarn org.slf4j.**



-dontwarn com.google.android.gms.auth.api.credentials.Credential
-dontwarn com.google.android.gms.auth.api.credentials.CredentialsApi
-dontwarn com.google.android.gms.auth.api.credentials.HintRequest$Builder
-dontwarn com.google.android.gms.auth.api.credentials.HintRequest
-dontwarn com.google.ar.sceneform.animation.AnimationEngine
-dontwarn com.google.ar.sceneform.animation.AnimationLibraryLoader
-dontwarn com.google.ar.sceneform.assets.Loader
-dontwarn com.google.ar.sceneform.assets.ModelData
-dontwarn com.google.devtools.build.android.desugar.runtime.ThrowableExtension
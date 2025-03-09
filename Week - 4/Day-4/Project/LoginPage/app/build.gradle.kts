plugins {
    alias(libs.plugins.android.application)
    alias(libs.plugins.kotlin.android)
    id("com.google.gms.google-services")
}

android {
    namespace = "com.pj.loginpage"
    compileSdk = 35

    buildFeatures {
        viewBinding = true
    }

    defaultConfig {
        applicationId = "com.pj.loginpage"
        minSdk = 23
        targetSdk = 35
        versionCode = 1
        versionName = "1.0"

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
    kotlinOptions {
        jvmTarget = "11"
    }
}

dependencies {

    implementation(libs.androidx.core.ktx)
    implementation(libs.androidx.appcompat)
    implementation(libs.material)
    implementation(libs.androidx.activity)
    implementation(libs.androidx.constraintlayout)

    // 🔹 Removed Mediation Test Suite if unnecessary (causes potential AdMob inclusion)
    // implementation(libs.mediation.test.suite)

    testImplementation(libs.junit)
    androidTestImplementation(libs.androidx.junit)
    androidTestImplementation(libs.androidx.espresso.core)


    // 🔹 Firebase BOM
    implementation(platform(libs.firebase.bom))

    // 🔹 Firebase Analytics (Exclude AdMob to prevent initialization issues)
    implementation(libs.firebase.analytics) {
        exclude(group = "com.google.android.gms", module = "play-services-ads")
    }

    // 🔹 Google Play Services Auth (Exclude Ads if included)
    implementation(libs.play.services.auth) {
        exclude(group = "com.google.android.gms", module = "play-services-ads")
    }
}

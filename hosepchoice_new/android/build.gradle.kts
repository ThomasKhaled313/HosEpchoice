// Top-level build.gradle.kts

buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // Add your Android Gradle Plugin
        classpath("com.android.tools.build:gradle:8.1.1") // or your version
        // Add Google Services plugin (for Firebase)
        classpath("com.google.gms:google-services:4.4.2") // << This is the correct place
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// This part is usually not necessary unless you're customizing Flutter build outputs
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

// Clean task
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

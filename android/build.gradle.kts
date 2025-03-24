allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Define a new build directory
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    val newSubprojectBuildDir = newBuildDir.dir(project.name)
    project.layout.buildDirectory.set(newSubprojectBuildDir)
}

// Define a clean task
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

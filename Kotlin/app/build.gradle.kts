plugins {
    kotlin("jvm") version "2.2.20"
    application
}

dependencies {
    implementation(kotlin("stdlib"))
    testImplementation(kotlin("test"))
    testRuntimeOnly("org.junit.jupiter:junit-jupiter-engine:5.10.2")
}

tasks.test {
    useJUnitPlatform()
    testLogging { events("passed", "skipped", "failed") }
}

kotlin { jvmToolchain(21) }

application { mainClass = "com.example.AppKt" }

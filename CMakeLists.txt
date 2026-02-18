cmake_minimum_required(VERSION 3.16)

project(ACMusicPlayer VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMKAE_CXX_STANDARD 23)

find_package(Qt6 REQUIRED COMPONENTS Quick)
find_package(HuskarUI REQUIRED)

qt_standard_project_setup(REQUIRES 6.8)

set(CMAKE_AUTORCC TRUE)

qt_add_executable(mplayer
    res/resources.qrc
)

qt_add_qml_module(mplayer
    URI ACMusicPlayer
    QML_FILES
        qml/Main.qml
        qml/Home/HomePage.qml
        qml/Home/SettingsPage.qml
        qml/Home/MusicHome.qml
    SOURCES
    SOURCES include/version.h include/themeswitchitem.h
    RESOURCES res/resources.qrc
    SOURCES src/main.cpp src/themeswitchitem.cpp
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(mplayer PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_include_directories(mplayer
    PRIVATE include
)

target_link_libraries(mplayer
    PRIVATE Qt6::Quick
    PRIVATE HuskarUI::Basic
)

include(GNUInstallDirs)
install(TARGETS mplayer
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

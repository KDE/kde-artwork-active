project(plasma-mobile)
cmake_minimum_required (VERSION 2.8)

find_package(KDE4 REQUIRED)

include(KDE4Defaults)

if (NOT DEFINED SCREEN_RESOLUTION)

    set(SCREEN_RESOLUTION 1366x768)
endif (NOT DEFINED SCREEN_RESOLUTION)
message("-- installing artwork for screen resolution of ${SCREEN_RESOLUTION}")

install(FILES splash/main.qml
              splash/Preview.png
              splash/Theme.rc
        DESTINATION ${DATA_INSTALL_DIR}/ksplash/Themes/ActiveAir)

install(DIRECTORY splash/images
        DESTINATION ${DATA_INSTALL_DIR}/ksplash/Themes/ActiveAir/)

# Lockscreen
install(DIRECTORY lockscreen/contents
        DESTINATION ${DATA_INSTALL_DIR}/ksmserver/screenlocker/org.kde.active.slide/ PATTERN .svn EXCLUDE)
install(FILES lockscreen/metadata.desktop
        DESTINATION ${DATA_INSTALL_DIR}/ksmserver/screenlocker/org.kde.active.slide/)


install(FILES
            wallpaper/${SCREEN_RESOLUTION}/Orchid.jpg
            wallpaper/${SCREEN_RESOLUTION}/CarribeanSunset.jpg
            wallpaper/${SCREEN_RESOLUTION}/Cactus.jpg
            wallpaper/${SCREEN_RESOLUTION}/RedFlower.jpg
            wallpaper/${SCREEN_RESOLUTION}/Dome.jpg
            wallpaper/${SCREEN_RESOLUTION}/Reichstag.jpg
            wallpaper/${SCREEN_RESOLUTION}/Sky.jpg
            wallpaper/${SCREEN_RESOLUTION}/PotsdamerPlatz.jpg
            wallpaper/${SCREEN_RESOLUTION}/PalmLeave.jpg
            wallpaper/${SCREEN_RESOLUTION}/default_wallpaper.png
            wallpaper/${SCREEN_RESOLUTION}/wallpaper-kdelogo.png
        DESTINATION ${WALLPAPER_INSTALL_DIR})

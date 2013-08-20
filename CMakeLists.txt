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

install(FILES splash/${SCREEN_RESOLUTION}/active-logo-1.png
              splash/${SCREEN_RESOLUTION}/active-logo-2.png
              splash/${SCREEN_RESOLUTION}/active-logo-3.png
              splash/${SCREEN_RESOLUTION}/background.png
              splash/${SCREEN_RESOLUTION}/bottomleft-smallvine-3.png
              splash/${SCREEN_RESOLUTION}/bottomleft-vine-1.png
              splash/${SCREEN_RESOLUTION}/bottomleft-vine-2.png
              splash/${SCREEN_RESOLUTION}/bottomleft-vine-3.png
              splash/${SCREEN_RESOLUTION}/bottomleft-vine-4.png
              splash/${SCREEN_RESOLUTION}/bottomleft-vine-5.png
              splash/${SCREEN_RESOLUTION}/spinner.png
              splash/${SCREEN_RESOLUTION}/topright-vine-2.png
              splash/${SCREEN_RESOLUTION}/topright-vine-3.png
              splash/${SCREEN_RESOLUTION}/topright-vine-4.png
        DESTINATION ${DATA_INSTALL_DIR}/ksplash/Themes/ActiveAir/images)

# Lockscreen
install(DIRECTORY lockscreen/contents
        DESTINATION ${DATA_INSTALL_DIR}/ksmserver/screenlocker/org.kde.active.slide/ PATTERN .svn EXCLUDE)
install(FILES lockscreen/metadata.desktop
        DESTINATION ${DATA_INSTALL_DIR}/ksmserver/screenlocker/org.kde.active.slide/)
install(FILES lockscreen/${SCREEN_RESOLUTION}/wallpaper.png
        DESTINATION ${DATA_INSTALL_DIR}/ksmserver/screenlocker/org.kde.active.slide/contents/ui)

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

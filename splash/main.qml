/*
 *   Copyright (C) 2011 Ivan Cukic <ivan.cukic(at)kde.org>
 *   Copyright (C) 2011 Marco Martin <mart@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License version 2,
 *   or (at your option) any later version, as published by the Free
 *   Software Foundation
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 1.0

Image {
    id: main
    source: "images/noiselight.png"
    fillMode: Image.Tile

    width: screenSize.width
    height: screenSize.height

    Image {
        source: "images/gradient.png"
        anchors.fill: parent
    }
    /* property declarations --------------------------{{{ */
    property int stage
    /* }}} */

    /* signal declarations ----------------------------{{{ */

    /* }}} */

    /* JavaScript functions ---------------------------{{{ */
    Component.onCompleted: {
        stage1BottomLeftVine.opacity = 1
    }
    onStageChanged: {
        if (stage == 4) {
            kLogo.opacity = 0.2
        } else if (stage == 5) {
            kLogo.opacity = 0.5
        } else if (stage == 6) {
            kLogo.opacity = 1
        }
    }
    /* }}} */

    /* object properties ------------------------------{{{ */

    /* }}} */

    /* child objects ----------------------------------{{{ */


    Image {
        id: kLogo
        anchors.horizontalCenter: parent.horizontalCenter
        y: 90
        source: "images/active-logo.png"
        opacity: 0

        Behavior on opacity {
            NumberAnimation {
                duration: 800
                easing {
                    type: Easing.InOutQuad 
                }
            }
        }
    }

        
    Image {
        id: busyindicator
        source: "images/busyindicator.png"
        anchors.horizontalCenter: parent.horizontalCenter
        smooth: true
        anchors.centerIn: parent

        RotationAnimation on rotation {
            from: 0
            to: 360
            duration: 2500
            running: busyindicator.opacity > 0
            loops: Animation.Infinite
        }
    }
    /* }}} */

    /* stages -----------------------------------------{{{ */

    /* }}} */

    /* transitions ------------------------------------{{{ */

    /* }}} */
}


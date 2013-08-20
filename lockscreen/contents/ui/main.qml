/***************************************************************************
 *   Copyright 2011 Artur Duque de Souza <asouza@kde.org>                  *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA .        *
 ***************************************************************************/

import QtQuick 1.0
import org.kde.plasma.core 0.1 as PlasmaCore
import org.kde.plasma.components 0.1 as PlasmaComponents
import org.kde.qtextracomponents 0.1


Item {
    id: lockScreen
    width: 800
    height: 600

    property bool suspendToRamSupported: false
    property bool shutdownSupported: false
    signal unlockRequested()
    signal suspendToRam()
    signal shutdown()

    onSuspendToRamSupportedChanged: {
        sleepSlider.visible = suspendToRamSupported
    }

    onShutdownSupportedChanged: {
        shutdownSlider.visible = shutdownSupported
    }

    Image {
        source: "wallpaper.png"
        anchors.centerIn: parent
    }

    MouseArea {
        anchors.fill: parent
        onPressed: mouse.accepted = true
    }

    PlasmaCore.Theme {
        id: theme
    }

    Behavior on opacity {
        NumberAnimation {duration: 250}
    }

    Item {
        id: lockArea
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        height: 120
    }

    // TODO: format with klocale
    Timer {
        id: clockTimer
        repeat: true
        running: true
        interval: 30000
        triggeredOnStart: true
        property string time
        onTriggered: {
            var currentTime = new Date();
            var currentHours = currentTime.getHours()
            if (currentHours < 10) {
                currentHours = "0" + currentHours
            }
            var currentMinutes = currentTime.getMinutes()
            if (currentMinutes < 10) {
                currentMinutes = "0" + currentMinutes
            }
            time = currentHours + ":" + currentMinutes
        }
    }

    Item {
        id: unlockArea
        anchors {
            top: parent.top
            bottom: lockArea.top
            left: parent.left
            right: parent.right
        }

        Text {
            text: clockTimer.time
            font.pixelSize: 75
            font.family: theme.font.family
            font.bold: theme.font.bold
            color: Qt.rgba(0, 0, 0, 0)
            style: Text.Sunken
            styleColor: Qt.rgba(0, 0, 0, 0.5)
            anchors.horizontalCenter: parent.horizontalCenter
            y: 100
        }

        Text {
            id: timeText
            text: clockTimer.time
            font.pixelSize: 75
            font.family: theme.font.family
            font.bold: theme.font.bold
            color: Qt.rgba(0, 0, 0, 0.05)
            style: Text.Raised
            styleColor: Qt.rgba(1, 1, 1, 0.8)
            anchors.horizontalCenter: parent.horizontalCenter
            y: 100
        }

        Text {
            id: unlockText
            text: i18n("Drag here to unlock")
            color: "white"
            anchors.centerIn: parent
            font.pixelSize: 36
            font.family: theme.font.family
            font.bold: theme.font.bold
            font.capitalization: theme.font.capitalization
            font.italic: theme.font.italic
            font.weight: theme.font.weight
            font.underline: theme.font.underline
            font.wordSpacing: theme.font.wordSpacing
            opacity: 0

            Behavior on opacity {
                NumberAnimation { duration: 200 }
            }
        }

        SliderSwitch {
            id: sleepSlider
            maximumValue: 100
            value: maximumValue
            x: -4
            anchors.verticalCenter: timeText.verticalCenter
            property int autoStep: maximumValue / 50
            property bool requestSent: false
            handleName: "sleep"
            visible: suspendToRamSupported

            onVisibleChanged: {
                if (visible) {
                    autoSleepTimer.running = true
                } else {
                    sleepText.text = i18n("Sleep")
                }
            }

            onValueChanged: {
                if (value > 5) {
                    requestSent = false
                } else if (!requestSent) {
                    autoSleepTimer.running = false
                    lockScreen.suspendToRam()
                    requestSent = true
                    resetTimer.running = true;
                }
            }

            onPressedChanged: {
                if (pressed) {
                    autoSleepTimer.running = false
                } else {
                    value = maximumValue;
                }
            }

            Text {
                id: sleepText
                text: i18n("Sleep")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
            }
 
            Timer {
                id: resetTimer
                repeat: false
                interval: 200

                onTriggered: {
                    sleepSlider.value = sleepSlider.maximumValue
                    sleepText.text = i18n("Sleep")
                }
            }

            Timer {
                id: autoSleepTimer
                repeat: true
                running: false
                interval: 100

                onTriggered: {
                    sleepSlider.value = sleepSlider.value - sleepSlider.autoStep;
                    sleepText.text = i18np("Sleeping in 1 second", "Sleeping in %1 seconds", (sleepSlider.value / sleepSlider.autoStep * interval / 1000))
                }

                onRunningChanged: {
                    if (!running) {
                        resetTimer.running = true
                    }
                }
            }
        }

        SliderSwitch {
            id: shutdownSlider
            maximumValue: 100
            value: maximumValue
            x: parent.width - width + 4
            anchors.verticalCenter: timeText.verticalCenter
            visible: shutdownSupported
            handleName: "shutdown"
            property bool requestSent: false;
            inverted: true

            onValueChanged: {
                if (value > 5) {
                    requestSent = false;
                } else if (!requestSent) {
                    autoSleepTimer.running = false
                    value = maximumValue
                    lockScreen.shutdown()
                    requestSent = true
                }
            }

            onPressedChanged: {
                if (!pressed) {
                    value = maximumValue;
                }
            }

        }

            Text {
                id: shutdownText
                text: i18n("Shutdown")
                //anchors.top: parent.bottom
                anchors.bottom: shutdownSlider.top
                anchors.horizontalCenter: shutdownSlider.horizontalCenter
            }
    }

    Image {
        id: lockerImage
        width: 64
        height: 64
        source: "unlock-normal.png"
        state: "default"

        anchors {
            bottom: lockScreen.bottom
            topMargin: 10
            horizontalCenter: lockScreen.horizontalCenter
        }

        MouseArea {
            anchors.fill: parent
            drag.target: parent
            onPressed: {
                lockerImage.state = "drag"
            }

            onReleased: {
                var pos = (lockerImage.x > unlockArea.x && lockerImage.y > unlockArea.y);
                var size = (lockerImage.x < unlockArea.width && lockerImage.y < unlockArea.height);

                if (pos && size) {
                    lockScreen.unlockRequested()
                }

                lockerImage.state = "default"
            }
        }

        states: [
            State {
                name: "drag"
                PropertyChanges {
                    target: lockerImage
                    anchors.bottom: undefined
                    anchors.horizontalCenter: undefined
                    source: "unlock-pressed.png"
                }
                PropertyChanges {
                    target: unlockText
                    opacity: 0.6
                }
            },
            State {
                name: "default"
                PropertyChanges {
                    target: lockerImage
                    anchors.bottom: lockScreen.bottom
                    anchors.horizontalCenter: lockScreen.horizontalCenter
                    source: "unlock-normal.png"
                }
                PropertyChanges {
                    target: unlockText
                    opacity: 0
                }
            }
        ]
    }
}

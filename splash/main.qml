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
    source: "images/background.png"

    width: screenSize.width
    height: screenSize.height

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
        if (stage == 2) {
            stage1BottomLeftVine.opacity = 0
            stage2BottomLeftVine.opacity = 1

            stage2TopRightVine.x = -stage2TopRightVine.width
        } else if (stage == 3) {
            stage2BottomLeftVine.opacity = 0
            stage3BottomLeftVine.opacity = 1

            stage3SmallVine.x = 0

            stage2TopRightVine.opacity = 0
            stage3TopRightVine.opacity = 1
        } else if (stage == 4) {
            stage3BottomLeftVine.opacity = 0
            stage4BottomLeftVine.opacity = 1

            stage3TopRightVine.opacity = 0
            stage4TopRightVine.opacity = 1
        } else if (stage == 5) {
            stage4BottomLeftVine.opacity = 0
            stage5BottomLeftVine.opacity = 1
        } else if (stage == 6) {
            kLogo4.opacity = 1
            kLogo5.opacity = 1
            kLogo6.opacity = 1
        }
    }
    /* }}} */

    /* object properties ------------------------------{{{ */

    /* }}} */

    /* child objects ----------------------------------{{{ */

    Image {
        id: stage1BottomLeftVine
        x: 0
        y: (main.height - height) -60
        source: "images/bottomleft-vine-1.png"
        opacity: 0

        Behavior on opacity {
            NumberAnimation {
                duration: 2000
                easing {
                    type: Easing.InOutQuad 
                }
            }
        }
    }
    
    Image {
        id: stage2BottomLeftVine
        x: 0
        y: (main.height - height) -60
        source: "images/bottomleft-vine-2.png"
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
        id: stage3BottomLeftVine
        x: 0
        y: (main.height - height) -60
        source: "images/bottomleft-vine-3.png"
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
        id: stage4BottomLeftVine
        x: 0
        y: (main.height - height) -60
        source: "images/bottomleft-vine-4.png"
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
        id: stage5BottomLeftVine
        x: 0
        y: (main.height - height) -60
        source: "images/bottomleft-vine-5.png"
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
        id: stage3SmallVine
        x: -width
        y: (main.height - height) -167
        source: "images/bottomleft-smallvine-3.png"
        opacity: 1

        Behavior on x {
            NumberAnimation {
                duration: 800
                easing {
                    type: Easing.InOutQuad 
                }
            }
        }
    }


    Image {
        anchors.left: parent.right
        Image {
            id: stage2TopRightVine
            x: 0
            y: 26
            source: "images/topright-vine-2.png"
            opacity: 1

            Behavior on x {
                NumberAnimation {
                    duration: 800
                    easing {
                        type: Easing.InOutQuad 
                    }
                }
            }
            Behavior on opacity {
                NumberAnimation {
                    duration: 800
                    easing {
                        type: Easing.InOutQuad 
                    }
                }
            }
        }
    }

    Image {
        id: stage3TopRightVine
        x: parent.width-width
        y: 26
        source: "images/topright-vine-3.png"
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
        id: stage4TopRightVine
        x: parent.width-width
        y: 26
        source: "images/topright-vine-4.png"
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
        id: kLogo6
        anchors.horizontalCenter: parent.horizontalCenter
        y: 90
        source: "images/active-logo-3.png"
        opacity: 0

        Behavior on opacity {
            NumberAnimation {
                duration: 3000
                easing {
                    type: Easing.InOutQuad 
                }
            }
        }
    }

    Image {
        id: kLogo5
        anchors.horizontalCenter: parent.horizontalCenter
        y: 90
        source: "images/active-logo-2.png"
        opacity: 0

        Behavior on opacity {
            NumberAnimation {
                duration: 1500
                easing {
                    type: Easing.InOutQuad 
                }
            }
        }
    }

    Image {
        id: kLogo4
        anchors.horizontalCenter: parent.horizontalCenter
        y: 90
        source: "images/active-logo-1.png"
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
        id: spinner
        source: "images/spinner.png"
        anchors.horizontalCenter: parent.horizontalCenter
        smooth: true
        anchors.centerIn: parent

        RotationAnimation on rotation {
            from: 0
            to: 360
            duration: 2500
            running: spinner.opacity > 0
            loops: Animation.Infinite
        }
    }
    /* }}} */

    /* stages -----------------------------------------{{{ */

    /* }}} */

    /* transitions ------------------------------------{{{ */

    /* }}} */
}


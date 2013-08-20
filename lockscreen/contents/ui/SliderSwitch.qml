/*
*   Copyright (C) 2011 by Daker Fernandes Pinheiro <dakerfp@gmail.com>
*
*   This program is free software; you can redistribute it and/or modify
*   it under the terms of the GNU Library General Public License as
*   published by the Free Software Foundation; either version 2, or
*   (at your option) any later version.
*
*   This program is distributed in the hope that it will be useful,
*   but WITHOUT ANY WARRANTY; without even the implied warranty of
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*   GNU General Public License for more details
*
*   You should have received a copy of the GNU Library General Public
*   License along with this program; if not, write to the
*   Free Software Foundation, Inc.,
*   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*/

/**Documented API
Inherits:
        Item

Imports:
        QtQuick 1.0
        org.kde.plasma.core

Description:
        An interactive slider component with Plasma look and feel.

Properties:
        int stepSize: range.stepSize
        This property holds in how many steps the slider value can be selected within it's
    range value.

        real minimumValue:
    	This property holds the minimun value that the slider's value can assume.
	The default value is 0.

        real maximumValue:
	    This property holds the maximum value that the slider's value can assume.
	The default value is 1.

        real value:
        This property holds the value selected inside the minimun to maximum range of value.
	The default value is 0.

        enumeration orientation:
   	    This property holds the orientation for this component.
	The orientation can assume Qt.Horizontal and Qt.Vertical values.
	The default is Qt.Horizontal.

        bool pressed:
   	    This property holds if the Slider is being pressed or not.
	Read-only.

        bool valueIndicatorVisible:
        This property holds if a value indicator element will be shown while is dragged or not.
    ! The value indicator is not implemented in the Plasma Slider.
    The default value is false.

        string valueIndicatorText:
    This property holds the text being displayed in the value indicator.
    ! The value indicator is not implemented in the Plasma Slider.
    Read-only.

Plasma Properties:

        bool animated:
        This property holds if the slider will animate or not when other point is clicked,
    and the slider handler is not being dragged.
    The default value is false.

        alias inverted:
        This property holds if the slider visualizations has an inverted direction.
    The default value is false.

        bool updateValueWhileDragging:
        This property holds if the value is updated while dragging or if it applies only
    when the slider's handler is released.

        real handleSize:
        This property holds the size of the Slider's handle.
**/

import QtQuick 1.0
import org.kde.plasma.core 0.1 as PlasmaCore
import org.kde.plasma.components 0.1 as PlasmaComponents

// TODO: create a value indicator for plasma?
Item {
    id: slider

    // Common API
    property alias stepSize: range.stepSize
    property alias minimumValue: range.minimumValue
    property alias maximumValue: range.maximumValue
    property alias value: range.value
    property int orientation: Qt.Horizontal
    property alias pressed: mouseArea.pressed
    property bool valueIndicatorVisible: false
    property string valueIndicatorText: value
    property string handleName: "sleep"

    // Plasma API
    property alias inverted: range.inverted

    width: contents.sourceSize.width
    height: contents.sourceSize.height
    // TODO: needs to define if there will be specific graphics for
    //     disabled sliders
    opacity: enabled ? 1.0 : 0.5

    Keys.onUpPressed: {
        if (!enabled || !contents.isVertical)
            return;

        if (inverted)
            value -= stepSize;
        else
            value += stepSize;
    }

    Keys.onDownPressed: {
        if (!enabled || !enabled)
            return;

        if (!contents.isVertical)
            return;

        if (inverted)
            value += stepSize;
        else
            value -= stepSize;
    }

    Keys.onLeftPressed: {
        if (!enabled || contents.isVertical)
            return;

        if (inverted)
            value += stepSize;
        else
            value -= stepSize;
    }

    Keys.onRightPressed: {
        if (!enabled || contents.isVertical)
            return;

        if (inverted)
            value -= stepSize;
        else
            value += stepSize;
    }

    Image {
        id: contents

        // Plasma API
        property bool animated: true
        property bool updateValueWhileDragging: true
        property real handleSize: theme.defaultFont.mSize.height*1.3
        source: "slider-background.png"

        // Convenience API
        property bool isVertical: orientation == Qt.Vertical

        width: sourceSize.width
        height: sourceSize.height
        rotation: contents.isVertical ? -90 : 0

        anchors.centerIn: parent

        PlasmaComponents.RangeModel {
            id: range

            minimumValue: 0.0
            maximumValue: 1.0
            value: 0
            stepSize: 0.0
            inverted: false
            positionAtMinimum: 0
            positionAtMaximum: contents.width - handle.width
        }

        Image {
            id: handle
            source: mouseArea.pressed ? handleName+"-pressed.png" : handleName+"-normal.png"
            x: fakeHandle.x
            anchors {
                verticalCenter: parent.verticalCenter
            }
            Behavior on x {
                id: behavior
                enabled: !mouseArea.drag.active && slider.animated

                PropertyAnimation {
                    duration: behavior.enabled ? 150 : 0
                    easing.type: Easing.OutSine
                }
            }
        }

        Item {
            id: fakeHandle
            width: handle.width
            height: handle.height
        }

        MouseArea {
            id: mouseArea

            anchors.fill: parent
            enabled: slider.enabled
            drag {
                target: fakeHandle
                axis: Drag.XAxis
                minimumX: range.positionAtMinimum
                maximumX: range.positionAtMaximum
            }
            hoverEnabled: true

            onPressed: {
                // Clamp the value
                var newX = Math.max(mouse.x, drag.minimumX)
                newX = Math.min(newX, drag.maximumX)

                // Debounce the press: a press event inside the handler will not
                // change its position, the user needs to drag it.
                if (Math.abs(newX - fakeHandle.x) > handle.width / 2) {
                    range.position = newX
                }

                slider.forceActiveFocus()
            }
            onReleased: {
                // If we don't update while dragging, this is the only
                // moment that the range is updated.
                if (!slider.updateValueWhileDragging) {
                    range.position = fakeHandle.x
                }
            }
        }
    }

    // Range position normally follow fakeHandle, except when
    // 'updateValueWhileDragging' is false. In this case it will only follow
    // if the user is not pressing the handle.
    Binding {
        when: updateValueWhileDragging || !mouseArea.pressed
        target: range
        property: "position"
        value: fakeHandle.x
    }

    // During the drag, we simply ignore position set from the range, this
    // means that setting a value while dragging will not "interrupt" the
    // dragging activity.
    Binding {
        when: !mouseArea.drag.active
        target: fakeHandle
        property: "x"
        value: range.position
    }
}
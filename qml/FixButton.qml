
import QtQuick 2

import QtQuick 2
import QtGraphicalEffects 1.0


Item {
	id: button
    width: 50
    height: 50
	property real opac:0.25
	signal clicked;


	property string text;
	
	property real xpos;
	property real ypos;
	
	x: xpos * page.xsc
	y: ypos * page.ysc
	
	
    Item {
        id: background
        anchors.fill: parent
    }

    RectangularGlow {
        id: effect
        anchors.fill: rect
        glowRadius: 10
        spread: 0.2
        color: "white"
        cornerRadius: rect.radius + glowRadius
		opacity: button.opac
    }

    Rectangle {
        id: rect
        color: innermarea.held? "#aa0011" : "#000011"
        anchors.centerIn: parent
        width: Math.round(parent.width / 1.5)
        height: Math.round(parent.height / 2)
        radius: parent.width/10
		opacity: button.opac
    }
	MouseArea{
		id: innermarea
		property bool held: false
		anchors.fill:parent;
		hoverEnabled:true
		drag.target: held ? button : undefined
		drag.minimumX: 0
		drag.maximumX: button.parent.width - button.width
		drag.minimumY: 0
		drag.maximumY: button.parent.height - button.height
		
		onPressAndHold: held = true
        onReleased: {
			held = false;
			button.xpos = button.x / button.parent.xsc
			button.ypos = button.y / button.parent.ysc
		}
		
		onClicked:{
			button.clicked()
		}
	}
			
	Behavior on x { PropertyAnimation {duration :100} }
	Behavior on y { PropertyAnimation {duration :100} }

	
	Text{
		text:button.text;
		font.family: "IRLotus";
		font.pointSize: 10;
		color: "yellow";
		anchors.centerIn: parent
	}
	
	transform: Scale{
			xScale: button.parent.xsc
			yScale: button.parent.ysc
		}
}


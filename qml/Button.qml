
import QtQuick 2
import QtGraphicalEffects 1.0


Item {
	id: button
    width: 50
    height: 50
	property real opac:0.25
	signal clicked;

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
        color: "#000011"
        anchors.centerIn: parent
        width: Math.round(parent.width / 1.5)
        height: Math.round(parent.height / 2)
        radius: parent.width/10
		opacity: button.opac
    }
	MouseArea{
		anchors.fill:parent;
		onClicked:{
			button.clicked()
		}
	}
	


}

	

import QtQuick 2
import QtGraphicalEffects 1.0

Rectangle{
		id: widgetframe
		
		color:"transparent"
		border.width:1
		border.color:"blue"
		
		property real basex:0;
		property real basey:0;
		property real basewidth:200;
		property real baseheight:200;
		
		property real normalwidth:400;
		property real normalheight:400;
		property real normalx:-1;
		property real normaly:-1;
		
		property real transitionTime:250
		
		x:(zoomed)?((parent.width-normalwidth)/2):basex
		y:(zoomed)?((parent.height-normalheight)/2):basey
		width:(zoomed)?normalwidth:basewidth
		height:(zoomed)?normalheight:baseheight
		
		property bool zoomed:false
	
		opacity: (innermarea.containsMouse | zoomed)?0.9:0.2
		
		MouseArea {
				id: innermarea
				anchors.fill: parent
				hoverEnabled:true
				drag.target: widgetframe
				drag.axis: Drag.XAxis
				drag.minimumX: 0
				drag.maximumX: holoview.width - widgetframe.width
				onClicked:{
					widgetframe.zoomed = !widgetframe.zoomed;
				}
		}
		
		Behavior on x { PropertyAnimation {duration :widgetframe.transitionTime} }
		Behavior on y { PropertyAnimation {duration :widgetframe.transitionTime} }
		Behavior on width { PropertyAnimation {duration :widgetframe.transitionTime} }
		Behavior on height { PropertyAnimation {duration :widgetframe.transitionTime} }
		Behavior on opacity { PropertyAnimation {duration :widgetframe.transitionTime} }
		
		transform:[ Rotation{ 
				origin.x: widgetframe.width/2; 
				origin.y:widgetframe.height/2; 
				axis{x:0;y:1;z:0} 
				angle: (widgetframe.zoomed)?0:45-(90*(widgetframe.x+widgetframe.width/2)/holoview.width) 
			},
			Scale{
				origin.x: widgetframe.width/2; 
				origin.y: widgetframe.height/2;
				property real temp : (widgetframe.zoomed)?1: 1 - 0.5*(0.5 - Math.abs(widgetframe.x+widgetframe.width/2-holoview.width/2)/holoview.width);
				xScale: temp
				yScale: temp
		}]
	}

import QtQuick 2

Image{
	id:button;
	x:100;
	y:100;
	fillMode: Image.PreserveAspectCrop;
	smooth: true
	signal clicked;
	
	property string icon: "settings";
	source : "icons/" + button.icon +".png"

	MouseArea{
		anchors.fill:parent;
		onClicked:{
			button.clicked()
		}
	}		
}
	

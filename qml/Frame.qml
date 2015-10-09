
import QtQuick 2
import QtQuick.Window 2.2
import QtQuick.Particles 2.0

Item {
	id:frameitem
	property Item img: frameimage
	
	property real xsc : width/Screen.width
	property real ysc : height/Screen.height	
	
	Image{
			id:frameimage
			source : "frame/004.png";
			asynchronous: true;
			fillMode: Image.Stretch ;
			anchors.fill: parent;
			smooth: true			
		}
	
	
	TXTButton{
		text:"رؤيت عالم"
		anchors.right: frame.right
		anchors.top: frame.top
		onClicked: Qt.openUrlExternally("D:/Royat/3.12/Royat/Royat.exe")
	}

		
	TXTButton{
		id:quitbtn
		text:"خروج"
		anchors.right: frame.right
		anchors.bottom: frame.bottom
		onClicked: Qt.quit()
	}
	
	FixButton{
		text:"C"
		xpos: 100
		ypos: 100
		onClicked: Qt.openUrlExternally("c:")
	}

}


import QtQuick 2
import QtQuick.Particles 2.0

Item {
	id:frameitem
	property Item img: frameimage
	Image{
			id:frameimage
			source : "frame/001.png";
			asynchronous: true;
			fillMode: Image.Stretch ;
			anchors.fill: parent;
			smooth: true			
		}
	
	property int current : 0;
	
	TXTButton{
		text:"رؤيت عالم"
		anchors.right: frame.right
		anchors.top: frame.top
		onClicked: Qt.openUrlExternally("D:/Royat/3.12/Royat/Royat.exe")
	}

	
	TXTButton{
		text:"C"
		anchors.left: frame.left
		anchors.bottom: frame.bottom
		onClicked: Qt.openUrlExternally("c:")
	}
		
	TXTButton{
		id:quitbtn
		text:"خروج"
		anchors.right: frame.right
		anchors.bottom: frame.bottom
		onClicked: Qt.quit()
	}
}

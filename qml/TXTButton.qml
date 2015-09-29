
import QtQuick 2

Button{
	id:button;
	property string text;
	Text{
		text:button.text;
		font.family: "IRLotus";
		font.pointSize: 10;
		color: "yellow";
		anchors.centerIn: parent
	}
}


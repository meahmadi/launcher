
import QtQuick 2

Item{
	id:list;
	width: 200; height: 200

    ListModel {
        id: fruitModel
        ListElement {
			title: "New1 Title"
			description: "llkas falskjf laksjf alksjf kal;sjf kl;asjfd kl;sdjf kl;sajf kl;asjf kla;sjf kl;asjf kl;asjf kl;asjf kl;asjf kl;sjf lkasjf kajf kals;jf lkjf kjd"
			attributes: [
				ListElement { description: "Core" },
				ListElement { description: "Deciduous" }
			]
		}
		ListElement {
			title: "New1 Title"
			description: "llkas falskjf laksjf alksjf kal;sjf kl;asjfd kl;sdjf kl;sajf kl;asjf kla;sjf kl;asjf kl;asjf kl;asjf kl;asjf kl;sjf lkasjf kajf kals;jf lkjf kjd"
			attributes: [
				ListElement { description: "Citrus" }
			]
		}
		ListElement {
			title: "New1 Title"
			description: "llkas falskjf laksjf alksjf kal;sjf kl;asjfd kl;sdjf kl;sajf kl;asjf kla;sjf kl;asjf kl;asjf kl;asjf kl;asjf kl;sjf lkasjf kajf kals;jf lkjf kjd"
			attributes: [
				ListElement { description: "Tropical" },
				ListElement { description: "Seedless" }
			]
		}
    }

    Component {
        id: fruitDelegate
        Row {
            spacing: 10
            Text { text: title ; color: "green"}
            Text { text: description; color: "white" ; wrapMode: Text.WordWrap;}
        }
    }

    ListView {
        anchors.fill: parent
        model: fruitModel
        delegate: fruitDelegate
    }

}


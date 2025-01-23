import QtQuick 2.15
import QtQuick.Window 2.13
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Extras.Private 1.0

ApplicationWindow {
    visible: true
    width: 1000
	maximumWidth : width
	minimumWidth : width
    height: 600
	maximumHeight : height
	minimumHeight : height
    title: "GUI tekanan Angin"
	color: "orange"
	Rectangle{
		x:410
		y:0
		width : 600
		height : 130
		color : "grey"
	}
	Image{
		x:0
		y:0
		width : 400
		height : 100
		source : "logoUpiPWK.png"
	}
	Text{
		x:470
		y:25
		text : "Pengatur Tekanan Angin"
		color : "white"
		font.pixelSize : 40
		font.bold : true
		font.family : "Berlin Sans FB Demi"
	}
	Rectangle {
		x: 0
		y: 100
		width:500
		height:500
		color: "#122e55"
		Column {
		Text{
			anchors.horizontalCenter: parent.horizontalCenter
			x:0
			y:0
			text:"Pressure (PSI)"
			font.pixelSize:30
			color: "white"
			font.family : "Berlin Sans FB Demi"
		}
			spacing: 20
			anchors.centerIn: parent
			// Circular Gauge untuk menampilkan tekanan
			CircularGauge {
				id: pressureGauge
				minimumValue: 0
				maximumValue: 100
				value: pressureControl.getPressure()
				width: 300
				height: 300
				style: CircularGaugeStyle {
					labelStepSize: 10
					needle: Rectangle {
						y: outerRadius * 0.15
						implicitWidth: outerRadius * 0.03
						implicitHeight: outerRadius * 0.9
						antialiasing: true
						color: "grey"
					}
				}
				// Perbarui nilai gauge saat tekanan berubah
				Connections {
					target: pressureControl
					function onPressureChanged(pressure) {
					pressureGauge.value = pressure
					}
				}
			}
			// Slider untuk mengatur tekanan target
			Slider {
				id: pressureSlider
				anchors.horizontalCenter: parent.horizontalCenter
				from: 0
				to: 100
				stepSize: 1
				value: 0
				width: 200
			}
			// Tombol untuk mengatur tekanan
			Button {
				anchors.horizontalCenter: parent.horizontalCenter
				text: "Atur Tekanan"
				onClicked: pressureControl.setTargetPressure(pressureSlider.value)
				width: 200
				font.family : "Berlin Sans FB Demi"
				font.pixelSize: 20
			}
		}
	}
	Rectangle {
		x: 500
		y: 100
		width:500
		height:500
		color: "#122e55"
		Text{
			x:0
			y:10
			text:"Target dan Hasil"
			font.pixelSize:30
			color: "white"
			font.family : "Berlin Sans FB Demi"
			anchors.horizontalCenter: parent.horizontalCenter
		}
		Column {
			spacing: 30
			anchors.centerIn: parent
			Image{
				x:20
				y:10
				width : 150
				height : 100
				anchors.horizontalCenter: parent.horizontalCenter
				source : "kompresor.png"
			}
			 // Tombol untuk mematikan (reset tekanan)
			Button {
				id: button1
				text: "MATIKAN"
				font.family : "Berlin Sans FB Demi"
				Rectangle{
					id:button1_color
					width : parent.width
					height: parent.height
					color:"red"
				}
				onClicked:pressureControl.resetPressure()
				anchors.horizontalCenter: parent.horizontalCenter
				width: 200
				font.pixelSize : 20
			}
			// Label untuk menampilkan tekanan target
			Label {
				anchors.horizontalCenter: parent.horizontalCenter
				text: "Tekanan Target: " + pressureSlider.value.toFixed(1) + " PSI"
				font.pixelSize: 20
				color : "white"
				font.family : "Berlin Sans FB Demi"
			}
			// Label untuk menampilkan tekanan saat ini
				Label {
					anchors.horizontalCenter: parent.horizontalCenter
					text: "Tekanan Saat Ini: " + pressureGauge.value.toFixed(1) + " PSI"
					font.pixelSize: 20
					color : "white"
					font.family : "Berlin Sans FB Demi"
				}
		}
	}
}














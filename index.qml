Item {
	anchors.fill: context;
	clip: true;

	Rectangle {
		id: ball;
		width: 100; height: 100;
		radius: 50;
		x: beta > 0 ? 0 : (beta < 0 ? 100% - width : (100% - width) / 2 );
		y: gamma > 0 ? 0 : (gamma < 0 ? 100% - height : (100% - height) / 2 );
		color: "#E91E63";
		property int betaDur: 2000 - Math.abs(beta * 10);
		property int gammaDur:  2000 - Math.abs(gamma * 10);
		property real beta: context.system.beta;
		property real gamma: context.system.gamma;

		Behavior on x { Animation { duration: ball.betaDur; easing: "cubic-bezier(0.55, 0.055, 0.675, 0.19)"; }}
		Behavior on y { Animation { duration: ball.gammaDur; easing: "cubic-bezier(0.55, 0.055, 0.675, 0.19)"; }}
	}

	Image {
		visible: !ball.visible;
		height: 100%; width: 100%;
		fillMode: Image.PreserveAspectFit;
		transform.rotateZ: context.system.beta;
		source: "res/compass.svg";

		Behavior on transform { Animation { duration: 2000; }}
	}
	
	Text {
		width: 100%; height: 30;
		horizontalAlignment: Text.AlignHCenter;
		text: ball.visible ? "Compass" : "Ball";
		color: "#444444";
		HoverMixin { cursor: "pointer"; }

		onClicked: {
			ball.visible = !ball.visible
		}
	}

	Text { 
		anchors.horizontalCenter: parent.horizontalCenter;
		anchors.bottom: parent.bottom;
		color: "#626262";
		text: "X: " + context.system.beta + "; Y: " + context.system.gamma + "; Z: " + context.system.alpha; 
	}
}

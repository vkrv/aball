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
		property real beta: context.orientation.beta;
		property real gamma: context.orientation.gamma;

		Behavior on x { Animation { duration: ball.betaDur; easing: "cubic-bezier(0.55, 0.055, 0.675, 0.19)"; }}
		Behavior on y { Animation { duration: ball.gammaDur; easing: "cubic-bezier(0.55, 0.055, 0.675, 0.19)"; }}
	}

	Image {
		visible: !ball.visible;
		height: 90%; width: 90%;
		x: 5%; y: 5%;
		fillMode: Image.PreserveAspectFit;
		transform.rotateZ: context.orientation.alpha;
		source: "res/compass.svg";

		Behavior on transform { Animation { duration: 2500; easing: "cubic-bezier(0.805, 1.505, 0.780, 0.930)"; }}
	}

	Row {
		height: 40;
		spacing: 12;
		y: 10;
		anchors.right: parent.right;
		anchors.rightMargin: 10;

		Rectangle {
			width: 40; height: 40;
			radius: 20;
			color: "#E91E63";
			opacity: ball.visible ? 0.4 : 1;
			HoverMixin { cursor: ball.visible ? "default" : "pointer"; }
			onClicked: { ball.visible = true; }
		}

		Image {
			width: 40; height: 40;
			source: "res/compass_icon.svg";
			opacity: !ball.visible ? 0.4 : 1;

			HoverMixin { cursor: !ball.visible ? "default" : "pointer"; }
			onClicked: { ball.visible = false; }
		}

		MaterialIcon {
			width: 40; height: 40;
			icon: context.fullscreen ? "fullscreen_exit" : "fullscreen";
			color: "#9C27B0";
			size: 40;

			HoverMixin { cursor: "pointer"; }
			onClicked: { context.fullscreen = !context.fullscreen }
		}
	}
	

	Text { 
		anchors.bottom: parent.bottom;
		color: "#626262";
		text: "X: " + Math.round(context.orientation.beta * 100)/100 + "; Y: " + Math.round(context.orientation.gamma * 100)/100 + "; Z: " + Math.round(context.orientation.alpha * 100)/100; 
	}
}

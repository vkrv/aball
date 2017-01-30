Item {
	anchors.fill: context;
	clip: true;

	Rectangle {
		id: ball;
		width: 100; height: 100;
		radius: 50;
		x: gamma < -1 ? 0 : (gamma > 1 ? 100% - width : (100% - width) / 2 );
		y: beta < -1 ? 0 : (beta > 1 ? 100% - height : (100% - height) / 2 );
		color: "#E91E63";
		property int betaDur: drag.pressed ? 0 : 2000 - Math.abs(beta * 10);
		property int gammaDur: drag.pressed ? 0 : 2000 - Math.abs(gamma * 10);
		property bool calibrated;
		property real calBeta, calGamma;
		property real beta: context.orientation.beta + calBeta;
		property real gamma: context.orientation.gamma + calGamma;
		property DragMixin drag: DragMixin {}

		calibrate: {
			this.calBeta = context.orientation.beta;
			this.calGamma = context.orientation.calGamma;
			this.calibrated = true;
		}

		Behavior on x { Animation { duration: ball.betaDur; easing: "cubic-bezier(0.55, 0.055, 0.675, 0.19)"; }}
		Behavior on y { Animation { duration: ball.gammaDur; easing: "cubic-bezier(0.55, 0.055, 0.675, 0.19)"; }}
	}

	Image {
		visible: !ball.visible;
		height: Math.min(parent.width, parent.height) * 0.9; width: height;
		x: (parent.width - width) / 2; y: (parent.height - height) / 2;
		radius: height / 2;

		transform.rotateY: context.orientation.beta / 3;
		transform.rotateX: context.orientation.gamma / 3;
		effects.shadow.y: transform.rotateY;
		effects.shadow.x: transform.rotateX;
		effects.shadow.color: "#000A"; 
		effects.shadow.blur: 45; 
		effects.shadow.spread: 1;

		Image {
			height: 100%; width: 100%;
			radius: height / 2;
			fillMode: Image.PreserveAspectFit;
			source: "res/compass.svg";
			transform.rotateZ: context.orientation.alpha;

			Behavior on transform { Animation { duration: 2000; easing: "cubic-bezier(0.805, 1.505, 0.780, 0.930)"; }}
		}

		Behavior on transform { Animation { duration: 2000; easing: "cubic-bezier(0.805, 1.505, 0.780, 0.930)"; }}
	}

	Row {
		height: 40;
		spacing: 12;
		y: 10;
		anchors.right: parent.right;
		anchors.rightMargin: 10;

		Text {
			height: 40;
			verticalAlignment: Text.AlignVCenter;
			color: "#626262";
			text: "calibrate";
			font.underline: true;
			visible: ball.visible;
			HoverMixin { cursor: "pointer"; }
			onClicked: { ball.calibrate() }
		}

		Rectangle {
			width: 40; height: 40;
			radius: 20;
			color: "#E91E63";
			opacity: ball.visible ? 0.3 : 1;
			HoverMixin { cursor: ball.visible ? "default" : "pointer"; }
			onClicked: { ball.visible = true; }
		}

		Image {
			width: 40; height: 40;
			source: "res/compass_icon.svg";
			opacity: !ball.visible ? 0.3 : 1;

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
		font.pixelSize: 14;
		text: "<b>x:</b> " + Math.round(context.orientation.beta * 100)/100 + "; <b>y:</b> " + Math.round(context.orientation.gamma * 100)/100 + "; <b>z:</b> " + Math.round(context.orientation.alpha * 100)/100 + (ball.calibrated ? "(calibrated x: " + ball.calBeta + " y: " + ball.calGamma : ""); 
	}
}

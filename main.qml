import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.1
import QtQuick.VirtualKeyboard 2.1

Window {
    id: main
    width: 340
    height: 600
    visible: true
    minimumWidth: 340
    maximumWidth: 340
    minimumHeight: 600
    maximumHeight: 600
    color: "#252525"
    title: qsTr("UniqCast")

    Text {
        id: logo
        x: 121
        y: 59
        width: 99
        height: 28
        text: qsTr("<b>uniq</b>Cast")
        horizontalAlignment: Text.AlignHCenter
        font.family: "Arial"
        color: "white"
        font.pixelSize: 20
    }

    Image {
        id: user_icon
        x: 139
        y: 130
        width: 64
        height: 64
        clip: false
        sourceSize.height: 64
        sourceSize.width: 64
        fillMode: Image.PreserveAspectFit
        source: "user.png"
    }

    TextField {
            id: userName
            x: 61
            y: 280
            width: 220
            height: 20
            font.pixelSize: 14
            smooth: true
            clip: false
            visible: true
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 300
            placeholderText: qsTr("User Name")
            style: TextFieldStyle{
                placeholderTextColor: "white"
                textColor: "white"
                background: Rectangle{
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: -16
                    color: "#252525"
                    gradient: Gradient{
                        GradientStop { position: 0.95; color: "#252525" }
                        GradientStop { position: 1.0; color: "white" }
                    }
                }
            }
    }

    TextField {
            id: userPin
            x: 61
            y: 340
            width: 220
            height: 20
            font.pixelSize: 14
            smooth: true
            clip: false
            visible: true
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 240
            echoMode: TextInput.Password
            placeholderText: qsTr("Insert PIN")
            style: TextFieldStyle{
                placeholderTextColor: "white"
                textColor: "white"
                background: Rectangle{
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: -16
                    color: "#252525"
                    gradient: Gradient{
                        GradientStop { position: 0.95; color: "#252525" }
                        GradientStop { position: 1.0; color: "white" }
                    }
                }
            }
        }

    Button {
            id: btnLogin
            x: 61
            y: 400
            width: 220
            height: 60
            text: "Log In"
            style: ButtonStyle{
                background: Rectangle{
                    color: "#252525"
                    border.width: 1
                    border.color: "white"
                    radius: 3
                   }
                label: Text{
                    text: control.text
                    color: "white"
                    font.pixelSize: 13
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }

        MouseArea {
            id: maLogin
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            anchors.fill: btnLogin
            onClicked:{
                getData(userName.text, userPin.text)
            }
        }

        MessageDialog{
            id: msg
            title: "Login"
            height: 308
            width: 308
            text: ""
        }

        Item {
            id: keyboard
            x: 0
            y: 476
            width: 340
            height: 124

            InputPanel{
                width: 340
                active: true
            }
        }

        Image {
            id: logedin
            x: 0
            y: 0
            width: parent.width
            height: parent.height
            visible: false
            source: "logedin.png"
        }

        function getData(x1, x2) {
            var xhr = new XMLHttpRequest();
                var url = "http://176.31.182.158:3001/auth/local";
                xhr.open("POST", url, true);
                xhr.setRequestHeader("Content-type", "application/json");
                var param = JSON.stringify({"identifier": x1,"password": x2});
                xhr.send(param);
                xhr.onreadystatechange = function () {
                     if(xhr.readyState == 4 && xhr.status == 200) {

                        logedin.visible = true
                         showFullScreen(logedin)



                    }
                     else {
                        if(xhr.readyState == 4){
                            msg.text = "\n Username/password not correct     \n";
                            msg.open()
                            }
                     }
                }
            }
}

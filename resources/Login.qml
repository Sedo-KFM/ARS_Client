import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {
    width: platform.width
    height: platform.height

    Connections {
        target: api

        function onAuthLoginResponse(success, value) {
            if (success) {
                loginButton.text = 'Success'
                light.color = Global.successColor
                let token = value
                let tokenLen = token.length;
                for (let i = 7; i > 0; i--) {
                    let index = (tokenLen / 8) * i;
                    token = token.slice(0, index) + '\n' + token.slice(index)
                }
                popUp.show(token)
            } else {
                loginButton.text = 'Failure'
                light.color = Global.warningColor
            }
        }
    }

    WPlatform {
        id: platform
        implicitHeight: column.height + 80
        implicitWidth: column.width + 100

        ColumnLayout {
            id: column

            anchors.centerIn: parent
            width: 200

            WText {
                Layout.alignment: Qt.AlignCenter
                Layout.bottomMargin: 15

                text: 'Allrensys'
                color: Global.strongTextColor
                sizeScale: 2
            }

            Column {
                Layout.alignment: Qt.AlignCenter
                Layout.bottomMargin: 5

                WText {
                    text: 'Username'
                    font.bold: false
                    sizeScale: 0.8
                }

                WTextField {
                    id: username
                    width: column.width
                }
            }

            Column {
                Layout.alignment: Qt.AlignCenter
                Layout.bottomMargin: 15

                WText {
                    text: 'Password'
                    font.bold: false
                    sizeScale: 0.8
                }

                WTextField {
                    id: password
                    width: column.width
                    // passwordCharacter: '*'
                    echoMode: TextInput.Password
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignCenter

                WButton {
                    id: loginButton
                    Layout.alignment: Qt.AlignCenter
                    text: 'Login'
                    color: Global.successColor

                    onClicked: {
                        api.authLogin(username.text, password.text)
                    }
                }

                Rectangle {
                    id: light
                    Layout.alignment: Qt.AlignCenter
                    width: 15
                    height: width
                    radius: width
                    color: Global.infoColor
                }
            }
        }
    }

    WPopUp {
        id: popUp
        anchors.centerIn: parent
        autohide: false
        text.font.pixelSize: 15
    }
}

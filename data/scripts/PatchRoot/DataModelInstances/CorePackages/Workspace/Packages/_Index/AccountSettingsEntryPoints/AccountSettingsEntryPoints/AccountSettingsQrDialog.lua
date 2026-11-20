-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:11:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local React = require(scriptParentParent.React)
local Foundation = require(scriptParentParent.Foundation)
local QRCodeDisplay = require(scriptParentParent.QRCodeDisplay)

local AccountSettingsPage = require(scriptParent.AccountSettingsPage)
local translate = require(scriptParent.translate)

local Dialog = Foundation.Dialog
local View = Foundation.View

local function AccountSettingsQrDialog(tbl1)
    local toEncode = AccountSettingsPage.getUrl(tbl1.page)

    return React.createElement(
        Dialog.Root,
        {
            onClose = tbl1.onClose,
            hasBackdrop = true,
            disablePortal = false,
            testId = "--account-settings-qr-dialog"
        },
        {
            DialogTitle = React.createElement(Dialog.Title, { text = AccountSettingsPage.getTitle(tbl1.page) }),
            DialogContent = React.createElement(Dialog.Content, { LayoutOrder = 1 }, {
                ContentView = React.createElement(View, {
                    tag = "col size-full-0 auto-y gap-medium"
                }, {
                    DialogText = React.createElement(
                        Dialog.Text,
                        {
                            Text = translate("Feature.Settings.Description.AccountSettingsWebsite"),
                            LayoutOrder = 1
                        }
                    ),
                    QRCodeContainer = React.createElement(
                        View,
                        {
                            tag = "row size-full-0 auto-y align-x-center padding-y-large",
                            LayoutOrder = 2
                        },
                        {
                            QRCode = React.createElement(
                                QRCodeDisplay.DisplayQRCode,
                                {
                                    ecLevel = QRCodeDisplay.ECLevels.EC_LEVEL_1,
                                    sideLength = 240,
                                    toEncode = toEncode
                                }
                            )
                        }
                    )
                })
            })
        }
    )
end

return AccountSettingsQrDialog

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IdentityVerificationParent = script:FindFirstAncestor("IdentityVerification").Parent

local React = require(IdentityVerificationParent.React)

local Foundation = require(IdentityVerificationParent.Foundation)
local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize
local View = Foundation.View
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens

local QRCodeDisplay = require(IdentityVerificationParent.QRCodeDisplay)
local ECLevels = QRCodeDisplay.ECLevels

local function QRDeepLinkDialog(tbl1)
    local deeplink = tbl1.deeplink
    local title = tbl1.title
    local description = tbl1.description
    local footer = tbl1.footer
    local onClose = tbl1.onClose

    local var1 = useTokens()

    local uDim = UDim.new(0, var1.Size.Size_400 + var1.Size.Size_1000)
    local uDim2 = UDim.new(0, var1.Size.Size_500)

    return React.createElement(Dialog.Root, {
        size = DialogSize.Medium,
        hasBackdrop = true,
        onClose = onClose
    }, {
        DialogContent = React.createElement(Dialog.Content, nil, {
            DialogView = React.createElement(View, { tag = "col items-stretch size-full-0 auto-y" }, {
                TitleWrapper = React.createElement(
                    View,
                    {
                        LayoutOrder = 1,
                        tag = "size-full-0 auto-y padding-bottom-small",
                        padding = { right = uDim, top = uDim2 }
                    },
                    {
                        TitleText = React.createElement(
                            FoundationText,
                            {
                                Text = title,
                                tag = "size-full-0 auto-y text-heading-small text-wrap text-align-x-left content-emphasis"
                            }
                        )
                    }
                ),
                BodyText = React.createElement(Dialog.Text, { Text = description, LayoutOrder = 2 }),
                QRCardWrapper = React.createElement(
                    View,
                    {
                        tag = "col align-x-center items-center size-full-0 auto-y margin-y-large",
                        LayoutOrder = 3
                    },
                    {
                        QRCard = React.createElement(View, {
                            tag = "col auto-xy padding-medium",
                            cornerRadius = UDim.new(0, 14),
                            backgroundStyle = {
                                Color3 = Color3.fromRGB(255, 255, 255),
                                Transparency = 0
                            }
                        }, {
                            QRCode = React.createElement(QRCodeDisplay.DisplayQRCode, {
                                ecLevel = ECLevels.EC_LEVEL_4,
                                sideLength = 176,
                                toEncode = deeplink,
                                backgroundColor = Color3.fromRGB(255, 255, 255),
                                pixelColor = Color3.fromRGB(0, 0, 0)
                            })
                        })
                    }
                ),
                FooterText = React.createElement(FoundationText, {
                    Text = footer,
                    LayoutOrder = 4,
                    RichText = true,
                    tag = "size-full-0 auto-y padding-bottom-small text-body-medium text-wrap text-align-x-left"
                })
            })
        })
    })
end

return QRDeepLinkDialog

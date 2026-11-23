-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _types = require(AppChat.types)
local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local memo = React.memo

local UIBlox = require(AppChatParent.UIBlox)
local useStyle = UIBlox.Core.Style.useStyle
local enum = UIBlox.App.Button.Enum
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local PartialPageModal = UIBlox.App.Dialog.Modal.PartialPageModal
local useIsInExperience = require(AppChat.Hooks.useIsInExperience)

local SocialLibraries = require(AppChat.SocialLibraries)
local Info = SocialLibraries.Components.AlertViews.Info
local Warning = SocialLibraries.Components.AlertViews.Warning

local tbl1 = {
    titleText = "",
    cancelAlertText = "",
    bodyText = "",
    isButtonDisabled = false,
    screenSize = Vector2.new(1000, 1000),
    onActivated = function() end,
    onDismissed = function() end
}

return memo(function(tbl2) -- name: PartialModal
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)
    local var2 = useStyle()
    local var3 = var1.style or var2

    local size600 = var3.Tokens.Size.Size_600
    local lineHeight140 = var3.Tokens.LineHeight.LineHeight_140

    if useIsInExperience() then
        local var4 = if var1.actionText then Warning else Info
        local cancelAlertText = if var1.actionText then var1.cancelAlertText else nil
        local confirmText = if var1.actionText then var1.actionText else var1.cancelAlertText
        return React.createElement(var4, {
            titleText = var1.titleText,
            bodyText = var1.bodyText,
            cancelText = cancelAlertText,
            confirmText = confirmText,
            screenSize = var1.screenSize,
            soakAreaColor3 = Color3.fromRGB(25, 25, 25),
            soakAreaTransparency = 0.8,
            width = UDim.new(0.8, 0),
            displayFailed = false,
            onActivated = var1.onActivated,
            onModalClose = var1.onDismissed
        })
    end
    local createElement = React.createElement
    local var4 = PartialPageModal
    local tbl3 = {
        title = var1.titleText,
        buttonStackProps = var1.actionText
            and {
                buttons = {{
                    buttonType = enum.ButtonType.PrimarySystem,
                    props = {
                        onActivated = var1.onActivated,
                        text = var1.actionText,
                        isDisabled = var1.isButtonDisabled
                    }
                }}
            }
            or nil,
        screenSize = var1.screenSize,
        onCloseClicked = var1.onDismissed
    }
    local tbl4 = { Body = 0 }
    local createElement2 = React.createElement
    local str1 = "Frame"
    local tbl5 = {
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y
    }
    local tbl6 = {
        ContentPadding = React.createElement(
            "UIPadding",
            {
                PaddingTop = UDim.new(0, size600 / 2),
                PaddingBottom = if var1.actionText then UDim.new(0, size600) else nil
            }
        ),
        Body = React.createElement(StyledTextLabel, {
            text = var1.bodyText,
            textXAlignment = Enum.TextXAlignment.Left,
            fontStyle = var3.Font.Body,
            lineHeight = lineHeight140,
            colorStyle = var3.Theme.TextDefault,
            size = UDim2.fromScale(1, 0),
            automaticSize = Enum.AutomaticSize.Y,
            fluidSizing = false
        })
    }
    tbl4.Body = createElement2(str1, tbl5, tbl6)
    return createElement(var4, tbl3, tbl4)
end)

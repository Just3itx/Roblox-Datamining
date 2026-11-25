-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PhoneUpsell = script:FindFirstAncestor("PhoneUpsell")
local PhoneUpsellParent = PhoneUpsell.Parent

local React = require(PhoneUpsellParent.React)

local UIBlox = require(PhoneUpsellParent.UIBlox)
local normalizeFontFace = require(PhoneUpsellParent.Foundation).Utility.normalizeFontFace

local useStyle = UIBlox.Core.Style.useStyle
local useLocalization = require(PhoneUpsellParent.Localization).Hooks.useLocalization
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local PartialPageModal = UIBlox.App.Dialog.Modal.PartialPageModal
local getPartialPageModalMiddleContentWidth = UIBlox.App.Dialog.Modal.getPartialPageModalMiddleContentWidth
local mergeProps = require(PhoneUpsell.Utils.mergeProps)

local function noOp() end

local tbl1 = {
    onClose = noOp,
    isButtonDisabled = false,
    onExtraButtonClick = noOp,
    isExtraButtonDisabled = false
}

local function getButtonStackProps(text: string, onActivated: (...any) -> (...any), isDisabled: boolean, text2: string, onActivated2: (...any) -> (...any), isDisabled2: boolean)
    local buttons = {{
        buttonType = ButtonType.PrimarySystem,
        props = { onActivated = onActivated, text = text, isDisabled = isDisabled }
    }}

    if text2 and text2 ~= "" then
        table.insert(
            buttons,
            1,
            {
                buttonType = ButtonType.Secondary,
                props = { onActivated = onActivated2, text = text2, isDisabled = isDisabled2 }
            }
        )
    end
    return {
        buttonHeight = 48,
        forcedFillDirection = Enum.FillDirection.Vertical,
        buttons = buttons
    }
end

local function EntryView(tbl2)
    local var1 = mergeProps(tbl1, tbl2)

    local partialPageModalMiddleContentWidth = getPartialPageModalMiddleContentWidth(var1.screenSize.X)

    local tbl3 = {
        titleKey = var1.titleKey,
        descriptionKey = var1.descriptionKey,
        buttonKey = var1.buttonKey
    }
    if var1.extraButtonKey and var1.extraButtonKey ~= "" then
        tbl3.extraButtonKey = var1.extraButtonKey
    end

    local var2 = useStyle()
    useLocalization(tbl3)

    local tbl4 = {
        titleKey = "Before you leave",
        descriptionKey = "This experience would be even more exciting with Voice Chat turned on. Unlock now before your next session.",
        buttonKey = "Unlock voice chat",
        extraButtonKey = "Leave experience"
    }

    local baseSize = var2.Font.BaseSize

    return React.createElement(PartialPageModal, {
        title = tbl4.titleKey,
        screenSize = var1.screenSize,
        buttonStackProps = getButtonStackProps(
            tbl4.buttonKey,
            var1.onButtonClick,
            var1.isButtonDisabled,
            tbl4.extraButtonKey,
            var1.onExtraButtonClick,
            var1.isExtraButtonDisabled
        ),
        onCloseClicked = var1.onClose
    }, {
        Middle = React.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y,
                Size = UDim2.new(1, 0, 0, 0)
            },
            {
                ContentPadding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, 12), PaddingBottom = UDim.new(0, 24) }),
                ListLayout = React.createElement("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    Padding = UDim.new(0, 6)
                }),
                BodyText = React.createElement("TextLabel", {
                    LayoutOrder = 0,
                    BackgroundTransparency = 1,
                    Text = tbl4.descriptionKey,
                    TextSize = baseSize,
                    TextColor3 = var2.Theme.TextDefault.Color,
                    TextTransparency = var2.Theme.TextDefault.Transparency,
                    FontFace = normalizeFontFace(var2.Tokens.Typography.BodyLarge.Font),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    Size = UDim2.new(0, partialPageModalMiddleContentWidth, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    RichText = true
                })
            }
        )
    })
end

return EntryView

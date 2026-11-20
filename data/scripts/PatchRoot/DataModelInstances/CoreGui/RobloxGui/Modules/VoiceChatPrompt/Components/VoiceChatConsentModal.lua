-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local React = require(CorePackages.Packages.React)
local t = require(CorePackages.Packages.t)
local ArgCheck = require(CorePackages.Workspace.Packages.ArgCheck)
local VoiceChat = require(CorePackages.Workspace.Packages.VoiceChat)

local UIBlox = require(CorePackages.Packages.UIBlox)
local Checkbox = require(CorePackages.Packages.Foundation).Checkbox
local GetTextSize = require(CorePackages.Workspace.Packages.Style).GetTextSize

local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local _Images = UIBlox.App.ImageSet.Images

local Assets = require(script.Parent.Parent.Parent.InGameMenu.Resources.Assets)

local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local GetFFlagSupportGamepadNavInVoiceModals = VoiceChat.Flags.GetFFlagSupportGamepadNavInVoiceModals
local GetFFlagDisablePVUpsellDataConsent = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagDisablePVUpsellDataConsent

local text = RobloxTranslator:FormatByKey("Feature.SettingsHub.Action.TurnOn")
local var1 = RobloxTranslator:FormatByKey("Feature.SettingsHub.Action.NotNow")
local var2 = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.SelectingTurnOn")

local var4 = ArgCheck.wrap(
    t.strictInterface({
        titleText = t.optional(t.string),
        bodyText = t.optional(t.string),
        handlePrimaryActivated = t.optional(t.callback),
        handleSecondaryActivated = t.optional(t.callback),
        Analytics = t.optional(t.table),
        showCheckbox = t.optional(t.boolean),
        promptStyle = t.optional(t.table),
        showPrompt = t.optional(t.boolean)
    })
)
local function VoiceChatConsentModal(tbl1, ref)
    assert(var4(tbl1))

    local isChecked, var6 = React.useState(false)

    local font = tbl1.promptStyle.Font.Header1.Font
    local var7 = tbl1.promptStyle.Font.Header1.RelativeSize * tbl1.promptStyle.Font.BaseSize
    local yOffset = 20 + GetTextSize(tbl1.titleText, var7, font, Vector2.new(325, math.huge), { addTemporaryPadding = false }).Y

    local font2 = tbl1.promptStyle.Font.Body.Font
    local var8 = tbl1.promptStyle.Font.Body.RelativeSize * tbl1.promptStyle.Font.BaseSize
    local yOffset2 = 20 + GetTextSize(tbl1.bodyText, var8, font2, Vector2.new(325, math.huge), { addTemporaryPadding = false }).Y

    local font3 = tbl1.promptStyle.Font.CaptionHeader.Font
    local var9 = tbl1.promptStyle.Font.CaptionHeader.RelativeSize * tbl1.promptStyle.Font.BaseSize
    local yOffset3 = 20 + GetTextSize(var2, var9, font3, Vector2.new(325, math.huge), { addTemporaryPadding = false }).Y
    local stop = if GetFFlagSupportGamepadNavInVoiceModals() then Enum.SelectionBehavior.Stop else nil
    local var10 = if GetFFlagSupportGamepadNavInVoiceModals() then true else nil

    local createElement = Roact.createElement
    local str1 = "ScreenGui"
    local tbl2 = {
        DisplayOrder = 8,
        IgnoreGuiInset = true,
        OnTopOfCoreBlur = true,
        Enabled = tbl1.showPrompt,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    }
    local tbl3 = {
        Overlay = Roact.createElement("TextButton", {
            AutoButtonColor = false,
            BackgroundColor3 = tbl1.promptStyle.Theme.Overlay.Color,
            BackgroundTransparency = tbl1.promptStyle.Theme.Overlay.Transparency,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 1, 0),
            Text = ""
        }),
        DialogMainFrame = 0
    }

    local createElement2 = Roact.createElement
    local imageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
    local tbl4 = {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Image = Assets.Images.RoundedRect.Image,
        ImageColor3 = tbl1.promptStyle.Theme.BackgroundUIDefault.Color,
        ImageTransparency = tbl1.promptStyle.Theme.BackgroundUIDefault.Transparency,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        ScaleType = Assets.Images.RoundedRect.ScaleType,
        Size = UDim2.new(
            0,
            365,
            0,
            yOffset + 1 + yOffset2 + 14 + 36 + (if GetFFlagDisablePVUpsellDataConsent() then 0 else 60 + yOffset3)
        ),
        AutomaticSize = Enum.AutomaticSize.Y,
        SliceCenter = Assets.Images.RoundedRect.SliceCenter,
        SelectionBehaviorDown = stop,
        SelectionBehaviorLeft = stop,
        SelectionBehaviorRight = stop,
        SelectionBehaviorUp = stop,
        SelectionGroup = var10,
        ref = 0
    }

    if not GetFFlagSupportGamepadNavInVoiceModals() then
        ref = nil
    end

    tbl4.ref = ref
    local tbl5 = {
        Padding = Roact.createElement("UIPadding", {
            PaddingTop = UDim.new(0, 10),
            PaddingBottom = UDim.new(0, 20),
            PaddingLeft = UDim.new(0, 20),
            PaddingRight = UDim.new(0, 20)
        }),
        Layout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        TitleTextContainer = Roact.createElement("Frame", {
            BackgroundTransparency = 1,
            LayoutOrder = 1,
            Size = UDim2.new(1, 0, 0, yOffset),
            AutomaticSize = Enum.AutomaticSize.Y
        }, {
            TitleText = Roact.createElement(UIBlox.App.Text.StyledTextLabel, {
                fontStyle = tbl1.promptStyle.Font.Header1,
                colorStyle = tbl1.promptStyle.Theme.SystemPrimaryDefault,
                textXAlignment = Enum.TextXAlignment.Center,
                size = UDim2.new(1, 0, 1, 0),
                text = tbl1.titleText
            })
        }),
        Divider = Roact.createElement("Frame", {
            BackgroundColor3 = tbl1.promptStyle.Theme.Divider.Color,
            BackgroundTransparency = tbl1.promptStyle.Theme.Divider.Transparency,
            BorderSizePixel = 0,
            LayoutOrder = 2,
            Size = UDim2.new(1, 0, 0, 1)
        }),
        DividerSpaceContainer = Roact.createElement("Frame", { BackgroundTransparency = 1, LayoutOrder = 3, Size = UDim2.new(1, 0, 0, 7) }),
        BodyTextContainer = Roact.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                LayoutOrder = 4,
                Size = UDim2.new(1, 0, 0, yOffset2)
            },
            {
                BodyText = Roact.createElement(UIBlox.App.Text.StyledTextLabel, {
                    fontStyle = tbl1.promptStyle.Font.Body,
                    colorStyle = tbl1.promptStyle.Theme.TextDefault,
                    textXAlignment = Enum.TextXAlignment.Left,
                    size = UDim2.new(1, 0, 1, 0),
                    text = tbl1.bodyText,
                    lineHeight = 1.2
                })
            }
        ),
        InfoTextContainer = 0,
        SpaceContainer = 0,
        ButtonContainer = 0
    }
    local element

    if GetFFlagDisablePVUpsellDataConsent() then
        element = nil
    else
        element = Roact.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                LayoutOrder = 5,
                Size = UDim2.new(1, 0, 0, yOffset3 + 20)
            },
            {
                Padding = Roact.createElement("UIPadding", { PaddingTop = UDim.new(0, 15) }),
                Layout = Roact.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalAlignment = Enum.VerticalAlignment.Top,
                    HorizontalAlignment = Enum.HorizontalAlignment.Left
                }),
                Checkbox = tbl1.showCheckbox
                    and Roact.createElement(Checkbox, {
                        label = "",
                        isChecked = isChecked,
                        isDisabled = false,
                        onActivated = function(arg2)
                            var6(arg2)
                        end,
                        LayoutOrder = 1
                    }),
                TextContainer = Roact.createElement(
                    "Frame",
                    {
                        BackgroundTransparency = 1,
                        LayoutOrder = 2,
                        Size = UDim2.new(if tbl1.showCheckbox then 0.95 else 1, 0, 0, yOffset3)
                    },
                    {
                        Padding = tbl1.showCheckbox and Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, 10) }),
                        InfoText = Roact.createElement(UIBlox.App.Text.StyledTextLabel, {
                            fontStyle = tbl1.promptStyle.Font.CaptionHeader,
                            colorStyle = tbl1.promptStyle.Theme.TextDefault,
                            textXAlignment = Enum.TextXAlignment.Left,
                            textYAlignment = Enum.TextYAlignment.Top,
                            size = UDim2.new(1, 0, 1, 0),
                            text = var2,
                            lineHeight = 1.15
                        })
                    }
                )
            }
        )
    end

    tbl5.InfoTextContainer = element

    tbl5.SpaceContainer = Roact.createElement("Frame", { BackgroundTransparency = 1, LayoutOrder = 6, Size = UDim2.new(1, 0, 0, 10) })

    tbl5.ButtonContainer = Roact.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            LayoutOrder = 7,
            Size = UDim2.new(1, 0, 0, 36),
            AutomaticSize = Enum.AutomaticSize.Y
        },
        {
            Layout = Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                Padding = UDim.new(0, 12),
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center
            }),
            SecondaryButton = Roact.createElement(Button, {
                buttonType = ButtonType.Secondary,
                layoutOrder = 1,
                size = UDim2.new(0.5, -5, 0, 36),
                text = var1,
                onActivated = tbl1.handleSecondaryActivated,
                Selectable = var10
            }),
            ConfirmButton = Roact.createElement(Button, {
                buttonType = ButtonType.PrimarySystem,
                layoutOrder = 2,
                size = UDim2.new(0.5, -5, 0, 36),
                text = text,
                isDisabled = tbl1.showCheckbox and not isChecked,
                onActivated = tbl1.handlePrimaryActivated,
                Selectable = var10
            })
        }
    )
    tbl3.DialogMainFrame = createElement2(imageSetLabel, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end

if GetFFlagSupportGamepadNavInVoiceModals() then
    return (React.forwardRef(VoiceChatConsentModal))
end
return VoiceChatConsentModal

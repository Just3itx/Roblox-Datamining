-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)
local t = require(CorePackages.Packages.t)
local ArgCheck = require(CorePackages.Workspace.Packages.ArgCheck)
local VoiceChat = require(CorePackages.Workspace.Packages.VoiceChat)

local UIBlox = require(CorePackages.Packages.UIBlox)
local GetTextSize = require(CorePackages.Workspace.Packages.Style).GetTextSize
local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local Images = UIBlox.App.ImageSet.Images
local Assets = require(script.Parent.Parent.Parent.InGameMenu.Resources.Assets)

local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local getMicDeeplinkDirections = require(script.Parent.Parent.Helpers.getMicDeeplinkDirections)
local getPrimingText = require(script.Parent.Parent.Helpers.getPrimingText)

local GetFFlagSupportGamepadNavInVoiceModals = VoiceChat.Flags.GetFFlagSupportGamepadNavInVoiceModals

local var1 = RobloxTranslator:FormatByKey("Feature.SettingsHub.Action.OpenSettings")
local var2 = RobloxTranslator:FormatByKey("Feature.SettingsHub.Action.Ok")
local text = RobloxTranslator:FormatByKey("Feature.SettingsHub.Action.NotNow")

local iconsControlsMicrophone = Images["icons/controls/microphone"]

local var4 = ArgCheck.wrap(
    t.strictInterface({
        titleText = t.string,
        bodyText = t.string,
        handlePrimaryActivated = t.callback,
        handleSecondaryActivated = t.callback,
        Analytics = t.table,
        promptStyle = t.table,
        showPrompt = t.boolean,
        settingsAppAvailable = t.boolean,
        UserInputService = t.table
    })
)
local function DevicePermissionsModal(tbl1, ref)
    assert(var4(tbl1))

    local micDeeplinkDirections = getMicDeeplinkDirections(tbl1.settingsAppAvailable, tbl1.UserInputService)
    local primingText = getPrimingText(tbl1.UserInputService)

    local font = tbl1.promptStyle.Font.Header1.Font
    local var5 = tbl1.promptStyle.Font.Header1.RelativeSize * tbl1.promptStyle.Font.BaseSize
    local yOffset = 20 + GetTextSize(tbl1.titleText, var5, font, Vector2.new(325, math.huge), { addTemporaryPadding = false }).Y

    local font2 = tbl1.promptStyle.Font.Body.Font
    local var6 = tbl1.promptStyle.Font.Body.RelativeSize * tbl1.promptStyle.Font.BaseSize
    local yOffset2 = 20 + GetTextSize(tbl1.bodyText, var6, font2, Vector2.new(325, math.huge), { addTemporaryPadding = false }).Y
    local yOffset3

    if primingText then
        local font3 = tbl1.promptStyle.Font.CaptionHeader.Font
        local var7 = tbl1.promptStyle.Font.CaptionHeader.RelativeSize * tbl1.promptStyle.Font.BaseSize
        yOffset3 = 10 + GetTextSize(primingText, var7, font3, Vector2.new(325, math.huge), { addTemporaryPadding = false }).Y
    else
        yOffset3 = 0
    end

    local yOffset4

    if micDeeplinkDirections then
        local font3 = tbl1.promptStyle.Font.Body.Font
        local var7 = tbl1.promptStyle.Font.Body.RelativeSize * tbl1.promptStyle.Font.BaseSize
        yOffset4 = (if primingText then 10 else 20) + GetTextSize(micDeeplinkDirections, var7, font3, Vector2.new(325, math.huge), { addTemporaryPadding = false }).Y
    else
        yOffset4 = 0
    end

    local num1 = if primingText then 5.5 elseif micDeeplinkDirections then 4.5 else 4
    local stop = if GetFFlagSupportGamepadNavInVoiceModals() then Enum.SelectionBehavior.Stop else nil
    local var7 = if GetFFlagSupportGamepadNavInVoiceModals() then true else nil

    local createElement = React.createElement
    local str1 = "ScreenGui"
    local tbl2 = {
        DisplayOrder = 8,
        IgnoreGuiInset = true,
        OnTopOfCoreBlur = true,
        Enabled = tbl1.showPrompt,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    }
    local tbl3 = {
        Overlay = React.createElement("TextButton", {
            AutoButtonColor = false,
            BackgroundColor3 = tbl1.promptStyle.Theme.Overlay.Color,
            BackgroundTransparency = tbl1.promptStyle.Theme.Overlay.Transparency,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 1, 0),
            Text = ""
        }),
        DialogMainFrame = 0
    }

    local createElement2 = React.createElement
    local imageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
    local tbl4 = {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Image = Assets.Images.RoundedRect.Image,
        ImageColor3 = tbl1.promptStyle.Theme.BackgroundUIDefault.Color,
        ImageTransparency = tbl1.promptStyle.Theme.BackgroundUIDefault.Transparency,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        ScaleType = Assets.Images.RoundedRect.ScaleType,
        Size = UDim2.new(0, 365, 0, yOffset + 5 + yOffset2 + 36 + num1 * 20 + yOffset4 + 55 + yOffset3),
        AutomaticSize = Enum.AutomaticSize.Y,
        SliceCenter = Assets.Images.RoundedRect.SliceCenter,
        SelectionBehaviorDown = stop,
        SelectionBehaviorLeft = stop,
        SelectionBehaviorRight = stop,
        SelectionBehaviorUp = stop,
        SelectionGroup = var7,
        ref = 0
    }

    if not GetFFlagSupportGamepadNavInVoiceModals() then
        ref = nil
    end

    tbl4.ref = ref
    local tbl5 = {
        Padding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, 15),
            PaddingBottom = UDim.new(0, 20),
            PaddingLeft = UDim.new(0, 20),
            PaddingRight = UDim.new(0, 20)
        }),
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        Icon = React.createElement(UIBlox.Core.ImageSet.ImageSetLabel, {
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Image = iconsControlsMicrophone,
            Size = UDim2.new(0, 55, 0, 55),
            LayoutOrder = 1,
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        }),
        TitleTextContainer = React.createElement("Frame", {
            BackgroundTransparency = 1,
            LayoutOrder = 2,
            Size = UDim2.new(1, 0, 0, yOffset),
            AutomaticSize = Enum.AutomaticSize.Y
        }, {
            Padding = React.createElement("UIPadding", { PaddingBottom = UDim.new(0, 7) }),
            TitleText = React.createElement(UIBlox.App.Text.StyledTextLabel, {
                fontStyle = tbl1.promptStyle.Font.Header1,
                colorStyle = tbl1.promptStyle.Theme.SystemPrimaryDefault,
                textXAlignment = Enum.TextXAlignment.Center,
                size = UDim2.new(1, 0, 1, 0),
                text = tbl1.titleText
            })
        }),
        Divider = React.createElement("Frame", {
            BackgroundColor3 = tbl1.promptStyle.Theme.Divider.Color,
            BackgroundTransparency = tbl1.promptStyle.Theme.Divider.Transparency,
            BorderSizePixel = 0,
            LayoutOrder = 3,
            Size = UDim2.new(1, 0, 0, 1)
        }),
        DividerSpaceContainer = React.createElement("Frame", { BackgroundTransparency = 1, LayoutOrder = 4, Size = UDim2.new(1, 0, 0, 15) }),
        BodyTextContainer = React.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                LayoutOrder = 5,
                Size = UDim2.new(1, 0, 0, yOffset2)
            },
            {
                BodyText = React.createElement(UIBlox.App.Text.StyledTextLabel, {
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
        PrimingTextContainer = 0,
        SpaceContainerTemp = 0,
        ButtonContainer = 0
    }
    local element

    if micDeeplinkDirections then
        element = React.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                LayoutOrder = 6,
                Size = UDim2.new(1, 0, 0, yOffset4 + 20)
            },
            {
                Padding = React.createElement(
                    "UIPadding",
                    {
                        PaddingTop = UDim.new(0, if primingText then 8 else 15),
                        PaddingLeft = UDim.new(0, 8)
                    }
                ),
                TextContainer = React.createElement(
                    "Frame",
                    {
                        BackgroundTransparency = 1,
                        LayoutOrder = 2,
                        Size = UDim2.new(1, 0, 0, yOffset4)
                    },
                    {
                        InfoText = React.createElement(UIBlox.App.Text.StyledTextLabel, {
                            fontStyle = tbl1.promptStyle.Font.Body,
                            colorStyle = tbl1.promptStyle.Theme.TextEmphasis,
                            textXAlignment = Enum.TextXAlignment.Left,
                            textYAlignment = Enum.TextYAlignment.Top,
                            size = UDim2.new(1, 0, 1, 0),
                            text = micDeeplinkDirections,
                            lineHeight = 1.25
                        })
                    }
                )
            }
        )
    else
        element = nil
    end

    tbl5.InfoTextContainer = element

    tbl5.SpaceContainer = if primingText then nil else React.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            LayoutOrder = 7,
            Size = UDim2.new(1, 0, 0, if micDeeplinkDirections then 40 else 20)
        }
    )
    local element2

    if primingText then
        element2 = React.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                LayoutOrder = 8,
                Size = UDim2.new(1, 0, 0, yOffset3)
            },
            {
                PrimingText = React.createElement(UIBlox.App.Text.StyledTextLabel, {
                    fontStyle = tbl1.promptStyle.Font.Body,
                    colorStyle = tbl1.promptStyle.Theme.TextDefault,
                    textXAlignment = Enum.TextXAlignment.Left,
                    textYAlignment = Enum.TextYAlignment.Top,
                    size = UDim2.new(1, 0, 1, 0),
                    text = primingText,
                    lineHeight = 1.25
                })
            }
        )
    else
        element2 = nil
    end

    tbl5.PrimingTextContainer = element2

    tbl5.SpaceContainerTemp = if primingText then React.createElement("Frame", { BackgroundTransparency = 1, LayoutOrder = 9, Size = UDim2.new(1, 0, 0, 30) }) else nil

    local createElement3 = React.createElement
    local str2 = "Frame"
    local tbl6 = {
        BackgroundTransparency = 1,
        LayoutOrder = 10,
        Size = UDim2.new(1, 0, 0, 36)
    }
    local tbl7 = {
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            Padding = UDim.new(0, 12),
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        SecondaryButton = if tbl1.settingsAppAvailable then React.createElement(Button, {
            buttonType = ButtonType.Secondary,
            layoutOrder = 1,
            size = UDim2.new(0.5, -5, 0, 36),
            text = text,
            onActivated = tbl1.handleSecondaryActivated,
            Selectable = var7
        }) else nil,
        ConfirmButton = React.createElement(Button, {
            buttonType = ButtonType.PrimarySystem,
            layoutOrder = 2,
            size = UDim2.new(if tbl1.settingsAppAvailable then 0.5 else 1, -5, 0, 36),
            text = if tbl1.settingsAppAvailable then var1 else var2,
            onActivated = tbl1.handlePrimaryActivated,
            Selectable = var7
        })
    }
    tbl5.ButtonContainer = createElement3(str2, tbl6, tbl7)
    tbl3.DialogMainFrame = createElement2(imageSetLabel, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end

if GetFFlagSupportGamepadNavInVoiceModals() then
    return (React.forwardRef(DevicePermissionsModal))
end
return DevicePermissionsModal

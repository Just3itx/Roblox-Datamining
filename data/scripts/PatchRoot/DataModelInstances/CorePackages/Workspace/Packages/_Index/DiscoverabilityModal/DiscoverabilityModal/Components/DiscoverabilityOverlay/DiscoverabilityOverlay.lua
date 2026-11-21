-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local scriptParentParentParent = script.Parent.Parent.Parent
local TextKeys = require(scriptParentParentParent.Common.TextKeys)
local dependencies = require(scriptParentParentParent.dependencies)
local Analytics = scriptParentParentParent.Analytics
local EventNames = require(Analytics.Enums.EventNames)

local React = dependencies.React
local UIBlox = dependencies.UIBlox
local Foundation = dependencies.Foundation
local Checkbox = Foundation.Checkbox
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local useLocalization = dependencies.Hooks.useLocalization

local DiscoverabilityUpsellNonPrefillDiscoverableUserIdsWhitelist = require(scriptParentParentParent.Flags.DiscoverabilityUpsellNonPrefillDiscoverableUserIdsWhitelist)

local useStyle = UIBlox.Core.Style.useStyle
local PartialPageModal = UIBlox.App.Dialog.Modal.PartialPageModal
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel

local RadioButtonList = UIBlox.App.InputButton.RadioButtonList
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local IconSize = UIBlox.App.Constant.IconSize

local tbl1 = { ["1"] = "Discoverable", ["2"] = "NotDiscoverable", ["nil"] = "Unset" }

return function(tbl2)
    local prefillDiscoverabilitySetting = tbl2.prefillDiscoverabilitySetting

    if Players.LocalPlayer
        and DiscoverabilityUpsellNonPrefillDiscoverableUserIdsWhitelist.isWhitelistedUserId(Players.LocalPlayer.UserId)
    then
        prefillDiscoverabilitySetting = false
    end

    local initialValue, var2 = React.useState(if prefillDiscoverabilitySetting then 1 else nil)

    local var3 = useStyle()
    local font = var3.Font
    local theme = var3.Theme

    local var4 = useLocalization({
        optInText = TextKeys.DISCOVERABILITY_OPT_IN,
        infoText = TextKeys.DISCOVERABILITY_INFO,
        learnMoreText = TextKeys.LEARN_MORE,
        continueText = TextKeys.CONTINUE,
        yesText = TextKeys.YES_OPT_IN,
        noText = TextKeys.NO_OPT_OUT,
        titleText = TextKeys.DISCOVERABILITY_TITLE,
        titleTextPrefillDiscoverable = TextKeys.DISCOVERABILITY_TITLE_PREFILL_DISCOVERABLE,
        optInTextPrefillDiscoverable = TextKeys.DISCOVERABILITY_OPT_IN_PREFILL_DISCOVERABLE,
        infoTextPrefillDiscoverable = TextKeys.DISCOVERABILITY_INFO_PREFILL_DISCOVERABLE
    })

    local function onActivated(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
        tbl2.analytics.fireAnalyticsEvent(EventNames.DiscoverabilityModalRadioButtonClick, { selected = tbl1[tostring(arg1)] })

        var2(arg1)
    end

    local function func1()
        tbl2.onActivated(tbl1[tostring(initialValue)])
    end

    local var5, element, element2, var6, var7, offset

    if prefillDiscoverabilitySetting then
        local function func2()
            onActivated(if initialValue == 1 then 2 else 1)
        end

        var5 = var4.titleTextPrefillDiscoverable

        element = React.createElement(ImageSetLabel, {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Image = Images["icons/graphic/findfriends_xlarge"],
            ImageTransparency = theme.IconEmphasis.Transparency,
            Size = UDim2.fromOffset(IconSize.XLarge, IconSize.XLarge),
            Position = UDim2.fromScale(0.5, 0.5),
            LayoutOrder = 1
        })

        local createElement = React.createElement
        local tbl3 = {
            BackgroundTransparency = 1,
            LayoutOrder = 2,
            Size = UDim2.fromScale(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y
        }
        local tbl4 = {
            UIListLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                Padding = UDim.new(0, 8),
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center
            }),
            UIPadding = React.createElement("UIPadding", { PaddingBottom = UDim.new(0, 12), PaddingRight = UDim.new(0, 24) }),
            Checkbox = React.createElement(Checkbox, { label = "", onActivated = func2, isChecked = initialValue == 1, LayoutOrder = 1 }),
            CheckboxLabel = React.createElement("TextButton", {
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                FontFace = normalizeFontFace(var3.Tokens.Typography.BodyLarge.Font),
                Size = UDim2.fromScale(1, 0),
                Text = var4.optInTextPrefillDiscoverable,
                TextColor3 = theme.TextDefault.Color,
                TextSize = font.Body.RelativeSize * font.BaseSize,
                TextTransparency = theme.TextDefault.Transparency,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                LayoutOrder = 2,
                [React.Event.Activated] = func2
            })
        }
        element2 = createElement("Frame", tbl3, tbl4)

        var6 = var4.infoTextPrefillDiscoverable
        var7 = theme.TextLink.Color
        offset = 12
    else
        var5 = var4.titleText

        element = React.createElement(StyledTextLabel, {
            text = var4.optInText,
            fontStyle = font.Body,
            colorStyle = theme.TextDefault,
            size = UDim2.fromScale(1, 0),
            automaticSize = Enum.AutomaticSize.Y,
            textTruncate = Enum.TextTruncate.AtEnd,
            textXAlignment = Enum.TextXAlignment.Left,
            textYAlignment = Enum.TextYAlignment.Top,
            layoutOrder = 1
        })

        element2 = React.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                LayoutOrder = 2,
                Size = UDim2.fromScale(1, 0),
                AutomaticSize = Enum.AutomaticSize.Y
            },
            {
                RadioButtonList = React.createElement(RadioButtonList, {
                    radioButtons = {
                        {
                            label = var4.yesText
                        },
                        {
                            label = var4.noText
                        }
                    },
                    elementSize = UDim2.new(1, 0, 0, 50),
                    onActivated = onActivated,
                    initialValue = initialValue,
                    padding = UDim.new(0, 0),
                    layoutOrder = 1
                })
            }
        )
        var6 = var4.infoText
        var7 = theme.TextEmphasis.Color
        offset = 24
    end

    local createElement = React.createElement
    local var8 = PartialPageModal

    local tbl3 = {
        title = var5,
        screenSize = tbl2.screenSize,
        onCloseClicked = function()
            tbl2.onCloseClicked(tbl1[tostring(initialValue)])
        end,
        buttonStackProps = {
            buttons = {{
                buttonType = ButtonType.PrimarySystem,
                props = {
                    onActivated = func1,
                    text = var4.continueText
                }
            }},
            buttonHeight = 48,
            marginBetween = 6,
            forcedFillDirection = Enum.FillDirection.Vertical
        }
    }

    local tbl4 = { ViewContainer = 0 }
    local createElement2 = React.createElement
    local tbl5 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.fromScale(1, 0),
        BackgroundTransparency = 1
    }
    local tbl6 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 12),
            HorizontalAlignment = Enum.HorizontalAlignment.Center
        }),
        UIPadding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, offset), PaddingBottom = UDim.new(0, 36) }),
        Header = element,
        Selector = element2,
        Description = React.createElement(StyledTextLabel, {
            text = var6,
            fontStyle = font.CaptionBody,
            colorStyle = theme.TextDefault,
            size = UDim2.fromScale(1, 0),
            automaticSize = Enum.AutomaticSize.Y,
            textTruncate = Enum.TextTruncate.AtEnd,
            textXAlignment = Enum.TextXAlignment.Left,
            textYAlignment = Enum.TextYAlignment.Top,
            layoutOrder = 3
        }),
        LearnMore = React.createElement("TextButton", {
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            FontFace = normalizeFontFace(var3.Tokens.Typography.BodySmall.Font),
            Size = UDim2.fromScale(1, 0),
            Text = var4.learnMoreText,
            TextColor3 = var7,
            TextSize = font.CaptionBody.RelativeSize * font.BaseSize,
            TextTransparency = theme.TextEmphasis.Transparency,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            LayoutOrder = 4,
            [React.Event.Activated] = tbl2.onLearnMoreClick
        })
    }
    tbl4.ViewContainer = createElement2("Frame", tbl5, tbl6)
    return createElement(var8, tbl3, tbl4)
end

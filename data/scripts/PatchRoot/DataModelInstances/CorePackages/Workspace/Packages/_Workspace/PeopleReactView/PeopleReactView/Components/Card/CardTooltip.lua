-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:21:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactView = script:FindFirstAncestor("PeopleReactView")
local PeopleReactViewParent = PeopleReactView.Parent

local React = require(PeopleReactViewParent.React)

local PeopleService = require(PeopleReactViewParent.PeopleService)

local RobloxAppEnums = require(PeopleReactViewParent.RobloxAppEnums)
local useDeviceOrientation = require(PeopleReactViewParent.RobloxAppHooks).useDeviceOrientation

local useLocalization = require(PeopleReactViewParent.Localization).Hooks.useLocalization

local Foundation = require(PeopleReactViewParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local InputSize = Foundation.Enums.InputSize
local ButtonVariant = Foundation.Enums.ButtonVariant
local StateLayerMode = Foundation.Enums.StateLayerMode
local Button = Foundation.Button
local FoundationText = Foundation.Text
local View = Foundation.View

local Constants = require(PeopleReactView.Constants)

local GetFFlagFixPeoplePageCardTooltip = PeopleService.getService("Flags").GetFFlagFixPeoplePageCardTooltip

local function CardTooltip(arg1)
    local var1 = useTokens()

    local uDim2 = UDim2.fromScale(1.75, 0)
    if GetFFlagFixPeoplePageCardTooltip() then
        local bool1 = useDeviceOrientation() == RobloxAppEnums.DeviceOrientationMode.Portrait

        uDim2 = React.useMemo(function(): UDim2
            if bool1 then
                return UDim2.fromScale(1, 0)
            end

            return UDim2.fromScale(1.75, 0)
        end, { bool1 })
    end

    local var2 = useLocalization({
        title = Constants.PEOPLEPAGE.CARD_TOOLTIP.LOCALIZED_STRINGS.BUY_WHAT_THEYRE_WEARING,
        description = Constants.PEOPLEPAGE.CARD_TOOLTIP.LOCALIZED_STRINGS.SELECT_AVATAR_TO_CHECKOUT_ITEMS,
        secondaryDescription = Constants.PEOPLEPAGE.CARD_TOOLTIP.LOCALIZED_STRINGS.SELECT_USERNAME_TO_VIEW_PROFILE,
        ok = Constants.PEOPLEPAGE.CARD_TOOLTIP.LOCALIZED_STRINGS.OK
    })

    return React.createElement(View, {
        tag = "auto-y radius-medium",
        backgroundStyle = var1.Inverse.Surface.Surface_0,
        Position = UDim2.new(1, var1.Size.Size_300, 0, 0),
        Size = uDim2,
        stateLayer = {
            mode = StateLayerMode.Inverse
        },
        ZIndex = 2
    }, {
        Content = React.createElement(View, {
            tag = "size-full-0 auto-y col gap-medium padding-medium"
        }, {
            Title = React.createElement(FoundationText, {
                tag = "size-full-0 auto-y text-title-large content-inverse-emphasis text-align-x-left text-wrap",
                Text = var2.title,
                LayoutOrder = 1
            }),
            Description = React.createElement(FoundationText, {
                tag = "size-full-0 auto-y text-body-medium content-inverse-default text-align-x-left text-wrap",
                Text = var2.description,
                LayoutOrder = 2
            }),
            SecondaryDescription = React.createElement(FoundationText, {
                tag = "size-full-0 auto-y text-body-medium content-inverse-default text-align-x-left text-wrap",
                Text = var2.secondaryDescription,
                LayoutOrder = 3
            }),
            Action = React.createElement(Button, {
                text = var2.ok,
                size = InputSize.Medium,
                width = UDim.new(1, 0),
                variant = ButtonVariant.Emphasis,
                LayoutOrder = 4,
                onActivated = arg1.action
            })
        }),
        Arrow = React.createElement(View, {
            tag = "size-200 radius-xsmall",
            backgroundStyle = var1.Inverse.Surface.Surface_0,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0, 1, 0.5, 0),
            Rotation = 45,
            stateLayer = {
                mode = StateLayerMode.Inverse
            }
        })
    })
end

return CardTooltip

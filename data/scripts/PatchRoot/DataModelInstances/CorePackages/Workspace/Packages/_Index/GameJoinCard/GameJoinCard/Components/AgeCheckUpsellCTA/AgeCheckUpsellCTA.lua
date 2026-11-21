-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCardParent = script:FindFirstAncestor("GameJoinCard").Parent

local React = require(GameJoinCardParent.React)
local Foundation = require(GameJoinCardParent.Foundation)
local Localization = require(GameJoinCardParent.Localization)

local Button = Foundation.Button
local Divider = Foundation.Divider
local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local View = Foundation.View
local ButtonVariant = Foundation.Enums.ButtonVariant
local DividerVariant = Foundation.Enums.DividerVariant
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local IconVariant = Foundation.Enums.IconVariant
local InputSize = Foundation.Enums.InputSize

local useLocalization = Localization.Hooks.useLocalization
local SharedFlags = require(GameJoinCardParent.SharedFlags)
local FFlagMobileGameJoinCardGamepadSupport = SharedFlags.FFlagMobileGameJoinCardGamepadSupport
local FFlagDesktopGameJoinCardGamepadSupport = SharedFlags.FFlagDesktopGameJoinCardGamepadSupport
local var1 = FFlagMobileGameJoinCardGamepadSupport or FFlagDesktopGameJoinCardGamepadSupport

local function AgeCheckUpsellCTA(tbl1)
    local var2 = useLocalization(
        {
            unlock = "Feature.ExperienceDetails.PlayButtonText.Unlock",
            bodyText = "Feature.FAE.CheckIfYouCanJoinGame"
        }
    )

    local createElement = React.createElement
    local var3 = View
    local tbl2 = {
        tag = "col size-full-0 auto-y",
        LayoutOrder = tbl1.LayoutOrder
    }
    local tbl3 = {
        Banner = React.createElement(View, { tag = "col size-full-0 auto-y", LayoutOrder = 1 }, {
            TopDivider = React.createElement(Divider, { variant = DividerVariant.Default, LayoutOrder = 1 }),
            BannerContent = React.createElement(
                View,
                {
                    tag = "row align-x-left align-y-center gap-medium size-full-0 auto-y padding-y-medium",
                    LayoutOrder = 2
                },
                {
                    BannerIcon = React.createElement(
                        Icon,
                        {
                            tag = "content-emphasis",
                            name = IconName.LockClosed,
                            size = IconSize.Large,
                            variant = IconVariant.Regular
                        }
                    ),
                    BannerText = React.createElement(
                        FoundationText,
                        {
                            tag = "shrink auto-xy text-wrap text-align-x-left text-body-medium content-emphasis",
                            Text = var2.bodyText
                        }
                    )
                }
            )
        }),
        UnlockButton = React.createElement(Button, {
            ref = if var1 then tbl1.focusRef else nil,
            text = var2.unlock,
            onActivated = tbl1.onUnlockPressed,
            variant = ButtonVariant.Emphasis,
            inputSize = InputSize.Medium,
            width = UDim.new(1, 0),
            LayoutOrder = 2
        })
    }
    return createElement(var3, tbl2, tbl3)
end

return AgeCheckUpsellCTA

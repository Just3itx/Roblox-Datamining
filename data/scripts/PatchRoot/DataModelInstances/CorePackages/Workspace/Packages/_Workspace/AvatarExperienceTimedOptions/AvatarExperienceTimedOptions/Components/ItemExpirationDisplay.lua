-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:11:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceTimedOptionsParent = script:FindFirstAncestor("AvatarExperienceTimedOptions").Parent
local React = require(AvatarExperienceTimedOptionsParent.React)
local useLocalization = require(AvatarExperienceTimedOptionsParent.Localization).Hooks.useLocalization
local Foundation = require(AvatarExperienceTimedOptionsParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local View = Foundation.View
local FoundationText = Foundation.Text
local Enums = Foundation.Enums

local LocalizationService = game:GetService("LocalizationService")

local function formatExpirationDateTime(isoDate: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    local dateTime = DateTime.fromIsoDate(isoDate)
    if not dateTime then
        return isoDate
    end

    return dateTime:FormatLocalTime("MMM DD, LT", LocalizationService.RobloxLocaleId)
end

local function ItemExpirationDisplay(tbl1)
    local var1 = useTokens()

    local var2 = useLocalization({ itemExpires = "Feature.Durables.Label.ItemExpires" })

    return React.createElement(View, {
        tag = "row align-y-center padding-large radius-medium flex-between size-full-0",
        backgroundStyle = var1.Color.Surface.Surface_100,
        LayoutOrder = tbl1.LayoutOrder,
        AutomaticSize = Enum.AutomaticSize.Y
    }, {
        LeftContent = React.createElement(View, {
            tag = "row align-y-center gap-small auto-xy",
            LayoutOrder = 1
        }, {
            Icon = React.createElement(
                Foundation.Icon,
                {
                    name = Enums.IconName.Clock,
                    variant = Enums.IconVariant.Regular,
                    size = Enums.IconSize.Small,
                    LayoutOrder = 1
                }
            ),
            Label = React.createElement(
                FoundationText,
                {
                    tag = "auto-xy text-label-medium content-emphasis",
                    Text = var2.itemExpires,
                    LayoutOrder = 2
                }
            )
        }),
        RightContent = React.createElement(View, { tag = "auto-xy", LayoutOrder = 2 }, {
            ExpirationText = React.createElement(
                FoundationText,
                {
                    tag = "auto-xy text-body-medium content-emphasis",
                    Text = formatExpirationDateTime(tbl1.expirationTime)
                }
            )
        })
    })
end
return ItemExpirationDisplay

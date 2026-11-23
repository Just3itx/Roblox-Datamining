-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:11:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")
local HttpService = game:GetService("HttpService")
local AvatarExperienceTimedOptionsParent = script:FindFirstAncestor("AvatarExperienceTimedOptions").Parent
local React = require(AvatarExperienceTimedOptionsParent.React)
local Localization = require(AvatarExperienceTimedOptionsParent.Localization)
local Localization2 = require(AvatarExperienceTimedOptionsParent.RobloxAppLocales).Localization
local useLocalization = Localization.Hooks.useLocalization
local NumberLocalization = Localization.NumberLocalization
local Foundation = require(AvatarExperienceTimedOptionsParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local FoundationText = Foundation.Text
local View = Foundation.View
local Enums = Foundation.Enums
local AvatarExperienceAnalytics = require(AvatarExperienceTimedOptionsParent.AvatarExperienceAnalytics)
local addUnifiedEventLogging = AvatarExperienceAnalytics.addUnifiedEventLogging
local UnifiedEventLogConstants = AvatarExperienceAnalytics.UnifiedEventLogConstants
local UnifiedEventLogEnums = AvatarExperienceAnalytics.UnifiedEventLogEnums
local FFlagAXWearTimeListItemUnifiedLogging = require(AvatarExperienceTimedOptionsParent.AvatarExperienceFlags).FFlagAXWearTimeListItemUnifiedLogging

return (React.forwardRef(function(tbl1, ref)
    local var1 = useTokens()
    local var2 = React.useMemo(function()
        return Localization2.new(LocalizationService.RobloxLocaleId)
    end, {})
    local var3 = useLocalization({
        infinite = "Feature.Durables.ItemDetails.WearTimeOptions.Button.Infinite",
        xDay = {
            "Feature.Durables.ItemDetails.WearTimeOptions.Button.XDay",
            num = tbl1.days
        },
        xDays = {
            "Feature.Durables.ItemDetails.WearTimeOptions.Button.XDays",
            num = tbl1.days
        }
    })
    local var4 = if tbl1.days == 0 then var3.infinite elseif tbl1.days == 1 then var3.xDay else var3.xDays

    if FFlagAXWearTimeListItemUnifiedLogging and not ref then
        ref = React.createRef()
    end

    if FFlagAXWearTimeListItemUnifiedLogging then
        React.useEffect(function()
            local var5 = addUnifiedEventLogging
            local var6 = ref
            local tbl2 = {
                action = UnifiedEventLogEnums.MarketplaceUnifiedAction.UI_ELEMENT_CLICK,
                elementName = "TIMED_OPTION_LIST_ITEM",
                elementMetadata = 0
            }
            local httpService = HttpService
            local input = {
                days = if tbl1.days == 0 then "permanent" else tostring(tbl1.days),
                price = tostring(tbl1.price)
            }
            tbl2.elementMetadata = httpService:JSONEncode(input)
            var5(var6, tbl2, { sessionTagName = UnifiedEventLogConstants.L2_SESSION_TAG_NAME })
        end, { tbl1.days, tbl1.price })
    end

    return React.createElement(View, {
        tag = "row align-y-center gap-medium padding-medium radius-medium size-full-0 auto-y",
        ref = ref,
        onActivated = tbl1.onActivated,
        backgroundStyle = if tbl1.isActive then var1.Color.Shift.Shift_300 else nil,
        LayoutOrder = tbl1.LayoutOrder,
        stateLayer = {
            affordance = Enums.StateLayerAffordance.None
        },
        selection = { Selectable = true }
    }, {
        ContentContainer = React.createElement(
            View,
            { tag = "row align-y-center size-full-0 auto-y flex-x-between", LayoutOrder = 1 },
            {
                DurationText = React.createElement(FoundationText, {
                    tag = "auto-xy",
                    Text = var4,
                    textStyle = var1.Color.Content.Emphasis,
                    fontStyle = {
                        Font = var1.Typography.LabelMedium.Font,
                        FontSize = var1.FontSize.FontSize_400
                    },
                    LayoutOrder = 1,
                    selection = { Selectable = false }
                }),
                PriceContainer = React.createElement(View, {
                    tag = "row align-y-center gap-xsmall auto-xy",
                    LayoutOrder = 2
                }, {
                    RobuxIcon = React.createElement(Foundation.Icon, {
                        name = Enums.IconName.Robux,
                        variant = Enums.IconVariant.Regular,
                        size = Enums.IconSize.Medium,
                        style = var1.Color.Content.Default,
                        LayoutOrder = 1
                    }),
                    PriceText = React.createElement(FoundationText, {
                        tag = "auto-xy",
                        Text = NumberLocalization.localize(tbl1.price, var2:GetLocale()),
                        textStyle = var1.Color.Content.Default,
                        fontStyle = {
                            Font = var1.Typography.LabelMedium.Font,
                            FontSize = var1.FontSize.FontSize_400
                        },
                        LayoutOrder = 2,
                        selection = { Selectable = false }
                    })
                })
            }
        )
    })
end))

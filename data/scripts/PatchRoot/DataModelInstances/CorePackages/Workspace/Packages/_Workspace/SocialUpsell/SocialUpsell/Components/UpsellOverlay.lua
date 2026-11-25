-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialUpsell = script:FindFirstAncestor("SocialUpsell")
local SocialUpsellParent = SocialUpsell.Parent

local Foundation = require(SocialUpsellParent.Foundation)
local React = require(SocialUpsellParent.React)
local Responsive = require(SocialUpsellParent.Responsive)
local AppBlox = require(SocialUpsellParent.AppBlox)
local Display = require(SocialUpsellParent.Display)
local SignalsReact = require(SocialUpsellParent.SignalsReact)
local ReactFocusNavigation = require(SocialUpsellParent.ReactFocusNavigation)
local ReactUtils = require(SocialUpsellParent.ReactUtils)
local useLocalization = require(SocialUpsellParent.Localization).Hooks.useLocalization
local useSelector = require(SocialUpsellParent.RoactUtils).Hooks.RoactRodux.useSelector
local HttpService = game:GetService("HttpService")
local FFlagEnableAEGIS2CommsFAEUpsell = require(SocialUpsellParent.SharedFlags).FFlagEnableAEGIS2CommsFAEUpsell

local SocialUpsellAnalytics = require(SocialUpsell.Analytics.SocialUpsellAnalytics)
local _UpsellEntrySurfaceType = require(SocialUpsell.Analytics.Enum.UpsellEntrySurfaceType)
local UpsellComponent = require(SocialUpsell.Analytics.Enum.UpsellComponent)
local _SocialUpsellType = require(SocialUpsell.Enum.SocialUpsellType)
local Constants = require(SocialUpsell.Constants)
local SocialLuaAnalytics = require(SocialUpsellParent.SocialLuaAnalytics)
local BannerBadge = AppBlox.BannerBadge
local EventTypes = SocialLuaAnalytics.Analytics.Enums.EventTypes
local FIntMaxDaysToShowCountDownLabel = require(SocialUpsell.Flag.FIntMaxDaysToShowCountDownLabel)
local FIntMinDaysToShowCountdownLabel = require(SocialUpsell.Flag.FIntMinDaysToShowCountdownLabel)
local useSocialUpsellOverlayController = require(SocialUpsell.Hooks.useSocialUpsellOverlayController)

local minHeightFor = Responsive.BreakpointConfig.getMinHeightFor(Responsive.Keys.Medium)

local BadgeVariant = Foundation.Enums.BadgeVariant
local ButtonVariant = Foundation.Enums.ButtonVariant
local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize
local IconName = Foundation.Enums.IconName
local FoundationText = Foundation.Text
local View = Foundation.View
local Image = Foundation.Image
local useScaledValue = Foundation.Hooks.useScaledValue

local tbl1 = { isInExperience = true }

local function func1(deadlineUtcTimestamp: number?, arg1)
    if not deadlineUtcTimestamp or deadlineUtcTimestamp == 0 then
        return nil
    end

    local num1 = math.floor((deadlineUtcTimestamp - os.time()) / 86400)

    if num1 < FIntMinDaysToShowCountdownLabel or FIntMaxDaysToShowCountDownLabel < num1 then
        return nil
    elseif num1 < 1 then
        return arg1.dayLeft
    end
    return arg1.daysLeft:gsub("{(.-)}", { daysLeft = tostring(num1) })
end

local getViewportSize = if FFlagEnableAEGIS2CommsFAEUpsell then Display.GetDisplayStore(false).getViewportSize else nil

return function(arg1)
    local var1 = arg1 or tbl1
    local var2 = useSocialUpsellOverlayController(var1.isInExperience)
    local var3 = React.useRef(nil)
    local vector2 = Vector2.new(useScaledValue(320), useScaledValue(180))
    local ref, var5 = ReactFocusNavigation.useDefaultFocusBehavior()
    local var6 = React.useRef(nil)
    local var4 = ReactUtils.useComposedRef(var5, var6)

    React.useEffect(function()
        if not var6.current then
            return
        end

        local var8 = var6.current:FindFirstChildWhichIsA("ScrollingFrame", true)
        if var8 then
            var8.Selectable = false
        end
    end, {})

    local var8 = React.useMemo(function()
        return var1.impressionId or HttpService:GenerateGUID(false)
    end, {
        var1.impressionId,
        var1.upsellEntrySurface,
        var1.upsellPurpose,
        var1.upsellEntryComponent
    })

    local upsellStage = React.useMemo(function()
        return SocialUpsellAnalytics.evaluateUpsellStage(var1.upsellEntrySurface, UpsellComponent.Modal, var1.upsellEntryComponent)
    end, { var1.upsellEntrySurface, var1.upsellEntryComponent })

    local var10 = useLocalization({ daysLeft = "Feature.FAE.Label.DaysLeft", dayLeft = "Feature.FAE.Label.DayLeft" })

    local var11 = React.useMemo(function()
        if var1.countDownBadge then
            return func1(var1.countDownBadge.deadlineUtcTimestamp, var10)
        end
        return nil
    end, { var1.countDownBadge, var10 })

    local text = React.useMemo(function()
        if var1.countDownBadge then
            if var1.countDownBadge.text then
                return var1.countDownBadge.text
            end

            return var11
        end

        return nil
    end, { var11, var1.countDownBadge })

    local var13 = if FFlagEnableAEGIS2CommsFAEUpsell then SignalsReact.useSignalState(getViewportSize) else useSelector(function(arg2)
        return arg2.ScreenSize
    end)

    local y = var13.Y
    local bool1 = minHeightFor <= y

    React.useEffect(function()
        if not var8 or var3.current == var8 then
            return
        end

        SocialUpsellAnalytics.logUpsellEvent(EventTypes.SocialUpsellShown, {
            upsellPurpose = var1.upsellPurpose,
            upsellEntrySurface = var1.upsellEntrySurface,
            upsellStage = upsellStage,
            upsellImpressionId = var8,
            upsellComponent = UpsellComponent.Modal,
            upsellEntryComponent = var1.upsellEntryComponent
        })

        var3.current = var8
    end, {
        var1.upsellEntrySurface,
        var1.upsellPurpose,
        var8,
        upsellStage,
        var1.upsellEntryComponent
    })

    local var14 = React.useCallback(function(btn: string)
        SocialUpsellAnalytics.logUpsellEvent(EventTypes.SocialUpsellButtonClick, {
            upsellPurpose = var1.upsellPurpose,
            upsellEntrySurface = var1.upsellEntrySurface,
            upsellStage = upsellStage,
            upsellImpressionId = var8,
            upsellComponent = UpsellComponent.Modal,
            btn = btn,
            upsellEntryComponent = var1.upsellEntryComponent
        })
    end, {
        var1.upsellEntrySurface,
        var1.upsellPurpose,
        var8,
        upsellStage,
        var1.upsellEntryComponent
    })

    local onActivated = React.useCallback(function()
        var14(Constants.UPSELL_OVERLAY_BUTTON_ACTION.Primary)
        var1.primaryAction.onActivated()
    end, { var1.primaryAction, var14 })

    local onClose = React.useCallback(function()
        var14(Constants.UPSELL_OVERLAY_BUTTON_ACTION.Dismiss)
        var2.closeSocialOverlay()
        if var1.onClose then
            var1.onClose()
        end
    end, { var14, var1.onClose, var2.closeSocialOverlay })

    local actions = React.useMemo(function()
        local result = {}
        table.insert(
            result,
            {
                text = var1.primaryAction.text,
                variant = ButtonVariant.Emphasis,
                onActivated = onActivated,
                ref = ref
            }
        )

        return result
    end, { onActivated, var1.primaryAction, ref })

    local createElement = React.createElement
    local root = Dialog.Root
    local tbl2 = {
        size = DialogSize.Medium,
        hasBackdrop = true,
        closeOnClickOutside = true,
        onClose = onClose,
        ref = var4
    }
    local tbl3 = { DialogContent = 0, DialogActions = 0 }
    local createElement2 = React.createElement
    local content = Dialog.Content
    local tbl4 = {}
    local tbl5 = { Content = 0 }
    local createElement3 = React.createElement
    local var18 = View
    local tbl6 = { tag = "col auto-y size-full-0 gap-medium padding-top-xlarge", LayoutOrder = 1 }

    local tbl7 = {
        Image = if var1.imageId and bool1 then React.createElement(Image, {
            tag = "size-full-full self-center content-emphasis",
            Image = var1.imageId,
            aspectRatio = 16 / 9,
            sizeConstraint = { MaxSize = vector2 }
        }) else nil,
        Badge = if text then React.createElement(BannerBadge, {
            LayoutOrder = 1,
            icon = {
                variant = Foundation.Enums.IconVariant.Filled,
                position = Foundation.Enums.IconPosition.Left,
                name = IconName.Clock
            },
            text = text,
            variant = BadgeVariant.Neutral
        }) else nil,
        TextContainer = React.createElement(
            View,
            {
                tag = "col gap-medium size-full-0 auto-y padding-right-xxlarge padding-bottom-xsmall",
                LayoutOrder = 2
            },
            {
                Title = if var1.title then React.createElement(View, {
                    tag = "size-full-0 auto-y",
                    LayoutOrder = 2
                }, {
                    TitleText = React.createElement(
                        FoundationText,
                        {
                            Text = var1.title,
                            tag = "size-full-0 auto-y content-emphasis text-wrap text-align-x-left text-heading-medium"
                        }
                    )
                }) else nil,
                BodyText = if var1.bodyText then React.createElement(
                    FoundationText,
                    {
                        tag = "size-full-0 auto-y text-wrap text-align-x-left text-body-medium",
                        Text = var1.bodyText,
                        LayoutOrder = 3
                    }
                ) else nil
            }
        )
    }
    tbl5.Content = createElement3(var18, tbl6, tbl7)
    tbl3.DialogContent = createElement2(content, tbl4, tbl5)

    tbl3.DialogActions = React.createElement(Dialog.Actions, { LayoutOrder = if text then 3 else 4, actions = actions })
    return createElement(root, tbl2, tbl3)
end

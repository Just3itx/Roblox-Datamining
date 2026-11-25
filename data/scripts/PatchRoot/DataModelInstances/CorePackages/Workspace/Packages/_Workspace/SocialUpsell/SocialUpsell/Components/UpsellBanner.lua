-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialUpsell = script:FindFirstAncestor("SocialUpsell")
local SocialUpsellParent = SocialUpsell.Parent
local HttpService = game:GetService("HttpService")
local React = require(SocialUpsellParent.React)
local useEffect = React.useEffect
local AppBlox = require(SocialUpsellParent.AppBlox)
local Foundation = require(SocialUpsellParent.Foundation)
local useCallback = React.useCallback

local Cryo = require(SocialUpsellParent.Cryo)
local _Types = require(SocialUpsell.Types)
local Constants = require(SocialUpsell.Constants)
local _SocialUpsellType = require(SocialUpsell.Enum.SocialUpsellType)
local isCompactUpsellBanner = require(SocialUpsell.Utils.isCompactUpsellBanner)
local getUpsellSignalStore = require(SocialUpsell.SignalStores.getUpsellSignalStore)

local SocialUpsellAnalytics = require(SocialUpsell.Analytics.SocialUpsellAnalytics)
local UpsellComponent = require(SocialUpsell.Analytics.Enum.UpsellComponent)
local EventTypes = require(SocialUpsellParent.SocialLuaAnalytics).Analytics.Enums.EventTypes

local FFlagAgeBasedUXHomepageVerificationBannerGreyButton = require(SocialUpsellParent.SharedFlags).FFlagAgeBasedUXHomepageVerificationBannerGreyButton

local UPSELL_BUTTON_ACTION = Constants.UPSELL_BUTTON_ACTION
local ButtonVariant = Foundation.Enums.ButtonVariant

local Banner = AppBlox.Banner

local tbl1 = { isContained = true }

local function getButtonVariant(arg1, config) -- Luacid: Inlined by compiler; 1 call site recovered
    if FFlagAgeBasedUXHomepageVerificationBannerGreyButton and arg1.variantOverride then
        return arg1.variantOverride
    end

    local var1 = isCompactUpsellBanner(config)
    if arg1.action then
        if arg1.action == UPSELL_BUTTON_ACTION.Primary then
            return if var1 then ButtonVariant.SoftEmphasis else ButtonVariant.Emphasis
        end
        if arg1.action == UPSELL_BUTTON_ACTION.Secondary then
            return ButtonVariant.Utility
        end
    end
    return nil
end

local function getBannerPropsFromConfig(config, tbl2)
    local badges = {}
    local buttons = {}

    if config.buttons then
        for _, button in config.buttons do
            table.insert(
                buttons,
                {
                    text = button.text,
                    variant = getButtonVariant(button, config),
                    onActivated = tbl2[button.action]
                }
            )
        end
    end
    if config.labelItems then
        for _, labelItem in config.labelItems do
            if labelItem.type ~= Constants.UPSELL_LABEL_ITEM_TYPE_COUNTDOWN then
                continue
            end

            table.insert(badges, {
                text = labelItem.text,
                icon = {
                    variant = Foundation.Enums.IconVariant.Filled,
                    position = Foundation.Enums.IconPosition.Left,
                    name = Foundation.Enums.IconName.Clock
                },
                variant = Foundation.Enums.BadgeVariant.Neutral
            })
        end
    end

    return {
        title = config.title,
        body = config.body,
        badges = badges,
        buttons = buttons,
        onDismiss = if config.isDismissable then tbl2[UPSELL_BUTTON_ACTION.Dismiss] else nil,
        image = config.image,
        icon = if config.image then nil else config.icon
    }
end

local function UpsellBanner(tbl2)
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)

    local var2 = React.useMemo(function()
        return var1.impressionId or HttpService:GenerateGUID(false)
    end, { var1.impressionId, var1.config.type })

    local var3 = React.useRef(nil)
    local upsellSignalStore = getUpsellSignalStore()

    local upsellStage = React.useMemo(function()
        return SocialUpsellAnalytics.evaluateUpsellStage(var1.upsellEntrySurface, UpsellComponent.Banner, var1.upsellEntryComponent)
    end, { var1.upsellEntrySurface, var1.upsellEntryComponent })

    useEffect(function()
        if not var2 or var3.current == var2 then
            return
        end

        SocialUpsellAnalytics.logUpsellEvent(EventTypes.SocialUpsellShown, {
            upsellPurpose = var1.config.type,
            upsellEntrySurface = var1.upsellEntrySurface,
            upsellStage = upsellStage,
            upsellImpressionId = var2,
            upsellComponent = UpsellComponent.Banner,
            conversationId = var1.conversationId,
            upsellEntryComponent = var1.upsellEntryComponent
        })

        var3.current = var2
    end, {
        var1.config.type,
        var1.upsellEntrySurface,
        upsellStage,
        var2,
        var1.upsellEntryComponent
    })

    useEffect(function()
        local type = var1.config.type
        local upsellEntrySurface = var1.upsellEntrySurface
        upsellSignalStore.setUpsellBannerData(type, upsellEntrySurface, var1.config)

        return function()
            upsellSignalStore.setUpsellBannerData(type, upsellEntrySurface, nil)
        end
    end, { var1.upsellEntrySurface, var1.config, upsellSignalStore })

    local var5 = useCallback(function(callback: (...any) -> (...any), btn)
        return function()
            SocialUpsellAnalytics.logUpsellEvent(EventTypes.SocialUpsellButtonClick, {
                upsellPurpose = var1.config.type,
                upsellEntrySurface = var1.upsellEntrySurface,
                upsellStage = upsellStage,
                upsellImpressionId = var2,
                upsellComponent = UpsellComponent.Banner,
                btn = btn,
                conversationId = var1.conversationId,
                upsellEntryComponent = var1.upsellEntryComponent
            })
            callback(var2)
        end
    end, {
        var1.upsellEntrySurface,
        var1.config.type,
        upsellStage,
        var2,
        var1.upsellEntryComponent
    })

    local var6 = useCallback(var5(var1.onPrimaryAction, UPSELL_BUTTON_ACTION.Primary), { var5, var1.onPrimaryAction })

    local var7 = useCallback(var5(var1.onSecondaryAction, UPSELL_BUTTON_ACTION.Secondary), { var5, var1.onSecondaryAction })

    local var8 = useCallback(var5(var1.onDismiss, "Dismiss"), { var5, var1.onDismiss })

    local var9 = React.useMemo(function()
        return (getBannerPropsFromConfig(var1.config, {
            [UPSELL_BUTTON_ACTION.Primary] = var6,
            [UPSELL_BUTTON_ACTION.Secondary] = var7,
            [UPSELL_BUTTON_ACTION.Dismiss] = var8
        }))
    end, {
        var1.config,
        var6,
        var7,
        var8
    })

    return React.createElement(Banner, Cryo.Dictionary.join(var9, { isContained = var1.isContained }))
end

return UpsellBanner

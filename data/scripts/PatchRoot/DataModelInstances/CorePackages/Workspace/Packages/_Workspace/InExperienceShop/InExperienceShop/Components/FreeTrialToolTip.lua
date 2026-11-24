-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local React = require(InExperienceShopParent.React)
local Foundation = require(InExperienceShopParent.Foundation)
local SignalsReact = require(InExperienceShopParent.SignalsReact)
local useLocalization = require(InExperienceShopParent.Localization).Hooks.useLocalization

local FFlagEnableExperienceShopGlobalIcon = require(InExperienceShop.Flags.FFlagEnableExperienceShopGlobalIcon)
local FFlagFixFreeTrialTooltipLocalization = require(InExperienceShop.Flags.FFlagFixFreeTrialTooltipLocalization)
local GetShopGlobalIconStore = require(InExperienceShop.Stores.GetShopGlobalIconStore)
local submitFreeTrialTooltips = require(InExperienceShop.submitFreeTrialTooltips)

local EducationalTooltip = Foundation.EducationalTooltip
local OverlayProvider = Foundation.OverlayProvider
local ButtonVariant = Foundation.Enums.ButtonVariant
local PopoverSide = Foundation.Enums.PopoverSide
local PopoverAlign = Foundation.Enums.PopoverAlign

local function createShownTooltip(anchorRef, str1: string, text: string, onActivated: (...any) -> (...any), callback: (...any) -> (...any))
    return React.createElement(OverlayProvider, nil, {
        Tooltip = React.createElement(EducationalTooltip, {
            anchorRef = anchorRef,
            title = str1 .. string.rep(" ", 10),
            side = PopoverSide.Bottom,
            align = PopoverAlign.Start,
            isOpen = true,
            actions = {{
                text = text,
                variant = ButtonVariant.Emphasis,
                onActivated = onActivated,
                width = UDim.new(1, 0)
            }},
            onClose = function()
                callback("user")
            end,
            onPressedOutside = function()
                callback("user")
            end,
            testId = "trial-available-tooltip"
        })
    })
end

local function ShownFreeTrialToolTip(tbl1)
    local var1 = useLocalization({ title = tbl1.titleKey, actionText = tbl1.actionTextKey })

    return createShownTooltip(tbl1.anchorRef, var1.title, var1.actionText, tbl1.onActionActivated, tbl1.dismiss)
end

return React.memo(function(tbl1) -- name: FreeTrialToolTip
    local var1 = SignalsReact.useSignalState(submitFreeTrialTooltips.getActiveTooltip)

    local current = SignalsReact.useSignalState(function(arg1)
        if not FFlagEnableExperienceShopGlobalIcon then
            return nil
        end
        return GetShopGlobalIconStore(arg1).getIconInstance(arg1)
    end)
    local var3 = React.useRef(current)
    var3.current = current
    local bool1 = not (var1 == nil) and var1.slot == "EducationTooltipOnShopIcon"

    if not bool1 then
        var3 = tbl1.anchorRef
    end
    local var4, var5 = React.useState(false)
    React.useEffect(function()
        var5(not (var3 == nil) and var3.current ~= nil)
    end, { var3, current, tbl1.anchorRef })

    local var6, var7 = React.useState(false)
    local dismiss = React.useCallback(function(str1: string)
        var7(true)
        submitFreeTrialTooltips.dismiss(str1)
    end, {})

    local action = if var1 == nil then nil else var1.action
    local gamePassId = if var1 == nil then nil else var1.gamePassId

    local onActionActivated = React.useCallback(function()
        submitFreeTrialTooltips.reportActivated()
        dismiss("activated")
        if action == "promptGamePassPurchase" and gamePassId ~= nil then
            require(InExperienceShop.initiateShopItemPurchase)(gamePassId, "GamePass")
            return
        end
        tbl1.onOpenShop()
    end, {
        dismiss,
        tbl1.onOpenShop,
        action,
        gamePassId
    })

    local title, actionText

    if FFlagFixFreeTrialTooltipLocalization then
        title = ""
        actionText = ""
    else
        local var2 = if var1 == nil then "" else var1.title
        local var8 = if var1 == nil then "" else var1.actionText
        local var11 = useLocalization({ title = var2, actionText = var8 })

        title = var11.title
        actionText = var11.actionText
    end

    local var9 = not (var1 == nil) and var4 and not var6
    local var10 = if bool1 then var9 and current ~= nil else var9 and tbl1.visible == true
    local tooltipQueue = tbl1.tooltipQueue
    local bool2 = not (tooltipQueue == nil) and tooltipQueue.isCurrentTooltip("TRIAL_AVAILABLE_TOOLTIP") == true
    local var11 = React.useRef(tooltipQueue)
    React.useEffect(function()
        var11.current = tooltipQueue
    end, { tooltipQueue })

    local var12 = if var1 == nil then 0 else var1.delayMs
    local var13 = if var1 == nil then 0 else var1.durationMs
    React.useEffect(function()
        local current = var11.current
        if var10 and current ~= nil and tbl1.priority ~= nil then
            current.registerTooltip("TRIAL_AVAILABLE_TOOLTIP", tbl1.priority, var12, var13)
            return function()
                current.unregisterTooltip("TRIAL_AVAILABLE_TOOLTIP")
            end
        end
    end, {
        var10,
        tbl1.priority,
        var12,
        var13
    })
    local var14 = React.useRef(false)
    React.useEffect(function()
        if var14.current and not bool2 and var10 then
            dismiss("timeout")
        end
        var14.current = bool2
    end, { bool2, var10, dismiss })

    local bool3 = var10 == true and bool2

    React.useEffect(function()
        if not bool3 then
            return
        end
        submitFreeTrialTooltips.reportMounted()
        submitFreeTrialTooltips.reportViewed()
    end, { bool3 })

    if not bool3 or var1 == nil then
        return nil
    elseif FFlagFixFreeTrialTooltipLocalization then
        if var1.title == "" or var1.actionText == "" then
            return nil
        end
        return React.createElement(ShownFreeTrialToolTip, {
            anchorRef = var3,
            titleKey = var1.title,
            actionTextKey = var1.actionText,
            onActionActivated = onActionActivated,
            dismiss = dismiss
        })
    else
        return createShownTooltip(var3, title, actionText, onActionActivated, dismiss)
    end
end)

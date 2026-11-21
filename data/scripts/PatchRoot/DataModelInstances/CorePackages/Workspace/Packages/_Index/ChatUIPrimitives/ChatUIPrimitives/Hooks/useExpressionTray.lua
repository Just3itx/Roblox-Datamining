-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:20:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local React = require(ChatUIPrimitivesParent.React)
local Signals = require(ChatUIPrimitivesParent.Signals)
local SignalsReact = require(ChatUIPrimitivesParent.SignalsReact)

local _ExpressionTrayView = require(ChatUIPrimitives.Components.ExpressionTray.ExpressionTrayView)
local useExpressionTrayController = require(ChatUIPrimitives.Hooks.useExpressionTrayController)
local useInExperienceLocalization = require(ChatUIPrimitives.Hooks.useInExperienceLocalization)
local useLayoutMode = require(ChatUIPrimitives.Hooks.useLayoutMode)
local withPresetDisclaimer = require(ChatUIPrimitives.PresetChat.withPresetDisclaimer)
local getExpressionCooldownStore = require(ChatUIPrimitives.getExpressionCooldownStore).getExpressionCooldownStore
local getDefaultCooldownKey = require(ChatUIPrimitives.getDefaultCooldownKey)
local expressionCatalogStore = require(ChatUIPrimitives.expressionCatalogStore)
local _createExpressionCatalogResource = require(ChatUIPrimitives.createExpressionCatalogResource)
local _Types = require(ChatUIPrimitives.UniversalMessage.Types)
local FFlagExpChatPresetGroupFooter = require(ChatUIPrimitives.Flags.FFlagExpChatPresetGroupFooter)

local FFlagExpChatExpressionTrayRecoverFromSendError = require(ChatUIPrimitives.Flags.FFlagExpChatExpressionTrayRecoverFromSendError)

local num1 = game:DefineFastInt("PresetChatCooldownLuaMs", 10000) / 1000

local signal = Signals.createSignal("disabled")
local signal2 = Signals.createSignal({})
local signal3 = Signals.createSignal(nil)
local tbl1 = {}

local function useExpressionTray(tbl2)
    local layoutMode = useLayoutMode()
    local catalogResource = if tbl2 then tbl2.catalogResource else nil
    local var2 = if tbl2 == nil or catalogResource ~= nil then nil else expressionCatalogStore
    local var3 = SignalsReact.useSignalState(if var2 ~= nil then var2.getStatus else signal)

    local var4 = SignalsReact.useSignalState(if var2 ~= nil then var2.getCategoryGroups else signal2)

    local var5 = SignalsReact.useSignalState(if catalogResource ~= nil then catalogResource.getCatalog else signal3)
    local var6

    if catalogResource ~= nil then
        var3 = if var5 == nil then "disabled" else var5.status
        local categoryGroups = if var5 == nil then nil else var5.categoryGroups

        if categoryGroups ~= nil then
            var6 = categoryGroups
        else
            var6 = tbl1
        end
    else
        var6 = var4
    end
    if FFlagExpChatPresetGroupFooter then
        local var7 = useInExperienceLocalization()

        var6 = React.useMemo(function()
            return withPresetDisclaimer(var6, var7)
        end, { var6, var7 })
    end
    local expressionCooldownStore = getExpressionCooldownStore(if tbl2 then tbl2.cooldownScope else nil)
    local cooldownEndsAtByKey = SignalsReact.useSignalState(expressionCooldownStore.getCooldownEndsAtByKey)

    local var8 = useExpressionTrayController({ categoryGroups = var6 })

    local close = var8.close
    local var9 = React.useRef(false)
    local canSend = if tbl2 then tbl2.canSend else false

    React.useEffect(function()
        local var10 = catalogResource
        if var10 ~= nil then
            if canSend then
                var10.acquire()
                return function()
                    var10.release()
                end
            end

            close()
            return
        end

        if canSend and var2 ~= nil then
            var2.acquire()
            return function()
                var2.release()
            end
        end

        close()
    end, {
        canSend,
        catalogResource,
        var2,
        close
    })

    local onKeyboardActivated = if tbl2 then tbl2.onKeyboardActivated else nil

    local var1 = React.useCallback(function()
        close()
        if onKeyboardActivated then
            onKeyboardActivated()
        end
    end, { close, onKeyboardActivated })

    local sendExpression = if tbl2 then tbl2.sendExpression else nil
    local cooldownDurationSeconds = if tbl2 and tbl2.cooldownDurationSeconds ~= nil then tbl2.cooldownDurationSeconds else num1

    local onExpressionActivated = React.useCallback(function(arg1)
        if sendExpression == nil then
            return
        end
        local defaultCooldownKey = getDefaultCooldownKey(arg1)

        if defaultCooldownKey ~= nil then
            local cooldownEndsAt = expressionCooldownStore.getCooldownEndsAt(defaultCooldownKey)
            if cooldownEndsAt ~= nil and os.clock() < cooldownEndsAt then
                return
            end
        end
        if var9.current then
            return
        end

        var9.current = true
        if defaultCooldownKey ~= nil then
            expressionCooldownStore.startCooldown(defaultCooldownKey, os.clock() + cooldownDurationSeconds)
        end
        close()
        task.spawn(function()
            if FFlagExpChatExpressionTrayRecoverFromSendError then
                local success, result = pcall(sendExpression, arg1)
                var9.current = false

                if success and not result and defaultCooldownKey ~= nil then
                    expressionCooldownStore.clearCooldown(defaultCooldownKey)
                end
                if not success then
                    error(result, 0)
                end
            else
                local var12 = sendExpression(arg1)
                var9.current = false

                if not var12 and defaultCooldownKey ~= nil then
                    expressionCooldownStore.clearCooldown(defaultCooldownKey)
                end
            end
        end)
    end, {
        sendExpression,
        cooldownDurationSeconds,
        close,
        expressionCooldownStore
    })

    local onOpenChanged = if tbl2 then tbl2.onOpenChanged else nil
    local isVisible = canSend and var3 == "enabled" and #var6 > 0
    local var13 = var8.isOpen and isVisible
    React.useEffect(function()
        if onOpenChanged then
            onOpenChanged(var13)
        end
    end, { var13, onOpenChanged })

    if tbl2 == nil then
        return nil
    end

    return {
        isVisible = isVisible,
        isOpen = var8.isOpen,
        layoutMode = layoutMode,
        focusNavEnabled = tbl2.focusNavEnabled,
        canLocalUserChat = tbl2.canLocalUserChat,
        footerText = tbl2.footerText,
        categoryGroups = var6,
        activeGroupId = var8.activeGroupId,
        cooldownDurationSeconds = cooldownDurationSeconds,
        cooldownEndsAtByKey = cooldownEndsAtByKey,
        onEntryActivated = var8.onEntryActivated,
        onPressedOutside = close,
        onGroupActivated = var8.onGroupActivated,
        onExpressionActivated = onExpressionActivated,
        onKeyboardActivated = var1
    }
end

return useExpressionTray

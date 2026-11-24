-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local React = require(ExpChatParent.React)
local SignalsReact = require(ExpChatParent.SignalsReact)

local Config = require(ExpChat.Config)
local GetTransparencyStore = require(ExpChat.Stores.GetTransparencyStore)
local GetChatTooltipStore = require(ExpChat.Stores.GetChatTooltipStore)
local _createChatTooltipStore = require(ExpChat.Stores.GetChatTooltipStore.createChatTooltipStore)

local function useChatTooltipLifecycle(tbl1)
    local tooltipKey = tbl1.tooltipKey
    local targetTextChannel = tbl1.targetTextChannel

    local chatTooltipStore = GetChatTooltipStore(false)
    local transparencyStore = GetTransparencyStore(false)

    local var1 = SignalsReact.useSignalState(chatTooltipStore.getShouldShow(tooltipKey))
    local var2 = SignalsReact.useSignalState(chatTooltipStore.getIsScreenWideEnough)
    local var3 = transparencyStore.getIsFocused or transparencyStore.getIsTextBoxFocused
    local var4 = SignalsReact.useSignalState(transparencyStore.getLastActivity)
    local var5 = SignalsReact.useSignalState(var3)

    local var6, var7 = React.useState(true)
    local var8, var9 = React.useState(false)

    local var10 = React.useRef(false)
    local var11 = React.useRef(0)
    local var12 = React.useRef(targetTextChannel)

    local setIsDismissed = chatTooltipStore.setIsDismissed
    local reportImpression = chatTooltipStore.reportImpression
    local onDismiss = React.useCallback(function()
        if not var10.current then
            var10.current = true
            reportImpression(tooltipKey)
        end
        setIsDismissed(tooltipKey, true)
    end, { tooltipKey, setIsDismissed, reportImpression })

    React.useEffect(function()
        if var5 then
            var7(true)
            return nil
        end

        local var14 = Config.ChatWindowBackgroundFadeOutTime - (os.clock() - var4)
        if var14 <= 0 then
            var7(false)
            return nil
        end
        var7(true)
        local var15 = task.delay(var14, function()
            var7(false)
        end)
        return function()
            task.cancel(var15)
        end
    end, { var4, var5 })

    React.useEffect(function()
        if not (var6 and var2) or var8 or not var1 then
            return nil
        end
        local startTime = os.clock()
        local num1 = math.max(0, 10 - var11.current)
        local var14 = task.delay(num1, function()
            var9(true)
        end)
        return function()
            local var15 = var11
            var15.current += os.clock() - startTime
            task.cancel(var14)
        end
    end, {
        var6,
        var2,
        var8,
        var1
    })

    React.useEffect(function()
        if not var8 then
            return nil
        end
        local var14 = task.delay(1, function()
            onDismiss()
        end)
        return function()
            task.cancel(var14)
        end
    end, { var8, onDismiss })

    React.useEffect(function()
        local current = var12.current
        var12.current = targetTextChannel
        if current and current ~= targetTextChannel and var1 and not var8 then
            var9(true)
        end
    end, { targetTextChannel, var1, var8 })

    return {
        isActive = var1 and var6 and var2 and not var8,
        onDismiss = onDismiss
    }
end

return useChatTooltipLifecycle

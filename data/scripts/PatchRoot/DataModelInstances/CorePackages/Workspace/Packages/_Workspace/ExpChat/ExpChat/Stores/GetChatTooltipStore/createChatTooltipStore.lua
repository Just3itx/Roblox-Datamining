-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Display = require(ExpChatParent.Display)
local Signals = require(ExpChatParent.Signals)
local createSignal = Signals.createSignal
local createComputed = Signals.createComputed
local createEffect = Signals.createEffect

local isUserChatEnabled = require(ExpChat.isUserChatEnabled)
local GetChatStatusStore = require(script.Parent.Parent.GetChatStatusStore)
local GetPresetChatStore = require(script.Parent.Parent.GetPresetChatStore)
local promptsApi = require(script.Parent.promptsApi)

local tbl1 = { "GlobalChatTooltip", "PresetChatTooltip" }

local tbl2 = { isEligible = false, isDismissed = false, shouldShow = false }

return function()
    local getIsChatWindowOpen, setIsChatWindowOpen = createSignal(false)
    local getIsChatInputBarVisible, setIsChatInputBarVisible = createSignal(false)
    local var5, setIsGlobalChatAvailable = createSignal(false)

    local getIsScreenWideEnough = createComputed(function(arg1): boolean
        return Display.GetDisplayStore(arg1).getViewportSize(arg1).X >= 720
    end)

    local chatStatusStore = GetChatStatusStore(false)
    local presetChatStore = GetPresetChatStore(false)

    local tbl3 = {
        GlobalChatTooltip = function(arg1)
            return isUserChatEnabled(chatStatusStore.getChatStatus(arg1)) and var5(arg1)
        end,
        PresetChatTooltip = function(arg1)
            return presetChatStore.getIsEnabled(arg1) and presetChatStore.getAccessLevel(arg1) == "Enabled"
        end
    }

    local tbl4 = ({})

    local function ensureTooltip(str1: string)
        local var7 = tbl4[str1]
        if var7 then
            return var7
        end

        local getEntry, setEntry = createSignal(tbl2)

        local tbl5 = {
            getEntry = getEntry,
            setEntry = setEntry,
            getIsEligible = createComputed(function(arg1)
                return getEntry(arg1).isEligible
            end),
            getIsDismissed = createComputed(function(arg1)
                return getEntry(arg1).isDismissed
            end),
            getShouldShow = createComputed(function(arg1)
                return getEntry(arg1).shouldShow
            end)
        }
        tbl4[str1] = tbl5
        return tbl5
    end

    for _, value in tbl1 do
        ensureTooltip(value)
    end

    local function setField(str1: string, str2: string, bool1: boolean) -- Luacid: Inlined by compiler; 3 call sites recovered
        ensureTooltip(str1).setEntry(function(arg1)
            if arg1[str2] == bool1 then
                return arg1
            end
            local var7 = table.clone(arg1)
            var7[str2] = bool1
            return var7
        end)
    end

    local function isTooltipValid(arg1, str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        local var7 = tbl3[str1]
        if var7 ~= nil and not var7(arg1) then
            return false
        end
        local var8 = tbl4[str1]
        if var8 == nil then
            return false
        end
        local entry = var8.getEntry(arg1)
        return entry.isEligible and not entry.isDismissed
    end

    local getActiveTooltipKey, var8 = createSignal(nil)

    local activeTooltipKeyEffect = createEffect(function(arg1)
        local var9 = getActiveTooltipKey(false)

        if var9 ~= nil and isTooltipValid(arg1, var9) then
            return
        end

        for _, value in tbl1 do
            if not isTooltipValid(arg1, value) then
                continue
            end

            if var9 ~= value then
                var8(value)
            end
            return
        end

        if var9 ~= nil then
            var8(nil)
        end
    end)

    return {
        getIsChatWindowOpen = getIsChatWindowOpen,
        setIsChatWindowOpen = setIsChatWindowOpen,
        getIsChatInputBarVisible = getIsChatInputBarVisible,
        setIsChatInputBarVisible = setIsChatInputBarVisible,
        getIsScreenWideEnough = getIsScreenWideEnough,
        setIsGlobalChatAvailable = setIsGlobalChatAvailable,
        getActiveTooltipKey = getActiveTooltipKey,
        getIsEligible = function(str1: string)
            return ensureTooltip(str1).getIsEligible
        end,
        setIsEligible = function(str1: string, bool1: boolean)
            setField(str1, "isEligible", bool1)
        end,
        getIsDismissed = function(str1: string)
            return ensureTooltip(str1).getIsDismissed
        end,
        setIsDismissed = function(str1: string, bool1: boolean)
            setField(str1, "isDismissed", bool1)
        end,
        getShouldShow = function(str1: string)
            return ensureTooltip(str1).getShouldShow
        end,
        setShouldShow = function(str1: string, bool1: boolean)
            setField(str1, "shouldShow", bool1)
        end,
        reportImpression = function(str1: string)
            promptsApi.reportImpression(str1)
        end,
        activeTooltipKeyEffect = activeTooltipKeyEffect
    }
end

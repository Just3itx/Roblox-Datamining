-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Signals = require(ExpChatParent.Signals)
local createSignal = Signals.createSignal

local FFlagExpChatWindowStatusEventFixes = require(ExpChat.Flags.FFlagExpChatWindowStatusEventFixes)

return function()
    local getBackgroundTimerStarted, setBackgroundTimerStarted = createSignal(0)
    local getTextTimerStarted, setTextTimerStarted = createSignal(0)
    local getOpenTimerStarted, setOpenTimerStarted = createSignal(0)
    local getClosedTimerStarted, setClosedTimerStarted = createSignal(0)
    local getPreviousChatWindowStateTimerExpired, setPreviousChatWindowStateTimerExpired = createSignal(0)

    local getCurrentChatWindowState, setCurrentChatWindowState = createSignal("unknown")
    local getPreviousChatWindowState, setPreviousChatWindowState = createSignal("unknown")
    local num1 = 0
    local num2 = 0
    local num3 = 0
    local num4 = 0

    local getDurationUpdates, setDurationUpdates = createSignal({ openDuration = 0, closedDuration = 0, textIdleDuration = 0, backgroundIdleDuration = 0 })

    local var17 = nil

    local function getStateStartTime(str1: string) -- Luacid: Inlined by compiler; 12 call sites recovered
        if str1 == "open" then
            return getOpenTimerStarted(false)
        elseif str1 == "closed" then
            return getClosedTimerStarted(false)
        elseif str1 == "textIdle" then
            return getTextTimerStarted(false)
        elseif str1 == "backgroundIdle" then
            return getBackgroundTimerStarted(false)
        end
        return 0
    end

    local function addDurationDelta(str1: string, num5: number) -- Luacid: Inlined by compiler; 2 call sites recovered
        if str1 == "unknown" then
            return
        end

        local var18 = num5
            - (if str1 == "open" then getStateStartTime("open") elseif str1 == "closed" then getStateStartTime("closed") elseif str1 == "textIdle" then getStateStartTime("textIdle") elseif str1 ~= "backgroundIdle" then 0 else getStateStartTime("backgroundIdle"))

        if var18 <= 0 then
            return
        end

        setDurationUpdates(function(arg1)
            if str1 == "open" then
                return {
                    openDuration = arg1.openDuration + var18,
                    closedDuration = arg1.closedDuration,
                    textIdleDuration = arg1.textIdleDuration,
                    backgroundIdleDuration = arg1.backgroundIdleDuration
                }
            elseif str1 == "closed" then
                return {
                    openDuration = arg1.openDuration,
                    closedDuration = arg1.closedDuration + var18,
                    textIdleDuration = arg1.textIdleDuration,
                    backgroundIdleDuration = arg1.backgroundIdleDuration
                }
            elseif str1 == "textIdle" then
                return {
                    openDuration = arg1.openDuration,
                    closedDuration = arg1.closedDuration,
                    textIdleDuration = arg1.textIdleDuration + var18,
                    backgroundIdleDuration = arg1.backgroundIdleDuration
                }
            elseif str1 == "backgroundIdle" then
                return {
                    openDuration = arg1.openDuration,
                    closedDuration = arg1.closedDuration,
                    textIdleDuration = arg1.textIdleDuration,
                    backgroundIdleDuration = arg1.backgroundIdleDuration + var18
                }
            end

            return arg1
        end)
    end

    local newStateEffect = Signals.createEffect(function(arg1)
        local var18 = getBackgroundTimerStarted(arg1)
        local var19 = getTextTimerStarted(arg1)
        local var20 = getOpenTimerStarted(arg1)
        local var21 = getClosedTimerStarted(arg1)
        setPreviousChatWindowState(getCurrentChatWindowState(false))

        if var21 < var20 and var19 < var20 and var18 < var20 then
            setCurrentChatWindowState("open")
            setPreviousChatWindowStateTimerExpired(var20)
        elseif var19 < var21 and var18 < var21 then
            setCurrentChatWindowState("closed")
            setPreviousChatWindowStateTimerExpired(var21)
        elseif var18 < var19 then
            setCurrentChatWindowState("textIdle")
            setPreviousChatWindowStateTimerExpired(var19)
        elseif var18 > 0 then
            setCurrentChatWindowState("backgroundIdle")
            setPreviousChatWindowStateTimerExpired(var18)
        else
            setCurrentChatWindowState("unknown")
        end
    end)

    local changingWindowStateEffect = Signals.createEffect(function(arg1)
        local var18 = getPreviousChatWindowState(arg1)
        local var19 = getPreviousChatWindowStateTimerExpired(arg1)
        if FFlagExpChatWindowStatusEventFixes then
            addDurationDelta(var18, var19)
            return
        end

        if var18 == "open" then
            num1 = var19 - getOpenTimerStarted(arg1)
        elseif var18 == "closed" then
            num2 = var19 - getClosedTimerStarted(arg1)
        elseif var18 == "textIdle" then
            num3 = var19 - getTextTimerStarted(arg1)
        elseif var18 == "backgroundIdle" then
            num4 = var19 - getBackgroundTimerStarted(arg1)
        end
        setDurationUpdates(function(arg2)
            return {
                openDuration = arg2.openDuration + num1,
                closedDuration = arg2.closedDuration + num2,
                textIdleDuration = arg2.textIdleDuration + num3,
                backgroundIdleDuration = arg2.backgroundIdleDuration + num4
            }
        end)
    end)

    return {
        getBackgroundTimerStarted = getBackgroundTimerStarted,
        getTextTimerStarted = getTextTimerStarted,
        getOpenTimerStarted = getOpenTimerStarted,
        getClosedTimerStarted = getClosedTimerStarted,
        getPreviousChatWindowStateTimerExpired = getPreviousChatWindowStateTimerExpired,
        getCurrentChatWindowState = getCurrentChatWindowState,
        getPreviousChatWindowState = getPreviousChatWindowState,
        getDurationUpdates = getDurationUpdates,
        setBackgroundTimerStarted = setBackgroundTimerStarted,
        setTextTimerStarted = setTextTimerStarted,
        setOpenTimerStarted = setOpenTimerStarted,
        setClosedTimerStarted = setClosedTimerStarted,
        setPreviousChatWindowStateTimerExpired = setPreviousChatWindowStateTimerExpired,
        setCurrentChatWindowState = setCurrentChatWindowState,
        setPreviousChatWindowState = setPreviousChatWindowState,
        setDurationUpdates = setDurationUpdates,
        flushFinalDuration = function(num5: number?)
            if var17 then
                return var17, false
            end

            local var18 = getCurrentChatWindowState(false)
            if var18 == "unknown" then
                return getDurationUpdates(false), false
            end

            addDurationDelta(var18, num5 or os.clock())

            local var19 = getDurationUpdates(false)
            var17 = var19
            return var19, true
        end,
        newStateEffect = newStateEffect,
        changingWindowStateEffect = changingWindowStateEffect
    }
end

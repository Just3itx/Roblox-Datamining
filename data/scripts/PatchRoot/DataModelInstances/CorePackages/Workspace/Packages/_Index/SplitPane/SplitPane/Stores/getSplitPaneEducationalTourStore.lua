-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local Signals = require(SplitPaneParent.Signals)

local FFlagSplitPaneEducationalTourSkipOnDeepLink = require(script.Parent.Parent.Flags.FFlagSplitPaneEducationalTourSkipOnDeepLink)

return Signals.createComputed(function()
    local getStepIndex, setStepIndex = Signals.createSignal(0)
    local getIsOpen, setIsOpen = Signals.createSignal(false)

    local getPendingUserId, setPendingUserId = Signals.createSignal(nil)

    local tbl1 = ({})
    local var7 = nil
    local getHasShownTour, var9 = Signals.createSignal(false)
    local function setTourVisibleCallback(func1: ((...any) -> (...any))?) -- Luacid: Inlined by compiler; 2 call sites recovered
        var7 = func1
    end

    local getIsTourActive = Signals.createComputed(function(arg1): boolean
        return getStepIndex(arg1) > 0
    end)

    local getCollapsedExpandButtonRect, setCollapsedExpandButtonRect = Signals.createSignal(nil)

    local getCollapsedExpandButtonInstance, setCollapsedExpandButtonInstance = Signals.createSignal(nil)
    local function reset() -- Luacid: Inlined by compiler; 1 call site recovered
        setStepIndex(0)
    end

    return {
        getStepIndex = getStepIndex,
        setStepIndex = setStepIndex,
        getIsOpen = getIsOpen,
        setIsOpen = setIsOpen,
        getPendingUserId = getPendingUserId,
        setPendingUserId = setPendingUserId,
        hasHandledCustomPromptForUser = function(arg1): boolean
            return tbl1[arg1] == true
        end,
        setHasHandledCustomPromptForUser = function(arg1, arg2)
            tbl1[arg1] = arg2
        end,
        setOnTourVisible = setTourVisibleCallback,
        notifyTourVisible = function()
            if FFlagSplitPaneEducationalTourSkipOnDeepLink then
                var9(true)
            end
            local var14 = var7
            var7 = nil
            if var14 ~= nil then
                var14()
            end
        end,
        clearOnTourVisible = function()
            setTourVisibleCallback(nil)
        end,
        getHasShownTour = getHasShownTour,
        discardPendingTour = function()
            if FFlagSplitPaneEducationalTourSkipOnDeepLink then
                var9(false)
            end
            setIsOpen(false)
            setPendingUserId(nil)
            setTourVisibleCallback(nil)
            reset()
        end,
        getIsTourActive = getIsTourActive,
        getCollapsedExpandButtonRect = getCollapsedExpandButtonRect,
        setCollapsedExpandButtonRect = setCollapsedExpandButtonRect,
        getCollapsedExpandButtonInstance = getCollapsedExpandButtonInstance,
        setCollapsedExpandButtonInstance = setCollapsedExpandButtonInstance,
        reset = reset
    }
end)

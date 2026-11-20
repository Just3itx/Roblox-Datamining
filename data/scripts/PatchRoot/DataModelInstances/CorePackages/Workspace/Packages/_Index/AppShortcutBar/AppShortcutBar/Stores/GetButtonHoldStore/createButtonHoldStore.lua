-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppShortcutBarParent = script:FindFirstAncestor("AppShortcutBar").Parent

local React = require(AppShortcutBarParent.React)
local Signals = require(AppShortcutBarParent.Signals)
local SignalsReact = require(AppShortcutBarParent.SignalsReact)
local _FocusNavigationUtils = require(AppShortcutBarParent.FocusNavigationUtils)

local function createButtonHoldStore()
    local getButtonHoldState, setButtonHoldState = Signals.createSignal({})

    local function updateButtonHoldState(arg1, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
        setButtonHoldState(function(arg3)
            if arg3[arg1] == arg2 then
                return arg3
            end

            local var3 = table.clone(arg3)
            var3[arg1] = arg2
            return var3
        end)
    end

    return {
        getButtonHoldState = getButtonHoldState,
        setButtonHoldState = setButtonHoldState,
        useDispatchButtonHoldStarted = function()
            return (React.useCallback(function(arg1, arg2)
                updateButtonHoldState(arg1, arg2)
            end, { updateButtonHoldState }))
        end,
        useDispatchButtonHoldEnded = function()
            return (React.useCallback(function(arg1)
                updateButtonHoldState(arg1, nil)
            end, { updateButtonHoldState }))
        end,
        useHeldProgressByEvent = function()
            return SignalsReact.useSignalState(getButtonHoldState)
        end
    }
end
return createButtonHoldStore

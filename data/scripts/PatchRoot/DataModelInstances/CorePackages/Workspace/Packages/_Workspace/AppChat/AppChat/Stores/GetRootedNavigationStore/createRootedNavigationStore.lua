-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Signals = require(AppChatParent.Signals)

local function createRootedNavigationStore()
    local getIsNavigationPending, var2 = Signals.createSignal(false)
    local num1 = 0
    local var3 = nil

    local function cancelNavigation() -- Luacid: Inlined by compiler; 1 call site recovered
        var3 = nil
        var2(false)
    end

    return {
        getIsNavigationPending = getIsNavigationPending,
        beginNavigation = function(): number
            num1 += 1
            var3 = num1
            var2(true)
            return num1
        end,
        completeNavigation = function(num2: number?)
            if getIsNavigationPending(false) and num2 == var3 then
                cancelNavigation()
            end
        end,
        cancelNavigation = cancelNavigation,
        reset = cancelNavigation
    }
end

return createRootedNavigationStore

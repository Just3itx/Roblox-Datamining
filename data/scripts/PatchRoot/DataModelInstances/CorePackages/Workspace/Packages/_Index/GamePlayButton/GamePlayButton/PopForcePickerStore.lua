-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButtonParent = script:FindFirstAncestor("GamePlayButton").Parent

local Signals = require(GamePlayButtonParent.Signals)

local function createStore(func1: (...any) -> (...any))
    local getSelection, var2 = Signals.createSignal("")
    local getSupported, var4 = Signals.createSignal(false)
    local var5 = nil

    local function refresh()
        local success, result, result2 = pcall(function()
            local var6 = func1()
            if not var6 or type(var6.SetForcedPop) ~= "function" then
                return nil, nil
            end
            return var6, var6:GetForcedPop()
        end)

        if success and type(result2) == "string" then
            var5 = result
            var2(result2)
            var4(true)
            return
        end
        var5 = nil
        var4(false)
    end

    return {
        getSelection = getSelection,
        getSupported = getSupported,
        refresh = refresh,
        select = function(str1: string)
            if not var5 then
                refresh()
            end
            if not var5 then
                return false
            end

            local success = pcall(function()
                var5:SetForcedPop(str1)
            end)

            refresh()
            return success and getSupported(false) and getSelection(false) == str1
        end,
        getSnapshot = function(): {[any]: any}?
            local success, result = pcall(function()
                return var5:GetSnapshot()
            end)
            return if success and type(result) == "table" then result else nil
        end
    }
end
return {
    createStore = createStore,
    getStore = Signals.createComputed(function()
        return (createStore(function(): PopLatencyService
            return game:GetService("PopLatencyService")
        end))
    end)
}

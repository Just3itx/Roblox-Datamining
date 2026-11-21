-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DictationCoreParent = script:FindFirstAncestor("DictationCore").Parent

local Signals = require(DictationCoreParent.Signals)

local function createMicStore()
    local getHolderId, var2 = Signals.createSignal(nil)

    local var3 = nil
    local num1 = 0

    return {
        getHolderId = getHolderId,
        createHolderId = function(): number
            num1 += 1
            return num1
        end,
        hold = function(num2: number, func1: (...any) -> (...any)): boolean
            local var4 = getHolderId(false)
            if var4 ~= nil and var4 ~= num2 then
                return false
            end
            var3 = func1
            if var4 == nil then
                var2(num2)
            end
            return true
        end,
        steal = function(num2: number, func1: (...any) -> (...any))
            local var4 = getHolderId(false)
            local var5 = var3
            var3 = func1
            if var4 == num2 then
                return
            end

            var2(num2)
            if var4 ~= nil and var5 ~= nil then
                var5()
            end
        end,
        drop = function(num2: number)
            if getHolderId(false) ~= num2 then
                return
            end
            var3 = nil
            var2(nil)
        end,
        reset = function()
            var3 = nil
            var2(nil)
        end
    }
end
return createMicStore

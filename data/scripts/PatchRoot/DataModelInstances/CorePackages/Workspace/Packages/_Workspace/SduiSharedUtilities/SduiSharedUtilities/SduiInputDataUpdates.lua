-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")

local getSduiApiStore = require(SduiSharedUtilities.getSduiApiStore)

local module = {}

function module.findInputData(str1: string, func1: (...any) -> (...any))
    local var1 = nil
    getSduiApiStore().forEachInputData(str1, function(_, arg1): boolean
        if not func1(arg1) then
            return false
        end

        var1 = arg1
        return true
    end)
    return var1
end

function module.updateInputDataField(str1: string, func1: (...any) -> (...any), str2: string, func2: (...any) -> (...any)): boolean
    local sduiApiStore = getSduiApiStore()
    local bool1 = false
    sduiApiStore.forEachInputData(str1, function(arg1, arg2): boolean
        if not func1(arg2) then
            return false
        end
        local var1 = arg2[str2]
        if var1 ~= nil then
            bool1 = sduiApiStore.setInputDataField(str1, arg1, str2, func2(var1))
        end
        return true
    end)
    return bool1
end

return module

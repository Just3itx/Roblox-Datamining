-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilitiesParent = script:FindFirstAncestor("SduiSharedUtilities").Parent

local AppCommonLib = require(SduiSharedUtilitiesParent.AppCommonLib)

local function createSduiFocusActivationStore()
    local var1 = (setmetatable({}, { __mode = "v" }))

    return {
        register = function(str1: string, func1: (...any) -> (...any))
            local var2 = var1[str1]
            if var2 == nil then
                var2 = AppCommonLib.Signal.new()
                var1[str1] = var2
            end
            local connection = var2:connect(func1)
            return function()
                connection.disconnect()
            end
        end,
        activate = function(str1: string)
            local var2 = var1[str1]
            if var2 then
                var2:fire()
            end
        end
    }
end

return createSduiFocusActivationStore

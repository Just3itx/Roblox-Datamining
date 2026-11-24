-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local scriptParentParentParent = scriptParentParent.Parent
local Signals = require(scriptParentParentParent.Signals)
local _InternalHttpStore = require(scriptParentParentParent.InternalHttpStore)
local _Types = require(scriptParentParent.Types)

local function createErrorStatusHandler(arg1)
    return function(arg2)
        return Signals.createComputed(function(arg3)
            local var1 = arg2(arg3)
            if var1.status == "Success" then
                local statusCode = var1.response.StatusCode
                if arg1[statusCode] ~= nil then
                    arg1[statusCode](var1)
                end
            end

            return var1
        end)
    end
end

return createErrorStatusHandler

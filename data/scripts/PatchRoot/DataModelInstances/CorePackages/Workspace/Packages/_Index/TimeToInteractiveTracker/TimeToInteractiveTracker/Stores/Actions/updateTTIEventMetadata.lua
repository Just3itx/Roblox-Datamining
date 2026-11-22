-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TimeToInteractiveTracker = script:FindFirstAncestor("TimeToInteractiveTracker")

local var1 = require(TimeToInteractiveTracker.Logger):new(script.Name)

local _types = require(script.Parent.Parent.types)

local mergeTTIEventMetadata = require(script.Parent.Parent.Parent.Utils.mergeTTIEventMetadata)

return function(callback)
    return function(str1: string, arg1)
        callback(function(arg2)
            local var2 = arg2[str1]
            if var2 == nil then
                var1:warning(`called before trackStart for eventName={str1}`)
                return arg2
            end

            local var3 = table.clone(arg2)

            local var4 = table.clone(var2)
            var4.metadata = mergeTTIEventMetadata(var2.metadata, arg1)
            var3[str1] = var4

            return var3
        end)
    end
end

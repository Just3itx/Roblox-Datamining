-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local SignalsExperimental = require(scriptParentParent.SignalsExperimental)
local SharedFlags = require(scriptParentParent.SharedFlags)
local ActionHandlers = require(script.Parent.ActionHandlers)

local FFlagSignalsRegistryOwnedFanout = SharedFlags.FFlagSignalsRegistryOwnedFanout

local function createSignalsMiddleware(arg1)
    return function(arg2, _)
        return function(arg3)
            if FFlagSignalsRegistryOwnedFanout then
                local var1 = nil
                SignalsExperimental.batch(function()
                    ActionHandlers.handleAction(arg1, arg3)

                    var1 = arg2(arg3)
                end)
                return var1
            end

            local var1 = arg1[arg3.type]

            if not (var1 and #var1 > 0) then
                return arg2(arg3)
            end

            SignalsExperimental.batch(function()
                local bool1 = true
                for _, value in var1 do
                    bool1 = value(arg3) and bool1
                end

                if not bool1 then
                    return arg2(arg3)
                end
                return nil
            end)
            return nil
        end
    end
end

return createSignalsMiddleware

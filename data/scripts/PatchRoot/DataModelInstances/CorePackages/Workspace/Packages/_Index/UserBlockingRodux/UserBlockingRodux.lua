-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local script2 = script
local script2Parent = script2.Parent
local Cryo = require(script2Parent.Cryo)
local RoduxNetworking = require(script2Parent.RoduxNetworking)
local UserBlockingNetworking = require(script2Parent.UserBlockingNetworking)

local UserBlockingReducer = require(script2.Reducers.UserBlockingReducer)

local module = {
    ["jest.config"] = script["jest.config"]
}

function module.config(arg1)
    local var1 = Cryo.Dictionary.join(
        arg1,
        {
            userBlockingNetworking = UserBlockingNetworking.config({ roduxNetworking = RoduxNetworking.mock() })
        }
    )

    return {
        installReducer = function()
            return UserBlockingReducer(var1)
        end
    }
end

return module

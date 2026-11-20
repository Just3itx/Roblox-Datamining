-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:01:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxNetworking = require(script.RoduxNetworking)
local NetworkStatus = require(script.NetworkStatus)
local mockRoduxNetworking = require(script.mockRoduxNetworking)
local _Types = require(script.Types)

return {
    config = function(arg1)
        local var1 = RoduxNetworking(arg1)
        local var2 = NetworkStatus(arg1)

        return {
            GET = function(arg2, arg3)
                return var1.GET(arg2, arg3)
            end,
            POST = function(arg2, arg3)
                return var1.POST(arg2, arg3)
            end,
            PATCH = function(arg2, arg3)
                return var1.PATCH(arg2, arg3)
            end,
            DELETE = function(arg2, arg3)
                return var1.DELETE(arg2, arg3)
            end,
            getNetworkImpl = function()
                return var1.getNetworkImpl()
            end,
            setNetworkImpl = function(...)
                var1.setNetworkImpl(...)
            end,
            installReducer = var2.installReducer,
            Enum = {
                NetworkStatus = var2.Enum.Status
            }
        }
    end,
    mock = mockRoduxNetworking
}

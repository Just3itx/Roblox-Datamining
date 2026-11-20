-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GET = require(script.Parent.GET)
local POST = require(script.Parent.POST)
local PATCH = require(script.Parent.PATCH)
local DELETE = require(script.Parent.DELETE)
local _Types = require(script.Parent.Types)

return function(arg1)
    assert(arg1, "Expected options to be passed into RoduxNetworking")
    assert(arg1.keyPath, "Expected options.keyPath to be passed into RoduxNetworking")
    assert(arg1.networkImpl, "Expected options.networkImpl to be passed into RoduxNetworking")

    return {
        GET = function(arg2, arg3)
            assert(arg2, "RoduxNetworking:GET expects moduleScript argument")
            assert(arg2, "RoduxNetworking:GET expects constructBuilderFunction argument")
            return GET(arg1)(arg2, arg3)
        end,
        POST = function(arg2, arg3)
            return POST(arg1)(arg2, arg3)
        end,
        PATCH = function(arg2, arg3)
            return PATCH(arg1)(arg2, arg3)
        end,
        DELETE = function(arg2, arg3)
            return DELETE(arg1)(arg2, arg3)
        end,
        getNetworkImpl = function()
            return arg1.networkImpl
        end,
        setNetworkImpl = function(networkImpl)
            arg1.networkImpl = networkImpl
        end
    }
end

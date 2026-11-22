-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:10:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SQUAD_URL = require(script.Parent.Parent.SQUAD_URL)
local _networkingSquadTypes = require(script.Parent.Parent.networkingSquadTypes)

return function(arg1)
    return (arg1.roduxNetworking.POST("SetRegroupPromptShown", function(arg2, arg3)
        return arg2(SQUAD_URL):path("group-up"):path("v1"):path("set-regroup-prompt-shown"):body({ groupUpId = arg3.groupUpId })
    end))
end

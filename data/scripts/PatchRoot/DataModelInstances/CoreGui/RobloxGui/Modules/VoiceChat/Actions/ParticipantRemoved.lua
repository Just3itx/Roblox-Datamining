-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local makeActionCreator = require(CorePackages.Packages.Rodux).makeActionCreator
local _t = require(CorePackages.Packages.t)
local maybeAssert = require(RobloxGui.Modules.VoiceChat.Helpers.maybeAssert)

return makeActionCreator(script.Name, function(arg1)
    maybeAssert(tonumber(arg1) ~= nil)

    return {
        userId = tostring(arg1)
    }
end)

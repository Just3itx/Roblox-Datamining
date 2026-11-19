-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local t = require(CorePackages.Packages.t)

local Types = require(script.Parent.Parent.Types)
local maybeAssert = require(script.Parent.maybeAssert)

local _Flags = script.Parent.Parent.Parent.Parent.Flags

local function getSettingsForMessage(arg1, arg2)
    maybeAssert(Types.IChatSettings(arg1))
    maybeAssert(t.optional(Types.IMessage)(arg2))

    local userSpecificSettings = arg1.UserSpecificSettings
    if not (userSpecificSettings and arg2) then
        return arg1
    end

    local userSpecificSetting = userSpecificSettings[arg2.userId]
    if not userSpecificSetting and arg2.adornee then
        userSpecificSetting = userSpecificSettings[arg2.adornee:GetFullName()]
    end

    return userSpecificSetting or arg1
end

return getSettingsForMessage

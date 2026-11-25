-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local _Enums = require(ProfilePlatform.Common.Enums)
local React = require(ProfilePlatformParent.React)

local HttpService = game:GetService("HttpService")

return function(arg1)
    return React.useMemo(function(): string
        return `ProfilePlatform_${arg1}_${HttpService:GenerateGUID()}`
    end, { arg1 })
end

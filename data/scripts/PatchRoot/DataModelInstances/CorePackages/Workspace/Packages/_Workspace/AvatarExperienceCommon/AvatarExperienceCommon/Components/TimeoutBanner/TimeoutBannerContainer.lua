-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local React = require(AvatarExperienceCommonParent.React)
local useTimeoutBannerProps = require(script.Parent.useTimeoutBannerProps)
local TimeoutBanner = require(script.Parent.TimeoutBanner)

return React.memo(function(arg1) -- name: TimeoutBannerContainer
    local var1 = useTimeoutBannerProps(arg1)
    return React.createElement(TimeoutBanner, var1)
end)

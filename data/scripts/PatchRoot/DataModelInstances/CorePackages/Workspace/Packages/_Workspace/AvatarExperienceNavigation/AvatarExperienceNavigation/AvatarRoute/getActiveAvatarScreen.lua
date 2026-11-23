-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceNavigation = script:FindFirstAncestor("AvatarExperienceNavigation")
local AvatarScreenProperties = require(AvatarExperienceNavigation.AvatarRoute.AvatarScreenProperties)

local function getActiveAvatarScreen(arg1)
    if not arg1 then
        return nil
    end

    while arg1 and arg1.routes do
        local var1 = arg1.routes[arg1.index]
        if var1 == nil or not AvatarScreenProperties[var1.routeName] then
            break
        end

        arg1 = var1
    end

    return arg1
end

return getActiveAvatarScreen

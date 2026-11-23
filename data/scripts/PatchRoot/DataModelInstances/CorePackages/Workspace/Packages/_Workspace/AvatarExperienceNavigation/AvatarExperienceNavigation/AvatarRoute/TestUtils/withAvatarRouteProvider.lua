-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceNavigation = script:FindFirstAncestor("AvatarExperienceNavigation")
local AvatarExperienceNavigationParent = AvatarExperienceNavigation.Parent
local React = require(AvatarExperienceNavigationParent.React)
local _Types = require(AvatarExperienceNavigation.AvatarRoute.Types)
local AvatarScreen = require(AvatarExperienceNavigation.Enums.AvatarScreen)
local AvatarRouteContext = require(AvatarExperienceNavigation.AvatarRoute.Context.AvatarRouteContext)
local AvatarRoute = require(AvatarExperienceNavigation.AvatarRoute.AvatarRoute)

local function avatarRouteFromString(str1: string)
    local tbl1 = {
        name = str1,
        key = str1,
        params = {}
    }
    return AvatarRoute.new({ current = tbl1, previousPages = { tbl1 }, opaque = tbl1, isVisible = true, isOverlayVisible = false })
end

local function avatarRouteFromTable(arg1)
    arg1 = arg1 or {}
    local current = arg1.current or {}
    local previous = arg1.previous or {}
    local opaque = arg1.opaque or {}
    local name = current.name or AvatarScreen.None
    local var1 = previous.name or AvatarScreen.None
    local var2 = opaque.name or AvatarScreen.None
    return AvatarRoute.new({
        current = {
            name = name,
            key = current.key or name,
            params = current.params or {}
        },
        previousPages = {{
            name = var1,
            key = previous.key or var1,
            params = previous.params or {}
        }},
        opaque = {
            name = var2,
            key = opaque.key or var2,
            params = opaque.params or {}
        },
        isVisible = arg1.isVisible ~= false,
        isOverlayVisible = arg1.isOverlayVisible == true
    })
end

return function(arg1, arg2)
    local value = if type(arg2) == "string" then avatarRouteFromString(arg2) else avatarRouteFromTable(arg2)

    return React.forwardRef(function(arg3, ref)
        local var2 = table.clone(arg3)
        var2.ref = ref
        return React.createElement(AvatarRouteContext.Provider, { value = value }, { component = React.createElement(arg1, var2) })
    end)
end

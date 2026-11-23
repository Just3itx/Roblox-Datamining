-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceNavigation = script:FindFirstAncestor("AvatarExperienceNavigation")
local AvatarExperienceNavigationParent = AvatarExperienceNavigation.Parent
local tutils = require(AvatarExperienceNavigationParent.tutils)
local t = require(AvatarExperienceNavigationParent.t)

local AvatarScreen = require(AvatarExperienceNavigation.Enums.AvatarScreen)
local _Types = require(script.Parent.Types)

local module = {}
module.__index = module

module.Interface = t.strictInterface({ name = t.string, key = t.string, params = t.table })

function module.new(name: string, key: string, params)
    local tbl1 = {
        name = name,
        key = key,
        params = params or {}
    }
    setmetatable(tbl1, module)
    return tbl1
end

module.EMPTY = module.new(AvatarScreen.None, AvatarScreen.None)

function module:__tostring()
    return string.format("%s(key=%s)", self.name, tostring(self.key))
end

function module:__eq(arg1): boolean
    if rawequal(self, arg1) then
        return true
    end

    return self.key == arg1.key and self.name == arg1.name and tutils.shallowEqual(self.params, arg1.params, nil)
end

return module

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceNavigationParent = script:FindFirstAncestor("AvatarExperienceNavigation").Parent
local t = require(AvatarExperienceNavigationParent.t)
local RouteInfo = require(script.Parent.RouteInfo)
local _Types = require(script.Parent.Types)

local module = {}
module.__index = module
module.maxPreviousCount = 2

module.Interface = t.strictInterface({
    current = RouteInfo.Interface,
    previousPages = t.optional(t.array(RouteInfo.Interface)),
    opaque = RouteInfo.Interface,
    isVisible = t.boolean,
    isOverlayVisible = t.boolean
})

function module.new(arg1)
    local tbl1 = {
        current = arg1.current or RouteInfo.EMPTY,
        previousPages = arg1.previousPages or {},
        opaque = arg1.opaque or RouteInfo.EMPTY,
        isVisible = arg1.isVisible or false,
        isOverlayVisible = arg1.isOverlayVisible or false
    }
    setmetatable(tbl1, module)
    return tbl1
end

function module:__tostring(): string
    local current = self.current
    local opaque = self.opaque
    local str1 = (("AvatarRoute[" .. (if self.isVisible then "Visible" else "Not Visible")) .. (if self.isOverlayVisible then " *Overlay" else "")) .. ", " .. tostring(current)
    if current.name ~= opaque.name then
        str1 ..= ", opaque: " .. tostring(opaque)
    end
    return str1 .. "]"
end

function module:__eq(arg1): boolean
    if not (self and arg1) then
        return false
    end

    if rawequal(self, arg1) then
        return true
    end

    return self.isVisible == arg1.isVisible
        and self.isOverlayVisible == arg1.isOverlayVisible
        and self.current == arg1.current
        and self.opaque == arg1.opaque
end

return module

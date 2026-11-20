-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local FoundationParent = Foundation.Parent
local React = require(FoundationParent.React)
local ReactIs = require(FoundationParent.ReactIs)

local _Types = require(Foundation.Components.Types)

local function getOriginalBackgroundStyle(color3, transparency)
    if ReactIs.isBinding(color3) and ReactIs.isBinding(transparency) then
        return React.joinBindings({ Color3 = color3, Transparency = transparency })
    elseif ReactIs.isBinding(color3) then
        return color3:map(function(color3_2)
            return { Color3 = color3_2, Transparency = transparency }
        end)
    elseif ReactIs.isBinding(transparency) then
        return transparency:map(function(transparency2)
            return { Color3 = color3, Transparency = transparency2 }
        end)
    end
    return { Color3 = color3, Transparency = transparency }
end

return getOriginalBackgroundStyle

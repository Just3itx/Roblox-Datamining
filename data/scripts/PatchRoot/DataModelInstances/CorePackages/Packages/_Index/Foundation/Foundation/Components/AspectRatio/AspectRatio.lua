-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:11:11Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)
local ReactIs = require(FoundationParent.ReactIs)

local getTestIdTag = require(Foundation.Utility.getTestIdTag)

local _Types = require(Foundation.Components.Types)

local function getAspectRatio(aspectRatio)
    if ReactIs.isBinding(aspectRatio) or typeof(aspectRatio) == "number" then
        return { AspectRatio = aspectRatio, AspectType = nil, DominantAxis = nil }
    end

    return {
        AspectRatio = aspectRatio.AspectRatio,
        AspectType = aspectRatio.AspectType,
        DominantAxis = aspectRatio.DominantAxis
    }
end

return React.memo(function(tbl1) -- name: AspectRatio
    local aspectRatio = getAspectRatio(tbl1.value)
    return React.createElement("UIAspectRatioConstraint", {
        AspectRatio = aspectRatio.AspectRatio,
        AspectType = aspectRatio.AspectType,
        DominantAxis = aspectRatio.DominantAxis,
        [React.Tag] = getTestIdTag(tbl1.testId)
    })
end)

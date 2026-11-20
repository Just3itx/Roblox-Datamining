-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local _Types = require(Foundation.Components.Types)

local FoundationImages = require(FoundationParent.FoundationImages)

local function getScaledSlice(rect: Rect?, scale: number?)
    local resolutionScale = FoundationImages.getResolutionScale()

    if rect then
        local min = rect.Min * resolutionScale
        local max = rect.Max * resolutionScale
        rect = Rect.new(min, max)
        scale = (scale or 1) / resolutionScale
    end

    return { center = rect, scale = scale }
end

return getScaledSlice

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:11:18Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Dash = require(FoundationParent.Dash)
local FoundationImages = require(FoundationParent.FoundationImages)
local Images = FoundationImages.Images
local isBuilderIcon = require(Foundation.Utility.isBuilderIcon)

local IconSize = require(Foundation.Enums.IconSize)

local tbl1 = {
    [IconSize.Small] = { Vector2.new(16, 16), Vector2.new(18, 18) },
    [IconSize.Medium] = { Vector2.new(28, 28), Vector2.new(36, 36) },
    [IconSize.Large] = { Vector2.new(48, 48) }
}

local resolutionScale = FoundationImages.getResolutionScale()

local tbl2 = {
    Small = {
        [IconSize.XSmall] = 0.66667,
        [IconSize.Small] = 0.88889,
        [IconSize.Medium] = 1.11111,
        [IconSize.Large] = 1.33333
    },
    Medium = {
        [IconSize.XSmall] = 0.45,
        [IconSize.Small] = 0.600003,
        [IconSize.Medium] = 0.749997,
        [IconSize.Large] = 0.9
    },
    Large = {
        [IconSize.XSmall] = 0.24545699999999998,
        [IconSize.Small] = 0.327276,
        [IconSize.Medium] = 0.40909500000000004,
        [IconSize.Large] = 0.490905
    }
}

local function useIcon(str1: string?, arg1)
    if not str1 or isBuilderIcon(str1) then
        return nil, 1
    end

    local var1 = Images[str1]
    if not var1 then
        return nil, 1
    end

    local vector2 = Vector2.new(var1.ImageRectSize.X / resolutionScale, var1.ImageRectSize.Y / resolutionScale)

    local medium = IconSize.Medium
    if Dash.includes(tbl1[IconSize.Small], vector2) then
        medium = IconSize.Small
    elseif Dash.includes(tbl1[IconSize.Medium], vector2) then
        medium = IconSize.Medium
    elseif Dash.includes(tbl1[IconSize.Large], vector2) then
        medium = IconSize.Large
    end

    return vector2, tbl2[medium][arg1]
end

return useIcon

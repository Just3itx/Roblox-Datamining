-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:30:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent
local ImageSet = require(AppBloxParent.UIBlox).App.ImageSet
local IconSize = ImageSet.Enum.IconSize
local getIconSize = ImageSet.getIconSize

local calcMediaGallerySizesFromWidth = require(script.Parent.calcMediaGallerySizesFromWidth)

local iconSize = getIconSize(IconSize.Medium)

function calcMediaGallerySizesFromHeight(num1: number, num2: number, bool1: boolean?)
    local num3 = math.floor(
        (math.floor((num1 - 24) * (16 / 9) * num2) + (num2 - 1) * 12 + iconSize * 2 + iconSize * 2 * num2) / (num2 + 1)
    )

    return calcMediaGallerySizesFromWidth(num3, num2, bool1)
end

return calcMediaGallerySizesFromHeight

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:30:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent
local ImageSet = require(AppBloxParent.UIBlox).App.ImageSet
local IconSize = ImageSet.Enum.IconSize
local iconSize = ImageSet.getIconSize(IconSize.Medium)

function calcMediaGallerySizesFromWidth(xOffset: number, num1: number, bool1: boolean?)
    local xOffset2 = if bool1 then xOffset else xOffset - iconSize * 2
    local yOffset = math.floor(xOffset2 / (16 / 9))
    local xOffset3 = if bool1 then math.floor((xOffset - (num1 - 1) * 12) / num1) else math.floor((xOffset - (num1 - 1) * 12 - iconSize * 2) / num1)
    local xOffset4 = if bool1 then xOffset + iconSize * 2 else xOffset
    local yOffset2 = math.floor(xOffset3 / (16 / 9))
    local yOffset3 = yOffset + yOffset2 + 24

    return {
        contentSize = UDim2.fromOffset(xOffset, yOffset3),
        previewSize = UDim2.fromOffset(xOffset2, yOffset),
        paginationSize = UDim2.fromOffset(xOffset4, yOffset2),
        thumbnailSize = UDim2.fromOffset(xOffset3, yOffset2)
    }
end

return calcMediaGallerySizesFromWidth

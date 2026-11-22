-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:10:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GetImageSetData = require(script.Parent.GetImageSetData)
local GetImageSetPathPattern = require(script.Parent.GetImageSetPathPattern)
local Images = require(script.Parent.Parent.FoundationImages).Images

local _types = require(script.Parent.types)

local function GetImageData(str1: string, num1: number?)
    local var1 = GetImageSetData(num1 or Images.ImagesResolutionScale)[str1]

    if var1 == nil then
        return nil
    end

    return {
        Image = GetImageSetPathPattern(var1.ImageSet),
        ImageRectSize = var1.ImageRectSize,
        ImageRectOffset = var1.ImageRectOffset
    }
end

return GetImageData

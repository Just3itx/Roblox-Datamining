-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local GetImageSetData = require(scriptParent.Generated.GetImageSetData)
local FallbackImages = require(scriptParent.Generated.FallbackImages)

local _ImagesTypes = require(scriptParent.ImagesTypes)
local getResolutionScale = require(scriptParent.getResolutionScale)

local CorePackages = game:GetService("CorePackages")
local var1, var2 = GetImageSetData((getResolutionScale()))

local scriptParentParent = scriptParent.Parent
local uiblox = require(scriptParentParent.BuilderIcons).Migration.uiblox
local whitelistedIconAssets = require(scriptParent.whitelistedIconAssets)

local function getStaticLuaAppsPackageDir(): string? -- Luacid: Inlined by compiler; 1 call site recovered
    return if CorePackages == nil then nil else "LuaPackages/Packages/_Index/FoundationImages/FoundationImages"
end

local function getImagePath(str1: string?, str2: string) -- Luacid: Inlined by compiler; 1 call site recovered
    if str1 == nil then
        return FallbackImages[str2]
    end
    return string.format("rbxasset://%s/SpriteSheets/%s.png", str1, str2)
end

local staticLuaAppsPackageDir = getStaticLuaAppsPackageDir()
local tbl1 = ({})

for value, value2 in var1 do
    if whitelistedIconAssets[value] == nil and uiblox[value] then
        continue
    end

    assert(typeof(value2) == "table", "invalid sourceData from GetImageSetData for scale " .. tostring(var2))
    local tbl2 = {}
    for value3, value4 in value2 do
        if value3 == "ImageSet" then
            tbl2.Image = if staticLuaAppsPackageDir == nil then getImagePath(nil, value4) else string.format("rbxasset://%s/SpriteSheets/%s.png", staticLuaAppsPackageDir, value4)
        else
            tbl2[value3] = value4
        end
    end
    tbl1[value] = tbl2
end

setmetatable(tbl1, {
    __index = function(arg1, image)
        if not uiblox[image] then
            error(("%q is not a valid member of Images"):format(tostring(image)), 2)
            return
        end

        local tbl2 = {
            ImageRectOffset = Vector2.new(0, 0),
            ImageRectSize = Vector2.new(0, 0),
            Image = image
        }
        arg1[image] = tbl2
        return tbl2
    end
})

return tbl1

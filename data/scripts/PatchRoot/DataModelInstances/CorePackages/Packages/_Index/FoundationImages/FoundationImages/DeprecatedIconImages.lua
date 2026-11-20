-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParent = script.Parent

local GetDeprecatedIconImageSetData = require(scriptParent.Deprecated.GetDeprecatedIconImageSetData)
local StaticFallbackImages = require(scriptParent.Deprecated.StaticFallbackImages)

local deprecatedIconImageSetData = GetDeprecatedIconImageSetData((require(scriptParent.getResolutionScale)()))

local scriptParentParent = scriptParent.Parent
local uiblox = require(scriptParentParent.BuilderIcons).Migration.uiblox
local whitelistedIconAssets = require(scriptParent.whitelistedIconAssets)

local tbl1 = ({})

for value, value2 in deprecatedIconImageSetData do
    if not uiblox[value] or whitelistedIconAssets[value] ~= nil then
        continue
    end

    local tbl2 = {}
    for value3, value4 in value2 do
        if value3 == "ImageSet" then
            tbl2.Image = StaticFallbackImages[value4]
        else
            tbl2[value3] = value4
        end
    end
    tbl1[value] = tbl2
end

return tbl1

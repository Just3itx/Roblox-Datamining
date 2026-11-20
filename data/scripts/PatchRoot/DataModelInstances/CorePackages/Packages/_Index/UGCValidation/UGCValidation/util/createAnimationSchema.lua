-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:20:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Constants = require(scriptParentParent.Constants)

local function createAnimationEntry(bool1: boolean?, bool2: boolean?)
    local tbl1 = { ClassName = "Animation" }

    if bool1 then
        tbl1._optional = true
    end
    if bool2 then
        tbl1._children = {{ Name = "Weight", ClassName = "NumberValue", _optional = true }}
    end

    return tbl1
end

local function createStringValueWithAnimations(str1: string, num1: number, bool1: boolean?)
    local _children = {}
    table.insert(_children, (createAnimationEntry(false, bool1)))

    if num1 > 1 then
        table.insert(_children, (createAnimationEntry(true, bool1)))
    end

    return { Name = str1, ClassName = "StringValue", _children = _children }
end

local function createAnimationSchema(assetType)
    local var1 = Constants.ANIMATION_ASSET_INFO[assetType]
    assert(var1, `No ANIMATION_ASSET_INFO for {assetType}`)

    local _children = {}

    if assetType == Enum.AssetType.IdleAnimation then
        table.insert(_children, (createStringValueWithAnimations("idle", 2, true)))
    else
        for _, value in var1.stringValueNames do
            local tbl1 = {}
            table.insert(tbl1, { ClassName = "Animation" })

            table.insert(_children, { Name = value, ClassName = "StringValue", _children = tbl1 })
        end
    end

    return { Name = "R15Anim", ClassName = "Folder", _children = _children }
end

return createAnimationSchema

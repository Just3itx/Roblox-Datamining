-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxGamesParent = script:FindFirstAncestor("RoduxGames").Parent

local t = require(RoduxGamesParent.t)

local module = {}

function module.new<T>(tbl1): T
    assert(module.isValid(tbl1))

    module.__index = module

    setmetatable(tbl1, module)

    return tbl1
end

function module.mock(arg1)
    arg1 = arg1 or {}

    return (module.new({
        assetTypeId = arg1.assetTypeId or 1,
        assetType = arg1.assetType or "Image",
        imageId = arg1.imageId or 1234567890,
        approved = arg1.approved or false
    }))
end

function module.format(tbl1)
    return (module.new({
        assetTypeId = tbl1.assetTypeId,
        assetType = tbl1.assetType,
        imageId = tbl1.imageId,
        videoHash = tbl1.videoHash,
        videoTitle = tbl1.videoTitle,
        approved = if tbl1.approved then tbl1.approved else false,
        altText = tbl1.altText
    }))
end
module.isValid = t.strictInterface({
    assetTypeId = t.optional(t.number),
    assetType = t.string,
    imageId = t.optional(t.number),
    videoHash = t.optional(t.string),
    videoTitle = t.optional(t.string),
    approved = t.boolean,
    altText = t.optional(t.string)
})

return module

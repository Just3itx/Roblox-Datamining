-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.mock(imageId: number?)
    return {
        assetTypeId = -1,
        assetType = "Image",
        imageId = imageId or 123456789,
        videoHash = nil,
        videoTitle = nil,
        approved = true,
        altText = "Alt Text"
    }
end

return module

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local THUMBNAILS_URL = require(scriptParentParentParent.Http).Url.THUMBNAILS_URL

return function(tbl1)
    return tbl1.roduxNetworking.POST("GetThumbnailByAssetId", function(arg1, tbl2)
        return arg1(THUMBNAILS_URL):path("v1"):path("batch"):body(
            {{
                targetId = tbl2.assetId,
                type = tbl2.assetType,
                size = tbl2.size
            }}
        )
    end)
end

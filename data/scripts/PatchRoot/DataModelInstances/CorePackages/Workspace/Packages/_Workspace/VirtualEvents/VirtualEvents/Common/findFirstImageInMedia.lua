-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:00:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local _GraphQLServer = require(VirtualEvents.Parent.GraphQLServer)

local function findFirstImageInMedia(tbl1)
    for _, value in tbl1 do
        if value.assetType == "Image" and value.imageId then
            return ("rbxassetid://%s"):format(value.imageId)
        end
    end
    return nil
end

return findFirstImageInMedia

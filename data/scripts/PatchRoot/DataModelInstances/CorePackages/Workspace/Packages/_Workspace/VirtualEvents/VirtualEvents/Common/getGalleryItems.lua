-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:00:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local _GraphQLServer = require(VirtualEvents.Parent.GraphQLServer)
local constants = require(VirtualEvents.constants)

local _AppBlox = require(VirtualEvents.Parent.AppBlox)

local FFlagLuaAppLimitEventThumbnailToOne = require(VirtualEvents.Flags.FFlagLuaAppLimitEventThumbnailToOne)

local function getGalleryItems(tbl1): {[any]: any} | {any} | {{imageId: any, isYouTubeVideo: boolean}}
    local tbl2 = {}

    if tbl1 then
        for _, value in tbl1 do
            if value.assetType == "Image" and value.imageId then
                table.insert(tbl2, { imageId = ("rbxassetid://%s"):format(value.imageId), isYouTubeVideo = false })
            end
        end
    end

    return if #tbl2 > 0 then if FFlagLuaAppLimitEventThumbnailToOne then { tbl2[1] } else tbl2 else {{
        imageId = constants.DEFAULT_EVENT_THUMBNAIL,
        isYouTubeVideo = false
    }}
end

return getGalleryItems

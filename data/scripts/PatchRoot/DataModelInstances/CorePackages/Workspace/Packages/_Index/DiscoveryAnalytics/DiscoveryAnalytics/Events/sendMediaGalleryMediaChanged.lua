-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local function sendMediaGalleryMediaChanged(tbl1, str1: string, tbl2, universeId: string?, autoAdvance: boolean?, isYouTubeVideo: boolean?, placeId: string?)
    local localPlayer = Players.LocalPlayer
    local str2 = "mediaGalleryMediaChanged"
    local tbl3 = {
        uid = if localPlayer then tostring(localPlayer.UserId) else "",
        placeId = placeId,
        universeId = universeId,
        imageAssetId = tbl2.imageId,
        videoAssetId = tbl2.videoId,
        isYouTubeVideo = isYouTubeVideo,
        autoAdvance = autoAdvance
    }
    tbl1:setRBXEventStream(str1, str2, tbl3)
end

return sendMediaGalleryMediaChanged

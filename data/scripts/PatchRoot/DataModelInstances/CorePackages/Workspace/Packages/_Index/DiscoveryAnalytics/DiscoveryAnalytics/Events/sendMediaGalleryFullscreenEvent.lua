-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:40:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local function sendMediaGalleryFullscreenEvent(tbl1, str1: string, str2: string, placeId: string?, universeId: string?, selectedIndex: number?, isVideo: boolean?)
    local localPlayer = Players.LocalPlayer
    local tbl2 = {
        uid = if localPlayer then tostring(localPlayer.UserId) else "",
        placeId = placeId,
        universeId = universeId,
        selectedIndex = selectedIndex,
        isVideo = isVideo
    }
    tbl1:setRBXEventStream(str1, str2, tbl2)
end

return sendMediaGalleryFullscreenEvent

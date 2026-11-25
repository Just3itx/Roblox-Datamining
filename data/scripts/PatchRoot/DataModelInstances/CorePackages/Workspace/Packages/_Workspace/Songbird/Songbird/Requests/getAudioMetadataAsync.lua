-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Songbird = script:FindFirstAncestor("Songbird")

local AssetService = game:GetService("AssetService")

local Cryo = require(Songbird.Parent.Cryo)
local _types = require(Songbird.types)

local function getAudioMetadataAsync(idList)
    local audioMetadataAsync = AssetService:GetAudioMetadataAsync(idList)

    return Cryo.List.map(audioMetadataAsync, function(arg1)
        local var1 = table.clone(arg1)

        var1.AlbumArt = "rbxassetid://11204867732"

        return var1
    end)
end

return getAudioMetadataAsync

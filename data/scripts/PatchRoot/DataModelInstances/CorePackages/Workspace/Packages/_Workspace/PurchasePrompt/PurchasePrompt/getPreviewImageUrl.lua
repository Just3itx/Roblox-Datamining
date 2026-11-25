-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local ContentProvider = game:GetService("ContentProvider")
local ItemType = require(scriptParent.Enums.ItemType)

local var1 = string.gsub(ContentProvider.BaseUrl:lower(), "https?://m.", "https?://www.")
local var2 = var1 .. "thumbs/asset.ashx?assetid="
local var3 = var1 .. "outfit-thumbnail/image?userOutfitId=%s&width=100&height=100&format=png"

local function getPreviewImageUrl(arg1, platform)
    local var4 = nil

    if arg1.itemType == ItemType.Bundle then
        if arg1.costumeId then
            return string.format(var3, arg1.costumeId)
        end

        var4 = arg1.items[1].id
    elseif arg1.AssetId ~= nil and arg1.AssetId ~= 0 then
        var4 = arg1.AssetId
    elseif arg1.IconImageAssetId ~= nil then
        var4 = arg1.IconImageAssetId
    else
        if arg1.ImageUrl ~= nil then
            return arg1.ImageUrl
        end

        if platform == Enum.Platform.XBoxOne then
            return "rbxasset://textures/ui/Shell/Icons/ROBUXIcon@1080.png"
        end
    end
    return var2 .. tostring(var4) .. "&x=100&y=100&format=png"
end

return getPreviewImageUrl

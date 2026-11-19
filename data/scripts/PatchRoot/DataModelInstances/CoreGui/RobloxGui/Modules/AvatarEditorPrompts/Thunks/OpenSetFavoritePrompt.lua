-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarEditorService = game:GetService("AvatarEditorService")
local CorePackages = game:GetService("CorePackages")
local MarketplaceService = game:GetService("MarketplaceService")

local Promise = require(CorePackages.Packages.Promise)

local scriptParentParent = script.Parent.Parent
local OpenPrompt = require(scriptParentParent.Actions.OpenPrompt)

local PromptType = require(scriptParentParent.PromptType)

return function(assetId: number, avatarItemType, shouldFavorite)
    return function(arg1)
        return Promise.new(function(callback, callback2)
            local infoType = if avatarItemType == Enum.AvatarItemType.Asset then Enum.InfoType.Asset else Enum.InfoType.Bundle

            local success, result = pcall(function()
                return MarketplaceService:GetProductInfoAsync(assetId, infoType)
            end)

            if not success then
                AvatarEditorService:SignalSetFavoriteFailed()

                callback2()
                return
            end

            arg1:dispatch(
                OpenPrompt(
                    PromptType.SetFavorite,
                    {
                        itemId = assetId,
                        itemName = result.Name,
                        itemType = avatarItemType,
                        shouldFavorite = shouldFavorite
                    }
                )
            )
            callback()
        end)
    end
end

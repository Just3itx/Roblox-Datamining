-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent

local React = require(AvatarExperienceProfilePictureEditorParent.React)
local useRealtimeEvent = require(AvatarExperienceProfilePictureEditorParent.RealtimeDelivery).useRealtimeEvent
local Localization = require(AvatarExperienceProfilePictureEditorParent.Localization)

local useOwnedEmotes = require(AvatarExperienceProfilePictureEditor.Hooks.useOwnedEmotes)
local useRecommendedEmotes = require(AvatarExperienceProfilePictureEditor.Hooks.useRecommendedEmotes)
local TextKeys = require(AvatarExperienceProfilePictureEditor.Common.TextKeys)

local useEditProfileImageActions = require(AvatarExperienceProfilePictureEditor.Context.EditProfileImageActionsContext).useEditProfileImageActions

local function useEditProfileImageEmotes(tbl1)
    local var1 = useEditProfileImageActions()
    local var2 = useOwnedEmotes()
    local var3 = useRecommendedEmotes()
    local emoteItems = var2.emoteItems
    local recommendedEmotes = var3.recommendedEmotes

    local var4 = React.useCallback(function(id: string)
        local label = nil
        for _, value in recommendedEmotes do
            if value.id == id then
                label = value.label
                break
            end
        end

        var2.markEmoteOwned(id, label)
    end, { recommendedEmotes, var2.markEmoteOwned })

    useRealtimeEvent("AvatarAssetOwnershipNotifications", "Grant", function(arg1)
        if tostring(arg1.AssetTypeId) == tostring(Enum.AvatarAssetType.EmoteAnimation.Value) then
            var4(tostring(arg1.AssetId))
        end
    end, { var4 })

    local var5 = React.useMemo(function()
        local result = {}
        for _, emoteItem in emoteItems do
            result[emoteItem.id] = true
        end
        return result
    end, { emoteItems })
    local var6 = React.useMemo(function()
        local result = {}
        for _, value in recommendedEmotes do
            result[value.id] = true
        end
        return result
    end, { recommendedEmotes })
    local selectedEmoteId = tbl1.selectedEmoteId
    local isRecommendedEmoteSelected = if selectedEmoteId and var5[selectedEmoteId] ~= true then var6[selectedEmoteId] == true else false

    React.useEffect(function()
        if selectedEmoteId and isRecommendedEmoteSelected then
            var1.onPrepareRecommendedEmotePurchase(selectedEmoteId)
        end
    end, { selectedEmoteId, isRecommendedEmoteSelected, var1.onPrepareRecommendedEmotePurchase })

    local var7 = Localization.Hooks.useLocalization({ free = TextKeys.Free })

    return {
        ownedEmotes = emoteItems,
        recommendedEmotes = recommendedEmotes,
        isLoading = var2.isLoading,
        hasError = var2.hasError,
        hasMoreEmotes = var2.hasMoreEmotes,
        isLoadingMoreEmotes = var2.isLoadingMoreEmotes,
        hasLoadMoreError = var2.hasLoadMoreError,
        onRetry = var2.refetch,
        onMoreEmotes = var2.onMoreEmotes,
        isRecommendedEmoteSelected = isRecommendedEmoteSelected,
        freeLabel = var7.free
    }
end

return useEditProfileImageEmotes

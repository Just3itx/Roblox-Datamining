-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent

local React = require(ProfilePlatformParent.React)
local Signals = require(ProfilePlatformParent.Signals)
local SignalsReact = require(ProfilePlatformParent.SignalsReact)
local _MomentsCommon = require(ProfilePlatformParent.MomentsCommon)
local _MomentsStoreTypes = require(ProfilePlatformParent.DataHydration.MomentsStoreTypes)
local MomentsGetPostAssetStore = require(ProfilePlatformParent.DataHydration.MomentsGetPostAssetStore)
local UserLib = require(ProfilePlatformParent.UserLib)

local readSceneOutfitIdFromPost = require(script.Parent.readSceneOutfitIdFromPost)

local getRbxthumbWithTypeSizeAndOptions = UserLib.Utils.getRbxthumbWithTypeSizeAndOptions
local RbxthumbTypes = UserLib.Utils.Constants.RbxthumbTypes

local signal = Signals.createSignal(nil)

local function useSceneOutfitMediaItem(arg1, mediaItem)
    local bool1 = arg1.metadata.isMomentScene == true
    local var1 = if not bool1 or arg1.postAsset == nil then 0 else arg1.postAsset.postAssetId
    local var2 = SignalsReact.useSignalState(
        if var1 > 0 then MomentsGetPostAssetStore(false).getAndFetchPostAsset(var1).data else signal
    )

    local scenePoster = React.useMemo(function()
        local var3 = if var2 == nil then nil else readSceneOutfitIdFromPost(var2)

        if var3 == nil then
            return nil
        end
        return Content.fromUri(getRbxthumbWithTypeSizeAndOptions(tostring(var3), RbxthumbTypes.Outfit, 420))
    end, { var2 })

    if not bool1 then
        return { mediaItem = mediaItem, scenePoster = nil }
    end

    local var3 = table.clone(mediaItem)
    var3.captureType = Enum.CaptureType.Screenshot
    var3.posterContent = nil
    return { mediaItem = var3, scenePoster = scenePoster }
end

return useSceneOutfitMediaItem

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCardParent = script:FindFirstAncestor("GameJoinCard").Parent

local React = require(GameJoinCardParent.React)
local SignalsReact = require(GameJoinCardParent.SignalsReact)

local getGameMediaStore = require(GameJoinCardParent.DataHydration).Game.getGameMediaStore

local DiscoveryTypes = require(GameJoinCardParent.DiscoveryTypes)
local GameMediaImageType = DiscoveryTypes.GameMediaImageType
local PlayabilityStatusEnum = DiscoveryTypes.PlayabilityStatusEnum

local VideoUtils = require(GameJoinCardParent.VideoUtils)
local isVideoEligibleForPlayability = VideoUtils.isVideoEligibleForPlayability
local useCanDevicePlayVideoPreview = VideoUtils.useCanDevicePlayVideoPreview
local EdpVideoBlockingConfig = VideoUtils.EdpVideoBlockingConfig

local function isValidVideoId(videoId): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if videoId == nil then
        return false
    end
    local str1 = tostring(videoId)
    return not (str1 == "") and str1 ~= "0"
end

local function useJoinCardBannerVideoId(str1: string, playabilityStatus: string?, bool1: boolean)
    local var1 = getGameMediaStore(false).getAndFetchGameMedia(str1)
    local var2 = SignalsReact.useSignalState(var1.data)

    local var3 = useCanDevicePlayVideoPreview(EdpVideoBlockingConfig, str1, "GameJoinCard")

    return React.useMemo(function()
        if not bool1 or str1 == "" or playabilityStatus == nil or var2 == nil then
            return nil
        end

        if not isVideoEligibleForPlayability(
            true,
            {
                isPlayable = playabilityStatus == PlayabilityStatusEnum.Playable,
                playabilityStatus = playabilityStatus
            }
        ) then
            return nil
        end

        local var4 = nil
        for _, value in var2 do
            if value.assetTypeId ~= GameMediaImageType.YouTubeVideo and isValidVideoId(value.videoId) then
                var4 = tostring(value.videoId)
                break
            end
        end

        return if var4 == nil or not var3() then nil else var4
    end, {
        bool1,
        str1,
        playabilityStatus,
        var2,
        var3
    })
end
return useJoinCardBannerVideoId

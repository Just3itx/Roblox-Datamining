-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Songbird = script:FindFirstAncestor("Songbird")

local AssetFavorites = require(Songbird.Parent.AssetFavorites)
local Cryo = require(Songbird.Parent.Cryo)
local React = require(Songbird.Parent.React)
local ReactSceneUnderstanding = require(Songbird.Parent.ReactSceneUnderstanding)
local useAudioMetadata = require(Songbird.Hooks.useAudioMetadata)
local getAssetIdForAudioSource = require(Songbird.Common.getAssetIdForAudioSource)
local _types = require(Songbird.types)
local logger = require(Songbird.logger)
local AnalyticActions = require(Songbird.Analytics.AnalyticActions)
local sendChromeWindowAnalytics = require(Songbird.Analytics.sendChromeWindowAnalytics)

local useMemo = React.useMemo
local useAudibleSounds = ReactSceneUnderstanding.useAudibleSounds
local useAssetFavoriting = AssetFavorites.useAssetFavoriting

local function useCurrentSong()
    local var1 = useAudibleSounds()

    local var2 = useMemo(function()
        return Cryo.List.filter(var1, function(arg1): boolean
            return getAssetIdForAudioSource(arg1) ~= nil
        end)
    end, { var1 })

    local var3 = useMemo(function()
        return Cryo.List.map(var2, function(arg1)
            return getAssetIdForAudioSource(arg1)
        end)
    end, { var2 })

    local var4 = useAudioMetadata(var3)

    local var5 = useAssetFavoriting(var3)

    return (useMemo(function()
        logger:info(`determining currently playing song from {#var2} audio sources...`)

        for _, sound in var2 do
            local assetId = getAssetIdForAudioSource(sound)

            if not assetId then
                continue
            end

            local metadata = var4.getByAssetId(assetId)
            local bool1 = true

            logger:info(`processing audio source: {sound} (AssetId: {assetId}, Path: {sound:GetFullName()})`)

            if not metadata then
                logger:warning("no metadata found. skipping...")
            elseif metadata.AudioType then
                if metadata.AudioType == Enum.AudioSubType.Music then
                    logger:debug(`{metadata.Title} is classified as music. checking if it meets criteria...`)

                    if not metadata.RecordingCode or metadata.RecordingCode == "" then
                        logger:debug(`{metadata.Title} does not meet criteria (no recording code found)`)
                        bool1 = false
                    end

                    if bool1 then
                        logger:info(`{metadata.Title} meets criteria`)
                    end

                    local function toggleFavorite()
                        return var5.toggleFavorite(assetId):andThen(function(arg1)
                            if arg1 then
                                sendChromeWindowAnalytics({ assetId = assetId, action = AnalyticActions.Like })
                                return
                            end
                            sendChromeWindowAnalytics({ assetId = assetId, action = AnalyticActions.Unlike })
                        end):catch(function(arg1)
                            logger:warning(arg1)
                        end)
                    end

                    return {
                        sound = sound,
                        metadata = metadata,
                        meetsCriteria = bool1,
                        isFavorited = var5.getByAssetId(assetId),
                        toggleFavorite = toggleFavorite
                    }
                end

                logger:debug(
                    `{metadata.Title} is not classified as music. instead classified as: {metadata.AudioType.Name}. skipping...`
                )
            else
                logger:debug(`{metadata.Title} has no AudioSubType classification. skipping...`)
            end
        end
        return nil
    end, {
        var4.getByAssetId,
        var2,
        var5.getByAssetId,
        var5.toggleFavorite
    }))
end
return useCurrentSong

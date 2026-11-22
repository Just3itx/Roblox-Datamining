-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Dash = require(MomentsCreationParent.Dash)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)

local Constants = require(MomentsCreation.Constants)
local _Music = require(MomentsCreation.Types.Music)

local FFlagMomentsCreationSkipRecordingCodeFilter = require(MomentsCreation.Flags.FFlagMomentsCreationSkipRecordingCodeFilter)

local FFlagMomentsCreationMusicSkipMetadataFetch = require(MomentsCreation.Flags.FFlagMomentsCreationMusicSkipMetadataFetch)

local FFlagMomentsCreationAudioSearchV2SortType = require(MomentsCreation.Flags.FFlagMomentsCreationAudioSearchV2SortType)

local reportMusicSearchCounts = MomentsCommon.Analytics.reportMusicSearchCounts

local function formatMusic(tbl1)
    local result = {}
    for _, value in tbl1 do
        local assetId = tonumber(value.AssetId)
        if assetId == nil or not FFlagMomentsCreationSkipRecordingCodeFilter and value.RecordingCode == nil then
            continue
        end

        table.insert(result, {
            Artist = value.Artist,
            AssetId = assetId,
            AudioType = value.AudioType,
            Duration = value.Duration,
            RecordingCode = value.RecordingCode,
            Title = value.Title
        })
    end
    return result
end

local function formatSearchResults(currentPage)
    local tbl1 = {}
    local num1 = 0
    for _, value in currentPage do
        local id = value.Id
        if id == nil or Dash.includes(Constants.SearchMusicCreatorDenylist, value.Creator.Id) then
            continue
        end

        num1 += 1

        if value.Purchasable == false then
            continue
        end

        table.insert(
            tbl1,
            {
                Artist = value.Artist,
                AssetId = id,
                AudioType = value.AudioType,
                Duration = value.Duration,
                Title = value.Title
            }
        )
    end

    return tbl1, num1
end

local function createMusicSource(tbl1)
    local function getAssetService(): {[any]: any} | AssetService -- Luacid: Inlined by compiler; 2 call sites recovered
        return tbl1 or game:GetService("AssetService")
    end

    local function formatPage(assetService, currentPage)
        if FFlagMomentsCreationMusicSkipMetadataFetch and FFlagMomentsCreationSkipRecordingCodeFilter then
            return formatSearchResults(currentPage)
        end

        local tbl2 = {}
        for _, value in currentPage do
            if not Dash.includes(Constants.SearchMusicCreatorDenylist, value.Creator.Id) then
                table.insert(tbl2, value.Id)
            end
        end

        local var1 = #tbl2 == 0 and {} or assetService:GetAudioMetadataAsync(tbl2)
        return formatMusic(var1), #var1
    end

    return {
        searchMusic = function(searchKeyword: string, minDuration: number)
            local assetService = getAssetService()
            local audioSearchParams = Instance.new("AudioSearchParams")
            audioSearchParams.SearchKeyword = searchKeyword
            audioSearchParams.AudioSubType = Enum.AudioSubType.Music
            audioSearchParams.MinDuration = minDuration

            if FFlagMomentsCreationAudioSearchV2SortType then
                pcall(function()
                    local audioSortType = Enum.AudioSortType
                    local audioSearchParams2 = audioSearchParams
                    audioSearchParams2.SortType = if searchKeyword == "" then audioSortType.MostUsed else audioSortType.Relevance
                end)
            end

            local var1 = assetService:SearchAudio(audioSearchParams)
            local tbl2, num1 = formatPage(assetService, var1:GetCurrentPage())

            reportMusicSearchCounts(num1, #tbl2, { queryPresent = searchKeyword ~= "" })

            return tbl2, {
                isFinished = function(): boolean
                    return var1.IsFinished == true
                end,
                nextPage = function()
                    var1:AdvanceToNextPageAsync()
                    return (formatPage(assetService, var1:GetCurrentPage()))
                end
            }
        end,
        getMetadata = function(tbl2)
            return (formatMusic(getAssetService():GetAudioMetadataAsync(tbl2)))
        end
    }
end

return createMusicSource

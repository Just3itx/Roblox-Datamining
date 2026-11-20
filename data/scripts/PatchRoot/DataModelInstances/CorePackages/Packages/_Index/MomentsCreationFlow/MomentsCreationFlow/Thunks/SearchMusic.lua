-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlow = script:FindFirstAncestor("MomentsCreationFlow")
local MomentsCreationFlowParent = MomentsCreationFlow.Parent

local AssetService = game:GetService("AssetService")

local Dash = require(MomentsCreationFlowParent.Dash)
local _MomentsCommon = require(MomentsCreationFlowParent.MomentsCommon)

local CreationFlowMusicInfoRetrieved = require(MomentsCreationFlow.Actions.CreationFlowMusicInfoRetrieved)
local MusicSearchRetrieved = require(MomentsCreationFlow.Actions.MusicSearchRetrieved)

local Constants = require(MomentsCreationFlow.Constants)

local function filterCreator(arg1): boolean
    return not Dash.includes(Constants.SearchMusicCreatorFilter, arg1.Creator.Id)
end

local function filterRecordingCode(arg1): boolean
    return arg1.RecordingCode ~= nil
end

local function formatMusic(tbl1)
    local result = ({})
    for _, value in ipairs(tbl1) do
        if value.Id == nil then
            continue
        end

        local id = value.Id
        result[id] = {
            Artist = value.Artist,
            AssetId = value.Id,
            AudioType = value.AudioType,
            Duration = value.Duration,
            RecordingCode = value.RecordingCode,
            Title = value.Title
        }
    end
    return result
end

local function SearchMusic(searchKeyword, minDuration)
    return function(arg1)
        local audioSearchParams = Instance.new("AudioSearchParams")
        audioSearchParams.SearchKeyword = searchKeyword
        audioSearchParams.AudioSubType = Enum.AudioSubType.Music
        audioSearchParams.MinDuration = minDuration or 30

        task.spawn(function()
            local success, result = pcall(function(): AudioPages
                return AssetService:SearchAudio(audioSearchParams)
            end)

            if not success then
                warn("Failed to retrieve musics: " .. result)
                return
            end

            local currentPage = result:GetCurrentPage()

            local var1 = Dash.filter(currentPage, filterCreator)
            local idList = Dash.map(var1, function(arg2)
                return arg2.Id
            end)

            local audioMetadataAsync = AssetService:GetAudioMetadataAsync(idList)
            local var2 = Dash.filter(audioMetadataAsync, filterRecordingCode)
            arg1:dispatch(CreationFlowMusicInfoRetrieved((formatMusic(var2))))
            arg1:dispatch(MusicSearchRetrieved(Dash.map(var2, function(arg2): number?
                return tonumber(arg2.AssetId)
            end)))
        end)
    end
end

return SearchMusic

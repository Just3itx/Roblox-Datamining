-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TeleportService = game:GetService("TeleportService")
local ExperienceStateRecordingService = game:GetService("ExperienceStateRecordingService")
local HttpService = game:GetService("HttpService")

local module = {}

function debugPrint(_) end

function module.SetLoadedState(arg1, arg2)
    debugPrint(
        "playResult minFrameNumber "
            .. tostring(arg2.minFrameNumber)
                .. " maxFrameNumber "
                    .. tostring(arg2.maxFrameNumber)
                        .. " minEpoch "
                            .. tostring(arg2.minEpoch) .. " - " .. tostring(DateTime.fromUnixTimestampMillis(arg2.minEpoch):ToIsoDate()) .. " maxEpoch " .. tostring(arg2.maxEpoch) .. " - " .. tostring(DateTime.fromUnixTimestampMillis(arg2.maxEpoch):ToIsoDate())
    )
    arg1.minLoadedFrameNumber = arg2.minFrameNumber
    arg1.maxLoadedFrameNumber = arg2.maxFrameNumber
    arg1.minLoadedEpoch = arg2.minEpoch
    arg1.maxLoadedEpoch = arg2.maxEpoch
    if arg1.minOverallEpoch == nil then
        arg1.minOverallEpoch = arg1.minLoadedEpoch
        arg1.maxOverallEpoch = arg1.maxLoadedEpoch
    elseif arg1.sourceType == Enum.ExperienceStateRecordingLoadSourceType.File then
        arg1.minOverallEpoch = math.min(arg1.minLoadedEpoch, arg1.minOverallEpoch)
        arg1.maxOverallEpoch = math.max(arg1.maxLoadedEpoch, arg1.maxOverallEpoch)
    end

    arg1.loadedLengthSeconds = (arg1.maxLoadedEpoch - arg1.minLoadedEpoch) / 1000

    arg1.overallLengthSeconds = (arg1.maxOverallEpoch - arg1.minOverallEpoch) / 1000

    arg1.replayToLoadedStartSeconds = (arg1.minLoadedEpoch - arg1.minOverallEpoch) / 1000

    debugPrint(
        "minOverallEpoch "
            .. tostring(arg1.minOverallEpoch) .. " maxOverallEpoch " .. tostring(arg1.maxOverallEpoch) .. " overallLengthSeconds " .. tostring(arg1.overallLengthSeconds) .. " loadedLengthSeconds " .. tostring(arg1.loadedLengthSeconds)
    )

    local xScale = arg1.loadedLengthSeconds / arg1.overallLengthSeconds
    arg1.ScrubberLoadProgress.Size = UDim2.new(xScale, 0, 1, 0)
    local xScale2 = arg1.replayToLoadedStartSeconds / arg1.overallLengthSeconds
    arg1.ScrubberLoadProgress.Position = UDim2.new(xScale2, 0, 0, 0)
    debugPrint("loadedPercent " .. tostring(xScale) .. " loadedStartPercent " .. tostring(xScale2))
end

function _getMetadataForUser(arg1)
    local var1 = ExperienceStateRecordingService:ListRecordingsAsync(arg1, "")

    print(var1)
end

function getMetadataForGuid(engineContextGuid, callback)
    local options = {
        Url = "https://apis.roblox.com/data-model-capture-service/v1/GetCaptureMetadataByEngineContextGuid",
        Method = "POST",
        Body = HttpService:JSONEncode({ engineContextGuid = engineContextGuid }),
        Headers = { ["Content-Type"] = "application/json", Accept = "application/json" }
    }

    return HttpService:RequestInternal(options):Start(function(arg1, arg2)
        if not arg1 then
            warn("Failed to get metadata for GUID: " .. tostring(engineContextGuid) .. " Error: " .. tostring(arg2.Status))

            for k, value in pairs(arg2) do
                print(k, value)
            end

            return nil
        end

        print(arg2.Body)
        local metadata = HttpService:JSONDecode(arg2.Body).metadata

        callback(tonumber(metadata.placeId), tonumber(metadata.placeVersion))

        return nil
    end)
end

function module.loadGUIDSlices(_, arg1, _, _)
    local metadataForGuid = getMetadataForGuid(arg1)
    print(metadataForGuid)
end

function module.loadGUID(arg1, directGuid)
    debugPrint("Loading slices for GUID: " .. tostring(directGuid))

    getMetadataForGuid(directGuid, function(arg2, arg3)
        debugPrint("Received metadata - PlaceId: " .. tostring(arg2) .. " PlaceVersion: " .. tostring(arg3))

        local var1 = ExperienceStateRecordingService:ListCaptureURLsAsync(directGuid, "2024-12-10T00:20:14.556Z", "2026-12-18T00:25:59.412Z")
        local placeUrl = ExperienceStateRecordingService:GetPlaceFileURLAsync(arg3, arg2)

        arg1.LoadingOverlay.Visible = true
        arg1.state.Loading = true

        arg1.minLoadedFrameNumber = 0
        arg1.maxLoadedFrameNumber = 0
        arg1.minLoadedEpoch = 0
        arg1.maxLoadedEpoch = 0
        arg1.minOverallEpoch = nil
        arg1.maxOverallEpoch = nil

        arg1.nextSliceToLoad = nil
        arg1.noncontiguousSliceToLoad = nil

        arg1.recordingsToPlayback = var1.urls

        arg1.placeURL = placeUrl

        arg1.sourceType = Enum.ExperienceStateRecordingLoadSourceType.S3Url

        for value, value2 in arg1.recordingsToPlayback do
            debugPrint("Recording " .. tostring(value) .. " " .. value2)
        end

        task.spawn(function()
            local success, result = pcall(function()
                local playbackAsyncResult = ExperienceStateRecordingService:LoadPlaybackAsync(
                    arg1.recordingsToPlayback[1],
                    arg1.placeURL,
                    Enum.ExperienceStateRecordingLoadMode.NewReplay,
                    arg1.sourceType
                )
                module.SetLoadedState(arg1, playbackAsyncResult)
                arg1.nextSliceToLoad = 2
                arg1.LoadingOverlay.Visible = false
                arg1.state.Loading = false
                arg1.ControlButtons(arg1.PlayButton)

                task.spawn(module.loadSlicesAfterFirst, arg1)
            end)
            if not success then
                arg1.LoadingLabel.Text = "Failed To Load Initial Slice, See Logs"
                warn("Failed to load initial slice because " .. tostring(result))
            end
        end)
    end)
end

function module.experienceCallback(arg1)
    local localPlayerTeleportData = TeleportService:GetLocalPlayerTeleportData()

    if not localPlayerTeleportData then
        return
    end

    if localPlayerTeleportData.directGuid then
        module.loadGUID(arg1, localPlayerTeleportData.directGuid)
        return
    end
    debugPrint("No direct GUID found in teleport data, falling back to loading slices")
    module.loadSlices(arg1)
end

function module.loadSlices(arg1)
    arg1.LoadingOverlay.Visible = true
    arg1.state.Loading = true

    arg1.minLoadedFrameNumber = 0
    arg1.maxLoadedFrameNumber = 0
    arg1.minLoadedEpoch = 0
    arg1.maxLoadedEpoch = 0
    arg1.minOverallEpoch = nil
    arg1.maxOverallEpoch = nil

    arg1.nextSliceToLoad = nil
    arg1.noncontiguousSliceToLoad = nil

    local localPlayerTeleportData = TeleportService:GetLocalPlayerTeleportData()
    arg1.recordingsToPlayback = { "/path/to/default/file" }

    arg1.sourceType = Enum.ExperienceStateRecordingLoadSourceType.File

    if localPlayerTeleportData then
        arg1.recordingsToPlayback = localPlayerTeleportData.captureURLs
        if localPlayerTeleportData.startTime then
            arg1.minOverallEpoch = localPlayerTeleportData.startTime.UnixTimestampMillis
        end
        if localPlayerTeleportData.endTime then
            arg1.maxOverallEpoch = localPlayerTeleportData.endTime.UnixTimestampMillis
        end

        arg1.sourceType = Enum.ExperienceStateRecordingLoadSourceType:FromValue(localPlayerTeleportData.sourceType)
        arg1.placeURL = localPlayerTeleportData.placeURL
    end

    for value, value2 in arg1.recordingsToPlayback do
        debugPrint("Recording " .. tostring(value) .. " " .. value2)
    end

    task.spawn(function()
        local success, result = pcall(function()
            local playbackAsyncResult = ExperienceStateRecordingService:LoadPlaybackAsync(
                arg1.recordingsToPlayback[1],
                arg1.placeURL,
                Enum.ExperienceStateRecordingLoadMode.NewReplay,
                arg1.sourceType
            )
            module.SetLoadedState(arg1, playbackAsyncResult)
            arg1.nextSliceToLoad = 2
            arg1.LoadingOverlay.Visible = false
            arg1.state.Loading = false
            arg1.ControlButtons(arg1.PlayButton)

            task.spawn(module.loadSlicesAfterFirst, arg1)
        end)
        if not success then
            arg1.LoadingLabel.Text = "Failed To Load Initial Slice, See Logs"
            warn("Failed to load initial slice because " .. tostring(result))
        end
    end)
end

function module.loadSlicesAfterFirst(arg1)
    local success, result = pcall(function()
        local num1 = 0

        while true do
            while true do
                task.wait(1)
                if arg1.noncontiguousSliceToLoad ~= nil then
                    break
                end

                if arg1.nextSliceToLoad <= #arg1.recordingsToPlayback and num1 >= 4 then
                    local uri = arg1.recordingsToPlayback[arg1.nextSliceToLoad]
                    debugPrint("loading contiguous " .. tostring(arg1.nextSliceToLoad) .. " url " .. uri)

                    local playbackAsyncResult = ExperienceStateRecordingService:LoadPlaybackAsync(
                        uri,
                        nil,
                        Enum.ExperienceStateRecordingLoadMode.ContiguousSlice,
                        arg1.sourceType
                    )
                    module.SetLoadedState(arg1, playbackAsyncResult)

                    local var1 = arg1
                    var1.nextSliceToLoad += 1
                    num1 = 0
                else
                    num1 += 1
                end
            end

            local uri = arg1.recordingsToPlayback[arg1.noncontiguousSliceToLoad]
            debugPrint("loading noncontiguous " .. tostring(arg1.noncontiguousSliceToLoad) .. " url " .. uri)

            local playbackAsyncResult = ExperienceStateRecordingService:LoadPlaybackAsync(
                uri,
                nil,
                Enum.ExperienceStateRecordingLoadMode.NoncontiguousSlice,
                arg1.sourceType
            )
            module.SetLoadedState(arg1, playbackAsyncResult)

            local percentage = (arg1.playbackSecondToFetch - arg1.replayToLoadedStartSeconds) / arg1.loadedLengthSeconds
            ExperienceStateRecordingService:SetPlaybackPercentage(percentage)

            arg1.LoadingOverlay.Visible = false
            arg1.state.Loading = false

            arg1.nextSliceToLoad = arg1.noncontiguousSliceToLoad + 1
            arg1.noncontiguousSliceToLoad = nil
            num1 = 0
        end
    end)

    if not success then
        arg1.LoadingLabel.Text = "Failed To Load Later Slice, See Logs"
        warn("Failed to load later slice because " .. tostring(result))
    end
end

function module.loadNoncontiguousSlice(arg1, arg2)
    if arg1.noncontiguousSliceToLoad ~= nil then
        warn("skipping non-contiguous slice load as still waiting for last jump")
    end

    arg1.LoadingOverlay.Visible = true
    arg1.state.Loading = true

    local playbackSecondToFetch = arg2 * arg1.overallLengthSeconds
    local num1 = math.floor(playbackSecondToFetch / 60)
    arg1.noncontiguousSliceToLoad = math.min(num1 + 1, #arg1.recordingsToPlayback)
    arg1.playbackSecondToFetch = playbackSecondToFetch
    debugPrint(
        "percentOverallLength " .. tostring(arg2) .. " playbackSecondToFetch " .. tostring(playbackSecondToFetch) .. " playbackMinuteToFetch " .. tostring(num1) .. " nextSliceToLoad " .. tostring(arg1.nextSliceToLoad)
    )
end

return module

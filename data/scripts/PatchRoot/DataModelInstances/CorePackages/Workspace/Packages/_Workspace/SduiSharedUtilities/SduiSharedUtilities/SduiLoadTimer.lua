-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:51:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")
local SduiSharedUtilitiesParent = SduiSharedUtilities.Parent

local SduiPageAnalytics = require(SduiSharedUtilities.SduiPageAnalytics)
local _SduiIntegrationTypes = require(SduiSharedUtilities.SduiIntegrationTypes)

local FFlagLuaAppSduiStreamingFirstDataTiming = require(SduiSharedUtilitiesParent.SharedFlags).FFlagLuaAppSduiStreamingFirstDataTiming

return {
    createLoadTimer = function(pageKey: string, callback: ((...any) -> (...any))?)
        local var1 = nil
        local var2 = nil

        local tbl1 = ({})
        local var3 = nil
        local str1 = "NotStarted"
        local var4 = nil
        local var5 = nil

        local function calculateDuration(str2: string, str3: string) -- Luacid: Inlined by compiler; 7 call sites recovered
            local var6 = tbl1[str2]
            local var7 = tbl1[str3]
            return if var6 and var7 then (var7 - var6) * 1000 else nil
        end

        local function start(str2: string) -- Luacid: Inlined by compiler; 2 call sites recovered
            var1 = os.clock()
            str1 = "Running"
            var5 = str2
        end

        local function finish()
            if str1 ~= "Running" or var1 == nil then
                return
            end

            str1 = "Finished"
            var2 = os.clock()

            local totalDurationMs = (var2 - var1) * 1000
            local duration

            if FFlagLuaAppSduiStreamingFirstDataTiming then
                local duration2 = calculateDuration("UiRequestQueued", "UiStreamChunkReceived")
                local duration3 = calculateDuration("UiRequestQueued", "UiResponseReceived")

                if duration2 and duration3 then
                    duration = math.min(duration2, duration3)
                else
                    duration = duration2 or duration3
                end
            else
                duration = calculateDuration("UiRequestQueued", "UiResponseReceived")
            end

            local responseDecodeDurationMs = calculateDuration("ResponseDecodeBegin", "ResponseDecodeEnd")
            local dataUpdateDurationMs = calculateDuration("ResponseDataUpdateBegin", "ResponseDataUpdateEnd")
            local tbl2 = {
                totalDurationMs = totalDurationMs,
                uiRequestDurationMs = duration,
                responseDecodeDurationMs = responseDecodeDurationMs,
                sduiTreeBuildDurationMs = calculateDuration("SduiTreeBuildBegin", "SduiTreeBuildEnd"),
                dataUpdateDurationMs = dataUpdateDurationMs,
                netRoundTripTimeMs = var3 and var3.RoundTripTime and var3.RoundTripTime * 1000,
                netDurationReceiveResponseMs = var3 and var3.DurationReceiveResponse and var3.DurationReceiveResponse * 1000,
                requestStatus = var4,
                pageKey = pageKey,
                startSource = var5 or "unknown"
            }
            tbl2.clientHintsDurationMs = calculateDuration("SduiClientHintsBegin", "SduiClientHintsEnd")

            if callback then
                callback(tbl2)
                return
            end
            SduiPageAnalytics.sendLoadTimerEvent(tbl2)
        end

        local function logTimestamp(str2: string) -- Luacid: Inlined by compiler; 15 call sites recovered
            tbl1[str2] = os.clock()
        end

        return {
            start = start,
            logUiRequestQueued = function()
                if str1 == "NotStarted" then
                    start("UiRequestQueued")
                end

                logTimestamp("UiRequestQueued")
            end,
            logUiRequestSent = function()
                if str1 == "NotStarted" then
                    start("UiRequestSent")
                end

                logTimestamp("UiRequestSent")
            end,
            logUiResponseReceived = function()
                logTimestamp("UiResponseReceived")
            end,
            logUiStreamChunkReceived = function()
                if FFlagLuaAppSduiStreamingFirstDataTiming and tbl1.UiStreamChunkReceived ~= nil then
                    return
                end

                logTimestamp("UiStreamChunkReceived")
            end,
            logResponseDecodeBegin = function()
                logTimestamp("ResponseDecodeBegin")
            end,
            logResponseDecodeEnd = function()
                logTimestamp("ResponseDecodeEnd")
            end,
            logResponseDataUpdateBegin = function()
                logTimestamp("ResponseDataUpdateBegin")
            end,
            logResponseDataUpdateEnd = function()
                logTimestamp("ResponseDataUpdateEnd")
            end,
            logSduiTreeBuildBegin = function()
                logTimestamp("SduiTreeBuildBegin")
            end,
            logSduiTreeBuildEnd = function()
                logTimestamp("SduiTreeBuildEnd")
            end,
            logSduiClientHintsBegin = function()
                logTimestamp("SduiClientHintsBegin")
            end,
            logSduiClientHintsEnd = function()
                logTimestamp("SduiClientHintsEnd")
            end,
            logComponentMounted = function()
                logTimestamp("SduiComponentMounted")
            end,
            logComponentReady = function()
                logTimestamp("SduiComponentReady")

                if str1 == "Running" then
                    finish()
                end
            end,
            logRefreshComplete = function()
                logTimestamp("RefreshComplete")

                if str1 == "Running" then
                    finish()
                end
            end,
            logNetRequestStats = function(tbl2)
                var3 = tbl2
            end,
            updateRequestStatus = function(arg1)
                var4 = arg1
            end,
            finish = finish
        }
    end
}

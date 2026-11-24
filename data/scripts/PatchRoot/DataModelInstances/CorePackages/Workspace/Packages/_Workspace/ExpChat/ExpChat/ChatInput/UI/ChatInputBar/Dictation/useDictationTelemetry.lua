-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local React = require(ExpChatParent.React)

local DictationMode = require(script.Parent.DictationMode)
local DictationAnalytics = require(script.Parent.DictationAnalytics)
local _requestMicPermission = require(script.Parent.requestMicPermission)

local FFlagExpChatDictationGrafanaMetrics = require(ExpChat.Flags.FFlagExpChatDictationGrafanaMetrics)

local function useDictationTelemetry()
    local var1 = React.useRef(nil)

    return {
        logMicClick = React.useCallback(function(arg1, arg2)
            DictationAnalytics.fire(
                DictationAnalytics.Events.MicClick,
                {
                    [DictationAnalytics.Properties.SttMode] = arg1,
                    [DictationAnalytics.Properties.EntryPoint] = arg2
                }
            )

            if FFlagExpChatDictationGrafanaMetrics then
                DictationAnalytics.reportStartedCounter(arg1, arg2)
            end
        end, {}),
        logPermissionResolved = React.useCallback(function(arg1, arg2)
            DictationAnalytics.fire(
                DictationAnalytics.Events.PermissionPrompt,
                {
                    [DictationAnalytics.Properties.SttMode] = arg1,
                    [DictationAnalytics.Properties.Status] = arg2
                }
            )

            if FFlagExpChatDictationGrafanaMetrics then
                DictationAnalytics.reportPermissionCounter(arg1, arg2)
            end
        end, {}),
        logRecordingStart = React.useCallback(function(arg1, arg2)
            DictationAnalytics.fire(
                DictationAnalytics.Events.RecordingStart,
                {
                    [DictationAnalytics.Properties.SttMode] = arg1,
                    [DictationAnalytics.Properties.TriggerType] = arg2
                }
            )
        end, {}),
        logRecordingStop = React.useCallback(function(arg1, autoChunk, num1: number, num2: number?)
            DictationAnalytics.fire(DictationAnalytics.Events.RecordingStop, {
                [DictationAnalytics.Properties.SttMode] = arg1,
                [DictationAnalytics.Properties.TriggerType] = autoChunk,
                [DictationAnalytics.Properties.DurationSeconds] = num1,
                [DictationAnalytics.Properties.CharCount] = num2
            })

            if FFlagExpChatDictationGrafanaMetrics and autoChunk ~= DictationAnalytics.TriggerTypes.AutoChunk then
                DictationAnalytics.reportEndedCounter(arg1, autoChunk)
            end
        end, {}),
        logSpeechStarted = React.useCallback(function()
            var1.current = os.clock()
            DictationAnalytics.fire(DictationAnalytics.Events.RecordingStart, {
                [DictationAnalytics.Properties.SttMode] = DictationMode.Continuous,
                [DictationAnalytics.Properties.TriggerType] = DictationAnalytics.TriggerTypes.AutoChunk
            })
        end, {}),
        logTranscription = React.useCallback(function(str1: string, continuous, bool1: boolean)
            local num1 = #str1
            if continuous == DictationMode.Continuous then
                local current = var1.current
                DictationAnalytics.fire(DictationAnalytics.Events.RecordingStop, {
                    [DictationAnalytics.Properties.SttMode] = DictationMode.Continuous,
                    [DictationAnalytics.Properties.TriggerType] = DictationAnalytics.TriggerTypes.AutoChunk,
                    [DictationAnalytics.Properties.CharCount] = num1,
                    [DictationAnalytics.Properties.DurationSeconds] = if current then os.clock() - current else nil
                })

                var1.current = nil
            end
            DictationAnalytics.fire(DictationAnalytics.Events.TranscriptionDone, {
                [DictationAnalytics.Properties.SttMode] = continuous,
                [DictationAnalytics.Properties.Success] = bool1,
                [DictationAnalytics.Properties.CharCount] = num1
            })
            if FFlagExpChatDictationGrafanaMetrics then
                DictationAnalytics.reportTranscriptionCounter(continuous, bool1)
            end
        end, {}),
        logTranscriptionFailed = React.useCallback(function(arg1)
            DictationAnalytics.fire(
                DictationAnalytics.Events.TranscriptionDone,
                {
                    [DictationAnalytics.Properties.SttMode] = arg1,
                    [DictationAnalytics.Properties.Success] = false
                }
            )

            if FFlagExpChatDictationGrafanaMetrics then
                DictationAnalytics.reportTranscriptionCounter(arg1, false)
            end
        end, {}),
        logMicToastShown = React.useCallback(function(arg1, bool1: boolean)
            DictationAnalytics.fire(
                DictationAnalytics.Events.MicToastShown,
                {
                    [DictationAnalytics.Properties.SttMode] = arg1,
                    [DictationAnalytics.Properties.CanDeepLink] = bool1
                }
            )
        end, {}),
        logMicToastActivated = React.useCallback(function(arg1, bool1: boolean)
            DictationAnalytics.fire(
                DictationAnalytics.Events.MicToastActivated,
                {
                    [DictationAnalytics.Properties.SttMode] = arg1,
                    [DictationAnalytics.Properties.CanDeepLink] = bool1
                }
            )
        end, {}),
        logMicToastDismissed = React.useCallback(function(arg1, arg2)
            DictationAnalytics.fire(
                DictationAnalytics.Events.MicToastDismiss,
                {
                    [DictationAnalytics.Properties.SttMode] = arg1,
                    [DictationAnalytics.Properties.DismissReason] = arg2
                }
            )
        end, {})
    }
end

return useDictationTelemetry

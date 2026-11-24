-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Promise = require(GenericAbuseReportingParent.Promise)
local React = require(GenericAbuseReportingParent.React)

local _AbuseSheetFlowTypes = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.AbuseSheetFlowTypes)
local computeImpactedUserCount = require(GenericAbuseReporting.BeduiV2.Utils.computeImpactedUserCount)
local _LoaderContext = require(GenericAbuseReporting.BeduiV2.Loaders.LoaderContext)
local reportHelper = require(GenericAbuseReporting.BeduiV2.Utils.reportHelper)
local useVoiceSnapshot = require(GenericAbuseReporting.BeduiV2.Hooks.Enrichment.useVoiceSnapshot).useVoiceSnapshot

local _appendReportAnythingTags = require(GenericAbuseReporting.BeduiV2.Utils.appendReportAnythingTags)

local submitVoiceReport = reportHelper.submitVoiceReport
local submitChatReport = reportHelper.submitChatReport
local submitChatReportWithoutMessage = reportHelper.submitChatReportWithoutMessage
local submitAvatarReport = reportHelper.submitAvatarReport
local submitPlaceReport = reportHelper.submitPlaceReport

return {
    useInExpCustomSubmit = function(tbl1)
        local var1 = useVoiceSnapshot(tbl1.voiceChatServiceManager)

        return React.useCallback(function(arg1)
            if not arg1.endpoint then
                error("SubmissionConfig must have an endpoint")
            end

            if arg1.endpoint == "voice" then
                local current = var1.current
                local tbl2 = {
                    sortedPlayerListUserIds = current.sortedPlayerListUserIds,
                    channelId = current.channelId,
                    voiceUserCount = current.voiceUserCount,
                    voiceImpactedUserCount = computeImpactedUserCount(tbl1.voiceChatServiceManager, arg1.data.targetIdStr),
                    menuOpenedUnixMilli = tbl1.menuOpenTimeRef.current
                }
                return submitVoiceReport(arg1, tbl2)
            elseif arg1.endpoint == "chat" then
                local inExpChatMessagesLoader = tbl1.inExpChatMessagesLoader
                if not inExpChatMessagesLoader then
                    return Promise.reject("inExpChatMessagesLoader is required for chat reports")
                end

                local textChatMessageId = arg1.data.custom and arg1.data.custom.textChatMessageId

                if textChatMessageId == "__MSG_NOT_SHOWN_ID" then
                    return submitChatReportWithoutMessage(arg1)
                end

                return inExpChatMessagesLoader.fetch({}):andThen(function(arg2)
                    local eligibleMessages = {}
                    local targetMessages = {}
                    for _, value in ipairs(arg2 or {}) do
                        for _, value2 in ipairs(value.items or {}) do
                            table.insert(eligibleMessages, { channel = value2.meta.textChannel, messageId = value2.id })
                            if value2.id ~= textChatMessageId then
                                continue
                            end

                            table.insert(targetMessages, {
                                channel = value2.meta.textChannel,
                                messageId = value2.id,
                                presetId = value2.meta.presetId,
                                presetChatVersion = value2.meta.presetChatVersion
                            })
                        end
                    end

                    return submitChatReport(arg1, { eligibleMessages = eligibleMessages, targetMessages = targetMessages })
                end)
            else
                if arg1.endpoint == "avatar" then
                    return submitAvatarReport(arg1, tbl1.reportAnythingSnapshotRef and tbl1.reportAnythingSnapshotRef.current)
                elseif arg1.endpoint == "place" then
                    return submitPlaceReport(arg1, tbl1.reportAnythingSnapshotRef and tbl1.reportAnythingSnapshotRef.current)
                end

                return Promise.reject("Unknown in-experience submission endpoint: " .. tostring(arg1.endpoint))
            end
        end, {
            tbl1.voiceChatServiceManager,
            tbl1.inExpChatMessagesLoader,
            tbl1.menuOpenTimeRef,
            tbl1.reportAnythingSnapshotRef
        })
    end,
    useInExpClientActionHandlers = function(tbl1)
        local var1 = useVoiceSnapshot(tbl1.voiceChatServiceManager)

        local voice = React.useCallback(function(arg1)
            local current = var1.current
            local tbl2 = {
                sortedPlayerListUserIds = current.sortedPlayerListUserIds,
                channelId = current.channelId,
                voiceUserCount = current.voiceUserCount,
                voiceImpactedUserCount = computeImpactedUserCount(tbl1.voiceChatServiceManager, arg1.data.targetIdStr),
                menuOpenedUnixMilli = tbl1.menuOpenTimeRef.current
            }
            return submitVoiceReport(arg1, tbl2)
        end, { tbl1.voiceChatServiceManager, tbl1.menuOpenTimeRef })

        local chat = React.useCallback(function(arg1)
            local inExpChatMessagesLoader = tbl1.inExpChatMessagesLoader
            if not inExpChatMessagesLoader then
                return Promise.reject("inExpChatMessagesLoader is required for chat reports")
            end

            local textChatMessageId = arg1.data.custom and arg1.data.custom.textChatMessageId

            if textChatMessageId == "__MSG_NOT_SHOWN_ID" then
                return submitChatReportWithoutMessage(arg1)
            end

            return inExpChatMessagesLoader.fetch({}):andThen(function(arg2)
                local eligibleMessages = {}
                local targetMessages = {}
                for _, value in ipairs(arg2 or {}) do
                    for _, value2 in ipairs(value.items or {}) do
                        table.insert(eligibleMessages, { channel = value2.meta.textChannel, messageId = value2.id })
                        if value2.id ~= textChatMessageId then
                            continue
                        end

                        table.insert(targetMessages, {
                            channel = value2.meta.textChannel,
                            messageId = value2.id,
                            presetId = value2.meta.presetId,
                            presetChatVersion = value2.meta.presetChatVersion
                        })
                    end
                end

                return submitChatReport(arg1, { eligibleMessages = eligibleMessages, targetMessages = targetMessages })
            end)
        end, { tbl1.inExpChatMessagesLoader })

        local avatar = React.useCallback(function(arg1)
            return submitAvatarReport(arg1, tbl1.reportAnythingSnapshotRef and tbl1.reportAnythingSnapshotRef.current)
        end, { tbl1.reportAnythingSnapshotRef })

        local place = React.useCallback(function(arg1)
            return submitPlaceReport(arg1, tbl1.reportAnythingSnapshotRef and tbl1.reportAnythingSnapshotRef.current)
        end, { tbl1.reportAnythingSnapshotRef })

        local legacyChat = React.useCallback(function(arg1)
            return submitChatReportWithoutMessage(arg1)
        end, {})

        return (React.useMemo(function()
            return {
                voice = voice,
                chat = chat,
                avatar = avatar,
                place = place,
                legacyChat = legacyChat
            }
        end, {
            voice,
            chat,
            avatar,
            place,
            legacyChat
        }))
    end,
    REPORT_MESSAGE_NOT_SHOWN_ITEM_ID = "__MSG_NOT_SHOWN_ID"
}

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local Telemetry = require(FriendsChatParent.AppChat.Telemetry)
local DefaultTelemetryEvents = require(FriendsChatParent.AppChat.DefaultTelemetryEvents)

return {
    AppChatVisible = Telemetry.new({
        name = "appChatVisible",
        description = "",
        lastUpdated = { 2026, 10, 7 },
        backendsList = {
            DefaultTelemetryEvents.namedCounterConfigurationAndFormat("AppChat.Navigation.Visible", function(tbl1)
                return {
                    isChatEnabled = tbl1.isChatEnabled,
                    isChatLoading = tbl1.isChatLoading,
                    isInConversation = tbl1.isInConversation
                }
            end),
            DefaultTelemetryEvents.eventIngestWithFormatFunction(function(tbl1)
                return {
                    isChatEnabled = tbl1.isChatEnabled,
                    isChatLoading = tbl1.isChatLoading
                }
            end)
        }
    }),
    AppChatClosed = Telemetry.new({
        name = "appChatClosed",
        description = "",
        lastUpdated = { 2026, 7, 7 },
        backendsList = {
            DefaultTelemetryEvents.namedCounterConfigurationAndFormat("AppChat.Navigation.Closed", function(tbl1)
                return {
                    isChatEnabled = tbl1.isChatEnabled,
                    isChatLoading = tbl1.isChatLoading
                }
            end),
            DefaultTelemetryEvents.eventIngestWithFormatFunction(function(tbl1)
                return {
                    isChatEnabled = tbl1.isChatEnabled,
                    isChatLoading = tbl1.isChatLoading
                }
            end)
        }
    })
}

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _types = require(AppChat.types)

local UIBlox = require(AppChatParent.UIBlox)
local Logger = require(script.Parent.Logger)
local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local memo = React.memo
local useTelemetry = require(AppChat.Telemetry.useTelemetry)
local ChatDetailsTelemetryEvents = require(AppChat.Components.ChatDetails.ChatDetailsTelemetryEvents)
local ChatDialogTelemetryLayer = require(AppChat.Telemetry.Layers.ChatDialogTelemetryLayer)

local ModalBottomSheet = UIBlox.ModalBottomSheet

local tbl1 = {
    conversationId = nil,
    participantId = nil,
    showRemoveUserButton = false,
    showViewProfileButton = true,
    showChatButton = false,
    viewProfileText = "localizedText.ViewProfile",
    chatText = "localizedText.Chat",
    reportUserText = "localizedText.ReportUser",
    removeFromGroupText = "localizedText.RemoveFromGroup",
    cancelText = "localizedText.Cancel",
    openViewProfile = function(_)
        Logger:warning("openViewProfile was not passed to ParticipantDialogDeprecated")
    end,
    openChat = function(...)
        Logger:warning("openChat was not passed to ParticipantDialogDeprecated")
    end,
    openReportUser = function(...)
        Logger:warning("openReportUser was not passed to ParticipantDialogDeprecated")
    end,
    openRemoveUserDialog = function(...)
        Logger:warning("openRemoveUserDialog was not passed to ParticipantDialogDeprecated")
    end,
    onDismiss = function(_)
        Logger:warning("onDismiss was not passed to ParticipantDialogDeprecated")
    end
}

function ParticipantDialogDeprecated(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local var2 = useTelemetry(ChatDialogTelemetryLayer.Context)
    local conversationId = var1.conversationId
    local participantId = var1.participantId
    local showRemoveUserButton = var1.showRemoveUserButton
    local var3 = var1.onDismiss or function() end

    local buttonModels = {}

    local function insertAction(text: string?, onActivated: ((...any) -> (...any))?, bool1: boolean?) -- Luacid: unused: defined but never referenced
        local tbl4 = buttonModels
        local tbl5 = {
            text = text,
            stayOnActivated = if bool1 then true else nil,
            onActivated = 0
        }

        if bool1 then
            onActivated = nil
        end

        tbl5.onActivated = onActivated
        table.insert(tbl4, tbl5)
    end

    if var1.showViewProfileButton then
        local viewProfileText = var1.viewProfileText

        table.insert(buttonModels, {
            text = viewProfileText,
            stayOnActivated = nil,
            onActivated = function()
                Logger:info("User activated viewProfile | userId: {}", participantId)
                var1.openViewProfile(participantId)
            end
        })
    end
    if var1.showChatButton then
        local chatText = var1.chatText

        table.insert(buttonModels, {
            text = chatText,
            stayOnActivated = nil,
            onActivated = function()
                Logger:info("User activated openChat | userId: {}", participantId)
                var2.emit(ChatDetailsTelemetryEvents.ParticipantDialogChatClicked, {})
                var1.openChat(participantId)
            end
        })
    end
    local reportUserText = var1.reportUserText

    table.insert(buttonModels, {
        text = reportUserText,
        stayOnActivated = nil,
        onActivated = function()
            Logger:info("User activated reportUser | userId: {}, conversationId: {}", participantId, conversationId)
            var2.emit(ChatDetailsTelemetryEvents.ParticipantDialogReportUserClicked, {})
            var1.openReportUser(participantId, conversationId)
        end
    })
    if showRemoveUserButton then
        local removeFromGroupText = var1.removeFromGroupText

        table.insert(buttonModels, {
            text = removeFromGroupText,
            stayOnActivated = nil,
            onActivated = function()
                var1.openRemoveUserDialog(participantId, conversationId)
            end
        })
    end
    local cancelText = var1.cancelText
    table.insert(buttonModels, { text = cancelText, stayOnActivated = nil, onActivated = var3 })

    return React.createElement(
        ModalBottomSheet,
        {
            bottomGap = 10,
            onDismiss = var3,
            buttonModels = buttonModels,
            screenWidth = 400,
            showImages = false
        }
    )
end

return memo(ParticipantDialogDeprecated)

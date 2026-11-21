-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatLineReporting = script:FindFirstAncestor("ChatLineReporting")
local ChatLineReportingParent = ChatLineReporting.Parent

local React = require(ChatLineReportingParent.React)
local ExpChatShared = require(ChatLineReportingParent.ExpChatShared)
local ButtonType = require(ChatLineReportingParent.UIBlox).App.Button.Enum.ButtonType
local ReportCompleteDialog = require(ChatLineReportingParent.GenericAbuseReporting.ReportCompleteDialog)
local LocalPlayer = game:GetService("Players").LocalPlayer
local useLocalization = require(ChatLineReportingParent.Localization).Hooks.useLocalization

local Constants = require(ChatLineReporting.Common.Constants)
local getDisplayNameFromUserId = require(ChatLineReporting.Common.getDisplayNameFromUserId)
local getPlayer = require(ChatLineReporting.Common.getPlayer)
local mutePlayer = require(ChatLineReporting.Common.mutePlayer)
local sendSystemMessage = require(ChatLineReporting.Common.sendSystemMessage)

local function ChatLineReportCompleteModal(tbl1)
    local context = ExpChatShared.context
    local var1 = useLocalization(tbl1.localizationKeys)

    local var2 = nil
    if context.store then
        var2 = getPlayer(context.store:getState().Players.byUserId, tbl1.selectedMessage.userId)
        var2 = var2 == nil
            and {
                displayName = getDisplayNameFromUserId(tbl1.selectedMessage.userId),
                userId = tbl1.selectedMessage.userId,
                username = ""
            }
            or var2
    end

    local var3 = useLocalization({
        completeMute = {
            "Feature.ReportAbuse.Action.TextMute",
            name = var2 and var2.displayName or ""
        },
        systemMuteMessage = {
            "Feature.ReportAbuse.Message.UserTextMutedSystem",
            name = var2 and var2.displayName or ""
        }
    })

    local tbl2 = {
        buttonType = ButtonType.PrimarySystem,
        props = {
            onActivated = function()
                tbl1.onDismiss(nil, "")
            end,
            text = var1.completeClose
        }
    }

    return React.createElement(ReportCompleteDialog, {
        buttonStackInfo = {
            forceFillDirection = Enum.FillDirection.Vertical,
            buttons = LocalPlayer and {
                {
                    buttonType = ButtonType.Secondary,
                    props = {
                        onActivated = function()
                            local var4 = mutePlayer(var2, LocalPlayer, tbl1.selectedMessage.isUniverseChat)
                            if var4 and var4.key == Constants.SuccessfulMuteKey then
                                sendSystemMessage(var3.systemMuteMessage)
                            end
                            tbl1.onDismiss(var4)
                        end,
                        text = var3.completeMute
                    }
                },
                tbl2
            } or { tbl2 }
        },
        localizationKeys = tbl1.localizationKeys,
        onDismiss = function()
            tbl1.onDismiss(nil, "")
        end
    })
end

return ChatLineReportCompleteModal

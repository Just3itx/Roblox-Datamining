-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:00:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local CorePackages = game:GetService("CorePackages")

local _Cryo = require(CorePackages.Packages.Cryo)
local Types = require(script.Parent.Parent.Types)
local maybeAssert = require(script.Parent.Parent.Helpers.maybeAssert)
local AddMessage = require(script.Parent.AddMessage)
local RemoveMessage = require(script.Parent.RemoveMessage)
local getSettingsForMessage = require(script.Parent.Parent.Helpers.getSettingsForMessage)

local num1 = game:DefineFastInt("BubbleChatAddMessageRolloutPercent", 100)

local function addMessageWithTimeout(arg1)
    maybeAssert(Types.IMessage(arg1))

    return function(arg2)
        arg2:dispatch(AddMessage(arg1))

        local settingsForMessage = getSettingsForMessage(arg2:getState().chatSettings, arg1)
        local var1 = arg2:getState().userMessages[arg1.userId]
        local messages = arg2:getState().messages
        for i = 1, #var1 - settingsForMessage.MaxBubbles do
            arg2:dispatch(RemoveMessage(messages[var1[i]]))
        end

        RbxAnalyticsService:ReportCounter("RoactBubbleChat-MessagesSent")
        if num1 >= math.random(1, 100) then
            RbxAnalyticsService:SendEventDeferred(
                "client",
                "bubbleChatMetric",
                "messageAdded",
                {
                    placeId = game.PlaceId,
                    senderUserId = arg1.userId
                }
            )
        end
        wait(settingsForMessage.BubbleDuration)

        arg2:dispatch(RemoveMessage(arg1))
    end
end

return addMessageWithTimeout

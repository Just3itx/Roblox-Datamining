-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local CorePackages = game:GetService("CorePackages")
local ExpChat = require(CorePackages.Workspace.Packages.ExpChat)

local Types = require(script.Parent.Parent.Types)
local maybeAssert = require(script.Parent.Parent.Helpers.maybeAssert)
local AddMessageWithTimeout = require(script.Parent.AddMessageWithTimeout)

local function addMessageFromEvent(arg1)
    maybeAssert(Types.IMessageData(arg1))

    return function(arg2)
        local success, result = pcall(function(): Player?
            return Players:GetPlayerByUserId(arg1.SpeakerUserId)
        end)

        if not success or not result then
            return
        end

        local character = result.Character

        if not character then
            return
        end

        local tbl1 = {
            id = tostring(arg1.ID),
            userId = tostring(arg1.SpeakerUserId),
            name = arg1.FromSpeaker,
            text = arg1.Message or "",
            timestamp = arg1.Time,
            adornee = character
        }

        ExpChat.Events.LegacyBubbleCreated(tbl1)

        return arg2:dispatch(AddMessageWithTimeout(tbl1))
    end
end

return addMessageFromEvent

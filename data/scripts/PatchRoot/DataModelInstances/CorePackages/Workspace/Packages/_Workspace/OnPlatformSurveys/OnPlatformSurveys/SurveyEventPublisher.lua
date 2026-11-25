-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local MessageBus = require(scriptParentParent.MessageBus).MessageBus
local t = require(scriptParentParent.t)

local WebViewEventType = require(scriptParent.Enums.WebViewEventType)

local OPEN_SURVEY_EVENT_DESCRIPTOR = {
    mid = MessageBus.getMessageId("Game", "openSurvey"),
    validateParams = t.strictInterface({ eventType = t.valueOf(WebViewEventType), customProps = t.optional(t.table) })
}

return {
    publishSurveyEvent = function(eventType)
        MessageBus.publish(OPEN_SURVEY_EVENT_DESCRIPTOR, { eventType = eventType })
    end,
    OPEN_SURVEY_EVENT_DESCRIPTOR = OPEN_SURVEY_EVENT_DESCRIPTOR
}

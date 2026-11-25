-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local EventIngestService = game:GetService("EventIngestService")
local HttpService = game:GetService("HttpService")

local getPlatformTarget = require(VirtualEvents.Parent.Analytics).getPlatformTarget
local logger = require(VirtualEvents.logger)

local function sendEventDeferred(eventName: string, tbl1)
    logger:debug(string.format("Fired %q with payload %s", eventName, HttpService:JSONEncode(tbl1)))
    EventIngestService:SendEventDeferred(getPlatformTarget(), "virtualEvents", eventName, tbl1)
end

return sendEventDeferred

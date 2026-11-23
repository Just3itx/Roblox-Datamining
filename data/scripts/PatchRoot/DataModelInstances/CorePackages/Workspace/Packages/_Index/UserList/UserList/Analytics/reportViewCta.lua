-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserList = script:FindFirstAncestor("UserList")

local Enums = require(UserList.Common.Enums)
local _Types = require(UserList.Common.Types)
local telemetryEmitter = require(UserList.Analytics.telemetryEmitter)
local userListInteractionEvent = require(UserList.Analytics.userListInteractionEvent)

local ButtonTypes = Enums.ButtonTypes

local function reportViewCta(arg1)
    if arg1 == nil then
        return
    end

    local tbl1 = {
        eventContext = arg1.surface,
        eventName = "ViewCta",
        subpage = arg1.subpage,
        buttonType = ButtonTypes.View
    }

    pcall(telemetryEmitter.emit, userListInteractionEvent, tbl1)
end

return reportViewCta

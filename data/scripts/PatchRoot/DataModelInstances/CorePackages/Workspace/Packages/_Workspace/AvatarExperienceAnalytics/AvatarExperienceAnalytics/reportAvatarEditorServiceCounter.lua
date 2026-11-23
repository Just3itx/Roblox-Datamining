-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Constants = require(script.Parent.Constants)
local sendAXCounterV2 = require(script.Parent.sendAXCounterV2)

local AVATAR_EDITOR_SERVICE_COUNTER_STATUS = Constants.AVATAR_EDITOR_SERVICE_COUNTER_STATUS

local function reportAvatarEditorServiceCounter(str1: string, status, arg1)
    local tbl1 = { status = status }

    if status == AVATAR_EDITOR_SERVICE_COUNTER_STATUS.Error and arg1 ~= nil then
        tbl1.message = string.sub(if typeof(arg1) == "EnumItem" then arg1.Name else tostring(arg1), 1, 256)
    end

    sendAXCounterV2(str1, tbl1)
end

return reportAvatarEditorServiceCounter

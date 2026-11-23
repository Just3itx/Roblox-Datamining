-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:21:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local Signal = require(AppChatParent.AppCommonLib).Signal

local _MessageFtuxTooltipVariant = require(script.Parent.MessageFtuxTooltipVariant)

local module = {
    dismissed = Signal.new()
}

function module.dismiss(arg1)
    module.dismissed:fire(arg1)
end

return module

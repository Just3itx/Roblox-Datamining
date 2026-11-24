-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:51:31Z
-- Luau bytecode version: 14 | Luau type version: 3
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
return require(ExpChatParent.Rodux).combineReducers({
    isChatInputBarEnabled = require(script.isChatInputBarEnabled),
    isChatWindowEnabled = require(script.isChatWindowEnabled),
    isChatHotkeyEnabled = require(script.isChatHotkeyEnabled),
    isChannelBarEnabled = require(script.isChannelBarEnabled),
    transparency = require(script.transparency)
})

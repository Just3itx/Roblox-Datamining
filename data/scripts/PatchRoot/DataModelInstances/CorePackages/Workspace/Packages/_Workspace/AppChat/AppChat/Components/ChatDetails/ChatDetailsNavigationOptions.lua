-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local GetFFlagIsSquadEnabled = require(AppChatParent.SharedFlags).GetFFlagIsSquadEnabled
local FFlagDebugAppChatEnableDomLocators = require(AppChat.Flags.FFlagDebugAppChatEnableDomLocators)
local DomLocators = require(AppChat.Utils.DomLocators)

local module = {}

function module.getHeaderText()
    return {
        raw = if GetFFlagIsSquadEnabled() then "Feature.Chat.Label.Details" else "Feature.Chat.Label.ChatDetails",
        shouldLocalize = true
    }
end

function module.getIsRooted(tbl1)
    return tbl1 and tbl1.getParam and tbl1.getParam("isRooted", false) or false
end

function module.getNavigationOptions(tbl1, tbl2)
    local navigation = tbl1 and tbl1.navigation
    local tbl3 = {
        headerText = module.getHeaderText(),
        backButtonTestId = if FFlagDebugAppChatEnableDomLocators then DomLocators.chatDetailsTopBarActionButton("back") else nil,
        backButtonEnabled = true,
        isRoot = module.getIsRooted(navigation)
    }
    return Cryo.Dictionary.join(tbl3, tbl2 or {})
end

function module.getTopBarConfig(tbl1)
    return {
        headerText = module.getHeaderText(),
        backButtonEnabled = true,
        isRoot = module.getIsRooted(tbl1)
    }
end

return module

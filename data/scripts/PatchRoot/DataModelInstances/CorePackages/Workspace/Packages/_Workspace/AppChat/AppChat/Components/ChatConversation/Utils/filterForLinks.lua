-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:50:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local ArgCheck = require(AppChatParent.ArgCheck)
local EnumMessageTypes = require(AppChat.Components.ChatConversation.EnumMessageTypes)

local formatMessages = require(script.Parent.formatMessages)
local separateRobloxUrlsFromText = require(script.Parent.RobloxUrlUtils.separateRobloxUrlsFromText)

local FFlagAppChatPlusReferralAssetCard = require(AppChat.Flags.FFlagAppChatPlusReferralAssetCard)

return function(arg1, arg2)
    ArgCheck.isType(arg1, "table", "filterForLinks.text")
    ArgCheck.isType(arg2, "table", "filterForLinks.whitelistedDomains")

    if arg1.messageType == EnumMessageTypes.System then
        return { arg1 }
    elseif arg1.messageType == EnumMessageTypes.Link and not (arg1.gameLink and arg1.gameLink.universeId) then
        return { Cryo.Dictionary.join(arg1, { messageType = Cryo.None }) }
    elseif not arg1.content
        or arg1.moderated
        or not (arg1.content:lower():match("%/games[^%d]*(%d+)/?")
            or arg1.content:match("%/share%?.*code=([%w%-]+)")
            or FFlagAppChatPlusReferralAssetCard and arg1.content:match("%/plus%-referral%?.*code=([%w%-]+)"))
    then
        return { arg1 }
    end
    return formatMessages(separateRobloxUrlsFromText(arg1.content), arg1)
end

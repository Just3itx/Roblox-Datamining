-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local UIBlox = require(ExpChatParent.UIBlox)

local summaryMessageRichText = require(ExpChat.summaryMessageRichText)

local bool1 = game:DefineFastFlag("ExpChatAlignSystemMessageStyling", false)

local function generateRichSystemMessageTextFormat(str1: string, bool2: boolean?, func1: ((...any) -> (...any))?)
    if bool1 and not bool2 and func1 == nil then
        return summaryMessageRichText.wrapInSummaryMutedStyle(str1)
    end
    local var1 = string.format(
        "<font color=\"#%s\">%s</font>",
        if bool2 then UIBlox.App.Style.Colors.Red:ToHex() else UIBlox.App.Style.Colors.LightGrey:ToHex(),
        str1
    )

    if func1 then
        var1 = func1(var1)
    end

    return var1
end

return generateRichSystemMessageTextFormat

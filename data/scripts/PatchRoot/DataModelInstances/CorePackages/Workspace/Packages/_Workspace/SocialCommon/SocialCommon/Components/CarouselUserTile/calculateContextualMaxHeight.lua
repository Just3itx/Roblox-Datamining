-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCommonParent = script:FindFirstAncestor("SocialCommon").Parent
local AppCommonLibText = require(SocialCommonParent.AppCommonLib).Text
local Constants = require(script.Parent.Constants)
local _UIBlox = require(SocialCommonParent.UIBlox)

return function(tbl1)
    local var1 = tbl1 and tbl1.nameTopPadding or Constants.NAME_TOP_PADDING
    local var2 = tbl1 and tbl1.contextualTopPadding or Constants.CONTEXTUAL_TOP_PADDING
    local var3 = tbl1 and tbl1.maxLinesNumber or Constants.LINES_MAX

    local font = tbl1.font

    local textHeight = AppCommonLibText.GetTextHeight("", font.CaptionHeader.Font, font.BaseSize * font.CaptionHeader.RelativeSize, 10000)
    local var4 = AppCommonLibText.GetTextHeight("", font.CaptionBody.Font, font.BaseSize * font.CaptionBody.RelativeSize, 10000) * var3

    return var1 + textHeight + var2 + var4
end

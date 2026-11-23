-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Cryo = require(AppChatParent.Cryo)

return function(arg1)
    local tbl1 = {
        TextDefault = {
            Color = arg1.Theme.TextEmphasis.Color,
            Transparency = arg1.Theme.TextEmphasis.Transparency
        }
    }

    local tbl2 = {
        Body = {
            Font = arg1.Font.Header1.Font,
            RelativeSize = arg1.Font.Body.RelativeSize,
            RelativeMinSize = arg1.Font.Body.RelativeMinSize
        },
        CaptionBody = {
            Font = arg1.Font.Header1.Font,
            RelativeSize = arg1.Font.CaptionBody.RelativeSize,
            RelativeMinSize = arg1.Font.CaptionBody.RelativeMinSize
        }
    }

    return {
        Theme = Cryo.Dictionary.join(arg1.Theme, tbl1),
        Font = Cryo.Dictionary.join(arg1.Font, tbl2),
        Settings = nil,
        Tokens = arg1.Tokens
    }
end

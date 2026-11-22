-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InlineRichText = script:FindFirstAncestor("InlineRichText")
local InlineRichTextParent = InlineRichText.Parent

local LinkType = require(InlineRichText.Enums.LinkType)
local default = require(InlineRichTextParent.LinkingProtocol).LinkingProtocol.default

local tbl1 = {
    {
        isLinkType = function(str1: string): boolean
            return string.match(str1, "^https://") ~= nil
        end,
        type = LinkType.Http
    },
    {
        isLinkType = function(str1: string)
            local var1, var2 = default:isURLRegistered(str1):await()
            return var1 and var2
        end,
        type = LinkType.LinkingProtocolRegistered
    },
    {
        isLinkType = function(_: string): boolean
            return true
        end,
        type = LinkType.Default
    }
}

local function getLinkType(str1: string)
    for _, value in tbl1 do
        if value.isLinkType(str1) then
            return value.type
        end
    end
    return LinkType.Default
end

return getLinkType

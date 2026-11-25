-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheetParent = script:FindFirstAncestor("ShareSheet").Parent

local default = require(ShareSheetParent.ExternalContentSharingProtocol).ExternalContentSharingProtocol.default

local function copyLink(tbl1)
    default:setClipboardText({ context = tbl1.context, text = tbl1.url })
end

return copyLink

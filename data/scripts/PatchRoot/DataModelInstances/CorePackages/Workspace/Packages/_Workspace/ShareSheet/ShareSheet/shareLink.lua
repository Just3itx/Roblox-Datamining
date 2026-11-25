-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheetParent = script:FindFirstAncestor("ShareSheet").Parent

local default = require(ShareSheetParent.ExternalContentSharingProtocol).ExternalContentSharingProtocol.default

local function shareLink(tbl1)
    default:shareUrl({ context = tbl1.context, url = tbl1.url })
end

return shareLink

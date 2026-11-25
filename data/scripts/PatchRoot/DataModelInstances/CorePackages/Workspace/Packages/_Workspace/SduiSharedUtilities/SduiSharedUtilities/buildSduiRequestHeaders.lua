-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilitiesParent = script:FindFirstAncestor("SduiSharedUtilities").Parent
local MrRouterHeaders = require(SduiSharedUtilitiesParent.Http).MrRouterHeaders

local function buildSduiRequestHeaders(accept: string, contentType: string?)
    local tbl1 = ({})
    tbl1.Accept = accept
    if contentType ~= nil then
        tbl1["Content-Type"] = contentType
    end
    return MrRouterHeaders.injectMrRouterHeaders(tbl1)
end

return buildSduiRequestHeaders

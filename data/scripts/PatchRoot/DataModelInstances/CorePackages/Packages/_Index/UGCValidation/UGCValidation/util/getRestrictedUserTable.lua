-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local success, result = pcall(function(): StudioService
    return game:GetService("StudioService")
end)
if not success then
    result = nil
end
local scriptParentParent = script.Parent.Parent

local _Types = require(scriptParentParent.util.Types)

local function getRestrictedUserTable(): {[any]: any} | {{creatorType: string, id: any}}
    return if result then {{
        creatorType = "User",
        id = result:GetUserId()
    }} else {}
end

return getRestrictedUserTable

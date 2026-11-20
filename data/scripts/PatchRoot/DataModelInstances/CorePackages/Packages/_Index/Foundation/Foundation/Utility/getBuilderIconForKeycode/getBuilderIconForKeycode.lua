-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local getBuilderIconForKeycode = require(FoundationParent.BuilderIcons).getBuilderIconForKeycode

return function(arg1)
    local success, result = pcall(function()
        return getBuilderIconForKeycode(arg1)
    end)
    return if success then result else nil
end

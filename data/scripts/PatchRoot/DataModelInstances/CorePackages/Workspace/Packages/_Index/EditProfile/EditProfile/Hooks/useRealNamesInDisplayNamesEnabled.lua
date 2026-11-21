-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfileParent = script:FindFirstAncestor("EditProfile").Parent
local useAppPolicy = require(EditProfileParent.UniversalAppPolicy).useAppPolicy

return function()
    return useAppPolicy(function(arg1)
        return arg1.getRealNamesInDisplayNamesEnabled()
    end)
end

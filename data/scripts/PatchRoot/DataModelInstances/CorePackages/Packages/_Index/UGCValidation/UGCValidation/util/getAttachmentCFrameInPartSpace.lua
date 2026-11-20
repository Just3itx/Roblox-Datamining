-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:21:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local R15plusUtils = require(scriptParentParent.util.R15plusUtils)

return function(arg1)
    if not R15plusUtils.checkFlagEnabledForAllowHrd() then
        return arg1.CFrame
    end
    local cFrame = arg1.CFrame
    local parent = arg1.Parent
    while parent and parent:IsA("Attachment") do
        cFrame = parent.CFrame * cFrame
        parent = parent.Parent
    end
    return cFrame
end

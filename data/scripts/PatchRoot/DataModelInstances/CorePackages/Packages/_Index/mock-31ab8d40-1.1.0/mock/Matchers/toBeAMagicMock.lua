-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local MagicMock = require(scriptParentParent.MagicMock)

return function(arg1)
    local pass = MagicMock.is(arg1)
    return {
        pass = pass,
        message = if pass then "Expected object to be anything but a MagicMock." else string.format("Expected object to be a MagicMock. Got %q instead.", tostring(arg1))
    }
end

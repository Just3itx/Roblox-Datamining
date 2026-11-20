-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Spy = require(scriptParentParent.Spy)

return function(arg1)
    local pass = Spy.is(arg1)
    return {
        pass = pass,
        message = if pass then "Expected object to be anything but a Spy." else string.format("Expected object to be a Spy. Got %q instead.", tostring(arg1))
    }
end

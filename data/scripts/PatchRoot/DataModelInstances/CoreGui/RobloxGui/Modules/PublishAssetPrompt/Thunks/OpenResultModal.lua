-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local OpenResultModal = require(scriptParentParent.Actions.OpenResultModal)

return function(arg1)
    return function(arg2)
        arg2:dispatch(OpenResultModal(arg1))
    end
end

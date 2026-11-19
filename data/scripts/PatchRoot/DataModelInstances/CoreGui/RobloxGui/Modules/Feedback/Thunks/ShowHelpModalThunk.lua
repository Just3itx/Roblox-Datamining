-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ShowHelpModal = require(scriptParentParent.Actions.ShowHelpModal)

return function(arg1)
    return function(arg2)
        arg2:dispatch(ShowHelpModal(arg1))
    end
end

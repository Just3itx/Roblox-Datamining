-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local CloseResultModal = require(scriptParentParent.Actions.CloseResultModal)

return function(arg1)
    arg1:dispatch(CloseResultModal())
end

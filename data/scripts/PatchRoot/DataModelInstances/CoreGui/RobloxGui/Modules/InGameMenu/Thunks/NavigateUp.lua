-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local SetCurrentPage = require(scriptParentParent.Actions.SetCurrentPage)
local Pages = require(scriptParentParent.Components.Pages)

return function(arg1)
    local state = arg1:getState()
    arg1:dispatch(SetCurrentPage(Pages.pagesByKey[state.menuPage].parentPage))
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:20:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local createNavigator = require(script.Parent.createNavigator)
local SwitchRouter = require(scriptParentParent.routers.SwitchRouter)
local SwitchView = require(scriptParentParent.views.SwitchView.SwitchView)

return function(arg1, arg2)
    arg2 = arg2 == nil and {} or arg2

    local var1 = SwitchRouter(arg1, arg2)

    return createNavigator(SwitchView, var1, arg2)
end

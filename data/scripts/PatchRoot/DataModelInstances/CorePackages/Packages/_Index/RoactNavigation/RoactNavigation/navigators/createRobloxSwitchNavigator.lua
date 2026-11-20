-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:20:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local createNavigator = require(script.Parent.createNavigator)
local SwitchRouter = require(scriptParentParent.routers.SwitchRouter)
local RobloxSwitchView = require(scriptParentParent.views.RobloxSwitchView)

return function(arg1, arg2)
    local var1 = SwitchRouter(arg1, arg2)

    return createNavigator(RobloxSwitchView, var1, arg2 or {})
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:20:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local createNavigator = require(script.Parent.createNavigator)
local StackRouter = require(scriptParentParent.routers.StackRouter)
local StackView = require(scriptParentParent.views.RobloxStackView.StackView)

return function(arg1, arg2)
    local var1 = StackRouter(arg1, arg2)

    return createNavigator(StackView, var1, arg2 or {})
end

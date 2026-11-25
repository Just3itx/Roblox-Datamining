-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local ReactUtils = require(scriptParentParentParent.ReactUtils)

local UserInputService = game:GetService("UserInputService")

local React = require(scriptParentParentParent.React)

local useEventConnection = ReactUtils.useEventConnection

local InputUtilities = require(scriptParentParent.Utils.InputUtilities)

return function()
    local var1, var2 = React.useState(false)

    local var3 = React.useCallback(function(arg1)
        if InputUtilities.isTouchInput(arg1) then
            var2(true)
        end
    end, { var2 })

    local var4 = React.useCallback(function(arg1)
        if InputUtilities.isTouchInput(arg1) then
            var2(false)
        end
    end, { var2 })

    useEventConnection(UserInputService.InputBegan, var3)
    useEventConnection(UserInputService.InputEnded, var4)

    return var1
end

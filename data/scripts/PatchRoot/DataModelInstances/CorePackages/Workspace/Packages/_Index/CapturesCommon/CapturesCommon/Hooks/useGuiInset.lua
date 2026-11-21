-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

local React = require(scriptParentParentParent.React)
local useEventConnection = require(scriptParentParentParent.ReactUtils).useEventConnection

local function func1() -- Luacid: Inlined by compiler; 2 call sites recovered
    local vector2, vector2_2 = GuiService:GetGuiInset()
    return {
        bottom = vector2_2.Y,
        left = vector2.X,
        right = vector2_2.X,
        top = vector2.Y
    }
end

return function()
    local var1, var2 = React.useState((func1()))

    local function func2()
        var2((func1()))
    end

    useEventConnection(GuiService.SafeZoneOffsetsChanged, func2)
    useEventConnection(UserInputService:GetPropertyChangedSignal("BottomBarSize"), func2)
    useEventConnection(UserInputService:GetPropertyChangedSignal("RightBarSize"), func2)

    return var1
end

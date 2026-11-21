-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local useEventConnection = require(ChatUIPrimitivesParent.ReactUtils).useEventConnection

local function resolveLayoutMode(arg1): string -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg1.PreferredInput == Enum.PreferredInput.Gamepad then
        return "FlyOut"
    end

    if arg1.TouchEnabled and not arg1.MouseEnabled then
        return "Tray"
    end

    return "FlyOut"
end

local function useLayoutMode(arg1)
    local var1 = arg1 or UserInputService
    local var2, var3 = React.useState(function(): string
        return resolveLayoutMode(var1)
    end)

    local var4 = React.useCallback(function()
        var3((resolveLayoutMode(var1)))
    end, { var1 })
    useEventConnection(var1:GetPropertyChangedSignal("PreferredInput"), var4)

    return var2
end

return useLayoutMode

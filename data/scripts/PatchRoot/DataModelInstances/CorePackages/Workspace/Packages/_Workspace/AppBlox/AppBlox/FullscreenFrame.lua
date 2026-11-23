-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent

local React = require(AppBloxParent.React)
local Cryo = require(AppBloxParent.Cryo)
local Display = require(AppBloxParent.Display)
local useSelector = require(AppBloxParent.RoactUtils).Hooks.RoactRodux.useSelector
local useSignalState = require(AppBloxParent.SignalsReact).useSignalState

return React.forwardRef(function(arg1, ref) -- name: FullscreenFrame
    local var1 = useSelector(function(arg2)
        return arg2.GlobalGuiInset
    end)
    local var2 = useSignalState(Display.GetDisplayStore().getDeviceSafePadding)

    local var3 = Cryo.Dictionary.join({
        Position = UDim2.new(0, -var1.left - var2.left, 0, -var1.top - var2.top),
        Size = UDim2.new(1, var1.left + var1.right + var2.left + var2.right, 1, var1.top + var1.bottom + var2.top + var2.bottom),
        BackgroundTransparency = 1,
        ref = ref
    }, arg1 or {})

    return React.createElement("Frame", var3)
end)

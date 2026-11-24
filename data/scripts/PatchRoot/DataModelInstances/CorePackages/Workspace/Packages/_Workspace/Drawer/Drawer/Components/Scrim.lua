-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T06:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DrawerParent = script:FindFirstAncestor("Drawer").Parent
local React = require(DrawerParent.React)

local useTokens = require(DrawerParent.Foundation).Hooks.useTokens

local bool1 = game:DefineFastFlag("DrawerScrimCanBeModal", false)

return (React.forwardRef(function(tbl1, ref)
    local var1 = useTokens()

    return React.createElement("TextButton", {
        ref = ref,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = tbl1.transparencyBinding,
        BackgroundColor3 = var1.Color.Common.Scrim.Color3,
        ClipsDescendants = false,
        Text = "",
        AutoButtonColor = false,
        ZIndex = tbl1.zIndex,
        [React.Change.AbsoluteSize] = tbl1.onSizeChanged,
        [React.Event.Activated] = tbl1.onActivated,
        BorderSizePixel = 0,
        Modal = if bool1 then tbl1.isModal else nil
    }, tbl1.children)
end))

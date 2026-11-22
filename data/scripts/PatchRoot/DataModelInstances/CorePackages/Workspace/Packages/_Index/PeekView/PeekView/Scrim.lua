-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeekViewParent = script:FindFirstAncestor("PeekView").Parent
local React = require(PeekViewParent.React)
local useDesignTokens = require(PeekViewParent.Style).useDesignTokens
local ReactOtter = require(PeekViewParent.ReactOtter)
local bool1 = game:DefineFastFlag("RemovePeekViewScrimBorder", false)

return (React.forwardRef(function(tbl1, ref)
    local var1 = useDesignTokens()

    local var2, var3 = React.useState(true)
    local var4 = var2
    local var5 = var3
    local backgroundTransparency, var7 = ReactOtter.useAnimatedBinding(1)
    local var8 = var7
    React.useEffect(function()
        var8(ReactOtter.spring(if var4 then 0.35 else 1))
    end, { var4 })

    local createElement = React.createElement
    local tbl2 = {
        ref = ref,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = backgroundTransparency,
        BackgroundColor3 = var1.Color.Common.Scrim.Color3,
        ClipsDescendants = false,
        Text = "",
        AutoButtonColor = false
    }

    tbl2[React.Event.Activated] = function()
        if tbl1.onActivated then
            tbl1.onActivated()
        end
        var5(not var4)
    end
    tbl2[React.Change.AbsoluteSize] = tbl1.onSizeChanged
    tbl2.BorderSizePixel = if bool1 then 0 else nil
    return createElement("TextButton", tbl2, tbl1.children)
end))

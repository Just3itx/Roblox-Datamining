-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local Cryo = require(SduiSharedContentParent.Cryo)
local _SduiCompat = require(SduiSharedContentParent.SduiCompat)

local SduiText = require(script.Parent.SduiText)
local useShimmerText = require(script.Parent.useShimmerText)

local function SduiShimmerText(arg1)
    local var1 = useShimmerText({
        animationSpeed = arg1.animationSpeed,
        children = arg1.children,
        gradientOffset = arg1.gradientOffset,
        isShimmerEnabled = arg1.isShimmerEnabled,
        textStyle = arg1.textStyle
    })
    local var2 = React.useMemo(function()
        return Cryo.Dictionary.join(arg1, {
            animationSpeed = Cryo.None,
            children = Cryo.None,
            gradientOffset = Cryo.None,
            isShimmerEnabled = Cryo.None,
            textStyle = var1.textStyle
        })
    end, { arg1, var1.textStyle })

    return React.createElement(SduiText, var2, var1.children)
end

return SduiShimmerText

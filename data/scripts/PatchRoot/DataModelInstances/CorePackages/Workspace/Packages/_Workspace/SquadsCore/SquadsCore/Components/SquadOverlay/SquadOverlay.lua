-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCoreParent = script:FindFirstAncestor("SquadsCore").Parent

local Cryo = require(SquadsCoreParent.Cryo)

local SquadPrompt = require(script.Parent.SquadPrompt)

local Foundation = require(SquadsCoreParent.Foundation)
local React = require(SquadsCoreParent.React)
local useSelector = require(SquadsCoreParent.RoactUtils).Hooks.RoactRodux.useSelector

local useTokens = Foundation.Hooks.useTokens

function SquadOverlay()
    local var1 = useTokens()
    local screenSize, var3 = React.useState(Vector2.new(0, 0))

    local var4 = useSelector(function(arg1)
        return arg1.Squad.SquadPrompt.arguments
    end)

    local createElement = React.createElement
    local tbl1 = {
        Enabled = true,
        IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 12
    }

    tbl1[React.Change.AbsoluteSize] = function(arg1)
        var3(arg1.AbsoluteSize)
    end

    return createElement("ScreenGui", tbl1, {
        Overlay = React.createElement("TextButton", {
            AutoButtonColor = false,
            BackgroundColor3 = var1.Color.Extended.Black.Black_70.Color3,
            BackgroundTransparency = var1.Color.Extended.Black.Black_70.Transparency,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 1, 0),
            Text = ""
        }),
        SquadPrompt = React.createElement(SquadPrompt, Cryo.Dictionary.join(var4, { screenSize = screenSize }))
    })
end

return SquadOverlay

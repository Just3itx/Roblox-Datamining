-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local _ColorNamespace = require(Foundation.Enums.ColorNamespace)
local React = require(FoundationParent.React)
local useTokens = require(Foundation.Providers.Style.useTokens)

local var1 = React.forwardRef(function(tbl1, ref)
    local var1 = useTokens()
    local colorNamespace = tbl1.colorNamespace

    return React.createElement("Frame", {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(-tbl1.offset, -tbl1.offset),
        Size = UDim2.new(1, tbl1.offset * 2, 1, tbl1.offset * 2),
        ref = ref
    }, {
        UICorner = React.createElement("UICorner", { CornerRadius = tbl1.cornerRadius }),
        UIStroke = React.createElement("UIStroke", {
            Color = var1[colorNamespace].Selection.Start.Color3,
            Transparency = var1[colorNamespace].Selection.Start.Transparency,
            Thickness = tbl1.borderWidth
        }, {})
    })
end)

return React.memo(var1)

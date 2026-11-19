-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local React = require(CorePackages.Packages.React)
local t = require(CorePackages.Packages.t)

local scriptParentParentParent = script.Parent.Parent.Parent
local createShallowEqualAndTables = require(scriptParentParentParent.createShallowEqualAndTables)
local FFlagPlayerListReduceRerenders = require(scriptParentParentParent.Flags.FFlagPlayerListReduceRerenders)

local var1 = Roact.PureComponent:extend("CellExtender")

var1.validateProps = t.strictInterface({
    layoutOrder = t.integer,
    size = t.UDim2,
    backgroundStyle = t.strictInterface({ Color = t.Color3, Transparency = t.number }),
    overlayStyle = t.strictInterface({ Color = t.Color3, Transparency = t.number }),
    doubleOverlay = t.boolean
})

function var1.render(arg1)
    return Roact.createElement("Frame", {
        LayoutOrder = arg1.props.layoutOrder,
        Size = arg1.props.size,
        BackgroundTransparency = arg1.props.backgroundStyle.Transparency,
        BackgroundColor3 = arg1.props.backgroundStyle.Color,
        BorderSizePixel = 0
    }, {
        DoubleOverLay = Roact.createElement("Frame", {
            ZIndex = 1,
            Visible = arg1.props.doubleOverlay,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = arg1.props.overlayStyle.Transparency,
            BackgroundColor3 = arg1.props.overlayStyle.Color,
            BorderSizePixel = 0
        }),
        OverlayFrame = Roact.createElement("Frame", {
            ZIndex = 2,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = arg1.props.overlayStyle.Transparency,
            BackgroundColor3 = arg1.props.overlayStyle.Color,
            BorderSizePixel = 0
        })
    })
end

if FFlagPlayerListReduceRerenders then
    return React.memo(var1, createShallowEqualAndTables({ "backgroundStyle" }))
end

return var1

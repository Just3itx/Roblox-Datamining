-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)

local function FreeTrialChipHostView(tbl1)
    return (React.createElement("Frame", {
        AnchorPoint = Vector2.new(1, 0),
        BackgroundTransparency = 1,
        Position = tbl1.position,
        Size = tbl1.size,
        Visible = tbl1.visible,
        ZIndex = tbl1.zIndex,
        [React.Tag] = "data-testid=FreeTrialChipHost",
        [React.Change.AbsoluteSize] = tbl1.onAbsoluteSizeChanged
    }, {
        Align = React.createElement("Frame", {
            AnchorPoint = Vector2.new(1, 0),
            AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundTransparency = 1,
            Position = UDim2.fromScale(1, 0),
            Size = UDim2.fromOffset(0, 0)
        }, {
            Slot = React.createElement(tbl1.slot, { onActivated = tbl1.onActivated, maxWidth = tbl1.maxWidth, hostVisible = tbl1.visible })
        })
    }))
end

return FreeTrialChipHostView

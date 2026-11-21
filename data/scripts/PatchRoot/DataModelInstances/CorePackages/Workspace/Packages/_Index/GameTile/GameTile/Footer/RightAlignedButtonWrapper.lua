-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTileParent = script:FindFirstAncestor("GameTile").Parent
local React = require(GameTileParent.React)

return function(tbl1)
    if not tbl1.Button then
        return tbl1.Content
    end

    return React.createElement(React.Fragment, nil, {
        ListLayout = React.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = tbl1.Padding
            }
        ),
        FooterContentWrapper = React.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                LayoutOrder = -1
            },
            {
                React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Shrink }),
                Content = tbl1.Content
            }
        ),
        Button = tbl1.Button
    })
end

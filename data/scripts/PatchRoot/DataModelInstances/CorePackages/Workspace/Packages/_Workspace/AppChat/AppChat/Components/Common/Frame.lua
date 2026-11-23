-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local React = require(AppChat.Parent.React)

local tbl1 = {
    [Enum.HorizontalAlignment.Center] = {
        [Enum.VerticalAlignment.Center] = {
            anchor = Vector2.new(0.5, 0.5),
            position = UDim2.fromScale(0.5, 0.5)
        },
        [Enum.VerticalAlignment.Top] = {
            anchor = Vector2.new(0.5, 0),
            position = UDim2.fromScale(0.5, 0)
        },
        [Enum.VerticalAlignment.Bottom] = {
            anchor = Vector2.new(0.5, 1),
            position = UDim2.fromScale(0.5, 1)
        }
    },
    [Enum.HorizontalAlignment.Left] = {
        [Enum.VerticalAlignment.Center] = {
            anchor = Vector2.new(0, 0.5),
            position = UDim2.fromScale(0, 0.5)
        },
        [Enum.VerticalAlignment.Top] = {
            anchor = Vector2.new(0, 0),
            position = UDim2.fromScale(0, 0)
        },
        [Enum.VerticalAlignment.Bottom] = {
            anchor = Vector2.new(0, 1),
            position = UDim2.fromScale(0, 1)
        }
    },
    [Enum.HorizontalAlignment.Right] = {
        [Enum.VerticalAlignment.Center] = {
            anchor = Vector2.new(1, 0.5),
            position = UDim2.fromScale(1, 0.5)
        },
        [Enum.VerticalAlignment.Top] = {
            anchor = Vector2.new(1, 0),
            position = UDim2.fromScale(1, 0)
        },
        [Enum.VerticalAlignment.Bottom] = {
            anchor = Vector2.new(1, 1),
            position = UDim2.fromScale(1, 1)
        }
    }
}
local function Frame(tbl2)
    local var1, var2 = React.useMemo(function()
        if tbl2.horizontalAlignment and tbl2.verticalAlignment then
            return tbl1[tbl2.horizontalAlignment][tbl2.verticalAlignment].anchor, tbl1[tbl2.horizontalAlignment][tbl2.verticalAlignment].position
        end

        return nil, nil
    end, { tbl2.horizontalAlignment, tbl2.verticalAlignment })

    return React.createElement("Frame", {
        AnchorPoint = tbl2.AnchorPoint or var1,
        BackgroundColor3 = tbl2.BackgroundColor3,
        BackgroundTransparency = tbl2.BackgroundTransparency or 1,
        BorderSizePixel = 0,
        ClipsDescendants = tbl2.ClipsDescendants,
        LayoutOrder = tbl2.LayoutOrder,
        Position = tbl2.Position or var2,
        Size = tbl2.Size or UDim2.fromScale(1, 1),
        ZIndex = tbl2.ZIndex,
        children = tbl2.children
    })
end

return Frame

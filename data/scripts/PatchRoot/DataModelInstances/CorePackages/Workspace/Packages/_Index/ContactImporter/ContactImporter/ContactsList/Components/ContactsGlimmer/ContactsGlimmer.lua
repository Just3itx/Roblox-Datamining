-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContactImporter = script:FindFirstAncestor("ContactImporter")
local dependencies = require(ContactImporter.dependencies)

local Roact = dependencies.Roact
local UIBlox = dependencies.UIBlox
local Skeleton = dependencies.Foundation.Skeleton

local withStyle = UIBlox.Style.withStyle

local var1 = Roact.PureComponent:extend("ContactsGlimmer")

function var1.render(arg1)
    local props = arg1.props

    return withStyle(function(arg2)
        local createElement = Roact.createElement
        local tbl1 = {
            LayoutOrder = props.layoutOrder,
            Size = UDim2.new(1, 0, 0, 72),
            BackgroundTransparency = 1
        }
        local tbl2 = { entryContent = 0, Divider = 0 }
        local createElement2 = Roact.createElement
        local tbl3 = {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1
        }
        local tbl4 = {
            Layout = Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Bottom,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 0)
            }),
            middleGroup = Roact.createElement("Frame", {
                Size = UDim2.new(1, -68, 1, 0),
                BackgroundTransparency = 1,
                [Roact.Event.Activated] = arg1.openBlankProfileView,
                LayoutOrder = 2,
                BackgroundColor3 = Color3.fromRGB(222, 22, 222)
            }, {
                Layout = Roact.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Vertical,
                    HorizontalAlignment = Enum.HorizontalAlignment.Left,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 10)
                }),
                Padding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, 12) }),
                PlayerName = Roact.createElement(Skeleton, { LayoutOrder = 1, Size = UDim2.fromOffset(90, 14) }),
                ContextualInfo = Roact.createElement(Skeleton, { LayoutOrder = 2, Size = UDim2.fromOffset(160, 14) })
            })
        }
        tbl2.entryContent = createElement2("Frame", tbl3, tbl4)

        tbl2.Divider = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, 1),
            Position = UDim2.new(0, 0, 1, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = arg2.Theme.Divider.Color,
            BackgroundTransparency = arg2.Theme.Divider.Transparency
        })
        return createElement("Frame", tbl1, tbl2)
    end)
end

return var1

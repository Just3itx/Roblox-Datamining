-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:10:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local Cryo = require(VirtualEvents.Parent.Cryo)
local React = require(VirtualEvents.Parent.React)

local uDim = UDim.new(0, 12)

local function FacePile(tbl1)
    local tbl2 = ({})

    for layoutOrder, value2 in (React.useMemo(function()
        if tbl1.desiredFirstUserId then
            local var1 = Cryo.List.find(tbl1.userIds, tbl1.desiredFirstUserId)

            if var1 then
                local var2 = table.clone(tbl1.userIds)
                table.remove(var2, var1)
                table.insert(var2, 1, tbl1.desiredFirstUserId)
                return var2
            end
        end

        return tbl1.userIds
    end, { tbl1.userIds, tbl1.desiredFirstUserId })) do
        local createElement = React.createElement
        local tbl3 = {
            LayoutOrder = layoutOrder,
            BackgroundColor3 = Color3.fromRGB(209, 209, 209),
            Image = ("rbxthumb://type=AvatarHeadShot&id=%s&w=100&h=100"):format(value2),
            Size = UDim2.fromOffset(36, 36)
        }
        local tbl4 = {
            BorderRadius = React.createElement("UICorner", { CornerRadius = UDim.new(0.5, 0) })
        }
        tbl2[value2] = createElement("ImageLabel", tbl3, tbl4)
    end

    return React.createElement(
        "Frame",
        {
            LayoutOrder = tbl1.layoutOrder,
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.XY
        },
        {
            Layout = React.createElement(
                "UIListLayout",
                {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = Enum.FillDirection.Horizontal,
                    Padding = uDim
                }
            ),
            Faces = React.createElement(React.Fragment, nil, tbl2)
        }
    )
end
return FacePile

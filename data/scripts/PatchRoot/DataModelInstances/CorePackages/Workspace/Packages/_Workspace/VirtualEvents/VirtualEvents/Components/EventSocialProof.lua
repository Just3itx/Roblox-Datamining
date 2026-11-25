-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local Cryo = require(VirtualEvents.Parent.Cryo)
local React = require(VirtualEvents.Parent.React)
local Foundation = require(VirtualEvents.Parent.Foundation)

local Image = Foundation.Image

local useTokens = Foundation.Hooks.useTokens

local uDim = UDim.new(0, -8)

local function EventSocialProof(tbl1)
    local var1 = useTokens()

    local var2 = React.useMemo(function()
        return if tbl1.desiredFirstUserId and Cryo.List.find(tbl1.userIds, tbl1.desiredFirstUserId) then tbl1.desiredFirstUserId else tbl1.userIds[1]
    end, { tbl1.userIds, tbl1.desiredFirstUserId })

    local var3 = React.useMemo(function()
        return tbl1.userIds[2] or nil
    end, { tbl1.userIds })

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.XY
    }
    local tbl3 = {
        Layout = React.createElement(
            "UIListLayout",
            {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Horizontal,
                Padding = uDim
            }
        ),
        FirstUser = 0,
        SecondUser = 0
    }
    local element

    if var2 then
        element = React.createElement("Frame", {
            BackgroundColor3 = var1.Inverse.Surface.Surface_300.Color3,
            Size = UDim2.fromOffset(25, 25),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            ZIndex = 3
        }, {
            Corner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) }),
            FirstUserFace = React.createElement(Image, {
                ZIndex = 4,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                tag = "radius-circle",
                Image = ("rbxthumb://type=AvatarHeadShot&id=%s&w=100&h=100"):format(var2),
                backgroundStyle = {
                    Color3 = var1.Color.Shift.Shift_200.Color3,
                    Transparency = 0
                },
                Size = UDim2.fromOffset(20, 20)
            })
        })
    else
        element = nil
    end

    tbl3.FirstUser = element
    local element2

    if var3 then
        element2 = React.createElement("Frame", {
            BackgroundColor3 = var1.Inverse.Surface.Surface_300.Color3,
            Size = UDim2.fromOffset(25, 25),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            ZIndex = 1
        }, {
            Corner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) }),
            SecondUserFace = React.createElement(Image, {
                ZIndex = 2,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                tag = "radius-circle",
                Image = ("rbxthumb://type=AvatarHeadShot&id=%s&w=100&h=100"):format(var3),
                backgroundStyle = {
                    Color3 = var1.Color.Shift.Shift_200.Color3,
                    Transparency = 0
                },
                Size = UDim2.fromOffset(20, 20)
            })
        })
    else
        element2 = nil
    end

    tbl3.SecondUser = element2
    return createElement(str1, tbl2, tbl3)
end

return EventSocialProof

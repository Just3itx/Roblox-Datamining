-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")

local GameTileParent = GameTile.Parent
local Roact = require(GameTileParent.Roact)
local ImageSetLabel = require(GameTileParent.UIBlox).Core.ImageSet.ImageSetLabel
local GetImageData = require(GameTileParent.RobloxAppAssets).GetImageData
local FriendIcon = require(GameTile.Footer.FriendIcon)

local SourceSans = Enum.Font.SourceSans
local sandRed = Color3.fromRGB(117, 117, 117)

local function NumberedIcon(arg1)
    local size = arg1.size
    local layoutOrder = arg1.layoutOrder
    local count = arg1.count

    return Roact.createElement(ImageSetLabel, {
        Size = UDim2.new(0, size, 0, size),
        LayoutOrder = layoutOrder,
        Image = GetImageData("LuaApp/graphic/gr-counter-slot-32x32") or "LuaApp/graphic/gr-counter-slot-32x32",
        BackgroundTransparency = 1
    }, {
        Count = Roact.createElement("TextLabel", {
            Size = UDim2.new(0.5, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Font = SourceSans,
            TextSize = 15,
            Text = "+" .. count,
            TextColor3 = sandRed,
            BackgroundTransparency = 1
        })
    })
end

local var1 = Roact.PureComponent:extend("UserIconList")

var1.defaultProps = {
    users = {}
}

function var1.render(arg1)
    local width = arg1.props.width
    local height = arg1.props.height
    local layoutOrder = arg1.props.layoutOrder
    local users = arg1.props.users
    local usersLen = #users
    local num1 = 0
    local maskColor = arg1.props.maskColor

    if usersLen <= 0 then
        return nil
    end

    local function GetMaxNumberOfIconsInWidth(arg2, width2): number -- Luacid: Inlined by compiler; 1 call site recovered
        return math.floor((width2 + 3) / (arg2 + 3))
    end

    local var2 = if height >= 32 and math.floor((width + 3) / 35) >= 3 then 32 elseif height >= 24 then 24 else height

    local tbl1 = {}
    local maxNumberOfIconsInWidth = GetMaxNumberOfIconsInWidth(var2, width)

    if maxNumberOfIconsInWidth > 0 then
        if maxNumberOfIconsInWidth < usersLen then
            num1 = usersLen - (maxNumberOfIconsInWidth - 1)
        end

        tbl1.ListLayout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 3)
        })

        for i = 1, num1 > 0 and maxNumberOfIconsInWidth - 1 or math.min(maxNumberOfIconsInWidth, usersLen) do
            local user = users[i]
            tbl1["UserIcon" .. i] = Roact.createElement(FriendIcon, { user = user, itemSize = var2, layoutOrder = i, maskColor = maskColor })
        end

        tbl1.NumberedIcon = num1 > 0 and Roact.createElement(NumberedIcon, { size = var2, layoutOrder = maxNumberOfIconsInWidth, count = num1 })
    end

    return Roact.createElement(
        "Frame",
        {
            Size = UDim2.new(0, width, 0, height),
            LayoutOrder = layoutOrder,
            BackgroundTransparency = 1
        },
        tbl1
    )
end

return var1

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Cryo = require(CorePackages.Packages.Cryo)
local React = require(CorePackages.Packages.React)

local function AudioDeviceInputDebugger(tbl1)
    local var1, var2 = React.useState(true)
    local instances = tbl1.instances
    local mutedPlayers = tbl1.mutedPlayers

    local var3 = Cryo.List.map(Cryo.Dictionary.keys(instances), function(arg1, layoutOrder: number)
        local active = arg1.Active
        local playerName = arg1.Player and arg1.Player.Name or "(no player)"

        local str1 = if arg1.Player and mutedPlayers[arg1.Player.UserId] then "muted" else "unmuted"
        local str2 = if arg1.MutedByLocalUser then "mutedByLocalUser" else "not-mutedByLocalUser"
        return React.createElement("TextLabel", {
            Text = string.format("<b>%s</b>: %s, %s, %s", playerName, if active then "active" else "inactive", str1, str2),
            Size = UDim2.fromOffset(20, 25),
            RichText = true,
            AutomaticSize = Enum.AutomaticSize.X,
            LayoutOrder = layoutOrder,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            Font = Enum.Font.SourceSans,
            TextSize = 18
        })
    end)

    local createElement = React.createElement
    local tbl2 = { Text = "<b>AudioDeviceInputs</b>" }
    tbl2[React.Event.Activated] = function()
        var2(not var1)
    end
    tbl2.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    tbl2.TextStrokeTransparency = 0.5
    tbl2.Size = UDim2.fromOffset(20, 25)
    tbl2.RichText = true
    tbl2.AutomaticSize = Enum.AutomaticSize.X
    tbl2.LayoutOrder = 0
    tbl2.TextXAlignment = Enum.TextXAlignment.Left
    tbl2.TextColor3 = Color3.fromRGB(255, 255, 255)
    tbl2.BackgroundTransparency = 1
    tbl2.Font = Enum.Font.SourceSansBold
    tbl2.TextSize = 20
    var3.Title = createElement("TextButton", tbl2)

    var3.UIListLayout = React.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 3) })

    var3.UIPadding = React.createElement("UIPadding", {
        PaddingTop = UDim.new(0, 3),
        PaddingBottom = UDim.new(0, 3),
        PaddingLeft = UDim.new(0, 3),
        PaddingRight = UDim.new(0, 3)
    })
    return React.createElement(
        "ScreenGui",
        {
            AutoLocalize = false,
            DisplayOrder = 100,
            IgnoreGuiInset = true,
            OnTopOfCoreBlur = true,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        },
        React.createElement("ScrollingFrame", {
            Size = UDim2.new(1 / 3, 0, var1 and 1 / 3 or 0, if var1 then 0 else 25),
            Position = UDim2.new(0, 0, 1, 0),
            AnchorPoint = Vector2.new(0, 1),
            Active = true,
            AutomaticCanvasSize = Enum.AutomaticSize.XY,
            BackgroundColor3 = Color3.fromRGB(50, 50, 50),
            BorderSizePixel = 0,
            CanvasSize = UDim2.new(0, 0, 0, #Cryo.Dictionary.keys(instances) * 28),
            ScrollBarThickness = 6,
            BackgroundTransparency = if var1 then 0.2 else 1
        }, var3)
    )
end

return AudioDeviceInputDebugger

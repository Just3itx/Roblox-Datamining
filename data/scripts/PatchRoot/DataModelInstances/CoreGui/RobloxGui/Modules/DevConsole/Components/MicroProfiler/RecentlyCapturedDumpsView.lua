-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:31:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Constants = require(script.Parent.Parent.Parent.Constants)
local MicroProfilerPanel = require(script.Parent.MicroProfilerPanel)

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local var1 = Roact.Component:extend("RecentlyCapturedDumpsView")

function var1.render(arg1)
    if arg1.props.RecentDumpPaths then
    end

    local rows = {}

    for _, recentDumpPath in ipairs(arg1.props.RecentDumpPaths) do
        local tbl2 = { DumpPathLabel = 0 }
        local createElement = Roact.createElement
        local tbl3 = {
            Font = Constants.Font.Log,
            Text = recentDumpPath,
            TextColor3 = Constants.Color.Text,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            TextEditable = false,
            ClearTextOnFocus = false,
            ClipsDescendants = true
        }

        local tbl4 = {
            UIPadding = Roact.createElement("UIPadding", {
                PaddingLeft = UDim.new(0, Constants.MicroProfilerFormatting.RecentDumpPathPadding),
                PaddingRight = UDim.new(0, Constants.MicroProfilerFormatting.RecentDumpPathPadding)
            })
        }
        tbl2.DumpPathLabel = createElement("TextBox", tbl3, tbl4)
        table.insert(rows, tbl2)
    end

    if #rows == 0 then
        table.insert(rows, {
            NoDumpsLabel = Roact.createElement("TextLabel", {
                Font = Constants.Font.MainWindow,
                Text = "No recently captured MicroProfiler dumps.",
                TextColor3 = Constants.Color.Text,
                TextSize = Constants.MicroProfilerFormatting.OptionTextSize,
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1)
            }, {
                UIPadding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, Constants.MicroProfilerFormatting.OptionTextPadding) })
            })
        })
    end

    return Roact.createElement(MicroProfilerPanel, {
        Title = "Recently captured MicroProfiler dumps",
        LayoutOrder = arg1.props.LayoutOrder,
        Sections = {{ Name = "RecentlyCapturedDumps", Rows = rows }}
    })
end

return RoactRodux.connect(function(arg1, _) -- name: mapStateToProps
    return {
        RecentDumpPaths = arg1.MicroProfiler.recentDumpPaths
    }
end, nil)(var1)

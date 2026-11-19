-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)
local _Actions = script.Parent.Parent.Parent.Actions

local Components = script.Parent.Parent.Parent.Components
local DataConsumer = require(Components.DataConsumer)

local Constants = require(script.Parent.Parent.Parent.Constants)
local MainRowPadding = Constants.GeneralFormatting.MainRowPadding
local UtilAndTab = require(Components.UtilAndTab)

local var1 = Roact.PureComponent:extend("MainViewVoiceChat")

function var1.init(arg1)
    function arg1.onUtilTabHeightChanged(utilTabHeight)
        arg1:setState({ utilTabHeight = utilTabHeight })
    end

    function arg1.onStatsUpdated(stats)
        arg1:setState({ stats = stats })
    end

    arg1._statsUpdatedConnection = arg1.props.VoiceChatData:Signal():Connect(arg1.onStatsUpdated)

    arg1.utilRef = Roact.createRef()

    arg1.state = {
        utilTabHeight = 0,
        stats = {}
    }
end

function var1.didMount(arg1)
    arg1:setState({ utilTabHeight = arg1.utilRef.current.Size.Y.Offset })
end

function var1.didUpdate(arg1)
    local currentSize = arg1.utilRef.current.Size
    if currentSize.Y.Offset ~= arg1.state.utilTabHeight then
        arg1:setState({ utilTabHeight = currentSize.Y.Offset })
    end
end

function var1.willUnmount(arg1)
    if arg1._statsUpdatedConnection then
        arg1._statsUpdatedConnection:Disconnect()
        arg1._statsUpdatedConnection = nil
    end
end

function var1.render(arg1)
    local size = arg1.props.size
    local formFactor = arg1.props.formFactor
    local tabList = arg1.props.tabList

    local tbl1 = {
        { key = "rttMs", format = "Round-trip time: %f", defaultValue = 0 },
        { key = "incomingPackets", format = "Incoming Packets: %d", defaultValue = 0 },
        { key = "outgoingPackets", format = "Outgoing Packets: %d", defaultValue = 0 },
        { key = "incomingPacketsLost", format = "Incoming Packets Lost: %d", defaultValue = 0 },
        { key = "outgoingPacketsLost", format = "Outgoing Packets Lost: %d", defaultValue = 0 }
    }

    local function renderStatLabels()
        local tbl2 = ({})
        for layoutOrder, value in ipairs(tbl1) do
            local createElement = Roact.createElement
            local tbl3 = {
                LayoutOrder = layoutOrder,
                Size = UDim2.fromOffset(200, 20),
                Text = string.format(value.format, arg1.state.stats[value.key] or value.defaultValue),
                TextColor3 = Constants.Color.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1
            }
            tbl2[layoutOrder] = createElement("TextLabel", tbl3)
        end

        return Roact.createFragment(tbl2)
    end

    return Roact.createElement("Frame", { Size = size, BackgroundTransparency = 1, LayoutOrder = 3 }, {
        UIListLayout = Roact.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            Padding = UDim.new(0, MainRowPadding)
        }),
        FramePadding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, 16) }),
        UtilAndTab = Roact.createElement(UtilAndTab, {
            windowWidth = size.X.Offset,
            formFactor = formFactor,
            tabList = tabList,
            layoutOrder = 1,
            refForParent = arg1.utilRef
        }),
        StatsContainer = Roact.createElement("Frame", {
            LayoutOrder = 2,
            BackgroundTransparency = 1
        }, {
            UIListLayout = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }),
            Labels = renderStatLabels()
        })
    })
end

return DataConsumer(var1, "VoiceChatData")

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local _ScriptContext = game:GetService("ScriptContext")

local ProfilerUtil = require(script.Parent.ProfilerUtil)

local Components = script.Parent.Parent.Parent.Components
local DropDown = require(Components.DropDown)

local Actions = script.Parent.Parent.Parent.Actions
local SetScriptProfilerState = require(Actions.SetScriptProfilerState)

local Constants = require(script.Parent.Parent.Parent.Constants)
local offset = Constants.GeneralFormatting.MainRowPadding * 2
local SmallFrameHeight = Constants.UtilityBarFormatting.SmallFrameHeight

local MainWindowHeader = Constants.Font.MainWindowHeader
local MainWindow = Constants.Font.MainWindow
local ButtonTextSize = Constants.MicroProfilerFormatting.ButtonTextSize
local ConstantsColorText = Constants.Color.Text

local _UnselectedGray = Constants.Color.UnselectedGray
local UnselectedGray = Constants.Color.UnselectedGray
local SelectedBlue = Constants.Color.SelectedBlue

local UnselectedGray2 = Constants.Color.UnselectedGray

local ButtonWidth = Constants.MicroProfilerFormatting.ButtonWidth

local DropDownArrowHeight = Constants.GeneralFormatting.DropDownArrowHeight
local var1 = DropDownArrowHeight / 2
local DownArrow = Constants.Image.DownArrow

local bool1 = game:DefineFastFlag("ScriptProfilerShowPlugins2", false)

local function makeFormattedStringTable(tbl1, func1: (...any) -> (...any)) -- Luacid: Inlined by compiler; 3 call sites recovered
    local var2 = table.create(#tbl1)

    for _, value in tbl1 do
        table.insert(var2, func1(value))
    end

    return var2
end

local function formatTimeSelection(arg1)
    if arg1 == 0 then
        return "Off"
    end
    return ProfilerUtil.formatTimer(arg1)
end

local tbl1 = { "Callgraph", "Functions" }

local tbl2 = {
    0,
    1,
    60,
    300,
    600
}
local formattedStringTable = makeFormattedStringTable(tbl2, formatTimeSelection)
local tbl3 = { 1000, 10000 }
local formattedStringTable2 = makeFormattedStringTable(tbl3, ProfilerUtil.formatFrequency)

local tbl4 = {
    0,
    60,
    300,
    600
}
local formattedStringTable3 = makeFormattedStringTable(tbl4, formatTimeSelection)
local var2 = Roact.PureComponent:extend("MobileSettingsView")

function var2.init(_) end

function var2.didMount(_) end

function var2.didUpdate(_) end

function var2.GetState(arg1, arg2)
    return (if arg1.props.isClientView then arg1.props.client else arg1.props.server)[arg2]
end

function var2.UpdateState(arg1, arg2, arg3)
    local var3 = if arg1.props.isClientView then arg1.props.client else arg1.props.server
    local var4 = table.clone(var3)
    var4[arg2] = arg3

    arg1.props.dispatchSetScriptProfilerState(arg1.props.isClientView, var4)
end

function var2.renderToggle(_, text, arg1, callback)
    local createElement = Roact.createElement
    local tbl5 = {
        Size = UDim2.new(1, 0, 0, SmallFrameHeight),
        BackgroundTransparency = 1,
        LayoutOrder = 2
    }

    local tbl6 = {
        Label = Roact.createElement("TextLabel", {
            Size = UDim2.new(0, ButtonWidth, 0, SmallFrameHeight),
            Position = UDim2.new(0.1, 0, 0, 0),
            Text = text,
            Font = MainWindowHeader,
            TextSize = ButtonTextSize,
            TextColor3 = Constants.Color.Text,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center,
            BackgroundColor3 = UnselectedGray2,
            BackgroundTransparency = 1
        }),
        ToggleButton = 0
    }

    local createElement2 = Roact.createElement
    local tbl7 = {
        Size = UDim2.new(0, ButtonWidth * 2, 0, SmallFrameHeight),
        Position = UDim2.new(0.9, -ButtonWidth * 2, 0, 0),
        BackgroundTransparency = 1
    }
    local tbl8 = { OffButton = 0, OnButton = 0 }
    local createElement3 = Roact.createElement
    local tbl9 = {
        Size = UDim2.new(0.5, 0, 1, 0),
        Text = "Off",
        Font = MainWindowHeader,
        TextSize = ButtonTextSize,
        TextColor3 = Constants.Color.Text,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center,
        BackgroundColor3 = arg1 and UnselectedGray or SelectedBlue
    }
    tbl9[Roact.Event.Activated] = function()
        callback(false)
    end

    tbl8.OffButton = createElement3("TextButton", tbl9)

    local createElement4 = Roact.createElement
    local tbl10 = {
        Size = UDim2.new(0.5, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0, 0),
        Text = "On",
        Font = MainWindowHeader,
        TextSize = ButtonTextSize,
        TextColor3 = Constants.Color.Text,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center,
        BackgroundColor3 = arg1 and SelectedBlue or UnselectedGray
    }
    tbl10[Roact.Event.Activated] = function()
        callback(true)
    end

    tbl8.OnButton = createElement4("TextButton", tbl10)
    tbl6.ToggleButton = createElement2("TextLabel", tbl7, tbl8)
    return createElement("Frame", tbl5, tbl6)
end

function var2.renderStateToggle(arg1, arg2, arg3, _)
    return arg1:renderToggle(arg2, arg1:GetState(arg3), function(arg4)
        arg1:UpdateState(arg3, arg4)
    end)
end

function var2.renderDropDown(arg1, text, arg2, dropDownList, arg3, selectedIndex, arg4)
    local element

    if arg4 then
        element = Roact.createElement("TextButton", {
            Position = UDim2.new(0.9, -ButtonWidth, 0, 0),
            Size = UDim2.new(0, ButtonWidth, 0, SmallFrameHeight),
            Text = dropDownList[selectedIndex],
            TextSize = ButtonTextSize,
            TextColor3 = ConstantsColorText,
            Font = MainWindow,
            AutoButtonColor = true,
            BackgroundColor3 = Constants.Color.InactiveBox,
            BackgroundTransparency = 0
        }, {
            arrow = Roact.createElement("ImageLabel", {
                Image = DownArrow,
                BackgroundTransparency = 1,
                Size = UDim2.new(0, DropDownArrowHeight, 0, DropDownArrowHeight),
                Position = UDim2.new(1, -DropDownArrowHeight - var1, 0.5, -var1)
            })
        })
    else
        element = Roact.createElement(
            "Frame",
            {
                Position = UDim2.new(0.9, -ButtonWidth, 0, 0),
                Size = UDim2.new(0, ButtonWidth, 0, SmallFrameHeight)
            },
            {
                Selection = Roact.createElement(DropDown, {
                    buttonSize = UDim2.new(1, 0, 0, SmallFrameHeight),
                    dropDownList = dropDownList,
                    selectedIndex = selectedIndex,
                    onSelection = function(arg5)
                        local state = arg1:GetState(arg2)

                        if typeof(state) == "boolean" then
                            state = arg5 == 2
                        elseif typeof(state) == "number" then
                            state = arg3[arg5]
                        end

                        arg1:UpdateState(arg2, state)
                    end
                })
            }
        )
    end
    return Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, SmallFrameHeight),
        BackgroundTransparency = 1
    }, {
        Label = Roact.createElement("TextLabel", {
            Size = UDim2.new(0, ButtonWidth, 0, SmallFrameHeight),
            Position = UDim2.new(0.1, 0, 0, 0),
            Text = text,
            Font = MainWindowHeader,
            TextSize = ButtonTextSize,
            TextColor3 = Constants.Color.Text,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center,
            BackgroundColor3 = UnselectedGray2,
            BackgroundTransparency = 1
        }),
        DropDown = element
    })
end

function var2.render(arg1)
    local state = arg1:GetState("isProfiling")

    return Roact.createElement("ScrollingFrame", {
        Size = arg1.props.size,
        BackgroundColor3 = Constants.Color.BaseGray,
        BackgroundTransparency = 1,
        LayoutOrder = 2,
        AutomaticCanvasSize = Enum.AutomaticSize.Y
    }, {
        UIListLayout = Roact.createElement("UIListLayout", { Padding = UDim.new(0, offset), SortOrder = Enum.SortOrder.LayoutOrder }),
        Percentages = arg1:renderToggle("Percentages", arg1.props.usePercentages, function(arg2)
            arg1.props.dispatchSetScriptProfilerUsePercentages(arg2)
        end),
        LiveToggle = arg1:renderStateToggle("Live Update", "liveUpdate"),
        PluginsToggle = if bool1 then arg1:renderStateToggle("Show Plugins", "showPlugins") else nil,
        GCToggle = arg1:renderStateToggle("GC Overhead", "showGc"),
        AverageDropDown = arg1:renderDropDown("Average", "average", formattedStringTable, tbl2, table.find(tbl2, arg1:GetState("average")) or 1),
        FrequencyDropDown = arg1:renderDropDown(
            "Frequency",
            "frequency",
            formattedStringTable2,
            tbl3,
            table.find(tbl3, arg1:GetState("frequency")) or 1,
            state
        ),
        TimerDropDown = arg1:renderDropDown(
            "Timer" .. (if state then ": " .. ProfilerUtil.formatTimer(arg1:GetState("timedProfilingCountdown")) else ""),
            "timedProfilingDuration",
            formattedStringTable3,
            tbl4,
            table.find(tbl4, arg1:GetState("timedProfilingDuration")) or 1,
            state
        ),
        ViewDropDown = arg1:renderDropDown("View", "isFunctionsView", tbl1, nil, if arg1:GetState("isFunctionsView") then 2 else 1)
    })
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _) -- name: mapStateToProps
    return {
        usePercentages = arg1.ScriptProfiler.usePercentages,
        isClientView = arg1.ScriptProfiler.isClientView,
        client = arg1.ScriptProfiler.client,
        server = arg1.ScriptProfiler.server
    }
end, function(callback) -- name: mapDispatchToProps
    return {
        dispatchSetScriptProfilerState = function(arg1, arg2)
            if arg1 then
                callback(SetScriptProfilerState(arg1, nil, arg2, nil))
                return
            end
            callback(SetScriptProfilerState(arg1, nil, nil, arg2))
        end,
        dispatchSetScriptProfilerUsePercentages = function(arg1)
            callback(SetScriptProfilerState(nil, arg1))
        end
    }
end)(var2)

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Stats = game:GetService("Stats")
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local Components = script.Parent.Parent.Parent.Components
local ClientMemory = require(Components.Memory.ClientMemory)
local ServerMemory = require(Components.Memory.ServerMemory)
local UtilAndTab = require(Components.UtilAndTab)
local DataConsumer = require(Components.DataConsumer)

local Actions = script.Parent.Parent.Parent.Actions
local ClientMemoryUpdateSearchFilter = require(Actions.ClientMemoryUpdateSearchFilter)
local ServerMemoryUpdateSearchFilter = require(Actions.ServerMemoryUpdateSearchFilter)

local Constants = require(script.Parent.Parent.Parent.Constants)
local MainRowPadding = Constants.GeneralFormatting.MainRowPadding

local bool1 = game:DefineFastFlag("DevConsoleMemoryTrackingAlert", false)

local var1 = Roact.Component:extend("LogButton")
function var1.init(arg1)
    function arg1.onAction()
        local var2 = arg1.props.isClientView and arg1.props.ClientMemoryData or arg1.props.ServerMemoryData
        local str1 = "\n"
        local function line(str2: string) -- Luacid: Inlined by compiler; 1 call site recovered
            str1 ..= str2 .. "\n"
        end

        str1 ..= "Name                                       Min   Max\n"
        str1 ..= "----------------------------------------   ---   ---\n"

        local function recurseMemoryTree(arg2, arg3, arg4)
            line(
                string.format("%s %s %s %3d   %3d", string.rep(" ", arg4), arg2, string.rep(" ", 40 - arg4 - #arg2), arg3.min, arg3.max)
            )

            if not arg3.children then
                return
            end

            for k, child in pairs(arg3.children) do
                recurseMemoryTree(k, child, arg4 + 2)
            end
        end

        recurseMemoryTree("Memory", var2._memoryData.Memory, 0)
        print(str1)
    end
end

function var1.render(arg1)
    return Roact.createElement("TextButton", {
        Text = "Log",
        Visible = true,
        BorderSizePixel = 1,
        BackgroundColor3 = Constants.Color.UnselectedGray,
        TextColor3 = Constants.Color.Text,
        [Roact.Event.Activated] = arg1.onAction
    })
end
local var2 = DataConsumer(var1, "ClientMemoryData", "ServerMemoryData")

local var3 = Roact.Component:extend("MainViewMemory")
function var3.init(arg1)
    function arg1.onUtilTabHeightChanged(utilTabHeight)
        arg1:setState({ utilTabHeight = utilTabHeight })
    end

    function arg1.onClientButton()
        arg1:setState({ isClientView = true })
    end

    function arg1.onServerButton()
        arg1:setState({ isClientView = false })
    end

    function arg1.onSearchTermChanged(arg2)
        if arg1.state.isClientView then
            arg1.props.dispatchClientMemoryUpdateSearchFilter(arg2, {})
            return
        end
        arg1.props.dispatchServerMemoryUpdateSearchFilter(arg2, {})
    end

    arg1.utilRef = Roact.createRef()

    arg1.state = { utilTabHeight = 0, isClientView = true }
end

function var3.didMount(arg1)
    arg1:setState({ utilTabHeight = arg1.utilRef.current.Size.Y.Offset })
end

function var3.didUpdate(arg1)
    local offset = arg1.utilRef.current.Size.Y.Offset

    if offset ~= arg1.state.utilTabHeight then
        arg1:setState({ utilTabHeight = offset })
    end
end

local function shouldDisplayMemoryWarning(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not Stats.MemoryTrackingEnabled
end

function var3.render(arg1)
    local tbl1 = ({})
    local size = arg1.props.size
    local isDeveloperView = arg1.props.isDeveloperView
    local formFactor = arg1.props.formFactor
    local tabList = arg1.props.tabList

    local utilTabHeight = arg1.state.utilTabHeight
    local isClientView = arg1.state.isClientView
    local searchTerm = isClientView and arg1.props.clientSearchTerm or arg1.props.serverSearchTerm
    local bool2 = if bool1 then shouldDisplayMemoryWarning() else false
    tbl1.UIListLayout = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, MainRowPadding) })

    tbl1.UtilAndTab = Roact.createElement(
        UtilAndTab,
        {
            windowWidth = size.X.Offset,
            formFactor = formFactor,
            tabList = tabList,
            isClientView = isClientView,
            searchTerm = searchTerm,
            layoutOrder = 1,
            refForParent = arg1.utilRef,
            onHeightChanged = arg1.onUtilTabHeightChanged,
            onClientButton = isDeveloperView and arg1.onClientButton,
            onServerButton = isDeveloperView and arg1.onServerButton,
            onSearchTermChanged = arg1.onSearchTermChanged
        },
        { var2 and Roact.createElement(var2, { isClientView = isClientView }) }
    )

    if bool2 then
        tbl1.MemoryHeader = Roact.createElement("TextLabel", {
            Size = UDim2.new(1, 0, 0, 20),
            Position = UDim2.new(0, 0, 0, 0),
            Text = "Memory category counters are disabled. Restart the client with the MicroProfiler on to guarantee counters are enabled.",
            TextColor3 = Constants.Color.Text,
            BackgroundColor3 = Color3.new(1, 0, 0),
            LayoutOrder = 2
        })
    end

    if utilTabHeight > 0 then
        if isClientView then
            tbl1.ClientMemory = Roact.createElement(
                ClientMemory,
                {
                    size = UDim2.new(1, 0, 1, -utilTabHeight),
                    searchTerm = searchTerm,
                    layoutOrder = 3
                }
            )
        else
            tbl1.ServerMemory = Roact.createElement(
                ServerMemory,
                {
                    size = UDim2.new(1, 0, 1, -utilTabHeight),
                    searchTerm = searchTerm,
                    layoutOrder = 3
                }
            )
        end
    end

    return Roact.createElement(
        "Frame",
        {
            Size = size,
            BackgroundColor3 = Constants.Color.BaseGray,
            BackgroundTransparency = 1,
            LayoutOrder = 4
        },
        tbl1
    )
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _) -- name: mapStateToProps
    return {
        clientSearchTerm = arg1.MemoryData.clientSearchTerm,
        clientTypeFilters = arg1.MemoryData.clientTypeFilters,
        serverSearchTerm = arg1.MemoryData.serverSearchTerm,
        serverTypeFilters = arg1.MemoryData.serverTypeFilters
    }
end, function(callback) -- name: mapDispatchToProps
    return {
        dispatchClientMemoryUpdateSearchFilter = function(arg1, arg2)
            callback(ClientMemoryUpdateSearchFilter(arg1, arg2))
        end,
        dispatchServerMemoryUpdateSearchFilter = function(arg1, arg2)
            callback(ServerMemoryUpdateSearchFilter(arg1, arg2))
        end
    }
end)(var3)

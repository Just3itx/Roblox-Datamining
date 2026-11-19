-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:40:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local RunService = game:GetService("RunService")

local Roact = require(CorePackages.Packages.Roact)

local scriptParentParent = script.Parent.Parent
local UtilAndTab = require(scriptParentParent.UtilAndTab)
local DropDown = require(scriptParentParent.DropDown)

local OrchestratorRow = require(script.Parent.OrchestratorRow)
local RequestOrchestratorData = require(script.Parent.RequestOrchestratorData)

local Constants = require(script.Parent.Parent.Parent.Constants)
local MainRowPadding = Constants.GeneralFormatting.MainRowPadding
local Mono = Constants.Font.Mono

local quillGrey = Color3.fromRGB(220, 220, 220)

local tbl1 = {
    BatchCreated = { RequestOrchestratorData.registerBatch, RequestOrchestratorData.trackQueueOnCreated },
    BatchSent = { RequestOrchestratorData.openSendAttempt, RequestOrchestratorData.drainQueueOnSent },
    BatchResponseReceived = { RequestOrchestratorData.settleBatch },
    BatchRetrying = { RequestOrchestratorData.reclassifyOnRetry, RequestOrchestratorData.requeueRetryOps },
    BatchExhausted = { RequestOrchestratorData.markExhausted, RequestOrchestratorData.clearQueueOnExhausted },
    OperationEnqueued = { RequestOrchestratorData.enqueueOperation },
    CacheItemAdded = { RequestOrchestratorData.recordCacheItemAdded },
    CacheHit = { RequestOrchestratorData.recordCacheHit }
}

local function makeLabel(text: string, layoutOrder: number)
    return Roact.createElement("TextLabel", {
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2.new(0, 0, 0, 22),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = quillGrey,
        TextSize = 11,
        Font = Mono,
        TextXAlignment = Enum.TextXAlignment.Left,
        LayoutOrder = layoutOrder
    })
end

local function cloneSet(selectedTypes) -- Luacid: Inlined by compiler; 3 call sites recovered
    local result = ({})
    for k, value in pairs(selectedTypes) do
        result[k] = value
    end
    return result
end

local var1 = Roact.Component:extend("MainViewRequestOrchestrator")

function var1.init(arg1)
    arg1.model = RequestOrchestratorData.new()
    arg1.connections = {}
    arg1.utilRef = Roact.createRef()

    function arg1.onUtilTabHeightChanged(utilTabHeight)
        arg1:setState({ utilTabHeight = utilTabHeight })
    end

    function arg1.onTypeToggle(arg2)
        local selectedTypes = cloneSet(arg1.state.selectedTypes)
        selectedTypes[arg2] = not selectedTypes[arg2] or nil
        arg1:setState({ selectedTypes = selectedTypes })
    end

    arg1.state = {
        utilTabHeight = 0,
        selectedTypes = {}
    }
end

function var1.observeType(arg1, arg2)
    local var2 = RequestOrchestratorData.observeType(arg1.model, arg2)
    if not var2 then
        return
    end

    local selectedTypes = cloneSet(arg1.state.selectedTypes)
    selectedTypes[var2] = true
    arg1:setState({ selectedTypes = selectedTypes })
end

function var1.didMount(arg1)
    arg1:setState({ utilTabHeight = arg1.utilRef.current.Size.Y.Offset })

    local RequestOrchestratorService = game:GetService("RequestOrchestratorService")

    local success, result = pcall(function()
        return RequestOrchestratorService:GetRegisteredOrchestrators()
    end)
    if success and result then
        local var2 = RequestOrchestratorData.observeTypes(arg1.model, result)
        if #var2 > 0 then
            local selectedTypes = cloneSet(arg1.state.selectedTypes)
            for _, value in ipairs(var2) do
                selectedTypes[value] = true
            end
            arg1:setState({ selectedTypes = selectedTypes })
        end
    end

    for k, value in pairs(tbl1) do
        arg1.connections[k] = RequestOrchestratorService[k]:Connect(function(arg2)
            local orchestratorType = arg2.orchestratorType or "Unknown"
            arg1:observeType(orchestratorType)
            for _, value2 in ipairs(value) do
                value2(arg1.model, orchestratorType, arg2)
            end
            arg1:setState({})
        end)
    end

    arg1.connections.heartbeat = RunService.Heartbeat:Connect(function()
        RequestOrchestratorData.advanceTime(arg1.model)
        arg1:setState({})
    end)
end

function var1.willUnmount(arg1)
    for _, connection in pairs(arg1.connections) do
        connection:Disconnect()
    end
    arg1.connections = {}
end

function var1.didUpdate(arg1)
    local offset = arg1.utilRef.current.Size.Y.Offset
    if offset ~= arg1.state.utilTabHeight then
        arg1:setState({ utilTabHeight = offset })
    end
end

function var1.render(arg1)
    local size = arg1.props.size
    local formFactor = arg1.props.formFactor
    local tabList = arg1.props.tabList
    local utilTabHeight = arg1.state.utilTabHeight
    local selectedTypes = arg1.state.selectedTypes
    local allTypes = arg1.model.allTypes

    local tbl2 = {
        UIListLayout = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, MainRowPadding) }),
        UtilAndTab = Roact.createElement(UtilAndTab, {
            windowWidth = size.X.Offset,
            formFactor = formFactor,
            tabList = tabList,
            layoutOrder = 1,
            refForParent = arg1.utilRef,
            onHeightChanged = arg1.onUtilTabHeightChanged
        })
    }
    if utilTabHeight > 0 then
        local num1 = 0
        local var2 = nil
        for i, value in ipairs(allTypes) do
            if selectedTypes[i] then
                num1 += 1
                var2 = value
            end
        end

        if #allTypes == 0 then
            var2 = "(waiting for traffic)"
        elseif num1 == 0 then
            var2 = "(none)"
        elseif num1 ~= 1 then
            if num1 == #allTypes then
                var2 = string.format("All (%d)", num1)
            else
                var2 = string.format("%d selected", num1)
            end
        end
        tbl2.Controls = Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 0, 24),
                BackgroundTransparency = 1,
                LayoutOrder = 2
            },
            {
                Layout = Roact.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 4),
                    VerticalAlignment = Enum.VerticalAlignment.Center
                }),
                ShowLabel = makeLabel("Show", 1),
                TypeDropDown = Roact.createElement(DropDown, {
                    buttonSize = UDim2.new(0, 220, 0, 22),
                    dropDownList = allTypes,
                    selectedSet = selectedTypes,
                    onToggle = arg1.onTypeToggle,
                    summaryText = var2,
                    layoutOrder = 2
                })
            }
        )

        for i, orchestratorType in ipairs(allTypes) do
            if not selectedTypes[i] then
                continue
            end

            local var3 = "Row_" .. orchestratorType
            tbl2[var3] = Roact.createElement(OrchestratorRow, {
                orchestratorType = orchestratorType,
                batches = arg1.model.batchesByType[orchestratorType] or {},
                queue = arg1.model.queues[orchestratorType],
                cache = arg1.model.cacheByType[orchestratorType],
                observedMaxBatchSize = arg1.model.observedMaxByType[orchestratorType],
                panelWidth = size.X.Offset,
                now = arg1.model.now,
                size = UDim2.new(1, 0, 0, 52),
                layoutOrder = 2 + i
            })
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
        tbl2
    )
end

return var1

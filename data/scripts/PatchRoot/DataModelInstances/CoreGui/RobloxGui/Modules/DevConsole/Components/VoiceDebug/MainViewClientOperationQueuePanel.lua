-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local Components = script.Parent.Parent.Parent.Components
local FilterChip = require(Components.FilterChip)
local InfoBanner = require(Components.InfoBanner)
local MergeObservedNames = require(Components.MergeObservedNames)
local OperationRow = require(Components.OperationRow)
local VirtualList = require(Components.VirtualList)

local CollapsibleSection = require(script.Parent.CollapsibleSection)
local VoiceDebugOperationLabels = require(script.Parent.VoiceDebugOperationLabels)

local function filterOperations(tbl1, tbl2, bool1: boolean)
    local result = {}
    for _, value in tbl1 do
        if bool1 then
            if value.operationType == "ClientCullingOperation" then
                result[#result + 1] = value
            end
        elseif value.operationType ~= "ClientCullingOperation" and not tbl2[value.operationType] then
            result[#result + 1] = value
        end
    end
    return result
end

local function isChipOn(str1: string, tbl1, bool1: boolean): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if str1 == "ClientCullingOperation" then
        return bool1
    end

    return not (bool1 or tbl1[str1])
end

local function nextChipState(str1: string, tbl1)
    if str1 == "ClientCullingOperation" then
        return {
            excludedNames = tbl1.excludedNames,
            showCullingExclusively = not tbl1.showCullingExclusively
        }
    end
    local excludedNames = table.clone(tbl1.excludedNames)
    if tbl1.showCullingExclusively then
        excludedNames[str1] = nil
    else
        excludedNames[str1] = not excludedNames[str1] or nil
    end
    return { excludedNames = excludedNames, showCullingExclusively = false }
end

local var1 = Roact.Component:extend("ClientOperationQueuePanel")

function var1.init(arg1)
    local observedNames = {}
    MergeObservedNames((arg1.props.remoteOperations or {}).operations or {}, observedNames, "operationType")

    arg1.state = {
        observedNames = observedNames,
        excludedNames = {},
        showCullingExclusively = false
    }

    function arg1.onChipActivated(arg2)
        arg1:setState(function(arg3)
            return (nextChipState(arg2, arg3))
        end)
    end
end

function var1.didUpdate(arg1, arg2)
    if arg2.remoteOperations == arg1.props.remoteOperations then
        return
    end
    local var2 = (arg1.props.remoteOperations or {}).operations or {}
    local observedNames = table.clone(arg1.state.observedNames)
    if MergeObservedNames(var2, observedNames, "operationType") then
        arg1:setState({ observedNames = observedNames })
    end
end

function var1.render(arg1)
    local var2 = arg1.props.remoteOperations or {}
    local layoutOrder = arg1.props.layoutOrder
    local excludedNames = arg1.state.excludedNames
    local showCullingExclusively = arg1.state.showCullingExclusively

    local items = filterOperations(var2.operations or {}, excludedNames, showCullingExclusively)
    table.sort(items, function(arg2, arg3): boolean
        return arg2.timestampSeconds > arg3.timestampSeconds
    end)

    local tbl2 = ({})
    local num1 = 0
    for value in arg1.state.observedNames do
        num1 += 1
        local var3 = "chip" .. value
        local createElement = Roact.createElement
        local var4 = FilterChip
        local tbl3 = {
            name = VoiceDebugOperationLabels.labelForOperationType(value),
            isOn = isChipOn(value, excludedNames, showCullingExclusively),
            layoutOrder = num1,
            onActivated = 0
        }

        function tbl3.onActivated()
            arg1.onChipActivated(value)
        end

        tbl2[var3] = createElement(var4, tbl3)
    end

    local bool1 = var2.operations ~= nil
    local bool2 = var2.opQueueCaptureEnabled == true

    local createElement = Roact.createElement
    local var3 = CollapsibleSection
    local tbl3 = { title = "Client Activity", layoutOrder = layoutOrder }
    local tbl4 = {
        CaptureNotice = if bool1 and not bool2 then Roact.createElement(InfoBanner, {
            layoutOrder = 1,
            text = "Operation capture is off (FFlag::VoiceMetricsDataEnabled). Enable it to see executed operations here."
        })
            or nil else nil,
        Filters = Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = 2,
                BackgroundTransparency = 1
            },
            {
                UIListLayout = Roact.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal,
                    Wraps = true,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 4)
                }),
                Chips = Roact.createFragment(tbl2)
            }
        ),
        List = 0
    }

    local createElement2 = Roact.createElement
    local var4 = VirtualList

    local tbl5 = {
        items = items,
        rowHeight = 22,
        renderItem = function(arg2, layoutOrder2)
            local var5 = arg2.name:match("::(.+)$") or arg2.name
            local name = VoiceDebugOperationLabels.labelForOperationType(arg2.operationType) .. ": " .. VoiceDebugOperationLabels.humanizeName(var5)
            return Roact.createElement(
                OperationRow,
                {
                    timestampText = arg2.timestampText,
                    tag = "op",
                    name = name,
                    layoutOrder = layoutOrder2
                }
            )
        end,
        size = 0,
        layoutOrder = 3,
        emptyText = "No activity observed yet."
    }

    local new = UDim2.new
    local num2 = 1
    local num3 = 0
    local num4 = 0
    local var5 = if #items > 0 then math.min(#items * 22, 320) or 44 else 44
    tbl5.size = new(num2, num3, num4, var5)
    tbl4.List = createElement2(var4, tbl5)
    return createElement(var3, tbl3, tbl4)
end

var1._filterOperations = filterOperations
var1._isChipOn = isChipOn
var1._nextChipState = nextChipState

return var1

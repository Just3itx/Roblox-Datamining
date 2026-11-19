-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:50:58Z
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

local function mergeChronologically(tbl1, tbl2)
    local var1 = table.create(#tbl1 + #tbl2)
    local num1 = 1
    local num2 = 1

    while num1 <= #tbl1 or num2 <= #tbl2 do
        if num1 <= #tbl1 and (#tbl2 < num2 or tbl1[num1].timestampSeconds <= tbl2[num2].timestampSeconds) then
            local var2 = tbl1[num1]
            local num3 = #var1 + 1
            var1[num3] = {
                name = var2.name,
                timestampSeconds = var2.timestampSeconds,
                timestampText = var2.timestampText,
                tag = "snt"
            }
            num1 += 1
        else
            local var2 = tbl2[num2]
            local num3 = #var1 + 1
            var1[num3] = {
                name = var2.name,
                timestampSeconds = var2.timestampSeconds,
                timestampText = var2.timestampText,
                tag = "srv"
            }
            num2 += 1
        end
    end
    return var1
end

local var1 = Roact.Component:extend("RemoteOperationsPanel")

function var1.init(arg1)
    local observedNames = {}
    local var2 = arg1.props.remoteOperations or {}
    MergeObservedNames(var2.sent or {}, observedNames, "name")
    MergeObservedNames(var2.received or {}, observedNames, "name")

    arg1.state = {
        observedNames = observedNames,
        excludedNames = {}
    }

    function arg1.onChipActivated(arg2)
        arg1:setState(function(arg3)
            local excludedNames = table.clone(arg3.excludedNames)
            excludedNames[arg2] = not excludedNames[arg2] or nil
            return { excludedNames = excludedNames }
        end)
    end
end

function var1.didUpdate(arg1, arg2)
    if arg2.remoteOperations == arg1.props.remoteOperations then
        return
    end
    local var2 = arg1.props.remoteOperations or {}
    local observedNames = table.clone(arg1.state.observedNames)
    local var4 = MergeObservedNames(var2.sent or {}, observedNames, "name")
    local var5 = MergeObservedNames(var2.received or {}, observedNames, "name")
    if var4 or var5 then
        arg1:setState({ observedNames = observedNames })
    end
end

function var1.render(arg1)
    local var2 = arg1.props.remoteOperations or {}
    local layoutOrder = arg1.props.layoutOrder
    local excludedNames = arg1.state.excludedNames

    local var3 = mergeChronologically(var2.sent or {}, var2.received or {})
    local items = {}
    for i = #var3, 1, -1 do
        local var4 = var3[i]
        if not excludedNames[var4.name] then
            items[#items + 1] = var4
        end
    end

    local tbl2 = ({})
    local num1 = 0
    for value in arg1.state.observedNames do
        num1 += 1
        local var4 = "chip" .. value
        local createElement = Roact.createElement
        local var5 = FilterChip
        local tbl3 = {
            name = VoiceDebugOperationLabels.labelForEventName(value),
            isOn = not excludedNames[value],
            layoutOrder = num1,
            onActivated = 0
        }

        function tbl3.onActivated()
            arg1.onChipActivated(value)
        end

        tbl2[var4] = createElement(var5, tbl3)
    end

    local bool1 = var2.sent ~= nil
    local bool2 = var2.receivedCaptureEnabled == true
    local bool3 = var2.sentCaptureEnabled == true

    local createElement = Roact.createElement
    local var4 = CollapsibleSection
    local tbl3 = { title = "Message Log", layoutOrder = layoutOrder }
    local tbl4 = { Banner = 0, Filters = 0, List = 0 }
    local element = bool1
        and not bool2
        and Roact.createElement(InfoBanner, {
            layoutOrder = 1,
            text = "Remote operation capture is off (FFlag::VoiceMetricsDataEnabled). Enable it to see sent/received events here."
        })

    if not element then
        if bool1 then
            element = not bool3
                and Roact.createElement(InfoBanner, {
                    layoutOrder = 1,
                    text = "Sent-event capture is off (FFlag::VoiceChatEventReplicatorWrapperEnabled). Received events are still shown below."
                })
                or nil
        else
            element = nil
        end
    end

    tbl4.Banner = element

    tbl4.Filters = Roact.createElement(
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
    )
    tbl4.List = Roact.createElement(VirtualList, {
        items = items,
        rowHeight = 22,
        renderItem = function(arg2, layoutOrder2)
            return Roact.createElement(OperationRow, {
                timestampText = arg2.timestampText,
                tag = arg2.tag,
                name = VoiceDebugOperationLabels.labelForEventName(arg2.name),
                layoutOrder = layoutOrder2
            })
        end,
        size = UDim2.new(1, 0, 0, #items > 0 and math.min(#items * 22, 280) or 44),
        layoutOrder = 3,
        emptyText = if #var3 > 0 then "No messages match filter." else "No messages observed yet."
    })

    return createElement(var4, tbl3, tbl4)
end

var1._mergeChronologically = mergeChronologically

return var1

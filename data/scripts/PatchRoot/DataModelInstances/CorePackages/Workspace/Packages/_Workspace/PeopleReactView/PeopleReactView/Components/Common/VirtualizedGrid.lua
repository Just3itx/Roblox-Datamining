-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:30:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactView = script:FindFirstAncestor("PeopleReactView")
local PeopleReactViewParent = PeopleReactView.Parent

local React = require(PeopleReactViewParent.React)
local Signals = require(PeopleReactViewParent.Signals)
local SignalsReact = require(PeopleReactViewParent.SignalsReact)

local View = require(PeopleReactViewParent.Foundation).View

local PeopleService = require(PeopleReactViewParent.PeopleService)

local VirtualizedItem = require(script.Parent.VirtualizedItem)

local _GetScrollingFrameStore = require(PeopleReactView.Stores.GetScrollingFrameStore)
local GetVirtualizedGridStore = require(PeopleReactView.Stores.GetVirtualizedGridStore)

local FFlagFixVirtualizedGridNumItems = PeopleService.getService("Flags").FFlagFixVirtualizedGridNumItems

return React.memo(function(tbl1) -- name: VirtualizedGrid
    local var1 = SignalsReact.useSignalState(GetVirtualizedGridStore)
    local var2 = SignalsReact.useSignalState(var1.getNumVirtualizedItems)

    local ref = React.useRef(nil)

    local var4 = React.joinBindings({ itemWidth = tbl1.itemWidth, itemHeight = tbl1.itemHeight, numColumns = tbl1.numColumns })

    local var5 = React.useMemo(function()
        return var4:map(function(tbl2)
            return UDim2.new(1, 0, 0, math.ceil(tbl1.numItems / tbl2.numColumns) * (tbl2.itemHeight + tbl1.gapSize) - tbl1.gapSize)
        end)
    end, { tbl1.numItems, tbl1.gapSize })

    React.useEffect(function()
        local effect = nil
        local connection = nil

        if tbl1.scrollingFrameStore and ref.current then
            local function handleCalculateVirtualizedGridLimits()
                var1.calculateVirtualizedGridLimits(
                    tbl1.scrollingFrameStore.getCanvasPositionY(),
                    tbl1.scrollingFrameStore.getAbsoluteSizeY(),
                    tbl1.itemWidth:getValue(),
                    tbl1.itemHeight:getValue(),
                    tbl1.numColumns:getValue(),
                    tbl1.gapSize
                )
            end

            if tbl1.onContainerWidthChanged then
                tbl1.onContainerWidthChanged(ref.current.AbsoluteSize.X)
            end

            handleCalculateVirtualizedGridLimits()

            effect = Signals.createEffect(function(arg1)
                tbl1.scrollingFrameStore.getCanvasPositionY(arg1)
                tbl1.scrollingFrameStore.getAbsoluteSizeY(arg1)
                handleCalculateVirtualizedGridLimits()
            end)

            connection = ref.current:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                if tbl1.onContainerWidthChanged then
                    tbl1.onContainerWidthChanged(ref.current.AbsoluteSize.X)
                end

                handleCalculateVirtualizedGridLimits()
            end)
        end

        return function()
            if effect then
                effect()
            end
            if connection then
                connection:Disconnect()
            end
        end
    end, { tbl1.onContainerWidthChanged, tbl1.scrollingFrameStore, tbl1.gapSize })

    local tbl2 = ({})

    if FFlagFixVirtualizedGridNumItems then
        var2 = math.min(var2, tbl1.numItems)
    end
    for relativeIndex = 1, var2 do
        local str1 = "VirtualizedItem_" .. relativeIndex
        tbl2[str1] = React.createElement(VirtualizedItem, {
            relativeIndex = relativeIndex,
            getMinVirtualizedIndex = var1.getMinVirtualizedIndex,
            getMaxVirtualizedIndex = var1.getMaxVirtualizedIndex,
            itemWidth = tbl1.itemWidth,
            itemHeight = tbl1.itemHeight,
            numColumns = tbl1.numColumns,
            gapSize = tbl1.gapSize,
            getElement = tbl1.getElement
        })
    end

    return React.createElement(View, { Size = var5, LayoutOrder = tbl1.layoutOrder, ref = ref }, tbl2)
end)

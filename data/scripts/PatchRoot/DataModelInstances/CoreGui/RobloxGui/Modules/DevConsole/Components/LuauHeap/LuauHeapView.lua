-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local Components = script.Parent.Parent.Parent.Components
local HeaderButton = require(Components.HeaderButton)
local BannerButton = require(Components.BannerButton)
local CellLabel = require(Components.CellLabel)
local BoxButton = require(Components.BoxButton)
local LuauHeapViewEntry = require(script.Parent.LuauHeapViewEntry)
local LuauHeapViewStatEntry = require(script.Parent.LuauHeapViewStatEntry)
local LuauHeapViewRefEntry = require(script.Parent.LuauHeapViewRefEntry)
local _LuauHeapTypes = require(script.Parent.LuauHeapTypes)

local Actions = script.Parent.Parent.Parent.Actions
local SetLuauHeapActiveSnapshot = require(Actions.SetLuauHeapActiveSnapshot)
local SetLuauHeapCompareSnapshot = require(Actions.SetLuauHeapCompareSnapshot)

local Constants = require(script.Parent.Parent.Parent.Constants)

local LineWidth = Constants.GeneralFormatting.LineWidth
local LineColor = Constants.GeneralFormatting.LineColor
local HeaderFrameHeight = Constants.GeneralFormatting.HeaderFrameHeight
local EntryFrameHeight = Constants.GeneralFormatting.EntryFrameHeight

local ValueCellWidth = Constants.LuauHeapFormatting.ValueCellWidth
local CellPadding = Constants.LuauHeapFormatting.CellPadding
local ValuePadding = Constants.LuauHeapFormatting.ValuePadding
local SnapshotWidth = Constants.LuauHeapFormatting.SnapshotWidth
local SnapshotHighlightSize = Constants.LuauHeapFormatting.SnapshotHighlightSize
local TabsHeight = Constants.LuauHeapFormatting.TabsHeight
local TabButtonWidth = Constants.LuauHeapFormatting.TabButtonWidth
local TabButtonHeight = Constants.LuauHeapFormatting.TabButtonHeight
local _TabButtonPad = Constants.LuauHeapFormatting.TabButtonPad
local TabHighlightHeight = Constants.LuauHeapFormatting.TabHighlightHeight
local TableHintHeight = Constants.LuauHeapFormatting.TableHintHeight

local tbl1 = {
    graph = {
        hint = "Graph displays the size of the objects in Luau VM aggregated by the shortest path from the root Engine references to them.\n\t\tMost important root references are ModuleScript tables and functions connected to signals or the task scheduler.",
        headers = { "Name", "Size", "Self" },
        initFragmentSource = function(arg1)
            return arg1:renderChildren()
        end
    },
    tag = {
        hint = "This memory breakdown displays how much memory is used by Luau VM types.",
        headers = { "Name", "Size", "Count" },
        initFragmentSource = function(arg1)
            return arg1:renderChildrenStats("TagBreakdown")
        end
    },
    memcat = {
        hint = "Memory separated by the category at the time of allocation.\n\t\tMemory category is assigned to the thread performing the allocation, not the script.\n\t\tDefault value is based on the script name. Custom value can be assigned using 'debug.setmemorycategory' API.",
        headers = { "Name", "Size", "Count" },
        initFragmentSource = function(arg1)
            return arg1:renderChildrenStats("MemcatBreakdown")
        end
    },
    userdata = {
        hint = "This breakdown shows how much memory inside Luau VM is taken by custom Roblox engine classes.\n\t\tFor DataModel classes like 'Part' this does not include the memory taken inside the engine itself.",
        headers = { "Name", "Size", "Count" },
        initFragmentSource = function(arg1)
            return arg1:renderChildrenStats("UserdataBreakdown")
        end
    },
    [if game:GetEngineFeature("UnparentedInstances") then "UniqueRefs" else "refs"] = {
        hint = "This view shows engine DataModel instances that are only referenced by Luau VM and are not directly parented to the DataModel.\n\t\tFor each instance, it will show the set of paths that make it accessible and prevent garbage collection.\n\t\tMost often, engine Luau references come from ModuleScript tables, active signal connections and active coroutines in the task scheduler.",
        headers = { "Name", "Count", "Total Instances" },
        initFragmentSource = function(arg1)
            return arg1:renderChildrenRefs()
        end
    }
}

if game:GetEngineFeature("UnparentedInstances") then
    tbl1.UnparentedRefs = {
        hint = "This view shows engine DataModel instances that are not parented to any instance (and are also not unique references).\n\t\tFor each instance, it will show the set of paths that make it accessible and prevent garbage collection.\n\t\t",
        headers = { "Name", "Count", "Total Instances" },
        initFragmentSource = function(arg1)
            return arg1:renderUnparentedRefs()
        end
    }
end

local var1 = Roact.PureComponent:extend("LuauHeapView")

function var1.renderSnapshotList(arg1)
    local result = ({})

    for layoutOrder, _ in arg1.props.data do
        local createElement = Roact.createElement
        local var2 = BannerButton
        local tbl2 = {
            size = UDim2.new(1, 0, 0, EntryFrameHeight),
            inset = 0,
            isExpanded = false,
            isExpandable = false,
            layoutOrder = layoutOrder,
            onButtonPress = 0
        }

        function tbl2.onButtonPress()
            arg1.props.dispatchSetLuauHeapActiveSnapshot(layoutOrder)
        end
        local tbl3 = {
            name = Roact.createElement(CellLabel, {
                text = `Snapshot #{layoutOrder}`,
                size = UDim2.new(UDim.new(1, 0), UDim.new(1, 0)),
                pos = UDim2.new(0, CellPadding, 0, 0)
            }),
            HorizontalHighlightTop = if arg1.props.activeSnapshot == layoutOrder then Roact.createElement("Frame", { Size = UDim2.new(1, 0, 0, SnapshotHighlightSize), BackgroundColor3 = LineColor }) else nil,
            HorizontalHighlightBottom = if arg1.props.activeSnapshot == layoutOrder then Roact.createElement("Frame", {
                Size = UDim2.new(1, 0, 0, SnapshotHighlightSize),
                Position = UDim2.new(0, 0, 1, -SnapshotHighlightSize),
                BackgroundColor3 = LineColor
            }) else nil,
            HorizontalHighlightLeft = if arg1.props.activeSnapshot == layoutOrder then Roact.createElement("Frame", { Size = UDim2.new(0, SnapshotHighlightSize, 1, 0), BackgroundColor3 = LineColor }) else nil,
            HorizontalHighlightRight = if arg1.props.activeSnapshot == layoutOrder then Roact.createElement("Frame", {
                Size = UDim2.new(0, SnapshotHighlightSize, 1, 0),
                Position = UDim2.new(1, -SnapshotHighlightSize, 0, 0),
                BackgroundColor3 = LineColor
            }) else nil,
            Compare = 0
        }
        local var3

        if arg1.props.activeSnapshot == layoutOrder then
            var3 = nil
        else
            local createElement2 = Roact.createElement
            local var4 = BoxButton
            local tbl4 = {
                text = "Compare",
                size = UDim2.new(0.3, -6, 1, -6),
                pos = UDim2.new(0.7, 3, 0, 3),
                onClicked = 0
            }

            function tbl4.onClicked()
                arg1.props.dispatchSetLuauHeapCompareSnapshot(layoutOrder)
            end

            var3 = createElement2(var4, tbl4)
        end

        tbl3.Compare = var3
        result[layoutOrder] = createElement(var2, tbl2, tbl3)
    end

    return result
end

function var1.renderChildren(arg1)
    local var2 = arg1.props.data[arg1.props.activeSnapshot]
    local var3 = arg1.props.data[arg1.props.compareSnapshot]

    return Roact.createElement(
        LuauHeapViewEntry,
        {
            layoutOrder = 0,
            depth = 0,
            data = if var2 then var2.Graph else nil,
            compare = if var3 then var3.Graph else nil
        }
    )
end

function var1.renderChildrenStats(arg1, arg2)
    local var2 = arg1.props.data[arg1.props.activeSnapshot]
    local var3 = arg1.props.data[arg1.props.compareSnapshot]

    local var4 = var2[arg2]
    local var5 = if var3 then var3[arg2] else nil
    local result = ({})

    for value, value2 in var4 do
        local var6 = nil

        if var5 then
            for _, value3 in ipairs(var5) do
                if value2.Name == value3.Name then
                    var6 = value3
                    break
                end
            end
        end

        local createElement = Roact.createElement
        local var7 = LuauHeapViewStatEntry
        local tbl2 = {
            layoutOrder = -value2.Size,
            depth = 0,
            data = value2,
            compare = var6
        }
        result[value] = createElement(var7, tbl2)
    end

    return result
end

function var1.renderUnparentedRefs(arg1)
    local refs = arg1.props.data[arg1.props.activeSnapshot].Refs

    if not refs then
        return {}
    end
    local unparentedReferences = refs.UnparentedReferences
    if not unparentedReferences then
        return {}
    end

    local result = ({})

    for value, value2 in unparentedReferences do
        local createElement = Roact.createElement
        local var2 = LuauHeapViewRefEntry
        local tbl2 = {
            layoutOrder = -value2.Instances,
            depth = 0,
            data = value2
        }
        result[value] = createElement(var2, tbl2)
    end

    return result
end

function var1.renderChildrenRefs(arg1)
    local refs = arg1.props.data[arg1.props.activeSnapshot].Refs

    if not refs then
        return {}
    end
    assert(refs)

    local result = ({})

    for k, root in refs.Roots do
        local createElement = Roact.createElement
        local var2 = LuauHeapViewRefEntry
        local tbl2 = {
            layoutOrder = -root.Instances,
            depth = 0,
            data = root
        }
        result[k] = createElement(var2, tbl2)
    end

    return result
end

function var1.createTabSelector(arg1, size, position)
    local function onTabSelected(activeTab: string) -- Luacid: Inlined by compiler; 1 call site recovered
        arg1:setState({ activeTab = activeTab })
    end

    local function createButton(activeTab: string, text: string, num1: number)
        return Roact.createElement(BoxButton, {
            text = text,
            size = UDim2.new(0, TabButtonWidth, 0, TabButtonHeight),
            pos = UDim2.new(0, TabButtonWidth * num1, 0, 0),
            onClicked = function()
                onTabSelected(activeTab)
            end
        })
    end

    local function createHighlight(activeTab: string, num1: number)
        if arg1.state.activeTab ~= activeTab then
            return nil
        end

        return (Roact.createElement("Frame", {
            Size = UDim2.new(0, TabButtonWidth, 0, TabHighlightHeight),
            Position = UDim2.new(0, TabButtonWidth * num1, 0, TabButtonHeight - TabHighlightHeight),
            BorderSizePixel = 0,
            BackgroundColor3 = Constants.Color.HighlightBlue,
            ZIndex = 10
        }))
    end

    if game:GetEngineFeature("UnparentedInstances") then
        return Roact.createElement("Frame", {
            Size = size,
            Position = position,
            BackgroundTransparency = 1
        }, {
            Graph = createButton("graph", "Graph", 0),
            GraphHighlight = createHighlight("graph", 0),
            Tags = createButton("tag", "Object Tags", 1),
            TagHighlight = createHighlight("tag", 1),
            Memcat = createButton("memcat", "Memory Categories", 2),
            MemcatHighlight = createHighlight("memcat", 2),
            Userdata = createButton("userdata", "Object Classes", 3),
            UserdataHighlight = createHighlight("userdata", 3),
            Refs = createButton("UniqueRefs", "Unique References", 4),
            RefHighlight = createHighlight("UniqueRefs", 4),
            UnparentedInstances = createButton("UnparentedRefs", "Unparented Instances", 5),
            UnparentedHighlight = createHighlight("UnparentedRefs", 5)
        })
    end
    return Roact.createElement("Frame", {
        Size = size,
        Position = position,
        BackgroundTransparency = 1
    }, {
        Graph = createButton("graph", "Graph", 0),
        GraphHighlight = createHighlight("graph", 0),
        Tags = createButton("tag", "Object Tags", 1),
        TagHighlight = createHighlight("tag", 1),
        Memcat = createButton("memcat", "Memory Categories", 2),
        MemcatHighlight = createHighlight("memcat", 2),
        Userdata = createButton("userdata", "Object Classes", 3),
        UserdataHighlight = createHighlight("userdata", 3),
        Refs = createButton("refs", "Unique References", 4),
        RefHighlight = createHighlight("refs", 4),
        UnparentedInstances = createButton("UnparentedRefs", "Unparented Instances", 5),
        UnparentedHighlight = createHighlight("UnparentedRefs", 5)
    })
end

function var1.createStatsTableHeader(arg1, yScale: number?, yOffset: number?, arg2)
    return Roact.createElement("Frame", {
        Size = UDim2.new(1 - SnapshotWidth, 0, 0, HeaderFrameHeight),
        Position = UDim2.new(SnapshotWidth, 0, yScale, yOffset),
        BackgroundTransparency = 1
    }, {
        First = if arg2[1] then Roact.createElement(HeaderButton, {
            text = arg2[1],
            size = UDim2.new(1 - ValueCellWidth * 2, -ValuePadding - CellPadding, 0, HeaderFrameHeight),
            pos = UDim2.new(0, CellPadding, 0, 0),
            sortfunction = arg1.onSortChanged
        }) else nil,
        Second = if arg2[2] then Roact.createElement(HeaderButton, {
            text = arg2[2],
            size = UDim2.new(ValueCellWidth, -CellPadding, 0, HeaderFrameHeight),
            pos = UDim2.new(1 - ValueCellWidth * 2, ValuePadding, 0, 0),
            sortfunction = arg1.onSortChanged
        }) else nil,
        Third = if arg2[3] then Roact.createElement(HeaderButton, {
            text = arg2[3],
            size = UDim2.new(ValueCellWidth, -CellPadding, 0, HeaderFrameHeight),
            pos = UDim2.new(1 - ValueCellWidth, ValuePadding, 0, 0),
            sortfunction = arg1.onSortChanged
        }) else nil,
        TopHorizontal = Roact.createElement("Frame", { Size = UDim2.new(1, 0, 0, 1), BackgroundColor3 = LineColor, BorderSizePixel = 0 }),
        LowerHorizontal = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, LineWidth),
            Position = UDim2.new(0, 0, 1, 0),
            BackgroundColor3 = LineColor,
            BorderSizePixel = 0
        }),
        Vertical1 = Roact.createElement("Frame", {
            Size = UDim2.new(0, LineWidth, 1, 0),
            Position = UDim2.new(1 - ValueCellWidth, 0, 0, 0),
            BackgroundColor3 = LineColor,
            BorderSizePixel = 0
        }),
        Vertical2 = Roact.createElement("Frame", {
            Size = UDim2.new(0, LineWidth, 1, 0),
            Position = UDim2.new(1 - ValueCellWidth * 2, 0, 0, 0),
            BackgroundColor3 = LineColor,
            BorderSizePixel = 0
        })
    })
end

function var1.init(arg1)
    arg1.state = { activeTab = "graph" }
end

function var1.render(arg1)
    local layoutOrder = arg1.props.layoutOrder
    local size = arg1.props.size

    local var2 = tbl1[arg1.state.activeTab]
    local element

    if arg1.props.data and #arg1.props.data ~= 0 then
        element = nil
    else
        element = Roact.createElement("TextLabel", {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            Text = "Capture a Snapshot to view details",
            TextColor3 = Constants.Color.Text,
            BackgroundTransparency = 1,
            LayoutOrder = layoutOrder
        })
    end

    return Roact.createElement("Frame", {
        Size = size,
        BackgroundTransparency = 1,
        LayoutOrder = layoutOrder
    }, {
        SnapshotHeader = Roact.createElement(HeaderButton, {
            text = "Snapshots",
            size = UDim2.new(SnapshotWidth, -CellPadding, 0, HeaderFrameHeight),
            pos = UDim2.new(0, CellPadding, 0, 0)
        }),
        Snapshots = Roact.createElement("ScrollingFrame", {
            Size = UDim2.new(SnapshotWidth, -4, 1, -HeaderFrameHeight),
            Position = UDim2.new(0, 2, 0, HeaderFrameHeight),
            BackgroundTransparency = 1,
            VerticalScrollBarInset = Enum.ScrollBarInset.None,
            ScrollBarThickness = 5,
            CanvasSize = UDim2.fromScale(0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y
        }, {
            Layout = Roact.createElement(
                "UIListLayout",
                {
                    FillDirection = Enum.FillDirection.Vertical,
                    SortOrder = Enum.SortOrder.LayoutOrder
                }
            ),
            Stroke = Roact.createElement("UIStroke", { Thickness = 2, Color = Color3.new(0.6, 0.6, 0.6) }),
            Children = Roact.createFragment(arg1:renderSnapshotList())
        }),
        Tabs = arg1:createTabSelector(UDim2.new(1 - SnapshotWidth, 0, 0, TabsHeight), UDim2.new(SnapshotWidth, 0, 0, 0)),
        Hint = Roact.createElement("TextLabel", {
            Size = UDim2.new(1 - SnapshotWidth, 0, 0, TableHintHeight),
            Position = UDim2.new(SnapshotWidth, 0, 0, TabsHeight),
            Text = var2.hint,
            TextColor3 = Constants.Color.Text,
            BackgroundTransparency = 1
        }),
        Headers = arg1:createStatsTableHeader(0, TabsHeight + TableHintHeight, var2.headers),
        Entries = Roact.createElement("ScrollingFrame", {
            Size = UDim2.new(1 - SnapshotWidth, 0, 1, -(TabsHeight + TableHintHeight + HeaderFrameHeight)),
            Position = UDim2.new(SnapshotWidth, 0, 0, TabsHeight + TableHintHeight + HeaderFrameHeight),
            BackgroundTransparency = 1,
            VerticalScrollBarInset = Enum.ScrollBarInset.None,
            ScrollBarThickness = 5,
            CanvasSize = UDim2.fromScale(0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y
        }, {
            Layout = Roact.createElement(
                "UIListLayout",
                {
                    FillDirection = Enum.FillDirection.Vertical,
                    SortOrder = Enum.SortOrder.LayoutOrder
                }
            ),
            Children = element or Roact.createFragment(var2.initFragmentSource(arg1))
        })
    })
end

return RoactRodux.UNSTABLE_connect2(nil, function(callback) -- name: mapDispatchToProps
    return {
        dispatchSetLuauHeapActiveSnapshot = function(num1: number)
            callback(SetLuauHeapActiveSnapshot(num1))
        end,
        dispatchSetLuauHeapCompareSnapshot = function(num1: number)
            callback(SetLuauHeapCompareSnapshot(num1))
        end
    }
end)(var1)

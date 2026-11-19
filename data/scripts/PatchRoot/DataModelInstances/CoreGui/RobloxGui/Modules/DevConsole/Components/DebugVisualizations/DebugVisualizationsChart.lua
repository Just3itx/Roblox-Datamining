-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local LinkingProtocol = require(CorePackages.Workspace.Packages.LinkingProtocol).LinkingProtocol

local Components = script.Parent.Parent.Parent.Components
local BannerButton = require(Components.BannerButton)
local BoxButton = require(Components.BoxButton)
local CellCheckbox = require(Components.CellCheckbox)
local CellLabel = require(Components.CellLabel)
local DataConsumer = require(Components.DataConsumer)
local DropDown = require(Components.DropDown)
local HeaderButton = require(Components.HeaderButton)

local Constants = require(script.Parent.Parent.Parent.Constants)
local GeneralFormatting = Constants.GeneralFormatting
local LineWidth = GeneralFormatting.LineWidth
local LineColor = GeneralFormatting.LineColor

local DebugVisualizationsFormatting = Constants.DebugVisualizationsFormatting
local ChartHeaderNames = DebugVisualizationsFormatting.ChartHeaderNames
local ChartCellWidths = DebugVisualizationsFormatting.ChartCellWidths
local HeaderFrameHeight = DebugVisualizationsFormatting.HeaderFrameHeight
local EntryFrameHeight = DebugVisualizationsFormatting.EntryFrameHeight
local CellPadding = DebugVisualizationsFormatting.CellPadding
local MinFrameWidth = DebugVisualizationsFormatting.MinFrameWidth
local LearnMoreWidth = DebugVisualizationsFormatting.LearnMoreWidth

local MainWindow = Constants.DefaultFontSize.MainWindow
local MainWindow2 = Constants.Font.MainWindow

local bool1 = game:DefineFastFlag("SlimDevConsole2", false)
local TextService = if bool1 then game:GetService("TextService") or nil else nil

local function getDescriptionWidth(xOffset, arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg1 == nil then
        return xOffset - CellPadding * 2
    end

    return xOffset - LearnMoreWidth - CellPadding * 2
end

local function getDescriptionHeight(str1: string, x: number?): number -- Luacid: Inlined by compiler; 1 call site recovered
    return math.max(TextService:GetTextSize(str1, MainWindow, MainWindow2, Vector2.new(x, math.huge)).Y, EntryFrameHeight)
end

local num1 = 0
for _, ChartCellWidth in ipairs(ChartCellWidths) do
    num1 += ChartCellWidth
end

local tbl1 = {}
local tbl2 = {}
local tbl3 = {}
local var1 = -num1 / 2
table.insert(tbl1, UDim2.fromOffset(CellPadding, 0))
table.insert(tbl2, UDim2.new(0.5, var1 - CellPadding, 0, HeaderFrameHeight))
table.insert(tbl3, UDim2.new(0.5, var1 - CellPadding, 0, EntryFrameHeight))

for _, ChartCellWidth in ipairs(ChartCellWidths) do
    table.insert(tbl1, UDim2.new(0.5, var1 + CellPadding, 0, 0))
    table.insert(tbl2, UDim2.fromOffset(ChartCellWidth - CellPadding, HeaderFrameHeight))
    table.insert(tbl3, UDim2.fromOffset(ChartCellWidth - CellPadding, EntryFrameHeight))
    var1 += ChartCellWidth
end

table.insert(tbl1, UDim2.new(0.5, var1 + CellPadding, 0, 0))
table.insert(tbl2, UDim2.new(0.5, -num1 / 2 - CellPadding, 0, HeaderFrameHeight))
table.insert(tbl3, UDim2.new(0.5, -num1 / 2 - CellPadding, 0, EntryFrameHeight))

assert(
    #ChartCellWidths == 2,
    "DebugVisualizationsChart expected DebugVisualizationsFormatting CELL_WIDTHS to have a length of 2"
)

assert(#tbl1 == 4, "DebugVisualizationsChart expected cellOffset to have length " .. 4)

assert(#tbl2 == 4, "DebugVisualizationsChart expected headerCellSize to have length " .. 4)

assert(#tbl3 == 4, "DebugVisualizationsChart expected entryCellSize to have length " .. 4)

local tbl4 = ({})
for i, value in ipairs(tbl1) do
    tbl4[i] = UDim2.new(value.X.Scale, value.X.Offset - CellPadding, value.Y.Scale, value.Y.Offset)
end

local var2 = Roact.Component:extend("DebugVisualizationsChart")

local function constructHeader(sortfunction, xOffset: number?)
    local tbl5 = ({})

    for i, text in ipairs(ChartHeaderNames) do
        local createElement = Roact.createElement
        local var3 = HeaderButton
        local tbl6 = {
            text = text,
            size = tbl2[i],
            pos = tbl1[i],
            sortfunction = sortfunction
        }
        tbl5[text] = createElement(var3, tbl6)
    end

    tbl5.upperHorizontalLine = Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, LineWidth),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = LineColor,
        BorderSizePixel = 0
    })

    tbl5.lowerHorizontalLine = Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, LineWidth),
        Position = UDim2.new(0, 0, 1, -LineWidth),
        BackgroundColor3 = LineColor,
        BorderSizePixel = 0
    })

    for i = 2, #tbl4 do
        local str1 = string.format("VerticalLine_%d", i)
        tbl5[str1] = Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(0, LineWidth, 1, 0),
                Position = tbl4[i],
                BackgroundColor3 = LineColor,
                BorderSizePixel = 0
            }
        )
    end

    return Roact.createElement("Frame", { Size = UDim2.new(0, xOffset, 0, HeaderFrameHeight), BackgroundTransparency = 1 }, tbl5)
end

local function constructEntry(arg1, xOffset: number?, yOffset: number?, yOffset2: number?, layoutOrder, isExpanded: boolean, getOnButtonPress, getLearnMorePress)
    local name = arg1.name
    local settingInfo = arg1.settingInfo

    local str1 = tostring(settingInfo.Name)

    local tbl5 = {}
    for i = 2, #tbl4 do
        local str2 = string.format("line_%d", i)
        tbl5[str2] = Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(0, LineWidth, 1, 0),
                Position = tbl4[i],
                BackgroundColor3 = LineColor,
                BorderSizePixel = 0
            }
        )
    end

    tbl5[name] = Roact.createElement(CellLabel, { text = str1, size = tbl3[1], pos = tbl1[1] })

    if bool1 and settingInfo.Kind == "Dropdown" then
        local enumItems = settingInfo.EnumItems
        local num2 = 1
        for i, enumItem in ipairs(enumItems) do
            if enumItem == settingInfo.Value then
                num2 = i
                break
            end
        end

        tbl5.checkbox = Roact.createElement("Frame", {
            Size = tbl3[2],
            Position = tbl1[2],
            BackgroundTransparency = 1
        }, {
            DropDown = Roact.createElement(DropDown, {
                buttonSize = UDim2.new(1, -CellPadding, 0, EntryFrameHeight - 8),
                position = UDim2.new(0, 0, 0, 4),
                dropDownList = settingInfo.DropDownList,
                selectedIndex = num2,
                onSelection = function(arg2)
                    arg1.valueChangeCallback(str1, enumItems[arg2])
                end
            })
        })
    else
        tbl5.checkbox = Roact.createElement(CellCheckbox, {
            name = str1,
            isSelected = settingInfo.Value,
            size = tbl3[2],
            pos = tbl1[2],
            OnCheckboxClicked = arg1.valueChangeCallback
        })
    end

    tbl5.visualType = Roact.createElement(CellLabel, { text = settingInfo.Type, size = tbl3[3], pos = tbl1[3] })

    tbl5.tags = Roact.createElement(CellLabel, { text = tostring(settingInfo.Tagstring), size = tbl3[4], pos = tbl1[4] })

    tbl5.lowerHorizontalLine = Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, LineWidth),
        Position = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = LineColor,
        BorderSizePixel = 0
    })

    local learnMoreUrl = nil
    local var3, element

    if bool1 then
        learnMoreUrl = settingInfo.LearnMoreUrl
        local descriptionWidth = getDescriptionWidth(xOffset, learnMoreUrl)
        var3 = UDim2.new(0, descriptionWidth, 0, yOffset2)
        element = learnMoreUrl ~= nil
    else
        var3 = UDim2.new(0, xOffset - LearnMoreWidth - CellPadding * 2, 0, EntryFrameHeight)
        element = true
    end

    local createElement = Roact.createElement
    local str2 = "Frame"
    local tbl6 = {
        Size = UDim2.new(0, xOffset, 0, yOffset),
        BackgroundTransparency = 1,
        LayoutOrder = layoutOrder
    }
    local tbl7 = {
        Button = Roact.createElement(BannerButton, {
            size = UDim2.new(1, 0, 0, EntryFrameHeight),
            pos = UDim2.new(),
            isExpanded = isExpanded,
            onButtonPress = getOnButtonPress(name)
        }, tbl5),
        DescriptionText = isExpanded
            and Roact.createElement(CellLabel, {
                pos = UDim2.new(0, CellPadding, 0, EntryFrameHeight + CellPadding),
                size = var3,
                text = tostring(settingInfo.Description)
            }),
        LearnMoreButton = 0
    }

    if isExpanded then
        element = element
            and Roact.createElement(BoxButton, {
                text = "Learn More",
                size = UDim2.new(0, LearnMoreWidth, 0, EntryFrameHeight),
                pos = UDim2.new(0, xOffset - LearnMoreWidth - CellPadding, 0, EntryFrameHeight + CellPadding),
                onClicked = if bool1 then getLearnMorePress(name, learnMoreUrl) else getLearnMorePress(name)
            })
    else
        element = isExpanded
    end

    tbl7.LearnMoreButton = element
    return createElement(str2, tbl6, tbl7)
end

function populateEntries(arg1, typeFilters, visualizationEntries, reverseSort, canvasPos, absScrollSize, xOffset, name, getOnButtonPress, getLearnMorePress)
    local tbl5 = ({})

    tbl5.UIListLayout = Roact.createElement("UIListLayout", {
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    local tbl6 = {}
    for k, typeFilter in pairs(typeFilters) do
        if typeFilter then
            table.insert(tbl6, k)
        end
    end

    local visualizationEntriesLen = #visualizationEntries
    local num2 = 0

    if absScrollSize and canvasPos then
        local yOffset = -1
        local num3 = 0
        local num4 = 0

        for i, value in ipairs(visualizationEntries) do
            local bool2

            if arg1 then
                local str1 = tostring(value.settingInfo.Name)
                bool2 = string.find(str1:lower(), arg1:lower()) ~= nil or string.find(value.name:lower(), arg1:lower()) ~= nil
            else
                bool2 = false
            end

            local bool3

            if #tbl6 > 0 then
                bool3 = false
                for _, value2 in pairs(tbl6) do
                    if table.find(value.settingInfo.Tags, value2) ~= nil then
                        bool3 = true
                        break
                    end
                end

                if arg1 then
                    bool3 = bool2 and bool3
                else
                    arg1 = true
                end
            else
                bool3 = bool2
            end

            if arg1 and not bool3 then
                continue
            end

            local isExpanded = name == value.name

            local var3 = EntryFrameHeight
            local var4

            if bool1 then
                if isExpanded then
                    local descriptionWidth = getDescriptionWidth(xOffset, value.settingInfo.LearnMoreUrl)

                    local description = value.settingInfo.Description
                    var3 = getDescriptionHeight(tostring(description), descriptionWidth)

                    var4 = EntryFrameHeight + var3 + CellPadding * 2
                else
                    var4 = EntryFrameHeight
                end
            else
                var4 = isExpanded and EntryFrameHeight * 2 + CellPadding * 2 or EntryFrameHeight
            end

            if num2 + EntryFrameHeight >= canvasPos.Y then
                if num3 < absScrollSize.Y then
                    local var5 = if reverseSort then visualizationEntriesLen - i or i else i
                    tbl5[i] = constructEntry(value, xOffset, var4, var3, var5 + 1, isExpanded, getOnButtonPress, getLearnMorePress)
                end

                if yOffset < 0 then
                    yOffset = num2
                else
                    num3 += EntryFrameHeight
                end
                num4 += 1
            end

            num2 += var4
        end

        if num4 == 0 then
            tbl5.NoneFound = Roact.createElement("TextLabel", {
                Size = UDim2.fromScale(1, 1),
                Text = "No DebugVisualizations Found",
                TextColor3 = LineColor,
                BackgroundTransparency = 1,
                LayoutOrder = 1
            })
        else
            tbl5.WindowingPadding = Roact.createElement("Frame", { Size = UDim2.new(1, 0, 0, yOffset), BackgroundTransparency = 1, LayoutOrder = 1 })
        end
    end

    return tbl5, num2
end

function var2.init(arg1, arg2)
    local visualizationEntries = arg2.DebugVisualizationsData:getCurrentData()

    function arg1.getOnButtonPress(expandedEntry)
        return function(_, _)
            arg1:setState({ expandedEntry = not (arg1.state.expandedEntry == expandedEntry) and expandedEntry })
        end
    end

    function arg1.getLearnMorePress(arg3, arg4)
        return function(_, _)
            LinkingProtocol.default:openURL(
                if bool1 then arg4 else "https://create.roblox.com/docs/reference/engine/classes/PhysicsSettings#" .. arg3
            )
        end
    end
    function arg1.onSortChanged(arg3)
        if arg3 == arg2.DebugVisualizationsData:getSortType() then
            arg1:setState(function(arg4)
                return {
                    reverseSort = not arg4.reverseSort
                }
            end)

            return
        end

        arg2.DebugVisualizationsData:setSortType(arg3)
        arg1:setState({ reverseSort = false })
    end

    function arg1.onCanvasPosChanged()
        local canvasPosition = arg1.scrollingRef.current.CanvasPosition
        arg1:setState({ canvasPos = canvasPosition })
    end

    arg1.scrollingRef = Roact.createRef()

    arg1.state = {
        visualizationEntries = visualizationEntries,
        reverseSort = false,
        expandedEntry = nil
    }
end

function var2.didUpdate(arg1)
    if not arg1.scrollingRef.current then
        return
    end

    local absoluteSize = arg1.scrollingRef.current.AbsoluteSize
    if absoluteSize ~= arg1.state.absScrollSize then
        arg1:setState({ absScrollSize = absoluteSize })
    end
end

function var2.didMount(arg1)
    arg1.visualizationsUpdated = arg1.props.DebugVisualizationsData:Signal():Connect(function(visualizationEntries)
        arg1:setState({ visualizationEntries = visualizationEntries })
    end)

    if not arg1.scrollingRef.current then
        return
    end

    arg1.canvasPosConnector = arg1.scrollingRef.current:GetPropertyChangedSignal("CanvasPosition"):Connect(arg1.onCanvasPosChanged)

    arg1:setState(
        {
            absScrollSize = arg1.scrollingRef.current.AbsoluteSize,
            canvasPos = arg1.scrollingRef.current.CanvasPosition
        }
    )
end

function var2.willUnmount(arg1)
    arg1.visualizationsUpdated:Disconnect()
    arg1.visualizationsUpdated = nil
    arg1.canvasPosConnector:Disconnect()
    arg1.canvasPosConnector = nil
end

function var2.render(arg1)
    local absScrollSize = arg1.state.absScrollSize
    local xOffset = absScrollSize and math.max(absScrollSize.X, MinFrameWidth) or MinFrameWidth

    local var3, yOffset = populateEntries(
        arg1.props.searchTerm,
        arg1.props.typeFilters,
        arg1.state.visualizationEntries,
        arg1.state.reverseSort,
        arg1.state.canvasPos,
        absScrollSize,
        xOffset,
        arg1.state.expandedEntry,
        arg1.getOnButtonPress,
        arg1.getLearnMorePress
    )

    local size = arg1.props.size
    local layoutOrder = arg1.props.layoutOrder

    local createElement = Roact.createElement

    local tbl5 = {
        Header = constructHeader(arg1.onSortChanged, xOffset),
        MainChart = Roact.createElement("ScrollingFrame", {
            Position = UDim2.fromOffset(0, HeaderFrameHeight),
            Size = UDim2.new(1, 0, 1, -HeaderFrameHeight),
            CanvasSize = UDim2.fromOffset(xOffset, yOffset),
            ScrollBarThickness = 6,
            BackgroundColor3 = Constants.Color.BaseGray,
            BackgroundTransparency = 1,
            [Roact.Ref] = arg1.scrollingRef
        }, var3)
    }
    return createElement(
        "Frame",
        {
            Size = size,
            BackgroundTransparency = 1,
            ClipsDescendants = true,
            LayoutOrder = layoutOrder
        },
        tbl5
    )
end

return DataConsumer(var2, "DebugVisualizationsData")

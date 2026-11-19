-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:50:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local TextService = game:GetService("TextService")
local Roact = require(CorePackages.Packages.Roact)

local Constants = require(script.Parent.Parent.Constants)
local FrameHeight = Constants.TabRowFormatting.FrameHeight
local TabDropDownWidth = Constants.TabRowFormatting.TabDropDownWidth
local TabOverlapThreshold = Constants.TabRowFormatting.TabOverlapThreshold

local FrameHeight2 = Constants.UtilityBarFormatting.FrameHeight
local SmallFrameHeight = Constants.UtilityBarFormatting.SmallFrameHeight
local SmallUtilPadding = Constants.UtilityBarFormatting.SmallUtilPadding
local ClientServerButtonWidth = Constants.UtilityBarFormatting.ClientServerButtonWidth
local ClientServerDropDownWidth = Constants.UtilityBarFormatting.ClientServerDropDownWidth

local MainRowPadding = Constants.GeneralFormatting.MainRowPadding

local scriptParent = script.Parent
local ClientServerButton = require(scriptParent.ClientServerButton)
local CheckboxContainer = require(scriptParent.CheckboxContainer)
local TabRowContainer = require(scriptParent.TabRowContainer)
local SearchBar = require(scriptParent.SearchBar)
local GetFFlagVoiceDebugConsoleV2 = require(scriptParent.VoiceDebug.GetFFlagVoiceDebugConsoleV2)

local var1 = Roact.Component:extend("UtilAndTab")

function var1.init(arg1)
    local tabList = arg1.props.tabList
    local num1 = 0
    local num2 = 0

    for k, _ in pairs(tabList) do
        num1 += TextService:GetTextSize(k, Constants.DefaultFontSize.TabBar, Constants.Font.TabBar, Vector2.new(0, 0)).X
        num2 += 1
    end

    function arg1.showSearchBar()
        arg1:setState({ activeSearchTerm = true })
    end

    function arg1.cancelInput(_, arg2)
        if arg2.UserInputType ~= Enum.UserInputType.MouseButton1
            and (arg2.UserInputType ~= Enum.UserInputType.Touch or arg2.UserInputState ~= Enum.UserInputState.End)
        then
            return
        end
        if arg1.searchRef.current then
            arg1.searchRef.current.Text = ""
        end

        local onSearchTermChanged = arg1.props.onSearchTermChanged
        if onSearchTermChanged then
            onSearchTermChanged("")
        end

        arg1:setState({ activeSearchTerm = false })
    end

    function arg1.focusLost(arg2, arg3, _)
        if not arg3 then
            return
        end

        local text = arg2.text
        local onSearchTermChanged = arg1.props.onSearchTermChanged
        if onSearchTermChanged then
            onSearchTermChanged(text)
        end
        local activeSearchTerm = text ~= ""
        if arg1.state.activeSearchTerm ~= activeSearchTerm then
            arg1:setState({ activeSearchTerm = activeSearchTerm })
        end
    end

    arg1.state = { totalTabWidth = num1, totalTabCount = num2, activeSearchTerm = false }

    arg1.utilRef = Roact.createRef()
    arg1.searchRef = Roact.createRef()
end

function var1.render(arg1)
    local windowWidth = arg1.props.windowWidth
    local formFactor = arg1.props.formFactor
    local tabList = arg1.props.tabList
    local orderedCheckboxState = arg1.props.orderedCheckboxState
    local layoutOrder = arg1.props.layoutOrder
    local isClientView = arg1.props.isClientView
    local searchTerm = arg1.props.searchTerm

    local onClientButton = arg1.props.onClientButton
    local onServerButton = arg1.props.onServerButton
    local onCheckboxChanged = arg1.props.onCheckboxChanged
    local onSearchTermChanged = arg1.props.onSearchTermChanged

    local totalTabWidth = arg1.state.totalTabWidth
    local totalTabCount = arg1.state.totalTabCount
    local activeSearchTerm = arg1.state.activeSearchTerm
    local useDropDown = (windowWidth - totalTabWidth) / totalTabCount < TabOverlapThreshold and windowWidth > 0
    local yOffset = formFactor == Constants.FormFactor.Small and SmallFrameHeight or FrameHeight2
    local num1 = if formFactor == Constants.FormFactor.Small then 6 else 7
    local var2 = if arg1.props[Roact.Children] then math.ceil(#arg1.props[Roact.Children] / 5) or 1 else 1
    local createElement = Roact.createElement
    local tbl1 = {
        Position = UDim2.new(1, -num1 * ClientServerButtonWidth - MainRowPadding, 0, 0),
        Size = UDim2.new(0, 5 * ClientServerButtonWidth, 0, yOffset * var2),
        BackgroundTransparency = 1
    }
    local tableValue1 = Roact.createElement("UIGridLayout", {
        CellPadding = UDim2.new(0, MainRowPadding, 0, 0),
        CellSize = UDim2.new(0, ClientServerButtonWidth, 0, yOffset),
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        FillDirectionMaxCells = 5
    })
    local buttons = createElement("Frame", tbl1, { Layout = tableValue1, unpack(arg1.props[Roact.Children] or {}) })

    if formFactor ~= Constants.FormFactor.Small and not useDropDown then
        local var3 = onClientButton and onServerButton

        local var4 = windowWidth - SmallUtilPadding * 3 - 3 * ClientServerButtonWidth

        if var3 then
            var4 -= ClientServerButtonWidth
        end

        local createElement2 = Roact.createElement
        local str1 = "Frame"
        local tbl2 = {
            Size = UDim2.new(1, 0, 0, FrameHeight + FrameHeight2 * var2 + MainRowPadding),
            BackgroundTransparency = 1,
            LayoutOrder = layoutOrder,
            [Roact.Ref] = arg1.props.refForParent
        }
        local tbl3 = {
            Tabs = Roact.createElement(
                TabRowContainer,
                {
                    tabList = tabList,
                    windowWidth = windowWidth,
                    frameHeight = FrameHeight,
                    formFactor = formFactor
                }
            ),
            UtilBar = Roact.createElement("Frame", {
                Position = UDim2.new(0, 4, 0, FrameHeight + MainRowPadding),
                Size = UDim2.new(1, -8, 0, FrameHeight2),
                BackgroundTransparency = 1,
                [Roact.Ref] = arg1.utilRef
            }, {
                MainRow = Roact.createElement("Frame", {
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1
                }, {
                    UIListLayout = Roact.createElement("UIListLayout", {
                        HorizontalAlignment = Enum.HorizontalAlignment.Left,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        VerticalAlignment = Enum.VerticalAlignment.Top,
                        FillDirection = Enum.FillDirection.Horizontal,
                        Padding = UDim.new(0, SmallUtilPadding)
                    }),
                    ClientServerButton = var3
                        and Roact.createElement(ClientServerButton, {
                            formFactor = formFactor,
                            isClientView = isClientView,
                            onClientButton = onClientButton,
                            onServerButton = onServerButton
                        }),
                    FilterCheckboxes = onCheckboxChanged
                        and Roact.createElement(CheckboxContainer, {
                            orderedCheckboxState = orderedCheckboxState,
                            frameWidth = var4,
                            frameHeight = FrameHeight2,
                            pos = UDim2.new(0, 2 * ClientServerButtonWidth + MainRowPadding, 0, 0),
                            onCheckboxChanged = onCheckboxChanged
                        })
                }),
                SearchBar = onSearchTermChanged
                    and Roact.createElement(SearchBar, {
                        size = UDim2.new(0, 2 * ClientServerButtonWidth, 0, FrameHeight2),
                        pos = UDim2.new(1, -2 * ClientServerButtonWidth, 0, 0),
                        searchTerm = searchTerm,
                        showClear = activeSearchTerm,
                        textSize = Constants.DefaultFontSize.Search,
                        font = Constants.Font.Search,
                        frameHeight = Constants.UtilityBarFormatting.FrameHeight,
                        refForParent = arg1.searchRef,
                        cancelInput = arg1.cancelInput,
                        focusLost = arg1.focusLost
                    }),
                Buttons = buttons,
                ExtraContent = if GetFFlagVoiceDebugConsoleV2() then arg1.props.extraContent else nil
            })
        }
        return createElement2(str1, tbl2, tbl3)
    end

    local yOffset2 = SmallFrameHeight * var2 + SmallUtilPadding
    if activeSearchTerm then
        yOffset2 = yOffset2 + SmallFrameHeight + SmallUtilPadding
    end

    local var3 = onClientButton and onServerButton

    local var4 = windowWidth - SmallFrameHeight - TabDropDownWidth

    if var3 then
        var4 -= ClientServerDropDownWidth
    end

    local xOffset = TextService:GetTextSize("Cancel", Constants.DefaultFontSize.UtilBar, Constants.Font.UtilBar, Vector2.new(0, 0)).X + 12

    local createElement2 = Roact.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(1, 0, 0, yOffset2),
        BackgroundTransparency = 1,
        LayoutOrder = layoutOrder,
        [Roact.Ref] = arg1.props.refForParent
    }
    local tbl3 = { MainFrame = 0, SearchBarFrame = 0 }
    local createElement3 = Roact.createElement
    local str2 = "Frame"
    local tbl4 = {
        Size = UDim2.new(1, 0, 0, SmallFrameHeight),
        BackgroundTransparency = 1,
        [Roact.Ref] = arg1.utilRef
    }
    local tbl5 = {
        MainRow = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1
        }, {
            UIListLayout = Roact.createElement("UIListLayout", {
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Top,
                FillDirection = Enum.FillDirection.Horizontal,
                Padding = UDim.new(0, SmallUtilPadding)
            }),
            Tabs = Roact.createElement(TabRowContainer, {
                tabList = tabList,
                windowWidth = windowWidth,
                frameHeight = SmallFrameHeight,
                formFactor = formFactor,
                layoutOrder = 1
            }),
            ClientServerButton = var3
                and Roact.createElement(ClientServerButton, {
                    frameHeight = SmallFrameHeight,
                    formFactor = formFactor,
                    useDropDown = useDropDown,
                    isClientView = isClientView,
                    layoutOrder = 2,
                    onClientButton = onClientButton,
                    onServerButton = onServerButton
                }),
            FilterCheckboxes = onCheckboxChanged
                and Roact.createElement(CheckboxContainer, {
                    orderedCheckboxState = orderedCheckboxState,
                    frameWidth = var4,
                    frameHeight = SmallFrameHeight,
                    pos = UDim2.new(0, 2 * ClientServerButtonWidth + MainRowPadding, 0, 0),
                    layoutOrder = 3,
                    onCheckboxChanged = onCheckboxChanged
                })
        }),
        SearchButton = Roact.createElement("ImageButton", {
            Size = UDim2.new(0, SmallFrameHeight, 0, SmallFrameHeight),
            Position = UDim2.new(1, -SmallFrameHeight, 0, 0),
            BackgroundTransparency = 1,
            Image = Constants.Image.Search,
            Visible = not activeSearchTerm,
            [Roact.Event.Activated] = arg1.showSearchBar
        }),
        Buttons = buttons,
        ExtraContent = if GetFFlagVoiceDebugConsoleV2() then arg1.props.extraContent else nil
    }
    tbl3.MainFrame = createElement3(str2, tbl4, tbl5)

    local createElement4 = Roact.createElement
    local tbl6 = {
        Size = UDim2.new(1, 0, 0, SmallFrameHeight),
        Position = UDim2.new(0, 0, 0, (SmallFrameHeight + SmallUtilPadding) * var2),
        Visible = activeSearchTerm,
        BorderSizePixel = 0,
        BackgroundTransparency = 1
    }

    local tbl7 = {
        SearchBar = Roact.createElement(SearchBar, {
            size = UDim2.new(1, -xOffset, 0, SmallFrameHeight),
            searchTerm = searchTerm,
            showClear = activeSearchTerm,
            textSize = Constants.DefaultFontSize.Search,
            font = Constants.Font.Search,
            frameHeight = SmallFrameHeight,
            refForParent = arg1.searchRef,
            cancelInput = arg1.cancelInput,
            focusLost = arg1.focusLost
        }),
        CancelButton = Roact.createElement("TextButton", {
            Size = UDim2.new(0, xOffset, 1, 0),
            Position = UDim2.new(1, -xOffset, 0, 0),
            Text = "Cancel",
            TextSize = Constants.DefaultFontSize.UtilBar,
            TextColor3 = Constants.Color.Text,
            Font = Constants.Font.UtilBar,
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            [Roact.Event.Activated] = arg1.cancelInput
        })
    }
    tbl3.SearchBarFrame = createElement4("Frame", tbl6, tbl7)
    return createElement2(str1, tbl2, tbl3)
end

return var1

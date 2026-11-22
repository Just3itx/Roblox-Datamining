-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MusicPicker = script:FindFirstAncestor("MusicPicker")
local MusicPickerParent = MusicPicker.Parent

local BuilderIcons = require(MusicPickerParent.BuilderIcons)
local Foundation = require(MusicPickerParent.Foundation)
local React = require(MusicPickerParent.React)

local Icon = Foundation.Icon
local IconButton = Foundation.IconButton
local FoundationText = Foundation.Text
local View = Foundation.View
local useStyleTags = Foundation.Hooks.useStyleTags
local useTokens = Foundation.Hooks.useTokens

local MusicPickerList = require(MusicPicker.Components.MusicPickerList)
local MusicPickerTabStrip = require(MusicPicker.Components.MusicPickerTabStrip)
local _MusicPickerTypes = require(MusicPicker.Types.MusicPickerTypes)

local MagnifyingGlass = BuilderIcons.Icon.MagnifyingGlass
local IconX = BuilderIcons.Icon.X

local function findActiveTab(tabs, id: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    for _, tab in tabs do
        if tab.id == id then
            return tab
        end
    end
    return if #tabs > 0 then tabs[1] else nil
end

local function MusicPickerView(tbl1)
    local var1 = useTokens()
    local var2 = useStyleTags(
        "fill size-0-full text-body-large text-align-x-left text-align-y-center text-no-wrap clip gui-object-defaults"
    )
    local emphasis = var1.Color.Content.Emphasis
    local element

    if tbl1.mode == "search" then
        element = React.createElement(MusicPickerList, { content = tbl1.searchContent, onSelect = tbl1.onSelect, LayoutOrder = 1 })
    else
        local activeTab = findActiveTab(tbl1.tabs, tbl1.activeTabId)
        local tbl2 = {}
        if tbl1.showTabs ~= false then
            tbl2.TabStrip = React.createElement(
                MusicPickerTabStrip,
                {
                    LayoutOrder = 1,
                    tabs = tbl1.tabs,
                    activeTabId = tbl1.activeTabId,
                    onTabSelected = tbl1.onTabSelected
                }
            )
        end

        if activeTab ~= nil then
            tbl2.Content = React.createElement(MusicPickerList, { content = activeTab.content, onSelect = tbl1.onSelect, LayoutOrder = 2 })
        end

        element = React.createElement(React.Fragment, nil, tbl2)
    end

    local safeAreaInsets = tbl1.safeAreaInsets
    local offset = math.max(if safeAreaInsets == nil then 0 else safeAreaInsets.left, var1.Padding.XLarge)
    local offset2 = math.max(if safeAreaInsets == nil then 0 else safeAreaInsets.right, var1.Padding.XLarge)

    local createElement = React.createElement
    local var3 = View
    local tbl2 = {
        onActivated = function() end,
        Size = UDim2.fromScale(1, 2 / 3),
        stateLayer = {
            affordance = Foundation.Enums.StateLayerAffordance.None
        },
        tag = "col align-x-center align-y-top gap-small position-bottom-center anchor-bottom-center size-full-0 radius-medium bg-surface-100",
        ZIndex = 5,
        padding = {
            top = UDim.new(0, var1.Padding.Medium),
            left = UDim.new(0, offset),
            right = UDim.new(0, offset2)
        }
    }
    local tbl3 = {
        DragHandle = React.createElement(View, { LayoutOrder = 1, Size = UDim2.fromOffset(32, 4), tag = "radius-circle bg-surface-300" }),
        ModalHeaderBar = React.createElement(
            View,
            {
                LayoutOrder = 2,
                tag = "row flex-x-between align-x-center align-y-center size-full-0 auto-y"
            },
            {
                Title = React.createElement(FoundationText, {
                    LayoutOrder = 1,
                    tag = "auto-xy text-heading-small text-align-x-left text-align-y-top text-truncate-end content-emphasis",
                    Text = tbl1.titleText
                }),
                CloseButton = React.createElement(IconButton, {
                    LayoutOrder = 2,
                    icon = IconX,
                    onActivated = tbl1.onClose,
                    size = Foundation.Enums.IconSize.Small,
                    variant = Foundation.Enums.ButtonVariant.Utility
                })
            }
        ),
        SearchBar = 0,
        Body = 0
    }

    local createElement2 = React.createElement
    local var4 = View
    local tbl4 = {
        cornerRadius = UDim.new(0.5, 0),
        LayoutOrder = 3,
        tag = "row align-y-center gap-large size-full-1000 padding-x-medium stroke-standard stroke-emphasis"
    }

    local tbl5 = {
        SearchIcon = React.createElement(Icon, { name = MagnifyingGlass, size = Foundation.Enums.IconSize.Medium, style = emphasis }),
        Input = 0
    }
    local createElement3 = React.createElement
    local tbl6 = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClearTextOnFocus = false,
        MultiLine = false,
        PlaceholderColor3 = emphasis.Color3,
        PlaceholderText = tbl1.searchPlaceholder,
        Text = tbl1.searchText,
        TextColor3 = emphasis.Color3,
        TextTransparency = emphasis.Transparency,
        [React.Tag] = var2
    }

    tbl6[React.Change.Text] = function(arg1) -- name: onSearchTextChanged
        tbl1.onSearchChanged(arg1.Text)
    end

    tbl6[React.Event.FocusLost] = function(_, bool1: boolean) -- name: onSearchFocusLost
        if bool1 then
            tbl1.onSubmitSearch()
        end
    end

    tbl5.Input = createElement3("TextBox", tbl6)
    tbl3.SearchBar = createElement2(var4, tbl4, tbl5)

    tbl3.Body = React.createElement(View, {
        LayoutOrder = 4,
        flexItem = {
            FlexMode = Enum.UIFlexMode.Shrink
        },
        tag = "col align-x-center align-y-top gap-xsmall size-full"
    }, element)
    return createElement(var3, tbl2, tbl3)
end

return MusicPickerView

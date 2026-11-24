-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:50:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local React = require(ExpChatParent.React)
local Foundation = require(ExpChatParent.Foundation)
local EmojiList = require(ExpChatParent.EmojiList)

local useCursor = require(ExpChatParent.UIBlox).App.SelectionCursor.useCursor

local Config = require(ExpChat.Config)
local PresetEntryText = require(ExpChat.Autocomplete.PresetEntryText)
local highlightMatchedText = require(ExpChat.Autocomplete.highlightMatchedText)

local function AutocompleteEntryV2(tbl1)
    local var1 = Foundation.Hooks.useTokens()
    local selectionImageObject = useCursor()
    local chatInputBarSettings = tbl1.chatInputBarSettings
    local bool1 = tbl1.layoutOrder == tbl1.selectedIndex
    local size1000 = var1.Size.Size_1000

    local var3 = highlightMatchedText(
        tbl1.result,
        tbl1.query,
        chatInputBarSettings.TextColor3:Lerp(chatInputBarSettings.BackgroundColor3, 0.3)
    )
    if tbl1.autocompleteType == "presets" then
        var3 = PresetEntryText.decorate(var3, chatInputBarSettings.TextSize)
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.layoutOrder,
        Size = UDim2.new(1, 0, 0, size1000),
        ZIndex = 2,
        [React.Event.MouseEnter] = tbl1.onAutocompleteDropdownHover
    }
    local tbl3 = { TextLabelButton = 0 }
    local createElement2 = React.createElement
    local str2 = "TextButton"
    local tbl4 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = if bool1 then Config.AutocompleteSelectedColor else nil,
        BackgroundTransparency = tbl1.setTransparency(if bool1 then Config.AutocompleteSelectedTransparency else 1, tbl1.transparencyValue),
        SelectionImageObject = selectionImageObject,
        Size = UDim2.new(1, 0, 0, size1000),
        Text = "",
        ZIndex = 3,
        [React.Event.Activated] = tbl1.onAutocompleteSelected
    }
    local tbl5 = {
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var1.Radius.Medium) }),
        UIPadding = React.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, var1.Padding.Small),
            PaddingRight = UDim.new(0, var1.Padding.Small),
            PaddingTop = UDim.new(0, var1.Padding.XSmall),
            PaddingBottom = UDim.new(0, var1.Padding.XSmall)
        }),
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            Padding = UDim.new(0, var1.Gap.Medium),
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        EmojiLabel = 0,
        TextLabel = 0
    }
    local element

    if tbl1.autocompleteType == "emojis" then
        element = React.createElement("TextLabel", {
            AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundTransparency = 1,
            FontFace = chatInputBarSettings.FontFace,
            LayoutOrder = 1,
            Size = UDim2.fromOffset(var1.Size.Size_600, 0),
            Text = EmojiList[tbl1.result].base,
            TextColor3 = chatInputBarSettings.TextColor3,
            TextSize = chatInputBarSettings.TextSize,
            TextStrokeColor3 = chatInputBarSettings.TextStrokeColor3,
            TextStrokeTransparency = tbl1.setTransparency(chatInputBarSettings.TextStrokeTransparency, tbl1.transparencyValue),
            TextTransparency = tbl1.setTransparency(0, tbl1.transparencyValue),
            ZIndex = 2
        })
    else
        element = nil
    end

    tbl5.EmojiLabel = element

    tbl5.TextLabel = React.createElement(
        "TextLabel",
        {
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            FontFace = chatInputBarSettings.FontFace,
            LayoutOrder = 2,
            RichText = true,
            Size = UDim2.new(),
            Text = var3,
            TextColor3 = chatInputBarSettings.TextColor3,
            TextSize = chatInputBarSettings.TextSize,
            TextStrokeColor3 = chatInputBarSettings.TextStrokeColor3,
            TextStrokeTransparency = tbl1.setTransparency(chatInputBarSettings.TextStrokeTransparency, tbl1.transparencyValue),
            TextTransparency = tbl1.setTransparency(0, tbl1.transparencyValue),
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 2
        },
        {
            UIFlexItem = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill })
        }
    )
    tbl3.TextLabelButton = createElement2(str2, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end

return AutocompleteEntryV2

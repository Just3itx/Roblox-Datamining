-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local React = require(ExpChatParent.React)

local ExpChatParent2 = ExpChat.Parent
local EmojiList = require(ExpChatParent2.EmojiList)

local useCursor = require(ExpChatParent2.UIBlox).App.SelectionCursor.useCursor

local Config = require(ExpChat.Config)
local PresetEntryText = require(ExpChat.Autocomplete.PresetEntryText)

local FFlagExpChatPresetChatAutocompleteEnabled = require(ExpChat.Flags.FFlagExpChatPresetChatAutocompleteEnabled)

return function(arg1)
    local selectionImageObject = useCursor()
    local createElement = React.createElement
    local str1 = "Frame"
    local tbl1 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, Config.AutocompleteEntryDefaultSizeY),
        BackgroundTransparency = 1,
        LayoutOrder = arg1.layoutOrder,
        ZIndex = 2,
        [React.Event.MouseEnter] = arg1.onAutocompleteDropdownHover
    }
    local tbl2 = { TextLabelButton = 0, Divider = 0 }
    local createElement2 = React.createElement
    local str2 = "TextButton"
    local tbl3 = {
        Size = UDim2.new(1, 0, 1, if arg1.isDividerVisible then -1 else 0),
        BackgroundTransparency = arg1.setTransparency(
            arg1.layoutOrder == arg1.selectedIndex and Config.AutocompleteSelectedTransparency or 1,
            arg1.transparencyValue
        ),
        BackgroundColor3 = arg1.layoutOrder == arg1.selectedIndex and Config.AutocompleteSelectedColor or nil,
        SelectionImageObject = selectionImageObject,
        Text = "",
        ZIndex = 3,
        [React.Event.Activated] = arg1.onAutocompleteSelected
    }
    local tbl4 = {
        UIPadding = React.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, 15),
            PaddingRight = UDim.new(0, 30),
            PaddingTop = UDim.new(0, 8),
            PaddingBottom = UDim.new(0, 8)
        }),
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        EmojiLabel = 0,
        SpaceLabel = 0,
        TextLabel = 0
    }
    local element

    if arg1.autocompleteType == "emojis" then
        element = React.createElement("TextLabel", {
            AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundTransparency = 1,
            FontFace = arg1.chatInputBarSettings.FontFace,
            RichText = true,
            Size = UDim2.new(0, 0, 0, 0),
            Text = string.format("%s", EmojiList[arg1.result].base),
            TextColor3 = arg1.chatInputBarSettings.TextColor3,
            TextSize = arg1.chatInputBarSettings.TextSize,
            TextStrokeColor3 = arg1.chatInputBarSettings.TextStrokeColor3,
            TextStrokeTransparency = arg1.setTransparency(arg1.chatInputBarSettings.TextStrokeTransparency, arg1.transparencyValue),
            TextTransparency = arg1.setTransparency(0, arg1.transparencyValue),
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            LayoutOrder = 1,
            ZIndex = 2
        })
    else
        element = false
    end

    tbl4.EmojiLabel = element
    local element2

    if arg1.autocompleteType == "emojis" then
        element2 = React.createElement("TextLabel", {
            AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundTransparency = 1,
            FontFace = arg1.chatInputBarSettings.FontFace,
            RichText = true,
            Size = UDim2.new(0, 0, 0, 0),
            Text = "  ",
            TextColor3 = arg1.chatInputBarSettings.TextColor3,
            TextSize = 14,
            TextStrokeColor3 = arg1.chatInputBarSettings.TextStrokeColor3,
            TextStrokeTransparency = arg1.setTransparency(arg1.chatInputBarSettings.TextStrokeTransparency, arg1.transparencyValue),
            TextTransparency = arg1.setTransparency(0, arg1.transparencyValue),
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            LayoutOrder = 2,
            ZIndex = 2
        })
    else
        element2 = false
    end

    tbl4.SpaceLabel = element2

    tbl4.TextLabel = React.createElement("TextLabel", {
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
        FontFace = arg1.chatInputBarSettings.FontFace,
        RichText = true,
        Size = UDim2.new(0, 0, 0, 0),
        Text = if FFlagExpChatPresetChatAutocompleteEnabled and arg1.autocompleteType == "presets" then PresetEntryText.decorate(arg1.result, arg1.chatInputBarSettings.TextSize) else string.format("%s", arg1.result),
        TextColor3 = arg1.chatInputBarSettings.TextColor3,
        TextSize = arg1.chatInputBarSettings.TextSize,
        TextStrokeColor3 = arg1.chatInputBarSettings.TextStrokeColor3,
        TextStrokeTransparency = arg1.setTransparency(arg1.chatInputBarSettings.TextStrokeTransparency, arg1.transparencyValue),
        TextTransparency = arg1.setTransparency(0, arg1.transparencyValue),
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        LayoutOrder = 3,
        ZIndex = 2
    })
    tbl2.TextLabelButton = createElement2(str2, tbl3, tbl4)

    tbl2.Divider = arg1.isDividerVisible
        and React.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, 1),
            Position = UDim2.new(0, 0, 1, 0),
            AnchorPoint = Vector2.new(0, 1),
            BackgroundTransparency = arg1.setTransparency(Config.ChatInputBarBorderTransparency, arg1.transparencyValue),
            BackgroundColor3 = Config.ChatInputBarBorderColor3,
            BorderSizePixel = 0,
            ZIndex = 2
        })
        or nil
    return createElement(str1, tbl1, tbl2)
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:50:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local TextChatService = game:GetService("TextChatService")
local ExpChatParent = ExpChat.Parent
local React = require(ExpChatParent.React)
local ExpChatShared = require(ExpChatParent.ExpChatShared)
local Foundation = require(ExpChatParent.Foundation)

local useStyle = require(ExpChatParent.UIBlox).Core.Style.useStyle

local List = require(ExpChatParent.llama).List
local Dictionary = require(ExpChatParent.llama).Dictionary

local Config = require(ExpChat.Config)
local AutocompleteEntry = require(script.Parent.AutocompleteEntry)
local AutocompleteEntryV2 = require(script.Parent.AutocompleteEntryV2)
local Constants = require(ExpChat.PresetChat.Constants)
local FFlagExpChatAutocompleteDropdownRedesign = require(ExpChat.Flags.FFlagExpChatAutocompleteDropdownRedesign)
local FFlagExpChatEmojiDropdownShowAnalytics = require(ExpChat.Flags.FFlagExpChatEmojiDropdownShowAnalytics)

local FFlagExpChatEmojiDropdownDismissAnalytics = require(ExpChat.Flags.FFlagExpChatEmojiDropdownDismissAnalytics)
local useEmojiDropdownDismissAnalytics = require(script.Parent.useEmojiDropdownDismissAnalytics)

if not FFlagExpChatAutocompleteDropdownRedesign then
    AutocompleteEntryV2 = AutocompleteEntry
end
return React.memo(function(arg1) -- name: AutoCompleteDropdown
    local ref = React.useRef(nil)
    local var2 = if FFlagExpChatAutocompleteDropdownRedesign then Foundation.Hooks.useTokens() else nil
    local theme = useStyle().Theme

    if FFlagExpChatEmojiDropdownShowAnalytics then
        local activated = arg1.activated

        if activated then
            if #arg1.results > 0 and arg1.autocompleteType == "emojis" then
                activated = arg1.isChatInputBarVisible ~= false
            else
                activated = false
            end
        end

        React.useEffect(function()
            if activated then
                ExpChatShared.Analytics:TelemetryLogEvent(
                    ExpChatShared.Analytics.ExpChatPresetActionConfig,
                    {
                        event_type = Constants.Analytics.EventTypes.Show,
                        component = Constants.Analytics.Components.EmojiDropdown
                    },
                    Constants.Analytics.ExtendedStandardizedFields
                )
            end
        end, { activated })

        if FFlagExpChatEmojiDropdownDismissAnalytics then
            useEmojiDropdownDismissAnalytics(activated, arg1.results, arg1.chosenEmojiForAnalyticsRef)
        end
    end

    local var3 = React.useCallback(function(arg2)
        local var3 = Dictionary.map(arg2, function<T>(arg3: T, layoutOrder)
            return React.createElement(AutocompleteEntryV2, {
                result = arg3,
                query = if FFlagExpChatAutocompleteDropdownRedesign then arg1.query else nil,
                layoutOrder = layoutOrder,
                chatInputBarSettings = arg1.chatInputBarSettings,
                setTransparency = arg1.setTransparency,
                transparencyValue = arg1.transparencyValue,
                isDividerVisible = List.count(arg2) ~= layoutOrder,
                selectedIndex = arg1.selectedIndex,
                autocompleteType = arg1.autocompleteType,
                onAutocompleteDropdownHover = arg1.onAutocompleteDropdownHover,
                onAutocompleteSelected = arg1.onAutocompleteSelected
            }), arg3
        end)

        var3["$layout"] = React.createElement("UIListLayout", {
            Padding = if FFlagExpChatAutocompleteDropdownRedesign then UDim.new(0, var2.Gap.XXSmall) else nil,
            SortOrder = Enum.SortOrder.LayoutOrder
        })

        return var3
    end)

    local function setCanvasPosition(): Vector2
        if not ref.current then
            return Vector2.new(0, 0)
        end

        local current = arg1.autocompleteDropdownRef.current
        local var4 = current and current.AbsoluteSize.Y or Config.AutocompleteFrameDefaultSizeY
        if FFlagExpChatAutocompleteDropdownRedesign then
            var4 = ref.current.AbsoluteSize.Y
        end

        local var5 = arg1.chatInputBarSettings.TextSize + 16
        local num1 = 0
        if current
            and current:FindFirstChild("ScrollBarFrame")
            and current.ScrollBarFrame:FindFirstChild("ScrollViewFrame")
            and current.ScrollBarFrame.ScrollViewFrame:FindFirstChild("ScrollView")
            and current.ScrollBarFrame.ScrollViewFrame.ScrollView:FindFirstChild("OffsetFrame")
        then
            local offsetFrame = current.ScrollBarFrame.ScrollViewFrame.ScrollView.OffsetFrame
            for _, child in ipairs(offsetFrame:GetChildren()) do
                if child.ClassName ~= "Frame" or not (child.LayoutOrder <= arg1.selectedIndex) then
                    continue
                end

                num1 += child.AbsoluteSize.Y
                if child.LayoutOrder == arg1.selectedIndex then
                    var5 = child.AbsoluteSize.Y
                end
            end
        end

        local canvasPositionY = ref.current.CanvasPosition.Y
        local var6 = canvasPositionY + var4
        local y = num1 - var5
        if FFlagExpChatAutocompleteDropdownRedesign then
            local var7 = var2.Gap.XXSmall * math.max(arg1.selectedIndex - 1, 0)
            y += var7
            num1 += var7
        end

        local var7 = if var6 < num1 then num1 - var4 else canvasPositionY

        if not (y < canvasPositionY) then
            y = var7
        end

        return Vector2.new(0, y)
    end

    local chatWindowConfiguration = TextChatService:FindFirstChildOfClass("ChatWindowConfiguration")
    local verticalAlignment, enabled

    if chatWindowConfiguration then
        verticalAlignment = chatWindowConfiguration.VerticalAlignment
        enabled = chatWindowConfiguration.Enabled
    else
        verticalAlignment = nil
        enabled = false
    end

    local bool1 = verticalAlignment == Enum.VerticalAlignment.Top and not enabled
    local var4 = arg1.textBoxRef.current and arg1.textBoxRef.current.AbsoluteSize.Y + 20
    local chatWindow = if arg1.autocompleteDropdownRef.current and arg1.autocompleteDropdownRef.current:FindFirstAncestor("appLayout") then arg1.autocompleteDropdownRef.current:FindFirstAncestor("appLayout"):FindFirstChild("chatWindow") or nil else nil
    local var5, var6

    if FFlagExpChatAutocompleteDropdownRedesign then
        local num1 = math.min(#arg1.results, 3.5)
        local num2 = math.max(math.ceil(num1) - 1, 0)
        var5 = UDim2.new(1, 0, 0, 2 * var2.Padding.Small + num1 * var2.Size.Size_1000 + num2 * var2.Gap.XXSmall)

        local xSmall = var2.Gap.XSmall
        var6 = UDim2.new(0, 0, 0, if bool1 then (var4 or 0) + xSmall else -xSmall)
    else
        var5 = UDim2.new(
            0.95,
            0,
            0,
            #arg1.results > 3 and Config.AutocompleteFrameDefaultSizeY or #arg1.results * Config.AutocompleteEntryDefaultSizeY
        )

        var6 = UDim2.new(0, 0, 0, bool1 and var4 or 0)
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl1 = {
        AnchorPoint = bool1 and Vector2.new(0, 0) or Vector2.new(0, 1),
        BackgroundTransparency = 1,
        Size = var5,
        Position = var6,
        ZIndex = 2,
        Visible = arg1.activated and #arg1.results > 0,
        ref = arg1.autocompleteDropdownRef
    }
    local tbl2 = {
        UISizeConstraint = React.createElement("UISizeConstraint", {
            MaxSize = Vector2.new(
                Config.ChatWindowMaxWidth,
                (not chatWindow or bool1) and math.huge or chatWindow.AbsoluteSize.Y or math.huge
            )
        }),
        ScrollBarFrame = 0
    }

    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl3 = {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = arg1.setTransparency(0, arg1.transparencyValue),
        BackgroundColor3 = arg1.chatInputBarSettings.BackgroundColor3,
        ZIndex = 2
    }
    local tbl4 = {
        Border = React.createElement("UIStroke", {
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            Color = if FFlagExpChatAutocompleteDropdownRedesign then var2.Color.Stroke.Default.Color3 else Config.ChatInputBarBorderColor3,
            Transparency = arg1.setTransparency(
                if FFlagExpChatAutocompleteDropdownRedesign then var2.Color.Stroke.Default.Transparency else Config.ChatInputBarBorderTransparency,
                arg1.transparencyValue
            )
        }),
        Corner = React.createElement(
            "UICorner",
            {
                CornerRadius = if FFlagExpChatAutocompleteDropdownRedesign then UDim.new(0, var2.Radius.Large) else UDim.new(0, 3)
            }
        ),
        ScrollViewFrame = 0
    }

    local createElement3 = React.createElement
    local str3 = "Frame"
    local tbl5 = {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        ZIndex = 2
    }

    local tbl6 = { UIPadding = 0, ScrollView = 0 }
    local element

    if FFlagExpChatAutocompleteDropdownRedesign then
        element = React.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, var2.Padding.Small),
            PaddingRight = UDim.new(0, var2.Padding.Small),
            PaddingTop = UDim.new(0, var2.Padding.Small),
            PaddingBottom = UDim.new(0, var2.Padding.Small)
        })
    else
        element = nil
    end

    tbl6.UIPadding = element

    local createElement4 = React.createElement
    local str4 = "ScrollingFrame"
    local tbl7 = {
        Size = if FFlagExpChatAutocompleteDropdownRedesign then UDim2.fromScale(1, 1) else UDim2.new(1, -4, 1, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = if FFlagExpChatAutocompleteDropdownRedesign then UDim2.new() else UDim2.new(0, 0, 0, #arg1.results * Config.AutocompleteEntryDefaultSizeY),
        CanvasPosition = setCanvasPosition(),
        BackgroundTransparency = 1,
        ScrollBarImageColor3 = theme.UIEmphasis.Color,
        ScrollBarImageTransparency = arg1.setTransparency(0, arg1.transparencyValue),
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        VerticalScrollBarInset = if FFlagExpChatAutocompleteDropdownRedesign then Enum.ScrollBarInset.ScrollBar else Enum.ScrollBarInset.Always,
        ClipsDescendants = not not FFlagExpChatAutocompleteDropdownRedesign,
        Selectable = false,
        ZIndex = 2,
        ref = ref
    }
    local tbl8 = {
        OffsetFrame = React.createElement("Frame", {
            AutomaticSize = if FFlagExpChatAutocompleteDropdownRedesign then Enum.AutomaticSize.Y else nil,
            Size = if FFlagExpChatAutocompleteDropdownRedesign then UDim2.fromScale(1, 0) else UDim2.new(1, 8, 1, 0),
            BackgroundTransparency = 1
        }, var3(arg1.results))
    }
    tbl6.ScrollView = createElement4(str4, tbl7, tbl8)
    tbl4.ScrollViewFrame = createElement3(str3, tbl5, tbl6)
    tbl2.ScrollBarFrame = createElement2(str2, tbl3, tbl4)
    return createElement(str1, tbl1, tbl2)
end)

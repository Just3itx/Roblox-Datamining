-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChat = script:FindFirstAncestor("FriendsChat")
local FriendsChatParent = FriendsChat.Parent

local React = require(FriendsChatParent.React)
local Foundation = require(FriendsChatParent.Foundation)
local getTextBoundsAsync = Foundation.Utility.getTextBoundsAsync
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local Signals = require(FriendsChatParent.Signals)
local SignalsReact = require(FriendsChatParent.SignalsReact)

local getMessageTextSize = require(FriendsChatParent.ChatUIPrimitives).Utils.getMessageTextSize

local useFinishChatWindowMessageRenderIntervals = require(FriendsChatParent.ChatUIPrimitives).Hooks.useFinishChatWindowMessageRenderIntervals

local _useMessageDisplayStore = require(script.Parent.MessageDisplayStore.useMessageDisplayStore)
local FFlagFriendsChatMessageSendPerfTracking = require(FriendsChat.Flags.FFlagFriendsChatMessageSendPerfTracking)
local FFlagFriendsChatLazyMountMessageSkeleton = require(FriendsChat.Flags.FFlagFriendsChatLazyMountMessageSkeleton)

local function fadeTransparency(num1: number, num2: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return num1 + num2 * (1 - num1)
end

local function isSystemDisplay(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not (arg1 == nil) and arg1.displayStyle == "system"
end

local function displayWantsSkeleton(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return not (arg1 == nil) and (arg1.skeletonWidth == "prefix" or arg1.skeletonWidth == "full")
end

return React.memo(function(tbl1) -- name: FriendsChatTextMessage
    local var1 = Foundation.Hooks.useTokens()

    local chatWindowSettings = tbl1.chatWindowSettings

    local var2 = (if chatWindowSettings then chatWindowSettings.FontFace else nil) or var1.Typography.BodySmall.Font
    local var3 = normalizeFontFace(var2)
    local font = Font.new(var3.Family, Enum.FontWeight.SemiBold, var3.Style)

    local textSize = getMessageTextSize(chatWindowSettings, tbl1.isSpatialUIEnabled) or var1.Typography.BodySmall.FontSize
    local num1 = math.max(1, textSize - 2)
    local textColor = if chatWindowSettings and chatWindowSettings.TextColor3 then chatWindowSettings.TextColor3 else var1.Color.Content.Default.Color3
    local color3 = var1.Color.Content.Muted.Color3
    local textStrokeColor3 = if chatWindowSettings then chatWindowSettings.TextStrokeColor3 else nil
    local var5 = if chatWindowSettings then if chatWindowSettings.TextStrokeTransparency then chatWindowSettings.TextStrokeTransparency else 1 else 1

    local var6 = tbl1.textTransparency or React.createBinding(0)

    local getDisplayId = tbl1.getDisplayId
    local getDisplayFromId = tbl1.getDisplayFromId
    local localize = tbl1.localize
    local var7 = React.useMemo(function()
        return { systemTextSize = num1, localize = localize }
    end, { num1, localize })
    local var8 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            return getDisplayFromId(getDisplayId(arg1), arg1, var7)
        end)
    end, { getDisplayId, getDisplayFromId, var7 })

    local display = SignalsReact.useSignalBinding(var8)
    local layoutOrder = SignalsReact.useSignalBinding(tbl1.getLayoutOrder)

    local getMessageIdFromDisplayId = tbl1.getMessageIdFromDisplayId
    local var11 = React.useCallback(function()
        if FFlagFriendsChatMessageSendPerfTracking and getMessageIdFromDisplayId then
            return getMessageIdFromDisplayId(getDisplayId(false))
        end
        return getDisplayId(false)
    end, { getDisplayId, getMessageIdFromDisplayId })
    local var12 = useFinishChatWindowMessageRenderIntervals(var11)
    local ref = React.useRef(nil)
    local var14 = React.useCallback(function(arg1)
        if arg1 and arg1.Text and arg1.Text ~= "" then
            var12()
        end
    end, { var12 })

    React.useEffect(function()
        if not FFlagFriendsChatMessageSendPerfTracking then
            return
        end
        local current = ref.current
        if current ~= nil and current.Text ~= "" then
            var12()
        end
    end, { var12 })

    local var15 = React.useMemo(function(): UDim2
        local xOffset = math.floor(textSize * 3 / 2)
        return UDim2.fromOffset(xOffset, textSize)
    end, { textSize })

    local placeholder, var17 = React.useBinding(var15)

    React.useEffect(function()
        var17(var15)
    end, { var15 })

    React.useEffect(function()
        local bool1 = false
        task.spawn(function()
            local textBoundsAsync = getTextBoundsAsync("          ", var3, textSize)
            if bool1 or textBoundsAsync == nil then
                return
            end
            var17(UDim2.fromOffset(textBoundsAsync.X, textBoundsAsync.Y))
        end)
        return function()
            bool1 = true
        end
    end, { var3, textSize })

    local var18 = display:map(function(arg1)
        if arg1 == nil then
            return ""
        elseif arg1.skeletonWidth == "prefix" then
            return `          {arg1.content}`
        end
        return arg1.content
    end)

    local tbl2 = { font = var3, textSize = textSize, textColor = textColor }

    local tbl3 = { font = font, textSize = num1, textColor = color3 }

    local var19 = display:map(function(arg1): {font: any, textColor: any, textSize: any} | {font: Font, textColor: any, textSize: number}
        return if isSystemDisplay(arg1) then tbl3 else tbl2
    end)

    local fontFace = var19:map(function(tbl4)
        return tbl4.font
    end)

    local var4 = var19:map(function(tbl4)
        return tbl4.textSize
    end)

    local textColor3 = var19:map(function(tbl4)
        return tbl4.textColor
    end)

    local textStrokeTransparency = var6:map(function(arg1): number
        return fadeTransparency(var5, arg1)
    end)

    local var24 = React.joinBindings({ display = display, textTransparency = var6 }):map(function(arg1)
        if arg1.textTransparency >= 0.9 then
            return false
        end

        return (displayWantsSkeleton(arg1.display))
    end)

    local var25 = React.joinBindings({ display = display, placeholder = placeholder }):map(function(arg1)
        local display = arg1.display
        if display ~= nil and display.skeletonWidth == "full" then
            return UDim2.new(1, 0, 0, arg1.placeholder.Y.Offset)
        end
        return arg1.placeholder
    end)

    local var26 = display:map(function(arg1): boolean
        return arg1 ~= nil
    end)

    local var27

    if FFlagFriendsChatLazyMountMessageSkeleton then
        local var28 = React.useMemo(function()
            return Signals.createComputed(function(arg1): boolean
                return (displayWantsSkeleton((var8(arg1))))
            end)
        end, { var8 })
        var27 = SignalsReact.useSignalState(var28)
    else
        var27 = true
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl4 = {
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 0),
        LayoutOrder = layoutOrder,
        Visible = var26,
        ref = tbl1.guiObjectRef
    }
    local tbl5 = {
        body = React.createElement("TextLabel", {
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = UDim2.new(1, 0, 0, 0),
            FontFace = fontFace,
            TextSize = var4,
            TextColor3 = textColor3,
            TextStrokeColor3 = textStrokeColor3,
            TextStrokeTransparency = textStrokeTransparency,
            TextTransparency = var6,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            RichText = true,
            Text = var18,
            ref = ref,
            [React.Change.Text] = var14
        }, {
            stroke = React.createElement("UIStroke", {
                Color = textStrokeColor3 or Color3.fromRGB(0, 0, 0),
                Thickness = var1.Stroke.Thin,
                Transparency = textStrokeTransparency
            })
        }),
        skeleton = if var27 then React.createElement(
            Foundation.Skeleton,
            {
                Size = var25,
                Position = UDim2.fromOffset(0, 0),
                AnchorPoint = Vector2.new(0, 0),
                Visible = var24
            }
        ) else nil
    }
    return createElement(str1, tbl4, tbl5)
end)

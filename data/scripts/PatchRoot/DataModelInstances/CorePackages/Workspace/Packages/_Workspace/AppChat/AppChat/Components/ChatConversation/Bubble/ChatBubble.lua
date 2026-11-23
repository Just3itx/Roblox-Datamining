-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local React = require(AppChatParent.React)
local Object = require(AppChatParent.LuauPolyfill).Object
local Cryo = require(AppChatParent.Cryo)
local ChatBubbleEnum = require(script.Parent.ChatBubbleEnum)

local Foundation = require(AppChatParent.Foundation)
local useCursor = Foundation.Hooks.useCursor

local tbl1 = {
    contentWidth = 0,
    isIncoming = false,
    isRepliedTo = false,
    imageColor = Color3.new(0, 0, 0),
    imageTransparency = 0,
    padding = 0,
    hasTail = false,
    onAbsoluteSizeChanged = function(_) end,
    setContentWidth = function(_: number) end,
    handleEvent = function(_) end,
    containerChildren = {}
}

function ChatBubble(tbl2)
    local selectionImageObject = useCursor(Foundation.Enums.CursorType.RoundedRect)
    local var2 = Cryo.Dictionary.union(tbl1, tbl2)
    local uDim = UDim.new(0, var2.padding or tbl1.padding)

    local xOffset = ChatBubbleEnum.TAIL_WIDTH + (if var2.isRepliedTo then ChatBubbleEnum.REPLIED_TO_MARKER_WIDTH + ChatBubbleEnum.REPLIED_TO_MARKER_GAP else 0)
    local uDim2 = if var2.isIncoming then UDim2.new(0, xOffset, 0, 0) else UDim2.new(1, -xOffset, 0, 0)
    local bubble = ChatBubbleEnum.BUBBLE
    if var2.hasTail then
        if var2.isIncoming then
            bubble = ChatBubbleEnum.RECEIVED_BUBBLE_WITH_TAIL
        else
            bubble = ChatBubbleEnum.SENT_BUBBLE_WITH_TAIL
        end
    end
    local var3 = React.useCallback(function(arg1)
        var2.onAbsoluteSizeChanged(arg1)
    end, { var2.onAbsoluteSizeChanged })

    local var4 = React.useCallback(function(arg1)
        var2.setContentWidth(arg1.AbsoluteContentSize.X + uDim.Offset * 2)
    end, { var2.setContentWidth })

    local createElement = React.createElement

    local tbl3 = {
        AutomaticSize = Enum.AutomaticSize.XY,
        Size = UDim2.new(0, var2.contentWidth, 0, 0),
        AnchorPoint = var2.isIncoming and Vector2.new(0, 0) or Vector2.new(1, 0),
        BackgroundTransparency = 1,
        ImageColor3 = var2.imageColor,
        Image = bubble,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = ChatBubbleEnum.SLIDE_CENTER,
        ImageTransparency = var2.imageTransparency,
        Position = uDim2,
        Selectable = not var2.hasTail,
        SelectionImageObject = selectionImageObject,
        [React.Change.AbsoluteSize] = var3
    }
    local assign = Object.assign
    local var5 = table.clone(var2.containerChildren)
    local tbl4 = {
        ["$margin"] = React.createElement("UIPadding", { PaddingBottom = uDim, PaddingTop = uDim, PaddingRight = uDim, PaddingLeft = uDim }),
        ["$layout"] = React.createElement("UIListLayout", { [React.Change.AbsoluteContentSize] = var4 })
    }
    return createElement("ImageLabel", tbl3, assign(var5, tbl4))
end

return React.memo(ChatBubble)

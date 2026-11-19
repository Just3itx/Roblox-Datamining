-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Cryo = require(CorePackages.Packages.Cryo)
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)
local ChatBubble = require(script.Parent.ChatBubble)
local Types = require(script.Parent.Parent.Types)

local _RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local var1 = Roact.Component:extend("BubbleChatList")

var1.validateProps = t.strictInterface({
    userId = t.string,
    isVisible = t.optional(t.boolean),
    theme = t.optional(t.string),
    onLastBubbleFadeOut = t.optional(t.callback),
    chatSettings = Types.IChatSettings,
    renderFirstInsert = t.optional(t.callback),
    insertSize = t.optional(t.Vector2),
    messageIds = t.array(t.string)
})

var1.defaultProps = { theme = "Light" }

function var1.getDerivedStateFromProps(arg1, arg2)
    local bubbles = {}

    if arg2.bubbles then
        for _, value in ipairs(arg2.bubbles) do
            if not Cryo.List.find(arg1.messageIds, value.messageId) then
                table.insert(bubbles, { messageId = value.messageId, fadingOut = true })
            end
        end
    end

    for _, messageId in ipairs(arg1.messageIds) do
        table.insert(bubbles, { messageId = messageId, fadingOut = false })
    end

    return { bubbles = bubbles }
end

function var1.init(arg1, arg2)
    if (not arg2.messageIds or #arg2.messageIds == 0) and arg2.onLastBubbleFadeOut then
        arg2.onLastBubbleFadeOut()
    end

    function arg1.onBubbleFadeOut(messageId)
        local bubbles = Cryo.List.filter(arg1.state.bubbles, function(arg3): boolean
            return arg3.messageId ~= messageId
        end)
        if #bubbles == 0 and arg1.props.onLastBubbleFadeOut then
            arg1.props.onLastBubbleFadeOut()
            return
        end

        arg1:setState({ bubbles = bubbles })
    end
end

function var1.render(arg1)
    local tbl1 = {}
    local chatSettings = arg1.props.chatSettings

    tbl1.Layout = Roact.createElement("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Bottom,
        Padding = UDim.new(0, chatSettings.BubblesSpacing)
    })

    tbl1.CaretPadding = chatSettings.TailVisible
        and arg1.props.showCarat
        and Roact.createElement("UIPadding", { PaddingBottom = UDim.new(0, 8) })

    for i, value in ipairs(arg1.state.bubbles) do
        local isMostRecent = i == #arg1.state.bubbles
        local renderFirstInsert = if isMostRecent then arg1.props.renderFirstInsert or nil else nil
        local insertSize = arg1.props.insertSize

        local var2 = "Bubble" .. value.messageId
        tbl1[var2] = Roact.createElement(ChatBubble, {
            messageId = value.messageId,
            isMostRecent = isMostRecent,
            theme = arg1.props.theme,
            fadingOut = value.fadingOut,
            onFadeOut = arg1.onBubbleFadeOut,
            chatSettings = chatSettings,
            renderInsert = renderFirstInsert,
            insertSize = insertSize,
            showCarat = arg1.props.showCarat
        })
    end

    return Roact.createElement(
        "Frame",
        {
            Visible = arg1.props.isVisible,
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1
        },
        tbl1
    )
end

return RoactRodux.connect(function(arg1, arg2) -- name: mapStateToProps
    return {
        messageIds = arg1.userMessages[arg2.userId] or {}
    }
end)(var1)

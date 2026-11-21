-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local Signals = require(ChatUIPrimitivesParent.Signals)
local SignalsReact = require(ChatUIPrimitivesParent.SignalsReact)

local _Types = require(script.Parent.Parent.Parent.Types)
local _groupMessages = require(script.Parent.Parent.groupMessages)
local isObservingAuthor = require(script.Parent.Parent.isObservingAuthor)
local ObservingUserContext = require(script.Parent.Parent.ObservingUserContext)
local useMessageRowContents = require(script.Parent.Parent.useMessageRowContents)
local getBubbleCornerRadii = require(script.Parent.getBubbleCornerRadii)
local Sizing = require(script.Parent.Parent.Parent.Sizing)
local _Types2 = require(script.Parent.Types)

local function renderKeyOf(arg1): string -- Luacid: Inlined by compiler; 1 call site recovered
    local author = arg1.message.author
    local var1 = if author == nil then "" else author.userId
    local var2 = if arg1.message.deliveryState == nil then "" else arg1.message.deliveryState
    return `{arg1.groupPosition.isFirst}|{arg1.groupPosition.isLast}|{var1}|{var2}`
end

local function useMessageBubbleViewModel(bool1: boolean)
    local var1 = ObservingUserContext.useObservingUserId()
    local cornerRadius = Sizing.useSizing().bubble.cornerRadius
    local var2 = useMessageRowContents(bool1)
    local var3 = React.useMemo(function()
        return Signals.createComputed(function(arg1): string
            return renderKeyOf((bool1(arg1)))
        end)
    end, { bool1 })
    local var4 = SignalsReact.useSignalState(var3)
    local bool2 = var2.replyLabel ~= nil

    local var5 = React.useMemo(function()
        local var5 = bool1(false)
        local isObservingUser = isObservingAuthor(var5.message.author, var1)
        local bool3 = var5.message.author ~= nil
        local alignment = if isObservingUser then "right" else "left"
        return {
            alignment = alignment,
            groupPosition = var5.groupPosition,
            isObservingUser = isObservingUser,
            showUsername = var5.groupPosition.isFirst and bool3 and not (isObservingUser or bool2),
            showAvatar = not isObservingUser and var5.groupPosition.isLast and bool3,
            cornerRadii = getBubbleCornerRadii(var5.groupPosition, alignment, cornerRadius),
            deliveryState = var5.message.deliveryState
        }
    end, {
        bool1,
        var4,
        var1,
        cornerRadius,
        bool2
    })
    return {
        alignment = var5.alignment,
        groupPosition = var5.groupPosition,
        isObservingUser = var5.isObservingUser,
        showUsername = var5.showUsername,
        showAvatar = var5.showAvatar,
        cornerRadii = var5.cornerRadii,
        getIdentity = var2.getIdentity,
        contents = var2.contents,
        deliveryState = var5.deliveryState,
        replyText = var2.replyText,
        replyLabel = var2.replyLabel
    }
end

return useMessageBubbleViewModel

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T17:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCards = script:FindFirstAncestor("SocialCards")
local SocialCardsParent = SocialCards.Parent

local Foundation = require(SocialCardsParent.Foundation)
local GetFriendsCallingStore = require(SocialCardsParent.FriendsCalling.Stores).GetFriendsCallingStore
local React = require(SocialCardsParent.React)
local var1 = require(SocialCardsParent.Loggers).Logger:new(script.Name)
local SharedFlags = require(SocialCardsParent.SharedFlags)

local Icon = Foundation.Icon
local IconSize = Foundation.Enums.IconSize
local FoundationText = Foundation.Text
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local mapCallCard = require(SocialCards.Components.CallCard.mapCallCard)
local parseCallCard = require(SocialCards.Components.CallCard.parseCallCard)
local RingingIndicator = require(SocialCards.Components.CallCard.RingingIndicator)
local useCallCard = require(SocialCards.Components.CallCard.useCallCard)

local FFlagFriendsCallingServiceLuaMigration = SharedFlags.FFlagFriendsCallingServiceLuaMigration

local FriendsCallingService = game:GetService("FriendsCallingService")

local uDim = UDim.new(0, 20)

local function CallCard(arg1)
    local var2 = useTokens()
    local var3 = React.useMemo(function()
        return parseCallCard.parseMessageCard({
            call_id = arg1.call_id,
            duration_seconds = arg1.duration_seconds,
            enable_join = arg1.enable_join,
            is_initiator = arg1.is_initiator,
            status = arg1.status
        })
    end, {
        arg1.call_id,
        arg1.duration_seconds,
        arg1.enable_join,
        arg1.is_initiator,
        arg1.status
    })

    local var4, var5, var6 = useCallCard(var3)
    local callId = var4.callId
    local conversationId = arg1.conversationId
    local var7 = React.useCallback(function()
        GetFriendsCallingStore(false).expand()
    end, {})
    local var8 = React.useCallback(function()
        if FFlagFriendsCallingServiceLuaMigration then
            pcall(function()
                FriendsCallingService:AnswerCall(callId)
            end)

            return
        end

        game:GetService("CallingService"):AnswerIncomingCall(callId)
    end, { callId })
    local var9 = React.useCallback(function()
        if FFlagFriendsCallingServiceLuaMigration then
            local success, result = pcall(function()
                FriendsCallingService:StartCall({ conversationId = conversationId })
            end)
            if not success then
                var1:debug("FriendsCallingService:StartCall failed: {}", result)
            end
        else
            local CallingService = game:GetService("CallingService")
            task.spawn(function()
                pcall(function()
                    CallingService:CreateCallAsync({}, conversationId)
                end)
            end)
        end
    end, { conversationId })
    local var10 = mapCallCard

    if not var6 or var5 ~= nil then
        var8 = nil
    end

    if var5 ~= nil then
        var9 = nil
    end

    if not var6 then
        var7 = nil
    end

    local var11 = var10(var4, var8, var9, var7)

    local createElement = React.createElement
    local var12 = View
    local tbl1 = {
        Size = UDim2.fromOffset(200, 0),
        cornerRadius = uDim,
        onActivated = var11.onActivated,
        tag = "row align-y-center gap-small auto-y padding-x-medium padding-y-small bg-shift-400",
        testId = arg1.testId
    }
    local tbl2 = {
        Icon = React.createElement(
            Icon,
            {
                LayoutOrder = 1,
                name = var11.icon,
                size = IconSize.Large,
                style = var2.Color.Content.Muted
            }
        ),
        Content = 0
    }
    local createElement2 = React.createElement
    local var13 = View
    local tbl3 = { LayoutOrder = 2, tag = "col fill auto-y" }

    local tbl4 = {
        Title = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = var11.title,
            tag = "size-full-0 auto-y text-title-medium text-no-wrap text-align-x-left text-truncate-end content-emphasis"
        }),
        Status = 0
    }
    local element

    if var11.description == nil then
        element = nil
    else
        element = React.createElement(View, {
            LayoutOrder = 2,
            tag = "row align-y-center gap-xsmall size-full-0 auto-y"
        }, {
            Description = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = var11.description,
                tag = "shrink auto-xy text-body-medium text-no-wrap text-align-x-left text-truncate-end content-default"
            }),
            Ringing = if var11.isRinging then React.createElement(RingingIndicator, { LayoutOrder = 2 }) else nil
        })
    end

    tbl4.Status = element
    tbl2.Content = createElement2(var13, tbl3, tbl4)
    return createElement(var12, tbl1, tbl2)
end

return CallCard

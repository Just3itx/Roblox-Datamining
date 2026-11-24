-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T12:00:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsCallingParent = script:FindFirstAncestor("FriendsCalling").Parent

local Foundation = require(FriendsCallingParent.Foundation)
local React = require(FriendsCallingParent.React)

local CallParticipantCard = require(script.Parent.CallParticipantCard)
local resolveGridLayout = require(script.Parent.resolveGridLayout)

local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local function useContainerSize()
    local var1 = React.useRef(nil)
    local var2, var3 = React.useState(Vector2.zero)

    React.useEffect(function()
        local current = var1.current
        if current == nil then
            return
        end

        local function update() -- Luacid: Inlined by compiler; 1 call site recovered
            var3(current.AbsoluteSize)
        end

        update()
        local connection = current:GetPropertyChangedSignal("AbsoluteSize"):Connect(update)
        return function()
            connection:Disconnect()
        end
    end, {})

    return var1, var2
end

local function CallParticipantGrid(tbl1)
    local medium = useTokens().Gap.Medium
    local ref, var2 = useContainerSize()
    local var3 = resolveGridLayout(var2, #tbl1.participants, medium)

    local tbl2 = {}
    for layoutOrder = 1, var3.rows do
        local tbl3 = ({})
        for i = 1, var3.columns do
            local var4 = (layoutOrder - 1) * var3.columns + i
            local participant = tbl1.participants[var4]
            if participant == nil then
                break
            end

            local str1 = `Participant{var4}`
            local createElement = React.createElement
            local var5 = View
            local tbl4 = {
                LayoutOrder = i,
                Size = UDim2.fromOffset(var3.cardSize.X, var3.cardSize.Y)
            }
            local tbl5 = {
                Card = React.createElement(CallParticipantCard, {
                    userId = participant.userId,
                    name = participant.name,
                    statusText = participant.statusText,
                    isMuted = participant.isMuted,
                    isSpeaking = participant.isSpeaking,
                    isDimmed = participant.isDimmed,
                    showStatusAnimation = participant.showStatusAnimation
                })
            }
            tbl3[str1] = createElement(var5, tbl4, tbl5)
        end

        tbl2[`Row{layoutOrder}`] = React.createElement(View, { LayoutOrder = layoutOrder, tag = "row align-x-center gap-medium size-full-0 auto-y" }, tbl3)
    end

    return React.createElement(
        View,
        {
            ref = ref,
            tag = "col align-x-center align-y-center gap-medium size-full",
            testId = tbl1.testId
        },
        tbl2
    )
end

return CallParticipantGrid

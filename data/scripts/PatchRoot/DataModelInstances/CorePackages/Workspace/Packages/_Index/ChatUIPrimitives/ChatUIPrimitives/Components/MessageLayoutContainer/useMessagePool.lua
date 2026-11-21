-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent

local React = require(ChatUIPrimitivesParent.React)
local Signals = require(ChatUIPrimitivesParent.Signals)
local SignalsExperimental = require(ChatUIPrimitivesParent.SignalsExperimental)

local useStableSignal = require(ChatUIPrimitives.Hooks.useStableSignal)

local function useMessagePool(tbl1)
    local var1 = React.useRef({})
    local var2 = React.useRef({})
    local var3 = React.useRef(0)

    local maxSlots = tbl1.maxSlots or 50

    local var4 = React.useRef(tbl1.createSlotElement)
    var4.current = tbl1.createSlotElement

    local var5, var6 = useStableSignal({})

    local function publishChildrenFromCache()
        local tbl2 = {}
        for _, value in var1.current do
            tbl2[value.stableKey] = value.element
        end
        for _, value in var2.current do
            tbl2[value.stableKey] = value.element
        end
        var6(tbl2)
    end

    local function rebuildElementsFromFactory()
        local current = var4.current
        for _, value in var1.current do
            local tbl2 = {
                getMessageId = value.getMessageId,
                getLayoutOrder = value.getLayoutOrder
            }
            value.element = current(tbl2)
        end

        for _, value in var2.current do
            local tbl2 = {
                getMessageId = value.getMessageId,
                getLayoutOrder = value.getLayoutOrder
            }
            value.element = current(tbl2)
        end

        publishChildrenFromCache()
    end

    local function reconcile(tbl2) -- Luacid: Inlined by compiler; 2 call sites recovered
        SignalsExperimental.batch(function()
            local current = var1.current
            local current2 = var2.current
            local bool1 = false

            local num1 = #tbl2
            local num2 = math.max(1, num1 - maxSlots + 1)

            local tbl3 = {}
            for i = num2, num1 do
                tbl3[tbl2[i]] = true
            end

            for value, value2 in current do
                if not tbl3[value] then
                    value2.setMessageId(nil)
                    current2[#current2 + 1] = value2
                    current[value] = nil
                end
            end

            for i = num2, num1 do
                local var7 = tbl2[i]
                if current[var7] then
                    continue
                end

                local tbl4

                if #current2 > 0 then
                    tbl4 = current2[#current2]
                    current2[#current2] = nil
                    tbl4.setMessageId(var7)
                else
                    local var8 = var3
                    var8.current += 1
                    local stableKey = "slot-" .. var3.current
                    local getMessageId, setMessageId = Signals.createSignal(var7)
                    local getLayoutOrder, setLayoutOrder = Signals.createSignal(0)
                    tbl4 = {
                        stableKey = stableKey,
                        getMessageId = getMessageId,
                        setMessageId = setMessageId,
                        getLayoutOrder = getLayoutOrder,
                        setLayoutOrder = setLayoutOrder,
                        element = var4.current({ getMessageId = getMessageId, getLayoutOrder = getLayoutOrder })
                    }
                    bool1 = true
                end

                current[var7] = tbl4
            end

            local num3 = 0
            for i = num2, num1 do
                local var7 = current[tbl2[i]]
                if var7 == nil then
                    continue
                end

                local layoutOrder = var7.getLayoutOrder(false)
                if layoutOrder <= num3 then
                    num3 += 1
                    var7.setLayoutOrder(num3)
                else
                    num3 = layoutOrder
                end
            end

            if bool1 then
                publishChildrenFromCache()
            end
        end)
    end

    local var7 = React.useRef(false)
    if not var7.current then
        var7.current = true
        reconcile((tbl1.messageIdsSignal()))
    end

    React.useEffect(function()
        return (Signals.createEffect(function(arg1)
            reconcile((tbl1.messageIdsSignal(arg1)))
        end))
    end, { tbl1.messageIdsSignal, var6, maxSlots })

    local var8 = React.useRef(false)

    React.useEffect(function()
        if not var8.current then
            var8.current = true
            return
        end
        rebuildElementsFromFactory()
    end, { tbl1.createSlotElement })

    return var5
end

return useMessagePool

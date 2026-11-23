-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Signals = require(BuildExperienceParent.Signals)
local _ChatCardEmphasisPositionContext = require(script.Parent.ChatCardEmphasisPositionContext)

local function outranks(tbl1, tbl2): boolean
    if tbl1.priority ~= tbl2.priority then
        return tbl1.priority > tbl2.priority
    end
    local position = tbl1.position
    local position2 = tbl2.position

    if position == nil or position2 == nil then
        return tbl1.order > tbl2.order
    end

    if position.messageOrder == position2.messageOrder then
        if position.segmentOrder == position2.segmentOrder then
            return position.childOrder > position2.childOrder
        end

        return position.segmentOrder > position2.segmentOrder
    end

    return position.messageOrder > position2.messageOrder
end

local function createChatCardEmphasisStore()
    local var1, var2 = Signals.createSignal({})

    return {
        register = function(arg1, priority: number, num1: number, position)
            local tbl1 = {
                priority = priority,
                order = num1,
                position = position or { messageOrder = num1, segmentOrder = 0, childOrder = 0 }
            }
            var2(function(arg2)
                local var3 = table.clone(arg2)
                var3[arg1] = tbl1
                return var3
            end)
        end,
        unregister = function(arg1)
            var2(function(arg2)
                if arg2[arg1] == nil then
                    return arg2
                end
                local var3 = table.clone(arg2)
                var3[arg1] = nil
                return var3
            end)
        end,
        getEmphasizedKey = Signals.createComputed(function(arg1)
            local var3 = nil
            local var4 = nil
            for value, value2 in var1(arg1) do
                if var4 == nil or outranks(value2, var4) then
                    var3 = value
                    var4 = value2
                end
            end

            return var3
        end)
    }
end
return createChatCardEmphasisStore

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local AutoScrollPolicy = require(ViewRecycler.Core.Enums.AutoScrollPolicy)
local AutoScrollTarget = require(ViewRecycler.Core.Enums.AutoScrollTarget)
local _Types = require(ViewRecycler.Core.Types)

local module = {}

function module.followedEdge(arg1)
    if arg1 == AutoScrollPolicy.WhenAtStart then
        return AutoScrollTarget.Start
    end

    if arg1 == AutoScrollPolicy.WhenAtEnd then
        return AutoScrollTarget.End
    end

    return nil
end

function module.distanceFromEdge(start, arg1)
    return if start == AutoScrollTarget.Start then arg1.scrollOffset else arg1.distanceFromEnd
end

function module.validate(arg1)
    assert(
        arg1 == nil or module.followedEdge(arg1) ~= nil,
        "Virtualizer: autoScrollOnChange must be AutoScrollPolicy.WhenAtStart or AutoScrollPolicy.WhenAtEnd"
    )
end

function module.resolveTarget(arg1, arg2, num1: number)
    local var1 = module.followedEdge(arg1)
    return not (var1 == nil or not (module.distanceFromEdge(var1, arg2) <= num1)) and var1
end

function module.getTargetOffset(start, num1: number, num2: number): number
    if start == AutoScrollTarget.Start then
        return 0
    end

    return math.max(0, num1 - num2)
end

function module.create()
    local var1 = nil
    local bool1 = false

    local function settle(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
        bool1 = bool1 and arg1 == var1
        var1 = arg1
    end

    return {
        onDataSourceChanged = function(arg1)
            if arg1 ~= false then
                settle(arg1)
                return arg1
            end

            if bool1 then
                return var1
            end

            bool1 = bool1 and var1 == nil
            var1 = nil

            return false
        end,
        settleAt = settle,
        pin = function(arg1)
            var1 = arg1
            bool1 = true
        end,
        getSettleOffset = function(arg1, arg2)
            local var2 = var1
            if var2 == nil then
                return nil
            end
            return module.getTargetOffset(var2, arg1, arg2)
        end,
        onScrollOffsetChanged = function(arg1, arg2, start)
            local var2 = var1
            if var2 ~= nil and module.distanceFromEdge(var2, arg1) <= arg2 then
                return
            end

            if start ~= nil and module.distanceFromEdge(start, arg1) <= arg2 then
                settle(start)
            else
                bool1 = bool1 and var1 == nil
                var1 = nil
            end
        end
    }
end

return module

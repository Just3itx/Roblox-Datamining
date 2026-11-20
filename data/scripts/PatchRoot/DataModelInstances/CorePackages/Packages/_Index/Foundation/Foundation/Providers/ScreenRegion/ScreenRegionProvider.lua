-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local React = require(FoundationParent.React)

local _ScreenRegion = require(script.Parent.ScreenRegion)
local _ScreenRegionKind = require(script.Parent.ScreenRegionKind)
local regionPolicies = require(script.Parent.regionPolicies)
local resolveRegion = require(script.Parent.resolveRegion)

local ScreenRegionContext = React.createContext(nil)

local function createManager(tbl1)
    local tbl2 = ({})
    local num1 = 0

    local function recompute(arg1)
        local var1 = tbl2[arg1]
        local var2 = tbl1[arg1]
        if var1 == nil or var2 == nil then
            return
        end

        local tbl3 = {}
        for _, value in var1 do
            table.insert(tbl3, value)
        end
        local var3 = resolveRegion(tbl3, var2)
        for value in var3.dismissed do
            var1[value].isDismissed = true
        end

        for value, value2 in var1 do
            local state = {
                isVisible = var3.visible[value] == true,
                isDismissed = value2.isDismissed
            }
            if state.isVisible ~= value2.state.isVisible or state.isDismissed ~= value2.state.isDismissed then
                value2.state = state
                value2.onChange(state)
            end
        end
    end

    return {
        register = function(arg1, id: number, kind, onChange: (...any) -> (...any))
            local var1 = tbl2[arg1] or {}
            tbl2[arg1] = var1
            var1[id] = {
                id = id,
                kind = kind,
                isOpen = false,
                isMounted = false,
                isDismissed = false,
                onChange = onChange,
                state = { isVisible = false, isDismissed = false }
            }
        end,
        update = function(arg1, num2: number, tbl3)
            local var1 = tbl2[arg1]
            local var2 = if var1 then var1[num2] else nil

            if var2 == nil then
                return
            end

            if tbl3.isOpen then
                if not var2.isOpen or var2.claimKey ~= tbl3.claimKey then
                    num1 += 1
                    var2.claimedAt = num1
                end
            else
                var2.claimedAt = nil
                var2.isDismissed = false
            end
            var2.isOpen = tbl3.isOpen
            var2.isMounted = tbl3.isMounted
            var2.claimKey = tbl3.claimKey
            var2.priority = tbl3.priority
            recompute(arg1)
        end,
        unregister = function(arg1, num2: number)
            local var1 = tbl2[arg1]
            if var1 and var1[num2] then
                var1[num2] = nil
                recompute(arg1)
            end
        end
    }
end

return {
    ScreenRegionProvider = function(tbl1)
        local value = React.useMemo(function()
            return (createManager(regionPolicies))
        end, {})

        return React.createElement(ScreenRegionContext.Provider, { value = value }, tbl1.children)
    end,
    ScreenRegionContext = ScreenRegionContext,
    createManager = createManager
}

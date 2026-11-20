-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChangeHistoryService = game:GetService("ChangeHistoryService")

local ReactUtils = script:FindFirstAncestor("ReactUtils")

local ReactUtilsParent = ReactUtils.Parent
local React = require(ReactUtilsParent.React)

local LUAU_ANALYZE_ERROR = require(ReactUtils.LUAU_ANALYZE_ERROR)

local function useHistory(arg1, callback: (...any) -> (...any), tbl1)
    local var1 = React.useRef(arg1)
    local var2 = React.useRef({})
    local var3 = React.useRef({})

    React.useEffect(function()
        local connection = ChangeHistoryService.OnUndo:Connect(function(waypoint: string)
            local current = var2.current
            local current2 = var3.current

            assert(current ~= nil, LUAU_ANALYZE_ERROR)
            assert(current2 ~= nil, LUAU_ANALYZE_ERROR)

            if not current[waypoint] or #current[waypoint] == 0 then
                return
            end

            if not current2[waypoint] then
                current2[waypoint] = {}
            end

            local num1 = #current[waypoint]
            local var4 = current[waypoint][num1]

            table.insert(current2[waypoint], var1.current)
            table.remove(current[waypoint], num1)

            var1.current = var4
            callback(var4)

            var2.current = current
            var3.current = current2
        end)

        local connection2 = ChangeHistoryService.OnRedo:Connect(function(waypoint: string)
            local current = var2.current
            local current2 = var3.current

            assert(current ~= nil, LUAU_ANALYZE_ERROR)
            assert(current2 ~= nil, LUAU_ANALYZE_ERROR)

            if not current2[waypoint] or #current2[waypoint] == 0 then
                return
            end

            local num1 = #current2[waypoint]
            local var4 = current2[waypoint][num1]

            table.insert(current[waypoint], var1.current)
            table.remove(current2[waypoint], num1)

            assert(var4 ~= nil, LUAU_ANALYZE_ERROR)

            var1.current = var4
            callback(var4)

            var2.current = current
            var3.current = current2
        end)

        return function()
            connection:Disconnect()
            connection2:Disconnect()
        end
    end, tbl1)

    React.useEffect(function()
        var2.current = {}
        var3.current = {}
    end, tbl1)

    return (React.useCallback(function(name: string, current)
        local current2 = var2.current

        assert(current2 ~= nil, LUAU_ANALYZE_ERROR)

        if not current2[name] then
            current2[name] = {}
        end

        var3.current = {}

        ChangeHistoryService:SetWaypoint(name)

        if typeof(var1.current) == "table" then
            table.insert(current2[name], table.clone(var1.current))
        else
            table.insert(current2[name], var1.current)
        end

        var1.current = current
        var2.current = current2
    end, tbl1))
end

return useHistory

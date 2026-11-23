-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:21:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local React = require(AppChatParent.React)
local RoactUtils = require(AppChatParent.RoactUtils)
local memo = React.memo
local useEffect = React.useEffect
local useRef = React.useRef
local usePrevious = RoactUtils.Hooks.usePrevious

function ExternalNavigationHandler(tbl1)
    local function func1() -- Luacid: Inlined by compiler; 1 call site recovered
        return not (tbl1.requestId == tbl1.completedRequestId) and tbl1.screen
    end

    local var1 = useRef({})

    local function func2()
        local screen = tbl1.screen
        local var2 = tbl1.navigationByScreen[screen]

        if var2 then
            var2(tbl1.params)
        else
            assert(var1.current, "Queue for ExternalNavigationHandler can't be nil")
            local var3 = var1.current[screen] or {}
            table.insert(var3, tbl1.params)
            var1.current[screen] = var3
        end

        tbl1.completeExternalNavigation(tbl1.requestId)
    end

    useEffect(function()
        if func1() then
            func2()
        end
    end, { tbl1.requestId, tbl1.completedRequestId, tbl1.screen })

    local var2 = usePrevious(tbl1.navigationByScreen)
    useEffect(function()
        assert(var1.current, "Queue for ExternalNavigationHandler can't be nil")
        if var2 == nil then
            return
        end

        for k, value in pairs(var1.current) do
            assert(var2, "")
            local var3 = var2[k]
            local var4 = tbl1.navigationByScreen[k]
            if var3 == var4 or not var4 then
                continue
            end

            for _, value2 in ipairs(value) do
                var4(value2)
            end
            var1.current[k] = nil
        end
    end, { tbl1.navigationByScreen })

    return nil
end

return memo(ExternalNavigationHandler)

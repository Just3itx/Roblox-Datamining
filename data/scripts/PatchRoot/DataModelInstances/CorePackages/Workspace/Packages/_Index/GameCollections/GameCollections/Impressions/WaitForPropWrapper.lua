-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameCollectionsParent = script:FindFirstAncestor("GameCollections").Parent
local React = require(GameCollectionsParent.React)
local usePrevious = require(GameCollectionsParent.RoactUtils).Hooks.usePrevious
local ArgCheck = require(GameCollectionsParent.ArgCheck)

local bool1 = game:DefineFastFlag("LuaAppEnableWaitForPropWrapperAssert", false)

local function WaitForPropWrapper(tbl1)
    local waitForProp = tbl1.waitForProp
    local maxUpdatesToDelay = tbl1.maxUpdatesToDelay
    local wrappedComponent = tbl1.wrappedComponent

    local var1 = usePrevious(waitForProp)
    local var2, var3 = React.useState(maxUpdatesToDelay)
    local bool2 = not (var1 == nil or waitForProp ~= nil or maxUpdatesToDelay == nil) and var2 < maxUpdatesToDelay

    React.useEffect(function()
        if not maxUpdatesToDelay then
            return
        end

        if waitForProp ~= nil then
            return
        end

        if bool2 then
            task.delay(0, function()
                var3(maxUpdatesToDelay)
            end)
        elseif var2 and var2 > 0 then
            task.delay(0, function()
                var3(var2 - 1)
            end)
        end
    end, {
        waitForProp,
        maxUpdatesToDelay,
        var2,
        bool2
    })
    local bool3 = true
    if waitForProp == nil and maxUpdatesToDelay ~= nil then
        if bool2 or var2 and var2 > 0 then
            bool3 = false
        elseif bool1 then
            ArgCheck.assert(
                waitForProp,
                `Missing data for prop for this game collection, after waiting {maxUpdatesToDelay} updates`
            )
        end
    end

    return if bool3 then wrappedComponent else nil
end

return WaitForPropWrapper

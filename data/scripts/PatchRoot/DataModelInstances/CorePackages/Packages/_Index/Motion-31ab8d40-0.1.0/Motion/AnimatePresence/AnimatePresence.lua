-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local React = require(scriptParentParentParent.React)
local PresenceChild = require(script.Parent.PresenceChild)
local PresenceState = require(scriptParentParent.Enums.PresenceState)

local function getCompositeKey(str1: string, arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if typeof(arg1) ~= "table" or not (arg1.props and arg1.props.presenceId) then
        return str1
    end

    return string.format("%s:%s", str1, tostring(arg1.props.presenceId))
end

local function AnimatePresence(tbl1)
    local children = tbl1.children
    local childData = if tbl1.childData == nil then nil else tbl1.childData
    local onExitComplete = if tbl1.onExitComplete == nil then nil else tbl1.onExitComplete
    local var1, var2 = React.useState({})
    local var3 = React.useRef({})

    React.useEffect(function()
        local tbl2 = ({})

        if children ~= nil and typeof(children) == "table" then
            for dictionaryKey, component in pairs(children) do
                if typeof(component) ~= "table" or component.type == nil then
                    continue
                end

                local compositeKey = getCompositeKey(dictionaryKey, component)
                tbl2[compositeKey] = {
                    type = PresenceState.Entering,
                    component = component,
                    dictionaryKey = dictionaryKey
                }
            end
        end

        for k, value in pairs(var1) do
            local bool1 = false

            if children ~= nil and typeof(children) == "table" then
                for k2, child in pairs(children) do
                    if typeof(child) == "table" and child.type ~= nil and getCompositeKey(k2, child) == k then
                        bool1 = true
                        break
                    end
                end
            end

            if bool1 or not value.isPresent then
                continue
            end

            local tbl3 = {
                type = PresenceState.Exiting,
                component = value.component,
                dictionaryKey = value.dictionaryKey
            }
            tbl2[k] = tbl3
        end

        if next(tbl2) == nil then
            return
        end

        var2(function(arg1)
            local var4 = table.clone(arg1)

            for k, value in pairs(tbl2) do
                if value.type == PresenceState.Entering then
                    local tbl3 = {
                        isPresent = true,
                        component = value.component,
                        safeToRemove = false,
                        dictionaryKey = value.dictionaryKey
                    }
                    var4[k] = tbl3
                elseif value.type == PresenceState.Exiting and var4[k] and var4[k].isPresent then
                    local tbl3 = {
                        isPresent = false,
                        component = value.component,
                        safeToRemove = false,
                        dictionaryKey = value.dictionaryKey
                    }
                    var4[k] = tbl3

                    var3.current[k] = true
                end
            end

            return var4
        end)
    end, { children })

    local var4 = React.useCallback(function(arg1)
        if not var3.current[arg1] then
            return
        end

        var3.current[arg1] = nil

        var2(function(arg2)
            local var4 = table.clone(arg2)
            if var4[arg1] then
                var4[arg1] = {
                    isPresent = false,
                    component = var4[arg1].component,
                    safeToRemove = true,
                    dictionaryKey = var4[arg1].dictionaryKey
                }
            end
            return var4
        end)
    end, {})

    React.useEffect(function()
        local tbl2 = ({})
        local bool1 = false

        for k, value in pairs(var1) do
            if value.safeToRemove then
                tbl2[k] = true
                bool1 = true
            end
        end

        if not bool1 then
            return
        end

        var2(function(arg1)
            local result = ({})
            for k, value in pairs(arg1) do
                if not tbl2[k] then
                    result[k] = value
                elseif onExitComplete then
                    onExitComplete(k)
                end
            end

            return result
        end)
    end, { var1 })

    local tbl2 = {}
    for k, value in pairs(var1) do
        if value.safeToRemove then
            continue
        end

        local createElement = React.createElement
        local var5 = PresenceChild
        local tbl3 = {
            key = k,
            presenceId = k,
            isPresent = value.isPresent,
            onExitComplete = 0,
            childData = 0,
            children = 0
        }

        function tbl3.onExitComplete()
            var4(k)
        end
        tbl3.childData = childData
        tbl3.children = value.component
        table.insert(tbl2, createElement(var5, tbl3, value.component))
    end

    return React.createElement(React.Fragment, {}, tbl2)
end

return AnimatePresence

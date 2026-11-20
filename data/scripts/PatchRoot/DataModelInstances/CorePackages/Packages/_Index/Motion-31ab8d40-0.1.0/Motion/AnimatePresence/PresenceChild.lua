-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local React = require(scriptParentParentParent.React)
local useIdFallback = require(script.Parent.utils).useIdFallback

local PresenceContext = require(script.Parent.PresenceContext)

local function newChildrenMap() -- Luacid: Inlined by compiler; 1 call site recovered
    return {}
end

local function PresenceChild(tbl1)
    if not tbl1.children or typeof(tbl1.children) == "string" then
        error("PresenceChild: children must be a React.Element")
    end

    if not tbl1.children.type then
        error("PresenceChild: children must be a React.Element")
    end

    if tbl1.onExitComplete and typeof(tbl1.onExitComplete) ~= "function" and not tbl1.onExitComplete._isMockFunction then
        error("PresenceChild: onExitComplete must be a function")
    end

    local children = tbl1.children
    local isPresent = tbl1.isPresent
    local onExitComplete = tbl1.onExitComplete
    local passThroughData = tbl1.passThroughData
    local presenceId = tbl1.presenceId
    local tbl2 = newChildrenMap()
    local current = React.useRef(tbl2).current

    local value = {
        id = presenceId or useIdFallback(),
        isPresent = isPresent ~= false,
        passThroughData = passThroughData,
        onExitComplete = function(str1: string) -- name: handleExitComplete
            current[str1] = true

            local bool1 = true
            for _, value in pairs(current) do
                if not value then
                    bool1 = false
                    break
                end
            end

            if bool1 and onExitComplete then
                onExitComplete()
            end
        end
    }
    if isPresent ~= nil then
        for k, _ in pairs(current) do
            current[k] = false
        end
    end

    return React.createElement(PresenceContext.Provider, { value = value }, children)
end

return PresenceChild

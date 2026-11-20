-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Motion = script:FindFirstAncestor("Motion")
local MotionParent = Motion.Parent
local React = require(MotionParent.React)
local PresenceContext = require(Motion.AnimatePresence.PresenceContext)
local useIdFallback = require(Motion.AnimatePresence.utils).useIdFallback

local function PresenceProvider(tbl1)
    if tbl1 == nil then
        error("PresenceProvider: props cannot be nil")
    end

    local children = tbl1.children
    local isPresent = tbl1.isPresent
    if isPresent == nil then
        isPresent = true
    end

    local passThroughData = tbl1.passThroughData

    local var1 = nil
    local success, result = pcall(function()
        var1 = useIdFallback()
    end)

    if not success then
        warn("PresenceProvider: Error generating ID:", result)
        var1 = "presence-" .. useIdFallback()
    end

    local var2 = nil
    local success2, result2 = pcall(function()
        var2 = React.useRef({})
    end)

    if not success2 then
        warn("PresenceProvider: Error creating childrenPresence ref:", result2)
        var2 = {
            current = {}
        }
    end

    local value = {
        id = var1,
        isPresent = isPresent,
        register = function(arg1)
            var2.current[arg1] = false

            return function()
                var2.current[arg1] = nil
            end
        end,
        onExitComplete = function(arg1)
            if var2.current then
                var2.current[arg1] = true
            end

            local bool1 = true
            for _, value in pairs(var2.current) do
                if not value then
                    bool1 = false
                    break
                end
            end

            if bool1 and tbl1.onExitComplete then
                tbl1.onExitComplete()
            end
        end,
        passThroughData = passThroughData
    }

    local element = nil
    local success3, result3 = pcall(function()
        element = React.createElement(PresenceContext.Provider, { value = value }, children)
    end)

    if not success3 then
        warn("PresenceProvider: Error creating PresenceContext.Provider:", result3)
    end

    return element or React.createElement(React.Fragment, {}, children)
end

return PresenceProvider

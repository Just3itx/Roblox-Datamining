-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:50:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCardParent = script:FindFirstAncestor("GameJoinCard").Parent

local Foundation = require(GameJoinCardParent.Foundation)
local _DataHydration = require(GameJoinCardParent.DataHydration)
local ButtonVariant = Foundation.Enums.ButtonVariant

local _Types = require(script.Parent.Types)
local actionFactories = require(script.Parent.actionFactories)

local function resolveJoinCardActions(arg1, arg2)
    local result = {}
    if arg1 == nil or arg1.actions == nil then
        return result
    end

    local bool1 = false
    for _, action in arg1.actions do
        local var1 = actionFactories[action.type]
        if var1 == nil then
            continue
        end

        local var2 = var1(arg2)
        if var2 == nil then
            continue
        end

        if var2.render == nil then
            if not bool1 then
                var2.variant = var2.variant or ButtonVariant.Emphasis
                bool1 = true
            elseif var2.variant == ButtonVariant.Utility then
                bool1 = true
            else
                var2.variant = ButtonVariant.Standard
                bool1 = true
            end
        end

        table.insert(result, var2)
    end

    return result
end

return resolveJoinCardActions

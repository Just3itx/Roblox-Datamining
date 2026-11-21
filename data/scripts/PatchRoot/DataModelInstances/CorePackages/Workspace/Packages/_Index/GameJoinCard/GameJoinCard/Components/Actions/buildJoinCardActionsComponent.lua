-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCardParent = script:FindFirstAncestor("GameJoinCard").Parent

local _React = require(GameJoinCardParent.React)
local UserCtaAction = require(GameJoinCardParent.UserCtaCommon).Enums.UserCtaAction

local _Types = require(script.Parent.Types)

local function buildJoinCardActionsComponent(tbl1, tbl2, callback: (...any) -> (...any), func1: (...any) -> (...any))
    local tbl3 = ({})
    local var1 = nil

    for value, value2 in tbl1 do
        if var1 == nil then
            if value2.id == UserCtaAction.JoinExperience then
                var1 = {
                    title = tbl2.playTogether
                }
            elseif value2.id == UserCtaAction.PlayExperience then
                var1 = {
                    title = tbl2.playTogetherSoon,
                    subtitle = tbl2.differentServer
                }
            end
        end

        local var2

        if value2.keepOpenOnActivate then
            var2 = value2
        else
            var2 = table.clone(value2)
            function var2.onActivated(...)
                value2.onActivated(...)
                callback()
            end
        end

        local str1 = `Action_{value}`
        tbl3[str1] = if var2.render ~= nil then var2.render(var2, value) else func1(var2, value)
    end

    return tbl3, var1
end

return buildJoinCardActionsComponent

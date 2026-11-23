-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:11:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserList = script:FindFirstAncestor("UserList")
local UserListParent = UserList.Parent

local Foundation = require(UserListParent.Foundation)
local Enums = require(UserList.Common.Enums)
local _Types = require(UserList.Common.Types)

local ButtonVariant = Foundation.Enums.ButtonVariant
local ButtonTypes = Enums.ButtonTypes
local tbl1 = {
    [Enums.ClientCtaActions.ViewProfile] = {
        buttonType = ButtonTypes.View,
        handlerKey = ButtonTypes.View,
        variant = ButtonVariant.Standard
    }
}

local function mapClientActionsToRowCta(arg1, str1: string, bool1: boolean, arg2, num1: number?)
    local clientActions = if arg2 then arg2.clientActions else nil

    if not clientActions or bool1 then
        return nil
    end

    for _, clientAction in clientActions do
        local var1 = tbl1[clientAction]
        local var2 = if var1 then arg1[var1.handlerKey] else nil

        if not (var1 and var2) then
            continue
        end

        return {
            primaryCta = {
                type = var1.buttonType,
                onActivated = function()
                    var2(str1, num1)
                end,
                variant = var1.variant,
                minWidth = if arg2 then arg2.primaryCtaMinWidth else nil,
                maxWidth = if arg2 then arg2.primaryCtaMaxWidth else nil
            },
            secondaryCta = nil
        }
    end

    return nil
end

return mapClientActionsToRowCta

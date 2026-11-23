-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserList = script:FindFirstAncestor("UserList")
local UserListParent = UserList.Parent

local _React = require(UserListParent.React)
local _DataHydration = require(UserListParent.DataHydration)
local _Types = require(UserList.Common.Types)

local FFlagUserListSurfacePresenceWins = require(UserListParent.SharedFlags).FFlagUserListSurfacePresenceWins

local function composeCtaRow(tbl1, arg1, arg2, arg3)
    local bool1 = not (arg1 == nil or arg1.showLoadingPlaceholder == false) and arg1.primaryCtaMinWidth ~= nil
    local ctaLoading = arg3.isLoading and bool1 and arg1 and {
        minWidth = arg1.primaryCtaMinWidth,
        maxWidth = arg1.primaryCtaMaxWidth
    } or nil
    local userPresenceType = if arg2 then arg2.userPresenceType else nil
    local renderRow = tbl1.renderRow
    if not renderRow then
        return tbl1.createRow(
            {
                presence = userPresenceType,
                primaryCta = arg3.primaryCta,
                secondaryCta = arg3.secondaryCta,
                ctaLoading = ctaLoading
            }
        )
    end

    local createRow = tbl1.createRow
    return renderRow(function(arg4)
        local var2 = table.clone(arg4)
        var2.presence = userPresenceType
        if FFlagUserListSurfacePresenceWins and arg4.presence ~= nil then
            var2.presence = arg4.presence
        end
        var2.primaryCta = arg3.primaryCta
        var2.secondaryCta = arg3.secondaryCta
        var2.ctaLoading = ctaLoading
        return createRow(var2)
    end, tbl1.entity, tbl1.index or 0)
end

return composeCtaRow

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserList = script:FindFirstAncestor("UserList")
local UserListParent = UserList.Parent

local React = require(UserListParent.React)
local _Types = require(UserList.Common.Types)
local _Enums = require(UserList.Common.Enums)
local BaseRow = require(script.Parent.BaseRow)
local useContactsData = require(UserList.Hooks.useContactsData)

local FFlagUserListSurfaceExtensions = require(UserListParent.SharedFlags).FFlagUserListSurfaceExtensions

return React.memo(function(tbl1) -- name: ContactRow
    local var1 = useContactsData(tbl1.entityId)
    if var1 == nil then
        return nil
    end

    local isTitleLoading = if tbl1.loadingState and tbl1.loadingState.title ~= nil then tbl1.loadingState.title else var1.isLoading
    local contextualInfo = tbl1.loadingState and tbl1.loadingState.contextualInfo

    return React.createElement(BaseRow, {
        avatarThumbnailUrl = var1.avatarThumbnailUrl,
        title = var1.name,
        layoutMode = tbl1.layoutMode,
        onActivated = tbl1.onActivated,
        isTitleLoading = isTitleLoading,
        isContextualInfoLoading = contextualInfo,
        contextualInfo = tbl1.contextualInfo,
        primaryCta = tbl1.primaryCta,
        secondaryCta = tbl1.secondaryCta,
        trailingContent = tbl1.trailingContent,
        layoutOrder = tbl1.layoutOrder,
        disableRowActivation = if FFlagUserListSurfaceExtensions and tbl1.configs then tbl1.configs.disableRowActivation else nil
    })
end)

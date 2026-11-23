-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserList = script:FindFirstAncestor("UserList")
local UserListParent = UserList.Parent

local React = require(UserListParent.React)
local ContactsContext = require(UserList.Context.ContactsContext)
local _Types = require(UserList.Common.Types)

local function useContactsData(str1: string)
    local contact = React.useContext(ContactsContext).contacts[str1]

    return React.useMemo(function()
        if contact == nil then
            return nil
        end

        return {
            isLoading = contact.isLoading or false,
            name = contact.name or "",
            avatarThumbnailUrl = contact.avatarThumbnailUrl or ""
        }
    end, { str1, contact })
end

return useContactsData

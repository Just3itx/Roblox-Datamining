-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RecipientSource = { ChatInbox = "chatInbox", OneToOneFriends = "oneToOneFriends" }

local tbl2 = ({})
for _, value in RecipientSource do
    tbl2[value] = true
end

return {
    RecipientSource = RecipientSource,
    DefaultRecipientSource = RecipientSource.ChatInbox,
    isValidRecipientSource = function(str1: string): boolean
        return tbl2[str1] == true
    end
}

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Cryo = require(AppChatParent.Cryo)

return {
    init = function()
        local function generate(id)
            return {
                id = id,
                title = string.format("default dog chat no. %d", id),
                thumbnails = { "rbxassetid://2610133241" },
                presenceImage = "",
                messages = {
                    keys = { "messageId" },
                    values = {
                        messageId = { content = "a message placeholder 🎷🐛" }
                    }
                },
                shortRelativeTime = "now+" .. id,
                alias = "(alias)"
            }
        end

        local getItemList = {}
        for i = 0, 200 do
            table.insert(getItemList, (generate(i)))
        end

        return {
            getItemList = function()
                return getItemList
            end,
            loadNext = function(arg1)
                return Cryo.List.join(arg1, { (generate(arg1[#arg1].id + 1)) })
            end,
            loadPrevious = function(arg1)
                return Cryo.List.join({ (generate(arg1[1].id - 1)) }, arg1)
            end
        }
    end
}

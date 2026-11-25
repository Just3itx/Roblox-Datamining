-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local Foundation = require(SduiSharedContentParent.Foundation)
local _SduiCompat = require(SduiSharedContentParent.SduiCompat)

local function normalizeAvatars(avatars)
    if typeof(avatars) ~= "table" then
        return nil
    end
    local result = {}
    for _, avatar in avatars do
        if typeof(avatar) == "table" then
            local userId = tonumber(avatar.userId)
            if userId then
                table.insert(result, { userId = userId, userPresence = avatar.userPresence })
            end
        else
            local userId = tonumber(avatar)
            if userId then
                table.insert(result, { userId = userId })
            end
        end
    end

    return result
end

return React.memo(function(tbl1) -- name: SduiAvatarGroup
    local avatars = normalizeAvatars(tbl1.avatars)
    if not avatars then
        return nil
    end

    return React.createElement(Foundation.AvatarGroup, {
        LayoutOrder = tbl1.layoutOrder,
        Visible = tbl1.visible,
        ZIndex = tbl1.zIndex,
        avatars = avatars,
        backplateStyle = tbl1.backplateStyle,
        max = tbl1.max,
        size = tbl1.size,
        testId = tbl1.testId,
        type = tbl1.type
    })
end)

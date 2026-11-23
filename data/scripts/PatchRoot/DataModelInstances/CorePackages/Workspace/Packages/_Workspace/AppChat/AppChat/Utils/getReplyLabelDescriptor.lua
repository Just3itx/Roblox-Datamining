-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getReplyLabelDescriptor(tbl1)
    local senderIsLocalUser = tbl1.senderIsLocalUser
    local senderRepliedToSelf = tbl1.senderRepliedToSelf
    local senderRepliedToLocalUser = tbl1.senderRepliedToLocalUser

    if senderIsLocalUser and senderRepliedToSelf then
        return "Feature.Chat.Label.YouRepliedToYou"
    end

    if not tbl1.isGroup then
        if senderIsLocalUser and not senderRepliedToSelf then
            return "Feature.Chat.Label.OneToOne.YouRepliedToThem"
        end
        if not senderIsLocalUser and senderRepliedToLocalUser then
            return "Feature.Chat.Label.OneToOne.ThemRepliedToYou"
        end
        if not senderIsLocalUser and senderRepliedToSelf then
            return "Feature.Chat.Label.OneToOne.ThemRepliedToThem"
        end
    else
        if senderIsLocalUser and not senderRepliedToSelf then
            return {
                "Feature.Chat.Label.Group.YouRepliedToThem",
                DISPLAY_NAME = tbl1.repliedToName
            }
        end

        if not senderIsLocalUser and senderRepliedToLocalUser then
            return {
                "Feature.Chat.Label.Group.ThemRepliedToYou",
                DISPLAY_NAME = tbl1.senderName
            }
        end

        if not senderIsLocalUser and senderRepliedToSelf then
            return {
                "Feature.Chat.Label.Group.ThemRepliedToThem",
                DISPLAY_NAME = tbl1.senderName
            }
        end

        if not (senderIsLocalUser or senderRepliedToLocalUser) then
            return {
                "Feature.Chat.Label.Group.ThemRepliedToOther",
                DISPLAY_NAME_1 = tbl1.senderName,
                DISPLAY_NAME_2 = tbl1.repliedToName
            }
        end
    end

    return "Feature.Chat.Label.UnknownUser"
end

return getReplyLabelDescriptor

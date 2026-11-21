-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:49:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    AppPage = "GroupProfile",
    Identifiers = { Announcement = "groupAnnouncement", ForumsDiscovery = "groupForumsDiscovery" },
    getConfigKey = function(str1: string): string
        return `GroupPeek-{str1}`
    end,
    CUSTOM_FORM_VERTICAL = "fe02680f247961a1369a66f681f990ec1e4a8708a2e84871019a93a7287ae7dd",
    CONTENT_REACTION_VERTICAL = "group_announcement"
}

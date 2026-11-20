-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParentParent = script.Parent.Parent.Parent
return require(scriptParentParentParent.dependencies).enumerate(script.Name, {
    NotFriends = "nonfriend",
    Friends = "friend",
    RequestSent = "requestSent",
    RequestReceived = "requestReceived",
    Ineligible = "ineligible",
    Recommendation = "recommendation"
})

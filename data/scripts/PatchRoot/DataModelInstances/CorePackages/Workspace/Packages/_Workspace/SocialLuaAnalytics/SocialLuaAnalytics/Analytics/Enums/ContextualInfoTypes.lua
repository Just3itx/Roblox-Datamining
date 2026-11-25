-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParentParent = script.Parent.Parent.Parent
return require(scriptParentParentParent.dependencies).enumerate(script.Name, {
    IsMyself = "isMyself",
    PreviousUsername = "previousUsername",
    Friend = "friend",
    Following = "following",
    MutualFriends = "mutualFriends",
    Frequents = "frequents"
})

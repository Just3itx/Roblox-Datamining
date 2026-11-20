-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:31:34Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParent = script.Parent

local scriptParentParent = scriptParent.Parent
return {
    name = "InlineLayout",
    exclude = { "_Index" },
    storyRoots = { scriptParent },
    mapStory = require(scriptParentParent.MarkdownCore).StoryMiddleware,
    roact = require(scriptParentParent.Dev.Roact)
}

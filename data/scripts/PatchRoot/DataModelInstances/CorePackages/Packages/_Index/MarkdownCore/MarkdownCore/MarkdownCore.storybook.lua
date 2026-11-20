-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParent = script.Parent
return {
    name = "MarkdownCore",
    exclude = { "_Index" },
    storyRoots = { scriptParent },
    mapStory = require(scriptParent.StoryMiddleware),
    roact = require(scriptParent.Parent.Dev.Roact)
}

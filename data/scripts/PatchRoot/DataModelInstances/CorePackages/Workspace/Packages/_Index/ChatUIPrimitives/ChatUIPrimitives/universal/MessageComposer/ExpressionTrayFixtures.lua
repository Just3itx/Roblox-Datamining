-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local _Types = require(ChatUIPrimitives.UniversalMessage.Types)

local tbl1 = {
    quickWordsGroup = {
        categoryGroupId = "quick-words",
        name = "Quick Words",
        categories = {
            {
                categoryId = "general",
                name = "General",
                items = {
                    {
                        content = { kind = "preset", presetId = "good-game", text = "Good game" }
                    },
                    {
                        content = { kind = "preset", presetId = "good-luck", text = "Good luck" }
                    },
                    {
                        content = { kind = "preset", presetId = "play-again", text = "Play again" }
                    }
                }
            },
            {
                categoryId = "play-together",
                name = "Play together",
                items = {
                    {
                        content = {
                            kind = "preset",
                            presetId = "want-to-play",
                            text = "Want to play?"
                        }
                    },
                    {
                        content = { kind = "preset", presetId = "join-me", text = "Join me" }
                    }
                }
            }
        }
    },
    emojisGroup = {
        categoryGroupId = "emojis",
        name = "Emojis",
        categories = {{
            categoryId = "top-picks",
            name = "Top picks",
            items = {
                {
                    content = {
                        kind = "emoji",
                        emojiId = "grinning-face",
                        unicode = "😀",
                        name = "grinning-face"
                    }
                },
                {
                    content = {
                        kind = "emoji",
                        emojiId = "waving-hand",
                        unicode = "👋",
                        name = "waving-hand"
                    }
                },
                {
                    content = {
                        kind = "emoji",
                        emojiId = "thumbs-up",
                        unicode = "👍",
                        name = "thumbs-up"
                    }
                },
                {
                    content = {
                        kind = "emoji",
                        emojiId = "party-popper",
                        unicode = "🎉",
                        name = "party-popper"
                    }
                }
            }
        }}
    }
}

tbl1.enabledCatalog = {
    status = "enabled",
    categoryGroups = { tbl1.quickWordsGroup, tbl1.emojisGroup }
}

tbl1.disabledCatalog = {
    status = "disabled",
    categoryGroups = {}
}

tbl1.quickWordsOnlyCatalog = {
    status = "enabled",
    categoryGroups = { tbl1.quickWordsGroup }
}

tbl1.emojisOnlyCatalog = {
    status = "enabled",
    categoryGroups = { tbl1.emojisGroup }
}

return tbl1

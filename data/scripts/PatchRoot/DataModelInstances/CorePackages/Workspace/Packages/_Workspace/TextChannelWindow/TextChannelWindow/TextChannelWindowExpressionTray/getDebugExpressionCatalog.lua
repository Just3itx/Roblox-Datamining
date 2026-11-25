-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChannelWindowParent = script:FindFirstAncestor("TextChannelWindow").Parent
local _ExpressionCatalogResource = require(TextChannelWindowParent.ChatUIPrimitives.ExpressionCatalogResource)

local tbl1 = {
    status = "enabled",
    version = "studio-debug",
    categoryGroups = {{
        categoryGroupId = "quick-words",
        name = "Quick Words",
        categories = {
            {
                categoryId = "general",
                name = "General",
                items = {
                    {
                        content = {
                            kind = "preset",
                            presetId = "studio-follow-me",
                            text = "Follow me"
                        }
                    },
                    {
                        content = {
                            kind = "preset",
                            presetId = "studio-good-game",
                            text = "Good game!"
                        }
                    },
                    {
                        content = {
                            kind = "preset",
                            presetId = "studio-this-way",
                            text = "This way"
                        }
                    }
                }
            },
            {
                categoryId = "reactions",
                name = "Reactions",
                items = {
                    {
                        content = {
                            kind = "preset",
                            presetId = "studio-awesome",
                            text = "Awesome!"
                        }
                    },
                    {
                        content = { kind = "preset", presetId = "studio-oops", text = "Oops!" }
                    }
                }
            }
        }
    }}
}

local function getDebugExpressionCatalog()
    return tbl1
end

return getDebugExpressionCatalog

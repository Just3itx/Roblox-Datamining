-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:10:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InlineRichText = script:FindFirstAncestor("InlineRichText")
local InlineRichTextParent = InlineRichText.Parent
local UIBlox = require(InlineRichTextParent.UIBlox)
local RobloxAppUIBloxConfig = require(InlineRichTextParent.Dev.RobloxAppUIBloxConfig)

UIBlox.init(RobloxAppUIBloxConfig)

local Roact = require(InlineRichTextParent.Dev.Roact)
local Cryo = require(InlineRichTextParent.Cryo)

local MockProviders = require(InlineRichText.MockProviders)

local tbl1 = {
    Default = { themeName = "Light", fontName = "Gotham" },
    Light = { themeName = "Light", fontName = "Gotham" },
    Dark = { themeName = "Dark", fontName = "Gotham" }
}

return {
    roact = Roact,
    mapStory = function(arg1)
        return function(arg2)
            local var1 = not (arg2 and arg2.definition) and {} or arg2.definition.props or {}
            local var2 = arg2 and tbl1[arg2.theme] or tbl1.Default

            return Roact.createElement(
                MockProviders,
                {
                    themeName = var2.themeName
                },
                {
                    story = Roact.createElement(arg1, Cryo.Dictionary.union(var1, arg2))
                }
            )
        end
    end
}

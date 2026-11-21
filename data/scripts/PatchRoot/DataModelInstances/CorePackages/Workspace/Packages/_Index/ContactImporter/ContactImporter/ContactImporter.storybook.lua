-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local UIBlox = require(scriptParentParent.UIBlox)

UIBlox.init(require(scriptParentParent.Dev.RobloxAppUIBloxConfig))

local dependencies = require(scriptParent.dependencies)
local Roact = dependencies.Roact
local llama = dependencies.llama

local mockLocale = require(scriptParentParent.Dev.SocialTestHelpers).StoryHelpers.mockLocale
local AppStyleProvider = UIBlox.App.Style.AppStyleProvider

Roact.setGlobalConfig({ propValidation = true, elementTracing = true })

local tbl1 = {
    Default = { themeName = "Light", fontName = "Gotham" },
    Light = { themeName = "Light", fontName = "Gotham" },
    Dark = { themeName = "Dark", fontName = "Gotham" }
}

local tbl2 = { language = "en-us" }

return {
    name = "ContactImporter",
    storyRoot = scriptParent,
    roact = Roact,
    mapDefinition = function(arg1)
        local controls = llama.Dictionary.join(tbl2, arg1.controls or {})
        return llama.Dictionary.join(arg1, { controls = controls })
    end,
    mapStory = function(arg1)
        return function(arg2)
            return Roact.createElement(
                AppStyleProvider,
                {
                    style = arg2 and tbl1[arg2.theme] or tbl1.Default
                },
                {
                    Child = mockLocale(arg1, arg2)
                }
            )
        end
    end
}

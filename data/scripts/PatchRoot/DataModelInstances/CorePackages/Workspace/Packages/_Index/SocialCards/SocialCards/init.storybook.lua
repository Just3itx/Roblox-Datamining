-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T17:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCards = script:FindFirstAncestor("SocialCards")

local SocialCardsParent = SocialCards.Parent

local Foundation = require(SocialCardsParent.Foundation)
local React = require(SocialCardsParent.React)
local ReactRoblox = require(SocialCardsParent.Dev.ReactRoblox)
local AppStyleProvider = require(SocialCardsParent.Dev.UIBlox).App.Style.AppStyleProvider

local tbl1 = {
    Default = Foundation.Enums.ColorMode.Dark,
    Light = Foundation.Enums.ColorMode.Light,
    Dark = Foundation.Enums.ColorMode.Dark
}

local tbl2 = { Default = "Desktop", Desktop = "Desktop", Console = "Console" }

return {
    name = SocialCards.Name,
    roact = React,
    reactRoblox = ReactRoblox,
    storyRoot = SocialCards,
    mapStory = function(arg1)
        return function(arg2)
            local colorMode = arg2 and tbl1[arg2.theme] or tbl1.Default
            return React.createElement(
                Foundation.FoundationProvider,
                {
                    colorMode = colorMode,
                    device = arg2 and tbl2[arg2.platform] or "Desktop"
                },
                {
                    AppStyleProvider = React.createElement(
                        AppStyleProvider,
                        {
                            style = {
                                themeName = colorMode.themeName,
                                fontName = "Gotham"
                            }
                        },
                        {
                            Child = React.createElement(arg1, arg2)
                        }
                    )
                }
            )
        end
    end
}

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")

local SquadsParent = Squads.Parent

local React = require(SquadsParent.React)
local UIBlox = require(SquadsParent.UIBlox)

UIBlox.init(require(SquadsParent.Dev.RobloxAppUIBloxConfig))

local mockLocale = require(SquadsParent.Dev.SocialTestHelpers).StoryHelpers.mockLocale

local dependencies = require(Squads.dependencies)
local Cryo = dependencies.Cryo
local Foundation = dependencies.Foundation
local Roact = dependencies.Roact

local AppStyleProvider = UIBlox.App.Style.AppStyleProvider

Roact.setGlobalConfig({ propValidation = true, elementTracing = true })

local tbl1 = {
    Default = { themeName = "Light", fontName = "Gotham" },
    Light = { themeName = "Light", fontName = "Gotham" },
    Dark = { themeName = "Dark", fontName = "Gotham" }
}

local tbl2 = { language = "en-us" }

local function useCreateOverlay(tbl3)
    local var1 = React.useRef(Instance.new("Frame"))

    if var1.current.Parent ~= tbl3.focus then
        var1.current.Parent = tbl3.focus
    end

    React.useEffect(function()
        var1.current.Size = UDim2.fromScale(1, 1)
        var1.current.BackgroundTransparency = 1

        return function()
            var1.current:Destroy()
        end
    end, {})

    return var1.current
end

return {
    name = "Squads",
    storyRoot = Squads,
    roact = Roact,
    mapDefinition = function(arg1)
        local controls = Cryo.Dictionary.join(tbl2, arg1.controls or {})
        return Cryo.Dictionary.join(arg1, { controls = controls })
    end,
    mapStory = function(arg1)
        return function(arg2)
            local current = useCreateOverlay(arg2)

            local style = arg2 and tbl1[arg2.theme] or tbl1.Default
            return Roact.createElement(
                "Frame",
                {
                    AutomaticSize = Enum.AutomaticSize.XY,
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1
                },
                { Roact.createElement(
                        Foundation.FoundationProvider,
                        {
                            device = "Desktop",
                            colorMode = style.themeName,
                            overlayGui = current
                        },
                        { Roact.createElement(AppStyleProvider, { style = style }, { Child = mockLocale(arg1, arg2) }) }
                    ) }
            )
        end
    end
}

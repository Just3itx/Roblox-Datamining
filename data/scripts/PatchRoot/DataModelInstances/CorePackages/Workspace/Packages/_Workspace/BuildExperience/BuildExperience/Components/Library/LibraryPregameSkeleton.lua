-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local Localization = require(BuildExperienceParent.Localization)
local Motion = require(BuildExperienceParent.Motion)
local React = require(BuildExperienceParent.React)
local RobloxAppLocales = require(BuildExperienceParent.RobloxAppLocales)
local FFlagBuildExperienceLibrary = require(BuildExperienceParent.SharedFlags).FFlagBuildExperienceLibrary
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local BuildExperienceCompositionStyleSheet = require(BuildExperience.Components.BuildExperienceCompositionStyleSheet)
local LibraryBrowserView = require(script.Parent.LibraryBrowser.LibraryBrowserView)
local LibraryExperienceView = require(script.Parent.LibraryExperienceView)
local LibraryThemeProvider = require(script.Parent.LibraryThemeProvider)
local useLibraryStrings = require(script.Parent.useLibraryStrings)

local function noop() end

local function useSlideIn()
    local var1 = Foundation.Hooks.useTokens()
    local bool1 = not (Foundation.Hooks.usePreferences().reducedMotion or UserGameSettings.ReducedMotion)
    local var2, var3 = React.useState(bool1)
    local var4, var5 = Motion.useMotion({ offset = if bool1 then 1 else 0 })
    React.useEffect(function()
        if not bool1 then
            return nil
        end
        local bool2 = false

        local default = Motion.transition({ duration = var1.Time.Time_400, easingStyle = var1.Ease.StandardOut })
        var5(Motion.createState({ offset = 0 }, { default = default }), {
            onAnimationComplete = function()
                if not bool2 then
                    var3(false)
                end
            end
        })
        return function()
            bool2 = true
        end
    end, { bool1, var5, var1 })
    if not bool1 then
        return nil, false
    end
    return var4.offset:map(function(xScale: number): UDim2
        return UDim2.fromScale(xScale, 0)
    end), var2
end

local function LibraryPregameContent(tbl1)
    local strings = useLibraryStrings()
    local tbl2 = {
        categories = {},
        status = "Loading",
        strings = strings,
        worldCutout = {
            title = strings.world,
            onActivated = noop,
            onRectChanged = noop
        }
    }
    local experience = React.createElement(
        LibraryExperienceView,
        {
            isOpen = true,
            assetLabel = strings.title,
            worldLabel = strings.world,
            title = strings.title,
            searchPlaceholder = strings.searchPlaceholder,
            onShowLibrary = noop,
            onShowWorld = noop,
            onLeave = tbl1.onCancel
        },
        {
            Browser = React.createElement(LibraryBrowserView, tbl2)
        }
    )

    if not FFlagBuildExperienceLibrary then
        return experience
    end

    local var2, clipsDescendants = useSlideIn()
    return React.createElement(Foundation.View, {
        Position = var2,
        ClipsDescendants = clipsDescendants,
        tag = "size-full",
        backgroundStyle = { Transparency = 1 },
        testId = "Library.Pregame.Page"
    }, { Experience = experience })
end

local function LibraryPregameSkeleton(tbl1)
    local localization = React.useMemo(function()
        return RobloxAppLocales.Localization.new(LocalizationService.RobloxLocaleId)
    end, {})
    return React.createElement("ScreenGui", {
        DisplayOrder = tbl1.displayOrder,
        ResetOnSpawn = false,
        ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets,
        ClipToDeviceSafeArea = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    }, {
        Localization = React.createElement(Localization.LocalizationProvider, {
            localization = localization
        }, {
            Theme = React.createElement(LibraryThemeProvider, {
                displayOrder = tbl1.displayOrder
            }, {
                CompositionStyleSheet = React.createElement(BuildExperienceCompositionStyleSheet),
                Content = React.createElement(LibraryPregameContent, tbl1)
            })
        })
    })
end

return LibraryPregameSkeleton

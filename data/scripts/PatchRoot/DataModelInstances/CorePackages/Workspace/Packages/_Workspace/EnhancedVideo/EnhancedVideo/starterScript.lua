-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T06:11:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local LocalizationService = game:GetService("LocalizationService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local React = require(scriptParentParent.React)
local ReactRoblox = require(scriptParentParent.ReactRoblox)
local Foundation = require(scriptParentParent.Foundation)
local FoundationProvider = Foundation.FoundationProvider
local Enums = Foundation.Enums

local AdLabel = require(scriptParent.interactivity.AdLabel)

local Localization = require(scriptParentParent.InExperienceLocales).Localization
local LocalizationProvider = require(scriptParentParent.Localization).LocalizationProvider

local EnhancedVideoStore = require(scriptParent.EnhancedVideoStore)

local dispatchEnhancedVideoConfig = require(scriptParent.dispatchEnhancedVideoConfig)

local var1 = require(scriptParentParent.Http).NetworkLayers.requestInternalWrapper(nil)
local function starterScript()
    if game.CreatorType ~= Enum.CreatorType.Group or game.CreatorId ~= 427968160 then
        return
    end

    local localization = Localization.new(LocalizationService.RobloxLocaleId)

    EnhancedVideoStore(false).fetchInitialData(var1, game.GameId):andThen(function(arg1)
        if arg1 then
            dispatchEnhancedVideoConfig(arg1)
        end
    end)

    local adDisclosurePauseEvent = ReplicatedStorage:WaitForChild("AdDisclosurePauseEvent")

    local enhancedVideoInteractivityControls = Instance.new("Folder")
    enhancedVideoInteractivityControls.Name = "EnhancedVideoInteractivityControls"
    enhancedVideoInteractivityControls.Parent = CoreGui
    ReactRoblox.createRoot(enhancedVideoInteractivityControls):render(
        React.createElement("ScreenGui", { DisplayOrder = -5 }, {
            LocalizationProvider = React.createElement(LocalizationProvider, {
                localization = localization
            }, {
                FoundationProvider = React.createElement(FoundationProvider, {
                    colorMode = Enums.ColorMode.Dark
                }, {
                    AdLabel = React.createElement(AdLabel, {
                        sendPauseEvent = function()
                            adDisclosurePauseEvent:Fire()
                        end
                    })
                })
            })
        })
    )
end
return starterScript

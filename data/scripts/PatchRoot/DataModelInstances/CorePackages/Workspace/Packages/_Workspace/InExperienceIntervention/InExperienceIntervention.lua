-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local scriptParent = script.Parent

local UIBlox = require(scriptParent.UIBlox)
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local LocalizationService = game:GetService("LocalizationService")
local Localization = require(scriptParent.InExperienceLocales).Localization
local LocalizationProvider = require(scriptParent.Localization).LocalizationProvider

local Images = UIBlox.App.ImageSet.Images
local NotificationModalsManager = require(scriptParent.NotificationModalsManager)
local Roact = require(scriptParent.Roact)
local Foundation = require(scriptParent.Foundation)
local AppStyleProvider = require(scriptParent.UIBlox).App.Style.AppStyleProvider
local LayerCollectorProvider = require(scriptParent.UIBlox).Core.Layout.LayerCollector.LayerCollectorProvider
local InExperienceInterventionContainer = require(script.InExperienceInterventionContainer)
local FoundationProvider = Foundation.FoundationProvider
local InterventionPlacement = require(scriptParent.InterventionShared).Contexts.InterventionPlacement
local Constants = require(scriptParent.InterventionShared).Utils.Constants

local tbl1 = {}

local bool1 = game:DefineFastFlag("FFlagTimeoutRemoteEvent", false)
local DisplayOrder = game:DefineFastInt("InExperienceInterventionDisplayOrder", 6)

if bool1 then
    RobloxReplicatedStorage:WaitForChild("TimeoutChatAttempt", math.huge).OnClientEvent:Connect(function(arg1, arg2)
        NotificationModalsManager.SetUIBloxToast({
            iconImage = Images["icons/status/error_large"],
            toastTitle = "Test Chat Timeout RemoteEvent",
            toastSubtitle = `startTime: {arg1}, duration: {arg2}`,
            sequenceNumber = DateTime.now().UnixTimestamp,
            iconSize = Vector2.new(36, 36)
        })
    end)
end

function tbl1.new()
    local var1 = setmetatable({}, tbl1)

    var1.root = Roact.createElement("ScreenGui", { DisplayOrder = DisplayOrder }, {
        LayerCollectorProvider = Roact.createElement(LayerCollectorProvider, {}, {
            LocalizationProvider = Roact.createElement(
                LocalizationProvider,
                {
                    localization = Localization.new(LocalizationService.RobloxLocaleId)
                },
                {
                    InterventionPlacementProvider = Roact.createElement(
                        InterventionPlacement.Provider,
                        {
                            value = Constants.InterventionPlacementType.InExperience
                        },
                        {
                            FoundationProvider = Roact.createElement(FoundationProvider, {
                                colorMode = "Dark"
                            }, {
                                StyleProvider = Roact.createElement(
                                    AppStyleProvider,
                                    {
                                        style = { themeName = "dark", fontName = "gotham" }
                                    },
                                    {
                                        Container = Roact.createElement(InExperienceInterventionContainer, {})
                                    }
                                )
                            })
                        }
                    )
                }
            )
        })
    })
    var1.element = Roact.mount(var1.root, CoreGui, "InExperienceInterventionApp")

    return var1
end

return tbl1.new()

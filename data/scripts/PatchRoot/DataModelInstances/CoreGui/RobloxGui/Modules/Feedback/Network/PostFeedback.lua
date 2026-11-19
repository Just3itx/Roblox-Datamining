-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParent = script.Parent.Parent

local InGameMenu = scriptParentParentParent.InGameMenu
local Url = require(InGameMenu.Network.Url)
local Constants = require(scriptParentParent.Resources.Constants)
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local CorePackages = game:GetService("CorePackages")
local Promise = require(CorePackages.Packages.InGameMenuDependencies).Promise
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local GetFFlagEnableSendImageFeedbackToBackend = require(RobloxGui.Modules.Flags.GetFFlagEnableSendImageFeedbackToBackend)

local function request(options: {Body: string, Headers: {[any]: any}, Method: string, Url: string}, callback, callback2) -- Luacid: Inlined by compiler; 1 call site recovered
    return HttpService:RequestInternal(options):Start(function(arg1, arg2)
        if arg1 then
            callback()
            return
        end
        callback2(tostring(arg2.StatusMessage))
    end)
end

return function(contentType, arg1, arg2, arg3, arg4, comments, reasonType)
    local input

    if not GetFFlagEnableSendImageFeedbackToBackend() then
        local num1

        if arg3 == "" or arg3 == nil then
            arg3 = "UID_" .. game.GameId
            num1 = 2
        else
            num1 = 1
        end

        input = {
            LocalizationFeedback = {
                FeedbackTarget = {
                    ServiceSource = { Type = num1, ExternalId = arg3 },
                    Source = { ContentType = 1, Value = arg1 },
                    Translation = { ContentType = 1, Value = arg2 }
                },
                Locale = if Players.LocalPlayer.LocaleId then Players.LocalPlayer.LocaleId:gsub("-", "_") else "",
                ReasonType = reasonType,
                Suggestion = { ContentType = 1, Value = arg4 },
                Comments = comments
            }
        }
    else
        local inGameTranslations = Constants.ServiceSourceType.InGameTranslations

        if arg3 == "" or arg3 == nil then
            arg3 = "UID_" .. game.GameId
            inGameTranslations = Constants.ServiceSourceType.InGameTranslationsNoEntryId
        end

        if contentType == Constants.ContentType.Image then
            inGameTranslations = Constants.ServiceSourceType.InGameUniverseAndImageAsset
        end

        input = {
            LocalizationFeedback = {
                FeedbackTarget = {
                    ServiceSource = { Type = inGameTranslations, ExternalId = arg3 },
                    Source = { ContentType = contentType, Value = arg1 },
                    Translation = (contentType ~= Constants.ContentType.Image or arg2 ~= nil and arg2 ~= "") and {
                        ContentType = contentType,
                        Value = arg2
                    }
                        or nil
                },
                Locale = if Players.LocalPlayer.LocaleId then Players.LocalPlayer.LocaleId:gsub("-", "_") else "",
                ReasonType = reasonType,
                Suggestion = {
                    ContentType = Constants.ContentType.Text,
                    Value = arg4
                },
                Comments = comments
            }
        }
    end

    local options = {
        Url = string.format("%sfeedback-api/v1/feedback/create-localization", Url.APIS_URL),
        Method = "POST",
        Body = HttpService:JSONEncode(input),
        Headers = { ["Content-Type"] = "application/json", Accept = "application/json" }
    }

    return Promise.new(function(callback, arg5)
        spawn(function()
            request(options, callback, arg5)
        end)
    end)
end
